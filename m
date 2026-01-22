Return-Path: <linux-fsdevel+bounces-74946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNNjFg1ucWkPHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:23:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B895FEBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6578736C96F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07F2BCF45;
	Thu, 22 Jan 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcmMfGYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390327F163
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041402; cv=pass; b=rSjU45KMPyB7RTg4d4SGwb0Uu4ed6b3ohQC5OCoysEvmAD18ndWf/1UFaFaayo4mkWOGALKdfzaGVFvj1JO5IcCsgIWb3EXmTyHJoj31hOI+3ENp5UyuKoA4S/FGPSancf/767bP1BFcxE7YZndX8ub6XgPzwpnB8oMwnXWdRpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041402; c=relaxed/simple;
	bh=IvHSX40nTc/ek4uvlvk06j7MjqF6iPY31dTzU/pChqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez0ES9FHYBDvhKuk67z/zwI8ZXr6Ix/TwNilJoa2usGskMcsyy492+jW/w7ms1Z7gPe2IfgbsFCK7Z1YHjTw3okldjDYsrCGbE3bHbXj5wi6xL/njs5NcZ1A9k5OSePbMMmFZTW7n+93YtjDEPYbvklnH4Po5FPMwyaleHGNtYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcmMfGYb; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5028fb9d03bso3171971cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041400; cv=none;
        d=google.com; s=arc-20240605;
        b=LU56ZP7As0OYWFqk05fYn0NBdyBrKUhBElREbOTLmBtZVIKPayQajFxYBjrizJhiRg
         9gfGAZHeToEfRqchQ/xQE+IwA96mZwHkMaEizSV2glBMofjOboaCcd7ZAnq+w2IbNUtC
         1Ba4XvRFXjtLIj2xlgbwJmiAZdUcbg2ElEapIeKS2PQb+uuuK7SbJ7f5TjU4Vtg8T5+v
         mt9tZ3fXTdcdfsUU+J+IX5CWj+0F51hNm6qAZcgdjrlmAUYWrOAJAMuUcKBCS04QAgmi
         soUkXj63UXfRrPdHU+vcisOni5cXCG/A8WQkFxU2DQQrbpoaaxWY+ldckADzy1iZRkd0
         Qquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        fh=pt1XeODH74FszcA1NSEhnuhFSkzz80UqkDIVCY6TpSg=;
        b=T3xahTyPau6rESVCHV62g/ccY3D8Zlx4pEyonxNXeyZqXBfOa+fzpg5eJwHuEgJh8E
         MrkM5L9J3dpnolnrZVcUfLwi+D5KCajeMLWBNyLBQqnIsBmi0J9nOsgr/IeMCpoegIaW
         i1dGmW5ykE4Y06dHv4hUWGrA4oYnVJE44rneQITLBgQINAxrV62+0bs1/bTHc6C2sGaK
         V0iQra3ojBIOoF/6sCWErtzDo25jkdienot+Zn0T8amTjoCKRLrLvrVONvgcnoHXHHIH
         OjQJBDCSQMe/b2Sb5GhG04Za+g2L0k06DBJkCaiLtZ6Q7PeTmgMBecxZGtIL88vAB897
         TIlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041400; x=1769646200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        b=RcmMfGYbQRjDlgMdgTk6wguPQ6WEM7/P3qT5HapoK9DU5EDqoc5yptx9GxgFJQILur
         BfGaM3mQuVEG1QMVv1+6auCRhz5BDfOCncBNxoDXuBpItcsBEZfrNN7KqAK/qHEFJbvq
         NQQFj2ffXh8piJwsrE59aVyYHMWspJf7ZJKiciR0plPUeCgWDniSyg8O643YlRao27+Y
         8m1/81UM5adKwT9U16isuLsyBOtxmus8H/JFEVwH5zXjfV+EMfnv4/AovfrByMQXMQv0
         pgKjQRrCuA9qkn2uYJNklX77T3QIneL6zIckjqcGktAwqxyC7aVLqmp7uaBmCCFcEmpJ
         m49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041400; x=1769646200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        b=BL+aYUrN895XtmgU0AQAfeKNJWm2BDTdMMshHEgVVqzA2UoDz64SiwRVsPpMefs6Pn
         JcQKk86lxKtg+qkorEJby5OHP/W5t1aqZfyANQtq6NxfAZATzXBt3v6sI/Oxh50P49Ye
         5z7nh0iircmNcS9LRw2IcperVKk1fn6fGhQM0mAGeuiI00uq5WEvJ5HlYq5T06wrls75
         ejdRlE8OeMXbSjhXMby+/hKVRL39iwJJxfJhNlNCx6KhHQ/0gQF49vDxVM5vH385hNHV
         0RGaYObMTIEaKjMDxP/p/hnMSKAh0cqmchBoefQ0R3WOVQFZEpGdthxifwk+gpnJfKLI
         UAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2GCh9jzgxSL6r5K0TUoS8cGQc1T2CCIAmEHDqnY3Wko4DvRnLzb9/K7NGc4arVHdwFGARI1bcr1GrGGXb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzha7ES5m0IpGSFORVGH+dgphNjo9Fp1O2TNRmDNZ0XBeW+E0Nw
	UjGOP9m7+CCeKYXxqfefwDVr0W0VrXHH/nn6Yv4rhmzvJM8EAjBVNkpAG8LkePgl97EhVXQ45oz
	taMA4KfgBDi2HUfCjBX6TEke3We2hLxs=
X-Gm-Gg: AZuq6aLTKJaPlhAuoCjJnTCeJmxHTe6n/XY2kXdIpdAHvMXOD1pk8IHTZnycFJvc/4b
	KqBlFUTuQua2l8iEWMtnP2XKwQlN8dXp4R7NtQ9NJih2T+Z9/bMIov61XqLRVq3RKI/fBeFWLEB
	3YYu1yOlbYxuWKhdo8g40EDaT9fydBEwk6xGAP3vl2+/S4441qbuXhh1Si5BELf3tTTjAvDOih2
	YZwb0HAbeLenyiHqRpWUhQEoS5xvxMBzFlJ+qkssdvnC9GuTXGsWgLTP2tZD442nKE23A==
X-Received: by 2002:ac8:7f56:0:b0:4ff:c884:31ad with SMTP id
 d75a77b69052e-502a175713dmr303665671cf.53.1769041399655; Wed, 21 Jan 2026
 16:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
 <CAJnrk1ZUbuAER90xbagWnBZ9dWKkdUAqVRa1vmZ5BtL_o=TnnA@mail.gmail.com> <20260122000227.GK5966@frogsfrogsfrogs>
In-Reply-To: <20260122000227.GK5966@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 16:23:08 -0800
X-Gm-Features: AZwV_Qgjb8XgeysXcP88DDgVJSYEpHtw7nd-7kRskGNM3PdmVUgS62gjGWMSLYQ
Message-ID: <CAJnrk1Z_M4XP7dApmuLA9Na+7+9OO0he9EcaZJrubTrHKKUk8w@mail.gmail.com>
Subject: Re: [PATCH 03/31] fuse: make debugging configurable at runtime
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74946-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 09B895FEBD
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 4:02=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 03:42:04PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Use static keys so that we can configure debugging assertions and dme=
sg
> > > warnings at runtime.  By default this is turned off so the cost is
> > > merely scanning a nop sled.  However, fuse server developers can turn
> > > it on for their debugging systems.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h     |    8 +++++
> > >  fs/fuse/iomap_i.h    |   16 ++++++++--
> > >  fs/fuse/Kconfig      |   15 +++++++++
> > >  fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c      |    7 ++++
> > >  5 files changed, 124 insertions(+), 3 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > index a88f5d8d2bce15..b6fc70068c5542 100644
> > > --- a/fs/fuse/file_iomap.c
> > > +++ b/fs/fuse/file_iomap.c
> > > @@ -8,6 +8,12 @@
> > >  #include "fuse_trace.h"
> > >  #include "iomap_i.h"
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
> > > +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> > > +#else
> > > +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> > > +#endif
> > > +
> > >  static bool __read_mostly enable_iomap =3D
> > >  #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> > >         true;
> > > @@ -17,6 +23,81 @@ static bool __read_mostly enable_iomap =3D
> > >  module_param(enable_iomap, bool, 0644);
> > >  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> > > +static struct kobject *iomap_kobj;
> > > +
> > > +static ssize_t fuse_iomap_debug_show(struct kobject *kobject,
> > > +                                    struct kobj_attribute *a, char *=
buf)
> > > +{
> > > +       return sysfs_emit(buf, "%d\n", !!static_key_enabled(&fuse_iom=
ap_debug));
> > > +}
> > > +
> > > +static ssize_t fuse_iomap_debug_store(struct kobject *kobject,
> > > +                                     struct kobj_attribute *a,
> > > +                                     const char *buf, size_t count)
> > > +{
> > > +       int ret;
> > > +       int val;
> > > +
> > > +       ret =3D kstrtoint(buf, 0, &val);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (val < 0 || val > 1)
> > > +               return -EINVAL;
> > > +
> > > +       if (val)
> > > +               static_branch_enable(&fuse_iomap_debug);
> > > +       else
> > > +               static_branch_disable(&fuse_iomap_debug);
> > > +
> > > +       return count;
> > > +}
> > > +
> > > +#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)               =
   \
> > > +{                                                                   =
   \
> > > +       .attr   =3D { .name =3D __stringify(_name), .mode =3D _mode }=
,        \
> > > +       .show   =3D _show,                                           =
     \
> > > +       .store  =3D _store,                                          =
     \
> > > +}
> > > +
> > > +#define FUSE_ATTR_RW(_name, _show, _store)                     \
> > > +       static struct kobj_attribute fuse_attr_##_name =3D        \
> > > +                       __INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> > > +
> > > +#define FUSE_ATTR_PTR(_name)                                   \
> > > +       (&fuse_attr_##_name.attr)
> > > +
> > > +FUSE_ATTR_RW(debug, fuse_iomap_debug_show, fuse_iomap_debug_store);
> > > +
> > > +static const struct attribute *fuse_iomap_attrs[] =3D {
> > > +       FUSE_ATTR_PTR(debug),
> > > +       NULL,
> > > +};
> > > +
> > > +int fuse_iomap_sysfs_init(struct kobject *fuse_kobj)
> > > +{
> > > +       int error;
> > > +
> > > +       iomap_kobj =3D kobject_create_and_add("iomap", fuse_kobj);
> > > +       if (!iomap_kobj)
> > > +               return -ENOMEM;
> > > +
> > > +       error =3D sysfs_create_files(iomap_kobj, fuse_iomap_attrs);
> > > +       if (error) {
> > > +               kobject_put(iomap_kobj);
> > > +               return error;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
> > > +{
> >
> > Is sysfs_remove_files() also needed here?
>
> kobject_put is supposed to tear down the attrs that sysfs_create_files
> attaches to iomap_kobj.  Though you're right to be suspicious -- there
> are a lot of places that explicitly call sysfs_remove_files to undo
> sysfs_create_files; and also a lot of places that just let kobject_put
> do the dirty work.

Makes sense, thanks for the context.
>
> > > +       kobject_put(iomap_kobj);
> > > +}
> > > +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> > > +
> > >  bool fuse_iomap_enabled(void)
> > >  {
> > >         /* Don't let anyone touch iomap until the end of the patchset=
. */
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 1eea8dc6e723c6..eec711302a4a13 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -2277,8 +2277,14 @@ static int fuse_sysfs_init(void)
> > >         if (err)
> > >                 goto out_fuse_unregister;
> > >
> > > +       err =3D fuse_iomap_sysfs_init(fuse_kobj);
> > > +       if (err)
> > > +               goto out_fuse_connections;
> > > +
> > >         return 0;
> > >
> > > + out_fuse_connections:
> > > +       sysfs_remove_mount_point(fuse_kobj, "connections");
> > >   out_fuse_unregister:
> > >         kobject_put(fuse_kobj);
> > >   out_err:
> > > @@ -2287,6 +2293,7 @@ static int fuse_sysfs_init(void)
> > >
> > >  static void fuse_sysfs_cleanup(void)
> > >  {
> > > +       fuse_iomap_sysfs_cleanup(fuse_kobj);
> > >         sysfs_remove_mount_point(fuse_kobj, "connections");
> > >         kobject_put(fuse_kobj);
> > >  }
> > >
> > Could you explain why it's better that this goes through sysfs than
> > through a module param?
>
> You can dynamically enable debugging on a production system.  I (by
> which I really mean the support org) wishes they could do that with XFS.
>
> Module parameters don't come with setter functions so you can't call
> static_branch_{enable,disable} when the parameter value updates.
>

Ohh I thought the "module_param_cb()" stuff does let you do that and
can be dynamically enabled/disabled as well? I mostly ask because it
feels like it'd be nicer from a user POV if all the config stuff (eg
enable uring, enable iomap, etc.) is in one place.

Thanks,
Joanne

> --D
>
> > Thanks,
> > Joanne

