Return-Path: <linux-fsdevel+bounces-24111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE63939BE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 09:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912FC282DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 07:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719C14B07A;
	Tue, 23 Jul 2024 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4ELEGbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22414AD3E;
	Tue, 23 Jul 2024 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720840; cv=none; b=kjvaVYN6xpCiJvxfzt84vJ04dU1qgxgHYX+OS5zEFtcIOJdAbu3BtpZDssW5B1wjec+4VidSEpACeMSCr0mwSqPLfdLOgDoRJIYKlaozuR1vZGOO3BOxIHSmr8gccrGEgQjj+HfT1ZWjT7/U6i/kwY/o/DhkhZRCr95miGggArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720840; c=relaxed/simple;
	bh=ohwuZOHbx1pyGTACmYGT8LdVk7iJcXF5WRCpTQ8WDq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=om6Zm3mdpaDr4/364dqF6ZEN5cssYSzJpH67e3caCprjaJBS+xUTK+X8Ln6P3VZGioygvRzVZE5ndFJqx77CSKwtoMoEYtdrspkEtt5I7DjUGJ38aneza4l/dxb/468xOXGjpzhX8RSMT16wVBWHzGJXwafl3jw2gSQmJ7IGxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4ELEGbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6652CC4AF09;
	Tue, 23 Jul 2024 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721720839;
	bh=ohwuZOHbx1pyGTACmYGT8LdVk7iJcXF5WRCpTQ8WDq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4ELEGbgUGgChPAotuYv0sgAIY2tNQ2RY13dtVxSeYz//rt00CgxX3TXcSiRa6JLU
	 uYynEFC/+/tp+ApWv9YQ4UFTGn5zi0pQCBOoTLDYfQTau1fRyvKpSOLyeCcGMJBJrL
	 uFoREXr8KCvir0zA+1OVXPBi3eM+vcJX7FDRq2kNPP+PAJe13ATFGwCNKmzMhNjzEa
	 /DEr1w+NwLkz7pbfWaxHVIPm0EECxjOOLIX2DlNnPtphFwqWy0r/Lcw+MBubdlqhbQ
	 gdspDcA774rM/5GHq9ksPhhR0uqNSz4cdpr6r/MSk4zus2bRPMZKpkp3uRhFPVs1fd
	 W9BGl8ih7kHQQ==
Date: Tue, 23 Jul 2024 09:47:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: 47 Mohit Pawar <mohitpawar@mitaoe.ac.in>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Fixed: fs: file_table_c: Missing blank line warnings
Message-ID: <20240723-kredit-bohrloch-2942d7c53f78@brauner>
References: <20240713180612.126523-1-mohitpawar@mitaoe.ac.in>
 <CAO-FDEOhDSxOw8jyxtdqhJP8-wz8QP+Veo0yGehXTM9F=4bsnA@mail.gmail.com>
 <20240722163741.us3r3v5pe2d76azk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722163741.us3r3v5pe2d76azk@quack3>

On Mon, Jul 22, 2024 at 06:37:41PM GMT, Jan Kara wrote:
> On Mon 15-07-24 09:26:29, 47 Mohit Pawar wrote:
> > From: Mohit0404 <mohitpawar@mitaoe.ac.in>
> > 
> > Fixed-
> >         WARNING: Missing a blank line after declarations
> >         WARNING: Missing a blank line after declarations
> 
> The patch is missing your Signed-off-by tag. Please add it. Also I'm not
> sure how Christian sees these pure whitespace cleanups but in this case it

I'm personally pro such cleanups.

> is probably at least a readability win so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > ---
> >  fs/file_table.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index 4f03beed4737..9950293535e4 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
> >         register_sysctl_init("fs", fs_stat_sysctls);
> >         if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
> >                 struct ctl_table_header *hdr;
> > +
> >                 hdr = register_sysctl_mount_point("fs/binfmt_misc");
> >                 kmemleak_not_leak(hdr);
> >         }
> > @@ -384,6 +385,7 @@ struct file *alloc_file_clone(struct file *base, int
> > flags,
> >                                 const struct file_operations *fops)
> >  {
> >         struct file *f = alloc_file(&base->f_path, flags, fops);
> > +
> >         if (!IS_ERR(f)) {

I would then change that to:

struct file *f;

f = alloc_file(&base->f_path, flags, fops);
if (!IS_ERR(f)) {

