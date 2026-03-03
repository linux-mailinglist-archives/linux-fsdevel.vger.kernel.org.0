Return-Path: <linux-fsdevel+bounces-79117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cRa6CAB8pmmuQQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 07:13:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DA1E96A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16A6E304D27E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DB36D9EC;
	Tue,  3 Mar 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5VJyDwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B1358365
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518394; cv=none; b=t6aMChM2cuYNKRPuOwO8q9dLqO/bNoDmH2tF/kYeu9gm3u0tt7uB1sZNjqYPXSrpIZuxkoeaxHUywDbWgbwAR82/+gZtzJgqVPLxbm6KAGgpuQeZzH4CDUab79q05SzZBc3CbWwHPmrBtLPQd90/MCEzSjwLRbDP+nXYXjr0sPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518394; c=relaxed/simple;
	bh=DqZX3rhR2GMV+s0NreNBLS9w6THmjh7tD40pCk278zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQhUcUVZADKg0ZM+JF/PimtJHAkEN1onnimKlPqJg8aQ4Js+/xI44n8OgdAeHzspg8vTGh8XNEyoJD+lTa9dq4Z73PYZhRucc2Id01v+EbD/yBBU5eLFosLEyXk/wwD9Xu++ud6y1UehDzkujWSDMDCJJImI7Ottp5VvI6y/Fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5VJyDwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C71C116C6
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772518394;
	bh=DqZX3rhR2GMV+s0NreNBLS9w6THmjh7tD40pCk278zE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B5VJyDwEp2fezGfw7WGTeMuKt1iGO7nFQiA4G97nmKzslO+eProFBIx0HayNWG9Bu
	 m9CZ8R9V7hiGWyyevVKUqUq1MThEfVYCseMvmdEzJN537nGKLMnfnBxy8lsonBVxKl
	 Qsw+1pRWOfC+7DQ0TMg7sYWMbv5uH1G/l7jxY/wqcO0r6aHyPS29losVCZfMIajepe
	 +3u6FF6GAg9m1rlVs2ajRYJwvoL48Y3mN22HS8BoS/aTajWR73lpRrqIcPVjPZI7a0
	 j5Y0Gz4yb+OpMN7cwN0hjtYzeKljWbhN5mk2fw/edp80b0NBVokeOLZZ+Q+KQ6sdtH
	 5TTV5ZqF1uVYw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8fb3c4bbc4so792003266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 22:13:14 -0800 (PST)
X-Gm-Message-State: AOJu0YxWXcw4W7gn3dtQtTLmK9Ck51Jy5DU56SKnxCUaorPlopPYpFg8
	5AuJ4DPRQ+VfrOgZbk0HdheioHmM88QjYHM3i2YIjAOqohnlVSJ879sZd9ZaqcGiY+iJLPwfdrV
	DcEXgo1txdMcqcfPJwEMgWQKCDHK7ub0=
X-Received: by 2002:a17:906:1d51:b0:b92:7cc:2776 with SMTP id
 a640c23a62f3a-b93765111b4mr700296066b.31.1772518392784; Mon, 02 Mar 2026
 22:13:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228084542.485615-1-dxdt@dev.snart.me> <20260228084542.485615-2-dxdt@dev.snart.me>
In-Reply-To: <20260228084542.485615-2-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Mar 2026 15:13:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_j8hxEVWZFYgqcEz+OtgPX+tUBJ7j44NomiFZ0efd1bw@mail.gmail.com>
X-Gm-Features: AaiRm53eJR1s84yKfYSzT_T1VBK7cjnes0FqDcIf3Ng_egX6uZMvQX4OYsdMD6g
Message-ID: <CAKYAXd_j8hxEVWZFYgqcEz+OtgPX+tUBJ7j44NomiFZ0efd1bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] exfat: add fallocate mode 0 support
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B9DA1E96A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[snart.me:server fail,mail.gmail.com:server fail,sea.lore.kernel.org:server fail];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79117-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 5:46=E2=80=AFPM David Timber <dxdt@dev.snart.me> wr=
ote:
Ah, I see it now.
Please CC me and exFAT maintainer/reviewers from next time.
>
> Currently, the Linux (ex)FAT drivers do not employ any cluster
> allocation strategy to keep fragmentation at bay. As a result, when
> multiple processes are competing for new clusters to expand files in
> exfat filesystem on Linux simultaneously, the files end up heavily
> fragmented. HDDs are most impacted, but this could also have some
> negative impact on various forms of flash memory depending on the
> type of underlying technology.
>
> For instance, modern digital cameras produce multiple media files for a
> single video stream. If the application does not take the fragmentation
> issue into account or the system is under memory pressure, the kernel
> end up allocating clusters in said files in a interleaved manner.
>
> Demo script:
>
>         for (( i =3D 0; i < 4; i +=3D 1 ));
>         do
>             dd if=3D/dev/urandom iflag=3Dfullblock bs=3D1M count=3D64 of=
=3Dfrag-$i &
>         done
>         for (( i =3D 0; i < 4; i +=3D 1 ));
>         do
>             wait
>         done
>
>         filefrag frag-*
>
> Result - Linux kernel native exfat, async mount:
>         780 extents found
>         740 extents found
>         809 extents found
>         712 extents found
>
> Result - Linux kernel native exfat, sync mount:
>         1852 extents found
>         1836 extents found
>         1846 extents found
>         1881 extents found
>
> Result - Windows XP:
>         3 extents found
>         3 extents found
>         3 extents found
>         2 extents found
>
> Windows kernel, on the other hand, regardless of the underlying storage
> interface or the medium, seems to space out clusters for each file.
> Similar strategy has to be employed by Linux fat filesystems for
> efficient utilisation of storage backend.
>
> In the meantime, userspace applications like rsync may
> use fallocate to to combat this issue.
>
> This patch may introduce a regression-like behaviour to some niche
> filesystem-agnostic applications that use fallocate and proceed to
> non-sequentially write to the file. Examples:
>
>  - libtorrent's use of posix_fallocate() and the first fragment from a
>    peer is near the end of the file
>  - "Download accelerators" that do partial content requests(HTTP 206)
>    in multiple threads writing to the same file
>
> The delay incurred in such use cases is documented in WinAPI. Patches
> that add the ioctl equivalents to the WinAPI function
> SetFileValidData() and `fsutil file queryvaliddata ...` will follow.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
> ---
>  fs/exfat/file.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 90cd540afeaa..4ab7e7e90ae6 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -13,6 +13,7 @@
>  #include <linux/msdos_fs.h>
>  #include <linux/writeback.h>
>  #include <linux/filelock.h>
> +#include <linux/falloc.h>
>
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -90,6 +91,45 @@ static int exfat_cont_expand(struct inode *inode, loff=
_t size)
>         return -EIO;
>  }
>
> +/*
> + * Preallocate space for a file. This implements exfat's fallocate file
> + * operation, which gets called from sys_fallocate system call. User spa=
ce
> + * requests len bytes at offset. In contrary to fat, we only support "mo=
de 0"
> + * because by leaving the valid data length(VDL) field, it is unnecessar=
y to
> + * zero out the newly allocated clusters.
> + */
> +static long exfat_fallocate(struct file *file, int mode,
> +                         loff_t offset, loff_t len)
> +{
> +       struct inode *inode =3D file->f_mapping->host;
> +       loff_t newsize =3D offset + len;
> +       int err =3D 0;
> +
> +       /* No support for other modes */
> +       if (mode !=3D 0)
> +               return -EOPNOTSUPP;
> +
> +       /* No support for dir */
> +       if (!S_ISREG(inode->i_mode))
> +               return -EOPNOTSUPP;
> +
> +       if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> +               return -EIO;
> +
> +       inode_lock(inode);
> +
> +       if (newsize <=3D i_size_read(inode))
> +               goto error;
> +
> +       /* This is just an expanding truncate */
> +       err =3D exfat_cont_expand(inode, newsize);
> +
> +error:
> +       inode_unlock(inode);
> +
> +       return err;
> +}
> +
>  static bool exfat_allow_set_time(struct mnt_idmap *idmap,
>                                  struct exfat_sb_info *sbi, struct inode =
*inode)
>  {
> @@ -771,6 +811,7 @@ const struct file_operations exfat_file_operations =
=3D {
>         .fsync          =3D exfat_file_fsync,
>         .splice_read    =3D exfat_splice_read,
>         .splice_write   =3D iter_file_splice_write,
> +       .fallocate      =3D exfat_fallocate,
>         .setlease       =3D generic_setlease,
>  };
>
> --
> 2.53.0.1.ga224b40d3f.dirty
>
>

