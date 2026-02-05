Return-Path: <linux-fsdevel+bounces-76358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JgdFAT1g2kwwQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 02:40:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1167EDB63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 820D43016499
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076C296BB6;
	Thu,  5 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiWRq8Zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F114F9D6
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255612; cv=none; b=LwiGx59l8wlFvXtAQooJuNMFSNoJjnFSeaxtsafZ+PUQAtijCNF1qtSBXlU1j8IRUQA6cmPWCCg0cNqQvfNNeCy5gUGtktos4ENAgHkqiZ7BoaVkOW32GIrviqQrbYnW0aCZT7v17iYNQlqm+SquaYTtxynHWTrxZdcwsMnYacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255612; c=relaxed/simple;
	bh=fWuxbytzJ1HBuBuWxhIcBh3Nrj4UTDCwX5abaLg5mL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBFjXgyh+zFRz428x5E5TogQJNUa0sguNj7t078g0GqkqE5ipGbs3GUDrEKzV9+feUbbrzOx4Tue8Rkzj/droQJTrPhw2y2IasJP7z0gE9vNwftCsQT/bKusrcVE6pltX/O1Gf1103K9xL2huM4rulrl+eddzxruP2YESKW6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiWRq8Zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63615C19425
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770255612;
	bh=fWuxbytzJ1HBuBuWxhIcBh3Nrj4UTDCwX5abaLg5mL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DiWRq8Zbn7ncszD96QgjY1VraQwB6VygHp8B4BQhdveY3+rLCjDm301M+Q1d+Trei
	 Yd+ot/NeDU3wbK2vebcps0Kz8ISG3V2UbP4p7BXYxgkWIvzqCB9zC9jUX6cbEKSZFe
	 VXa2yLg/DU8YSXIEljZJ01qOWKNwk2hKczDys3SnuQwFQcbTF9YenHxcVZQ3i9oC9u
	 ZYZX0p/Ww3M7821KFwcyc+qrivcdn170rpE/9cexY7Wwv7aXHnCS+AyYEmPJ9uL7pK
	 VfG2iAwaGt8NG9MG5QiekMlqLj0C8DcvjHAszKffn1VPObJr8jhaxTfAoHWjhk22jo
	 xcj6Yk+ySdCHw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so833971a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 17:40:12 -0800 (PST)
X-Gm-Message-State: AOJu0YyQjfrKlwwkU47HM9aeZ2pGKrKQAW5Mi0JWc79gfMHEL4YWhMpT
	Zbc0eo+h6t+/sswqzgNnNn+EylOX6PjJeJ5h1mP2nLw+f8GJL3Q+TyUeGmqWiySGvGCA5UvC60u
	nVka9N2bhx9FqGuu7drynjBC/D3DtR9E=
X-Received: by 2002:a05:6402:f29:b0:64f:d03a:9af4 with SMTP id
 4fb4d7f45d1cf-65949bb6f07mr2584593a12.3.1770255610848; Wed, 04 Feb 2026
 17:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204071435.602246-1-chizhiling@163.com> <20260204071435.602246-2-chizhiling@163.com>
In-Reply-To: <20260204071435.602246-2-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 5 Feb 2026 10:39:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-xgjbF1u4x9KZvoaVa0xL7LL6Mie_gL9v+UpfCPpH6BQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh8f91Mr39e9Eekgd0iwsjk1A8RdTtLXeruf3zgtgVsup1qiSyNmjwiPtQ
Message-ID: <CAKYAXd-xgjbF1u4x9KZvoaVa0xL7LL6Mie_gL9v+UpfCPpH6BQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] exfat: add block readahead in exfat_chain_cont_cluster
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76358-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: C1167EDB63
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 4:15=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wro=
te:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> The conversion from NO_FAT_CHAIN format to FAT_CHAIN format occurs
> when the file cannot allocate contiguous space. When the file to be
> converted is very large, this process can take a long time.
>
> This patch introduces simple readahead to read all the blocks in
> advance, as these blocks are consecutive.
>
> Test in an empty exfat filesystem:
> dd if=3D/dev/zero of=3D/mnt/file bs=3D1M count=3D30k
> dd if=3D/dev/zero of=3D/mnt/file2 bs=3D1M count=3D1
> time cat /mnt/file2 >> /mnt/file
>
> | cluster size | before patch | after patch |
> | ------------ | ------------ | ----------- |
> | 512          | 47.667s      | 4.316s      |
> | 4k           | 6.436s       | 0.541s      |
> | 32k          | 0.758s       | 0.071s      |
> | 256k         | 0.117s       | 0.011s      |
>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  fs/exfat/exfat_fs.h |  9 +++++++--
>  fs/exfat/fatent.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 2dbed5f8ec26..5a3cdf725846 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -10,6 +10,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/nls.h>
>  #include <linux/blkdev.h>
> +#include <linux/backing-dev.h>
>  #include <uapi/linux/exfat.h>
>
>  #define EXFAT_ROOT_INO         1
> @@ -79,6 +80,10 @@ enum {
>  #define EXFAT_HINT_NONE                -1
>  #define EXFAT_MIN_SUBDIR       2
>
> +#define EXFAT_BLK_RA_SIZE(sb)          \
> +(min((sb)->s_bdi->ra_pages, (sb)->s_bdi->io_pages) \
> +        << (PAGE_SHIFT - sb->s_blocksize_bits))
> +
>  /*
>   * helpers for cluster size to byte conversion.
>   */
> @@ -117,9 +122,9 @@ enum {
>  #define FAT_ENT_SIZE (4)
>  #define FAT_ENT_SIZE_BITS (2)
>  #define FAT_ENT_OFFSET_SECTOR(sb, loc) (EXFAT_SB(sb)->FAT1_start_sector =
+ \
> -       (((u64)loc << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
> +       (((u64)(loc) << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
>  #define FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc) \
> -       ((loc << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
> +       (((loc) << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
>
>  /*
>   * helpers for bitmap.
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index 71ee16479c43..0c17621587d5 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -142,13 +142,51 @@ int exfat_ent_get(struct super_block *sb, unsigned =
int loc,
>         return -EIO;
>  }
>
> +static int exfat_blk_readahead(struct super_block *sb, sector_t sec,
> +               sector_t *ra, blkcnt_t *ra_cnt, sector_t end)
> +{
> +       struct blk_plug plug;
> +
> +       if (sec < *ra)
> +               return 0;
> +
> +       *ra +=3D *ra_cnt;
> +
> +       /* No blocks left (or only the last block), skip readahead. */
> +       if (*ra >=3D end)
> +               return 0;
> +
> +       *ra_cnt =3D min(end - *ra + 1, EXFAT_BLK_RA_SIZE(sb));
> +       if (*ra_cnt =3D=3D 0) {
> +               /* Move 'ra' to the end to disable readahead. */
> +               *ra =3D end;
> +               return 0;
> +       }
> +
> +       blk_start_plug(&plug);
> +       for (unsigned int i =3D 0; i < *ra_cnt; i++)
> +               sb_breadahead(sb, *ra + i);
> +       blk_finish_plug(&plug);
> +       return 0;
> +}
Can you combine multiple readahead codes (readahead in
exfat_allocate_bitmap, exfat_dir_readahead) in exfat?
Thanks.

