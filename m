Return-Path: <linux-fsdevel+bounces-8597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB358392B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E789B22D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817FD5FEF3;
	Tue, 23 Jan 2024 15:29:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD905FDD5;
	Tue, 23 Jan 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023753; cv=none; b=oSVzAtUQQs10uFTD997TScBjQrn3cyuFQcfiBiWXfeHKFbfE+rPq97N1jUqLN+Sk78xg71rWj0wrNuwD4pxoVcCb+SFVZOptCHIm6LqOAvXPEJHh1Mwa8SvVJnbPtO0TYotbvRYWcRytQCh2/QorQoVwmNREIxy1Z7vHCCPEzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023753; c=relaxed/simple;
	bh=s6jgl5KcyFsafPQ+hFpzhVn26U7GR5BduKRkjTiqmyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu+VS20tsfdFPnDGVnoxf/RCo14ddGJ7kpi4ZAt5GOqcvOSA4yntzqo73B5ADQ/epIcZcthxfa+t7CiIkk/Gf5Q39DNZagViQBbA7K+tizmAPosVPPF7bQHPUEJbg2/wxvjexLrMcd+6HYEw6bn6hgzDauCq/bi81eNf9MEAMkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7232dcb3eso18829735ad.2;
        Tue, 23 Jan 2024 07:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023751; x=1706628551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEoXkdsFzObck9VQxVE2hGH3a3xF+qG8H5BqRHfrQRM=;
        b=PBx9QDzWHnMhxgqxdNB2v0jFYL/URQfek/nb+AYQkQWZoZjnrlQMyLdukzMWs3bGq5
         hTJ6yWzNNF7U1EVFRC2FE4EWSZLd1Hw5DhV0BU/G//uXeiNWD0lrF9BLppk4ufyiqHKa
         AiS+tOsvlhiluuATKcI9+RE89eWEaWtHUDoA2J94LE03/YMNbNK3c+g3XcUpyvNTBUi8
         wcS/DJ8GdXEd3fs/qyA/CUQ1kRCchVZtUtrtLd+gGEAYcUW9cWNjdAJwl5rSRb4yKqbV
         9VNGycQb4vCv4yEnkTUuInD/iIyGu/RVe7+tdqcny5AiZLOhAMwBmukwavJJqAXkS1qC
         /2sg==
X-Gm-Message-State: AOJu0Yyl+UlVqdMbhOk/T+IzFSTSGns+FPXB7Utm0vwQ+KFsSJL4EoRk
	+ge2pa0Twm52i3dEmFNx+LRlS3sMt37m3Rdk8lxxGUMKtV8RRpSs
X-Google-Smtp-Source: AGHT+IESSOPXAtxeDnwtmAzzfqPO0vHSCSiFgAsWzZ1m6fJrkXNCGAF1nxYU6Vw1hCMO9M/5h+Bkqw==
X-Received: by 2002:a17:903:1107:b0:1d7:2455:2e70 with SMTP id n7-20020a170903110700b001d724552e70mr3613598plh.21.1706023750906;
        Tue, 23 Jan 2024 07:29:10 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902ef0500b001d7244c8ee0sm6819370plx.117.2024.01.23.07.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:29:10 -0800 (PST)
Message-ID: <0d266548-b8dc-473c-9603-41f8adb2d3c1@acm.org>
Date: Tue, 23 Jan 2024 07:29:09 -0800
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
 <edefdfbc-8584-47ad-9cb0-19ecb94321a8@acm.org>
 <4f36fc64-a93b-9b2c-7a12-79e25671b375@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4f36fc64-a93b-9b2c-7a12-79e25671b375@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 04:16, Kanchan Joshi wrote:
> On 1/23/2024 1:39 AM, Bart Van Assche wrote:
>> On 1/22/24 01:31, Kanchan Joshi wrote:
>>> On 1/19/2024 7:26 PM, Kanchan Joshi wrote:
>>>> On 1/19/2024 12:24 AM, Bart Van Assche wrote:
>>>>> I think the above proposal would introduce a bug: it would break the
>>>>> F_GET_RW_HINT implementation.
>>>>
>>>> Right. I expected to keep the exact change in GET, too, but that will
>>>> not be free from the side-effect.
>>>> The buffered-write path (block_write_full_page) picks the hint from one
>>>> inode, and the direct-write path (__blkdev_direct_IO_simple) picks the
>>>> hint from a different inode.
>>>> So, updating both seems needed here.
>>>
>>> I stand corrected. It's possible to do away with two updates.
>>> The direct-io code (patch 8) should rather be changed to pick the hint
>>> from bdev inode (and not from file inode).
>>> With that change, this patch only need to set the hint into only one
>>> inode (bdev one). What do you think?
>>
>> I think that would break direct I/O submitted by a filesystem.
> 
> By breakage do you mean not being able to set/get the hint correctly?
> I tested with XFS and Ext4 direct I/O. No breakage.

The approach that you proposed is wrong from a conceptual point of view.
Zero, one or more block devices can be associated with a filesystem. It
would be wrong to try to access all associated block devices from inside
the F_SET_RW_HINT implementation. I don't think that there is any API in
the Linux kernel for iterating over all the block devices associated with
a filesystem.

Bart.

