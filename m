Return-Path: <linux-fsdevel+bounces-8718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69C83A86B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B243B1C209CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58B34F88F;
	Wed, 24 Jan 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvcp7e8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161252C69F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096564; cv=none; b=Z6i+UmPoGHNQ8Zy+dL0nJsvkyBQafCn4wF0kpseYdyTuNrf9hijxjmKQ4Jr5SAAJJHW7dXzltv5UWMyIspXZj62/HWg8inwXCJlmbucUqwMjYGHJ9kjzg3IzOoe6N5FJYqBAnUQ5i/b9YaBk3LOZGiqzJ3RtJXaOODlgZWFXYDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096564; c=relaxed/simple;
	bh=g5mvmux9aGNZ0p2/A4msslSatKdjYFurJLfeoYD4z38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWm7UUQthf0/KmbXOikZJb3J+ojhnBThsa5h3U20QA3vKgdMIep/E0Y7zX16pW8AfYFK/ZO2EzY6vn5mfNhtAkClS6SwgniUGpsyRqbnWnY40rE06I57wGKXeTp4kD5M4VFBhzvG4wwgkoye9V4QrSMZkifwhR02plsuYDNr4JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvcp7e8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF19EC433C7;
	Wed, 24 Jan 2024 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706096563;
	bh=g5mvmux9aGNZ0p2/A4msslSatKdjYFurJLfeoYD4z38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lvcp7e8r0cf7RnX0j3u+1ZaHG4VWNTREqCjYZiVrW1FP/92S50g2ZosZnoejPpxdd
	 t3lrilb102OoxzjBaOSSarngCJsfM5ASef9dpi13bRxOUjVCQeAAqe67ceWiQad2+d
	 n0XWToypRtjQ5kOqR+/i93sbqdWB9LjMiHdpwA9wVS4gzE8i5vf0YPDEvJz+Yhckzw
	 qEGZmpmx3cPir73v22KTlPbwruyt1XMiHZsdEw0BIImb72wpMTK6+Ommnbk2F5DLS3
	 z+VcwE3PHcx+YaxZvy1UuW6PmkfkT1zyxuyCsoBa/oM/FEO4V1BkFVaVFIsva7CAhl
	 tmqofxklvOUQQ==
Date: Wed, 24 Jan 2024 12:42:39 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Re: [PATCH 3/3] Enable support for tmpfs quotas
Message-ID: <ozwso3vxlqvhncphhxdmqyhtcdjkngdm3zkthhdr2otr2jhbcf@vy57quyazjv5>
References: <20240109134651.869887-1-cem@kernel.org>
 <20240109134651.869887-4-cem@kernel.org>
 <gWO_6455WDo9j0nGP5RMvQ8C6kbvXksXMUIN7sy-MEITH9dK6p49_3nU1AqQVqIxP0lk6RA7vMSIkcaT3EMlFw==@protonmail.internalid>
 <20240117175954.jikporwmchenbkrk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117175954.jikporwmchenbkrk@quack3>

On Wed, Jan 17, 2024 at 06:59:54PM +0100, Jan Kara wrote:
> On Tue 09-01-24 14:46:05, cem@kernel.org wrote:
> > From: Carlos Maiolino <cem@kernel.org>
> >
> > To achieve so, add a new function handle_quota() to the quotaio subsystem,
> > this will call do_quotactl() with or without a valid quotadev, according to the
> > filesystem type.
> >
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Thanks for the patch. Some comments bewow.
> 
> > diff --git a/quotaio.c b/quotaio.c
> > index 9bebb5e..3cc2bb7 100644
> > --- a/quotaio.c
> > +++ b/quotaio.c
> > @@ -34,6 +34,22 @@ struct disk_dqheader {
> >  	u_int32_t dqh_version;
> >  } __attribute__ ((packed));
> >
> > +int handle_quota(int cmd, struct quota_handle *h, int id, void *addr)
> 
> Call this quotactl_handle()?
> 
> > +{
> > +	int err = -EINVAL;
> > +
> > +	if (!h)
> > +		return err;
> > +
> > +	if (!strcmp(h->qh_fstype, MNTTYPE_TMPFS))
> > +		err = do_quotactl(QCMD(cmd, h->qh_type), NULL, h->qh_dir,
> > +					id, addr);
> > +	else
> > +		err = do_quotactl(QCMD(cmd, h->qh_type), h->qh_quotadev,
> > +					h->qh_dir, id, addr);
> > +
> > +	return err;
> > +}
> 
> ...
> 
> > diff --git a/quotasys.c b/quotasys.c
> > index 903816b..1f66302 100644
> > --- a/quotasys.c
> > +++ b/quotasys.c
> > @@ -1384,7 +1390,11 @@ alloc:
> >  			continue;
> >  		}
> >
> > -		if (!nfs_fstype(mnt->mnt_type)) {
> > +		/*
> > +		 * If devname and mnt->mnt_fsname matches, there is no real
> > +		 * underlyin device, so skip these checks
> > +		 */
> > +		if (!nfs_fstype(mnt->mnt_type) && strcmp(devname, mnt->mnt_fsname)) {
> >  			if (stat(devname, &st) < 0) {	/* Can't stat mounted device? */
> >  				errstr(_("Cannot stat() mounted device %s: %s\n"), devname, strerror(errno));
> >  				free((char *)devname);
> 
> I'm a bit uneasy about the added check because using device name the same
> as filesystem name is just a common agreement but not enforced in any way.
> So perhaps just add an explicit check for tmpfs? Later we can generalize
> this if there are more filesystems like this...

What about adding a new tmpfs_fstype() helper, to mimic nfs_fstype, and use it
here? like:

if (!nfs_fstype(mnt->mnt_type) && tmpfs_fstype(mnt->mnt_type))) {
	/* skipe S_ISBLK && S_ISCHR checks */
}

We could open code !strcmp(mnt->mnt_type, MNTTYPE_TMPFS), but it seems to me
adding a new tmpfs_fstype() helper is easier on the eyes, and also OCFS2 does
something similar.

Perhaps that's exactly what you meant as having an explicit check for tmpfs, but
I'm not really sure?!

Carlos

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

