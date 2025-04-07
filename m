Return-Path: <linux-fsdevel+bounces-45866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA468A7DE67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D41889DED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DBE241696;
	Mon,  7 Apr 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2egSpxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A021E4BE;
	Mon,  7 Apr 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030872; cv=none; b=mr/rDd4gNi+EomQKhdCNQZanW0Lud3/FFm25n16sCGJeVH4z437UT3CL6YndKnVC/gNPdwYLnDOjn2r637Wt9OKis1xXKWBkt4ld1O2l0JEGNR4WzZxxzviTAYVp00/lOk9uZijOSolhuBkbUaqcpwg8yzs3GKc9uKklUjQAqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030872; c=relaxed/simple;
	bh=swQ42VWSGclVMOp1KzNKztiNW8v5JoW4Me8J1MRpsEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgLPN6HZBt29NXEPFK44yBucPd6UmRb5la2aCfWU3Ya0N8qerhZMNhCS7QitKf360312Zj3ewbzMh7ma6NOa41ybqxAGbuqhgoY1KaMoggjclbq6z6X7QpUC3EKsQrU/dAJtbh1J6mmVmZKgz6XtoeyGbJ0eIy5JpEejq2G/1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2egSpxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021BC4CEE7;
	Mon,  7 Apr 2025 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744030871;
	bh=swQ42VWSGclVMOp1KzNKztiNW8v5JoW4Me8J1MRpsEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t2egSpxcxXzT9tJtfEQmMOGg6OQY5+lxpuaVn6dDpt6iyukYKop2yQ++1ra5/dR8R
	 K3F4IPyzIF8kjwElfk0g4Z+wM4DhhRdLWqdqPuR0z8LX9aaR5SwCq3Gem8uWiuTtpW
	 TTx+TTHiVnU5stjWUvB8qe3H/Zjy0GORQ1ezhPut2puu6XPJaumCCqpLUxDQ/xgngF
	 kyl0Oow8eQD7tuq1Z65Qw8zrkOWTc152qNOQSomIIh5ItBE5PeaZHzlwR2o/i+xJ3e
	 MEiNfOizPSvp4USA7Zlb/uH5wQi+R2hjbmK+1jxcCf3S8qKMJlcxOQON8V80jEho6T
	 jHD6bKYuVo4MA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc44c72959so2602823fac.0;
        Mon, 07 Apr 2025 06:01:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/HDpHrknJRgaCku7e9jfj19534DDwU5HniEndGaCL2CoGHHRf1T6da+ctTfJC+tuT73mfUxwgVmY2zjzH@vger.kernel.org, AJvYcCWU46WU/O7PjIcwUGNi/nDocS8qzpEMqGlkxiFKAEiVSngrEL5Mk1m6kdbHQ5PMJIqRwjAj0burVBWxqeU/@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFK4Noh+mNI6buEbSWNVdIfnQFV5Fl7k8sHREHP8oSShRFSWJ
	avjd7wReP+cR1UuA+hrIO+WYcqjLRic4lNi7M7sVi3fivCtBFpSrtoGkvvn5ub2s43bQWjqR1O8
	3bh3f9IerE0l44OGmnbGVPLzW4PM=
X-Google-Smtp-Source: AGHT+IFUsthTvsXxiDkToDYnoQrtj8Lsz+y/Ya181Sq6lQZJ8XX2jRuW3mVWIFagWVO0JNGF3otHDzyd7JbslhrnCpk=
X-Received: by 2002:a05:6871:71c5:b0:2a7:d8cb:5284 with SMTP id
 586e51a60fabf-2cca188c89amr6866768fac.7.1744030870944; Mon, 07 Apr 2025
 06:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407102345.50130-1-ailiop@suse.com>
In-Reply-To: <20250407102345.50130-1-ailiop@suse.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 7 Apr 2025 22:00:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_i4V-BRXBtke4Ditp+siT3O=6atuTQ+Ffu8F9xtrNDCQ@mail.gmail.com>
X-Gm-Features: ATxdqUEtyhybxEwFYz0exRofUqyuLhFreYCQiqYGbMQJ7frJrHmvmOpQcFFxX0c
Message-ID: <CAKYAXd_i4V-BRXBtke4Ditp+siT3O=6atuTQ+Ffu8F9xtrNDCQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: enable request merging for dir readahead
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:23=E2=80=AFPM Anthony Iliopoulos <ailiop@suse.com>=
 wrote:
>
> Directory listings that need to access the inode metadata (e.g. via
> statx to obtain the file types) of large filesystems with lots of
> metadata that aren't yet in dcache, will take a long time due to the
> directory readahead submitting one io request at a time which although
> targeting sequential disk sectors (up to EXFAT_MAX_RA_SIZE) are not
> merged at the block layer.
>
> Add plugging around sb_breadahead so that the requests can be batched
> and submitted jointly to the block layer where they can be merged by the
> io schedulers, instead of having each request individually submitted to
> the hardware queues.
>
> This significantly improves the throughput of directory listings as it
> also minimizes the number of io completions and related handling from
> the device driver side.
>
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  fs/exfat/dir.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 3103b932b674..a46ab2690b4d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c

Hi Anthony,
> @@ -621,6 +621,7 @@ static int exfat_dir_readahead(struct super_block *sb=
, sector_t sec)
>  {
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
>         struct buffer_head *bh;
> +       struct blk_plug plug;
>         unsigned int max_ra_count =3D EXFAT_MAX_RA_SIZE >> sb->s_blocksiz=
e_bits;
>         unsigned int page_ra_count =3D PAGE_SIZE >> sb->s_blocksize_bits;
>         unsigned int adj_ra_count =3D max(sbi->sect_per_clus, page_ra_cou=
nt);
> @@ -644,8 +645,10 @@ static int exfat_dir_readahead(struct super_block *s=
b, sector_t sec)
>         if (!bh || !buffer_uptodate(bh)) {
>                 unsigned int i;
It is better to move plug declaration here.
Thanks!
>
> +               blk_start_plug(&plug);
>                 for (i =3D 0; i < ra_count; i++)
>                         sb_breadahead(sb, (sector_t)(sec + i));
> +               blk_finish_plug(&plug);
>         }
>         brelse(bh);
>         return 0;
> --
> 2.49.0
>

