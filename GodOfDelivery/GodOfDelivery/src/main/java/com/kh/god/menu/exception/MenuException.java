package com.kh.god.menu.exception;

import java.io.PrintStream;
import java.io.PrintWriter;

public class MenuException extends RuntimeException {

	public MenuException() {
		super();
	}

	public MenuException(String message, Throwable cause) {
		super(message, cause);
	}

	public MenuException(String message) {
		super(message);
	}

	public MenuException(Throwable cause) {
		super(cause);
	}

	
	
}
