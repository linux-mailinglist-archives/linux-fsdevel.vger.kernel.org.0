Return-Path: <linux-fsdevel+bounces-74960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIBoENx5cWkvHwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:14:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5A360348
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 02:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27E6E3C7813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91754654;
	Thu, 22 Jan 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDWWOFkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D233F370
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044433; cv=pass; b=SS8I9x6uriMda24OZzVSbl2P1EQfMHkTKICOKtyzO7HVo92lxMTOcdjO6nztQgBN02xFH+rw3fvwMM6Mr3a2npov74s2B2CqO6LlrClM/0laTtC6SG0sisl61FNYvXGgW3qfsIYDvDdnXHGdks1WnG3cn5JFv2zwieaNzIXPopE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044433; c=relaxed/simple;
	bh=tEX+D1g1lVttEi0BuWRhKIw4cU0gKmvwvXVwSVxX3cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkW2kBkUZPZcl88lPQmgtY5NGCkpVH2tZzS1dz1iJPk6fBH406mvEN02Az6rFkIYgePZvrwqw0r5V+HT6kDAYprkbnqCWZnjeT3Z/3zxeQqVJ0gshX5pB7JlvW98hW+Qny78ajR6gFCdxrQATBy1gYN5jKDSgKRQHR03SsT8CBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDWWOFkF; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5014b7de222so4946501cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:13:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769044430; cv=none;
        d=google.com; s=arc-20240605;
        b=V+Yd/3sxSCzYW8vImyqrSMo/3szq6LuIKuhGmz+k1iDCIbh4O8fY5aBX4HxkeBJ+VV
         KJLPJfVeEGEEBKtAng+hWs//UK4o4DCbfOHA5XqeWZa7UJsDPBw34qfc2XnxZ0MD/lBu
         lVvqI/SNI8H73mi2lu49/+y4fpwm6LBe5Rym5gcB5QK21xFR0s26vLAsrJxcdsT8upvN
         0yMaICG8P+Az9ftA/+HbZWnZE3tIiVO7r0ziE63IoI6M2f6cZD/HzIwuFL1V0yPVpE5a
         5/iR0qL5Rpd6u6I2draaAQcPtvyrjFP+vJIoWwmvMPe5ugXq03jGjaTVteGNSump0RcP
         1DuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/EqnRS4anw5ImavbzkbEqaZ3insgdpNqwRLJTI8ASjI=;
        fh=dz5xAsdeYk6YmGbF0mIl3TMamcSaUmJ1ck5J+oAGSX0=;
        b=KhULp1ZS479iUyaWR1gRkviwu5wfWvJIAz34Lc4ncGLBn2AhGQpzE7QNEYd7WtGpZZ
         wZabX/vytQG/xVpc4YFI3ooLjKNKLLrjtrQXbLyMxnGWc4OlY42HcdausbdvxFkxthpo
         iM6XtArrP+PcBWDX0PFeyLMmDswSbl+k+br0Wz1zYKYlAMhSHAOdth4nxAIqvHP+mf3+
         2NmIr1kg2ZIhjK0bupgTxePj0BURnf7ehLctHvClBrM/o0zTjV5f9Uk1xs2Fg4fxquJj
         g+yrNSpn9OYv8QM04Am2mGUTX6ig2bNbj5YB+6tffR2fM22NieQXV6llKsSzw+XFA9Q+
         tj4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769044430; x=1769649230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EqnRS4anw5ImavbzkbEqaZ3insgdpNqwRLJTI8ASjI=;
        b=aDWWOFkFL1NVfBLblQcT+DiwoKGx7PtqvODWHzC6iOAhSsOKR7+vj3LQBjvJfOB8bh
         HSPBbFAewlBJznrgvkvZgunOSSkEsbhQoQTpeI8U/fqm/piSgATJ7vHE6sFMlc1R30jf
         W+WWyHyXYZK6If5fqECwrXBmqgmrVJn8Mb7izNh++U385czIy8naBQ247H3l7Sp+Crar
         krZKN54NZmx9uB5dqWxznvCrHdSr6HN8hr9+2RH84BJO8/kwige3tjT513eF0nDGHPap
         bjxW1uZ8T/LzbtCieEPwX7Nk0ITGZe1J3ys21is3VA4fPgD2bj1dFEasKXyAIWuji2I7
         oJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769044430; x=1769649230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EqnRS4anw5ImavbzkbEqaZ3insgdpNqwRLJTI8ASjI=;
        b=GAo/4h+icqm5Wt8Je0JBYTlvhIsFLUH4dmtviKYK67JkMkTaraRWfWqwaJt+nIZX8a
         nUssvttwjfx6x6NlOlTAZqPqVgzcQhWaCvVqLm126HAjRTk7G3fyAWZthQnbBB7OuOPw
         IrvIS+vLglp7st1MGa28CWdpDNvaL24fOzumxi78TdDCMGLxW+jsu1ro+teu0Xw+4lD9
         WTgIjw6mzTrOY6Nsq1aKNcj0evVefaiofdhaJeeADsDQbtvuEcXomM3zhvPfX4PNvloG
         mmOdFFU36hzuaYb6ngfAvhphVTYtwg3G1Ec15nlkSmn3F1CgGvLAs+T3mF7Wl5M/qTBI
         d9rg==
X-Forwarded-Encrypted: i=1; AJvYcCVYbBJ4DNphk2WHWi4Dt/sbCGQf11z7WPJeFYH60HebOEGiHi42HH95HdBXSLieA9E366cIHsbTHuKmoGgf@vger.kernel.org
X-Gm-Message-State: AOJu0YzCo2SZCEjzU+Mn2vEbeliISyw7FizA3zX7QCY9W9BSfaqC8vFZ
	0Ui1c5AGCCFXoPN8oZJ6kTTQPxXoKKcex93TyKLGS+iZxyK73ctSLTyhQSp/Q0mWRtQikwCP7lS
	vvVtZwvs0jwrgK5g2Td5k+OzM/X/UH8Q=
X-Gm-Gg: AZuq6aIr4a58IYPLSVIcjkUjTaOfqNJXyJs9xdx2HzvV0iWebzgzqmIGTlpRZrEJcwR
	5f4RTwewDDfpDcWDNpJkjAlx0E0AMePYHJhJQLaHZ0nxSv0IBKpc+/TmTOjSPXt+/lUXUyKYSZ7
	mbfLLYmE2GAfH3Ziu8n2ZjinPx8uWoa21NiyEGcmIKW4wIW+6qzWCwZv/6LG+Wvz4cgNw5hQRLY
	PwpmWtmJZLfeJwphUlHQ5GDToXfEK3DB5jUjm4Vja/gv8A33qXuGYzD8A45Na90wLP92g==
X-Received: by 2002:a05:622a:1794:b0:4ee:2423:d538 with SMTP id
 d75a77b69052e-502a168803fmr228499071cf.18.1769044430101; Wed, 21 Jan 2026
 17:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 17:13:39 -0800
X-Gm-Features: AZwV_QiqZjPmBSaXwec1w5MBMkCKu72_zyL1vctkxBiIMbpDclr05tDNS-CMOA8
Message-ID: <CAJnrk1ZDeYytdjuCdg6-O-PGjcmwS33LOnfFT_YY9SPE=x=Qxw@mail.gmail.com>
Subject: Re: [PATCH 07/31] fuse: create a per-inode flag for toggling iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74960-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DB5A360348
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create a per-inode flag to control whether or not this inode actually
> uses iomap.  This is required for non-regular files because iomap
> doesn't apply there; and enables fuse filesystems to provide some
> non-iomap files if desired.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

The logic in this makes sense to me, left just a few comments below.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/fuse_i.h          |   17 ++++++++++++++++
>  include/uapi/linux/fuse.h |    3 +++
>  fs/fuse/file.c            |    1 +
>  fs/fuse/file_iomap.c      |   49 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |   26 ++++++++++++++++++------
>  5 files changed, 90 insertions(+), 6 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 839d4f2ada4656..c7aeb324fe599e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -257,6 +257,8 @@ enum {
>          * or the fuse server has an exclusive "lease" on distributed fs
>          */
>         FUSE_I_EXCLUSIVE,
> +       /* Use iomap for this inode */
> +       FUSE_I_IOMAP,
>  };
>
>  struct fuse_conn;
> @@ -1717,11 +1719,26 @@ extern const struct fuse_backing_ops fuse_iomap_b=
acking_ops;
>
>  void fuse_iomap_mount(struct fuse_mount *fm);
>  void fuse_iomap_unmount(struct fuse_mount *fm);
> +
> +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)=
;
> +void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_fla=
gs);
> +void fuse_iomap_evict_inode(struct inode *inode);
> +
> +static inline bool fuse_inode_has_iomap(const struct inode *inode)
> +{
> +       const struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       return test_bit(FUSE_I_IOMAP, &fi->state);
> +}
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
>  # define fuse_iomap_mount(...)                 ((void)0)
>  # define fuse_iomap_unmount(...)               ((void)0)
> +# define fuse_iomap_init_reg_inode(...)                ((void)0)
> +# define fuse_iomap_init_nonreg_inode(...)     ((void)0)
> +# define fuse_iomap_evict_inode(...)           ((void)0)
> +# define fuse_inode_has_iomap(...)             (false)
>  #endif
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e571f8ceecbfad..e949bfe022c3b0 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -243,6 +243,7 @@
>   *
>   *  7.99
>   *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operat=
ions
> + *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -583,9 +584,11 @@ struct fuse_file_lock {
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
>   * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
> + * FUSE_ATTR_IOMAP: Use iomap for this inode
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
>  #define FUSE_ATTR_DAX          (1 << 1)
> +#define FUSE_ATTR_IOMAP                (1 << 2)
>
>  /**
>   * Open flags
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f1ef77a0be05bb..42c85c19f3b13b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3135,6 +3135,7 @@ void fuse_init_file_inode(struct inode *inode, unsi=
gned int flags)
>         init_waitqueue_head(&fi->page_waitq);
>         init_waitqueue_head(&fi->direct_io_waitq);
>
> +       fuse_iomap_init_reg_inode(inode, flags);

imo it's a bit confusing to have this here when the rest of the
fuse_iomap_init_nonreg_inode() calls happen inside the switch case
statement. Maybe it makes sense to have this inside the switch case
like the fuse_iomap_init_nonreg_inode() calls, or alternatively move
the fuse_iomap_init_nonreg_inode() calls into their corresponding
helpers (eg fuse_init_dir(), etc.), so that it's consistent?

>         if (IS_ENABLED(CONFIG_FUSE_DAX))
>                 fuse_dax_inode_init(inode, flags);
>  }
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 1b9e1bf2f799a3..fc0d5f135bacf9 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -635,3 +635,52 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
>         fuse_flush_requests_and_wait(fc);
>         fuse_send_destroy(fm);
>  }
> +
> +static inline void fuse_inode_set_iomap(struct inode *inode)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       set_bit(FUSE_I_IOMAP, &fi->state);
> +}
> +
> +static inline void fuse_inode_clear_iomap(struct inode *inode)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       clear_bit(FUSE_I_IOMAP, &fi->state);
> +}
> +
> +void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_fla=
gs)
> +{
> +       struct fuse_conn *conn =3D get_fuse_conn(inode);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       ASSERT(!S_ISREG(inode->i_mode));
> +
> +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
> +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> +}
> +
> +void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
> +{
> +       struct fuse_conn *conn =3D get_fuse_conn(inode);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       ASSERT(S_ISREG(inode->i_mode));
> +
> +       if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
> +               set_bit(FUSE_I_EXCLUSIVE, &fi->state);
> +               fuse_inode_set_iomap(inode);
> +       }
> +}
> +
> +void fuse_iomap_evict_inode(struct inode *inode)
> +{
> +       struct fuse_conn *conn =3D get_fuse_conn(inode);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       if (fuse_inode_has_iomap(inode))

If I'm understanding this correctly, a fuse inode can't have
FUSE_I_IOMAP set on it if conn>iomap is not enabled, correct? Maybe it
makes sense to just return if (!conn->iomap) at the very beginning, to
make that more clear?

> +               fuse_inode_clear_iomap(inode);
> +       if (conn->iomap && fuse_inode_is_exclusive(inode))
> +               clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
> +}
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 271356fa3be3ea..9b9e7b2dd0d928 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -196,6 +196,8 @@ static void fuse_evict_inode(struct inode *inode)
>                 WARN_ON(!list_empty(&fi->write_files));
>                 WARN_ON(!list_empty(&fi->queued_writes));
>         }
> +
> +       fuse_iomap_evict_inode(inode);
>  }
>
>  static int fuse_reconfigure(struct fs_context *fsc)
> @@ -428,20 +430,32 @@ static void fuse_init_inode(struct inode *inode, st=
ruct fuse_attr *attr,
>         inode->i_size =3D attr->size;
>         inode_set_mtime(inode, attr->mtime, attr->mtimensec);
>         inode_set_ctime(inode, attr->ctime, attr->ctimensec);
> -       if (S_ISREG(inode->i_mode)) {
> +       switch (inode->i_mode & S_IFMT) {
> +       case S_IFREG:
>                 fuse_init_common(inode);
>                 fuse_init_file_inode(inode, attr->flags);
> -       } else if (S_ISDIR(inode->i_mode))
> +               break;
> +       case S_IFDIR:
>                 fuse_init_dir(inode);
> -       else if (S_ISLNK(inode->i_mode))
> +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> +               break;
> +       case S_IFLNK:
>                 fuse_init_symlink(inode);
> -       else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> -                S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> +               break;
> +       case S_IFCHR:
> +       case S_IFBLK:
> +       case S_IFIFO:
> +       case S_IFSOCK:
>                 fuse_init_common(inode);
>                 init_special_inode(inode, inode->i_mode,
>                                    new_decode_dev(attr->rdev));
> -       } else
> +               fuse_iomap_init_nonreg_inode(inode, attr->flags);
> +               break;
> +       default:
>                 BUG();

Just thinking out loud here and curious to hear whether you like this
idea or not: another option is calling

if (conn->iomap)
    fuse_iomap_init_inode();

at the end, where fuse_iomap_init_inode() would be something like:

void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
{
    struct fuse_inode *fi =3D get_fuse_inode(inode);

    if (attr_flags & FUSE_ATTR_IOMAP)
          set_bit(FUSE_I_EXCLUSIVE, &fi->state);

    if (S_ISREG(inode->i_mode))
            fuse_inode_set_iomap(inode);
}

which seems simpler to me than having both
fuse_iomap_init_nonreg_inode() and fuse_iomap_init_reg_inode()
function and invoking it per i_mode case.

Thanks,
Joanne

> +               break;
> +       }
>         /*
>          * Ensure that we don't cache acls for daemons without FUSE_POSIX=
_ACL
>          * so they see the exact same behavior as before.
>

