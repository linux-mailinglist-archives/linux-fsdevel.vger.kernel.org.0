Return-Path: <linux-fsdevel+bounces-77735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOebNmxdl2mIxQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:58:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84480161D44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 19:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E591303C61C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 18:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3022EC562;
	Thu, 19 Feb 2026 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXAOwycu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F812E8DFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527474; cv=pass; b=aki49xM8XLF8DgxJqJoQZ2EvId5blKvnSY5pz3ijaH8HYMnmbwJoVSQ8y+M7gJv9GXD32T8C68AnPSQ3SlBukSBWN0dWB9wnEbyZE/kNSfY1pWu03Urc6TUJrS+uEInpr5gC/TR6PgCRj5aFkTAe8Tlt8lSNJrUgyWKbUqxZwz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527474; c=relaxed/simple;
	bh=fj+YaSKDsualB1VdmxHvXU4DOPR+wgzu3vnMbjBDHwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA/3rk2pvzcTlsn9ald2t/5TDYI+UfZYhDOHpEdFRtvULdnf5KwhgYXdTw4oRUssDAWNFG33J4EAXvsZ+Par0GFttGqIy/tVBIN/fP+uZNStoSz+bwjzOAogxMGa90m5lsSdODRVd3zhs8LmlMgRG9t25SrdAsJoc0G9OcWa20g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXAOwycu; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so9905e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 10:57:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771527471; cv=none;
        d=google.com; s=arc-20240605;
        b=N2Qo2koEPy5trgdzKEV55jn06eU6RFOwiFqvgLLRG0GOE5Ddw9HSNz2qoaKAnZoodq
         k/grQPDc3Q0Bi0ydYGROmGdG8n/Tx+x+eCy3awYwYy0DpTS5NJjETSj/r6zpxr/hYouq
         QTaefLXaNQzFRyAkSc2JGCkZISIRd1soo2iXWB+J0dpVIM75VYn6ym6tK/3aFcgUZqC/
         6swBobI9HKJ1dP+dhAW1DwObQ+cAJwlPUZF5dsSS8LA+1mfwxf1SbGfXImFy3/WESubW
         ZRiKyZ0UI3XHD8pUiopL7Cml4MJzBwtJutA66kfD/PZW2FbGYr7Kqenk+TYicKl46fHo
         FuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NFBMInVvk2+20qEW3rAuH6OydbWEXhtEVk/J1ukU7mw=;
        fh=N5XUnkb5KvYAlH3YbbjNEichV8+wLgXgqEV6O94Ulmc=;
        b=bfbcmWHImaXPhyIKVaUAXJJXKqj55ZO56+j+QJ7Hz6A/x/9JMkD7uJpJZdsnsFzjxj
         2chpwx4B6sIhFny9m/ygmTzE8e6xkcwMTOGQC9jZ7a3FZdKGpw7NYjju6BpQaugKdgg0
         rvO3r+3lBQe7Cy1qCA2OabpCx+X7V2YaJu35tzn/2DOrKCnGr1fAw0R5PSpZr6XPCNNz
         ILVcucW7zthDAXsxFl/OJIE07lLvPD0PV4DRwcr9qXRqmFOkGxFTQ04cURUuD3eL3XkP
         XYmMSnE6lO3VO03ZJ5HB8Y3CWI+qmGrVK69daAN7lvTozjSfkwJHq4eDbOkxZKsHw/Wh
         YDnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771527471; x=1772132271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFBMInVvk2+20qEW3rAuH6OydbWEXhtEVk/J1ukU7mw=;
        b=YXAOwycurFI0xWE2M34UN36yD4VC+Z+fraYCSSU4T1TlxsedLkJ3PsexrOxFTmBefu
         dPPUr+zCIrd6Kbb/kyc+ADYJxYyq9ofULbamjZGE2eqxEl/AJmufZwxnHSvu9vNkPk3O
         Pd4ayS6FO5aNHR8rWTDktvsHtO5qKHwUvKpXCAhBYOPlPaUp95jhbYGDYFzzo3D72i87
         AC+v3IK2HFITa0UfoZC3+YQZfAFHZJLH0/LaeKup+/yiU2SbQkHIEj+G/f3n3ralobsx
         4uUz+lg7KKfJpSqqMT3mCAwsFQJ7SdR4GBv0JXAWy0JlQ8oSgjX5uelyDaF5DYYKH1hH
         sHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527471; x=1772132271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFBMInVvk2+20qEW3rAuH6OydbWEXhtEVk/J1ukU7mw=;
        b=h255vJ8bjrw78Xe+E/JbJYZqre5ytZgetBUtRI3KFYCB0kW58DF10IIv8xolHIEKng
         5c6pl/hoOLDUBTjlEH4gIlULM9jPVb7JQ6xviZeEyVReSoLvJ82XwXR20O85dGBzCoZI
         rXb0OBZ+7UHS+JGJEbdm5vA8Rs4EWj4JzD5hi4S74qj0XzqaW+ZxoHBkVFjRZNA12p5W
         VzykV6+cO4N++k9v+GGAQagwyZ70kftw61SlLt/mDBMagk8DZLftjyb0abPDVSneWXl4
         rR3aQQrGD3bSlSikumUfc/ujD4dhsCBq37bBr7yrmdwazyyFkiOKdljX9eHY57i2uzzb
         MhnA==
X-Forwarded-Encrypted: i=1; AJvYcCVxAXdQu8wU8zaey+QZlFKghvqV2703xIw3RCODvjsVck1uXhOg3C4zelvjvpcD64q3FWhS2waQK7laTm6c@vger.kernel.org
X-Gm-Message-State: AOJu0YzyByZymLmDTyNvJSBdjig4UKKAvuXGvfbG8MpNl1xoMMpw4f8E
	6TbkeeaGniTJx3M1A9A5fzKd+EHF0or6SXKE9HscwROn7bOi86RNoS0Kjq6xdCoUuRIonjEcrvH
	5SqHLKtko03fAg5U5ZlZ9o0ar1fYk0JBorA6wog1d
X-Gm-Gg: AZuq6aKXxEmJ6lRW6Nw/BIamz+xFlGsmuHfcOjYoOWwNui3wUw/nrQcdYg1rOpWbew0
	zzfNhE/QQZYBs2oZGf2sUygdJ6tYO3lP4H65zBHP7aI1moBVMgQham0EMjBbR39DNCGc7TDH3bu
	5XhP+YEMy8BgTy7hs8D78Z54yD1fov/qnoIHC1pRmFbYNhHya1EVVnqnBfq3oUtNnIhfKnv4m7M
	J2XC17zliKEKVsDbUpM92nN3duXTZlJ/G94o0AI2z5GPj+kCgZW64joYCfxy/k67zS6zgNHXv9o
	sfcDhZ2nrXL1JiW/BcrDGZTPs1gbgRKwfYxUEn0/fHDYs9DVea1ujImY9dPjLq29EHI8iw==
X-Received: by 2002:a05:600c:4e0d:b0:47a:80ec:b2f7 with SMTP id
 5b1f17b1804b1-483a3ea10b2mr41835e9.14.1771527471028; Thu, 19 Feb 2026
 10:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
 <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
 <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
 <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
 <CABdmKX0DGP9=OOPwU8WjqHnmRDfPnxoAjm8Rvy-D2GYQX0GE0A@mail.gmail.com> <anwsdq5gxzeyfavxqvujbevozknyix6xo7leccqrbznfdgi4nz@hfuqqgtv7m4p>
In-Reply-To: <anwsdq5gxzeyfavxqvujbevozknyix6xo7leccqrbznfdgi4nz@hfuqqgtv7m4p>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 19 Feb 2026 10:57:34 -0800
X-Gm-Features: AaiRm521HjvGNhdUSunhILK8eWMKqrsMi6CHX_6mrk_tnUftoq73nxUbEb5C0LY
Message-ID: <CABdmKX2JXndogbfvTM0WVia9CtXucth+X3UqXBimN7vZ4X0yow@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Jan Kara <jack@suse.cz>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77735-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,memory.events:url]
X-Rspamd-Queue-Id: 84480161D44
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 3:05=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-02-26 14:10:42, T.J. Mercier wrote:
> > On Wed, Feb 18, 2026 at 11:58=E2=80=AFAM T.J. Mercier <tjmercier@google=
.com> wrote:
> > > On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM T.J. Mercier <tjmercier@goog=
le.com> wrote:
> > > > On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wr=
ote:
> > > > > On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > > > > > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz=
> wrote:
> > > > > > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > > > > > Currently some kernfs files (e.g. cgroup.events, memory.eve=
nts) support
> > > > > > > > inotify watches for IN_MODIFY, but unlike with regular file=
systems, they
> > > > > > > > do not receive IN_DELETE_SELF or IN_IGNORED events when the=
y are
> > > > > > > > removed.
> > > > > > >
> > > > > > > Please see my email:
> > > > > > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyh=
fdy4zvxylx732voet@ol3kl4ackrpb
> > > > > > >
> > > > > > > I think this is actually a bug in kernfs...
> > > > > > >
> > > > > > >                                                              =
   Honza
> > > > > >
> > > > > > Thanks, I'm looking at this now. I've tried calling clear_nlink=
 in
> > > > > > kernfs_iop_rmdir, but I've found that when we get back to vfs_r=
mdir
> > > > > > and shrink_dcache_parent is called, d_walk doesn't find any ent=
ries,
> > > > > > so shrink_kill->__dentry_kill is not called. I'm investigating =
why
> > > > > > that is...
> > > > >
> > > > > Strange because when I was experimenting with this in my VM I hav=
e seen
> > > > > __dentry_kill being called (if the dentries were created by someo=
ne looking
> > > > > up the names).
> > > >
> > > > Ahh yes, that's the difference. I was just doing mkdir
> > > > /sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo=
.
> > > > kernfs creates the dentries in kernfs_iop_lookup, so there were non=
e
> > > > when I did the rmdir because I didn't cause any lookups.
> > > >
> > > > If I actually have a program watching
> > > > /sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill k=
ill
> > > > calls, but despite the prior clear_nlink call i_nlink is 1 so
> > > > fsnotify_inoderemove is skipped. Something must be incrementing it.
> > >
> > > The issue was that kernfs_remove unlinks the kernfs nodes, but doesn'=
t
> > > clear_nlink when it does so. Adding that seems to work to generate
> > > IN_DELETE_SELF and IN_IGNORED. I'll do some more testing and get a
> > > patch ready.
> >
> > This works for the rmdir case, because
> > vfs_rmdir->shrink_dcache_parent->shrink_kill->__dentry_kill is invoked
> > when the user runs rmdir.
> >
> > However the case where a kernfs file is removed because a cgroup
> > subsys is deactivated does not work, because it occurs when the user
> > writes to cgroup.subtree_control. That is a vfs_write which calls
> > fsnotify_modify for cgroup.subtree_control, but (very reasonably)
> > there is no attempt made to clean up the dcache in VFS on writes.
>
> OK, and is this mostly a theoretical concern or do you practically expect
> someone to monitor subsystem files in a cgroup with inotify to learn that
> the subsystem has been disabled? It doesn't look very probable to me...

The rmdir case is the main one I'd like to fix. In production we don't
currently disable cgroup controllers after they have been enabled. I
agree the monitor-for-subsystem-disable case seems improbable.

> > So I think kernfs still needs to generate fsnotify events manually for
> > the cgroup_subtree_control_write->cgroup_apply_control_disable case.
> > Those removals happen via kernfs_remove_by_name->__kernfs_remove, so
> > that would look a lot like what I sent in this v3 patch, even if we
> > also add clear_nlink calls for the rmdir case.
>
> If there's a sensible usecase for monitoring of subsystem files being
> deleted, we could also d_delete() the dentry from cgroup_rm_file(). But
> maybe the performance overhead would be visible for some larger scale
> removals so maybe just using fsnotify_inoderemove() to paper over the
> problem would be easier if this case is really needed.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

