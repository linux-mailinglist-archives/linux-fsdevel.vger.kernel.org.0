Return-Path: <linux-fsdevel+bounces-77394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3AOuOdzAlGkwHgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:26:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213014FA05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 20:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80A7A3047367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 19:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA7377576;
	Tue, 17 Feb 2026 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hcwa2qfh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C402D2481
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356373; cv=pass; b=UWC6cKccTBjHP5SvrI1CVfI2mlWZCreg8MPaoCnQr1ZdNRh2YSZpCfnaOHdKIAog8F7GysJZXn0/KgIY6HKBfXiAKf0pZ9jbc1fxuq/dzh8Idov5MAN9AZSTJaL270vKTAMHsK4PBYlkUAFIqnDJjcWLsnYtLrmUxeT9M9ImS+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356373; c=relaxed/simple;
	bh=ZInnzvFTqZm3vNXw0nWFlKKRjaD+CRuq9E6Kn9OzF8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ta1aH6mvMPiy7aQlXoHhjnhWSnxabNo6rWGY+Z7lYZmxhwXNvr3YzKvUA5+Mlnz+W51maFwFfsRNNB0spvcrda5vrdfiRT34V+puDsDm44fvEkaZZ3R2MvcAhyOT8hBj94OffYsqTjpPcZL+KpvoWGrud4SPBcnhWh3hFl0c03E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hcwa2qfh; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48371d2f661so8165e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 11:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356369; cv=none;
        d=google.com; s=arc-20240605;
        b=g2tGa8bPjn6LH/y8TraAq6ArhhU1R2i8mVlLgopzjjQCaqs1Y/GAyMBc4MQJRNSZ+r
         SdIyhQduXZT97DERXNFdR2/qRcpBrutIV80h1fCTyXMEOL+x0P9lH/jSqTY199pXrzqD
         ai2c1+YWreTXE9zfEvmrMe5QXPGPQx4zODn0auP2KhVrUMVvAbCCj4xGJTQW5vDtY5J8
         c+ndp7gs/ODSGkZAaYr1z3dQd245K6zphtl+YxA+e75wTiqilkLnHgkJZirog0yalDA5
         e7cBRm5cLCM0K+oNgWraHJGiNsK75U/iycw0r2CWR2m9jjRvSOlsgyVyfdqOspfkVZKj
         Zy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ZGsA3xReBt7X5+3ZrIcwe+PD8olQd0gZLMTyqBqYmI=;
        fh=QynGfgk9XiKofAMXELnq7TimyLdKzjO/h+jzrun3qBY=;
        b=CCIjXPwjpVVrJYrCBpJ+Gr74z3Vlfxu/zg2JFGXPgC8SKiFF64uATS130EsTy5ldnt
         zCqY+hz2Rl58AJnWbRffe5VvlUGfIWyd7xks5pWsOY61idKmR4Hf01dX/eBTcO5eDrgu
         k9Wa8pS7d2bnXppCMJ0oaHqCkl4Qk8ua4xoC5T9/9Eoo4IEMxSSlJxDjwQXNZMuCUBvD
         vNYaUcOh9l1L4+F5Q2N3auvhoICjlTUKZvl7PccuM9hIXNXWlWiMIgTlZTKWcGzrLd49
         FrCTnTENMEyr204v5v+vrxp/Yr5nidMYV6oabfQyQeSzIAAROD+pdbaMtKjy2vuy4Cnx
         jZtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356369; x=1771961169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZGsA3xReBt7X5+3ZrIcwe+PD8olQd0gZLMTyqBqYmI=;
        b=Hcwa2qfhD37w0DSM/jVb+Us1qJb5nwMOi63RYin9XDPFpS9mcQ87+8VFc/r6Sct4f3
         nfE2o3FE9/smhYeSm8NsL1BAKhSg/exZ17gaYNEoQPSac4aLDID6AGnBn/fk3O3vZNzN
         T252mMX3sDwUf8UJFK896Bwk1ZO6dfyvDJpypwy6g+fOu6f545J5a9lUXOvFaLUUhjvP
         pyqQJpOHadx2tHUoe70L1g19axUk1qdZG+3A6LVbo7rqdhGX/rySbd2km39uTzgf8o5R
         YRQ4vPeQlWGw0O3WvasuNp+cs3/vFrStWXHT49uqaiphCmDGjuxWjZ+rBaVPNChSJrBC
         OPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356369; x=1771961169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZGsA3xReBt7X5+3ZrIcwe+PD8olQd0gZLMTyqBqYmI=;
        b=aOM9X40rxQytvKHGjFZYDW+DQfetui/ZJrVZ0Bq/xXlIwPIpJsqFLLqU/YAM2W4hNS
         4CFfQfcGjPWDco2aF7GODA08NVMJTYN1+3lS+cb+282Le8uBnUQ7BCVpz7C1iK03QyAE
         KAcQ3q+xRWaPsYElMjWbJQPsKGd1XyZVGoI5xSc8vwn3AIsYo9zCj4jmA3hl4PldmG5m
         ussAMv0a8LwE4Qg80MGp4pXyw86fIrGFC4JrUMoJWHE/Ah30SXeyjxGOOOIndARxYZMY
         rueIHz5YFjCd+tA88QJbOqzdJWV8gvBKe2t/eZWX5Pc2GyyO+BMwwy9QqWfM8HyK90sN
         ZEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS1Hq6H/ogJyFUzEDjQCZV3JAZLwpLW7nz7zYLnwRkoS2pkVYpldS0EJry70l4foT0RVvovLrPw0WjRCJz@vger.kernel.org
X-Gm-Message-State: AOJu0YynKY7BWPWVku4tG2pwYo2m8leync3csG+QTfc9TkvLjEbhIL2r
	C/nzsIL/SSFRf3cn+jnGcac0T8Jb7QrLVHG/3M0dnEUMkr2tjRsWWQ301ZyxkBts6EM0LyhCGxZ
	2M7njSE77SC4cD/vFfWv3uMC8qwywR2rLJaxeba9T
X-Gm-Gg: AZuq6aIUB5xDt9yEztSvfIlUaNMLJ1e/a8aKHardzrOzbqj1fEm3WKU2vBOqiBNIhhh
	GU2HzWz3vWp4Df1h590KTpe0GxMWuYP7HhnB3ONx8JvjXkjAA8nhU2KmIMvkJvA6EbUEHwinhZw
	j3ed+lTfgZQfDTP0uTWD0wZcaOJHrfcJ5kdN6nMjV4rLsDQXDPsD2p0qmKteDkcicS5tYCDUMkb
	EW20o88Uff9f6KhBz8IpdnyGCstywo/AuabvMw0DVnIvj7wBZytMqhn1XFtQ2HPdvqgSUAfojnE
	vTqll7WVoxh0bFxhXKPO4iihdJUV7RMGGQBvneP9X1UU/upd8THURG22B6/vZTPPpz1HchVP93T
	5Pwb/
X-Received: by 2002:a05:600c:6017:b0:477:95a8:2562 with SMTP id
 5b1f17b1804b1-48388599956mr1086505e9.13.1771356368554; Tue, 17 Feb 2026
 11:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <20260212215814.629709-3-tjmercier@google.com>
 <aZRAkalnJCxSp7ne@amir-ThinkPad-T480>
In-Reply-To: <aZRAkalnJCxSp7ne@amir-ThinkPad-T480>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:25:56 -0800
X-Gm-Features: AaiRm51Ypdymx3dN9Uu0r1qkZyxKEOlZU17aaE-kKgHuYF4YzCdc0HZQ1vDObCw
Message-ID: <CABdmKX3wsWphRTDanKwGGiUWoO0xTaC8L_QxjHzhpxfZn256MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Amir Goldstein <amir73il@gmail.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77394-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[memory.events:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6213014FA05
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 2:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Feb 12, 2026 at 01:58:13PM -0800, T.J. Mercier wrote:
> > Currently some kernfs files (e.g. cgroup.events, memory.events) support
> > inotify watches for IN_MODIFY, but unlike with regular filesystems, the=
y
> > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > removed.
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
>
> This looks very useful,
> But,
> How will the application know that ti can rely on IN_DELETE_SELF
> from cgroups if this is not an opt-in feature?
>
> Essentially, this is similar to the discussions on adding "remote"
> fs notification support (e.g. for smb) and in those discussions
> I insist that "remote" notification should be opt-in (which is
> easy to do with an fanotify init flag) and I claim that mixing
> "remote" events with "local" events on the same group is undesired.

I think this situation is a bit different because this isn't adding
new features to fsnotify. This is filling a gap that you'd expect to
work if you only read the cgroups or inotify documentation without
realizing that kernfs is simply wired up differently for notification
support than most other filesystems, and only partially supports the
existing notification events. It's opt-in in the sense that an
application registers for IN_DELETE_SELF, but other than a runtime
test like what I added in the selftests I'm not sure if there's a good
way to detect the kernel will actually send the event. Practically
speaking though, if merged upstream I will backport these patches to
all the kernels we use so a runtime check shouldn't be necessary for
our applications.

> However, IN_IGNORED is created when an inotify watch is removed
> and IN_DELETE_SELF is called when a vfs inode is destroyed.
> When setting an inotify watch for IN_IGNORED|IN_DELETE_SELF there
> has to be a vfs inode with inotify mark attached, so why are those
> events not created already? What am I missing?

The difference is vfs isn't involved when kernfs files are unlinked.
When a cgroup removal occurs, we get to kernfs_remove via kernfs'
inode_operations without calling vfs_unlink. (You can't rm cgroup
files directly.)

> Are you expecting to get IN_IGNORED|IN_DELETE_SELF on an entry
> while watching the parent? Because this is not how the API works.

No, only on the file being watched. The parent should only get
IN_DELETE, but I read your feedback below and I'm fine with removing
that part and just sending the DELETE_SELF and IN_IGNORED events.

> I think it should be possible to set a super block fanotify watch
> on cgroupfs and get all the FAN_DELETE_SELF events, but maybe we
> do not allow this right now, I did not check - just wanted to give
> you another direction to follow.
>
> >
> > Implementation details:
> > The kernfs notification worker is updated to handle file deletion.
> > fsnotify handles sending MODIFY events to both a watched file and its
> > parent, but it does not handle sending a DELETE event to the parent and
> > a DELETE_SELF event to the watched file in a single call. Therefore,
> > separate fsnotify calls are made: one for the parent (DELETE) and one
> > for the child (DELETE_SELF), while retaining the optimized single call
>
> IN_DELETE_SELF and IN_IGNORED are special and I don't really mind adding
> them to kernfs seeing that they are very useful, but adding IN_DELETE
> without adding IN_CREATE, that is very arbitrary and I don't like it as
> much.

That's fair, and the IN_DELETE isn't actually needed for my use case,
but I figured I would add the parent notification for file deletions
since it is already there for MODIFY events, and I was modifying that
area of the code anyway. I'll remove the parent notification for
DELETE and just send DELETE_SELF and IGNORED with
fsnotify_inoderemove() in V3.

> > for MODIFY events.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  fs/kernfs/dir.c             | 21 +++++++++++++++++++++
> >  fs/kernfs/file.c            | 16 ++++++++++------
> >  fs/kernfs/kernfs-internal.h |  3 +++
> >  3 files changed, 34 insertions(+), 6 deletions(-)
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
> > index e978284ff983..2d21af3cfcad 100644
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
> > @@ -959,15 +959,19 @@ static void kernfs_notify_workfn(struct work_stru=
ct *work)
> >                       if (p_inode) {
> >                               fsnotify(notify_event | FS_EVENT_ON_CHILD=
,
> >                                        inode, FSNOTIFY_EVENT_INODE,
> > -                                      p_inode, &name, inode, 0);
> > +                                      p_inode, &name,
> > +                                      (notify_event =3D=3D FS_MODIFY) =
?
> > +                                             inode : NULL, 0);
> >                               iput(p_inode);
> >                       }
> >
> >                       kernfs_put(parent);
> >               }
> >
> > -             if (!p_inode)
> > -                     fsnotify_inode(inode, notify_event);
> > +             if (notify_event =3D=3D FS_DELETE)
> > +                     fsnotify_inoderemove(inode);
> > +             else if (!p_inode)
> > +                     fsnotify_inode(inode, FS_MODIFY);
>
> Didn't you mean notify_event?

Yes, that would be better.

> Thanks,
> Amir.

Thanks for looking at my patches Amir,
T.J.

