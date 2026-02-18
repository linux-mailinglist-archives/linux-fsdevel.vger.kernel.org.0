Return-Path: <linux-fsdevel+bounces-77610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGkeBO0Plmk8ZgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:15:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66071158F7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE8F33023363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C3347BA3;
	Wed, 18 Feb 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0ibvlJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B41E1C3BFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442145; cv=pass; b=CKjWp8OgpfKDjRcjKJ9NTWL3Xpc4iqQmznImiENDCWJaCUUGiJ5fmuxRiXv9+QyAVDDqqLKIN4yoaN6OiaUbDWCsq67imr7EzDsXnCmZ1U3S3U5PF47qNetCZfwfMZE+/KTS3va+o/R7C/qKPzylQ+Ttz67Bsl35BS3vEpB279w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442145; c=relaxed/simple;
	bh=wBFNCt7xEGs0VQ8C7Z13cB9OU5SAamOgWMLc8IFwhTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZwpmfSuPHGmOvuFpMc6x9vqVvaoIIIh2TQXheTQda6MgaBzAblRoKpSDRG7CdNnEnYkQNrndHDg738L30AVbNAi6xEeqPh1Fal+3ZVtO3HNNz+cx4uQgZ7Pa1fboxdgLv4GseIyR2nZqW33vzV00JPVv4yR8GAH5AR+adRAJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0ibvlJR; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so11195e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771442142; cv=none;
        d=google.com; s=arc-20240605;
        b=aP/GtWDogLaON5+808bBX7xV7rXNlDFz7TDkrWc7dNQzw9rYVcJNfDOaI67L+RVOGs
         iShvDNe96IplptwU3ku2SH+kfMzT1lssLAzLmCJADHJYIwWRyeVUVSRsAJdekehc2IFA
         JMDPksuKnN15/+xfpSHM8VJQpUtgSKx4948Dnz8zHZMsrrbFkQ0HgCElIYr9HjnOXRQ9
         L8a7b2oFgv1A7/kRCvdGKHBfRTxydWSUA8imKK6Cmz1W0EKvQ9CtO+/44GLqaTn1CAbY
         06WPRyLalU3m/TbzRlTtoCVVi3g+h5unCyFr9hrDfwfaLJAuxhPK35/RRDzJbhObaBX4
         Q+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        fh=ReKcfBo5mzf5ZDLP5oR0zVmsN0VFXClVQJOb5JUqphI=;
        b=ORvayUVAFIR+ezbdjOi1o2S157hPAiYjqayxQN+QV9uVal+riGQG+WAW7qK/dZ/oc1
         kcima99mPDjIquWt+oc4y2lXMaRI7JUF2K/0+p6ZoksZ8Uy51Aj2PJ9CJU1VvqTZwELF
         i+lplq2oOpIj9T6oZPZFGk4XWPKt1aAgJnQoJE2ROvr9fr0OVo/lH9gYRIAOU8nZfyXL
         c6i1nU8SumlFfo89Q9rj9MafyW0i0P3J/kXJ2qzmATSr3+H4xpywqpV5bkT+M5lvNQmP
         gP5sJhNOsu7YsM0fiojvj31ShcOg6//hoi3yt6fvD4RU/2vLNLGWw4pOg4Kw5FxuGfj8
         9Agw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771442142; x=1772046942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        b=k0ibvlJRy1mVTRq7VYvbD4vaR8CC+E9EOCFYxbBvEcMiu+Tx0WEqNyYt077TVXI4yn
         Aet3xzHkFL304zxjRw0h3hq0DzVX8UgdfAHMymzQHth53T4mR8Yz1OKBwgCp/1m3+ann
         6QI/xLjsH3iGr4iGgLb+1xuFdaiEHHWGf05T2CfVH61JVQ6+17ww0WHB+9n4kSQ2J9fG
         M4eYQCasoQ1I5w/stnTD7P+A3zgag8s9G3+VD5XgSYLGN0OwNouBin3NRWee/u4WyEVf
         u6uVCTNq+2mEvXK5kybJ4rTyz6P6fn9WBz1RX9KLSV4TDumLZdYcrJqjGXej9ABFek4q
         3uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771442142; x=1772046942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        b=eM18vSJ0QucVzWL76epO9o0mrHrqiyCuA0N4VOMZwgWkL9UNqRbXH3XpdNXNZECc05
         CVCfk4+tsKStIIbvC9ftw6cwca5IB4Fh5WVHiRNQmn63LqHzO28ddzWjtUT0+fr+aoyi
         DkxRvWkOVYvc7L35uVyAxF+liIuZJIlnA8tRMj2hWN26dtF7WDhluMcqpifbDyPraznh
         TdY7wMQ3sjUyEqX29d+ikmv4nHDg5FVPqBe1tpjO55PsOJyLmandVLrJKKpnocXSXAJa
         OtwapfxRrN2cu1/MOaZoklb0Ypb8U+Nom6I9H5tOEuy9h13KGJRXXVsTRmIPjuQaJZ0X
         mKpA==
X-Forwarded-Encrypted: i=1; AJvYcCUpPAPN0wUOAmGAMz+O0Vten5FrbR2lJthkCwmtpu6x0+uJEf/bFeYwCDcIUwZBVrSE6ujyLMpmRMWkXzuB@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnlmbsAdsN/Nwpn/SvTl7zrlJgFqrVwzd5kgav7zWmT65jJHa
	2xR7xB+hNqKBBwt+XucwwPhixIcdABeN/xN62nzZtHNLCQC5dQEwlMRA7tX+T64AgiN0ngbdUyl
	zxPp9Ob4lVAK2gDsp8ITnMH3sakUmaseD9lmcr4/M
X-Gm-Gg: AZuq6aKdGCo5yQyjoaHXMdVi2IRW95M/dyq8Mr/5/nwlO0Vy61TasFX3SF7WHPQzcgb
	0hmrrlem3uVoeRk1uZhkImnpBvGyJsO2bn1d7Em4qbuGlvuDmU+s9OrZCQCElg1knrglNbpvvcH
	zYVaeE5zg1uA99Lye6f8xzhr1qFLvs929/Hv4iQDcyT/xaANdWe/xrOhuk6Bxqaeqvt+vF2AJog
	HNKznXYeQz9rJDKtTjIyMS4qOxLdFqXo7X53pRiCeNpM9uSf7eYvtU/DOwqWC3Pql43hAASJygY
	LeuI5JZZkekxZuFUjL+LrHC0WqSndiz3+nzauK8NnMUmnvq2akta7UXiCtePGvDw5sypgA==
X-Received: by 2002:a05:600d:4452:10b0:483:6a76:11a6 with SMTP id
 5b1f17b1804b1-4839e6312famr23405e9.5.1771442142133; Wed, 18 Feb 2026 11:15:42
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com> <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
In-Reply-To: <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 11:15:30 -0800
X-Gm-Features: AaiRm53wtP0XVPm7Td49NxqM3FHtwAMm9Y-nYQJjMavu1aBdzT7jkoJc9BaBFyc
Message-ID: <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-77610-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 66071158F7E
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > Currently some kernfs files (e.g. cgroup.events, memory.events) sup=
port
> > > > inotify watches for IN_MODIFY, but unlike with regular filesystems,=
 they
> > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > removed.
> > >
> > > Please see my email:
> > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxy=
lx732voet@ol3kl4ackrpb
> > >
> > > I think this is actually a bug in kernfs...
> > >
> > >                                                                 Honza
> >
> > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > and shrink_dcache_parent is called, d_walk doesn't find any entries,
> > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > that is...
>
> Strange because when I was experimenting with this in my VM I have seen
> __dentry_kill being called (if the dentries were created by someone looki=
ng
> up the names).

Ahh yes, that's the difference. I was just doing mkdir
/sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
kernfs creates the dentries in kernfs_iop_lookup, so there were none
when I did the rmdir because I didn't cause any lookups.

If I actually have a program watching
/sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
calls, but despite the prior clear_nlink call i_nlink is 1 so
fsnotify_inoderemove is skipped. Something must be incrementing it.

