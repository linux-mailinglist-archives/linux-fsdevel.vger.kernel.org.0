Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C336812C29F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2019 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfL2OLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Dec 2019 09:11:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36449 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfL2OLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:11:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so30567460wru.3;
        Sun, 29 Dec 2019 06:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLBgbovkIffZO+hRIgOqtb2WolDw1aCQuaQFQ7bH7sc=;
        b=Sm1ed4Q9VQUpsdQ9W1hqzD+pJoDwPmy8Zm0mGuoMQ6MFHJKgEwmL3sM8LMbBXtfrH8
         DZF9PtirmfBCgSIevsFwkV/XFwNTNAuC/SZw356HzrxF34PelPBMV6V9SCw5C/JouHU5
         pBPemabklJcQnBZ736/RHtVijoKB5QzfCMtUDHV2v2NqStHfnVCh3Y0NAy0CN2F2xwOt
         Nzd8Ec4R5N6kDFChk5lHi5S68eZ1JCI5oz+oYA3i2dn66PiiNem+qlsAZl8ZSpT9JcwV
         eZiiFEKig5alOB7foLpNRREqp1qg8BTKe4MonCAMKIfamt4sJEvsnFSdkgTOzwpNYiJZ
         5i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLBgbovkIffZO+hRIgOqtb2WolDw1aCQuaQFQ7bH7sc=;
        b=Fd9R3afYRVhmuHPEbLy4WolJ9qrR+Af6z0l/8kMtGf7f+SKpGyWSVK2eVtWgKqccjC
         XPgKxDjQaqxSn6hbtsOfJteMiRbIXPFhMePOSDwzhBF0uH2rFAPk2bsbD+Lm2rZokzPT
         L1boKH8jbRiU7x9Dmj3MBXQ/v/44dXmewzffdCyRN5YxDwpk8HQZFZ8jf+l6cuCjJYD2
         LAwyNJmSivC1rBJ0kHwb7vBtK5LOVXaPwVwgPWxii4Ifqb4lo0aB7B/R+80F1r+O+CAZ
         yBm3oUyb1g1MaTyLqHhpXrXw8nqDb71/AmoieO8Estkcvj+QLA21TENdauXSFCt2QfVb
         BHhA==
X-Gm-Message-State: APjAAAXBb+0tSnCDoBeVQnwnl5HzV8Op3guIdW1+KXa+lYG1WqIF56Ms
        MtqwwEBxACL+xSfDAYjBvG0=
X-Google-Smtp-Source: APXvYqwdSaqAPp9+rYWAz+uKrQUKXehK3b1IWgX/1AkuvgyPDWADKhjc5Kcjb7YvjGQ8uZLTqlA9Fg==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr62370480wru.296.1577628670279;
        Sun, 29 Dec 2019 06:11:10 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id w22sm17075101wmk.34.2019.12.29.06.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 06:11:09 -0800 (PST)
Date:   Sun, 29 Dec 2019 15:11:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v8 01/13] exfat: add in-memory and on-disk structures and
 headers
Message-ID: <20191229141108.ufnu6lbu7qvl5oxj@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062732epcas1p17f3b1066fb4d6496559f349f950e1751@epcas1p1.samsung.com>
 <20191220062419.23516-2-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vnynbe7hoynpmjey"
Content-Disposition: inline
In-Reply-To: <20191220062419.23516-2-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vnynbe7hoynpmjey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2019 01:24:07 Namjae Jeon wrote:
> This adds in-memory and on-disk structures and headers.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/exfat_fs.h  | 559 +++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/exfat_raw.h | 202 ++++++++++++++++
>  2 files changed, 761 insertions(+)
>  create mode 100644 fs/exfat/exfat_fs.h
>  create mode 100644 fs/exfat/exfat_raw.h

=2E..

> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
> new file mode 100644
> index 000000000000..a3ccac835993
> --- /dev/null
> +++ b/fs/exfat/exfat_raw.h

=2E..

> +/* file attributes */
> +#define ATTR_READONLY		0x0001
> +#define ATTR_HIDDEN		0x0002
> +#define ATTR_SYSTEM		0x0004
> +#define ATTR_VOLUME		0x0008
> +#define ATTR_SUBDIR		0x0010
> +#define ATTR_ARCHIVE		0x0020
> +#define ATTR_EXTEND		(ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM | \
> +				 ATTR_VOLUME) /* 0x000F */
> +
> +#define ATTR_EXTEND_MASK	(ATTR_EXTEND | ATTR_SUBDIR | ATTR_ARCHIVE)
> +#define ATTR_RWMASK		(ATTR_HIDDEN | ATTR_SYSTEM | ATTR_VOLUME | \
> +				 ATTR_SUBDIR | ATTR_ARCHIVE)
> +
> +#define ATTR_READONLY_LE	cpu_to_le16(0x0001)
> +#define ATTR_HIDDEN_LE		cpu_to_le16(0x0002)
> +#define ATTR_SYSTEM_LE		cpu_to_le16(0x0004)
> +#define ATTR_VOLUME_LE		cpu_to_le16(0x0008)
> +#define ATTR_SUBDIR_LE		cpu_to_le16(0x0010)
> +#define ATTR_ARCHIVE_LE		cpu_to_le16(0x0020)

Hello!

This looks like copy-paste code from /* file attributes */ section
above. What about at least making these macro definitions as?

  #define ATTR_READONLY_LE	cpu_to_le16(ATTR_READONLY)
  #define ATTR_HIDDEN_LE	cpu_to_le16(ATTR_HIDDEN)
  ...

But main question is, are these _LE definitions needed at all?

Looking at the whole patch series and only ATTR_SUBDIR_LE and
ATTR_ARCHIVE_LE are used.

Is not it better to use cpu_to_le16(ATTR_READONLY) directly in code and
do not define duplicate ATTR_READONLY_LE macro at all?

> +
> +#define JUMP_BOOT_LEN			3
> +#define OEM_NAME_LEN			8
> +#define MUST_BE_ZERO_LEN		53
> +#define EXFAT_FILE_NAME_LEN		15
> +
> +/* EXFAT BIOS parameter block (64 bytes) */
> +struct bpb64 {
> +	__u8 jmp_boot[JUMP_BOOT_LEN];
> +	__u8 oem_name[OEM_NAME_LEN];
> +	__u8 res_zero[MUST_BE_ZERO_LEN];
> +};
> +
> +/* EXFAT EXTEND BIOS parameter block (56 bytes) */
> +struct bsx64 {
> +	__le64 vol_offset;
> +	__le64 vol_length;
> +	__le32 fat_offset;
> +	__le32 fat_length;
> +	__le32 clu_offset;
> +	__le32 clu_count;
> +	__le32 root_cluster;
> +	__le32 vol_serial;
> +	__u8 fs_version[2];
> +	__le16 vol_flags;
> +	__u8 sect_size_bits;
> +	__u8 sect_per_clus_bits;
> +	__u8 num_fats;
> +	__u8 phy_drv_no;
> +	__u8 perc_in_use;
> +	__u8 reserved2[7];
> +};

Should not be this structure marked as packed? Also those two below.

> +/* EXFAT PBR[BPB+BSX] (120 bytes) */
> +struct pbr64 {
> +	struct bpb64 bpb;
> +	struct bsx64 bsx;
> +};
> +
> +/* Common PBR[Partition Boot Record] (512 bytes) */
> +struct pbr {
> +	union {
> +		__u8 raw[64];
> +		struct bpb64 f64;
> +	} bpb;
> +	union {
> +		__u8 raw[56];
> +		struct bsx64 f64;
> +	} bsx;
> +	__u8 boot_code[390];
> +	__le16 signature;
> +};

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vnynbe7hoynpmjey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgiz+QAKCRCL8Mk9A+RD
UmAYAJ9H2kwrv3K00UAzeVDfVYXvruxJkACfYgrgSvFXfP5UPzQ3HJPqmoWvgdY=
=EIYf
-----END PGP SIGNATURE-----

--vnynbe7hoynpmjey--
