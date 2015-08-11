package com.rav.audtioapp.service;

import com.rav.audtioapp.dao.LoginDAO;
import com.rav.audtioapp.dto.LoginDTO;
import com.rav.audtioapp.util.SaltTextEncryption;

public class LoginService {

	public boolean processRequest(LoginDTO dto) {
		boolean result = false;
		System.out.println("In Login Service userName " + dto.getUserName() + " password " + dto.getPassword());
		if (dto.getUserName() != null && dto.getUserName().length() > 0 && dto.getPassword() != null
				&& dto.getPassword().length() > 0) {
			LoginDAO dao = new LoginDAO();
			System.out.println("Checking username exists");
			if (dao.userNameExists(dto.getUserName())) {
				try {
					System.out.println("Checking password");
					if (SaltTextEncryption.getInstance().validateStrings(dto.getPassword(),
							dao.getPassword(dto.getUserName())))
						result = true;
				} catch (Exception e) {
					System.err.println(e);
				}
			}

		} else {
			result = false;
		}
		return result;
	}

}
