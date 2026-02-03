Return-Path: <linux-fsdevel+bounces-76193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIgmEdn0gWljNAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:15:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8FD9C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23EB3303ABDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ADF34EEE6;
	Tue,  3 Feb 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUMytbp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281234D4FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770124100; cv=none; b=H1AIFovgFHiTvU/w0feOzMK4GYOU0ANrln2m4y9rQClDIVWNR1hLGLeM817zp+giok5JUA8OMMFtckXL8eVDvHM62Dd44jEJ4UHxLPRu1cPdt6jla0aEgKgzui8/xueghyJrE5puZvHaHsbHtuoEez/M8//TKCqxz2bzh0d75g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770124100; c=relaxed/simple;
	bh=Fgs6oq5ZmgOdR8h8oGiVipB4usedwgC3ie9P6qq4rbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwKPz1ydhPYtR0EmDAHQKuKeP7gHZep8mq2Qx2uueq8RZlxcNinQAnGKQPiimXhwHL0NKE/qZv//hxxcmnj8gacBFmxnngdcZXIQdbHO7Ie3vdAI7v/BUT5BhguYpMITUypt1IOFK5NCFrun/44v6rGZbK+bei7Ua0QpEHkzeWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUMytbp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10DAC4AF09
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770124099;
	bh=Fgs6oq5ZmgOdR8h8oGiVipB4usedwgC3ie9P6qq4rbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZUMytbp58agsSidHdsN1YkjVxPn30NQGMKxWlHuGo+B9bLOQqal8ynb8m4RM6dZzB
	 sSSBXmvSWN9sxJly2Uo00RmJQNg3KAdCqb0Q5/zozJChm4hWBnN6cjt6+W8zjhvlMl
	 Lw1M5y7IetgxyGdBidv0e5sBJl0cSt1Zt66YJGeJqVyGX+PmGXrXHD34dRaYNQ7UgZ
	 25pkPgClnzsm6q6hW4uUTzkKNP+zewV+SxmBdPeodjb0ibHuxdN2vDlpU7oHMqAU6O
	 nJaK7lc9n5zKtLQ9KXL8thsfPBMMxVmfT2nuv6KKkRonNGYNvzsVqww6o/1BwnPR/i
	 zFKMUbQPlnldg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65941c07fb4so492582a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:08:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfwp0NUSu2Hqbe0gyWRFiE8E1fKD4OGzQI3YRA1TkxJ7zMxNCuIz4jMn1vHmjjelfTgK5D3cvGogqzUalF@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkFrKYNZsJr4tJdrpjA9Cms+E0JYBkjZJxUAf/n4zXdnBpJTS
	UjsiKOvvUdnHym1ggOYm11w3AFkpYJEFy5TajoHz6EA4z+RoSADoeUiek38Wmb9BJb3+dAdg06m
	2clzzjXH4DEzC1TzRppdLW4HDQQ9+YPg=
X-Received: by 2002:a05:6402:5253:b0:658:bc1d:a5c3 with SMTP id
 4fb4d7f45d1cf-658de55cfbfmr9271670a12.11.1770124098445; Tue, 03 Feb 2026
 05:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-9-linkinjeon@kernel.org>
 <20260203060748.GE16426@lst.de>
In-Reply-To: <20260203060748.GE16426@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Feb 2026 22:08:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CPA-mmyT9_0y+E4D+O92q6q9hipGac6c8QoGktCCAvg@mail.gmail.com>
X-Gm-Features: AZwV_QisAJmriyDvviu1nHEEg5TmiJbbpmpKBg9VXxucQC8DWSYIhqcmhvwg4HU
Message-ID: <CAKYAXd_CPA-mmyT9_0y+E4D+O92q6q9hipGac6c8QoGktCCAvg@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] ntfs: update file operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76193-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lst.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75F8FD9C86
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:07=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Suggested commit message:
>
> Rewrite the file operations to utilize the iomap infrastructure,
> replacing the legacy buffer-head based implementation.
>
> Implement ntfs_setattr() with size change handling, uid/gid/mode.
>
> Add support for Direct I/O.
>
> Add support for fallocate with the FALLOC_FL_KEEP_SIZE,
> FALLOC_FL_PUNCH_HOLE, FALLOC_FL_COLLAPSE_RANGE, FALLOC_FL_INSERT_RANGE
> and FALLOC_FL_ALLOCATE_RANGE modes.
>
> Implement .llseek with SEEK_DATA / SEEK_HOLE support.
>
> Implement ntfs_fiemap() using iomap_fiemap().
>
> Add FS_IOC_SHUTDOWN, FS_IOC_[GS]ETFSLABEL, FITRIM ioctl support.
I will use it in the next version.
>
> >  static int ntfs_file_open(struct inode *vi, struct file *filp)
> >  {
> > +     struct ntfs_inode *ni =3D NTFS_I(vi);
> > +
> > +     if (NVolShutdown(ni->vol))
> > +             return -EIO;
> > +
> >       if (sizeof(unsigned long) < 8) {
> >               if (i_size_read(vi) > MAX_LFS_FILESIZE)
> >                       return -EOVERFLOW;
> >       }
> > +     if (filp->f_flags & O_TRUNC && NInoNonResident(ni)) {
> > +             int err;
> >
> > +             mutex_lock(&ni->mrec_lock);
> > +             down_read(&ni->runlist.lock);
> > +             if (!ni->runlist.rl) {
> > +                     err =3D ntfs_attr_map_whole_runlist(ni);
> > +                     if (err) {
> > +                             up_read(&ni->runlist.lock);
> > +                             mutex_unlock(&ni->mrec_lock);
> > +                             return err;
> > +                     }
> >               }
> > +             ni->lcn_seek_trunc =3D ni->runlist.rl->lcn;
> > +             up_read(&ni->runlist.lock);
> > +             mutex_unlock(&ni->mrec_lock);
> >       }
>
> Do you ever hits this?  O_TRUNC should call into ->setattr to do
> the truncation long before calling into ->open.
Right, I will remove it.
>
> > +
> > +     filp->f_mode |=3D FMODE_NOWAIT;
>
> This should also set FMODE_CAN_ODIRECT instead of setting the noop
> direct I/O method.
Okay.
>
> > +static int ntfs_file_release(struct inode *vi, struct file *filp)
> >  {
> > +     struct ntfs_inode *ni =3D NTFS_I(vi);
> > +     struct ntfs_volume *vol =3D ni->vol;
> > +     s64 aligned_data_size =3D round_up(ni->data_size, vol->cluster_si=
ze);
> > +
> > +     if (NInoCompressed(ni))
> > +             return 0;
> > +
> > +     inode_lock(vi);
> > +     mutex_lock(&ni->mrec_lock);
> > +     down_write(&ni->runlist.lock);
> > +     if (aligned_data_size < ni->allocated_size) {
>
> Splitting the compresse handling into a helper would really help
> the code maintainability here.  Also please add a comment why
> this does work on final release, which is highly unusual.  And
> even more unusual then doing it in ->flush which is called for
> every close.
Okay, I will add a helper and add a comment for this.
>
> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks for the review!

