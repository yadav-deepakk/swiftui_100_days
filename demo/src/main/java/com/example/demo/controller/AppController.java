package com.example.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping()
@Slf4j
public class AppController {

	@PostMapping(value = "api/v1/cupcakes")
	@ResponseStatus(HttpStatus.OK)
	public String response(@RequestBody String body) {
		log.info("recieved request {}", body.toString());
		return body;
	}

}
