Return-Path: <linux-fsdevel+bounces-3814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D692D7F8B21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F9F1C20B46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E44111A5;
	Sat, 25 Nov 2023 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="ZDsE5X5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A057B6
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 05:28:51 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso2693716b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Nov 2023 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1700918930; x=1701523730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBkKuI0fbhzEilDcSEndZwSBUCGMGB5hB9S6RQoSuM=;
        b=ZDsE5X5I8qxxAK7qx0g743hbMLx4KwOFOZtJHYq/OkAmmnxkCLqOGDXj6Clzpsa6fi
         ArXELUDP9hc5sXpbmG/yVwYyVWtYQZrjMAC4wVKYIIxUwyIWfpD/cE2JBx88naXG11r4
         /nCv7RIDNBzb/KwbgucmKog3El0zG2OEqUTl3St+AaqQ55LBRbKQ9Z7DETFlUFSN5oQo
         +f9+uh1fbO/NhJtJtKh1PBNc2rwTJrWxkls/YyttXeW8dgTjOzoC41GjO0v7N3jKUQYE
         xjKVZROWMP8m/K5UEgAw1Ta9SVjUgkOmA2bEiKdlyG9gUDjq1hys2Hiww06iP1ZZFlcu
         0ppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918930; x=1701523730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhBkKuI0fbhzEilDcSEndZwSBUCGMGB5hB9S6RQoSuM=;
        b=bC2d7RA/RVy6kAE+d2JxJBVVG/ZREWW/NlOXglASHjlEjZbN1z7ymqx/5Zcm8bSzMr
         cFTOg9DjS446Q3NRJC7U7s5CVYoBvUl9k0PVV4mWf9nyAHy+VqOGSMUAv+ykVFNEotTO
         S2ZCokgirObyo5D9fbIg/cN9f6k8/Y0JTFGpEzo75rZhoWcK8fDrrSvMuV8nAU07Xk3R
         Tz2b/5DS8uRk/8HMEbG+ViOk3xQT0G98NWXe/UZ91ePw87gYFQtBG3/7bEJC9X/xCQM+
         pgyoXG8d4fIWo+23GOkNd0rbG8Vdvz+FbH4l1qz4sBeo7qF4x59fPdGzgxeEUci4XChT
         +ayA==
X-Gm-Message-State: AOJu0Yxw+NFXZyiUQr/wltcAiTPDAtkGRqV1rlOyB3stb9S/lRDIDFAG
	yty5dPEAwj4k7t+PiJRWQIsIPw==
X-Google-Smtp-Source: AGHT+IEiSGWhWT6eayr99X2E4BBgRz0QRwNCxk4p6EBFiHOcTMr6rIe36BrEaF+XzZ7App03i0QClw==
X-Received: by 2002:a05:6a00:8e03:b0:6c2:cb4a:73c3 with SMTP id io3-20020a056a008e0300b006c2cb4a73c3mr6700182pfb.11.1700918930618;
        Sat, 25 Nov 2023 05:28:50 -0800 (PST)
Received: from telecaster ([2601:602:a300:3bc0::1923])
        by smtp.gmail.com with ESMTPSA id fi14-20020a056a00398e00b006a77343b0ccsm4340925pfb.89.2023.11.25.05.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 05:28:50 -0800 (PST)
Date: Sat, 25 Nov 2023 05:28:49 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Omar Sandoval <osandov@fb.com>, David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs fixes
Message-ID: <ZWH2kSJXcXEohpyd@telecaster>
References: <20231124-vfs-fixes-3420a81c0abe@brauner>
 <CAHk-=wiJFsu70BqrgxtoAfMHeJVJMfsWzQ42PXFduGNhFSVGDA@mail.gmail.com>
 <20231125-manifest-hinauf-7007f16894b6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125-manifest-hinauf-7007f16894b6@brauner>

On Sat, Nov 25, 2023 at 02:10:52PM +0100, Christian Brauner wrote:
> On Fri, Nov 24, 2023 at 10:25:15AM -0800, Linus Torvalds wrote:
> > On Fri, 24 Nov 2023 at 02:28, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > * Fix a bug introduced with the iov_iter rework from last cycle.
> > >
> > >   This broke /proc/kcore by copying too much and without the correct
> > >   offset.
> > 
> > Ugh. I think the whole /proc/kcore vmalloc handling is just COMPLETELY broken.
> 
> Ugh, I didn't even look at that closely because the fix was obviously
> correct for that helper alone. Let's try and just return zeroed memory
> like you suggested in your last mail before we bother fixing any of
> this.
> 
> Long-term plan, it'd be nice to just get distros to start turning
> /proc/kcore off. Maybe I underestimate legitimate users but this
> requires CAP_SYS_RAW_IO so it really can only be useful to pretty
> privileged stuff anyway.

drgn needs /proc/kcore for debugging the live kernel, which is a very
important use case for lots of our users. And it does in fact read from
KCORE_VMALLOC segments, which is why I found and fixed this bug. I'm
happy to clean up this code, although it's a holiday weekend here so I
won't get to it immediately of course. But please don't rip this out.

Omar

