Return-Path: <linux-fsdevel+bounces-8607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B6839406
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59751C21EDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA7612EF;
	Tue, 23 Jan 2024 15:59:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960860277;
	Tue, 23 Jan 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025592; cv=none; b=QRDrGCM5cr+Fl/SDlOi1TeXHhslXs8/usk+35kiKmEKgSYfr6OrubEC7jO08qWzVi6Hur/RSv2zcTZvR7SmSQfsrCDj51cbYd5YoYduHvP1iDzaUXVG2xsxfPJmILHIQemCLknEb2nhksRBMuy7rHVE7ytadaabD/6VZuKdf5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025592; c=relaxed/simple;
	bh=iIHhwJmlVl4McxGC9PbqY4l+E23pzobb4tPG9neNLtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOFAF04E3XxGuNcqdjQRT7EvyP8voI/xtE7nL+laNOQi1HLzvUkgd50NFuc8ur6HUQdN2sznMmphxcNTHbUrwBU4iaS4FrFrHei3fvS81cf5cDtWIvqWkmhr6kIee8VakRaijAQbsdNHKTFf2k6zZQxDTf4FcS4Ss0gY+eurG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29026523507so3384719a91.0;
        Tue, 23 Jan 2024 07:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025590; x=1706630390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIHhwJmlVl4McxGC9PbqY4l+E23pzobb4tPG9neNLtE=;
        b=WXznCNFtNDeBnfj7ZoMnppx1mLRidFZuOmZPdigWNST6zkXrWznB/kpEQQO9dSBPHt
         Hkg+5+3l1Dv+BcuAU7692Bru+qa6LDBv5S1JDgVAR4gCgQcC5Z6N+39OXR34smgBw05t
         O2uIHDPXVHNRyZk1l7+micBhOccFZf5wINr2uYLy4PMFmU5QW17pCdGR9Dg1eT/vh1/V
         pBhtf0lj8VxyAJZaFQP8a1i2iSXJoS3oeP8YhH9rs7VluzmGJNME+zQlag//WTRosZ1z
         kr2eAYCcJA4BmWuqXJhOK3o0oNVNZ9J5TT2LmXvNldrHSlb1XYFuWrueKl4on3SB6U0z
         eQJg==
X-Gm-Message-State: AOJu0YxLp1cusiIFky/Se7/04Lv0HwBGuvZ+oK7nWmcEWhChFDJ1iGJ2
	GS9JBaK+daEHFlOTVJAPOgjonwxlOeStfM8fLh1tl7xD+NQwn2yy
X-Google-Smtp-Source: AGHT+IFBKo6TaGjN+xsbdjkKy45LeO8Nqvlw3rKgL8wySffscXcpKtUN5cn2mbrHecHhdrY25UKkDw==
X-Received: by 2002:a17:90a:e38a:b0:28e:84e4:f7d1 with SMTP id b10-20020a17090ae38a00b0028e84e4f7d1mr3417266pjz.93.1706025590529;
        Tue, 23 Jan 2024 07:59:50 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id sy14-20020a17090b2d0e00b0029005525d76sm11890089pjb.16.2024.01.23.07.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:59:50 -0800 (PST)
Message-ID: <7d24a322-47a7-4b28-b3a3-42cf3dfbee82@acm.org>
Date: Tue, 23 Jan 2024 07:59:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <CGME20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6@epcas5p2.samsung.com>
 <20231219000815.2739120-6-bvanassche@acm.org>
 <23354a9b-dd1e-5eed-f537-6a2de9185d7a@samsung.com>
 <bbaf780c-2807-44df-93b4-f3c9f6c43fad@acm.org>
 <51194dc8-dd4d-1b0b-f6c1-4830ea3a63e9@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <51194dc8-dd4d-1b0b-f6c1-4830ea3a63e9@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 04:35, Kanchan Joshi wrote:
> At the cost of inviting some extra work. Because this patch used
> file_inode, the patch 6 needs to set the hint on two inodes.
> If we use bdev_file_inode, this whole thing becomes clean.

The idea of accessing block devices only in the F_SET_RW_HINT
implementation is wrong because it involves a layering violation.
With the current patch series data lifetime information is
available to filesystems like Fuse. If the F_SET_RW_HINT
implementation would iterate over block devices, no data lifetime
information would be available to filesystems like Fuse.

Bart.

