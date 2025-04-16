Return-Path: <linux-fsdevel+bounces-46542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD6A8B042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 08:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9411F7ADF92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8C22B8AF;
	Wed, 16 Apr 2025 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFhYlhKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C022206B3;
	Wed, 16 Apr 2025 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784845; cv=none; b=IZ7sEogDi+4oPltwFuZQy7wCmGS6ckDWNMYeJuIqYrFgd4c/+91x5ZePyA7vMZ3TBTbN7PFuE+a2V+ODPY7arbMkDz1s6tMHo/xdPtg1cMJcwlYoGj4RlU046qxTDPEzPCUBdIuX2Utzk24XO3yS3NlNfQBguzWO0yoFYRbfEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784845; c=relaxed/simple;
	bh=5/dvJapbezp2DjC3tieCg8oZ706CUrQvPxNTcrPLcgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjC/GPhECArsVy69gvWuECtxEeWsF3xrGr7bC8K8RgJJ+t88gGWrzfKAwU8VqwBnx4+/OYQ7Oxg6FsNHyy6DluxsrTamaJrKcLRuqLj3sRPqaYT8BZftYSuKDJaNGfMwLkt0cV8R6m9y/CZw04bmwjTgg6aap0S2EMQSSUPY3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFhYlhKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55696C4CEEC;
	Wed, 16 Apr 2025 06:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744784844;
	bh=5/dvJapbezp2DjC3tieCg8oZ706CUrQvPxNTcrPLcgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFhYlhKMq1V/g8Z0/ZIyhDnRdwM/jMiduzSS/kd6O/3DoBXKnPM27yH8PmGkld49I
	 zeMvdHYqpb4EtvTIYW9r939l0wPpnYEoJ5n61qSL/7VPEXUrrIi/ssP7JNnY1OzK/t
	 mj5SQuO+kEVR/pP3vXstM23M68NQwFiVmiXs0hGmbSqmz5qyCwPKXjcVaoxMKXTaSf
	 Lk2XsbzpVPPehusvezbLvW/Wdf9xBahSC72plemcFbr6hN+l8oMQKOVm06YQqjwZJq
	 hNmTOXqSUzM0/F2NOvN6erTTR89JUVVWI7cUB1ubDIlLzymw2g23e41G4hRCkDVrcL
	 9PtVObNnKMKqQ==
Date: Wed, 16 Apr 2025 08:27:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	David Sterba <dsterba@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, Sandeen <sandeen@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
Message-ID: <20250416-willen-wachhalten-55a798e41fd2@brauner>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
 <20250415144907.GB25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415144907.GB25659@frogsfrogsfrogs>

On Tue, Apr 15, 2025 at 07:49:07AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 15, 2025 at 09:51:37AM +0200, Christian Brauner wrote:
> > Both the hfs and hfsplus filesystem have been orphaned since at least
> > 2014, i.e., over 10 years. It's time to remove them from the kernel as
> > they're exhibiting more and more issues and no one is stepping up to
> > fixing them.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/hfs/super.c     | 2 ++
> >  fs/hfsplus/super.c | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index fe09c2093a93..4413cd8feb9e 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -404,6 +404,8 @@ static int hfs_init_fs_context(struct fs_context *fc)
> >  {
> >  	struct hfs_sb_info *hsb;
> >  
> > +	pr_warn("The hfs filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> 
> Does this mean before or after the 2025 LTS kernel is released?  I would

I would've tried before the LTS release...

> say that we ought to let this circulate more widely among users, but

which is a valid point. The removal of reiserfs and sysv has been pretty
surgically clean. So at least from my POV it should be simple enough to
revert the removal. But I'm not dealing with stable kernels so I have no
intuition about the pain involved.

> OTOH I guess no maintainer for a decade is really bad.
> 
> --D
> 
> > +
> >  	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
> >  	if (!hsb)
> >  		return -ENOMEM;
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 948b8aaee33e..58cff4b2a3b4 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -656,6 +656,8 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
> >  {
> >  	struct hfsplus_sb_info *sbi;
> >  
> > +	pr_warn("The hfsplus filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> > +
> >  	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
> >  	if (!sbi)
> >  		return -ENOMEM;
> > -- 
> > 2.47.2
> > 
> > 

