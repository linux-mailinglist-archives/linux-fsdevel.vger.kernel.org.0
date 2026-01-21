Return-Path: <linux-fsdevel+bounces-74825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC7nHQ2ecGlyYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:36:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40573547F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A1E35C7FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC65546AF36;
	Wed, 21 Jan 2026 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCQpM/mT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE03A8FF5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987537; cv=pass; b=egSXpIC0jEypN11RrxjpyWtUOANY8vKzKqEi3Rn39G5e7PRwjfsNwffVXVeag0wGJmTbBVTtwYt5nuN0D4H3zctu2SHslFTdMN+lVKEPycapF56H1JuTTFazXSai92toqQ02khkT2eIzashS5UMlzN5SsZVQeEUspRdZqqs3kAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987537; c=relaxed/simple;
	bh=QHugJybIn+A13bUi62gHbfpfGj3a683riqV/MptVDbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB1K7Y+ovqCEYXaHXuuzJmPyVqDesjYAqQmslutO+w62XnKmNHs1nbEA0nGfPyoBaRa9lpErx0I5a3ylQpN/nvEq4pGxw3Q90u29SIAkl0KMJTEVRnO80ovM+B/JwGFyCBjb+Nflmd9aSr2C8fGxhW6H59jSnHcfv07H3CM8OVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCQpM/mT; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso1337885a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 01:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987533; cv=none;
        d=google.com; s=arc-20240605;
        b=fyj9vEuV+372nYNKWfwjAZ0zSLMMdtiOzeFdSm2mZS94Hpvx3V5/KdA90srKSXRq7v
         +SCmMs+M/u+TXerJYe7HdndKLHAxdfiZFLP9DSgq6PKEj0Vve3hLSJC9hoWUQ1g5P8qV
         /JX4mK264aqP4WYjj8jx8/gRH8oTLKDNWGGPPIsT9c00EuN36os98+0cm7JNyoQhm16+
         6bgjxGjmLPOYi/tiXJi05ee5jygXppFh6u9q7U5+QERmFvUU9AyrBZipNmzCoQgU80l+
         Rm7E0k305jfP6Oobic3mlmYoExvr5l3fy+YLjvk6Z+j5bN0TI70zBXjQa+BghvGIIwv2
         i/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        fh=rKCN/Svx90W/gEhyHUfNa72gTB57DCSZRtZJPCAhSCU=;
        b=QKUxk+3BxYv4GDjwygCZ8jWYNgnzBE6+ok4Bra8zY8DEdBMkVbCN85hdZM7G687ZJj
         L1W5ZZR/DKrupRIzJfiVT1qWe93qQuvWParTGW0kfYw8ZKtYdnz+e4PTgluodFI/oXIW
         afRuPE/cOVQTtHkYM8Tx58+qWfwltv3imQOz5eDmXDDT8VANXSFhVPcuxKX+u4oje9Fp
         lqC4dfuuQDdDFzvUAeRge+PxWyqkfKdaQRVTIzTdYTsPlI6c8M40QrDg1JOca/x4GNFE
         ADZaDHE+TAB+LcrD+29LD6S9N2vLtVpfWHMDBG+U8Qz/J5yjMx9eOC5c8nHDh7bkKYJt
         q2pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987533; x=1769592333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        b=RCQpM/mTCf0IblwbblMvXor3Ww5iKS14y0hIGBnXAGD2vs5lrrO0h90Uh2ggtKjg7E
         vtkCbY9KgRnVP15t3soAYBliMpAJgZLejOWxcfhpeHpop1dFNC3CGlbidbiPy+Ew8YAh
         TrTY484JamF1DNlfN3QE5BAbi9D+J0l6WbIBM5DX4FzRh5c62ySsUAjaTKwTWpiPlNpz
         1Lkaz8+HbfKPr4IcmUfsxlNY+Gx9CgoOTT263ddJru4F060cSyx5m4N1PdMM8uh/1EiC
         lQUsSJy/4pSMuh0L1c558fphhp1thud85h/8TjLEoLDpNwjTKu3vOxUYvev0wv1Dr1MB
         9A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987533; x=1769592333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        b=bs3oPHDb97FbGZF5SdEaNwtrmJuCVNWpV1PKdF4/oPW+Oy+roBVh0DTJA7Rm9GrEeQ
         37UbLqnbwYWppGJrlskcxPaH+Uz0w5WejbcMH7jghRt7zuM9l5Ql4JiXwrfeq44LDPYu
         uSeWh+LfvTCPD5n0AW34lN0WIvUrhwFZ8+5BUg0a8pDw2DPC2XzGQPD2+xj9ZnycS56f
         xvMYKmatxR+ozsv5pKrvD3bGtBgfuRzRphzatzlBxNbYGkWTk9iV1g0CH6xOrXt0WsnA
         Gmir8V4vmDUFJvLLTx31mRwj5L++k8iBrYOmvOWh0lPTwraPGMyleKsHAiSxf0LywA+c
         ohjg==
X-Forwarded-Encrypted: i=1; AJvYcCWweGtZPnOWiVU0XaCi8Rc0ylk9kyJa4Jh2UmZ1l26PmkZcdX7ir7ZzKhdcgrtTgTb5cNECoVxOoBdAw1ND@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJG+FNLcNG9nBRFhlgr/eoP3eW6WetHUt03O/PHUexyAfYz2M
	Vhmf69UGWTa2Q66B9xcgIC+0gjiOk4SbcYxsf+MNoNW4oBSSilofHBsuyWvCwpNl6ZhCQmtY/KV
	wSNe83laDs04MIrXM0Blwy+UUwex/jPY=
X-Gm-Gg: AZuq6aJy5fKLgwKX54X6fgb4ICJUpM8iitKa3B3wtt7cce7ubeoI755zczql7/66iEO
	B17zQxT0jZrFsJf8PEHB2lzYPnMWWX3BYIa7NDns3Tchr/D2dgZ8UWU1+1UiCHiDuiWXgvp7zae
	0kz9tsJqsuAIsvY3gfBN7uoYMbvJXsD2ZdPIs8LVxDxd8OshKisBb3jxPRlWzJD/PAeMYCh+f3R
	u4G2pI7czvbywfduuJ0FwTUMt//w7kL+VKxxfW+l5sbhx5G8T3FidtTag7/CHwVuRS43mus+9KG
	Mf3YrU2vAiNcC8ZqcLCnEUWRM0ahGQ==
X-Received: by 2002:aa7:c708:0:b0:658:ded:97c8 with SMTP id
 4fb4d7f45d1cf-6580ded999fmr1927493a12.9.1768987532701; Wed, 21 Jan 2026
 01:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085028.558164-1-amir73il@gmail.com>
In-Reply-To: <20260121085028.558164-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 10:25:21 +0100
X-Gm-Features: AZwV_Qha9OC9bEP43y2_OZbfZ-P8E78cWE_KF4QdlarDuJNF0ODtiZxG6MZgt5E
Message-ID: <CAOQ4uxikycvR4+z34Ox5tuoaFoX3XyUkv6mP53V38b25_tNhQQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-74825-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 40573547F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[cc the correct email address for Neil]

On Wed, Jan 21, 2026 at 9:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).
>
> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
>
> Therefore, do not allow nfsd to export filesystems with custom ->open()
> or ->permission() methods.
>
> Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> Christian,
>
> I had enough of the stable file handles discussion [1].
>
> This patch which I already suggested [2] on week ago, states a justified
> technical reason why pidfs and nsfs should not be exported by nfsd,
> so let's use this technical reasoning and stop the philosophic discussion=
s
> about what is a stable file handle is please.
>
> Regarding cgroupfs, we can either deal with it later or not - it is not
> a clear but as pidfs and nsfs which absolutely should be fixed
> retroactively in stable kernels.
>
> If you think that cgroupfs could benefit from "exhaustive" file handles [=
3]
> then we can implement open_by_handle_at(FD_CGROUPFS_ROOT, ... and that
> would classify cgroupfs the same as pidfs and nsfs.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-0-1a=
247645cef5@kernel.org/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5=
CGiyUjB=3D8YA2zTbOtFvw@mail.gmail.com/
> [3] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-29-1=
a247645cef5@kernel.org/
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad196..232dacac611e9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct sv=
c_export *);
>  static int check_export(const struct path *path, int *flags, unsigned ch=
ar *uuid)
>  {
>         struct inode *inode =3D d_inode(path->dentry);
> +       const struct export_operations *nop =3D inode->i_sb->s_export_op;
>
>         /*
>          * We currently export only dirs, regular files, and (for v4
> @@ -422,13 +423,12 @@ static int check_export(const struct path *path, in=
t *flags, unsigned char *uuid
>         if (*flags & NFSEXP_V4ROOT)
>                 *flags |=3D NFSEXP_READONLY;
>
> -       /* There are two requirements on a filesystem to be exportable.
> -        * 1:  We must be able to identify the filesystem from a number.
> -        *       either a device number (so FS_REQUIRES_DEV needed)
> -        *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> -        * 2:  We must be able to find an inode from a filehandle.
> -        *       This means that s_export_op must be set.
> -        * 3: We must not currently be on an idmapped mount.
> +       /*
> +        * The requirements for a filesystem to be exportable:
> +        * 1. The filehandle must identify a filesystem by number
> +        * 2. The filehandle must uniquely identify an inode
> +        * 3. The filesystem must not have custom filehandle open/perm me=
thods
> +        * 4. The requested file must not reside on an idmapped mount
>          */
>         if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
>             !(*flags & NFSEXP_FSID) &&
> @@ -437,11 +437,16 @@ static int check_export(const struct path *path, in=
t *flags, unsigned char *uuid
>                 return -EINVAL;
>         }
>
> -       if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +       if (!exportfs_can_decode_fh(nop)) {
>                 dprintk("exp_export: export of invalid fs type.\n");
>                 return -EINVAL;
>         }
>
> +       if (nop->open || nop->permission) {
> +               dprintk("exp_export: export of non-standard fs type.\n");
> +               return -EINVAL;
> +       }
> +
>         if (is_idmapped_mnt(path->mnt)) {
>                 dprintk("exp_export: export of idmapped mounts not yet su=
pported.\n");
>                 return -EINVAL;
> --
> 2.52.0
>

