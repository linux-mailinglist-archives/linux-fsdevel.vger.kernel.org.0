Return-Path: <linux-fsdevel+bounces-76578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OATzEefhhWk9HwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:43:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBEEFDAE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9ADB30479C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7C3AEF35;
	Fri,  6 Feb 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="TqnNaZCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629233ACEF8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381751; cv=pass; b=IR9iKonVHyAtQvx3HB+AxKw3whAJ8rf7Evfx9j9wRWQWYgoIKsaGRSECeNhOHiPWLI3pkSfG4loZ+qA+OI/iVmltlsFVte8jVXKMM+VyTjNXzg3HWks7R25PSvkDifHcoa3WFh5MO4Wa6KKndG8WbhVHYKZ9WmqGtKzmvuaFABo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381751; c=relaxed/simple;
	bh=zdhBWmvj+JKFWU/nHEjqvB/HzAnQKmeTgyhMS0D9RWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJpzXIArMjLGrVTLy+TyIRfFSsak53fxUuvxkYy1eLcgsIY6orHxCaYdVd4+ef3FJcGwBaESBd6iv2miS/2yed8TsJ9+TXyNmpmXUxn+qHW1I15CLK/iuBALSWe5bmqVEGq61cNzh59PtxTwtqksG0BGlHkU+hj69dx6aI3t8ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=TqnNaZCJ; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so2139121e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 04:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770381749; cv=none;
        d=google.com; s=arc-20240605;
        b=OtB+QIIllSGCZDSG+W9a9KfGDGGhIMr+VWD/f1pJpnpLBGUmoGntWdE60TivUd9d7P
         aH5JlHg60x5NFKinWFftonG1kSn3X2VhOjN7fSYiqGeK8UN5KocBAyiF0B+yt2BHa/+z
         hQC6pA5K0ScopjXgczxztuhP5rarYq7QjJmelEkWnTdntUJbQfVOnmHJUl8iHx2BxqnN
         qglBcc54sUbZFXxAsSutBjclqVFuc021vVxFPMYlKizKMn3kRyuG/dJGONWKfUI7ZLqy
         MoIwpIJAXdlLOgZw4MAB0hTC7u0oAOtflCHDgwJXRIvYmrN9AzMQ8733uYoe3mzMGY4x
         nhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        fh=Ncg8Yb6XCD6iHXSc9vNwkjd38g7FVi4EtevkFwAdOjs=;
        b=Xld9os07Zp44qVaCA9F75Jn5t5jESr9N8xBoclbsNRJuXBzaBuLzxNWK1kv9RoZ3iE
         8xJmkIRyNC0CQ2iXGdC+l5qLQW538WgtT73soeBqyZEds8uo1zFz+drCYp7C6il39uDV
         mgCuexJj1J9BbkjQkjeDm+N89FilNh1GKJ4g8/pGqtXN1pEHiZ42ZCmJVs2G7p0CI9V5
         3ZF53Qkcm7MLjYTl2cMmqPDVvvM1nzEgdRaF5WnKpyhdBWl/zVXvMWPVgnyHgCBaCiZC
         GYpQUbNGjWV9g+kBT7HnhFq7ypePwzMdqF+2PUtt/DUPJWrhSvyVsr5vv9pEGkUTLqO9
         z8cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770381749; x=1770986549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        b=TqnNaZCJZKDgERTbB2O9RwX5KuxSimAIghe/aagR/qPzjAwjRyvzeCSvMOuyjy6M8G
         QrqskpvjYrPhWinHVcC+pIMVNqWEDvflwH88SFxyt52NiYfoybLL3zN9YcucA6TwxlqC
         qp+KeMIUqb1deDSE5WZxVUCrzj9+++lV0ok2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770381749; x=1770986549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        b=L5tBlIJCB9MSTcsokaB+VFECTzAX2WlajURK1uduofAfdOMSG7uGIsUuqxmEe2ya7F
         r+iSfd4fH9OBQVdlHnCEz4NU1SI0rLtxwmI33m8swPGBscW6GWmYZDZ6XaX4h9xa7d8e
         vH88TIQwvqgWMm5rtifX19TNJCi0wbgHBfV+jrCc9v1OmbP4q80oxY3c845oiY3eO0X+
         IZIWe91SEy8qkX0WcBV6rXptF9TCEkiTyeRrGSQM5LxB8Q0GBdx8z5OpVTzrc4q8D3hT
         nGZW6m3IQh3gI34DHrO3nVIVSKRaobPDKQZWw6X7DLPhyKDpKXJFKF0P9diy9HTdo8c/
         GrWA==
X-Forwarded-Encrypted: i=1; AJvYcCUpv98F1aUgs7IW0lgerFp2aAd1+u3BiQ/e5+1KvgE+RUXyu/4xurWziAaKAahBm4ahuZxXwaPv8KOYQPyH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YRwjDAjwdiVFTrXD5FQZNUkTOG5FRpQZDj9C4tXTnXrAWHHI
	KPjBzE96wtr2YmBGb2P9Z5fGeH2hc0pf3T4G55hutR15recdexGTxIYJXoo+5FebKGe5xnWCjae
	AWpQ7H6y4F7dCIVR57xGaMYzw2ycQ9R0OeDkwKEKMtQ==
X-Gm-Gg: AZuq6aJ5kyFDBoeVPgmuUUO78Tq3C6fFvxB7qfyBIo0bVyWAVZW0LSJ3WOJx43hZ3EU
	tClPVTNRWdiQDQra1j6qHj7r1nXzHQG72Uf8ddAeqPjANVNSHWaN8hojTrmILqZA4Eu130aVMfv
	/r5akHgkEWdOh0XwTXm38zhKobuNiCrCXke0jPHUnFtqlDUTLxF5CaX4wzC5TNQFFio3TJbIuji
	1cCGrr0bQpFvW5UngGQicuIzlbLb0R1e+yqE3Z/L78jwr3dNjC/06Z6j6fn90eY07FW9++1lfvj
	HTxWVLMlu9/xOAfUfj6KtqtldCU=
X-Received: by 2002:a05:6512:1390:b0:59e:476:a1cf with SMTP id
 2adb3069b0e04-59e45173187mr806234e87.49.1770381749061; Fri, 06 Feb 2026
 04:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com> <20260206-gelenk-gierig-82ad15ec8080@brauner>
In-Reply-To: <20260206-gelenk-gierig-82ad15ec8080@brauner>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 6 Feb 2026 13:42:17 +0100
X-Gm-Features: AZwV_QgkLBXyWCcKj5zjTf7523gOvqXKWBYJGr6JBO7fN7jZv7v_4Ao7HJZnJug
Message-ID: <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76578-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,iogearbox.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,futurfusion.io:email,mihalicyn.com:dkim]
X-Rspamd-Queue-Id: DBBEEFDAE6
X-Rspamd-Action: no action

Am Fr., 6. Feb. 2026 um 13:33 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Instead of FS_USERNS_MOUNT we should use recently introduced
> > FS_USERNS_DELEGATABLE cause it better expresses what we
> > really want to get there. Filesystem should not be allowed
> > to be mounted by an unprivileged user, but at the same time
> > we want to have sb->s_user_ns to point to the container's
> > user namespace, at the same time superblock can only
> > be created if capable(CAP_SYS_ADMIN) check is successful.
> >
> > Tested and no regressions noticed.
> >
> > No functional change intended.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> > Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > - RWB-tag from Jeff [1]
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  kernel/bpf/inode.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9f866a010dad..d8dfdc846bd0 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
> >       struct inode *inode;
> >       int ret;
> >
> > -     /* Mounting an instance of BPF FS requires privileges */
> > -     if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > -             return -EPERM;
>
> Jeff's patch does:
>
>         if (user_ns != &init_user_ns &&
>             !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
>                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
>                 return ERR_PTR(-EPERM);
>         }

Hi Christian,

>
> IOW, it only restricts the ability to end up in bpf_fill_super() if
> FS_USERNS_DELEGATABLE is set. You still need to perform the permission
> check in bpf_fill_super() though otherwise anyone can mount bpffs in an
> unprivileged container now.

Yeah, this is what  mount_capable(struct fs_context *fc) does. I'm removing
FS_USERNS_MOUNT so know it checks capable(CAP_SYS_ADMIN), instead of
ns_capable(fc->user_ns, CAP_SYS_ADMIN).

No functional changes here.

>
> So either Jeff's patch needs to be changed to require
> capable(CAP_SYS_ADMIN) when FS_USERNS_DELEGATABLE is set (which makes
> sense to me in general) or the check needs to remain n bpf_fill_super().
>
> @Jeff do you require capable(CAP_SYS_ADMIN) from within nfs? I think you
> somehow must because otherwise what prevents a container from mounting
> arbitrary servers?

Same point here. We have this check in mount_capable(struct fs_context
*fc) already.

Kind regards,
Alex

>
> > -
> >       ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> >       if (ret)
> >               return ret;
> > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> >       .init_fs_context = bpf_init_fs_context,
> >       .parameters     = bpf_fs_parameters,
> >       .kill_sb        = bpf_kill_super,
> > -     .fs_flags       = FS_USERNS_MOUNT,
> > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >  };
> >
> >  static int __init bpf_init(void)
> > --
> > 2.47.3
> >

