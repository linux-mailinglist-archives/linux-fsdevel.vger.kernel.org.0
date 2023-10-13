Return-Path: <linux-fsdevel+bounces-266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345D7C8929
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7906B20B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E661C280;
	Fri, 13 Oct 2023 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bMCaOVPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A97B1BDEF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 15:53:36 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA7BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fab2caf70so20009239f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697212414; x=1697817214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=bMCaOVPLmjdUUJk41icyyKvHf1jHZrvZQoTWQ4b1Ya5gbBeRrnMoRTgUwfP4imhfvI
         MbwEz9u096CsLR/j76Wn9e4rzzt2v0fbiJcIlhO9U/HgNNJqagGnkqiwz+Fek/TbMqOK
         bKacmQD095tA5wDxDPeRrSLk3sKybZsOg5nkSr6h/4iOJtyLmMTLuz5SYx2q/TzJwGNK
         CVJ+PJI9v1mR2ssV4Uevdktyw6xc0zV+lAlK1mAYCMVGg5kMegq4I4FLcxjuodOGLjoN
         Iqwv4QtiuCX8wLvZAXStKGMyR8tfCvh6yjsBKuQLf/flv/DozNgCZU2PRevqWvUWp14H
         ADLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212414; x=1697817214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=fAn+lkE9RDbnZwfC6gU7wAtwy26gTiLsqufzYogU04T0agx8yt0TfN460xQS8UktV4
         GnFPrT0MrpBaz4DEL5AGXZASslNu7B9L8IRrNvJMAsaAR0vKaRVY+HQ3Eg9lPRlMk76a
         uD0fB2GTtyUApapQmeq+pc0TpCa5PoiooYzYffLU91aNrg4dhbkeQKLSuPh2Dj1o6Rrn
         yxHS66OQQL/xZCB5Gy8iDoHtftM4OvdurMVWmi5S8IwKth+MunvrKI5ZGpu4NvmWF3tm
         rascqyyEdA7hmdEO/dKNGl1f72TEn69uYU6tU5DHjAihMpdEGofa6k99vxEokYdtuRj4
         3Fgw==
X-Gm-Message-State: AOJu0YxVC7A9LU0m0On5ZPvMV5nt3eMTphVRjJ3xFKFi5pjZLpuyYovb
	L3wjCUq4BZSfbqJN1f47ty0ljg==
X-Google-Smtp-Source: AGHT+IGD+Y6udldFEfNzSbeSH4ZSFKpxb16IumSgm5Ax2wKNRo/VZ1i60Er7mUo8Y6PAYB6BQM7MWg==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr26797941iob.0.1697212413928;
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d24-20020a6b6818000000b007911db1e6f4sm4935706ioc.44.2023.10.13.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Message-ID: <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
Date: Fri, 13 Oct 2023 09:53:32 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Dan Clash <daclash@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com,
 linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
 audit@vger.kernel.org, io-uring@vger.kernel.org
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231013-karierte-mehrzahl-6a938035609e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 9:44 AM, Christian Brauner wrote:
> On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
>> An io_uring openat operation can update an audit reference count
>> from multiple threads resulting in the call trace below.
>>
>> A call to io_uring_submit() with a single openat op with a flag of
>> IOSQE_ASYNC results in the following reference count updates.
>>
>> These first part of the system call performs two increments that do not race.
>>
>> [...]
> 
> Picking this up as is. Let me know if this needs another tree.

Since it's really vfs related, your tree is fine.

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

You'll send it in for 6.6, right?

-- 
Jens Axboe


