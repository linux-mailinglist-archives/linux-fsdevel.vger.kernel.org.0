Return-Path: <linux-fsdevel+bounces-77748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPmAFfSMl2lv0QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:21:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4161631D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE0F3042274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2632B9B2;
	Thu, 19 Feb 2026 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KgC4+ou/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348F2EC54C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539674; cv=pass; b=VXqB51iEe8/6OifG0XnCKw4P4ctEyOm1HgXp9xg72BTzQhBZ9yG3r8uoejYOGwuGt1tMWDln9eQxmTonnWKUuLyaDA+VkPJCmpR43T56td/Sp0eH1W1r8+k2MzLEB4IWj+EJENWFiwkZeAe3ayN0u4cP9RFVuayEkCGeEcXiE3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539674; c=relaxed/simple;
	bh=wowk2ufSHQecDFQjYYkrX5YR3rZgdfDGin5E0dyvKbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcXKMvREPDvvJ+siG6sOl0Vw+7RbyR+4Dc0ldWfBGLLy9+/7vB9O0+brgPJHoqiyz3JlbluG1Eexp3duwZGa6bf0yjeD9mN7H4VRn20S9UaRouP0DyRbm03jtTJze6AafivYnkc+efHguXYVewumhRPAi0Wkw8B2ZP8qK36w4qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KgC4+ou/; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a871daa98fso9184175ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 14:21:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771539671; cv=none;
        d=google.com; s=arc-20240605;
        b=g+RrwFBwqPXweU0A4/aMaM9KjwN2kZo/XApfOa7EBa461ycXXuo4RfbsQgodFiF6fd
         frdjpuIUC2S1XNZw1Dl4k/IvWaTxz0xUYo+ih1gDnuaJBam9jjiM8Zq44PaGu5qWJkRf
         KHCL4MmW06VtmtuY6OUcab1rs/m9XJlOnGj5kMbvw7q34OPwOvwHAP++R9NUgmXzeuqH
         HFD+bZcNtEDRjeMLod6+/ex6WplJGRhVroJ743F25PZ9wdunERBXscwvoHL5MVAKWaL5
         rzudq+JTt45s/9iARzC65EnjxSGgo25dNfLvdpFg1g44LvKfe9jf+YcHKDQn3eLQbbfq
         Nfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        fh=nbXN8xgKsFBYIH+LDYSbm3uc6FPSk4BTneQUmBipMX8=;
        b=dQR/q1NoXiJfk35A4Bi9O7ZxGGQHepzXiMlUVRL4jCJ8MfhsQ+63IajQawh+KcrCTJ
         kOHm1fWPXzYkE8thF831icswtnlgQ7ixlvqSkTrNvz0WsNTmoB12bSJyQNhSeM2v91Ki
         QU/TsR536ywlkuBjfl+yH3nNesbvFQv5CmzmLisk08mfHgmLfGlCD8tNcJynmMjiptvF
         nVJ4PEr1XYn+WI9raDCdUPQhlk0g/bbJ09V9GReHM9RH9p8jEmaCNV+T+WcJLeJCfSp8
         DaoAnQaXMgt173Valg1GZ4EbXjqD8GLnKqdQGK1DUndWq6pUsSEeO8NeWLNvQG76YcqB
         BOvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771539671; x=1772144471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        b=KgC4+ou/pZ1wsCyJC1XjcA3yDoNZz2fK1nFbxLcqAp0tbqBNnd3C4NRPMGqa2Fv9Lp
         pBtEqj8UkkzL1JVsTaPuk15B/SBNoUDdF3hY40h8C8WH/GvmJKV2YFWIYyOMzPHK8Z6f
         uedyTBXidFJpCheTZITbGA9G1h+p0den5uNCTlP9rP4yK4aXdMdxli4wM+rBiAaVjwLz
         x0GxoZ8XXW6kGz+Kf2Lf6+PJIxs5VQdU132DU5TihaXyizY1EvArj2tPHmeqNINJBuB0
         gYo+lirxvz8JdlEodvwHPXYdOEUOxuXjeIFbQl5wijOCgN2CJ3L5vDFX/ihUMiVeIipz
         X1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771539671; x=1772144471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqD/hmWCO/g7QzjyQSEKC17b3zjerA61fNbfTiWAe3A=;
        b=h0D6H4CA+a7uvKq+gY6qdASR6jMbnjQHmdJjoEyMmYthfgbOuPfJMsnwo9CCreJKxX
         voBSJhGP8RHwqFTMC6MSZcfdfIMHG+Sh+9rjF7CMO+fMxuqoYbAPTmjuxD1JksJi5Sq8
         3KH/hM0DOZU95uJhatrw9UvKyNGqlCeIgX2CEsOnYUDeiYY4XK0rHHioAFdL+zoRU1XZ
         E94601dveBIb7C6nzpP9RydMZIsSOSBgjrGC+BpGCaY7kFcB5aYMG3VCFVI1H3OKFMty
         DWDTnHOh2qPCJoI8wQQ4Kqkfa5dlcSCZpheVnjvxPDrmOh68oPNxN5to2WpU3wErIoIG
         SMWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZl+3arBPLHLu05KvpXnOBWwQ+zyyo3SxykKv4mlCbEgjNbVU5BELwC+54dMemXV5JFk4qstVMhm7WQ50R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87eZYOjIVe/qy/3/9nl5HWKyS5iKqpFsiReZLATQXObKGqXIS
	qEjIBrxu+UHQ/U1lcbBkg7fpjjQg4IFXtjUe7nOf/gQ93nK4nq3oJnQqwuhTLIGXLsD0vfBf8v2
	a5kUD/p6brCOFZwM8+LyoxuQA4oYGojVazM/Zr5T3
X-Gm-Gg: AZuq6aLxKX6odC2ZxcDojzjsl+Ppb7TPctDfNUz3v2eY2aepMTQpV1QMKQ3OrFUAXZX
	2Fh9Gg6Uj6QVtQitDeI3PQDLsvgcRu0E6AHsp+GsY1f0wgHSTPQZHtj5AL7+Jw6vOYC/lierwl6
	0xF8XTfPaV1BTbZ/Nk1fxymtUM3duL4BVvaZpB77SPdEJRe+AZvyUiGyYKvm5sd9WtyrL4Mdz2B
	CDPwueL5tKCqitt9Y6xpyjMnaeIyB/0S/4YuitullZBWxU8zwAJiSSPCZrykDXDgJ8GluGR4bJW
	Mb4w0jQ=
X-Received: by 2002:a17:902:d50a:b0:2a9:4c2:e47 with SMTP id
 d9443c01a7336-2ad1759d351mr213955245ad.56.1771539671248; Thu, 19 Feb 2026
 14:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206201918.1988344-1-longman@redhat.com> <20260212180820.2418869-2-longman@redhat.com>
In-Reply-To: <20260212180820.2418869-2-longman@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 17:20:59 -0500
X-Gm-Features: AaiRm50N0R25gsfn0vpcilKZY1vgm9wjILm5OJyUYNaP67DJtz5hnb-dhbNc_ts
Message-ID: <CAHC9VhTA+b1sdg88o1wXgMUcPDpxd_nQYc-aPEcBuzUuNVz+ag@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] fs: Add a pool of extra fs->pwd references
 to fs_struct
To: Waiman Long <longman@redhat.com>
Cc: Eric Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, 
	Richard Guy Briggs <rgb@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77748-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,paul-moore.com:url,paul-moore.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC4161631D4
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 1:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> When the audit subsystem is enabled, it can do a lot of get_fs_pwd()
> calls to get references to fs->pwd and then releasing those references
> back with path_put() later. That may cause a lot of spinlock contention
> on a single pwd's dentry lock because of the constant changes to the
> reference count when there are many processes on the same working
> directory actively doing open/close system calls. This can cause
> noticeable performance regresssion when compared with the case where
> the audit subsystem is turned off especially on systems with a lot of
> CPUs which is becoming more common these days.
>
> A simple and elegant solution to avoid this kind of performance
> regression is to add a common pool of extra fs->pwd references inside
> the fs_struct. When a caller needs a pwd reference, it can borrow one
> from pool, if available, to avoid an explicit path_get(). When it is
> time to release the reference, it can put it back into the common pool
> if fs->pwd isn't changed before without doing a path_put(). We still
> need to acquire the fs's spinlock, but fs_struct is more distributed
> and it is less common to have many tasks sharing a single fs_struct.
>
> A new set of get_fs_pwd_pool/put_fs_pwd_pool() APIs are introduced
> with this patch to enable other subsystems to acquire and release
> a pwd reference from the common pool without doing unnecessary
> path_get/path_put().
>
> Besides fs/fs_struct.c, the copy_mnt_ns() function of fs/namespace.c is
> also modified to properly handle the extra pwd references, if available.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/fs_struct.c            | 26 +++++++++++++++++++++-----
>  fs/namespace.c            |  8 ++++++++
>  include/linux/fs_struct.h | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 6 deletions(-)

...

> diff --git a/fs/namespace.c b/fs/namespace.c
> index c58674a20cad..a2323ba84d76 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -40,6 +41,33 @@ static inline void get_fs_pwd(struct fs_struct *fs, st=
ruct path *pwd)
>         read_sequnlock_excl(&fs->seq);
>  }
>
> +/* Acquire a pwd reference from the pwd_refs pool, if available */
> +static inline void get_fs_pwd_pool(struct fs_struct *fs, struct path *pw=
d)
> +{
> +       read_seqlock_excl(&fs->seq);
> +       *pwd =3D fs->pwd;
> +       if (fs->pwd_refs)
> +               fs->pwd_refs--;
> +       else
> +               path_get(pwd);
> +       read_sequnlock_excl(&fs->seq);
> +}
> +
> +/* Release a pwd reference back to the pwd_refs pool, if appropriate */
> +static inline void put_fs_pwd_pool(struct fs_struct *fs, struct path *pw=
d)
> +{
> +       bool put =3D false;
> +
> +       read_seqlock_excl(&fs->seq);
> +       if ((fs->pwd.dentry =3D=3D pwd->dentry) && (fs->pwd.mnt =3D=3D pw=
d->mnt))
> +               fs->pwd_refs++;
> +       else
> +               put =3D true;
> +       read_sequnlock_excl(&fs->seq);
> +       if (put)
> +               path_put(pwd);
> +}

This is a nitpick, and perhaps I'm missing something, but I think you
could skip the local 'put' boolean by setting 'pwd' to NULL in the
pool case, e.g.

static inline void put_fs_pwd_pool(fs, pwd)
{
  read_seqlock_excl(&fs)
  if (fs =3D=3D pwd) {
    fs->pwd_refs++
    pwd =3D NULL
  }
  read_sequnlock_excl(&fs)
  if (pwd)
    path_put(pwd)
}

--=20
paul-moore.com

