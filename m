Return-Path: <linux-fsdevel+bounces-78393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNCWD1Y6n2m5ZQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:07:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D901819C02B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 19:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01A3E306240F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC22E92BA;
	Wed, 25 Feb 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h23vggha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DD2E3397
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042814; cv=pass; b=MUr+6Dp9Rvo+tM4zlg2EYLlP+5Zkup9Oythf2EDFsGpEuFbwykuv4ck5Wwhzok4/GsAQtjl/raDoyawvhY8BsgXd+NUpGwXDn/CkS+00OfROqz3vOKJnoHXiWA6GgCql03oUUPZFKLAgi9oW1S0vCvBz+FnOZR1FTpb/JJNrwy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042814; c=relaxed/simple;
	bh=TzgLgttUfoooDP59brZgB7vPztreASd8bY+M1SKug3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVWEGyA9PH+6Din8kkXcZoOflnG7zull2AclRwhmHaXsH+JYlOnKcrlos3amtYNICFobHcYNz7/l6Gfy1j+W1Oi6BX8G+RksWzp7RG59Bqp/oylvsoFuwSiBjbQrvRsBHeholBUSrN12LKRJh+2SOzyYpPuytTFSUTmoHEL/RcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h23vggha; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so1143716666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 10:06:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772042811; cv=none;
        d=google.com; s=arc-20240605;
        b=jSReaz8OkOEV76ErYaQvdoaguCCvic5omvR9pr9f8hf2I14GZcjqLvyEpsC9B9h0AU
         ECrOKNslWXipgAapK+YNeFIzs5PuTcRiAD+/vMGENuK8lxtU388BlDVFvvarGJIZ37n/
         J2werGmV/X+YoBJBvKSV3xBybiGY8ULs2+bInU+cTvmNLTg01KK7CGciJt8gjnigQ4VK
         J7a6rZ+wzLwFWBA4aFMFfiidcUNbF+dv+Xmu/ciSZQRnjD8uREhMyIEa8JBaXxobRSST
         yE3vVL2geKQIug2xkiNLpUsHssvwf1GykEPUvzahu/8Q/y6ZJLGUri5ljL57oPnam6pL
         BOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qd/2ikqix4XgntJaRLRNkJWCVvNPm+XdJfVzSZI1yZA=;
        fh=Lg5uidN42aOw9jhe/tlCcQEiF9ls/yNgK+l0UhujlBo=;
        b=gW96jB9G3xCRzwieOFM96P3mxT3ur0TFdO2eVhBirMR7u3iRuyg1XEcG+CdpD/oJ7j
         qM2rsAE861BKtiagINSPZZhBtrrp8xLaEe9nBmsdUI/TKfXbrQc7sZRj64nWGdKlR7aK
         szB6utV6TX1FfnlbGc6+G3JNR2ZZdAs1+SECtV9ZfC9TUK4JwuNsr+zoVm/MjHH4y/b1
         0fub9h9ErZ6QFPKyx3Dw6mQyQhIvYru0yyIJshc1uDqMugU9zwqgCD8bLeqgkjUYwzUl
         5xj+wey9/6F5GAl6fAoRiubHnf9M8qjGA6D+DaJFDhN1Z1x8gJAZCcc1l6y/prLyICbA
         l6Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772042811; x=1772647611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd/2ikqix4XgntJaRLRNkJWCVvNPm+XdJfVzSZI1yZA=;
        b=h23vgghauwCnVcduplwzIDQb32tSvnnfM3h7nwMCweinLnKGGGG3JIfBbz+46b0DtJ
         UcBz/hsIuI2O3pRFgTBNs7c+LWzag3BkfIIKBkHwh3MiyDbuMb3aqj6LC1xaJrucgtbL
         cDODTLV4mFMbPViIv1K6FuAJwWf+j109FHfTz2s2w/YOFpl3Uf7ZJVvQnV2GlWxi1VgX
         R55ZCBu+IYvH8Q3J0TVZXYirUrRiyb3hW/4FOPxe68jPp3MJjhcQ+LVmnOloWoAoimoi
         eiOB1BxZDnd4SYjvUROYRIIHJmp5fBH/C6mIcCZeWxaui2AyhlJoD8OJPetk+6srAFoJ
         ynXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042811; x=1772647611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qd/2ikqix4XgntJaRLRNkJWCVvNPm+XdJfVzSZI1yZA=;
        b=sAcKg/pNWGPKAdGbEPw/fL7O9go5rlLXU9XCjIbdOzjTv7TKEkZBLke8K+0Qog7yF/
         Yyg2ChQOWbJmfTgSJ89665H7aQ/RbQm9tKet+Zx3dKDmV/KLYpaYsxZjR/WxdWYikNa/
         WpV4ggkWwTdb92y0LkUZRs5ahtWA2Y0CL27lwdYaDJZ8b/jNB9nJBP5dlz0xeHFv2GLB
         fhQHLSN8+brt3JSKkIiUvFnsZIk3sd5+bfLpSaWlszNqkE2tddsP0qtbXjvSJGgNnQ3b
         OooxmbJZbeQYHabkTRh++DQETsSOjlr2t++/ieiUVYXtzkktfMrbR7qohi/QzZEl4gCQ
         AbSg==
X-Forwarded-Encrypted: i=1; AJvYcCUKcCIX7gbhJ+quKzky9XSfMcfEQyUsBrVDqSUzE9GVFzLJ04pTTZRXjQVpGFGMO8RXZsPvEhLNKDJ6Lj0E@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmCtklcn5RB7Zp118GlSn9y6UzJHrbqUY+XFnYHUGAYzk/4Ts
	euEVYJwMKqOAWwD6SHwROk9wmCJN8dj1q4ZLebpv7svxImDNhmVAvRK60C6vCKWq+ft97Di/8P1
	4wxLBVDLmlejwRq6SCld0aT6+vFzmZ/jdAWMEapY=
X-Gm-Gg: ATEYQzxdLkt/8CNUiPHQfYeJRXJOhHC4IG66Lh/J5AvAGf/fKtK8DKET7pO4aP8apq+
	fRxqNpPNOmP9siyYZWWOTidECmajDEIHXIKX1uKelFOJreE96P3aHsdWETURNqnMiS0vQMWAHGZ
	3XEx0vYc0DIBv8V54mo9vGcQKfCcGK50y41SInEAwbRqEbXazpvM8ypas6lrpw0/5CLPrJi27bW
	ux9m9FrAKsTrql6CS3E8VsTZ8tUMwosSsL6OZ50yiXhJ+dTCE0FVTnVk06wcelksRO0RQdeH4R2
	3IgWthahy2ufyg+Tp/MJ9VUYbpuE7TShMintLOodog==
X-Received: by 2002:a17:906:9f96:b0:b8e:796a:fd5e with SMTP id
 a640c23a62f3a-b93517c158emr75235966b.51.1772042811064; Wed, 25 Feb 2026
 10:06:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
In-Reply-To: <20260225112439.27276-7-luis@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Feb 2026 19:06:39 +0100
X-Gm-Features: AaiRm50JxTlwMwFRqlAlSLMydOt8FyoIJbT7VNCWhnk3Xw5sFFnjTlOMgDTNM6g
Message-ID: <CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78393-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,ddn.com,bsbernd.com,kernel.org,gmail.com,vger.kernel.org,jumptrading.com,igalia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: D901819C02B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:25=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:
>
> The implementation of lookup_handle+statx compound operation extends the
> lookup operation so that a file handle is be passed into the kernel.  It
> also needs to include an extra inarg, so that the parent directory file
> handle can be sent to user-space.  This extra inarg is added as an extens=
ion
> header to the request.
>
> By having a separate statx including in a compound operation allows the
> attr to be dropped from the lookup_handle request, simplifying the
> traditional FUSE lookup operation.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
>  fs/fuse/fuse_i.h          |  23 ++-
>  fs/fuse/inode.c           |  48 +++++--
>  fs/fuse/readdir.c         |   2 +-
>  include/uapi/linux/fuse.h |  23 ++-
>  5 files changed, 355 insertions(+), 35 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5c0f1364c392..7fa8c405f1a3 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -21,6 +21,7 @@
>  #include <linux/security.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> +#include <linux/exportfs.h>
>
>  static bool __read_mostly allow_sys_admin_access;
>  module_param(allow_sys_admin_access, bool, 0644);
> @@ -372,6 +373,47 @@ static void fuse_lookup_init(struct fuse_args *args,=
 u64 nodeid,
>         args->out_args[0].value =3D outarg;
>  }
>
> +static int do_lookup_handle_statx(struct fuse_mount *fm, u64 parent_node=
id,
> +                                 struct inode *parent_inode,
> +                                 const struct qstr *name,
> +                                 struct fuse_entry2_out *lookup_out,
> +                                 struct fuse_statx_out *statx_out,
> +                                 struct fuse_file_handle **fh);
> +static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *=
attr);
> +static int do_reval_lookup(struct fuse_mount *fm, u64 parent_nodeid,
> +                          const struct qstr *name, u64 *nodeid,
> +                          u64 *generation, u64 *attr_valid,
> +                          struct fuse_attr *attr, struct fuse_file_handl=
e **fh)
> +{
> +       struct fuse_entry_out entry_out;
> +       struct fuse_entry2_out lookup_out;
> +       struct fuse_statx_out statx_out;
> +       FUSE_ARGS(lookup_args);
> +       int ret =3D 0;
> +
> +       if (fm->fc->lookup_handle) {
> +               ret =3D do_lookup_handle_statx(fm, parent_nodeid, NULL, n=
ame,
> +                                            &lookup_out, &statx_out, fh)=
;
> +               if (!ret) {
> +                       *nodeid =3D lookup_out.nodeid;
> +                       *generation =3D lookup_out.generation;
> +                       *attr_valid =3D fuse_time_to_jiffies(lookup_out.e=
ntry_valid,
> +                                                          lookup_out.ent=
ry_valid_nsec);
> +                       fuse_statx_to_attr(&statx_out.stat, attr);
> +               }
> +       } else {
> +               fuse_lookup_init(&lookup_args, parent_nodeid, name, &entr=
y_out);
> +               ret =3D fuse_simple_request(fm, &lookup_args);
> +               if (!ret) {
> +                       *nodeid =3D entry_out.nodeid;
> +                       *generation =3D entry_out.generation;
> +                       *attr_valid =3D ATTR_TIMEOUT(&entry_out);
> +                       memcpy(attr, &entry_out.attr, sizeof(*attr));
> +               }
> +       }
> +
> +       return ret;
> +}
>  /*
>   * Check whether the dentry is still valid
>   *
> @@ -399,10 +441,11 @@ static int fuse_dentry_revalidate(struct inode *dir=
, const struct qstr *name,
>                 goto invalid;
>         else if (time_before64(fuse_dentry_time(entry), get_jiffies_64())=
 ||
>                  (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TAR=
GET))) {
> -               struct fuse_entry_out outarg;
> -               FUSE_ARGS(args);
>                 struct fuse_forget_link *forget;
> +               struct fuse_file_handle *fh =3D NULL;
>                 u64 attr_version;
> +               u64 nodeid, generation, attr_valid;
> +               struct fuse_attr attr;
>
>                 /* For negative dentries, always do a fresh lookup */
>                 if (!inode)
> @@ -421,35 +464,36 @@ static int fuse_dentry_revalidate(struct inode *dir=
, const struct qstr *name,
>
>                 attr_version =3D fuse_get_attr_version(fm->fc);
>
> -               fuse_lookup_init(&args, get_node_id(dir), name, &outarg);
> -               ret =3D fuse_simple_request(fm, &args);
> +               ret =3D do_reval_lookup(fm, get_node_id(dir), name, &node=
id,
> +                                     &generation, &attr_valid, &attr, &f=
h);
>                 /* Zero nodeid is same as -ENOENT */
> -               if (!ret && !outarg.nodeid)
> +               if (!ret && !nodeid)
>                         ret =3D -ENOENT;
>                 if (!ret) {
>                         fi =3D get_fuse_inode(inode);
> -                       if (outarg.nodeid !=3D get_node_id(inode) ||
> -                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (outar=
g.attr.flags & FUSE_ATTR_SUBMOUNT)) {
> -                               fuse_queue_forget(fm->fc, forget,
> -                                                 outarg.nodeid, 1);
> +                       if (!fuse_file_handle_is_equal(fm->fc, fi->fh, fh=
) ||
> +                           nodeid !=3D get_node_id(inode) ||
> +                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (attr.=
flags & FUSE_ATTR_SUBMOUNT)) {
> +                               fuse_queue_forget(fm->fc, forget, nodeid,=
 1);
> +                               kfree(fh);
>                                 goto invalid;
>                         }
>                         spin_lock(&fi->lock);
>                         fi->nlookup++;
>                         spin_unlock(&fi->lock);
>                 }
> +               kfree(fh);
>                 kfree(forget);
>                 if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR)
>                         goto out;
> -               if (ret || fuse_invalid_attr(&outarg.attr) ||
> -                   fuse_stale_inode(inode, outarg.generation, &outarg.at=
tr))
> +               if (ret || fuse_invalid_attr(&attr) ||
> +                   fuse_stale_inode(inode, generation, &attr))
>                         goto invalid;
>
>                 forget_all_cached_acls(inode);
> -               fuse_change_attributes(inode, &outarg.attr, NULL,
> -                                      ATTR_TIMEOUT(&outarg),
> +               fuse_change_attributes(inode, &attr, NULL, attr_valid,
>                                        attr_version);
> -               fuse_change_entry_timeout(entry, &outarg);
> +               fuse_dentry_settime(entry, attr_valid);
>         } else if (inode) {
>                 fi =3D get_fuse_inode(inode);
>                 if (flags & LOOKUP_RCU) {
> @@ -546,8 +590,215 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
>         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->siz=
e);
>  }
>
> -int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qs=
tr *name,
> -                    u64 *time, struct inode **inode)
> +static int create_ext_handle(struct fuse_in_arg *ext, struct fuse_inode =
*fi)
> +{
> +       struct fuse_ext_header *xh;
> +       struct fuse_file_handle *fh;
> +       u32 len;
> +
> +       len =3D fuse_ext_size(sizeof(*fi->fh) + fi->fh->size);
> +       xh =3D fuse_extend_arg(ext, len);
> +       if (!xh)
> +               return -ENOMEM;
> +
> +       xh->size =3D len;
> +       xh->type =3D FUSE_EXT_HANDLE;
> +       fh =3D (struct fuse_file_handle *)&xh[1];
> +       fh->size =3D fi->fh->size;
> +       memcpy(fh->handle, fi->fh->handle, fh->size);
> +
> +       return 0;
> +}
> +
> +static int fuse_lookup_handle_init(struct fuse_args *args, u64 nodeid,
> +                                  struct fuse_inode *fi,
> +                                  const struct qstr *name,
> +                                  struct fuse_entry2_out *outarg)
> +{
> +       struct fuse_file_handle *fh;

Considering that fuse has long used uint64_t fh as the convention
for a file id all over the code, it would be better to pick a different
convention for fuse file handle, perhaps ffh, or fhandle?

> +       size_t fh_size =3D sizeof(*fh) + MAX_HANDLE_SZ;

I don't remember what we concluded last time, but
shouldn't the server request max_handle_sz at init?
This constant is quite arbitrary.

> +       int ret =3D -ENOMEM;
> +
> +       fh =3D kzalloc(fh_size, GFP_KERNEL);
> +       if (!fh)
> +               return ret;
> +
> +       memset(outarg, 0, sizeof(struct fuse_entry2_out));
> +       args->opcode =3D FUSE_LOOKUP_HANDLE;
> +       args->nodeid =3D nodeid;
> +       args->in_numargs =3D 3;
> +       fuse_set_zero_arg0(args);
> +       args->in_args[1].size =3D name->len;
> +       args->in_args[1].value =3D name->name;
> +       args->in_args[2].size =3D 1;
> +       args->in_args[2].value =3D "";
> +       if (fi && fi->fh) {

Same here fi->ffh? or fi->fhandle


> +               args->is_ext =3D true;
> +               args->ext_idx =3D args->in_numargs++;
> +               args->in_args[args->ext_idx].size =3D 0;
> +               ret =3D create_ext_handle(&args->in_args[args->ext_idx], =
fi);
> +               if (ret) {
> +                       kfree(fh);
> +                       return ret;
> +               }
> +       }
> +       args->out_numargs =3D 2;
> +       args->out_argvar =3D true;
> +       args->out_argvar_idx =3D 1;
> +       args->out_args[0].size =3D sizeof(struct fuse_entry2_out);
> +       args->out_args[0].value =3D outarg;
> +
> +       /* XXX do allocation to the actual size of the handle */
> +       args->out_args[1].size =3D fh_size;
> +       args->out_args[1].value =3D fh;
> +
> +       return 0;
> +}
> +
> +static void fuse_req_free_argvar_ext(struct fuse_args *args)
> +{
> +       if (args->out_argvar)
> +               kfree(args->out_args[args->out_argvar_idx].value);
> +       if (args->is_ext)
> +               kfree(args->in_args[args->ext_idx].value);
> +}
> +

Just wanted to point out that statx_out is > 256 bytes on stack
so allocating 127+4 and the added complexity of ext arg
seem awkward.

Unless we really want to support huge file handles (we don't?)
maybe the allocation can be restricted to fi->handle?
Not sure.

Thanks,
Amir.

