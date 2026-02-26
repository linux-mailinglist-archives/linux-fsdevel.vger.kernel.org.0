Return-Path: <linux-fsdevel+bounces-78461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYrAf0boGmzfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:10:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE01A40CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75475301E3C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF13A1E76;
	Thu, 26 Feb 2026 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+h/IgSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349163A4F40
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100502; cv=pass; b=dA4/4UgTWYrLbMJoxZxELJ9BUvwwiN+X4P6DSvbHw2ucuZ5wZsuTXVeQmKXJkgl2i2Q6BglJ2Opv10Wvizd0Sm8s9/dGzNc02zrb7ItOXHPASPk1Dl0f9v8Wt+eRFTkxP/3Yf1ftkFcX6hDPI3Aew4Gq873aKDMUG/fjCpAWPOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100502; c=relaxed/simple;
	bh=gZLRYl7VqTB3PFmvUxetzE15rYH57w9NYK0yeQxsjzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs+hSaqy0ESPoMRKfCzb321YAIeSdd57U1YZHjSMz7pCCwiGYVmuYQQdsM/5TrI4eD2aWc0jy2xv9n4FtxcP2U8IORUCc/uVawMRJz7N41jMhYjweKnaUu3ctJFjKwdICH5mz/Vm3Wqxw4OeAV0+ASBC30ao2ULWVDcYwy4uI/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+h/IgSo; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so91691166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 02:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772100494; cv=none;
        d=google.com; s=arc-20240605;
        b=SWZWsI4a7upoPXTPyFboxjNsTkIvYS+Jiv23RKCG0VSolPnA4NGnj4In+Ow0576R4i
         vRpQefrzD+bq0IPKTj6+x8tuUP6M/fYu/mAw8dY2rvjEOGKLLZgjsFXh68BKC/zWDJ9B
         NDXoVb9/z/flo2w/BkTpuAdfveDRsajdjjBdqcyqCjFB5B34cMzOnVGa1R38Z5z4MUYu
         CCzPKyEX4dM4bmFSNmU/12zSG+ls3pmktjdWaPX8JNsDbfUeOxj6rvmiNpmX5bCXfrDi
         0m62O+0OSIDCO+8v1Hg6A3MYCp4k3IbWxYwosBfJNUypToR6yQP49VRdYap5TzrdQ1eg
         iL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dzPf5ntVNcQWCYru7CrebhGIkroyXfoeSMPEijOJwb4=;
        fh=jKqa3GHSSIJnKh06XNKDT2gMWT3nSK9W/gt1gOsG4FA=;
        b=JCCVre/eLVy7QuQWZve3A+s1zhPR8Zcqf6vmroeTxSvd/tF6UT3Pt+yDyC9XXvS3j4
         XfMWv6JNFnR0FGhABOmH5OYj3FCfNI49ywtcHAjqUOErlm+9e54awBsUhlm0OUYaAFSN
         nnLvqcL0uuv/UixDwROK4x6uVV9B0Ynv5z/LLOa6rpfA5DzlM/1woGq8jNeIiOjQXSrh
         ekvZhr/FFT8A/NNsXU7rkCI3JTaXwsJ793kkg+BdIu2hiev2iEthokZyFVhm+FeOT2ii
         /9xM4lX2n9SxQev1Z+yNd2Jvx1+WC3kpmoSdSVVfZw7Q93u3IYdUEQvbWu2RGaaVtJtH
         3jtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772100494; x=1772705294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzPf5ntVNcQWCYru7CrebhGIkroyXfoeSMPEijOJwb4=;
        b=U+h/IgSoQ+TRlEOVwqtzVMxpfPeLkFYWZftn3DWcFE+GqyvW/QLhpFYbErpNowzCuY
         sCtIP2r9uFwYYBsw56JHTi4TmQwGzcOPxcPl3F6LK8usvd5euIislkLd0368aMRtr9mH
         4hFdl9l+sGxn5jBAqTVSNNDaoODh5j5bK41r/OiSmSYf3JPgroWbIK3JYgpY85QNCjsB
         f4op5V/6zMXnsRlIAP0TfhLjOGvrClQj60xiHZ3CFGJOBS7c0xkGRsOEu1nFUQD0l6Ns
         vLPX3Xsn4A1MKp3vfYTYjIZhIaqDmtvuCpAe58nnOXJWrk7vcfbBCTuwO0O1iclQdkUJ
         uSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772100494; x=1772705294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzPf5ntVNcQWCYru7CrebhGIkroyXfoeSMPEijOJwb4=;
        b=BTqW2xLRVtJib7MKTXMwhZhMonayvARPB3sWeGwXRbirPhQB1g4vgHdkR1Wq168SC5
         Lk6zhkbxSgltYoQa1axk9fH/3bJEoUsDx7EEqiCmNYNNno/h1p1cRXFpznHWcXr+jNPh
         9PtRU/tyXLimYFHv9d202SF6DFXIPLxxLj9XFiSGuS5pg2OdK1GZL4We4/jXvLFa+ond
         Tsc1ZHgCR75pm+PWm0mt78aZxvodyIamhfS4kznjQCoga9kTbV7bFoUiI0nkogGW7rbK
         helVuv2IR5r2IbQ72SCoMLnAMD2NbbqyIG0X/FpWPr3QGkCiCxdpZ9ZwEYBGE3X1mEU0
         tEZA==
X-Forwarded-Encrypted: i=1; AJvYcCVYbGZdDrk910AdER6mvvHCZPxElBBteVG++9mB+Ub0qAEYgRDarrx0/wlEaa//+GUev7eX5TnATnfC0eZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdsrk2HCUlyPKC59x8Q3VDJWd6NFfpV7RAuWeUOsmVC+X1IVhE
	JRqkyi1m+smj221UZs683Nd00PqEqyFhzUV9iptNXCag3pqCujRWLlM/ANPH/S1T1KnNIL+YgnJ
	KqcEzuq3KPYH2ZUg/kpNbhf84JQJGW+Q=
X-Gm-Gg: ATEYQzx+vp5PZLHkE88v3zg4ivQmN9E1e8yCIwELXCkLSQ61tIuIk6Dn/Mp5c+xAxpr
	30f8WoV7GxX4NsC/7kDqEEFeJEzj1hYwjX/fpNVTfUh665HM0RRzDgrmooCJv9glSC6iaGbdZOW
	f9QjUCRo1/pSt/zzxPmZAkJxHuetWE/ntkC1xPWbsy8PhWHCNhOJJPJEqQZgGgR+0fsnpMLdgh6
	TSbFzqPoGrUfeJ+kFBgYTQf5YRELwsPr4/B9HAAi2HewzvZHeB/XJpEoN6oNRHC5vQ11lnTWoev
	/RKmFKGeeEv0QFXyXGqe+Pa9sY6mreKakFkpdVYIDg==
X-Received: by 2002:a17:907:3f24:b0:b88:4849:38bd with SMTP id
 a640c23a62f3a-b935b521ebamr93061666b.23.1772100493763; Thu, 26 Feb 2026
 02:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com> <87zf4v7rte.fsf@wotan.olymp>
In-Reply-To: <87zf4v7rte.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Feb 2026 11:08:02 +0100
X-Gm-Features: AaiRm52XU5nN2BxL2h2p9MtlxP-yYWMn0HBObLrkqzwDgkyw58EcjzQeFLnVPYE
Message-ID: <CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78461-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 77FE01A40CC
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:54=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>
> Hi Amir,
>
> On Wed, Feb 25 2026, Amir Goldstein wrote:
>
> > On Wed, Feb 25, 2026 at 12:25=E2=80=AFPM Luis Henriques <luis@igalia.co=
m> wrote:
> >>
> >> The implementation of lookup_handle+statx compound operation extends t=
he
> >> lookup operation so that a file handle is be passed into the kernel.  =
It
> >> also needs to include an extra inarg, so that the parent directory fil=
e
> >> handle can be sent to user-space.  This extra inarg is added as an ext=
ension
> >> header to the request.
> >>
> >> By having a separate statx including in a compound operation allows th=
e
> >> attr to be dropped from the lookup_handle request, simplifying the
> >> traditional FUSE lookup operation.
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++--=
-
> >>  fs/fuse/fuse_i.h          |  23 ++-
> >>  fs/fuse/inode.c           |  48 +++++--
> >>  fs/fuse/readdir.c         |   2 +-
> >>  include/uapi/linux/fuse.h |  23 ++-
> >>  5 files changed, 355 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> >> index 5c0f1364c392..7fa8c405f1a3 100644
> >> --- a/fs/fuse/dir.c
> >> +++ b/fs/fuse/dir.c
> >> @@ -21,6 +21,7 @@
> >>  #include <linux/security.h>
> >>  #include <linux/types.h>
> >>  #include <linux/kernel.h>
> >> +#include <linux/exportfs.h>
> >>
> >>  static bool __read_mostly allow_sys_admin_access;
> >>  module_param(allow_sys_admin_access, bool, 0644);
> >> @@ -372,6 +373,47 @@ static void fuse_lookup_init(struct fuse_args *ar=
gs, u64 nodeid,
> >>         args->out_args[0].value =3D outarg;
> >>  }
> >>
> >> +static int do_lookup_handle_statx(struct fuse_mount *fm, u64 parent_n=
odeid,
> >> +                                 struct inode *parent_inode,
> >> +                                 const struct qstr *name,
> >> +                                 struct fuse_entry2_out *lookup_out,
> >> +                                 struct fuse_statx_out *statx_out,
> >> +                                 struct fuse_file_handle **fh);
> >> +static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_att=
r *attr);
> >> +static int do_reval_lookup(struct fuse_mount *fm, u64 parent_nodeid,
> >> +                          const struct qstr *name, u64 *nodeid,
> >> +                          u64 *generation, u64 *attr_valid,
> >> +                          struct fuse_attr *attr, struct fuse_file_ha=
ndle **fh)
> >> +{
> >> +       struct fuse_entry_out entry_out;
> >> +       struct fuse_entry2_out lookup_out;
> >> +       struct fuse_statx_out statx_out;
> >> +       FUSE_ARGS(lookup_args);
> >> +       int ret =3D 0;
> >> +
> >> +       if (fm->fc->lookup_handle) {
> >> +               ret =3D do_lookup_handle_statx(fm, parent_nodeid, NULL=
, name,
> >> +                                            &lookup_out, &statx_out, =
fh);
> >> +               if (!ret) {
> >> +                       *nodeid =3D lookup_out.nodeid;
> >> +                       *generation =3D lookup_out.generation;
> >> +                       *attr_valid =3D fuse_time_to_jiffies(lookup_ou=
t.entry_valid,
> >> +                                                          lookup_out.=
entry_valid_nsec);
> >> +                       fuse_statx_to_attr(&statx_out.stat, attr);
> >> +               }
> >> +       } else {
> >> +               fuse_lookup_init(&lookup_args, parent_nodeid, name, &e=
ntry_out);
> >> +               ret =3D fuse_simple_request(fm, &lookup_args);
> >> +               if (!ret) {
> >> +                       *nodeid =3D entry_out.nodeid;
> >> +                       *generation =3D entry_out.generation;
> >> +                       *attr_valid =3D ATTR_TIMEOUT(&entry_out);
> >> +                       memcpy(attr, &entry_out.attr, sizeof(*attr));
> >> +               }
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >>  /*
> >>   * Check whether the dentry is still valid
> >>   *
> >> @@ -399,10 +441,11 @@ static int fuse_dentry_revalidate(struct inode *=
dir, const struct qstr *name,
> >>                 goto invalid;
> >>         else if (time_before64(fuse_dentry_time(entry), get_jiffies_64=
()) ||
> >>                  (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_=
TARGET))) {
> >> -               struct fuse_entry_out outarg;
> >> -               FUSE_ARGS(args);
> >>                 struct fuse_forget_link *forget;
> >> +               struct fuse_file_handle *fh =3D NULL;
> >>                 u64 attr_version;
> >> +               u64 nodeid, generation, attr_valid;
> >> +               struct fuse_attr attr;
> >>
> >>                 /* For negative dentries, always do a fresh lookup */
> >>                 if (!inode)
> >> @@ -421,35 +464,36 @@ static int fuse_dentry_revalidate(struct inode *=
dir, const struct qstr *name,
> >>
> >>                 attr_version =3D fuse_get_attr_version(fm->fc);
> >>
> >> -               fuse_lookup_init(&args, get_node_id(dir), name, &outar=
g);
> >> -               ret =3D fuse_simple_request(fm, &args);
> >> +               ret =3D do_reval_lookup(fm, get_node_id(dir), name, &n=
odeid,
> >> +                                     &generation, &attr_valid, &attr,=
 &fh);
> >>                 /* Zero nodeid is same as -ENOENT */
> >> -               if (!ret && !outarg.nodeid)
> >> +               if (!ret && !nodeid)
> >>                         ret =3D -ENOENT;
> >>                 if (!ret) {
> >>                         fi =3D get_fuse_inode(inode);
> >> -                       if (outarg.nodeid !=3D get_node_id(inode) ||
> >> -                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (ou=
targ.attr.flags & FUSE_ATTR_SUBMOUNT)) {
> >> -                               fuse_queue_forget(fm->fc, forget,
> >> -                                                 outarg.nodeid, 1);
> >> +                       if (!fuse_file_handle_is_equal(fm->fc, fi->fh,=
 fh) ||
> >> +                           nodeid !=3D get_node_id(inode) ||
> >> +                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (at=
tr.flags & FUSE_ATTR_SUBMOUNT)) {
> >> +                               fuse_queue_forget(fm->fc, forget, node=
id, 1);
> >> +                               kfree(fh);
> >>                                 goto invalid;
> >>                         }
> >>                         spin_lock(&fi->lock);
> >>                         fi->nlookup++;
> >>                         spin_unlock(&fi->lock);
> >>                 }
> >> +               kfree(fh);
> >>                 kfree(forget);
> >>                 if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR)
> >>                         goto out;
> >> -               if (ret || fuse_invalid_attr(&outarg.attr) ||
> >> -                   fuse_stale_inode(inode, outarg.generation, &outarg=
.attr))
> >> +               if (ret || fuse_invalid_attr(&attr) ||
> >> +                   fuse_stale_inode(inode, generation, &attr))
> >>                         goto invalid;
> >>
> >>                 forget_all_cached_acls(inode);
> >> -               fuse_change_attributes(inode, &outarg.attr, NULL,
> >> -                                      ATTR_TIMEOUT(&outarg),
> >> +               fuse_change_attributes(inode, &attr, NULL, attr_valid,
> >>                                        attr_version);
> >> -               fuse_change_entry_timeout(entry, &outarg);
> >> +               fuse_dentry_settime(entry, attr_valid);
> >>         } else if (inode) {
> >>                 fi =3D get_fuse_inode(inode);
> >>                 if (flags & LOOKUP_RCU) {
> >> @@ -546,8 +590,215 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
> >>         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->=
size);
> >>  }
> >>
> >> -int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct=
 qstr *name,
> >> -                    u64 *time, struct inode **inode)
> >> +static int create_ext_handle(struct fuse_in_arg *ext, struct fuse_ino=
de *fi)
> >> +{
> >> +       struct fuse_ext_header *xh;
> >> +       struct fuse_file_handle *fh;
> >> +       u32 len;
> >> +
> >> +       len =3D fuse_ext_size(sizeof(*fi->fh) + fi->fh->size);
> >> +       xh =3D fuse_extend_arg(ext, len);
> >> +       if (!xh)
> >> +               return -ENOMEM;
> >> +
> >> +       xh->size =3D len;
> >> +       xh->type =3D FUSE_EXT_HANDLE;
> >> +       fh =3D (struct fuse_file_handle *)&xh[1];
> >> +       fh->size =3D fi->fh->size;
> >> +       memcpy(fh->handle, fi->fh->handle, fh->size);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int fuse_lookup_handle_init(struct fuse_args *args, u64 nodeid=
,
> >> +                                  struct fuse_inode *fi,
> >> +                                  const struct qstr *name,
> >> +                                  struct fuse_entry2_out *outarg)
> >> +{
> >> +       struct fuse_file_handle *fh;
> >
> > Considering that fuse has long used uint64_t fh as the convention
> > for a file id all over the code, it would be better to pick a different
> > convention for fuse file handle, perhaps ffh, or fhandle?
>
> Good point, I'll make sure next revision will follow a different
> convention.
>
> >> +       size_t fh_size =3D sizeof(*fh) + MAX_HANDLE_SZ;
> >
> > I don't remember what we concluded last time, but
> > shouldn't the server request max_handle_sz at init?
> > This constant is quite arbitrary.
>
> You're right, I should have pointed that out in the cover letter at least=
.
> In the previous version that maximum size was indeed provided by the
> server.  But from the discussion here [0] I understood that this
> negotiation should be dropped.  Here's what Miklos suggested:
>
> > How about allocating variable length arguments on demand?  That would
> > allow getting rid of max_handle_size negotiation.
> >
> >        args->out_var_alloc  =3D true;
> >        args->out_args[1].size =3D MAX_HANDLE_SZ;
> >        args->out_args[1].value =3D NULL; /* Will be allocated to the ac=
tual size of the handle */
>
> Obviously that's not what the code is currently doing.  The plan is to
> eventually set the .value to NULL and do the allocation elsewhere,
> according to the actual size returned.
>
> Because I didn't yet thought how/where the allocation could be done
> instead, this code is currently simplifying things, and that's why I
> picked this MAX_HANDLE_SZ.
>
> Sorry, I should have pointed that out at in a comment as well.
>
> [0] https://lore.kernel.org/all/CAJfpegszP+2XA=3DvADK4r09KU30BQd-r9sNu2Do=
g88yLG8iV7WQ@mail.gmail.com
>
> >> +       int ret =3D -ENOMEM;
> >> +
> >> +       fh =3D kzalloc(fh_size, GFP_KERNEL);
> >> +       if (!fh)
> >> +               return ret;
> >> +
> >> +       memset(outarg, 0, sizeof(struct fuse_entry2_out));
> >> +       args->opcode =3D FUSE_LOOKUP_HANDLE;
> >> +       args->nodeid =3D nodeid;
> >> +       args->in_numargs =3D 3;
> >> +       fuse_set_zero_arg0(args);
> >> +       args->in_args[1].size =3D name->len;
> >> +       args->in_args[1].value =3D name->name;
> >> +       args->in_args[2].size =3D 1;
> >> +       args->in_args[2].value =3D "";
> >> +       if (fi && fi->fh) {
> >
> > Same here fi->ffh? or fi->fhandle
>
> Ack!
>
> >> +               args->is_ext =3D true;
> >> +               args->ext_idx =3D args->in_numargs++;
> >> +               args->in_args[args->ext_idx].size =3D 0;
> >> +               ret =3D create_ext_handle(&args->in_args[args->ext_idx=
], fi);
> >> +               if (ret) {
> >> +                       kfree(fh);
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +       args->out_numargs =3D 2;
> >> +       args->out_argvar =3D true;
> >> +       args->out_argvar_idx =3D 1;
> >> +       args->out_args[0].size =3D sizeof(struct fuse_entry2_out);
> >> +       args->out_args[0].value =3D outarg;
> >> +
> >> +       /* XXX do allocation to the actual size of the handle */
> >> +       args->out_args[1].size =3D fh_size;
> >> +       args->out_args[1].value =3D fh;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void fuse_req_free_argvar_ext(struct fuse_args *args)
> >> +{
> >> +       if (args->out_argvar)
> >> +               kfree(args->out_args[args->out_argvar_idx].value);
> >> +       if (args->is_ext)
> >> +               kfree(args->in_args[args->ext_idx].value);
> >> +}
> >> +
> >
> > Just wanted to point out that statx_out is > 256 bytes on stack
> > so allocating 127+4 and the added complexity of ext arg
> > seem awkward.
> >
> > Unless we really want to support huge file handles (we don't?)
> > maybe the allocation can be restricted to fi->handle?
> > Not sure.
>
> If I understand you correctly, you're suggesting that the out_arg that
> will return the handle should be handled on the stack as well and then it
> would be copied to an allocated fi->handle.  Sure, that can be done.
>
> On the other hand, as I mentioned above, the outarg allocation is just a
> simplification.  So maybe the actual allocation of the handle may be done
> elsewhere with the _actual_ fh size, and then simply used in fh->handle.
>
> Please let me know if I got your comment right.
> (And thanks for the comments, by the way!)

file handle on stack only makes sense for small pre allocated size.
If the server has full control over handle size, then that is not relevant.

At some point we will need to address the fact that the most common
case is for very small file handles.

In struct fanotify_fid_event, we used a small inline buffer to optimize thi=
s
case. This could also be done for fuse_inode::handle, but we can worry abou=
t
that later.

Thanks,
Amir.

