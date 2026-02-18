Return-Path: <linux-fsdevel+bounces-77544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPFIA9t4lWl8RwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:31:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802DB154155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D99603031005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86030F546;
	Wed, 18 Feb 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8+nrWs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B52DF128
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403468; cv=pass; b=NwiXZawxDZoA8HYxMQawwhpVpv/2rA5486N0ifge/VlHrn8LSmAtogGbG8DeZ2WpSxAQTp6X/c25QQrfMQn+cQzc5b+NZHxx23wXgfifPD6mpTJcPcMXuryrSgxf1uVt8zNuyI2lzMUHF+tgqVUOIQaTFMu1LjkmA+k7+CaE5S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403468; c=relaxed/simple;
	bh=pOcrR9g/30b877GWLIQEiogDavQ6piFbc5NysJoGEjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1aNYDbHmGv7X+nsKC8P7LI4JBxcPoXhUVGDcHoedXYQxEZIlQBHWt3bbfcNx+oXenfT91TRFbgucFB+ExpVdDkx9nz4N0au9G2Ee0S699mltVjAJy3iikSJD0i280+p1FNACZpVuXt2JMdorLwF21tcZWvzhfaCvMNB9vDYg3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8+nrWs0; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65bfe9c585cso4821678a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 00:31:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771403465; cv=none;
        d=google.com; s=arc-20240605;
        b=RjHEFDnSRTGEKKcqGKdqCWudut5HxFqX2kTctZzna/RtVi0nNtq14MlADOu+jIgLTp
         W5yzpP4/Q62trRD2+7fZQysIEh8RV73+o3OzuI0hcalRG2ZASTF8xvN01l62dAK0dufa
         szj60CHrgLbKh9jxSekB9aI95pki6NEtdPcGLqBzeK//6bd3vA3kxpP/pBWjxZrV3mSu
         ARUBsyiGnL1Upd9Wm+bgq2L41boCPnJlV5Z8PtE5cxutzH8JrZ/8ju7VpUTaRumuerjb
         SUVH7/7m0ysvROSzS5G4fKL/jeYKdZXRUzdTbXJLrhAwKUUZyldJ+irABXXX2ToA3F6G
         kdSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cd+FmpSKeZY657ydPhpXWP28mI30FM0F7sFttu1MBmg=;
        fh=AgPkAr479BelR0xj9k+WKWKbR2eJ0nXmLWiUiVXw++k=;
        b=Kne0HJnpqR2AVNkiZd1PJ+3+CXPB+983E0wVrF6pwODU0Q94yjqIOoOlMiuzZOw3DK
         fAqiXFQWRlLIfMUOWGHIfX1nDRrWiI62+MQF12nDX4V6D+Df/IUasVC5sMqSS3VjduK+
         a7+ook7Twy6DlRUpQmN4d8SzTlyvTdzsntB3oFYJu+jAjjPKGY+eaGq6vTW3OPITFJu6
         6st3k5iNbAlGbkk+Aekgf/77fevC6mWJ3adStib9clAvxMK86WUd/GpYxIeu5tc5W5Zk
         +q9xx7bjRVKhenuwhpuMzL6HCCmS8Qe9Dyc/oS89ttHOhiItlgFhjh/NKWfOJGfkvd2r
         ULoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771403465; x=1772008265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+FmpSKeZY657ydPhpXWP28mI30FM0F7sFttu1MBmg=;
        b=W8+nrWs0t3nYly9aQdYDojfd/ojwSO6NGcTkZun3NnlNXxO080HxchVbR6K06rovo5
         9RJqIvUzAh4QbIKjNo3vm3ktm4ielFDx1LY0HJCimG09ox3gqIyTMo808CbL3YXfNcAA
         drmAR19cUxBWdTr/SCrddODp2BY2cSsys4KQIKSLedZkKD+JDHWCzxIqZlr4UcbgIbUS
         0dO6IIHOlPjD/lMhbmkJz3+oj9aUJ2Tboj8V4BMnfb0QdhZcHfp7RUwkPKE8aFrNHchX
         9ylLt0AtavYtMsY2db7Fc8qYdv4vhs7S6Wrn90WUZ+K8DxbtCPR/Zv7QLoMEAY1h+l5G
         CEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771403465; x=1772008265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cd+FmpSKeZY657ydPhpXWP28mI30FM0F7sFttu1MBmg=;
        b=THPNMlQYhnmqQkN1OzQQD4jLf6Tn0GTlNUvedpJjPnxsbgOSUzQT4+mB4ji6/xk38F
         y8YU8VxeV9I4b8cEh57CcAERlufamaCPdlBsRJZBNIAN1RQNQ7fud66I+hNDMnBo1p9L
         Sy4oOrP71N6Ccd2SGAZOJ5DMWmub8HGFnxNiE2Bc7u6UQ097zXJ6J3n6mrXKg7dKNxaa
         v3cfvoBLcN3cQcbLtMEDY8KYrP026JUNvoVWMsQcQEA6tZb4/t+MQXL2Ut7TeOiRHowi
         sSjSDWlFjEExSuP6ZtPQhOdgQomlOquT0gaw+IHA3q8gr8t3/LKNCIZRfxaZoJVrpjHN
         6e/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxGPyfDcH6RLKIxqAM6a6XWexyCCVYUqZTAglzs21pvXhjReZ1Yy/SvlJcYjXd0xia8SF3dee+8g6Sf/x3@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdFR4JP3syGu1cw1xVHMoQVfR7RyO3ui6dckfAwP08Me9LmQi
	K7QrgPbTcyYsV/W9SPrpjZnzLS3eIMDgii+1U/cTPvoblKXLzLRG5Ce9VE5DYM4TV4zRovOVOUK
	+CN2oLtk57eVS87avJGR2xlhHVW1LxzM=
X-Gm-Gg: AZuq6aK7VIeugYSb8nD3rPvnUgTMq2NTjbd+c0NKCML/7I+6jgWFzBMS9XSkwijKyAh
	d8Fn/PNwnYI+acA5Ee5V/HqEoR0f21u2HTrfrj6K/bGFrAZHDoixhxwjxkMo+js3UAEo+1wtqST
	eLsPsyGg3qayyIrdjFrvDMZsgXn+BqWe2QvyXGycT7FXNluAhGh7tCilK3ivw+qvZC0dfiQLvAI
	0djGmdd7zOJZmfXuSCVowKKMd4q48EafJ6C2QQsHhMavpaVKga/bWL1igXfZJtck1+AwqpyonWG
	11E/xXQK
X-Received: by 2002:a17:907:c23:b0:b87:3beb:194a with SMTP id
 a640c23a62f3a-b8fc3cb90cfmr783252566b.44.1771403464353; Wed, 18 Feb 2026
 00:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com> <20260218032232.4049467-3-tjmercier@google.com>
In-Reply-To: <20260218032232.4049467-3-tjmercier@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Feb 2026 09:30:52 +0100
X-Gm-Features: AaiRm52rcAO1uVM86zLcvkOqxQIDflGCfwWsZ-SPyqDCOtD9nqwyY5fQY1S-rmY
Message-ID: <CAOQ4uxjwO6JVy5GKJ6k+Rm4Ey1=TD9=gXMiuB=JvwQSA13iXjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77544-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 802DB154155
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 5:22=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Currently some kernfs files (e.g. cgroup.events, memory.events) support
> inotify watches for IN_MODIFY, but unlike with regular filesystems, they
> do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> removed.
>
> This creates a problem for processes monitoring cgroups. For example, a
> service monitoring memory.events for memory.high breaches needs to know
> when a cgroup is removed to clean up its state. Where it's known that a
> cgroup is removed when all processes die, without IN_DELETE_SELF the
> service must resort to inefficient workarounds such as:
> 1.  Periodically scanning procfs to detect process death (wastes CPU and
>     is susceptible to PID reuse).
> 2.  Placing an additional IN_DELETE watch on the parent directory
>     (wastes resources managing double the watches).

This sentence is a red flag for me.
"wastes resources"? What resources are you talking about?
A single inotify watch? That's nothing.
This is not a valid argument IMO.
I fail to see how managing N watches is different than managing 2N watches.
I have no objection to your patch, but we need to keep our arguments honest=
.

> 3.  Holding a pidfd for every monitored cgroup (can exhaust file
>     descriptors).
>
> This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
> This allows applications to rely on a single existing watch on the file
> of interest (e.g. memory.events) to receive notifications for both
> modifications and the eventual removal of the file, as well as automatic
> watch descriptor cleanup, simplifying userspace logic and improving
> resource efficiency.
>
> Implementation details:
> The kernfs notification worker is updated to handle file deletion.
> The optimized single call for MODIFY events to both the parent and the
> file is retained, however because CREATE (parent) events remain
> unsupported for kernfs files, support for DELETE (parent) events is not

Either drop this story about DELETE or expand it.
inotify does not generate a DELETE event when watching a file,
because DELETE is an event notifying a change of a directory.
If you would have kept your DELETE implementation that would have
broken this rule.

> added here to retain symmetry. Only support for DELETE_SELF events is
> added.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/kernfs/dir.c             | 21 +++++++++++++++++
>  fs/kernfs/file.c            | 45 ++++++++++++++++++++-----------------
>  fs/kernfs/kernfs-internal.h |  3 +++
>  3 files changed, 48 insertions(+), 21 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 29baeeb97871..e5bda829fcb8 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/fs.h>
> +#include <linux/fsnotify_backend.h>
>  #include <linux/namei.h>
>  #include <linux/idr.h>
>  #include <linux/slab.h>
> @@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool show=
)
>         up_write(&root->kernfs_rwsem);
>  }
>
> +static void kernfs_notify_file_deleted(struct kernfs_node *kn)
> +{
> +       static DECLARE_WORK(kernfs_notify_deleted_work,
> +                           kernfs_notify_workfn);
> +
> +       guard(spinlock_irqsave)(&kernfs_notify_lock);
> +       /* may overwite already pending FS_MODIFY events */

Typo: overwite

> +       kn->attr.notify_event =3D FS_DELETE;

FS_DELETE_SELF

> +
> +       if (!kn->attr.notify_next) {
> +               kernfs_get(kn);
> +               kn->attr.notify_next =3D kernfs_notify_list;
> +               kernfs_notify_list =3D kn;
> +               schedule_work(&kernfs_notify_deleted_work);
> +       }
> +}
> +
>  static void __kernfs_remove(struct kernfs_node *kn)
>  {
>         struct kernfs_node *pos, *parent;
> @@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
>                         struct kernfs_iattrs *ps_iattr =3D
>                                 parent ? parent->iattr : NULL;
>
> +                       if (kernfs_type(pos) =3D=3D KERNFS_FILE)
> +                               kernfs_notify_file_deleted(pos);
> +

Why are we not notifying a deleted directory?
If users expect DELETE_SELF on a watched cgroup file
they would definitely expect DELETE_SELF on a watched cgroup dir
when the cgroup is destroyed.

I claim that *this* should be the standard way to monitor
destroyed cgroups.

>                         /* update timestamps on the parent */
>                         down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
>
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e978284ff983..4be9bbe29378 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -37,8 +37,8 @@ struct kernfs_open_node {
>   */
>  #define KERNFS_NOTIFY_EOL                      ((void *)&kernfs_notify_l=
ist)
>
> -static DEFINE_SPINLOCK(kernfs_notify_lock);
> -static struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
> +DEFINE_SPINLOCK(kernfs_notify_lock);
> +struct kernfs_node *kernfs_notify_list =3D KERNFS_NOTIFY_EOL;
>
>  static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_nod=
e *kn)
>  {
> @@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, lo=
ff_t offset, int whence)
>         return ret;
>  }
>
> -static void kernfs_notify_workfn(struct work_struct *work)
> +void kernfs_notify_workfn(struct work_struct *work)
>  {
>         struct kernfs_node *kn;
>         struct kernfs_super_info *info;
> @@ -935,11 +935,7 @@ static void kernfs_notify_workfn(struct work_struct =
*work)
>         down_read(&root->kernfs_supers_rwsem);
>         down_read(&root->kernfs_rwsem);
>         list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
> -               struct kernfs_node *parent;
> -               struct inode *p_inode =3D NULL;
> -               const char *kn_name;
>                 struct inode *inode;
> -               struct qstr name;
>
>                 /*
>                  * We want fsnotify_modify() on @kn but as the
> @@ -951,24 +947,31 @@ static void kernfs_notify_workfn(struct work_struct=
 *work)
>                 if (!inode)
>                         continue;
>
> -               kn_name =3D kernfs_rcu_name(kn);
> -               name =3D QSTR(kn_name);
> -               parent =3D kernfs_get_parent(kn);
> -               if (parent) {
> -                       p_inode =3D ilookup(info->sb, kernfs_ino(parent))=
;
> -                       if (p_inode) {
> -                               fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> -                                        inode, FSNOTIFY_EVENT_INODE,
> -                                        p_inode, &name, inode, 0);
> -                               iput(p_inode);
> +               if (notify_event =3D=3D FS_DELETE) {
FS_DELETE_SELF

> +                       fsnotify_inoderemove(inode);
                            iput(inode);
                            continue;
                    }

Avoids all the churn and unneeded extra indentation that follows.

Thanks,
Amir.

