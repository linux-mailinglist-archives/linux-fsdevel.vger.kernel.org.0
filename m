Return-Path: <linux-fsdevel+bounces-78312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO1TJMsWnmmcTQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:23:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D719818CB10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746EB303CEA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6033D4F8;
	Tue, 24 Feb 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dfQ/bWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D333B95D
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968198; cv=pass; b=aPFsn5ngb/1XShGCADgWC/IBvOqZ63BttHFuRHleoC13GJAI81uCfGj2x0EsYvlSVAdpe6rfEG9Ru6M6QHjHeTZ9fS1pQwhx2I657JcQWR8QN0NeweHP25qsPHZ+ffvkjxRYGQNQMfYDHxE0ZbDgs5QOzgkoZ/RbxyWMF2DyLac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968198; c=relaxed/simple;
	bh=xuDGZjuVSwp0lBoiWWwwKP5GUKb2eHPSZ4oJNFeW0Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0j0/zHJTdEHzpijFFZVQsDQe50reN+8B1w3J6KnOyHL9Y2zSZiyxY2miD8Tu75Aff9pjOizvx0dGR1FN9z+n0q07wcfpnmrRiMhIVFqI/EbKS4eiUOB6djFD2hqFMi6oPchm31jhBXakxBsF/2s6uR+UixjY/6dtNkOm31G7gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dfQ/bWK; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so3553a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:23:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771968195; cv=none;
        d=google.com; s=arc-20240605;
        b=i/3rk2Ib4gwgIH6HfBlKxj5UA2B4sUgwsQrtja4L0Se6VcJqTf/+l7te0gPAIsbBk3
         GfPwMtfKz0Xk+X/Rlcok/En+z24ou46c6nwfqh0WlFk4sCa7WTXGbx00fCptrFBUZou1
         zPH+qm4qTDsUsUSnu0u+tC3D9sgmDZ/48zKDdzxFpFfpiQT1cEy84beUEOVXn0xyC3HD
         DMtdUwhBZjUPjqIw1b0P0dTGeQDP919mHUn0lvO05L0cc8+XdVsayj8DTvsP/rVKanBa
         KiWKaxMrui5JgwIM2g69lKCLS8JNwocNk7bFVVzP6GwOD0CgiqavOUvdmpE92/ahIyYQ
         TYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfT8TqHks5hjIFjk9aOHD5F05Qofmp4GiLvlEM+GTOA=;
        fh=RRv3XsT6vNkGi0faJVxLfbiJoMhz4y638Sg2LEuTC/Q=;
        b=GsSl8RJeK69j9lNvoeB0HfMkrA98Ccyw8gnku4LeJlG4e38Y02cuAQHjE5w1F36n7A
         i3z/hX8NG2UoJG92yUdgpjGNAMDsQS0/nGE9mkDx1Suw5XXs4QzK5FCsgfnlcp3qTvfQ
         Q7L2zAvOa5s6hxknEQrYQdAPID8kmBbxeZpT1rcVW5BLwtH8cJzUn+I2U0vP3eeKiCet
         gd6D1UA+TaTlDMhPpFBTVWwQBa0xJxN1RGC4GEpgxIutyuticxXsfuJQA7RTigWNXOaj
         UFltcAZFYdv4JOSl3XGuDy6WOeYt8BCdT+hEZ6YgYzLT3nYJKlXwF+amKHrF15lY9mpZ
         mkxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771968195; x=1772572995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfT8TqHks5hjIFjk9aOHD5F05Qofmp4GiLvlEM+GTOA=;
        b=4dfQ/bWKnUbcRGfqxv6vFUJcAWOR/YiMnv+jU62tZ9r2dwW/oX40KhYjzRYUtcRG9Y
         vxnpzyQi/uTya8JZ8O2qj+GJETbHxGJqD1ED+BzJVZlcAILBDsBSgWCuxiLJ9T4WVq1n
         X6Fr1XRm8ztef5+xSsJLXt4p8j9iMaV21UmZewwYEOmmpn4cX3yvyAOgHFNEeZxF7bBW
         IB4qfyyIehG5102/wqHD5V67wWESjOoVv31Xu1q9817O50rNdFSji2g9aUYRTkIom514
         pvHBKnHsgAuVLLjYOFWNt3dHLRayX1+ikXKDlb1Kvrkw22Vx62uc8FDaQFEI8QeNXzX5
         GZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771968195; x=1772572995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfT8TqHks5hjIFjk9aOHD5F05Qofmp4GiLvlEM+GTOA=;
        b=Yd++NjZoHRoG91PrjSDXae5l9e477qWwgPQQj3Mr8EeotYxQKV/gUaQdRmWZhcWk1x
         XqRbmwNBpqsKzGZaNcWLfrvyDPLE4SdporiCbVeHHD1GfF42gvFOYY6FGw/0RqD1s0rg
         qil3azQFPzI+tcnmFrHOhqtRVqVANmYkqn0JRRrYmcCUmKJ1t/nkPbSjJfJ3wB+/D6KB
         foQHY7Ksqsq6uSXKu0uazwXU1I8ZMjfNOI00wX69JCv34VmMquug+5hpceDQ13nkFp8F
         l8dV5lrYRuniTj0fGojgdNG6UqXKZlIlSEMORASSLVTmh89VhIbWfcm5Fgad3IlGnrOI
         ZXOA==
X-Gm-Message-State: AOJu0YzhobIRTBlJKiHnr5F3EQe13Wl6YmNo0rPdPCWD5IFdJ0C9z33T
	Ow8XUPouxW9nZuigJOTR+qsznjAYLqYO4SYM26cAiwMGrIpfWESIsr/75UlXt1ZCGAmMOwD19O2
	RGTJHPP1g/JuROOyr8cxvxkAAzHEKgWOllt9UmZTLuY97l/Ni4FN111XhcGQ=
X-Gm-Gg: ATEYQzzzlNgbde5++ZKv6L7kMDdPRI2HW5W1prCH3ehBVdBEXCxj5pmDSfXKEDtYQOO
	ZuGCMRiZYGlISPy4EirBmy/X/bslQ3bd9+gvxQ8qXx7ZtewvGxAhIX13/ZYfDfEjLddbAI4OrfQ
	1G9zKfOH0NUks/L8P2nzp1HBi7ha08ehGdtedGVIWjsbELT3AXYtCau24dYmi3Go9qucEiZKcEy
	hNhpAOo+MRAIMAhNzObN2/nX4EQ317Is1Fh8m6OMIX+oOhn6+TWSOognTjNndlrVjWd7AX7/Ghw
	v5GojS2vrTMN/P94VYyQbvEqhAID9KZ/4MdU
X-Received: by 2002:aa7:c916:0:b0:65a:1240:b8c4 with SMTP id
 4fb4d7f45d1cf-65f8783713bmr1494a12.3.1771968194419; Tue, 24 Feb 2026 13:23:14
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org> <20260223-work-pidfs-inode-owner-v3-1-490855c59999@kernel.org>
In-Reply-To: <20260223-work-pidfs-inode-owner-v3-1-490855c59999@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 24 Feb 2026 22:22:38 +0100
X-Gm-Features: AaiRm51as_AW7-5Yr8m_5Zy23EufhkdWnmeE1mE9BrOljeASJf6eZTU7EXBibHU
Message-ID: <CAG48ez10oDKLBRfM-Tc9Bj6AXEEY+PECPSP=Dr96vAu9GnWELQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] pidfs: add inode ownership and permission checks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78312-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D719818CB10
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Right now we only support trusted.* xattrs which require CAP_SYS_ADMIN
> which doesn't really require any meaningful permission checking. But in
> order to support user.* xattrs and custom pidfs.* xattrs in the future
> we need permission checking for pidfs inodes. Add baseline permission
> checking that can later be extended with additional write-time checks
> for specific pidfs.* xattrs.
>
> Make the effective {u,g}id of the task the owner of the pidfs inode
> (like procfs does). The ownership is set when the dentry is first
> stashed and reported dynamically via getattr since credentials may
> change due to setuid() and similar operations. For kernel threads use
> root, for exited tasks use the credentials saved at exit time.
>
> The inode's ownership is updated via WRITE_ONCE() from the getattr()
> and permission() callbacks. This doesn't serialize against
> inode->i_op->setattr() but since pidfs rejects setattr() this isn't
> currently an issue. A seqcount-based approach can be used if setattr()
> support is added in the future [1].
>
> Save the task's credentials and thread group pid inode number at exit
> time so that ownership and permission checks remain functional after
> the task has been reaped.
>
> Add a permission callback that checks access in two steps:
>
>  (1) Verify the caller is either in the same thread group as the target
>      or has equivalent signal permissions. This reuses the same
>      uid-based logic as kill() by extracting may_signal_creds() from
>      kill_ok_by_cred() so it can operate on credential pointers
>      directly. For exited tasks the check uses the saved exit
>      credentials and compares thread group identity.
>
>  (2) Perform standard POSIX permission checking via generic_permission()
>      against the inode's ownership and mode bits.
>
> This is intentionally less strict than ptrace_may_access() because pidfs
> currently does not allow operating on data that is completely private to
> the process such as its mm or file descriptors. Additional checks will
> be needed once that changes.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=
=3Dwork.inode.seqcount [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c           | 133 +++++++++++++++++++++++++++++++++++++++++++++=
++----
>  include/linux/cred.h |   2 +
>  kernel/signal.c      |  19 ++++----
>  3 files changed, 136 insertions(+), 18 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 318253344b5c..16a3cfa84af4 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
[...]
> +static int pidfs_permission(struct mnt_idmap *idmap, struct inode *inode=
,
> +                           int mask)
> +{
> +       struct pid *pid =3D inode->i_private;
> +       struct task_struct *task;
> +       const struct cred *cred;
> +       u64 pid_tg_ino;
> +
> +       scoped_guard(rcu) {
> +               task =3D pid_task(pid, PIDTYPE_PID);
> +               if (task) {
> +                       if (unlikely(task->flags & PF_KTHREAD))
> +                               return -EPERM;
> +
> +                       cred =3D __task_cred(task);
> +                       pid_tg_ino =3D task_tgid(task)->ino;

Can this NULL deref if the task concurrently gets reaped and has
detach_pid() called on it?

> +               } else {
> +                       struct pidfs_attr *attr;
> +
> +                       attr =3D READ_ONCE(pid->attr);
> +                       VFS_WARN_ON_ONCE(!attr);
> +                       /*
> +                        * During copy_process() with CLONE_PIDFD the
> +                        * task hasn't been attached to the pid yet so
> +                        * pid_task() returns NULL and there's no
> +                        * exit_cred as the task obviously hasn't
> +                        * exited. Use the parent's credentials.
> +                        */
> +                       cred =3D attr->exit_cred;
> +                       if (!cred)
> +                               cred =3D current_cred();
> +                       pid_tg_ino =3D attr->exit_tgid_ino;
> +               }
> +
> +               /*
> +                * If the caller and the target are in the same
> +                * thread-group or the caller can signal the target
> +                * we're good.
> +                */
> +               if (pid_tg_ino !=3D task_tgid(current)->ino &&
> +                   !may_signal_creds(current_cred(), cred))
> +                       return -EPERM;
> +
> +               /*
> +                * This is racy but not more racy then what we generally
> +                * do for permission checking.
> +                */
> +               WRITE_ONCE(inode->i_uid, cred->euid);
> +               WRITE_ONCE(inode->i_gid, cred->egid);

I realize that using ->euid here matches what procfs does in
task_dump_owner(), but it doesn't make sense to me. The EUID is kinda
inherently "subjective" and doesn't really make sense in a context
like this where we're treating the process as an object. See also how,
when sending a signal to a process, kill_ok_by_cred() doesn't care
about the EUID of the target process, because it would be silly to
allow a user to send signals to a fileserver that happens to briefly
call seteuid() to access the filesystem in the name of the user, or
something like that.

The thing that IMO most expresses the objective identity of a process
is the RUID (notably that includes that it stays the same across
setuid execution unless the process explicitly changes RUID).

I think this should be using cred->uid and cred->gid so that the
permission check below makes more sense. That said, if you want to
instead follow the precedent of procfs and rely on the more explicit
permission checks above to actually provide security, I guess that
works too...

> +       }
> +       return generic_permission(&nop_mnt_idmap, inode, mask);
> +}
[...]
>  {
> diff --git a/kernel/signal.c b/kernel/signal.c
> index d65d0fe24bfb..e20dabf143c2 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -777,19 +777,22 @@ static inline bool si_fromuser(const struct kernel_=
siginfo *info)
>                 (!is_si_special(info) && SI_FROMUSER(info));
>  }
>
> +bool may_signal_creds(const struct cred *signaler_cred,
> +                     const struct cred *signalee_cred)
> +{
> +       return uid_eq(signaler_cred->euid, signalee_cred->suid) ||
> +              uid_eq(signaler_cred->euid, signalee_cred->uid) ||
> +              uid_eq(signaler_cred->uid, signalee_cred->suid) ||
> +              uid_eq(signaler_cred->uid, signalee_cred->uid) ||
> +              ns_capable(signalee_cred->user_ns, CAP_KILL);
> +}

I don't like reusing the signal sending permission checks here - in my
opinion, filesystem operations shouldn't be allowed based on the
caller's *RUID*. They should ideally be using the caller's FSUID.

> +
>  /*
>   * called with RCU read lock from check_kill_permission()
>   */
>  static bool kill_ok_by_cred(struct task_struct *t)
>  {
> -       const struct cred *cred =3D current_cred();
> -       const struct cred *tcred =3D __task_cred(t);
> -
> -       return uid_eq(cred->euid, tcred->suid) ||
> -              uid_eq(cred->euid, tcred->uid) ||
> -              uid_eq(cred->uid, tcred->suid) ||
> -              uid_eq(cred->uid, tcred->uid) ||
> -              ns_capable(tcred->user_ns, CAP_KILL);
> +       return may_signal_creds(current_cred(), __task_cred(t));
>  }
>
>  /*
>
> --
> 2.47.3
>

