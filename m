Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70BC3E4B0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhHIRma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhHIRm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:42:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D1C061796
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 10:42:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id az7so19279376qkb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zMzTuqFPiZBVeMUZF4LS9h41gWV5h1KPJNtSy0NtgKU=;
        b=tjVB3H2CyUbYOGbRry/miYm9WJKdL9yaRt+cu/wVte8y3apsaFwuELHSPtnsqRcl65
         O/d2a5S6M/iSg7dm+JfT2tHBTYuHShQOyZ0QSg8P0lu1eKxcwbEBuDOPj16Jheuw7bb0
         4a9b02X0hoZCAn1P0A4wxzUk+ibeRgllcXSn52dfBu9G4Rkawktxjk0YbrdlMLOL78Rh
         8B0cZrOXY9s33X/YjT9MBXkuosFUqleOQTXSVymAdKbsKn+lGESMPrgH4pnzOXdeEMNc
         1XDsHTUYVDu34Sy6tcpKStNv+awdCpY9i7vnMah2UsBXi62qKO3khOKjNanoqxBvvllD
         VZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zMzTuqFPiZBVeMUZF4LS9h41gWV5h1KPJNtSy0NtgKU=;
        b=TGnAnNqArUByrm3xrmVhtufAQrMCM90l36SeL0PvwSSdtGdv+xZpwzjwhzYEGnOUr9
         fFeSR1SBviAmZZovJKjGlNrOsVY0SVRZjNIi82gZlQwWLIEQmtfBE6DqwKrvIwnxg/7W
         m6VnJDMrqKIXbs1v70nvMT4bWpo3dGPDB0pXlguzMBRRJnfcgCw+w7KShw4A4gowaDr1
         r3nVeMmWOb1tecF6b6OwWL/kRzo2QoOC/gdCv9Avgr2V52i/IblfcVAr9afHkGOCmKAc
         kUZwsX3CwyopyVORlSk3SyJB4K7dOjXOm2dGItRCYriOnH6r3LwlZCa6gR0pxoYBza8E
         V8IQ==
X-Gm-Message-State: AOAM532+wUD0WnqHCBCo6E8DqIXu14HlkOomOKHPPg9lwYagciww6R4r
        p1vWdemr4JG/qP1RhJzuo+9aUQ==
X-Google-Smtp-Source: ABdhPJw0nwMhFOKnb3ozDL8IlcvWRSwkiH/IrO6MmnaGxiyEDrpiez2Y6dcpGbyQfnc9Bt/EhU9YXQ==
X-Received: by 2002:a05:620a:f91:: with SMTP id b17mr24087288qkn.107.1628530928009;
        Mon, 09 Aug 2021 10:42:08 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:615b:6e84:29a:3bc6])
        by smtp.gmail.com with ESMTPSA id k4sm741849qkj.40.2021.08.09.10.42.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 10:42:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 13/20] hfsplus: Do not use broken utf8 NLS table for
 iocharset=utf8 mount option
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210808162453.1653-14-pali@kernel.org>
Date:   Mon, 9 Aug 2021 10:42:02 -0700
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
Message-Id: <4D2445C9-7D4D-438A-964C-5B8F46BC15B5@dubeyko.com>
References: <20210808162453.1653-1-pali@kernel.org>
 <20210808162453.1653-14-pali@kernel.org>
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
> Note that this fs driver does not support full Unicode range, =
specially
> UTF-16 surrogate pairs are unsupported. This patch does not change =
this
> limitation and support for UTF-16 surrogate pairs stay unimplemented.
>=20
> When iochatset=3Dutf8 is used then set sbi->nls to NULL and use it for
> distinguish between the fact if NLS table or native UTF-8 functions =
should
> be used.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
> fs/hfsplus/dir.c            |  6 ++++--
> fs/hfsplus/options.c        | 32 ++++++++++++++++++--------------
> fs/hfsplus/super.c          |  7 +------
> fs/hfsplus/unicode.c        | 31 ++++++++++++++++++++++++++++---
> fs/hfsplus/xattr.c          | 14 +++++++++-----
> fs/hfsplus/xattr_security.c |  3 ++-
> 6 files changed, 62 insertions(+), 31 deletions(-)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 84714bbccc12..2caf0cd82221 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -144,7 +144,8 @@ static int hfsplus_readdir(struct file *file, =
struct dir_context *ctx)
> 	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> 	if (err)
> 		return err;
> -	strbuf =3D kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN + =
1, GFP_KERNEL);
> +	strbuf =3D kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : =
4) *
> +			HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);

Maybe, introduce some variable that will contain the length calculation?

> 	if (!strbuf) {
> 		err =3D -ENOMEM;
> 		goto out;
> @@ -203,7 +204,8 @@ static int hfsplus_readdir(struct file *file, =
struct dir_context *ctx)
> 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
> 			fd.entrylength);
> 		type =3D be16_to_cpu(entry.type);
> -		len =3D NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
> +		len =3D (HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) =
*
> +		      HFSPLUS_MAX_STRLEN;
> 		err =3D hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, =
&len);
> 		if (err)
> 			goto out;
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index a975548f6b91..16c08cb5c4f8 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -104,6 +104,9 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 	char *p;
> 	substring_t args[MAX_OPT_ARGS];
> 	int tmp, token;
> +	int have_iocharset;
> +
> +	have_iocharset =3D 0;

What=E2=80=99s about boolean type and to use true/false?

>=20
> 	if (!input)
> 		goto done;
> @@ -171,20 +174,24 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 			pr_warn("option nls=3D is deprecated, use =
iocharset=3D\n");
> 			/* fallthrough */
> 		case opt_iocharset:
> -			if (sbi->nls) {
> +			if (have_iocharset) {
> 				pr_err("unable to change nls =
mapping\n");
> 				return 0;
> 			}
> 			p =3D match_strdup(&args[0]);
> -			if (p)
> -				sbi->nls =3D load_nls(p);
> -			if (!sbi->nls) {
> -				pr_err("unable to load nls mapping =
\"%s\"\n",
> -				       p);
> -				kfree(p);
> +			if (!p)
> 				return 0;
> +			if (strcmp(p, "utf8") !=3D 0) {
> +				sbi->nls =3D load_nls(p);
> +				if (!sbi->nls) {
> +					pr_err("unable to load nls =
mapping "
> +						"\"%s\"\n", p);
> +					kfree(p);
> +					return 0;
> +				}
> 			}
> 			kfree(p);
> +			have_iocharset =3D 1;

Ditto. What=E2=80=99s about true here?

> 			break;
> 		case opt_decompose:
> 			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
> @@ -207,13 +214,10 @@ int hfsplus_parse_options(char *input, struct =
hfsplus_sb_info *sbi)
> 	}
>=20
> done:
> -	if (!sbi->nls) {
> -		/* try utf8 first, as this is the old default behaviour =
*/
> -		sbi->nls =3D load_nls("utf8");
> -		if (!sbi->nls)
> -			sbi->nls =3D load_nls_default();
> -		if (!sbi->nls)
> -			return 0;
> +	if (!have_iocharset) {
> +		/* use utf8, as this is the old default behaviour */
> +		pr_debug("using native UTF-8 without nls\n");
> +		/* no sbi->nls means that native UTF-8 code is used */
> 	}
>=20
> 	return 1;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index b9e3db3f855f..985662451bfc 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -403,11 +403,7 @@ static int hfsplus_fill_super(struct super_block =
*sb, void *data, int silent)
>=20
> 	/* temporarily use utf8 to correctly find the hidden dir below =
*/
> 	nls =3D sbi->nls;
> -	sbi->nls =3D load_nls("utf8");
> -	if (!sbi->nls) {
> -		pr_err("unable to load nls for utf8\n");
> -		goto out_unload_nls;
> -	}
> +	sbi->nls =3D NULL;
>=20
> 	/* Grab the volume header */
> 	if (hfsplus_read_wrapper(sb)) {
> @@ -585,7 +581,6 @@ static int hfsplus_fill_super(struct super_block =
*sb, void *data, int silent)
> 		}
> 	}
>=20
> -	unload_nls(sbi->nls);
> 	sbi->nls =3D nls;
> 	return 0;
>=20
> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> index 73342c925a4b..1d8c31c5126f 100644
> --- a/fs/hfsplus/unicode.c
> +++ b/fs/hfsplus/unicode.c
> @@ -190,7 +190,12 @@ int hfsplus_uni2asc(struct super_block *sb,
> 				c0 =3D ':';
> 				break;
> 			}
> -			res =3D nls->uni2char(c0, op, len);
> +			if (nls)
> +				res =3D nls->uni2char(c0, op, len);
> +			else (len > 0)
> +				res =3D utf32_to_utf8(c0, op, len);
> +			else
> +				res =3D -ENAMETOOLONG;
> 			if (res < 0) {
> 				if (res =3D=3D -ENAMETOOLONG)
> 					goto out;
> @@ -233,7 +238,12 @@ int hfsplus_uni2asc(struct super_block *sb,
> 			cc =3D c0;
> 		}
> done:
> -		res =3D nls->uni2char(cc, op, len);
> +		if (nls)
> +			res =3D nls->uni2char(cc, op, len);
> +		else (len > 0)
> +			res =3D utf32_to_utf8(cc, op, len);
> +		else
> +			res =3D -ENAMETOOLONG;
> 		if (res < 0) {
> 			if (res =3D=3D -ENAMETOOLONG)
> 				goto out;
> @@ -256,7 +266,22 @@ int hfsplus_uni2asc(struct super_block *sb,
> static inline int asc2unichar(struct super_block *sb, const char =
*astr, int len,
> 			      wchar_t *uc)
> {
> -	int size =3D HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
> +	struct nls_table *nls =3D HFSPLUS_SB(sb)->nls;
> +	unicode_t u;
> +	int size;
> +
> +	if (nls)
> +		size =3D nls->char2uni(astr, len, uc);
> +	else {
> +		size =3D utf8_to_utf32(astr, len, &u);
> +		if (size >=3D 0) {
> +			/* TODO: Add support for UTF-16 surrogate pairs =
*/

Have you forgot to delete this string? Or do you plan to implement this?

> +			if (u <=3D MAX_WCHAR_T)
> +				*uc =3D u;
> +			else
> +				size =3D -EINVAL;
> +		}
> +	}
> 	if (size <=3D 0) {
> 		*uc =3D '?';
> 		size =3D 1;
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index e2855ceefd39..9b2653f08a5f 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -425,7 +425,8 @@ int hfsplus_setxattr(struct inode *inode, const =
char *name,
> 	char *xattr_name;
> 	int res;
>=20
> -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE * =
HFSPLUS_ATTR_MAX_STRLEN + 1,
> +	xattr_name =3D kmalloc((HFSPLUS_SB(sb)->nls ? =
NLS_MAX_CHARSET_SIZE : 4) *
> +			     HFSPLUS_ATTR_MAX_STRLEN + 1,
> 		GFP_KERNEL);

What=E2=80=99s about to introduce a variable for length calculation?

> 	if (!xattr_name)
> 		return -ENOMEM;
> @@ -579,7 +580,8 @@ ssize_t hfsplus_getxattr(struct inode *inode, =
const char *name,
> 	int res;
> 	char *xattr_name;
>=20
> -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE * =
HFSPLUS_ATTR_MAX_STRLEN + 1,
> +	xattr_name =3D kmalloc((HFSPLUS_SB(sb)->nls ? =
NLS_MAX_CHARSET_SIZE : 4) *
> +			     HFSPLUS_ATTR_MAX_STRLEN + 1,
> 			     GFP_KERNEL);

Ditto. What=E2=80=99s about to introduce a variable for length =
calculation?

> 	if (!xattr_name)
> 		return -ENOMEM;
> @@ -699,8 +701,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, =
char *buffer, size_t size)
> 		return err;
> 	}
>=20
> -	strbuf =3D kmalloc(NLS_MAX_CHARSET_SIZE * =
HFSPLUS_ATTR_MAX_STRLEN +
> -			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
> +	strbuf =3D kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : =
4) *
> +			HFSPLUS_ATTR_MAX_STRLEN + =
XATTR_MAC_OSX_PREFIX_LEN + 1,
> +			GFP_KERNEL);

Ditto. What=E2=80=99s about to introduce a variable for length =
calculation?

> 	if (!strbuf) {
> 		res =3D -ENOMEM;
> 		goto out;
> @@ -732,7 +735,8 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, =
char *buffer, size_t size)
> 		if (be32_to_cpu(attr_key.cnid) !=3D inode->i_ino)
> 			goto end_listxattr;
>=20
> -		xattr_name_len =3D NLS_MAX_CHARSET_SIZE * =
HFSPLUS_ATTR_MAX_STRLEN;
> +		xattr_name_len =3D (HFSPLUS_SB(sb)->nls ? =
NLS_MAX_CHARSET_SIZE : 4)
> +				* HFSPLUS_ATTR_MAX_STRLEN;
> 		if (hfsplus_uni2asc(inode->i_sb,
> 			(const struct hfsplus_unistr =
*)&fd.key->attr.key_name,
> 					strbuf, &xattr_name_len)) {
> diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
> index c1c7a16cbf21..438ebcd1359b 100644
> --- a/fs/hfsplus/xattr_security.c
> +++ b/fs/hfsplus/xattr_security.c
> @@ -41,7 +41,8 @@ static int hfsplus_initxattrs(struct inode *inode,
> 	char *xattr_name;
> 	int err =3D 0;
>=20
> -	xattr_name =3D kmalloc(NLS_MAX_CHARSET_SIZE * =
HFSPLUS_ATTR_MAX_STRLEN + 1,
> +	xattr_name =3D kmalloc((HFSPLUS_SB(sb)->nls ? =
NLS_MAX_CHARSET_SIZE : 4) *
> +			     HFSPLUS_ATTR_MAX_STRLEN + 1,
> 		GFP_KERNEL);

Ditto. What=E2=80=99s about to introduce a variable for length =
calculation?

Thanks,
Slava.

> 	if (!xattr_name)
> 		return -ENOMEM;
> --=20
> 2.20.1
>=20

