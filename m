Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ECC3E4B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhHIRwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHIRwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:52:11 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF2C061796
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 10:51:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kk23so8771813qvb.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+jgm8f6qLwVRwqw+onxb7pUQp2OzWLj5MWSH/TZR1lg=;
        b=k7xueK+4mzlwQUXdMpnpVWcp6qTmXBLHD5nXWjbJU/SR8aiAO7DEpGfbhjy+eH4Ptp
         WiCxbmhhS5Is71rOqmUmFzG/a4XoPsYskvlWEbqBBUAnrQSi8bVfZGtNCqHAEJn86L5s
         oHc83AkppqSnusxvPCkGq8eHlZA9QaCChWzFUh1s3dTWITsMWM1NrF9n8En51n0mdIJX
         U/oWCzdQnwSpHjb/G5iTbAhtUIzFy0nwxPuDH0v8Kbxq5XJQaCp5NKMDJ6WcI/qlixSO
         +e5VTir7JDVGm7xN8H///ivAJvQOLY5HXnctPnchpN+NiCnxnKF1GBS9YLFnyJnGyWAb
         e8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+jgm8f6qLwVRwqw+onxb7pUQp2OzWLj5MWSH/TZR1lg=;
        b=OI5ZKnDRieHTSfR1sDQf4oSB1gwYm9HXQCY6Vdvk3TiLdZ52HWkSNKCvA1UlVTSzPj
         LkC1RoqgMakl+uMSCiiplbqlFopMk382c2+sKUCObOUrz6jqItQ7uXbWt4dzLIjYYEr9
         m/6hI/MChbTMxuwuGI0JRUkjRU6evCQCWk5wsDczwoZWVZvjxPSJMCNNjvpQpwJUV+uz
         zDWnVF6MxIvkM7bWPE6ZHRDtve1VhpKftCrwxDoCoCxmnWaO5wKwbNd5+fWQltWWqVqC
         uVkQiIoQjkzBayOTfgGw/NN+9cOP+86ulAbA76590An1E7FKddCNacc75WjXwSm8VGaW
         UyGA==
X-Gm-Message-State: AOAM531Pp6Cp5mAANfkHKyXCblKMPlG/xMzDvQgVV1XvNTed3UWTvikq
        DLCHv9YNefIKoefnjCkxTOi3yQ==
X-Google-Smtp-Source: ABdhPJwBTUiS+76CDkMxJrLBv/Y+VhQj6kwC4MHhZsyJSCETZaOiVdDvWRCCGaqaWO6lSrHh5M+P0w==
X-Received: by 2002:a05:6214:18c7:: with SMTP id cy7mr24583469qvb.59.1628531509748;
        Mon, 09 Aug 2021 10:51:49 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:615b:6e84:29a:3bc6])
        by smtp.gmail.com with ESMTPSA id c27sm8499011qkp.5.2021.08.09.10.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:51:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 02/20] hfsplus: Add iocharset= mount option as alias
 for nls=
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210808162453.1653-3-pali@kernel.org>
Date:   Mon, 9 Aug 2021 10:51:44 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA573A41-865C-4171-8837-FD5A2C33F42B@dubeyko.com>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-3-pali@kernel.org>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 8, 2021, at 9:24 AM, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>=20
> Other fs drivers are using iocharset=3D mount option for specifying =
charset.
> So add it also for hfsplus and mark old nls=3D mount option as =
deprecated.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
> fs/hfsplus/options.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 047e05c57560..a975548f6b91 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -23,6 +23,7 @@ enum {
> 	opt_creator, opt_type,
> 	opt_umask, opt_uid, opt_gid,
> 	opt_part, opt_session, opt_nls,
> +	opt_iocharset,
> 	opt_nodecompose, opt_decompose,
> 	opt_barrier, opt_nobarrier,
> 	opt_force, opt_err
> @@ -37,6 +38,7 @@ static const match_table_t tokens =3D {
> 	{ opt_part, "part=3D%u" },
> 	{ opt_session, "session=3D%u" },
> 	{ opt_nls, "nls=3D%s" },
> +	{ opt_iocharset, "iocharset=3D%s" },
> 	{ opt_decompose, "decompose" },
> 	{ opt_nodecompose, "nodecompose" },
> 	{ opt_barrier, "barrier" },
> @@ -166,6 +168,9 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 			}
> 			break;
> 		case opt_nls:
> +			pr_warn("option nls=3D is deprecated, use =
iocharset=3D\n");
> +			/* fallthrough */
> +		case opt_iocharset:
> 			if (sbi->nls) {
> 				pr_err("unable to change nls =
mapping\n");
> 				return 0;
> @@ -230,7 +235,7 @@ int hfsplus_show_options(struct seq_file *seq, =
struct dentry *root)
> 	if (sbi->session >=3D 0)
> 		seq_printf(seq, ",session=3D%u", sbi->session);
> 	if (sbi->nls)
> -		seq_printf(seq, ",nls=3D%s", sbi->nls->charset);
> +		seq_printf(seq, ",iocharset=3D%s", sbi->nls->charset);
> 	if (test_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags))
> 		seq_puts(seq, ",nodecompose");
> 	if (test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
> --=20
> 2.20.1
>=20

Looks reasonable. But I would like to be sure that the code has been =
reasonably tested.

Thanks,
Slava.


