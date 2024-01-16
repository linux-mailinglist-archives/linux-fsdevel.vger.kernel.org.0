Return-Path: <linux-fsdevel+bounces-8028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F186F82E808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 03:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821B5B2229E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 02:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EC5254;
	Tue, 16 Jan 2024 02:58:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D67E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598ee012192so827708eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 18:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705373909; x=1705978709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diJ+OhNJId/gd7TgHTTCXUMVQPxQtGi/dC1WHOopUjc=;
        b=JnVixpGSoC85H6rlLwIv0wwkKXhGB+0tmqeCT6nnrq3BYKP+6p7oktPRoGA7nQDWEw
         kqkb0+bPV2uHG1o3Iuqc0sRoU3KVY/KftawmiIZWoQ3uCXs5CqDHa5eOFvgYAhw6bhDd
         OE1q3Ll+pO/S6ZzmTKS40Gaz22lhMrAt7Jco7NSTxn4f02NyaJAz4Dc5MGQ0nBvwLbus
         UCW2bNqK5WBODSDKMycFmuGhwssFP6NkkHhyFG+JZ58ocBGe33sR1dDvJXpn6Y3LF1li
         n6xr+pV/dnjPIhzzodqXGlnJuxaXdLBdE9ORAThiuysRizHM5aSWX4LvGQPIjMcnMalH
         yDpA==
X-Gm-Message-State: AOJu0YzAjQhhRlKv2xs3P+GtmBSBdm/ZeQnSixtDHx7NYiCY8Ui4Lzlq
	EWO9jN+BdRYQEt0CYUaKbQU=
X-Google-Smtp-Source: AGHT+IF1JgewMIYQsSD2Zf9bzld0bLwPUbnI4uKHHRRZAi7ql1NxahEU+p/b1Zjl8GYlXNy1nrkCFQ==
X-Received: by 2002:a05:6359:2d4e:b0:175:b450:11bc with SMTP id rm14-20020a0563592d4e00b00175b45011bcmr3478917rwb.59.1705373908897;
        Mon, 15 Jan 2024 18:58:28 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id nc12-20020a17090b37cc00b0028dbd1f7165sm10521402pjb.47.2024.01.15.18.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 18:58:28 -0800 (PST)
Message-ID: <0ea56c32-c71b-4997-b1c7-6d9bbc49a1dd@acm.org>
Date: Mon, 15 Jan 2024 18:58:27 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file
 systems
Content-Language: en-US
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc: kent.overstreet@linux.dev, naohiro.aota@wdc.com, Matias.Bjorling@wdc.com,
 javier.gonz@samsung.com, dlemoal@kernel.org, slava@dubeiko.com,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240115082236.151315-1-slava@dubeyko.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240115082236.151315-1-slava@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/24 00:22, Viacheslav Dubeyko wrote:
> POTENTIAL ATTENDEES:
> bcachefs - Kent Overstreet
> btrfs - Naohiro Aota
> ssdfs - Viacheslav Dubeyko
> WDC - Matias Bjørling
> Samsung - Javier González
> 
> Anybody else would like to join the discussion?

Since F2FS has a mature zoned storage implementation, you may want to
include the F2FS maintainer.

Bart.



