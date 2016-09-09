
package lefty.settings;

import android.app.Activity;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.PreferenceFragment;
import android.preference.SwitchPreference;

import com.android.launcher3.LauncherFiles;
import com.android.launcher3.R;
import com.android.launcher3.config.ProviderConfig;

import lefty.CommonsUtils;
import lefty.LauncherActivityUpdater;


/**
 * Settings activity for Lefty. Currently implements the following setting: Enable Lefty
 * @author tajinder
 */
public class LeftySettingsActivity extends Activity {
    public static final String ALLOW_LEFTY_PREFERENCE_KEY = "pref_allowLefty";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Display the fragment as the main content.
        getFragmentManager().beginTransaction().replace(android.R.id.content, new LauncherSettingsFragment()).commit();
    }


    /**
     * This fragment shows the lefty preferences.
     */
    public static class LauncherSettingsFragment extends PreferenceFragment implements OnPreferenceChangeListener {
        @Override
        public void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            addPreferencesFromResource(R.xml.lefty_preferences);
            setUpLeftSwitch();
        }

        SharedPreferences getPreferences() {
            return getActivity().getSharedPreferences("Lefty", MODE_PRIVATE);
        }

        void setUpLeftSwitch() {
            SwitchPreference pref1 = (SwitchPreference) findPreference(ALLOW_LEFTY_PREFERENCE_KEY);
            pref1.setPersistent(true);
            pref1.setChecked(getPreferences().getBoolean(CommonsUtils.SHARED_PREF_ALLOW_LEFTY_KEY,true));
            pref1.setOnPreferenceChangeListener(this);

        }
        void saveEnable_DisableLefty(boolean flag) {
            SharedPreferences.Editor editor = getPreferences().edit();
            editor.putBoolean(CommonsUtils.SHARED_PREF_ALLOW_LEFTY_KEY, flag);
            editor.commit();
        }
        @Override
        public boolean onPreferenceChange(Preference preference, Object newValue) {
            if (preference.getKey().equalsIgnoreCase(ALLOW_LEFTY_PREFERENCE_KEY)) {
                Boolean value = (Boolean) newValue;
                saveEnable_DisableLefty(value);
                LauncherActivityUpdater.getInstance().notifyListener();

            } else {
                Bundle extras = new Bundle();
                extras.putBoolean(LSettings.EXTRA_VALUE, (Boolean) newValue);
                getActivity().getContentResolver().call(
                        LSettings.CONTENT_URI,
                        LSettings.METHOD_SET_BOOLEAN,
                        preference.getKey(), extras);
            }
            return true;
        }
    }

    /**
     * Launcher settings
     */
    public static final class LSettings {
        public static final Uri CONTENT_URI = Uri.parse("content://" +
                ProviderConfig.AUTHORITY + "/settings");

        public static final String METHOD_GET_BOOLEAN = "get_boolean_setting";
        public static final String METHOD_SET_BOOLEAN = "set_boolean_setting";

        public static final String EXTRA_VALUE = "value";
        public static final String EXTRA_DEFAULT_VALUE = "default_value";
    }

    public static String getSharedPreferencesKey() {
        return LauncherFiles.SHARED_PREFERENCES_KEY;
    }

}








