Return-Path: <linux-fsdevel+bounces-13658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736498728BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C641F2B657
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1477129A66;
	Tue,  5 Mar 2024 20:29:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D739460;
	Tue,  5 Mar 2024 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670549; cv=none; b=Z0CxSkidmkdEWdtpF1x76f+/vr8Qbq+/hjy0lpegk5XJaBtqm22Czy4wSL4ecF9b0sYJ7FDo4HbjInNXq9nGV9XoIBiDmOWGBV+NPx+J4kZpLOkILDOuggkRuLKltix/7RmhhWiPSTRRn0v0kwiQsmt9mBXW7blopOMQ5Fhw944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670549; c=relaxed/simple;
	bh=oe2J97hfiCUqd8RBj/oWDlSveRaG9vwVNseRd0cTLKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YN+8oNVtZOWeMbAWwxgszDETsbsNVLpzgbIR2yVRpb8vtAGsLF7KsJNuhxx1b/1ScedJZWpeWmPrHpp60GDUUD949PxzLiSOMgE1s+DB3rh/xavCmSz0Vx3RXKWuJvCFIPeqoKWV9JWWm//n4fJrOzqbte5CqtN275fGiGUlFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd01ea35b5so19716985ad.0;
        Tue, 05 Mar 2024 12:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709670547; x=1710275347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXq7pFAKK69JkeekroRzoD2aGhQy0QdXJGytui7Sb+Q=;
        b=B1GBHJa4S2bBwfdALIiXMiM/5J3idVW/mX+3aQbz1FAgfb2MRNu8olvmgBEJvB862s
         LQbMGCu4JelFDBxANfMQkuO3JO693oKqfwwU0/LbgzTzSAK5K8Y/hX+auZDcyHMtQFrI
         Rs6kR03WqWxRnrcpH4/DZBksldxmyxwSjoe1e8R2Q4FZyhj5lAT7/NvT6eYIIQFrrhCZ
         N6kcOvhlmcilNVhXTg5fzu2bDaQmin2ZGU5to3B7B6/uDanayPZzYQjmKacUU9BwLh7A
         krPMak3xvAkKfZaLVOPxYJt9WKldRgzPlg5YZFHsATrK1FPX8JtDRRrsRdZ7dxLrXtkK
         3QYg==
X-Forwarded-Encrypted: i=1; AJvYcCX0YywZ6ZkDP7NC+jj8s8nCY3SSaWyDXtOfsb06rqR/1DsemxrEHbD0KroLXxLEYxPQ9A9dscE+hqPpEEG/aW2qqrDljblM
X-Gm-Message-State: AOJu0Yx9pEOzKXQrHp3iFHocxIi9Nne/vxSuWFZIyalPd6EvgGmZ2MNJ
	bOUANJVAO4IRCKzrfF3V0HwM/oAV5EMbkGy0gTuGZNyH12L/GYt7icQ+mb4g
X-Google-Smtp-Source: AGHT+IETxGKGf4oNCsiF0ugeq/oWFzeRGXyo+6AW6CukFPu5toWGC9tmAJCslyrUxa4UkmJCypV7bw==
X-Received: by 2002:a17:902:8a83:b0:1d7:2e86:fb2a with SMTP id p3-20020a1709028a8300b001d72e86fb2amr2569921plo.65.1709670547210;
        Tue, 05 Mar 2024 12:29:07 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:3e11:2c1a:c1ee:7fe1? ([2620:0:1000:8411:3e11:2c1a:c1ee:7fe1])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001dcc2847655sm11005035plh.176.2024.03.05.12.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 12:29:06 -0800 (PST)
Message-ID: <bce48abd-8e8c-4ee9-b49f-1595e6aa8f8a@acm.org>
Date: Tue, 5 Mar 2024 12:29:05 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "fs/aio: Make io_cancel() generate completions
 again"
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Benjamin LaHaise <ben@communityfibre.ca>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org,
 syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
References: <20240304182945.3646109-1-bvanassche@acm.org>
 <20240304193153.GC1195@sol.localdomain>
 <20240305-hinunter-atempause-5a3784811337@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240305-hinunter-atempause-5a3784811337@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 00:50, Christian Brauner wrote:
> We've been wrestling aio cancellations for a while now and aimed to
> actually remove it but apparently it's used in the wild. I still very
> much prefer if we could finally nuke this code.

io_cancel() is being used by at least the Android user space code for
cancelling pending USB writes. As far as I know we (Linux kernel
developers) are not allowed to break existing user space code. See also:
* 
https://android.googlesource.com/platform/frameworks/av/+/refs/heads/main/media/mtp/MtpFfsHandle.cpp
* 
https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/daemon/usb.cpp

Thanks,

Bart.


