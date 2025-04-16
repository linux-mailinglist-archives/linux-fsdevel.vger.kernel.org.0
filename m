Return-Path: <linux-fsdevel+bounces-46569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256BDA90755
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F233189B452
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430A1FF60E;
	Wed, 16 Apr 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6APyql2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD735962;
	Wed, 16 Apr 2025 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815966; cv=none; b=ID3D2hNwEqMyd8Xc1QBkAinmLx3eEsuSn6HdCMOWF6iekryrTjkrEInojImOKulaTDbPykzu/D6Dz3nti21XEAFDwB8VzY5zCI8y/Yuw4yBQ9+OjM7d4j3PhrZyI5MI7HIFONxMu3HMr72lSqpR0ciQxul5Gip2IaJOddADL75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815966; c=relaxed/simple;
	bh=l2u5/AR5KohY2Ne0q9kFZHfh95fUmdMdWQxvvpvtISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJTToTUTVAmaeCOr0FhxYd8l/YVaawvsxMUHt6XyS3W69RdwIfFdPg/6H2Hnm3AasfJvKaaGhxYdKcN60Uvmf8zpyPfqAOwrQ9p0ONJK5XQSHVW2jPmED9eba7UmGdnhFZJnLKb15PjHF3DrslE86dPYnGg0AWXUD8a6wBNX7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6APyql2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C20C4CEE2;
	Wed, 16 Apr 2025 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744815965;
	bh=l2u5/AR5KohY2Ne0q9kFZHfh95fUmdMdWQxvvpvtISs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6APyql2LPE1KPUscXGJVcbv+8XglRtjpu12Za7zt5fVUWvF1TjCOCySAEKX1HmNZ
	 HEpPDBw37fWjoQEc5J2jV4ydAonr9VKSvm3fcvczL+Qr4s9ipbFupyJaUvBTrmqTda
	 e8XuKDH0nh6PMPI83QuI8H7vydAThj1U6XbIlaccfZ5SF3LzHDAgScQhVP601ufyTu
	 pt2Nr2ZdOnRImv3W5SeJq8Jygepdnqh272RdUAN3KP90P6fgD+d7DnsoAGBl3gRGkk
	 ccdGwrf9FpnKwMbOGPGxtuc/pXIBpUt/itkljlNG2OBVYdrel+t3GBB5hCpgCW1pO0
	 8Esiltxwt5Pwg==
Date: Wed, 16 Apr 2025 08:06:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	David Sterba <dsterba@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>, Sandeen <sandeen@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
Message-ID: <20250416150604.GB25700@frogsfrogsfrogs>
References: <20250415-orchester-robben-2be52e119ee4@brauner>
 <20250415144907.GB25659@frogsfrogsfrogs>
 <20250416-willen-wachhalten-55a798e41fd2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-willen-wachhalten-55a798e41fd2@brauner>

On Wed, Apr 16, 2025 at 08:27:19AM +0200, Christian Brauner wrote:
> On Tue, Apr 15, 2025 at 07:49:07AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 15, 2025 at 09:51:37AM +0200, Christian Brauner wrote:
> > > Both the hfs and hfsplus filesystem have been orphaned since at least
> > > 2014, i.e., over 10 years. It's time to remove them from the kernel as
> > > they're exhibiting more and more issues and no one is stepping up to
> > > fixing them.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/hfs/super.c     | 2 ++
> > >  fs/hfsplus/super.c | 2 ++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > > index fe09c2093a93..4413cd8feb9e 100644
> > > --- a/fs/hfs/super.c
> > > +++ b/fs/hfs/super.c
> > > @@ -404,6 +404,8 @@ static int hfs_init_fs_context(struct fs_context *fc)
> > >  {
> > >  	struct hfs_sb_info *hsb;
> > >  
> > > +	pr_warn("The hfs filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> > 
> > Does this mean before or after the 2025 LTS kernel is released?  I would
> 
> I would've tried before the LTS release...

Well you still could.  No better way to get an oft-ignored filesystem
back into maintenance by throwing down a deprecation notice. :)

> > say that we ought to let this circulate more widely among users, but
> 
> which is a valid point. The removal of reiserfs and sysv has been pretty
> surgically clean. So at least from my POV it should be simple enough to
> revert the removal. But I'm not dealing with stable kernels so I have no
> intuition about the pain involved.

It'll probably cause a lot of pain for the distributions that support
PPC Macs because that's the only fs that the OF knows how to read for
bootfiles.  For dual-boot Intel Macs, their EFI partition is usually
HFS+ and contains various system files (+ grub), but their EFI actually
can read FAT.  I have an old 2012 Mac Mini that runs exclusively Debian,
and a FAT32 ESP works just fine.

> > OTOH I guess no maintainer for a decade is really bad.

On those grounds,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> > 
> > --D
> > 
> > > +
> > >  	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
> > >  	if (!hsb)
> > >  		return -ENOMEM;
> > > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > > index 948b8aaee33e..58cff4b2a3b4 100644
> > > --- a/fs/hfsplus/super.c
> > > +++ b/fs/hfsplus/super.c
> > > @@ -656,6 +656,8 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
> > >  {
> > >  	struct hfsplus_sb_info *sbi;
> > >  
> > > +	pr_warn("The hfsplus filesystem is deprecated and scheduled to be removed from the kernel in 2025\n");
> > > +
> > >  	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
> > >  	if (!sbi)
> > >  		return -ENOMEM;
> > > -- 
> > > 2.47.2
> > > 
> > > 

