Return-Path: <linux-fsdevel+bounces-5038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1918077D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956121F21106
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C5E6EB6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItAupaKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ECCD40;
	Wed,  6 Dec 2023 09:24:30 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d7d58ab7fso4201208eaf.2;
        Wed, 06 Dec 2023 09:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701883470; x=1702488270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZDShyZXW7vdD+sEytI5yOQzMqBtyU656pypgNuq0Og=;
        b=ItAupaKFaAEfuSnUsQY8eysSkAOcpHKHPu1V33w4B5Ul2QNyEFonhzjqTAmRC92Sz5
         EFyZjxo8VzE7YGbMFNUrhLRHOqiYGDHF/RuVYruajYvb8tekR1BficcKHEmA7RDs62oq
         /ILDhrGq1tYwNUobRjS+EWtz0rKuu4YYGzZJlACtmyc5MR4yO4N6Ijt77Morb0nyEEbh
         L8dAuGFiZ5TlG1G3LqmMPDdZTVGfticKdcPs5JAlsa250ConFyWiXES96zMfOEEClmbu
         BkApFMaJdqRNGatYDHy7SFE47+3QMRh5F2RM5YvT/w5MabWt7Kh5W38vcl0nvg1Rftkv
         oJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883470; x=1702488270;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZDShyZXW7vdD+sEytI5yOQzMqBtyU656pypgNuq0Og=;
        b=mb6zM9CIOm5l1oUzWeo1CxnXBDZk6To3bFlhMjWccXGBvbKcXWd2oZnQ+t7hwQituc
         8C+noGc0Rnd683KJUFQeZPXZ3hrojxJxb/P1V7YHzPrS1YOAnr05PF3dN6Pdx9qYzicJ
         QnzmbLJf/ZFrH35KY98a4Qc0mORALs925qQl99+bu2X1o6Fo6dZu4JzxS1/WwSco3Lw6
         TxF/LGcMPs8dpDbi2/shLCmOnbRxtFkHduv2CC9Uen438m4IHLmHKkWWe9wqfn7VfrrB
         yIAQGyLZh6O2CJ3aKDIqQfPD9+aMPlrdrFh7gjlunFpI/69t4jeq+X7lTta96rrc5S1a
         sl0w==
X-Gm-Message-State: AOJu0YwI0bvFIG8b/zROn6exbLef2CqAEwMjaThJyauNEnnt9SeOHYUx
	wTu8ArHIZqixDC3rPkGa/gKE2W4YhCtvswmakWA=
X-Google-Smtp-Source: AGHT+IFJJ8SeqZ/WE3l4lLx73t12F9/QDukHuCGUyVDCvOIHofKuZ4kM+7RXMuKJp85Aym8z0GgdSpaS4VPCzYoaGrk=
X-Received: by 2002:a05:6871:7a3:b0:1fa:511:ff40 with SMTP id
 o35-20020a05687107a300b001fa0511ff40mr1281729oap.21.1701883469905; Wed, 06
 Dec 2023 09:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a05:6802:30f:b0:50c:13ee:b03d with HTTP; Wed, 6 Dec 2023
 09:24:29 -0800 (PST)
In-Reply-To: <20231206170958.GP1674809@ZenIV>
References: <20231201065602.GP38156@ZenIV> <20231201200446.GA1431056@ZenIV>
 <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020> <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020> <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020> <20231206161509.GN1674809@ZenIV>
 <20231206163010.445vjwmfwwvv65su@f> <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 6 Dec 2023 18:24:29 +0100
Message-ID: <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-doc@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On 12/6/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Wed, Dec 06, 2023 at 05:42:34PM +0100, Mateusz Guzik wrote:
>
>> That is to say your patchset is probably an improvement, but this
>> benchmark uses kernfs which is a total crapper, with code like this in
>> kernfs_iop_permission:
>>
>>         root = kernfs_root(kn);
>>
>>         down_read(&root->kernfs_iattr_rwsem);
>>         kernfs_refresh_inode(kn, inode);
>>         ret = generic_permission(&nop_mnt_idmap, inode, mask);
>>         up_read(&root->kernfs_iattr_rwsem);
>>
>>
>> Maybe there is an easy way to dodge this, off hand I don't see one.
>
> At a guess - seqcount on kernfs nodes, bumped on metadata changes
> and a seqretry loop, not that this was the only problem with kernfs
> scalability.
>

I assumed you can't have possibly changing inode fields around
generic_permission.

> That might account for sysinfo side, but not the unixbench - no kernfs
> locks mentioned there.  OTOH, we might be hitting the wall on
> ->i_rwsem with what it's doing...
>

I did not see anything about unixbench, the subject only talks about stressng.

That said now I'm curious enough what's going on here to give it a
serious poke instead of a quick glance.

-- 
Mateusz Guzik <mjguzik gmail.com>

