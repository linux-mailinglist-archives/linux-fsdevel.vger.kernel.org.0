Return-Path: <linux-fsdevel+bounces-77603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAnDDsz/lWlHYAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:07:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31615886D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 19:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5036C3006802
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46093346A1B;
	Wed, 18 Feb 2026 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhNMvWPu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664B3009D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438011; cv=pass; b=OXk9PYLL//BFtALAq7EMN1iEdISNJqKyVHq00bPzOL+kk07apFxFtsDrMLK2KUE116ky9GfT/qYYeUFIsz1mrobtBxswm+k2Cf+4P0fJrhWGB9BDj1UHq3sGVI+oZ8HLyHG4lwicQKrpprGZNDSXIGEuidbG1VBVzSgnVILrDNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438011; c=relaxed/simple;
	bh=vKHFmimGHmcCxm1OfH95ndaDSr1nvlL1XXWRjG4Pjog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXYKlE7zOe8WbajBc7mfabaHjOtuEA06tn2Zng4S/+AuDE7Iki6XOpfF+Gj6bUKfU84ZvVVd0B6ulS/oAaWfmGUaznizYISOW/rZq1KcOrIrudJBJpOlQ4k4gDYDndM0f3TM7xsXfyODrq33i3lnGFH9ZcalPUiYhBzvq5jYEM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhNMvWPu; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so4665e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 10:06:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771438008; cv=none;
        d=google.com; s=arc-20240605;
        b=Uq/PB4Lbgw+0UXGVBNAe98MUjvBEETOKwNwGkDlkPevz5t0x4dOyUqRsTWhQFcfeed
         INyuSVvJlf5yCY1QOWRbSWziJXcNTGIRKw6cGxfMj1f+qmJDJrNELfKMefg8h1Md2tm6
         Lx6U9tpUzEjeLg6Ya85vCX1r13i8geqzRehDvoYut4Z0bsHK4tUet0pU3cfysqzyPO60
         YEtl4vLziWFi1BoXFj8kKiQfiRK0KDdjICuem60B3o7DvTkjnV6PL4lS3o8Q1BOrUkkl
         AMbMLhLVhmTKhowfkxMAB14Pfj8FIDa+O/dcJgUJZ/TDqV+lfjyzRCc/syzGahj9XJo8
         CqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        fh=Us7t9Ep8FAs56QntAkl/nlmhUwekqP/Q+alxDHlXN8M=;
        b=Vj2qkoA7MgvDFLbiVNnCkIJkgPSE4sBY5ysgOVs4HbMg+TzUJFVGaW0Z0AGv5CCZh9
         PP2pvGzvydUDwMm7QGaO8/dknKcSc+uXETMh1I7KiEWav3ufnh4es4rwJuOgQG277fwp
         RxWjQjycbqbLPzHVdiuf/cB7RUfXbVD/E7A4Unk8zKIH+SqHgxXQIsHSVrswGngCGxdx
         WHc823ZlV384X+i2pLlimL4uoTLlrseW8O6muRggtVkmMkyboKznoqr/vlBDqHci0roL
         3YsYQ3vi3ZXBwtlU2ftbGOc4wAfJJquvUHaTmZkoawpXM8At3wVYxd3R63Cm4MfXP6b8
         4ZTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771438008; x=1772042808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        b=qhNMvWPuim6JSMCm/6+TDOIpVik3k9+UUa4+JiVqMFIs+Z9jciAUwNCqvCMF6n4Xz2
         3U0f5uMEyKv4hUPb6WgN+UmjTc+2HrMtNQI/s6qkEButK9BKHqeyeIpKIwd2Ee1E+U8d
         GTVy3P2/Gooqh7ql10PcIzBjdf0VxH2Tgrltv/BO6CbIJjZm9vHGXH6YwDwMaAxKopbs
         fG+yU5Cj5BzLSEVCStSjhvKuESb4S4RvbjcMIBuZsTKT6MxA1pJXg3hihCzpgUK2ssWL
         IgLrCbn8b1WZ2spWQl5OjU7uuxLFL7BCbnRrQu685gQ7Veq3NGUUe1FFQkW1u6SvnA7m
         qBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771438008; x=1772042808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1f95vZTOi5Yw4hvqLUrqCnxMotQccaY9rSWPiX8Mka0=;
        b=l7Oj+v+rWFoLgmK0nn+dSZ2Lf6FwBF1F0NBQ8JnBWf0Kl4CMkFzJOcKo0cZ00Sw5GN
         DJsvaMil6z3dcaARsublnKhwiZwX6Wlv2QOTI2hb92+oYFmS7XDAJWhG11wJJpuyeGl/
         TG6V8fAA37tdFdQIBWlB9Y3ytA7xQ1B0c5Lf1cBGLUOBsF+Hwefax05Oom2EFx02MOjE
         DtvnFIlhAWAIatXm9GDKDO0FYRvUBe7uC/lOO0rs2pSLV2utsCjmDtPDgoJ2UU2c7WNE
         jBkNRA+frVGXMs6iCkWCK1POcKKvgUcK0kDF/nFVqhvG550Oj9JivdFEX4QwGNYTu4Gi
         1inw==
X-Forwarded-Encrypted: i=1; AJvYcCVTqBmdowDpYJKZ0JxCzPkSRv9PG4xCwdoBEF31KMPr/0vWg2AijkNphOFcJfbBV3slwdpMWdNcEEcoUp4d@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdwV89p2ylVR2Z3u/OKWvBvfejIpcHEJb3BiPM+X7H6i17kjS
	d9ofqvIbyztTCjgbdZg16eWDyhAOdA5cHe3lkV7z+jUJ5U5QxV+qjr0WTCrnwFGU9FRhzcoM9Qr
	Ex4W0Ppv7AikfKMKBjwbIGvmy96byYqwdqrMFKdDFHDxlltWDOD/pcyiqLI0=
X-Gm-Gg: AZuq6aLMl4p0bi7r3CM8irhQRAvF1DEWw4QEq+mPR46bYVNN5H+24TzC/Y1Hm/WAMeA
	882OJPSNp9Hivi1fEjyO7Y0OInRrWp11v9ngIe2cUGumlyEG2WYvD9u9F3zN8cgjshksEiL95//
	RINqjJ6R9MAhiFe7lQIhWp87eokrUV5KVcvskno/WoC7kWWRsj3MzOeIUWruKvRLnAiltIFwlGx
	1FuVUgWrSnhon8xAsIxUnl1xPChRBVqWS2wA5oQhSEb9ZFLdTdA4OwEAFrpxYVJ/EodYWRxB3bC
	KMq28xD8kGf2aMvHL9JNR8D0hPObEbX1nAOtsdxjT3m2H7pTgkgxdbikQVYugEYkNxmDGg==
X-Received: by 2002:a05:600c:5251:b0:45f:2940:d194 with SMTP id
 5b1f17b1804b1-4839e5d968cmr18215e9.2.1771438007529; Wed, 18 Feb 2026 10:06:47
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
In-Reply-To: <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 10:06:35 -0800
X-Gm-Features: AaiRm53thvlVisx2lMRMuScTFsLjEYaxzAzammhyQCf8yauixPxpvKuRWHvq3fQ
Message-ID: <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77603-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,memory.events:url,suse.cz:email,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5D31615886D
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > inotify watches for IN_MODIFY, but unlike with regular filesystems, the=
y
> > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > removed.
>
> Please see my email:
> https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxylx73=
2voet@ol3kl4ackrpb
>
> I think this is actually a bug in kernfs...
>
>                                                                 Honza

Thanks, I'm looking at this now. I've tried calling clear_nlink in
kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
and shrink_dcache_parent is called, d_walk doesn't find any entries,
so shrink_kill->__dentry_kill is not called. I'm investigating why
that is...

> >
> > This creates a problem for processes monitoring cgroups. For example, a
> > service monitoring memory.events for memory.high breaches needs to know
> > when a cgroup is removed to clean up its state. Where it's known that a
> > cgroup is removed when all processes die, without IN_DELETE_SELF the
> > service must resort to inefficient workarounds such as:
> > 1.  Periodically scanning procfs to detect process death (wastes CPU an=
d
> >     is susceptible to PID reuse).
> > 2.  Placing an additional IN_DELETE watch on the parent directory
> >     (wastes resources managing double the watches).
> > 3.  Holding a pidfd for every monitored cgroup (can exhaust file
> >     descriptors).
> >
> > This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
> > This allows applications to rely on a single existing watch on the file
> > of interest (e.g. memory.events) to receive notifications for both
> > modifications and the eventual removal of the file, as well as automati=
c
> > watch descriptor cleanup, simplifying userspace logic and improving
> > resource efficiency.
> >
> > Implementation details:
> > The kernfs notification worker is updated to handle file deletion.
> > The optimized single call for MODIFY events to both the parent and the
> > file is retained, however because CREATE (parent) events remain
> > unsupported for kernfs files, support for DELETE (parent) events is not
> > added here to retain symmetry. Only support for DELETE_SELF events is
> > added.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > ---
> >  fs/kernfs/dir.c             | 21 +++++++++++++++++
> >  fs/kernfs/file.c            | 45 ++++++++++++++++++++-----------------
> >  fs/kernfs/kernfs-internal.h |  3 +++
> >  3 files changed, 48 insertions(+), 21 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 29baeeb97871..e5bda829fcb8 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/sched.h>
> >  #include <linux/fs.h>
> > +#include <linux/fsnotify_backend.h>
> >  #include <linux/namei.h>
> >  #include <linux/idr.h>
> >  #include <linux/slab.h>
> > @@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool sh=
ow)
> >       up_write(&root->kernfs_rwsem);
> >  }
> >
> > +static void kernfs_notify_file_deleted(struct kernfs_node *kn)
> > +{
> > +     static DECLARE_WORK(kernfs_notify_deleted_work,
> > +                         kernfs_notify_workfn);
> > +
> > +     guard(spinlock_irqsave)(&kernfs_notify_lock);
> > +     /* may overwite already pending FS_MODIFY events */
> > +     kn->attr.notify_event =3D FS_DELETE;
> > +
> > +     if (!kn->attr.notify_next) {
> > +             kernfs_get(kn);
> > +             kn->attr.notify_next =3D kernfs_notify_list;
> > +             kernfs_notify_list =3D kn;
> > +             schedule_work(&kernfs_notify_deleted_work);
> > +     }
> > +}
> > +
> >  static void __kernfs_remove(struct kernfs_node *kn)
> >  {
> >       struct kernfs_node *pos, *parent;
> > @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *k=
n)
> >                       struct kernfs_iattrs *ps_iattr =3D
> >                               parent ? parent->iattr : NULL;
> >
> > +                     if (kernfs_type(pos) =3D=3D KERNFS_FILE)
> > +                             kernfs_notify_file_deleted(pos);
> > +
> >                       /* update timestamps on the parent */
> >                       down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
> >
> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index e978284ff983..4be9bbe29378 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -37,8 +37,8 @@ struct kernfs_open_node {
> >   */
> >  #define KERNFS_NOTIFY_EOL                    ((void *)&kernfs_notify_l=
ist)
> >
> > -static DEFINE_SPINLOCK(kernfs_notify_lock);
> > -static struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
> > +DEFINE_SPINLOCK(kernfs_notify_lock);
> > +struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
> >
> >  static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_n=
ode *kn)
> >  {
> > @@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, =
loff_t offset, int whence)
> >       return ret;
> >  }
> >
> > -static void kernfs_notify_workfn(struct work_struct *work)
> > +void kernfs_notify_workfn(struct work_struct *work)
> >  {
> >       struct kernfs_node *kn;
> >       struct kernfs_super_info *info;
> > @@ -935,11 +935,7 @@ static void kernfs_notify_workfn(struct work_struc=
t *work)
> >       down_read(&root->kernfs_supers_rwsem);
> >       down_read(&root->kernfs_rwsem);
> >       list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
> > -             struct kernfs_node *parent;
> > -             struct inode *p_inode =3D NULL;
> > -             const char *kn_name;
> >               struct inode *inode;
> > -             struct qstr name;
> >
> >               /*
> >                * We want fsnotify_modify() on @kn but as the
> > @@ -951,24 +947,31 @@ static void kernfs_notify_workfn(struct work_stru=
ct *work)
> >               if (!inode)
> >                       continue;
> >
> > -             kn_name =3D kernfs_rcu_name(kn);
> > -             name =3D QSTR(kn_name);
> > -             parent =3D kernfs_get_parent(kn);
> > -             if (parent) {
> > -                     p_inode =3D ilookup(info->sb, kernfs_ino(parent))=
;
> > -                     if (p_inode) {
> > -                             fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> > -                                      inode, FSNOTIFY_EVENT_INODE,
> > -                                      p_inode, &name, inode, 0);
> > -                             iput(p_inode);
> > +             if (notify_event =3D=3D FS_DELETE) {
> > +                     fsnotify_inoderemove(inode);
> > +             } else {
> > +                     struct kernfs_node *parent =3D kernfs_get_parent(=
kn);
> > +                     struct inode *p_inode =3D NULL;
> > +
> > +                     if (parent) {
> > +                             p_inode =3D ilookup(info->sb, kernfs_ino(=
parent));
> > +                             if (p_inode) {
> > +                                     const char *kn_name =3D kernfs_rc=
u_name(kn);
> > +                                     struct qstr name =3D QSTR(kn_name=
);
> > +
> > +                                     fsnotify(notify_event | FS_EVENT_=
ON_CHILD,
> > +                                              inode, FSNOTIFY_EVENT_IN=
ODE,
> > +                                              p_inode, &name, inode, 0=
);
> > +                                     iput(p_inode);
> > +                             }
> > +
> > +                             kernfs_put(parent);
> >                       }
> >
> > -                     kernfs_put(parent);
> > +                     if (!p_inode)
> > +                             fsnotify_inode(inode, notify_event);
> >               }
> >
> > -             if (!p_inode)
> > -                     fsnotify_inode(inode, notify_event);
> > -
> >               iput(inode);
> >       }
> >
> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index 6061b6f70d2a..cf4b21f4f3b6 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > @@ -199,6 +199,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_n=
ode *parent,
> >   * file.c
> >   */
> >  extern const struct file_operations kernfs_file_fops;
> > +extern struct kernfs_node *kernfs_notify_list;
> > +extern void kernfs_notify_workfn(struct work_struct *work);
> >
> >  bool kernfs_should_drain_open_files(struct kernfs_node *kn);
> >  void kernfs_drain_open_files(struct kernfs_node *kn);
> > @@ -212,4 +214,5 @@ extern const struct inode_operations kernfs_symlink=
_iops;
> >   * kernfs locks
> >   */
> >  extern struct kernfs_global_locks *kernfs_locks;
> > +extern spinlock_t kernfs_notify_lock;
> >  #endif       /* __KERNFS_INTERNAL_H */
> > --
> > 2.53.0.310.g728cabbaf7-goog
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

