Return-Path: <linux-fsdevel+bounces-77615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFC2DRoalmkSaAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:59:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8411594BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E88EB3029629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A62349B02;
	Wed, 18 Feb 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgeRmV1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3823345CC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444742; cv=pass; b=RsX8FB7/0J5g7oqfpgLmysHalqYIdT1GjZEHBO4KDhe7WgtXkWRlD2YqVZjmfi5vIMOQToYwPMq+qH1RM7yRGJJLHJto/e/zJ1aoB6wezYG3Ktsh4I/STZxAt8ikJUZt7H67c1R2TYn//jc49IjlBj6x8R8XbZQEFF+ewA9wGe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444742; c=relaxed/simple;
	bh=fAj9Q1ygswz4E6SrtEFpUTAbwt8zju3u9r/LEpTkE3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpkywlX99ZSjzTQC+d5ZeHW6rx0TDuAgknJ/l045CthlRwPEEjzRX77K2/ka88Li+sjDxYOf8Le/vOgYha9WVuOH50QgGBjFWof0DJQLZlp+Jb7wP6w1OHQWlNigGl3adfvG3yod4XtEyO/LETFtp1fCZnXV4pKV4C8w8MljHTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgeRmV1R; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so15695e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771444739; cv=none;
        d=google.com; s=arc-20240605;
        b=RSiAta6iZ1uAY7vr7SkG0c5P5TkaIV1BzeF18mlOWQ7zCVU1l0zFprg9S60MX4TpPB
         D/xHPRJ0XNjokzbpYi4YEx3pgMYIZU1Z5AwgxhsqGlzUaO2x9a2XBmcTeM+eqi9Q1KVS
         1BJLlSInQTrr8ycdpsjY3OEHQcMy6TMweEGMWvlAHfQUB7ixX+sli+PyOqlXmgtwo5Z9
         AVrVrRBxbOUxUcFh9i3OEZpY+CMYZkOLHEbQSgMREkK7FcCTnb3SM2gXfJyxSakDACJT
         GTNC8LTwVD0QlXYk805SaJoW9HJCEMcEcFRN3lUl6BhqpDbzMRaG/+ZUu4NW5x20Mo7B
         dEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OylA8EM9epDUNp/ar6ETdvAJBvo4gpIzvj6gp7Iy9D0=;
        fh=alRnncBadoomD6n6i+Frs0/8QVGIq1iAauBtbwr9HY4=;
        b=Yl0yGPlZI1yKu7hzPbviVUkgtrPrYEqQMEDSCGG3IyalX+DP7ndDUncwU0SBjSQ230
         J9rb07vCKrni+8v4XhpDTpWYWPrRbjW5YfElThjRr3KZy9zm2/Gm2dQ0tOKlaoL7qmqj
         Vi0QAr8ffEqHIbn07G4pSwjRf9b6t0ddBXJj4FP2lMTYl+VNRbaxFKlx2wvjbWNGoreV
         D2Ml9KSk+No+dfy54KuHhSIIcmf4g5eLNgK2QT1W14gBQhI7pzRSvnI8Ynbm3kH0yc/L
         vD7Gao1VOafxtC63EYR7x96S4gK5vdvBO8kN19UMx55ZsHVAc2g6uGLPgQdwS1Gzn9+R
         ZSog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771444739; x=1772049539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OylA8EM9epDUNp/ar6ETdvAJBvo4gpIzvj6gp7Iy9D0=;
        b=AgeRmV1RhQBAlmnoA3RTul5w2nJ57KLE9ZZS9d2bLICsnWFYZTcAJGpdEciopvVxZd
         Z7wQVRxI3QX5CmuHlZqv4sE+nONEMSVZnoijJp8+xCi/OZxFk1yQBjZti4TiIVG8P5hn
         Ol9h//F+Zq/sWL8QbxfxuRIadPeuDnu4Zthz/UpA67xqevmyEUqmbwYfoX3z6aylsdha
         J09LIjJoQvf6TVKT3u3ayg0QvnOffSJM2dKGVPi1DzbDbGNw2am3ehv99BldvySO4qcG
         ARyY127U4WHG9UacPBZJ6VpsRlW0VHY1o1ahaA+oHnWlFwiM/enOn6MSLl7fcJEVRntj
         s/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771444739; x=1772049539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OylA8EM9epDUNp/ar6ETdvAJBvo4gpIzvj6gp7Iy9D0=;
        b=du4mqFG399ixM8uYHOD3Y/crdiwoKr2GAgfl4wrHTpCkfikyuIAYeqZfpfir+D8ZD0
         tYKITSylEeRwHwjZrEwnDTn1CJ7/b5PDZ7VqGmvlgCJPE5dVQpIC3qlQ9x/shMj1M7Fk
         4hH7TJPPbgqh9UmMK8Pn/HZu2lEyVhU0AcGJeBfvfTZ7uRVNzlioyI81R4baA9ckYbpp
         Kb2Rzxs6oSsLwsmFx4Z+o2sOv62iJiD9pS/CnqLtWFgdFdXZNTZ2gMxHwFW5qBlvCCFb
         MWM77fRz7v06iUwFyC9beJInxgm7ONmRyfBq+78kSVdIOTTvJt/feEOpyk0KdC+3gbAo
         E26A==
X-Forwarded-Encrypted: i=1; AJvYcCUvok5I99hAwvE/e/qC7nUr9jdkwJ47p3d9iGo0awG9wko2sLXDxEAiTgyCdAzLItqFR7XI2Oje+3GTGehV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dtJUoW9GrLB2MyWesRD9Y4vltQp8bU8t+aZA/HMZcB3H4mKo
	8C6JAcznERVoNXphkHvAr059aw/okWyJLm/QS6UttNw5pDr9rP2j+Cf+RRXP2FCrVlPwl8qpyuc
	c5ePMYuylc6bd0HwweHRs1ydiq9DsTe97zzkUejNr
X-Gm-Gg: AZuq6aJ2EFxU8QJituaQ3lvamp6j/XztvfVEXTtxOqu14CYR1vLDd+ibqTSymMSfDEL
	GP/7wfFX9mIexxCBl/7JwRjqQS4ibZfgOrm+83wcUu5wBr8leDEt8hPPSfru2I0evyXW2OwJupc
	l2IX1AFNkNdl4TMaxSdu3uXRQuQsCJq7/yA0qeGLxG9jcQbH92zFOAMhr6uK19qElWtcXo0jfno
	R6EALv7Yjcs+wWphLcxF7pjYjY1tTzkRXEGE9ILRZHrpfNxcoQpRaE2a68vnJQjgYRrMQFB57sk
	byFoT29ere2hqwqkPp4Wjb45fQ+biHy21OZfOOPq/5UydCbF3HJCmII0IEakprkDH0cBzQ==
X-Received: by 2002:a05:600c:8b76:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-4839e5d9a1dmr138535e9.4.1771444738775; Wed, 18 Feb 2026
 11:58:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
 <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f> <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
In-Reply-To: <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 11:58:46 -0800
X-Gm-Features: AaiRm52n0lIK2grreFCNiF6qE3JVFwkwj9cGx62TA9xdekMRJsGok-FwMltR-JM
Message-ID: <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77615-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: BD8411594BB
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrot=
e:
> > > >
> > > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > > Currently some kernfs files (e.g. cgroup.events, memory.events) s=
upport
> > > > > inotify watches for IN_MODIFY, but unlike with regular filesystem=
s, they
> > > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > > removed.
> > > >
> > > > Please see my email:
> > > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zv=
xylx732voet@ol3kl4ackrpb
> > > >
> > > > I think this is actually a bug in kernfs...
> > > >
> > > >                                                                 Hon=
za
> > >
> > > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > > and shrink_dcache_parent is called, d_walk doesn't find any entries,
> > > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > > that is...
> >
> > Strange because when I was experimenting with this in my VM I have seen
> > __dentry_kill being called (if the dentries were created by someone loo=
king
> > up the names).
>
> Ahh yes, that's the difference. I was just doing mkdir
> /sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
> kernfs creates the dentries in kernfs_iop_lookup, so there were none
> when I did the rmdir because I didn't cause any lookups.
>
> If I actually have a program watching
> /sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
> calls, but despite the prior clear_nlink call i_nlink is 1 so
> fsnotify_inoderemove is skipped. Something must be incrementing it.

The issue was that kernfs_remove unlinks the kernfs nodes, but doesn't
clear_nlink when it does so. Adding that seems to work to generate
IN_DELETE_SELF and IN_IGNORED. I'll do some more testing and get a
patch ready.

