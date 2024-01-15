Return-Path: <linux-fsdevel+bounces-8002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A882E1F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 21:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FEE1C2286F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D8D1AAC5;
	Mon, 15 Jan 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bQWy0F2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134D1AABC
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d437a2a4c7so16465205ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 12:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705351733; x=1705956533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bDPBFVencqLvrZExgO66pd/JmeyFHjNxxkRoLJ2tKI=;
        b=bQWy0F2bBDtzmDzxIiqOvtALx4iUiOcQSAYwpphCwQkz0of7NIRKRiuq936KNSFc+9
         Dkcsn79jHpxld+O0MfZGP9PLR+YMNOtfHyThnBAHqS5od6oiRulc/oia1TjEHy8Dsl03
         1zPezF+Who4VTHcaZJ/LTsG7iHMJYes9Q00QJz/Yva7SuvilRt+q2593OAPCMGvVFzFq
         /flgxl0yoDa+0Me8WcSw/n/zc3G4F2VaaemjRYtSDalsprxS5jgmy+4KNJ6cHsvYuNt2
         uvS81lM5LIO2rJpX/yDtOLVirsaxiGCV4HmzrpGk/45fqXtmuuTwPWLflHchFY1IT2Xk
         UfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705351733; x=1705956533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bDPBFVencqLvrZExgO66pd/JmeyFHjNxxkRoLJ2tKI=;
        b=Asw3iEKuqw5+VJproSQ3zCeuuWOmf2XNFgVzaA983+/5jlMKvp3cQqf5sKRoHoZtID
         trMw96Ovh237+3BN2krItJVhpfHC+eLp31vS5cXUyN6ttuMBQtQozZA1fTlzKII6h2dl
         gO9BRGZL93a/So2czQyvF9BF+jU9zHZS1f2M10+IE5E/YggxBfWWi5BbOLnGAFQbE3jO
         uMdbeBIvmo/nHj4TCIxVBwmAkYjg9xL6Qu0MKBsNJ+5LM0eFXNYEKIMb7GvvWFowcSXh
         N5j+QgRaJ3qImsHSbXN8z4LHO5noSEouG8DCcm7R1abGhHqeqzN6647FaWgniXRZFLGL
         wFGQ==
X-Gm-Message-State: AOJu0YxU0E7Mu0T3EwFaMTaY8vZTE2gfVRnoLgP52LG7I0/D6lQrT36k
	cO/306VP8JtjRpUUhQJaxtb91KOoZz673A==
X-Google-Smtp-Source: AGHT+IGFcOd+Q2pgHaeY7p8QfZ8Ag0q0Js8t3H3ZGrCmPNnELXy2Kic041f/DMIp3OYHYUOgWS8hWA==
X-Received: by 2002:a05:6a20:9798:b0:199:dca2:8e71 with SMTP id hx24-20020a056a20979800b00199dca28e71mr10571221pzc.6.1705351733397;
        Mon, 15 Jan 2024 12:48:53 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902c61400b001d403f114d2sm8087306plr.303.2024.01.15.12.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 12:48:52 -0800 (PST)
Message-ID: <b45bd8ff-5654-4e67-90a6-aad5e6759e0b@kernel.dk>
Date: Mon, 15 Jan 2024 13:48:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
 <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
 <CAOQ4uxgzvz9XE4eMLaRt4Jkg-o4+mTQvgbHrayx27ku2ONGfPg@mail.gmail.com>
 <20240115183758.6yq6wjqjvhreyqnu@quack3>
 <CAOQ4uxhLum65Nou=DRaAT6W5xTvWjjP4+5mxYv2K3j4PB89s1A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxhLum65Nou=DRaAT6W5xTvWjjP4+5mxYv2K3j4PB89s1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Jens, if you have time for another round please test.
> My expectation would be to see something like
> 
> +1.46%  [kernel.vmlinux]  [k] __fsnotify_parent

Sure - so first I can current -git, which we know has that extra
fsnotify call as previously discussed. This is with SECURITY=y and
FANOTITY_ACCESS_PERMISSIONS=y for both.

Performance:

IOPS=65.01M, BW=31.74GiB/s, IOS/call=31/32
IOPS=65.42M, BW=31.94GiB/s, IOS/call=32/32
IOPS=65.02M, BW=31.75GiB/s, IOS/call=31/32
IOPS=65.37M, BW=31.92GiB/s, IOS/call=32/32
IOPS=65.44M, BW=31.95GiB/s, IOS/call=31/31
IOPS=64.91M, BW=31.70GiB/s, IOS/call=32/32
IOPS=64.25M, BW=31.37GiB/s, IOS/call=32/31

and profile:

+    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
+    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent

With this patch applied, I see:

IOPS=73.09M, BW=35.69GiB/s, IOS/call=32/31
IOPS=72.94M, BW=35.61GiB/s, IOS/call=32/32
IOPS=72.95M, BW=35.62GiB/s, IOS/call=31/31
IOPS=72.54M, BW=35.42GiB/s, IOS/call=32/32
IOPS=73.01M, BW=35.65GiB/s, IOS/call=32/31
IOPS=73.07M, BW=35.68GiB/s, IOS/call=32/32

and profile:

+    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent

and perf diff shows the following top items:

     3.67%     -1.30%  [kernel.vmlinux]  [k] __fsnotify_parent
     4.51%             [kernel.vmlinux]  [k] fsnotify

Let me know if this is what you wanted, or if the base should be with
that extra fsnotify removed.

-- 
Jens Axboe



