package com.squareup.timessquare;

import ti.sq.TisqModule;
import android.util.Log;

/** Log utility class to handle the log tag and DEBUG-only logging. */
final class Logr {
  public static void d(String message) {
    if (TisqModule.DEBUG) {
      Log.d("TimesSquare", message);
    }
  }

  public static void d(String message, Object... args) {
    if (TisqModule.DEBUG) {
      d(String.format(message, args));
    }
  }
}
