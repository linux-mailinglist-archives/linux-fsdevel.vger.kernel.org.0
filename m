Return-Path: <linux-fsdevel+bounces-67864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0FDC4C8A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37BD3BC394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A322E975F;
	Tue, 11 Nov 2025 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DGZg1hpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E9238C3A;
	Tue, 11 Nov 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851860; cv=none; b=gXUWvpTbLhutipQ2ntZS9kLUk2+zNu7a8wN3ll6HLDb9x19BYu9eFrBgqCAE1x95hdHQQRoYFev2b2Fj++sCVvXaoGWS3zx0Gmsma+XNjFBQnzdndWw1r+/S+2/NxW4MS6gT/vvo7T9FZ2EGiNuOkxWb4mYmlWtpBar/JWM9sX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851860; c=relaxed/simple;
	bh=VPLZAA4LoKT22J4c1RkRpNHV87GAwiwNtPeNSsX/uTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLyGTuyVCuTSxUgHTC45Glr90G7X61Lr58q4COtm8srAdXTZTRbZjFgFPdf2G28Ln97Lh+U82e05NPkjgLhacFKeXDnuCe/mxXWrehiue+TYyOkK5APskv0HhmaR9Kp68Zt4e7vduSdX5FotgPY/ZoxO0GBX5oLd418MfGcX3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DGZg1hpw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZwrtQ6+FGJJ1cCIQ14Mdkpcu+BTeaX0CsYugdDU7yYE=; b=DGZg1hpwOQOwZRy7GqzXvT1Ppp
	s0j9UGTDrdTVjnjCFY/BOcvLF2ts+ZSem30sHYzAfyS5kqnOSj6DFOCbYrJXrxwoYJ6Tx/2ZehLU/
	Cmy6PdSNRT5ttSh3fzajYQDBXEp0ByDm35Vf28QgBbGZy4vIqQOX0LUMUvPxio8TH0k9hjzdodQfx
	PdeS+5y0F1iNwnD9B1V+HIfwYFn6g59gvCeIoVUVEeRp7difEsQwU0pb0pWgvFMXRSy/hylsMrsiO
	JDiBiictOkS41x3MEjBBBdj0+fxVl0p2HJLGiuZKCZ+nw+E0UO1nbVr0W+BoDNy7g3vSbJxFguTmD
	IQozz1/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkIS-0000000ETgU-22QC;
	Tue, 11 Nov 2025 09:04:16 +0000
Date: Tue, 11 Nov 2025 09:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111090416.GR2441659@ZenIV>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111065951.GQ2441659@ZenIV>
 <d8040d10-3e2a-44d9-9df2-f275dc050fcd@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8040d10-3e2a-44d9-9df2-f275dc050fcd@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 04:25:29PM +0800, Ian Kent wrote:

> > Huh?  What's to guarantee that superblock won't outlive the namespace?
> 
> Not 30 minutes after I posted these I was thinking about the case the daemon
> 
> (that mounted this) going away, very loosely similar I think. Setting the
> 
> mounting process's namespace when it mounts it is straight forward but what
> 
> can I do if the process crashes ...
> 
> 
> I did think that if the namespace is saved away by the process that mounts
> 
> it that the mount namespace would be valid at least until it umounts it but
> 
> yes there are a few things that can go wrong ...

Umm...

1) super_block != mount; unshare(CLONE_NEWNS) by anyone in the namespace of
that mount *will* create a clone of that mount, with exact same ->mnt_sb
and yes, in a separate namespace.

2) mount does not pin a namespace.  chdir into it, umount -l and there you go...

3) mount(2) can bloody well create more than one struct mount, all with the
same ->mnt_sb.

So I'd say there's more than a few things that can go wrong here.

Said that, this "we need a daemon in that namespace" has been a source of
assorted headaches for decades now; could we do anything about that?
After all, a thread can switch from one namespace to another these
days (setns(2))...

