Return-Path: <linux-fsdevel+bounces-1920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153D7E0404
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22A3B21404
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3F18632;
	Fri,  3 Nov 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dk1h9cNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F418623
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 13:52:17 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972191
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 06:52:16 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5ac376d311aso24710287b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699019535; x=1699624335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYuO/C9GpkkIoAS96l7iTjBNNJrZplioBHxrTK6U3XE=;
        b=dk1h9cNBh1W9FqTuMZuI2D0JBe7KJ+vLJeznsnXFlC7z+YZFtQBFRLZTbIRb4T22mI
         q/RvoSWuiXUB4elvCZtkW2f9SEJSxcXOlmqckM7yRDEVHN7jR94n3i3GvSUyfW1+HiaA
         cpHDa/uuA8NGHIOBrUf66o9vbi3uGjh6h0rAYHgY/B6GKo0BFbn3EUt1AV1TEOH7fbY+
         so9tln8LLXAJKT/RFK1bk/2eUNSOj6m4UGxhi5Dy7tWIoRZSaaFqUFkVwlBIGbwUA6l7
         6fTKDM9ySxsmoZNTxqS9MuXICzwzSpib8KeqoL5nwKGnzNpmkz4TDy9q4y2vqK1GAdmX
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019535; x=1699624335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYuO/C9GpkkIoAS96l7iTjBNNJrZplioBHxrTK6U3XE=;
        b=J4lLelWYb3egFS88tlmfp9M/BxPDWW+zrWL5NFjPUEmhFsIcvoyvciABR/mzeJpXiD
         1m0SMdW9/NKlgcruJFEMjpJOZVmTTj6YDVk0T2p5TBXzv28uBgIU1uf6C0vystmVsF7i
         wHrn1IKHz4vSLT7Z0O4X31zrn2n0jgkbP2vgyvclPd0W4GsLCj7Zkdu8XTEniJE2dshW
         y3jcnJg/hlKPK1L2i62hNPBX8K0ZGLjsehxoR2EVzRBcSKvj2Lt5fpcc9Jxx0b9I7SQJ
         E/bkEXDInPRzC4+Si8ru8rFlrsM3M6NtUUUsBz84YCgTQYhYbLDC5uaKDZMDfxYJPiNo
         1IdQ==
X-Gm-Message-State: AOJu0YzRDCplPc2L6LYraX1LyGbJUhtMGcXNn1ISJehKGB6aLqIqfxug
	rml3nQgoSiAgIhfP/xx8jv6IfQ==
X-Google-Smtp-Source: AGHT+IHhtlG6mXXeKlDlSKrT7t7a1BH00I4TCPHzCkDtKR3roMulinT3ZCPDhp1InU1VBskXXsP6aQ==
X-Received: by 2002:a0d:e6cb:0:b0:5a7:b8d4:60e1 with SMTP id p194-20020a0de6cb000000b005a7b8d460e1mr3241045ywe.9.1699019535272;
        Fri, 03 Nov 2023 06:52:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s10-20020ad4524a000000b00670c15033aesm734910qvq.144.2023.11.03.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:52:14 -0700 (PDT)
Date: Fri, 3 Nov 2023 09:52:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Hellwig <hch@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103135213.GB3548732@perftesting>
References: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
 <20231103-wichen-shrimps-1ddd9565d6a6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-wichen-shrimps-1ddd9565d6a6@brauner>

On Fri, Nov 03, 2023 at 07:56:39AM +0100, Christian Brauner wrote:
> On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> > On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > > Thanks,
> > > > 
> > > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > > the new mount api in June:
> > > > 
> > > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > > 
> > > 
> > > Yeah Daan told me about this after I had done the bulk of the work.  I
> > > shamelessly stole the dup idea, I had been doing something uglier.
> > > 
> > > > Can I ask you to please please copy just two things from that series:
> > > > 
> > > > (1) Please get rid of the second filesystems type.
> > > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > > >
> > > 
> > > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > > because the standard distro way of doing things is to do
> > > 
> > > mount -o ro,subvol=/my/root/vol /
> > > mount -o rw,subvol=/my/home/vol /home
> > > <boot some more>
> > > mount -o remount,rw /
> > > 
> > > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > > investigate today.  Thanks,
> > 
> > It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> > subvolumes with different ro/rw options"), the functionality should
> > be preserved else it's a regression.
> 
> My series explicitly made sure that it _isn't_ broken. Which is pretty
> obvious from the description I put in there where that example is
> explained at length.
> 
> It just handles it _cleanly_ through the new mount api while retaining
> the behavior through the old mount api. The details - as Josef noted -
> I've explained extensively.

I think Dave's comments were towards me, because I was considering just not
pulling it forward and waiting to see who complained.  I'll copy your approach
and your comment, and wire up a test to make sure we don't regress.  Thanks,

Josef

