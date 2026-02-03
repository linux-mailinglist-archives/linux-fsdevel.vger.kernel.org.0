Return-Path: <linux-fsdevel+bounces-76208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDbWIj4ggmlIPgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:20:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0CDBD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24E23167CFD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76823D1CA2;
	Tue,  3 Feb 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="AxhekHSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAD3C1976
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135133; cv=pass; b=Yi2bkxV87AcIrKLMfHyPaFyQ50clHGO3PRCLvgJEZ83psvdofWPI5ukRUtMralTMMU0+rTgyskhLwZZKOAe0qmtYRaJ0HceT+GqoKTE2bXlay/64D0ykHCj4bfTKqB+5wT6DVwyJPYLMnTWQWeBRA5XAfDf3EnyfFBlQdYiBhKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135133; c=relaxed/simple;
	bh=A8RN4GDLWQ83r49qq2Mz8+c6CAijfCOfj8JYE67qE84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMxkXBweq7qtTlnjSPsKrbgXiPpGHV/vjN+oPuYqL8OKinLU9JBzz0pI7xdZLWGLUtgjHPTQnn8QRVgPbJRCvATtqRBITpN8sfwM3pfkWZEgFWDl73BaH724dZ9qLCW0+CO6Cn9Amka5FmyHZdlXCcQwFkRKhGfZxRPNlKCZQZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=AxhekHSE; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso6190367e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 08:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135128; cv=none;
        d=google.com; s=arc-20240605;
        b=gyevtn8lF5ipKCLTbussFSLJMUhKVz09HWnbTjpUOt9Soy1K5KJ3h+klKTCGNVX6sC
         UnGmggpEZOvq2jtgzgk8zn12qwl1sBKnBXO7L9V0cxhcOjfUwhxj3VsJWAq2jyDVfjvm
         ihTX01ufd08j+BDE4ZLpJwhqV/0RjgDRaBJIvkxyrTuu+cd871brK32qOjy4HL7fRx4W
         G+uAVX7UL1SS3MqWsrMotetItYUex/oEuZuSa3GVe5yENnhIMq0150EXUvJhthapxPP9
         xdNvxYgZSDM67Le2Qe5aJe77CJbNMz1hFFtaUY4NsX8SRUXMJwyrXHEqX/O7EGOZehe9
         RV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        fh=Xheh5RQspoWCPAWTZn9If1am+D+3PP0eKVU7CQTs81c=;
        b=jc9Y6T6Lts2YOI12cxkogf2oh8rO2yI1B5E8J+qNxXD3atoB5LUpNt0Mdp9HUFQWo0
         1Vo+LMlMtT3swDBjpQR0l0Q9UY4MSyF9YwUM2tc+QseUCaB/M/UEY0ET4dxysDz2FbbS
         zjXhLROusMEsZKlwJxIRC+wejHLJtfQ4uhuYVF5qWs5GW0xyWQBJ+ZdSa8CuNZfW+Bsj
         0Z0Hjv/o1Y0cDm7soUF5myYky8fQRZXkf/KQJ7ArGW07U3Wkmxye9ok3RwIHLpnRHTEU
         QMBes9cB5RtVnnMRqI70dx6SYpQi0jYfy7qHZxHIdO0Ad2U32ea0Tn7fRi3yjQINH6tw
         T8RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770135128; x=1770739928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        b=AxhekHSELVLKOo3FYHbVT2qZpM6RKlitYeyZqwDwVR/4s7jxrV+h9SiHNbmQdr/3D6
         57gKBKJZDEj1OEnS0itIagto3vVC6Qq8FlE3V/H0c/elq4YYAb9DZ+I8RXFPmzw7+kDQ
         G0ZLdoG/KQu28HDJAD8f/BcHB8Uc4mTIhFQ5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135128; x=1770739928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        b=vFlt4eW1yWXJG0TQVv81m+H9xcKTRPKcHU9ifRROb1BcVLs6r+se+ZFl+ARXrSKeLc
         swezIT/BnjAoMvwcmtjhnKDqSTryLVx3aVYuxbJ080LUg/RaaHwHO7lisffzN8souMRO
         X4BZt2gVqYTE7PELvpvIpKLGz2FwDY3e0lK5oA6IAPMDU3J4tpWFhsShyetmDH9vDMdD
         aD6Koi/X2Cd9Jr4BBZSPBdzjD0E0o/2uGfemVIjae6lpfhPQGbETKQwo9XI0PrWMpYF+
         isju20VfYDOlat0YcxSIYIuqyb9PZWGTaDZHIfrs1KIjqT9SMjvMfjAr3mrujWhdyjAP
         sIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBLQn2bdT5dywstjO69qgL+rQvm1bMXRe7IyFEbnzqK11rcJSzTsX4rLTy8hsqS16hjmdvg1MyUjUD4Iu0@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZKfM641/YOOrFFqY6wwI6PRM+yySwnX/JmdcY85OhEWb0ZMm
	6DP1xYSDYAP6n7sR3+WmQEINGApI8z9wqz4PkyrLUhfTsSZJIYyNtwnhubbDXsx77W9M7fTy5c8
	LQeQ4fv6fdaPy+9ITEfCw3XEmVdNFx52+ex6jC1Uub1Qju09KNJbWxSQLLPoK
X-Gm-Gg: AZuq6aJMwR/75aZBezkiIIx6ECi/nFh6VrP11DdE29TYTdr2rQJhRhZF8+Gt3MeUf8e
	ZWc59PmFtJzB7gw09GForc53/tVnaPidqPlsN/eimYb/9Mzs2cX3d6YurhGYMo9v2t05a6DPXNb
	tOhqgSjpmbFUVTzm78PSoTjnoDQqXmZ+QGcp8ssvH1yOFKu2i80CZhmR2no8LnwfwZAXYUlQyyN
	satM/pLzChrxQiBE44FhoOSbid80cPVkYaA41IqO1L12rGgqp9yPQCKi6I8p8czdiekXg==
X-Received: by 2002:a05:6512:361a:b0:59e:174e:fce0 with SMTP id
 2adb3069b0e04-59e174efd13mr3804850e87.42.1770135127877; Tue, 03 Feb 2026
 08:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
In-Reply-To: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Feb 2026 17:11:55 +0100
X-Gm-Features: AZwV_Qh3STuAfXyfImYoG9ogVPD44LxztQyiZo154t6EomlvRura8CdCgjeoM8I
Message-ID: <CAJqdLrphO1GnAZ2=n8wQAP7B+ZwFnD0wSLY7sAjacZTpLZrqBg@mail.gmail.com>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76208-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mihalicyn.com:dkim]
X-Rspamd-Queue-Id: DFA0CDBD37
X-Rspamd-Action: no action

Am Do., 29. Jan. 2026 um 22:48 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> container that doesn't have FS_USERNS_MOUNT set.
>

Hi Jeff,

> This broke NFS mounts in our containerized environment. We have a daemon
> somewhat like systemd-mountfsd running in the init_ns. A process does a
> fsopen() inside the container and passes it to the daemon via unix
> socket.
>
> The daemon then vets that the request is for an allowed NFS server and
> performs the mount. This now fails because the fc->user_ns is set to the
> value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> want to add FS_USERNS_MOUNT to NFS since that would allow the container
> to mount any NFS server (even malicious ones).
>
> Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.

Great idea, very similar to what we have with BPFFS/BPF Tokens.

Taking into account this patch, shouldn't we drop FS_USERNS_MOUNT and
replace it with
FS_USERNS_DELEGATABLE for bpffs too?

I mean something like:

======================
$ git diff
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..d8dfdc846bd0 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block
*sb, struct fs_context *fc)
        struct inode *inode;
        int ret;

-       /* Mounting an instance of BPF FS requires privileges */
-       if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
-               return -EPERM;
-
        ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
        if (ret)
                return ret;
@@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
        .init_fs_context = bpf_init_fs_context,
        .parameters     = bpf_fs_parameters,
        .kill_sb        = bpf_kill_super,
-       .fs_flags       = FS_USERNS_MOUNT,
+       .fs_flags       = FS_USERNS_DELEGATABLE,
 };

 static int __init bpf_init(void)
======================

Because it feels like we were basically implementing this FS_USERNS_DELEGATABLE
flag implicitly for BPFFS before. I can submit a patch for BPFFS later
after testing.

>
> Fixes: e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Kind regards,
Alex

> ---
>  fs/nfs/fs_context.c |  8 ++++++--
>  fs/super.c          | 11 ++++++-----
>  include/linux/fs.h  |  1 +
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index b4679b7161b0968810e13f57c889052ea015bf56..128ebd48b4f4ba1c17e8b5b1b9dcefbd7a97db1a 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1768,7 +1768,9 @@ struct file_system_type nfs_fs_type = {
>         .init_fs_context        = nfs_init_fs_context,
>         .parameters             = nfs_fs_parameters,
>         .kill_sb                = nfs_kill_super,
> -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +       .fs_flags               = FS_RENAME_DOES_D_MOVE |
> +                                 FS_BINARY_MOUNTDATA   |
> +                                 FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs");
>  EXPORT_SYMBOL_GPL(nfs_fs_type);
> @@ -1780,7 +1782,9 @@ struct file_system_type nfs4_fs_type = {
>         .init_fs_context        = nfs_init_fs_context,
>         .parameters             = nfs_fs_parameters,
>         .kill_sb                = nfs_kill_super,
> -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +       .fs_flags               = FS_RENAME_DOES_D_MOVE |
> +                                 FS_BINARY_MOUNTDATA   |
> +                                 FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs4");
>  MODULE_ALIAS("nfs4");
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d14001d51524dbaec0778af8f12c048ac..b7f1bb2b679b43261fbdcd586971c551b85e8372 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -738,12 +738,13 @@ struct super_block *sget_fc(struct fs_context *fc,
>         int err;
>
>         /*
> -        * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
> -        * not set, as the filesystem is likely unprepared to handle it.
> -        * This can happen when fsconfig() is called from init_user_ns with
> -        * an fs_fd opened in another user namespace.
> +        * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT or
> +        * FS_USERNS_DELEGATABLE is not set, as the filesystem is likely
> +        * unprepared to handle it. This can happen when fsconfig() is called
> +        * from init_user_ns with an fs_fd opened in another user namespace.
>          */
> -       if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
> +       if (user_ns != &init_user_ns &&
> +           !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
>                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
>                 return ERR_PTR(-EPERM);
>         }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a01621fa636a60764e1dfe83f2260caf50c4037e..94695ce5e25b5fbe4f321d5478172b8cb24e00d1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2273,6 +2273,7 @@ struct file_system_type {
>  #define FS_MGTIME              64      /* FS uses multigrain timestamps */
>  #define FS_LBS                 128     /* FS supports LBS */
>  #define FS_POWER_FREEZE                256     /* Always freeze on suspend/hibernate */
> +#define FS_USERNS_DELEGATABLE  512     /* Can be mounted inside userns from outside */
>  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during rename() internally. */
>         int (*init_fs_context)(struct fs_context *);
>         const struct fs_parameter_spec *parameters;
>
> ---
> base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
> change-id: 20260129-twmount-114ddfd43420
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

