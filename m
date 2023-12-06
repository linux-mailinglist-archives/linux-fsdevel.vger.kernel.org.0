Return-Path: <linux-fsdevel+bounces-5034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0478077C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDA81C20B64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8DC6F610
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXULRDIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA94D3;
	Wed,  6 Dec 2023 08:52:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b845ba9ba9so10155b6e.3;
        Wed, 06 Dec 2023 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701881563; x=1702486363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i1au5lbtdhuYhTzxu7K3e1mZkKqka6jLLtZkjNaoKMc=;
        b=ZXULRDIpSZOkiumlJHfa69UVuyRP0DruUZNJpc+Hh4BvfpWz1YPdOgpqiR4TV1picY
         uGRQqisr0a5fDaf8OG639RBlSoJ0uRYDYav0OW3V6x8VU1fMO4TJSHqcNSD42LKoFyCt
         O6flSvpCm1gdyzuzPieDpSkJn0h3tGOjmSUdTPzzBlpwEn//ssCoRZhIl9hiqqPHuJGi
         SzDNC+kqCEDTqzT/MAcEepey/BkWw96a/YsEnRU7tyNLEwRvUY+9FtGiN6MBEEbWz2J5
         bM9fJSu9e6LWlwF6m/kYiiffUk311orf2vh9BltaMjEYFI8x5103tY/vBmSFrwNQHeRA
         phLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881563; x=1702486363;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1au5lbtdhuYhTzxu7K3e1mZkKqka6jLLtZkjNaoKMc=;
        b=FHUvE5bqPa2tTAndkmlIcWfyxN5r6mNjHKMfL8hNaaN59ftjA50M9QQx1G4oSSEhj9
         TiLh27S4ON0dMBS9uwqOSSErTQ2hO2mf2DQoupRzZTNGuNzbb2muQQdDpcaiIOUB9J/R
         wmU6jNHDNPSW5r8oWovcBsiMBHSLvsjGbN3Y48QhDfFY9DuGzcjIE/3WdZA8hc/KnyfW
         4UGSJP3pIX9yCmm1vHmdpnhoRRsubMpvrV7ic92UH5UC4RGZCYXwentVFlGXcE63NgLq
         sXWclAjWJ5SeinWkVCcOAv6ab/UWMhEOwEZg1ktqUsj8YjZMxIDKU87PvNcR64WwBbXR
         wnMg==
X-Gm-Message-State: AOJu0YwL0PeL63ja9Fex5aIaSlm7xPutT0LYb8k1InQqYAsIL31ozXW5
	GZYTLBUQfSD9EKoyvayKhi2dDI/Hmr+s/Hj8Wmo=
X-Google-Smtp-Source: AGHT+IGZ/Yr5F7fr0x3yUHZ3H8FzlhrdgaoQi9g9SY9SBjIS2V506x0YzxsM95+SBtT/PUWyn/Ecfay+HG2v633hkYE=
X-Received: by 2002:a05:6870:1711:b0:1fb:75c:3feb with SMTP id
 h17-20020a056870171100b001fb075c3febmr1324530oae.75.1701881563431; Wed, 06
 Dec 2023 08:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6802:30f:b0:50c:13ee:b03d with HTTP; Wed, 6 Dec 2023
 08:52:43 -0800 (PST)
In-Reply-To: <20231206164513.GO1674809@ZenIV>
References: <20231201040951.GO38156@ZenIV> <20231201065602.GP38156@ZenIV>
 <20231201200446.GA1431056@ZenIV> <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
 <20231204195321.GA1674809@ZenIV> <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
 <20231206054946.GM1674809@ZenIV> <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020>
 <20231206161509.GN1674809@ZenIV> <20231206163010.445vjwmfwwvv65su@f> <20231206164513.GO1674809@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 6 Dec 2023 17:52:43 +0100
Message-ID: <CAGudoHGUDtiRN_AbMHYWPN+ABRkMUG-sZD5J=v0x2Z=HrK+hnw@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On 12/6/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Dec 06, 2023 at 05:30:10PM +0100, Mateusz Guzik wrote:
>
>> > What the hell is going on?  Was ->d_lock on parent serving as a throttle
>> > and reducing
>> > the access rate to something badly contended down the road?  I don't see
>> > anything
>> > of that sort in the profile changes, though...
>
>> Not an outlandish claim would be that after you stopped taking one of
>> them, spinning went down and more traffic was put on locks which *can*
>> put their consumers off cpu (and which *do* do it in this test).
>
> That's about the only guess I've got (see above), but if that's the case,
> which lock would
> that be?
>
>> All that said I think it would help if these reports started including
>> off cpu time (along with bt) at least for spawned threads.
>

Given backtracs I posted it's at least root->kernfs_iattr_rwsem (see
kernfs_iop_permission), but there may be more.

Ultimately I expect would be easy to answer if one was to rebuild with lockstat.

I may end up doing it tomorrow if there is a problem testing this on your end.

-- 
Mateusz Guzik <mjguzik gmail.com>

