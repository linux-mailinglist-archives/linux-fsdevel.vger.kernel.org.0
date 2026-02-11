Return-Path: <linux-fsdevel+bounces-76970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO3mCRDcjGm3uAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:44:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B187A1273EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A3B3032743
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC943542E3;
	Wed, 11 Feb 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PowYvJbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFF3542D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839014; cv=pass; b=t36WyIbixA2gwR5MSoaUip7+7w261s7qhOizH39w5sUYX4el+nUDAScsMsnzXPa9U14/KxXuGLYrY6OPMtkLr/kJUbFV647qYSNBO0BwIRSxj8hhWvFICtMdc9cVYVDBOKRiBqkVWqz4T4kCP5Ft5rF17fqdHia6AN+lviduhnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839014; c=relaxed/simple;
	bh=oXQ1XB8B3wClH1fLqpgOnCS78LK40SPPGujDt6bxq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6iNYv1OFwBuSYaifGrQzTf8El999KgtGnmHugX5n64aXCbOb5b/gyteqnY8navME69+F9T5jykfIbr0vo8RTqy2CEaQdH4CSnGAZyNxfhs9fifD6KeNdGZh96QVVEH4CfpPx7rKPGEKI8lUSsW1SQLvPSLWJOYV6jU7UalAF90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PowYvJbT; arc=pass smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-948d0d5d4d0so1427584241.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 11:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839013; cv=none;
        d=google.com; s=arc-20240605;
        b=XmxA2flN6EWTdcSF6iIZ+wcQ+fDWpBgFsczFDId2Xd77saMNEhws354abl4gfKTeGC
         aQf+pVDGTlpqbkIwAYtjFdnCEyUfuhuvjfzpYdRTsoK2NuLBkjosxd8nP+JFcHZh0DGt
         NinF9rR2dlEb8cj/eIrKRnm9iV7gJzHJEgA/BmY3mfJ6lYNiSbXcdSkfOfW3SUSxeLjN
         lOJMrv9q93bFQKSUIqd9mwucCuzTfbnjJWpcddMzOCXUFpDgVDQK5lXj2ljurTOgidhE
         nNocX4KirFlZOxmzfrQjUhs5mAJazPC5dNfLGRhXTPSCoH3m0XhaN8Kisv7z+VHgN2It
         Apbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        fh=3k7Y9w9q7yiRyLQH7afyu6swg9YdtXwWqUOQurlN2IY=;
        b=CxJsXc/J/qbxY+mMyoztndMj9kteiHu5UCF3wSPAjJpb/x5vjyymQbLtVtK6iIiSeq
         jqw/7MVCaXW6NtO/J9bqGLBt/Z/MBp5SUeu+yvjCbxn1tItVFLlI/HOyUzSUXDsRC4Qh
         ABPhICMRTpPrIeTFVUlDVi2mb++S3zqIepoY1Tvpl3Y+kb09bhJUOJye0XUOwQP+Kwmn
         q3LR2ESL60hArFezPLWJ46UMmfdy0IO+wPLx7rMFs5U0B0RTdzRgZWr1T1kBvkXgIu+G
         TpgX2Ox0kEBB93f0h4t3dDRmCxv1D6iWu5vw/kRP4/rmoubu173jLVsAsIbOfKRej4Fs
         y7mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839013; x=1771443813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=PowYvJbTJPD5aOP9KtNXgpElGAHlayOJtccZi17gLCiV7NklgomQwPWvFL+tS/F06+
         a4IHJWMKWcQOCMuG0V5Y1S7C3NMpWRRazWJSMGJ/+lW0n8XplZ7g7PHPZvoIPWr7ddC6
         kBURI9c6WeteHacV61ibMk9mDDzli28UvAOwlslzqHBLPbUBqJzca/m0c5JolC7p1VcV
         qs5+NNIx3MrvmcDaY/OsicJhdP7sZwy9m5emE/013J9SvcxjRvFzxDsyfLjLcjyYInMY
         HBHhumq6HhVkgF0CZKb1GWABndE+59YlInwq0nEKWZ3tZaa6o+GwTjhAB8RDB0zcOK4h
         ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839013; x=1771443813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=ACtUA5aT+X4m2WaHiGV6SylTDFF6sThqY+7wTyXCiR2RQ9/FLhUqF01nqAFcfLZaMV
         0IlgfEDbH+etQTAZl3K3DzPrmeqFeZpIT6nnGUMXSeUZMEjxfBPKqc+Vyb9B4VotFlnf
         RdN3+nV/aMdBGQbewlUSf54jo0CDY0TxaglftADTvpTlybmwNoBu/wkwD1ijmy1xl7/8
         69dg6A3Q1E20g2rC1m8sZCutaFaQ2g0FJynXM3AkYBVXdjdMLEWHq4UliAqkT7Y7+zct
         3GGadEDEq8QT16uWXKZY0t1iaIXyv+B7A1pSNoNNLl1kC7MjEWD0EsoJlwRUycx/L3Bt
         rSbw==
X-Gm-Message-State: AOJu0Yxw/GnG0HlHHPxpH15pCqV9FHyPjTo7dBi41YVu1rsD6e9mV/dr
	9wxvRm8Lus+IOGbhfCpK4BSNihEFTZdFk2fxRod4hQq/P6lJ1zhQv95YiARDBUa1X13XaqtAbR7
	Vyf9Zecv01L8+a+puLrhWFFXfEp1wxhA=
X-Gm-Gg: AZuq6aKP0Am+Mg3ksmCeWoqkftH3eCQbcHf+OSPObGyUXRSaKOM/pZjMlYFlMANWGif
	VImV1cIrDufQLaFFT3m1LufU4WNVnLcCHsQ4OWFx0cWVIQ3it/vqRjCZMTdw+8XlaAHDHxmAkx5
	YHyLcweKpbk9ZEveDMH9Lf1a3N1E5/IvoFBaFIyLleE6kW+ivBRdlBX4ot1EP2WN827Mmf9Dlcu
	5SsAXA9LqTEBDj8x9NwZJRMEEqwKS+z3m76lihGZ8QaVl+O8+2VeeXC3vLplzQXW4idRPBo3LBb
	e5JtIyU=
X-Received: by 2002:a05:6102:b03:b0:5fd:faf5:bc7a with SMTP id
 ada2fe7eead31-5fdfbe41f38mr144483137.41.1770839012601; Wed, 11 Feb 2026
 11:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206180248.12418-1-danieldurning.work@gmail.com> <20260209-spanplatten-zerrt-73851db30f18@brauner>
In-Reply-To: <20260209-spanplatten-zerrt-73851db30f18@brauner>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Wed, 11 Feb 2026 14:43:21 -0500
X-Gm-Features: AZwV_Qhs3SxVp8P05lu1S3k0H4-gjDRINJd9WaPk3va07O3EBGHdjmRA3KZwHck
Message-ID: <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76970-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,gmail.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieldurningwork@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B187A1273EC
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wr=
ote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Added a permission check to pidfd_info(). Originally, process info
> > could be retrieved with a pidfd even if proc was mounted with hidepid
> > enabled, allowing pidfds to be used to bypass those protections. We
> > now call ptrace_may_access() to perform some DAC checking as well
> > as call the appropriate LSM hook.
> >
> > The downside to this approach is that there are now more restrictions
> > on accessing this info from a pidfd than when just using proc (without
> > hidepid). I am open to suggestions if anyone can think of a better way
> > to handle this.
>
> This isn't really workable since this would regress userspace quite a
> bit. I think we need a different approach. I've given it some thought
> and everything's kinda ugly but this might work.
>
> In struct pid_namespace record whether anyone ever mounted a procfs
> with hidepid turned on for this pidns. In pidfd_info() we check whether
> hidepid was ever turned on. If it wasn't we're done and can just return
> the info. This will be the common case. If hidepid was ever turned on
> use kern_path("/proc") to lookup procfs. If not found check
> ptrace_may_access() to decide whether to return the info or not. If
> /proc is found check it's hidepid settings and make a decision based on
> that.
>
> You can probably reorder this to call ptrace_may_access() first and then
> do the procfs lookup dance. Thoughts?

Thanks for the feedback. I think your solution makes sense.

Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
boot for services with the ProtectProc option enabled. This means that
procfs will always have been mounted with hidepid in the init pid namespace=
.
Do you think it would be viable to record whether or not procfs was mounted
with hidepid enabled in the mount namespace instead?

> > I have also noticed that it is possible to use pidfds to poll on any
> > process regardless of whether the process is a child of the caller,
> > has a different UID, or has a different security context. Is this
> > also worth addressing? If so, what exactly should the DAC checks be?
>
> Oleg and I had discusses this and decided that such polling isn't
> sensitive information so by default this should just work and it's
> relied upon in Android and in a bunch of other workloads. An LSM can of
> course restrict access via security_file_ioctl().
>
> Fwiw, pidfds now support persistent trusted extended attributes so if
> the LSM folks wanted we can add security.* extended attribute support
> and they can mark pidfds with persistent security labels - persistent as
> in for the lifetime of the task.
>
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > ---
> >  fs/pidfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index dba703d4ce4a..058a7d798bca 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned=
 int cmd, unsigned long arg)
> >               goto copy_out;
> >       }
> >
> > +     /*
> > +      * Do a filesystem cred ptrace check to verify access
> > +      * to the task's info.
> > +      */
> > +     if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> > +             return -EACCES;
> > +
> >       c =3D get_task_cred(task);
> >       if (!c)
> >               return -ESRCH;
> > --
> > 2.52.0
> >

