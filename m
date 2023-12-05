Return-Path: <linux-fsdevel+bounces-4903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BC8061DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0130CB2110F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A783FE49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bsny76bS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BBA1A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 14:22:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db539ab8e02so4807829276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701814923; x=1702419723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kV+tvXpjVk7xX2GSglbALSCSl6OSs1vaoyTrKyQ3HM=;
        b=Bsny76bSlA7tMaRB0CuSWeOtCPicfyo4HILwcKw+h4noG+lT3rZshzgTWwlkA5ZBGU
         6TA3JISy3Wq4QL+5LGX364CrS3bCkXoMSCfS23RxjCf5cgTfX0XQxhSD58GoR57sPfVl
         NLdZhIck74gMMrxNgnKynfNgysiQ9MCf+td91Naj4ramtjM96o09dW9nftLiG52PCoON
         mQI7p1bLZUYsxM4COLAvHb8rF/7oiC5HwPiLxq5d1H4POaTqm+V/3tsuX5WuMy1W5w7d
         6XwlgB3Nzlt6IK0rOI3RF58IbYTqyAi1eBkZd4GIleTRTule3niBINI1L2QbzVa8Ifd6
         zlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814923; x=1702419723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kV+tvXpjVk7xX2GSglbALSCSl6OSs1vaoyTrKyQ3HM=;
        b=Z1sPGbUAeQ/2pa7nLfiTVm7mJj/yiNMnNA4QETOEcm5wWjLdzBO1TSoGeCQH2I1rgW
         jVeNXRcROw918AyRATkMiMXsOfPJGoAxJaE3cRKKp9rD1nhTj/gzRX7cRtm9uYpVjOyD
         J8yRE7GgsKdIu3VtSR8bnPnazK1fRuGsyQG5Xh9WXgR3fpLlv9XYFSv7FEYpHfat3CyA
         PbxN6L9Gklq1oG1ciRaRImcsN2Ebx5/6Dz+pvCbneJYxTN546f+yYp9cHuDE3QLvo22R
         ByuSLr+0kb8IwF80fq9E283vgE03WydyErI0EtiV2+pauUGT4VzLvF4bk48yet96fFFf
         +QUg==
X-Gm-Message-State: AOJu0Yx/tTqzH6XMct/acSL0k+Se5rMQIpDwbCT2o6NnmSj8FQxTeRMV
	LTF9luk0/mSEEmSClgNC04rGjEbBi8q+uXiPnr55
X-Google-Smtp-Source: AGHT+IGb3c/R29ZeC6hZ83UGu7fypKrA5DKbgx3ctnIYDUC2sabTvsdQmTs920D2XYac45G1OW8SMMMEAgKnLS1qn88=
X-Received: by 2002:a25:d30d:0:b0:db5:4dc8:60e9 with SMTP id
 e13-20020a25d30d000000b00db54dc860e9mr4669503ybf.0.1701814922816; Tue, 05 Dec
 2023 14:22:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5f8b18b0-0744-4cf5-9ec5-b0bb0451dd18@p183> <20231201205940.23095-1-kamatam@amazon.com>
In-Reply-To: <20231201205940.23095-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Dec 2023 17:21:51 -0500
Message-ID: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, casey@schaufler-ca.com, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 4:00=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Fri, 2023-12-01 09:30:00 +0000, Alexey Dobriyan wrote:
> > On Wed, Nov 29, 2023 at 05:11:22PM -0800, Andrew Morton wrote:
> > >
> > > fyi...
> > >
> > > (yuk!)
> > >
> > > Begin forwarded message:
> > > Date: Thu, 30 Nov 2023 00:37:04 +0000
> > > From: Munehisa Kamata <kamatam@amazon.com>
> > > Subject: [PATCH] proc: Update inode upon changing task security attri=
bute
> > >
> > > I'm not clear whether VFS is a better (or worse) place[1] to fix the
> > > problem described below and would like to hear opinion.
> > >
> > > If the /proc/[pid] directory is bind-mounted on a system with Smack
> > > enabled, and if the task updates its current security attribute, the =
task
> > > may lose access to files in its own /proc/[pid] through the mountpoin=
t.
> > >
> > >  $ sudo capsh --drop=3Dcap_mac_override --
> > >  # mkdir -p dir
> > >  # mount --bind /proc/$$ dir
> > >  # echo AAA > /proc/$$/task/current         # assuming built-in echo
> > >  # cat /proc/$$/task/current                        # revalidate
> > >  AAA
> > >  # echo BBB > dir/attr/current
> > >  # cat dir/attr/current
> > >  cat: dir/attr/current: Permission denied
> > >  # ls dir/
> > >  ls: cannot access dir/: Permission denied
> > >  # cat /proc/$$/attr/current                        # revalidate
> > >  BBB
> > >  # cat dir/attr/current
> > >  BBB
> > >  # echo CCC > /proc/$$/attr/current
> > >  # cat dir/attr/current
> > >  cat: dir/attr/current: Permission denied
> > >
> > > This happens because path lookup doesn't revalidate the dentry of the
> > > /proc/[pid] when traversing the filesystem boundary, so the inode sec=
urity
> > > blob of the /proc/[pid] doesn't get updated with the new task securit=
y
> > > attribute. Then, this may lead security modules to deny an access to =
the
> > > directory. Looking at the code[2] and the /proc/pid/attr/current entr=
y in
> > > proc man page, seems like the same could happen with SELinux. Though,=
 I
> > > didn't find relevant reports.
> > >
> > > The steps above are quite artificial. I actually encountered such an
> > > unexpected denial of access with an in-house application sandbox
> > > framework; each app has its own dedicated filesystem tree where the
> > > process's /proc/[pid] is bind-mounted to and the app enters into via
> > > chroot.
> > >
> > > With this patch, writing to /proc/[pid]/attr/current (and its per-sec=
urity
> > > module variant) updates the inode security blob of /proc/[pid] or
> > > /proc/[pid]/task/[tid] (when pid !=3D tid) with the new attribute.
> > >
> > > [1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/security/selinux/hooks.c#n4220
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> > > ---
> > >  fs/proc/base.c | 23 ++++++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index dd31e3b6bf77..bdb7bea53475 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file =
* file, const char __user * buf,
> > >  {
> > >     struct inode * inode =3D file_inode(file);
> > >     struct task_struct *task;
> > > +   const char *name =3D file->f_path.dentry->d_name.name;
> > >     void *page;
> > >     int rv;
> > >
> > > @@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct fil=
e * file, const char __user * buf,
> > >     if (rv < 0)
> > >             goto out_free;
> > >
> > > -   rv =3D security_setprocattr(PROC_I(inode)->op.lsm,
> > > -                             file->f_path.dentry->d_name.name, page,
> > > -                             count);
> > > +   rv =3D security_setprocattr(PROC_I(inode)->op.lsm, name, page, co=
unt);
> > >     mutex_unlock(&current->signal->cred_guard_mutex);
> > > +
> > > +   /*
> > > +    *  Update the inode security blob in advance if the task's secur=
ity
> > > +    *  attribute was updated
> > > +    */
> > > +   if (rv > 0 && !strcmp(name, "current")) {
> > > +           struct pid *pid;
> > > +           struct proc_inode *cur, *ei;
> > > +
> > > +           rcu_read_lock();
> > > +           pid =3D get_task_pid(current, PIDTYPE_PID);
> > > +           hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
> > > +                   ei =3D cur;
> >
> > Should this "break;"? Why is only the last inode in the list updated?
> > Should it be the first? All of them?
>
> If it picks up the first node, it may end up updating /proc/[pid]/task/[t=
id]
> rather than /proc/[pid] (when pid =3D=3D tid) and the task may be denied =
access
> to its own /proc/[pid] afterward.
>
> I think updating all of them won't hurt. But, as long as /proc/[pid] is
> accessible, the rest of the inodes should be updated upon path lookup via
> revalidation as usual.
>
> When pid !=3D tid, it only updates /proc/[pid]/task/[tid] and the thread =
may
> lose an access to /proc/[pid], but I think it's okay as it's a matter of
> security policy enforced by security modules. Casey, do you have any
> comments here?
>
> > > +           put_pid(pid);
> > > +           pid_update_inode(current, &ei->vfs_inode);
> > > +           rcu_read_unlock();
> > > +   }

I think my thoughts are neatly summarized by Andrew's "yuk!" comment
at the top.  However, before we go too much further on this, can we
get clarification that Casey was able to reproduce this on a stock
upstream kernel?  Last I read in the other thread Casey wasn't seeing
this problem on Linux v6.5.

However, for the moment I'm going to assume this is a real problem, is
there some reason why the existing pid_revalidate() code is not being
called in the bind mount case?  From what I can see in the original
problem report, the path walk seems to work okay when the file is
accessed directly from /proc, but fails when done on the bind mount.
Is there some problem with revalidating dentrys on bind mounts?

--=20
paul-moore.com

