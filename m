Return-Path: <linux-fsdevel+bounces-8475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F1837386
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DEE28EAC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F741236;
	Mon, 22 Jan 2024 20:09:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E541201;
	Mon, 22 Jan 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954150; cv=none; b=QRDcAzXaebAKjzxZbe9upDUmSXpJATCrtOK5A7tHYXs8DbnqqS+aQQI1yG2lO2jYFdnHZq42zUMbrP+q5VI09u+5XlNYY6Jw2m57GE5FFkuXj+kqSGFFx9r/tNOp0hWe9mJ4yaz/xeKafEf98Sn5+ejBrvMI7w2/hjRWENcjgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954150; c=relaxed/simple;
	bh=A9UvLOwOpodh+7+qQNvGu4uH1RSZ0x0pBvj1w7jcJK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCsHBUYkEy195n8YDf5BTfp0Ha1aCiRM+6TwAkh3RvHid27fDszAn8aPZjT8vftcqb4jZhHrf2fF+nnGbmDavRJT5cXjyUHAfp74N3B0dM3LcTKwLUYusTEfF8lYhq1lRStnmT6BYtFJ7kQ/P31GqL66egdIPuQUDRMk5zOpuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dbb26ec1deso3689060b3a.0;
        Mon, 22 Jan 2024 12:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705954148; x=1706558948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsNEGOg1W9SSUbMC5dXx27HrjziDPHGrITW9iQruscY=;
        b=hl3TypwJahOJZL5fNcL5YCAaoc73peg09YvPaUEX6j3zhwEx+l1X6Uk4VdFrlgme02
         MsA3kP6+Jgbiffxohs1NnwOXsoYro7lef9peS/wL8RUPwlIndz1/7J707khVLRTzr8px
         kA7mkgCoH/dKrZesEQbqaiDVZo56ErSr1r71QtU3j6Sjl+hQq8YIsvd6QjEI9Dd3FSre
         M88mnhtWk0rCXLI+N+PVSUFkVJzclLxzMtohLtkIRDbcPH74v0Fd7x3mCmx4jtivG6M4
         6d283cCJO+/WZlI67ZHeCyHmWS/f4aaMQEgjCO3slGHMx6MFevRQtpD0y+jpbld5NS5C
         kz4g==
X-Gm-Message-State: AOJu0YwTlRIOJoqVlqrMKPTBk80gnHCV/84jm7NPZzU65e2UO9uFtLH6
	B8Qz12OG0vF535pCVgDVoizN3/PsepkkdYVPCM1dAeFFHDcGSNGZE4NANWy+
X-Google-Smtp-Source: AGHT+IELoHpJB8ahHqjAgPvgmLB3hbJtkcVq7YDOJH3Vi5yiiOcgGl4qY8TFnx9Du2OGo1ZlXlfKNA==
X-Received: by 2002:a05:6a20:324a:b0:19a:b86c:5b98 with SMTP id hm10-20020a056a20324a00b0019ab86c5b98mr4410806pzc.121.1705954148215;
        Mon, 22 Jan 2024 12:09:08 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id fc13-20020a056a002e0d00b006d9cf4b56edsm10301417pfb.175.2024.01.22.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:09:07 -0800 (PST)
Message-ID: <edefdfbc-8584-47ad-9cb0-19ecb94321a8@acm.org>
Date: Mon, 22 Jan 2024 12:09:06 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de>
 <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org> <20240103090204.GA1851@lst.de>
 <CGME20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc@epcas5p4.samsung.com>
 <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
 <b294a619-c37e-cb05-79a8-8a62aec88c7f@samsung.com>
 <9b854847-d29e-4df2-8d5d-253b6e6afc33@acm.org>
 <9fa04d79-0ba6-a2e0-6af7-d1c85f08923b@samsung.com>
 <85be3166-1886-b56a-4910-7aff8a13ea3b@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <85be3166-1886-b56a-4910-7aff8a13ea3b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 01:31, Kanchan Joshi wrote:
> On 1/19/2024 7:26 PM, Kanchan Joshi wrote:
>> On 1/19/2024 12:24 AM, Bart Van Assche wrote:
>>> I think the above proposal would introduce a bug: it would break the
>>> F_GET_RW_HINT implementation.
>>
>> Right. I expected to keep the exact change in GET, too, but that will
>> not be free from the side-effect.
>> The buffered-write path (block_write_full_page) picks the hint from one
>> inode, and the direct-write path (__blkdev_direct_IO_simple) picks the
>> hint from a different inode.
>> So, updating both seems needed here.
> 
> I stand corrected. It's possible to do away with two updates.
> The direct-io code (patch 8) should rather be changed to pick the hint
> from bdev inode (and not from file inode).
> With that change, this patch only need to set the hint into only one
> inode (bdev one). What do you think?

I think that would break direct I/O submitted by a filesystem.

Bart.

