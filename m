Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2023E4B29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhHIRuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHIRuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:50:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74FC061796
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 10:49:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a19so19319516qkg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jpfIGx2EzYaUOkGK/YPaLej8O5uKozVOIfYq7wV/cTQ=;
        b=Tj7RAOmM1x2cET3pYHKg6cLSxjzwEmOYMIpGiMmjmkZHludn4vfEy5dyhIf3mMCMG3
         fndz4DvX7LH/eCPn453Ic3kGMhGSareukjsqhkN3I46oL21egiPsE5H0acE4fUc9ABYB
         iDxJGa8pi5M7Xd7x6CNHNWSYZEJJOxbf8shbEK53dwP+akOODp/rRjWTszoaquPBeXWd
         9hsdgEWotN4xK1oqzCUtlnJ6Bz7hyS/ZWSFZ0SAy+iFX8u75i1wpTtvEtENsVNSVZoBv
         Gt1FGzTBknfRVQLco9vYwXInh8Xy+xBS/7uZQ+zRHb5GazZF2jD9V/r5ozx7q6FBDjnq
         K5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jpfIGx2EzYaUOkGK/YPaLej8O5uKozVOIfYq7wV/cTQ=;
        b=hIL6OTpkpHnzuDnuo2SrxUMN1WjFNLreQe+d5Z63PurG9EomYQe3jTwcKzkLgJWlVN
         YyblMhck3gUjlPKnrYgOqKcqDjNxzvP2khs6eJRTl5WUESzQyhbT5frCu3/F88wsb6Wq
         U4AI6CVn1TqSs/cGZpKUjUfP+nI7JydSZpcE22CLkW7lqx61wf91BX52UwvlBC7msA+G
         tIBvDZBh++w0+aZq+RNhA/H59htY05se5PN/q1D9i0nDTZZMIkT7sYThNwL5Hlnk/fPX
         5oLt1db8rNmtFP/BCetE3m/FwK56oRtSL5uyciUOb1XYi0m3dCk90B4SqVxDBsp4hS4P
         84Yw==
X-Gm-Message-State: AOAM53058J3LxPTL4JSQXKSNZ/j8AdOPjQc440iA213dQN4rASmtYGvf
        oq1aLrCuGxVvrnWHOG+7dfBpbw==
X-Google-Smtp-Source: ABdhPJz2058dUuvRBlMStlQcuOvywn5SOSNHYuAFINAcfE0R3v56luVgJPI9khFKBeN8xtsVzZxpoA==
X-Received: by 2002:a37:8306:: with SMTP id f6mr24935656qkd.82.1628531380217;
        Mon, 09 Aug 2021 10:49:40 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:615b:6e84:29a:3bc6])
        by smtp.gmail.com with ESMTPSA id a8sm8629059qkn.63.2021.08.09.10.49.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:49:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 12/20] hfs: Do not use broken utf8 NLS table for
 iocharset=utf8 mount option
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210808162453.1653-13-pali@kernel.org>
Date:   Mon, 9 Aug 2021 10:49:34 -0700
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
Message-Id: <4B1987C7-F6D9-4493-ACD0-846B92F86037@dubeyko.com>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-13-pali@kernel.org>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 8, 2021, at 9:24 AM, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>=20
> NLS table for utf8 is broken and cannot be fixed.
>=20
> So instead of broken utf8 nls functions char2uni() and uni2char() use
> functions utf8_to_utf32() and utf32_to_utf8() which implements correct
> encoding and decoding between Unicode code points and UTF-8 sequence.
>=20
> When iochatset=3Dutf8 is used then set hsb->nls_io to NULL and use it =
for
> distinguish between the fact if NLS table or native UTF-8 functions =
should
> be used.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
> fs/hfs/super.c | 33 ++++++++++++++++++++++-----------
> fs/hfs/trans.c | 24 ++++++++++++++++++++----
> 2 files changed, 42 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 86bc46746c7f..076308df41cf 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -149,10 +149,13 @@ static int hfs_show_options(struct seq_file =
*seq, struct dentry *root)
> 		seq_printf(seq, ",part=3D%u", sbi->part);
> 	if (sbi->session >=3D 0)
> 		seq_printf(seq, ",session=3D%u", sbi->session);
> -	if (sbi->nls_disk)
> +	if (sbi->nls_disk) {
> 		seq_printf(seq, ",codepage=3D%s", =
sbi->nls_disk->charset);

Maybe, I am missing something. But where is the closing =E2=80=9C}=E2=80=9D=
?


> -	if (sbi->nls_io)
> -		seq_printf(seq, ",iocharset=3D%s", =
sbi->nls_io->charset);
> +		if (sbi->nls_io)
> +			seq_printf(seq, ",iocharset=3D%s", =
sbi->nls_io->charset);
> +		else
> +			seq_puts(seq, ",iocharset=3Dutf8");
> +	}
> 	if (sbi->s_quiet)
> 		seq_printf(seq, ",quiet");
> 	return 0;
> @@ -225,6 +228,7 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 	char *p;
> 	substring_t args[MAX_OPT_ARGS];
> 	int tmp, token;
> +	int have_iocharset;

What=E2=80=99s about boolean type?

>=20
> 	/* initialize the sb with defaults */
> 	hsb->s_uid =3D current_uid();
> @@ -239,6 +243,8 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 	if (!options)
> 		return 1;
>=20
> +	have_iocharset =3D 0;

What=E2=80=99s about false here?

> +
> 	while ((p =3D strsep(&options, ",")) !=3D NULL) {
> 		if (!*p)
> 			continue;
> @@ -332,18 +338,22 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 			kfree(p);
> 			break;
> 		case opt_iocharset:
> -			if (hsb->nls_io) {
> +			if (have_iocharset) {
> 				pr_err("unable to change iocharset\n");
> 				return 0;
> 			}
> 			p =3D match_strdup(&args[0]);
> -			if (p)
> -				hsb->nls_io =3D load_nls(p);
> -			if (!hsb->nls_io) {
> -				pr_err("unable to load iocharset =
\"%s\"\n", p);
> -				kfree(p);
> +			if (!p)
> 				return 0;
> +			if (strcmp(p, "utf8") !=3D 0) {
> +				hsb->nls_io =3D load_nls(p);
> +				if (!hsb->nls_io) {
> +					pr_err("unable to load iocharset =
\"%s\"\n", p);
> +					kfree(p);
> +					return 0;
> +				}
> 			}
> +			have_iocharset =3D 1;

What=E2=80=99s about true here?

> 			kfree(p);
> 			break;
> 		default:
> @@ -351,7 +361,7 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 		}
> 	}
>=20
> -	if (hsb->nls_io && !hsb->nls_disk) {
> +	if (have_iocharset && !hsb->nls_disk) {
> 		/*
> 		 * Previous version of hfs driver did something =
unexpected:
> 		 * When codepage was not defined but iocharset was then
> @@ -382,7 +392,8 @@ static int parse_options(char *options, struct =
hfs_sb_info *hsb)
> 			return 0;
> 		}
> 	}
> -	if (hsb->nls_disk && !hsb->nls_io) {
> +	if (hsb->nls_disk &&
> +	    !have_iocharset && strcmp(CONFIG_NLS_DEFAULT, "utf8") !=3D =
0) {

Maybe, introduce the variable to calculate the boolean value here? Then =
if statement will look much cleaner.

> 		hsb->nls_io =3D load_nls_default();
> 		if (!hsb->nls_io) {
> 			pr_err("unable to load default iocharset\n");
> diff --git a/fs/hfs/trans.c b/fs/hfs/trans.c
> index c75682c61b06..bff8e54003ab 100644
> --- a/fs/hfs/trans.c
> +++ b/fs/hfs/trans.c
> @@ -44,7 +44,7 @@ int hfs_mac2asc(struct super_block *sb, char *out, =
const struct hfs_name *in)
> 		srclen =3D HFS_NAMELEN;
> 	dst =3D out;
> 	dstlen =3D HFS_MAX_NAMELEN;
> -	if (nls_io) {
> +	if (nls_disk) {
> 		wchar_t ch;
>=20

I could miss something here. But what=E2=80=99s about the closing =
=E2=80=9C}=E2=80=9D?

Thanks,
Slava.

> 		while (srclen > 0) {
> @@ -57,7 +57,12 @@ int hfs_mac2asc(struct super_block *sb, char *out, =
const struct hfs_name *in)
> 			srclen -=3D size;
> 			if (ch =3D=3D '/')
> 				ch =3D ':';
> -			size =3D nls_io->uni2char(ch, dst, dstlen);
> +			if (nls_io)
> +				size =3D nls_io->uni2char(ch, dst, =
dstlen);
> +			else if (dstlen > 0)
> +				size =3D utf32_to_utf8(ch, dst, dstlen);
> +			else
> +				size =3D -ENAMETOOLONG;
> 			if (size < 0) {
> 				if (size =3D=3D -ENAMETOOLONG)
> 					goto out;
> @@ -101,11 +106,22 @@ void hfs_asc2mac(struct super_block *sb, struct =
hfs_name *out, const struct qstr
> 	srclen =3D in->len;
> 	dst =3D out->name;
> 	dstlen =3D HFS_NAMELEN;
> -	if (nls_io) {
> +	if (nls_disk) {
> 		wchar_t ch;
> +		unicode_t u;
>=20
> 		while (srclen > 0) {
> -			size =3D nls_io->char2uni(src, srclen, &ch);
> +			if (nls_io)
> +				size =3D nls_io->char2uni(src, srclen, =
&ch);
> +			else {
> +				size =3D utf8_to_utf32(str, strlen, &u);
> +				if (size >=3D 0) {
> +					if (u <=3D MAX_WCHAR_T)
> +						ch =3D u;
> +					else
> +						size =3D -EINVAL;
> +				}
> +			}
> 			if (size < 0) {
> 				ch =3D '?';
> 				size =3D 1;
> --=20
> 2.20.1
>=20

