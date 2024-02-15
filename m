Return-Path: <linux-fsdevel+bounces-11766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4EF856F96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 22:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1A1C21B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A01419AD;
	Thu, 15 Feb 2024 21:51:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302A13DBA4;
	Thu, 15 Feb 2024 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033885; cv=none; b=diigl5uQPlptHdAeckJAf2I0hxyovOuNpEfWPnUumE0HhPRuq0cKB1hT9De8+0T3VOM4UZACyulm6rarBydEA555Aotg4BEbW+68FeELBWfeM6lPnfhQX+eQW7OA0x0xpRRNCW2CZL2J+L5gBi7eAiWPAfG1qJF4qObNKfXRpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033885; c=relaxed/simple;
	bh=07wWNbeHxUzkVYswvMAWe+pi+1S6uFutjpU8Zj8mFk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebtn6QJ1fuFMFDC413/oRF27y3HkYQcqzFgC3onqoquudG8sK4yF3g/Hf/7EetDzOIJo38mJYwggQlMuw5JQqyl3ACz496zMyUOyPfUXIXeN/j6iOUtS45Vs3DQriTiworhwQ/h/qr50td1vlJSaDrABw+ZbdvmY5oqsHYR+rBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d746856d85so301955ad.0;
        Thu, 15 Feb 2024 13:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033883; x=1708638683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1fFgNzNhhvGsLeidToTl84deDxlBKxhhFvN8bx9T1A=;
        b=uzdGoQy4lHnsWFeLjXJk5vy/dc2pHPzQNcnCqFp3STo03FNnFW0NKkQJjrDLOcd5dx
         GnRpf0o3YXT6ZpruTcPPKKXXXfuUUPUmnD2WLX/BahihC3+LXy/NY4lyuRgg7lblqWEY
         qGO77PPGRjPbN+bVR2uuRoqb+0GXtdlGztU3zSZ2BAD2uQ32uXf48pvRproJ23Nh9uW/
         eIMByZN+ZpzJT8vbcUwgDV+KdzKghuUImQVaQ9UYiJ9hilEXgg4jDIwu0NmkabWtFH3q
         mOpWxvMR6Wrah1V49ovmuDqc8xh2kLeW+ViPCXB6koltvJvxx1U5K+GEVT9zcnVX8xRw
         +bgw==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ml5y/m1P9sMMiM0SZY3OiDsNCIInKw5CqMcaDxuylKt2g+m4d9y5JRaSwJk1UGa8APmq/FJ3THgzDy+KT6AbMJ7ekFIKzuTW0MdwCz33dH/j+ZH2rLbc14jAKGxyLCVIxwi1FrFHsC7H
X-Gm-Message-State: AOJu0YzYJ5qb0HQ7knh5qUm8qrLqY0VpndcMnoTxLr4YaqbAyzOSWwcW
	iZOJ5KjR4K9r4dBGpOqshaP8fRwmNSJysD92l7Acm9l+vsqu5ia1
X-Google-Smtp-Source: AGHT+IFY3vBO2lC4fEwdrc4qzoomc/2OR7R+v6tV9k0gPu8h7USvA2udgZ11C4FPmuDvcwMb+EscGw==
X-Received: by 2002:a17:902:d4c8:b0:1d9:a674:aa77 with SMTP id o8-20020a170902d4c800b001d9a674aa77mr4048217plg.24.1708033883140;
        Thu, 15 Feb 2024 13:51:23 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3612:25f8:d146:bb56? ([2620:0:1000:8411:3612:25f8:d146:bb56])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902b69100b001db3efca159sm1708756pls.132.2024.02.15.13.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:51:22 -0800 (PST)
Message-ID: <7e3662b4-30c0-496b-be19-378c5fab5f33@acm.org>
Date: Thu, 15 Feb 2024 13:51:21 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-12-bvanassche@acm.org>
 <yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1h6i9e7v7.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 13:33, Martin K. Petersen wrote:
>> @@ -1256,7 +1283,7 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>   		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
>>   					 protect | fua, dld);
>>   	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
>> -		   sdp->use_10_for_rw || protect) {
>> +		   sdp->use_10_for_rw || protect || rq->write_hint) {
> 
> Wouldn't it be appropriate to check sdkp->permanent_stream_count here?
> rq->write_hint being set doesn't help if the device uses 6-byte
> commands.

Something like this untested change?

@@ -1256,7 +1283,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
  		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
  					 protect | fua, dld);
  	} else if ((nr_blocks > 0xff) || (lba > 0x1fffff) ||
-		   sdp->use_10_for_rw || protect) {
+		   sdp->use_10_for_rw || protect ||
+		   (rq->write_hint && sdkp->permanent_stream_count)) {
  		ret = sd_setup_rw10_cmnd(cmd, write, lba, nr_blocks,
  					 protect | fua);
  	} else {

Thanks,

Bart.

