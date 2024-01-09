Return-Path: <linux-fsdevel+bounces-7664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAAB828E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 21:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AA9B238C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BC3D963;
	Tue,  9 Jan 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hn8hp8tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC153D572
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-360630beb7bso2825905ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704831870; x=1705436670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tVel0UQW1Uo9yWn+sEdOE5Exl8SfVcjWVWSNPbqjKA=;
        b=hn8hp8tk5HOeI5hwFlgW/kgaG7s+W0t9ohZ/FiH4hp2r5VMNYSvvxMGBP4I1GuL1W/
         LHoNRIuym3XM57o4hNzC5m8uc34HcFyHcmHAoZ5zktGKQY21/6j8v3n72JsFT6wwKdw4
         njrsdRErQpxgfPi6+wjRsEvETstuTFSeXGln19CLhxPcWj592KwQrgyX4ZkHL9hWa9l4
         bwBWLJ1CPJ9INrRM7QEVLrdvknyumoeXv1spvhTjyWbYuq/NWp5uIbdDehjfGM1oBR6h
         Q5vRimoVlZyGwbEPCwQUxUjbkGzXJ4mNZF+iRG+rqNjXg2MsRMyLogtQgR/QAGKFJV0y
         +Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831870; x=1705436670;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tVel0UQW1Uo9yWn+sEdOE5Exl8SfVcjWVWSNPbqjKA=;
        b=IkfO4zgNvQNUzJtzAwz3hw1bu3T/3qqhvvWo8g7Bc6+ceX7YZGIh8JKy2ZfCcwy+BI
         tbX4zxhJqPwwnnGlYdsRV/oy7zyl9i4ZzOgNHcJu6xNhurcDWdTz1oAaBQsU4SkmBmSY
         tK1sKGjChvKPfDdH4ipalAZV65TTAlOaKZgTyk00fNYIQSFTKlpc/0Rp6/iBtFR/+Kw/
         VjpM6msZfmA52JkHAz2zMmWkeiO6MHG7xYrR16ynTuadUEyuCImcRTquyJsUdoE/JsLC
         co3dXP7ft20L7e9YoZjIBoHL78x3IUsWqqMb5LORRy7yp85yTooAdmNMi71FP+/Y/75Y
         FS0A==
X-Gm-Message-State: AOJu0YwuXRi1NY7EeQAL6UMBcDL7R8ZxtasIO10YQG0FUvs9Zql0w/0w
	XdCr5Bn+VA+W+6mR9I45LRiULQ6cR+1HWgUGuQ5yGWYT95mK+A==
X-Google-Smtp-Source: AGHT+IE5CnR7avtY0jtzfOcK1YE/pN1h5Dyx6OJrQ+AETMvniEpBbrytSc01ajUsDDma/3sYXhHLoQ==
X-Received: by 2002:a5e:d906:0:b0:7be:ed2c:f8b with SMTP id n6-20020a5ed906000000b007beed2c0f8bmr1200396iop.1.1704831870083;
        Tue, 09 Jan 2024 12:24:30 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d9f46000000b007bed8ff57c6sm561618iot.25.2024.01.09.12.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:24:29 -0800 (PST)
Message-ID: <2cf86f5f-58a1-4f5c-8016-b92cb24d88f1@kernel.dk>
Date: Tue, 9 Jan 2024 13:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] fsnotify: optimize the case of no access event
 watchers
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
References: <20240109194818.91465-1-amir73il@gmail.com>
 <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
In-Reply-To: <91797c50-d7fc-4f58-b52a-e95823b3df52@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 1:12 PM, Jens Axboe wrote:
> On 1/9/24 12:48 PM, Amir Goldstein wrote:
>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
>> optimized the case where there are no fsnotify watchers on any of the
>> filesystem's objects.
>>
>> It is quite common for a system to have a single local filesystem and
>> it is quite common for the system to have some inotify watches on some
>> config files or directories, so the optimization of no marks at all is
>> often not in effect.
>>
>> Access event watchers are far less common, so optimizing the case of
>> no marks with access events could improve performance for more systems,
>> especially for the performance sensitive hot io path.
>>
>> Maintain a per-sb counter of objects that have marks with access
>> events in their mask and use that counter to optimize out the call to
>> fsnotify() in fsnotify access hooks.
>>
>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> ---
>>
>> Jens,
>>
>> You may want to try if this patch improves performance for your workload
>> with SECURITY=Y and FANOTIFY_ACCESS_PERMISSIONS=Y.
> 
> Ran the usual test, and this effectively removes fsnotify from the
> profiles, which (as per other email) is between 5-6% of CPU time. So I'd
> say it looks mighty appealing!

Tried with an IRQ based workload as well, as those are always impacted
more by the fsnotify slowness. This patch removes ~8% of useless
overhead in that case, so even bigger win there.

-- 
Jens Axboe


