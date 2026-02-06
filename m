Return-Path: <linux-fsdevel+bounces-76579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC0FJDfihWk9HwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:44:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35CFDAFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0143032CF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B53AEF47;
	Fri,  6 Feb 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="I9W7zIIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7460D2F9C3D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381869; cv=pass; b=rylQE3ehpzuspwyG+jHYyCuBERcY2nS6TpDd6yA7mNjS6g31DR8e7jM3Ha8nDeCv3K5CEMiGuJgZb2T1sZe6A52Zg19/GE9mLXOZoLv2MxgIDvc6ZptbnBdUm2C/I16Q76ACG7ZcUWDN0N8tyfkKpMp0dpinpyAJ8S0eARUmFfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381869; c=relaxed/simple;
	bh=3mw8uJP0ZIcDNqYKhNkrQSFVmjQSE9rgWbRnkN5Bt+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYpo6FLPCEEIlbOxCqumhYjwgOSF9jk5m2lTG616qmxNcv+nXqk6ra4ObzT7A+VeUHdTyCJVYREOwG0eXQv7u1DaDThx94tytDPreutL4ZKkN/a05TdT0pJUSSESVu/cZZhWq0E2qbnkhCHMYFTb1tTLir1/eVja9JCaiR5JmAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=I9W7zIIs; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649e456e8a2so2152530d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 04:44:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770381868; cv=none;
        d=google.com; s=arc-20240605;
        b=lg449D/kD9RMB1QWdENOk8Rms+6n+xC72ZY+ek8FqNdZ54jnow60zkaJF74mya34XK
         DfimbZ4lML2cMbolYXGKQnnW/fBAp/0NEnErUt5gRHK6ZB6z24K3bMJyq5UD4oobVid3
         pTLOye5RHbSiyIEybtJH5urn3lajvgJ+gkmd9RAjYu940Y4+b3CgyU0oWnpepBZ6ZrQn
         /VtkYtzzGNue/oUpHxia4fztbzxMTOkROQKY6E5nHuE1hTR3tntLHrP+vJElq9QeTZhT
         k05CNNkfbBXg3V/1Ld1xJMegJSL7lYcldhpJLh+nnMz9E72U3gYksICKwG1Cxwr/hOUC
         yxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        fh=yZpyEEQDpzFvlLkIUIA+LyrhCDZSf7IvER6WnpI59Rw=;
        b=Bk2SLFqsf6V/CAPs4n2f7NGX/LU/HhSfB3Vqxg7acC3YLgXa6gwa1gYTZjEJtfHxEo
         jwl6uG9gQ6WSeiHwgxU4gHPxPy5pqFGw1jSGqd4v3bpyNoF6Gj3/FtK6+FRdd9XMjQH+
         hIXUfY4MWv5CShhbsjNA0EXMtUBTxmjmzWec+7ircj1EDYS4A8M5fGr/B5IXvmbEGcnb
         e/jUJS2GURrDUJGlIke5lmqlYgd6HvVdP8yVLzW6eYy7X0huEf8Z2EmYnMWqCDGQiC1z
         /bzirNc6RZ65T1QDsSPDTuVTTxwwTL6yDoHpSPePrfrkwivcDE5DTHVQI53J85Fm0mGQ
         GKNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770381868; x=1770986668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        b=I9W7zIIseqoqUxW7SbhJXiGhjf6rafdA6zBBij5gQs6oxa1Ll6o+HclXVxD5krVu2g
         Lexl4gtI3mPOPS9jJY7xuO2T3wIx8/ZvI8o7KZRgWzzUCP8awlKRjL6p2CmoyQOjAoxb
         8iZUzBUBA/QrixGrNWHw4DxjFIT/Q1p+LEzTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770381868; x=1770986668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        b=cDSCB2KtloFOHvrqbKy3Uawx+8xx7H0Xio0OetonlwfwK9cOfCDsutR5OXfeTMEBSt
         UOd8FeGHo2SWrRLrwPMnzUnBlK4lNNv/YXaPd6ccjMV4CmbWjIZTF1cdCeP4WURWHmSm
         ezbl+awSlpK54waFC2QIkxuKhFD1w9fCbqmSgbIwUo0bIIagL2h+5S0FG9+oITtfvw1K
         83ZYEySlHuW8r6MeAJx7fuPPMKBwsjNrd02IqPY6hvEctY23Kygt1ayDpBhG+SLnbTy3
         0yumyZANirELWGxal6Tu7HThzArKJ3vGb9abwiYbD4F0O3J7XYDb67eF7XOOJZ5rp7jN
         8kQg==
X-Forwarded-Encrypted: i=1; AJvYcCXQoUAbRSJX4N70V2UCEHgpYPNHETKMA2CGKCSsIIB6qDdXCY9UydM9YAtKl0hhCPWQ+yQWezssInrREAmb@vger.kernel.org
X-Gm-Message-State: AOJu0YzOcVTcaHNBSPTeqzhaJM13P/JPk2GleB1ptT8qc9/ChjN+NMJ0
	EpBxq7laUb04FGedDopGFa3qZSvucBkzvL7/+xeEA0Bz8SeQP65a3ufOLwv6xnBXkuL2K4FQEiF
	fjFhWNemhyR7mUVwll1YINrDuBowQc5RtjfYyHE5Yiw==
X-Gm-Gg: AZuq6aKP0bWFtB1xNGw7LjqQN4QOYjGREOfPwMGIllhO7PKABwJpJ9GXhHTAI2bLpWC
	KuCzSvB1LLDyHjVhMeqruF885F/Azv3xsqF7LlRaYQN7ZbTCQmuzsq3LnHCnipoXf4sobHr50kG
	RaZ1dq/U7Q5JEC3z6sLa8O7+5qj3rtd0GDFNFnPLs8smAyxVuNfsMlGXoKREKiLrketVvVx8lei
	2ch9B4vBKLh+pMKYWJAAIv6WUvrCrFJwWOQx85RZy0UhdCk3m4aXI8hF+QqLh+8WF4MoKdHTwaw
	V8Mwy1pdxhjmT0e5nqv+i275yhw=
X-Received: by 2002:a05:690c:39c:b0:794:ef94:1222 with SMTP id
 00721157ae682-7952ab57b30mr48502987b3.55.1770381868226; Fri, 06 Feb 2026
 04:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <20260206-gelenk-gierig-82ad15ec8080@brauner> <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
In-Reply-To: <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 6 Feb 2026 13:44:14 +0100
X-Gm-Features: AZwV_QjKPM44JjJR4PKgkXJKTIpISniJnOL6jzJRVFwiWxRMDOew-ykuozR4V5U
Message-ID: <CAJqdLrrU-iJcSg-pA_L4iZLkt6Xd2Ju5=C3x71QZmB9X4zYtsQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76579-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,vger.kernel.org,futurfusion.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,futurfusion.io:email,mail.gmail.com:mid,mihalicyn.com:email,mihalicyn.com:dkim,iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC35CFDAFD
X-Rspamd-Action: no action

Am Fr., 6. Feb. 2026 um 13:42 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> Am Fr., 6. Feb. 2026 um 13:33 Uhr schrieb Christian Brauner
> <brauner@kernel.org>:
> >
> > On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Instead of FS_USERNS_MOUNT we should use recently introduced
> > > FS_USERNS_DELEGATABLE cause it better expresses what we
> > > really want to get there. Filesystem should not be allowed
> > > to be mounted by an unprivileged user, but at the same time
> > > we want to have sb->s_user_ns to point to the container's
> > > user namespace, at the same time superblock can only
> > > be created if capable(CAP_SYS_ADMIN) check is successful.
> > >
> > > Tested and no regressions noticed.
> > >
> > > No functional change intended.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> > > Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yonghong.song@linux.dev>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > - RWB-tag from Jeff [1]
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  kernel/bpf/inode.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..d8dfdc846bd0 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       struct inode *inode;
> > >       int ret;
> > >
> > > -     /* Mounting an instance of BPF FS requires privileges */
> > > -     if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > > -             return -EPERM;
> >
> > Jeff's patch does:
> >
> >         if (user_ns != &init_user_ns &&
> >             !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
> >                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
> >                 return ERR_PTR(-EPERM);
> >         }
>
> Hi Christian,
>
> >
> > IOW, it only restricts the ability to end up in bpf_fill_super() if
> > FS_USERNS_DELEGATABLE is set. You still need to perform the permission
> > check in bpf_fill_super() though otherwise anyone can mount bpffs in an
> > unprivileged container now.
>
> Yeah, this is what  mount_capable(struct fs_context *fc) does. I'm removing
> FS_USERNS_MOUNT so know it checks capable(CAP_SYS_ADMIN), instead of
> ns_capable(fc->user_ns, CAP_SYS_ADMIN).
>
> No functional changes here.
>
> >
> > So either Jeff's patch needs to be changed to require
> > capable(CAP_SYS_ADMIN) when FS_USERNS_DELEGATABLE is set (which makes
> > sense to me in general) or the check needs to remain n bpf_fill_super().
> >
> > @Jeff do you require capable(CAP_SYS_ADMIN) from within nfs? I think you
> > somehow must because otherwise what prevents a container from mounting
> > arbitrary servers?
>
> Same point here. We have this check in mount_capable(struct fs_context
> *fc) already.

And of course, I would never send a patch like this without testing it
for unprivileged
user and without ensuring that it doesn't cause any obvious privilege
escalation ;-)

>
> Kind regards,
> Alex
>
> >
> > > -
> > >       ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> > >       if (ret)
> > >               return ret;
> > > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> > >       .init_fs_context = bpf_init_fs_context,
> > >       .parameters     = bpf_fs_parameters,
> > >       .kill_sb        = bpf_kill_super,
> > > -     .fs_flags       = FS_USERNS_MOUNT,
> > > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> > >  };
> > >
> > >  static int __init bpf_init(void)
> > > --
> > > 2.47.3
> > >

