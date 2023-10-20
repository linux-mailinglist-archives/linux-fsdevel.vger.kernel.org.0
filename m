Return-Path: <linux-fsdevel+bounces-859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A87D174E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 22:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AE8281F2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79CF208DB;
	Fri, 20 Oct 2023 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A01802E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 20:45:48 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA9B172E;
	Fri, 20 Oct 2023 13:45:42 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so897590a12.0;
        Fri, 20 Oct 2023 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697834742; x=1698439542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vutrsb5JnCQsKaXFvh73rRJHAgEusiSsuInphwVkJa4=;
        b=SNnyYSdeoWe+upBQ1AdNgtA3pwSinRXfR8V8pEp8pDbXL36MLAMY0b9XqgJS9ISRmw
         XyTG+JqeC7tbbaI14RmDWpVVGJaY+xXrXWcCL+YaG/dp/6we4U+LphH6q64qGREDKXxS
         Igo7CBHqFr4GiYe6isfxay0smdXP4+kKwh69RtQ7JSCntchpKLxgnMxUyVeOGSDpcE1v
         y4AIz9vmxfTzAhDlQEWdtFRWgebSp3DCF3llV/yrm2f6916cssjzP28Ds1X3VAkrTHOt
         3G7v/xEMfz3x5EKfa/DK2EBqPDEQ4tPBS8STLuwIQZhRSovWZKLfGZh0oNTtUkqCcFtH
         /u9Q==
X-Gm-Message-State: AOJu0YwYg0jRqvJ/o1LvVuabSH4gFv6GaXDDXIHlMDeMdYfM6B6flY1W
	wI31kquLHLnFTgXsH0iqtCo=
X-Google-Smtp-Source: AGHT+IHcoxyaOXOn8IwRdHquaMtX3ArdAIWiXujrLn6NFN7C5QoFgHXgr8GegShqNs5oO3F0PpFnDw==
X-Received: by 2002:a05:6a20:7d96:b0:13a:e955:d958 with SMTP id v22-20020a056a207d9600b0013ae955d958mr3258701pzj.7.1697834742070;
        Fri, 20 Oct 2023 13:45:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:72ba:c99b:d191:901c? ([2620:15c:211:201:72ba:c99b:d191:901c])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78e86000000b0068fd026b496sm1968205pfr.46.2023.10.20.13.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:45:41 -0700 (PDT)
Message-ID: <42639844-8758-4396-bb2c-ffcc8593d205@acm.org>
Date: Fri, 20 Oct 2023 13:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Pass data temperature information to SCSI disk
 devices
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
 <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 12:09, Jens Axboe wrote:
> I'm also really against growing struct bio just for this. Why is patch 2
> not just using the ioprio field at least?

Hi Jens,

Can you please clarify whether your concern is about the size of struct 
bio only or also about the runtime impact of the comparisons that have 
been added in attempt_merge() and blk_rq_merge_ok()? It may be possible 
to eliminate the overhead of the new comparisons as follows:
* Introduce a union of struct { I/O priority; data lifetime; } and u32.
* Use that union in struct bio instead of bi_ioprio and bi_lifetime.
* Use that union in struct request instead of the ioprio and lifetime
   members.
* In attempt_merge() and blk_rq_merge_ok(), compare the u32 union member
   instead of comparing the I/O priority and data lifetime separately.

Thanks,

Bart.

