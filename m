Return-Path: <linux-fsdevel+bounces-77633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBx/Fvc4lml4cgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:11:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E215A932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5F443019164
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CB3335074;
	Wed, 18 Feb 2026 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHXlcvqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CFF2FC006
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771452659; cv=pass; b=bbLDDQ6zaCgXOKjt1NhlQZtcyA/eTUyxsJ2IIX+VgvAKa77vjJn1R9+58vY3SIMFXorjeZD8UJUy9XLNH70fEbjmA3NqlQbqYrN1N3Hd+CfRqtnPlQKw/GMK67EeVsTq8UTfQZf2T/Z5ec+lli/2hTvq6bhL5Dc0/m28jrZkEwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771452659; c=relaxed/simple;
	bh=lPYt0pFhbd6M7kXSQtBzYZaVvT2A54L7thEUJD072Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGBRs3Aa3Nz+1PAAOfryIvYzKYzxMfhacDuu+TWha4h6klKiUuXA+HJ2s5V5rW2sQuf+ScjNSvK7l7esLJZmNcuasuICLv1HVSi/W5vlRTt3xxUI88mIIkunfNz8l77O7j2dlzOO+AFxbbwxj0Aa5XzrXWaE8MGuX8uyyPp2IfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHXlcvqR; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so26155e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771452656; cv=none;
        d=google.com; s=arc-20240605;
        b=YdcYz8KHdMVOIFSuGxBbWQIq+r4AlS4UZpWj7yYv/EYBAZAK9db7xWRT5a26u/zy3H
         krFRYDqzapG4P2GK3B9V1XD7K9WM1U22f8+uNE+daMF0zvzdgnRFDPJEska+IDA/0Oo4
         LD5ld+HKa0PdyohidrZRkogdnbA752yHlOszumiiYVSdpm29ns0NL1gwz+KR+VocD+6Q
         UIWgZst0wXh93W3RHFK41/eH7LOaDUyz1b7KH3kUmsuHog6sm3Z08wjJJOV11y6zfHB4
         tz4uc1HW+OoSQE8oZFYT8EDwpLM5uYAlrpl9oeXrmSc+F3GnJ6VwBJAL9cbk0jIJj/NI
         rnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        fh=CAx1YvupGPKOMsTtfwAuwmkBFRMOobkIktwfNOimdN0=;
        b=lX9uRoDbyzqfbRRSuV0FMgR7stOsapajcLRLoVSLfpsIaq9OX2PY5zE5k84kx3P/Cg
         v1T9RPt3NBx89OvNkslFhb1FlQDoDztQJpY03UheFyzqG+wjVhX/oJs1wuwngTTOVWXk
         RNBwpk1NTWTiTEGlMH7u++xytH1CnMQTkRLiOHPJQb9DNSrvYOq83GCI9heuJeOrdh46
         Wp7xg3hVx8Mc/NFb9hyrdrZDKcfT5SWaG8XVhW4mSpGMqg5T/N1tZD8EIvSa8f8WcIqZ
         dgzktZKvwB6ujcXo6Wco9O3B+QSIcXSZjhW+3A/NWHJKj72W702eTkDAXhMBMd0hk8q7
         EIyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771452656; x=1772057456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        b=gHXlcvqRsCXRFRWgKe2rCQ+pBr2va665XoRPpX94fX/z6KkXa7Eek/zmzIcgqrrMt7
         2D29ca6OTzPQtkc0XnawaXDloZM2bveVMyzqxPugfnwsquJ9FP+xvG0InyqiwPbgni3e
         ZktSpe5qmA2gHbik95BElCBIHX8gL9NTrEBeOOec+BZqkN3J0jhUQFJ49+rLFwnTQeUP
         Qz7fhSkiAWGqyzwRslZ/TDy9iUQtEC7Vr/g8et7rgSs1RVELu4iW5Bvh640XmcCfM71Y
         bPzzb/m3mUnqsbrHNrW+6eQ78RU8UFE/jo0JTlqDpraGUCgODweN06T8F4/6r1W5p9dp
         /R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771452656; x=1772057456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFceulQD+cH2ZvMG6LJDvnAg6v30pKU0WTiw2QCY5N0=;
        b=MFR1zv4CjoQ/Nz95Fz/k4TrQCB0eGVNWL9liYcSJioadyjF9PVFb5/tl3zgMWfRR2e
         lMF4hc83RsEJpdwX8lrcIlAT2wqD1gcCIxK98jHzoz2kjAbhj5n3jWdxziJQkrOXPjji
         XXRgs54APweJkaOAjnWgzFeTlNNXOoa3MEMt6nOKI90bBFXVyA47kipWz30vIYi+3I1C
         P8yqg9DfbNbmDLPFnQ+NmUhq/mhGBgwAS5b5MxD3dMndh9FYT5RpGHWs1xFjeVQEy46J
         HPsAWLZHf38GRlPSzsbz55wCVixB5KPtLgY7Y/OWAcfLtPMAmKw40H4ZwC7wBjmJchZF
         lEsA==
X-Forwarded-Encrypted: i=1; AJvYcCWvyNtSVhWekXFMIwnv/425seeK0x67p9N6hT7v3wpc+9nfMlBwWvuADa8wTVjCJvtPl99ADmHWO4KKSSGl@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXcd6r0KzyUHpm3oLY8YEFCCv9mxnlvcX8ZEJvWqq8wJ+Y4JC
	INypW62E9wD9XhiuJsWZTTbLD7f1raxw+rTqYagxeiSr/ttpB+h0QkR/egWMjIHmngYQfnIm21T
	b+pYne40BrIP+2fwefwIaau75tkZ3cRYbP91tM1cK
X-Gm-Gg: AZuq6aIvk8LQ0Oj0UD7PzdYXEX5DGezt0Pj3x4VEBcWe2oJ06whe4Wrq0Syq62p8cYL
	N6+xI6Vvi1+ZYgBJmhxIF3XJYqG8vZie4W3UlRn3f8b93zrXz8cJyqM5IROBDdukAv+Oo7fouje
	OSX1wZBwkciwyZrEd9YqwKo3bLClzH8Xk0r0fhD7hxnpW2eWBm6bTQ0zMqp3FYcshGCsyKB09gP
	wcxyyVlAwWk9MXbrTLT2pLLZIoqueNpGhkfKtTOoZ2jUZga0y1h26zCOt/5flTy7v4ssyn5y72R
	zhWuMbe/cOLBRF97bmP+CH9mD2iYKkfY8i0hgpYsajwstccmb7j/dO/lpsEDWHsaEBXl0g==
X-Received: by 2002:a05:600c:3e06:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4839f8fbec9mr92205e9.2.1771452655867; Wed, 18 Feb 2026 14:10:55
 -0800 (PST)
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
 <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com> <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
In-Reply-To: <CABdmKX0BJcsv0TaPSsGN2a4nkQaKF=cX8rnnoL5kPTHNfuKL7Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 14:10:42 -0800
X-Gm-Features: AaiRm50oJmkhv3JVc8QRZs9eNQOIt0sVOkSFuyILAnwFvxKBu7Elyj-9uDHYoK8
Message-ID: <CABdmKX0DGP9=OOPwU8WjqHnmRDfPnxoAjm8Rvy-D2GYQX0GE0A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-77633-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 102E215A932
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 11:58=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > > > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wr=
ote:
> > > > >
> > > > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > > > Currently some kernfs files (e.g. cgroup.events, memory.events)=
 support
> > > > > > inotify watches for IN_MODIFY, but unlike with regular filesyst=
ems, they
> > > > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they ar=
e
> > > > > > removed.
> > > > >
> > > > > Please see my email:
> > > > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4=
zvxylx732voet@ol3kl4ackrpb
> > > > >
> > > > > I think this is actually a bug in kernfs...
> > > > >
> > > > >                                                                 H=
onza
> > > >
> > > > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > > > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > > > and shrink_dcache_parent is called, d_walk doesn't find any entries=
,
> > > > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > > > that is...
> > >
> > > Strange because when I was experimenting with this in my VM I have se=
en
> > > __dentry_kill being called (if the dentries were created by someone l=
ooking
> > > up the names).
> >
> > Ahh yes, that's the difference. I was just doing mkdir
> > /sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
> > kernfs creates the dentries in kernfs_iop_lookup, so there were none
> > when I did the rmdir because I didn't cause any lookups.
> >
> > If I actually have a program watching
> > /sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
> > calls, but despite the prior clear_nlink call i_nlink is 1 so
> > fsnotify_inoderemove is skipped. Something must be incrementing it.
>
> The issue was that kernfs_remove unlinks the kernfs nodes, but doesn't
> clear_nlink when it does so. Adding that seems to work to generate
> IN_DELETE_SELF and IN_IGNORED. I'll do some more testing and get a
> patch ready.

This works for the rmdir case, because
vfs_rmdir->shrink_dcache_parent->shrink_kill->__dentry_kill is invoked
when the user runs rmdir.

However the case where a kernfs file is removed because a cgroup
subsys is deactivated does not work, because it occurs when the user
writes to cgroup.subtree_control. That is a vfs_write which calls
fsnotify_modify for cgroup.subtree_control, but (very reasonably)
there is no attempt made to clean up the dcache in VFS on writes.

So I think kernfs still needs to generate fsnotify events manually for
the cgroup_subtree_control_write->cgroup_apply_control_disable case.
Those removals happen via kernfs_remove_by_name->__kernfs_remove, so
that would look a lot like what I sent in this v3 patch, even if we
also add clear_nlink calls for the rmdir case.

