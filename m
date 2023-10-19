Return-Path: <linux-fsdevel+bounces-773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726867CFEEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EEB1C20EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF532194;
	Thu, 19 Oct 2023 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV84FMsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067830FB0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:00:16 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0575B6;
	Thu, 19 Oct 2023 09:00:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso91075641fa.2;
        Thu, 19 Oct 2023 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697731212; x=1698336012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSDDMkWKOscG8d7aFe9xNzMWpe2tWGppER9q+Picffw=;
        b=hV84FMsEQDUDbv3DeZ4WLdHhDp46aXY8d6E7vntBVsTWmx/tB96wrkNmsqdmvqXKM5
         dAQKz4k1qsqUD6eEt/Mbkan7OMT7SePQ5IE2jyY5EnkZxQXY6GkWK5oVGIWawPeG3uGg
         znzeJJRjtxv7vO/XDyjCTnvKQxnByYL4Wx63P5How7UUeGXT9nPu6zkbybA0H8+cgOSG
         1hWtbGaZMXRsZYs/1LhyC8Zjcn3DQDonKYMTd8eCNQc0XY4K6jmDLRiwJwedoST9ymMX
         wsPy70KHyoN7LeQ3+snu4s+oGitQHKdDYX2NdLiQo1tuXdkKJ8rXGz78WmJ6tBQEeOji
         alLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731212; x=1698336012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSDDMkWKOscG8d7aFe9xNzMWpe2tWGppER9q+Picffw=;
        b=fmIv/UrNc0iD6Cln3bjO5F4NLuLoUmb5RxCvEjJ6OJ6+Ne2M3/r+ZNn4t51DKmAxlD
         10x3vyQobs7kNS3MLCh/20wV/XGo9mQff3m+8S9asQpAmMH5Z+OvVh0NK+5kP1fF5oQa
         wBcSgcb+U5B6tL5/y1c2CdvFBHbY+1yH79tGxvOnliUGJcnY06qEfXUmEcH5GeM68Ut3
         HM3ayVkx3M/n6mUaRtUrQTCJzj5uV6uZt5Un+WXxuYCwJua76Z/iV052X0JygQIjLILC
         DWLXOv8p+Q9/C0mxhMSLPBzT4S/8Xu5WW75D9iqdOIsDVwGkbluNEym0YK9eVvzNkPlC
         b6Rg==
X-Gm-Message-State: AOJu0YzSeerCvboRHnt9i9gTIQL/LvjUeSIA++iMyUabYBPN23nlMfiE
	xrr3Y2+k+9fKCb17/JGMozU=
X-Google-Smtp-Source: AGHT+IG3e6RX4/S2XxCBBQFe1+QWTlT36Exu33T/w95mZLQJPeQ2D33wxraevY5sRm43e/jMnglcSw==
X-Received: by 2002:a2e:97ca:0:b0:2bc:d5f1:b9cf with SMTP id m10-20020a2e97ca000000b002bcd5f1b9cfmr1737842ljj.27.1697731211784;
        Thu, 19 Oct 2023 09:00:11 -0700 (PDT)
Received: from f (cst-prg-84-171.cust.vodafone.cz. [46.135.84.171])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm4675459wmo.27.2023.10.19.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:00:11 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:59:58 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231019155958.7ek7oyljs6y44ah7@f>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019153040.lj3anuescvdprcq7@f>

On Thu, Oct 19, 2023 at 05:30:40PM +0200, Mateusz Guzik wrote:
> On Tue, May 23, 2023 at 11:28:38AM +0200, Christian Brauner wrote:
> > On Tue, 09 May 2023 12:56:47 -0400, Kent Overstreet wrote:
> > > Because scalability of the global inode_hash_lock really, really
> > > sucks.
> > > 
> > > 32-way concurrent create on a couple of different filesystems
> > > before:
> > > 
> > > -   52.13%     0.04%  [kernel]            [k] ext4_create
> > >    - 52.09% ext4_create
> > >       - 41.03% __ext4_new_inode
> > >          - 29.92% insert_inode_locked
> > >             - 25.35% _raw_spin_lock
> > >                - do_raw_spin_lock
> > >                   - 24.97% __pv_queued_spin_lock_slowpath
> > > 
> > > [...]
> > 
> > This is interesting completely independent of bcachefs so we should give
> > it some testing.
> > 
> > I updated a few places that had outdated comments.
> > 
> > ---
> > 
> > Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
> > Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.
> > 
> > Please report any outstanding bugs that were missed during review in a
> > new review to the original patch series allowing us to drop it.
> > 
> > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > patch has now been applied. If possible patch trailers will be updated.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > branch: vfs.unstable.inode-hash
> > 
> > [22/32] vfs: inode cache conversion to hash-bl
> >         https://git.kernel.org/vfs/vfs/c/e3e92d47e6b1
> 
> What, if anything, is blocking this? It is over 5 months now, I don't
> see it in master nor -next.
> 
> To be clear there is no urgency as far as I'm concerned, but I did run
> into something which is primarily bottlenecked by inode hash lock and
> looks like the above should sort it out.
> 
> Looks like the patch was simply forgotten.
> 
> tl;dr can this land in -next please

In case you can't be arsed, here is something funny which may convince
you to expedite. ;)

I did some benching by running 20 processes in parallel, each doing stat
on a tree of 1 million files (one tree per proc, 1000 dirs x 1000 files,
so 20 mln inodes in total).  Box had 24 cores and 24G RAM.

Best times:
Linux:          7.60s user 1306.90s system 1863% cpu 1:10.55 total
FreeBSD:        3.49s user 345.12s system 1983% cpu 17.573 total
OpenBSD:        5.01s user 6463.66s system 2000% cpu 5:23.42 total
DragonflyBSD:   11.73s user 1316.76s system 1023% cpu 2:09.78 total
OmniosCE:       9.17s user 516.53s system 1550% cpu 33.905 total

NetBSD failed to complete the run, OOM-killing workers:
http://mail-index.netbsd.org/tech-kern/2023/10/19/msg029242.html
OpenBSD is shafted by a big kernel lock, so no surprise it takes a long
time.

So what I find funny is that Linux needed more time than OmniosCE (an
Illumos variant, fork of Solaris).

It also needed more time than FreeBSD, which is not necessarily funny
but not that great either.

All systems were mostly busy contending on locks and in particular Linux
was almost exclusively busy waiting on inode hash lock.

