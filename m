Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37524640F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 21:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiLBUi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 15:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbiLBUiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:38:25 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B64C82EB
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 12:38:24 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id cg5so6826978qtb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Dec 2022 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JOcxwhxiaCN4P7YWLL832teuG1uo7i/ABv0IaQTb0E=;
        b=reBeD053PlaDOPDSnyvPRP39vnzXXg2sA1itIFF2NtImWJNKi/J4MhYB0BsdCJBUDZ
         I89EceiVXhDw9DE7erUVEXWQdiGHTqBLRc0DbBhRONRv0//kulqIFSvt6xpzlyO/oCUQ
         CdS9WyJCcWiQQWcY6jZmZmPD2DtiWYTWDsLk1SmVLlx0QARzF2kMxL7DYj6FR8awrbZC
         mpsJhMtjqvTlnCEoKg4eiUxoiClTC/5TCK+sovq45cqIW5peytkcjvFDDdxOzJtUbbEo
         6u3N4w3ii6R0rLesUiQrAjNTvL086cL/giED5c5O0hUvQ1z3xkwmFbwuOQYpr69RCl5M
         NSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JOcxwhxiaCN4P7YWLL832teuG1uo7i/ABv0IaQTb0E=;
        b=o9qk2N/vEN7NQnXVrTrrTigOQTLi4d2lI+x9WiLX7xKhb3GMj73ElvyXIVMXSUc73K
         2f9CT9bprwevUcoZDFiu9aT0fjDMBef7uck4cKbaYmjQBehayACkp1GraE1Ly+0NRT36
         jd8RGdgFV9lsb0Zp0mdvvulySjxCMvkI+QilRZKrOizHGxb2i8ig+slGP9JIwTrMEzf+
         PLyyN196KNx4J3QOPLVwirngFazvqsqpaFjmO8Cze42HM+b1qyT1RDb0ZWOBUp8ctqUV
         Rtb7FGelFgxcmeETF45r5Nb7fwSrpCL3xWPK+8hQyxOc8aSgm5+CznKzN/mtDz/IcAw1
         N8kA==
X-Gm-Message-State: ANoB5plajCeXS+viNulJcL41sYZCDyhwYavr3p8yO81DcD3a67t8oIya
        WtEB4wYQWm24TB0xiJmROoOx1A==
X-Google-Smtp-Source: AA0mqf6IcPIo2erPqqnbdgRw4umsKGiZJaMf7hfV1peyeO+X2MxwX8vViJNz/QQdAr7SUCeKMPrQyw==
X-Received: by 2002:a05:622a:4a11:b0:3a5:1cc6:ae12 with SMTP id fv17-20020a05622a4a1100b003a51cc6ae12mr67298178qtb.103.1670013503222;
        Fri, 02 Dec 2022 12:38:23 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006eea4b5abcesm6713795qkp.89.2022.12.02.12.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2022 12:38:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
Date:   Fri, 2 Dec 2022 12:38:19 -0800
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AE11F8A-3C10-46A3-9F42-B5F72F1FC634@dubeyko.com>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
To:     Aditya Garg <gargaditya08@live.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 1, 2022, at 10:01 PM, Aditya Garg <gargaditya08@live.com> =
wrote:
>=20
> From: Aditya Garg <gargaditya08@live.com>
>=20
> This patch enables users to permanently enable writes of HFS+ locked
> and/or journaled volumes using a module parameter.
>=20
> Why module parameter?
> Reason being, its not convenient to manually mount the volume with =
force
> everytime. There are use cases which are fine with force enabling =
writes
> on journaled volumes. I've seen many on various online forums and I am =
one
> of them as well.
>=20
> Isn't it risky?
> Yes obviously it is, as the driver itself warns users for the same. =
But
> any user using the parameter obviously shall be well aware of the =
risks
> involved. To be honest, I've been writing on a 100Gb journaled volume =
for
> a few days, including both large and small files, and haven't faced =
any
> corruption yet.
>=20

If you created HFS+ volume under Linux, then you never have journal
and problem of journal replay (even if you created journaled volume).
So, I see the only one case when you have journal with transactions.
You are using HFS+ volume in Linux and Mac OS X. It means that
Mac OS X can create transactions in the journal and Linux needs
to manage it somehow.

Even if you don=E2=80=99t see any corruptions after such short testing, =
then
it doesn=E2=80=99t mean that you are safe. The key trouble that you can
silently lose the data because some metadata state could sit
in the journal and no replay operation has happened. Yes, you can
ignore the transactions in the journal and continue to store data and
modify metadata. But if journal still contain valid transactions, then
mount operation under Mac OS X will replay journal. And it sounds
that journal replay under Mac OS X can corrupt metadata and data
state that was modified/created under Linux.

So, I believe that your suggestion is slightly dangerous because
people loves to make mistakes and really hates to lose data.

Thanks,
Slava.=20

> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> fs/hfsplus/super.c | 46 ++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 36 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 122ed89eb..2367a2407 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -24,6 +24,16 @@ static void hfsplus_free_inode(struct inode =
*inode);
> #include "hfsplus_fs.h"
> #include "xattr.h"
>=20
> +static unsigned int force_journaled_rw;
> +module_param(force_journaled_rw, uint, 0644);
> +MODULE_PARM_DESC(force_journaled_rw, "Force enable writes on =
Journaled HFS+ volumes. "
> +		"([0] =3D disabled, 1 =3D enabled)");
> +
> +static unsigned int force_locked_rw;
> +module_param(force_locked_rw, uint, 0644);
> +MODULE_PARM_DESC(force_locked_rw, "Force enable writes on locked HFS+ =
volumes. "
> +		"([0] =3D disabled, 1 =3D enabled)");
> +
> static int hfsplus_system_read_inode(struct inode *inode)
> {
> 	struct hfsplus_vh *vhdr =3D HFSPLUS_SB(inode->i_sb)->s_vhdr;
> @@ -346,14 +356,22 @@ static int hfsplus_remount(struct super_block =
*sb, int *flags, char *data)
> 			/* nothing */
> 		} else if (vhdr->attributes &
> 				cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) {
> -			pr_warn("filesystem is marked locked, leaving =
read-only.\n");
> -			sb->s_flags |=3D SB_RDONLY;
> -			*flags |=3D SB_RDONLY;
> +			if (force_locked_rw) {
> +				pr_warn("filesystem is marked locked, =
but writes have been force enabled.\n");
> +			} else {
> +				pr_warn("filesystem is marked locked, =
leaving read-only.\n");
> +				sb->s_flags |=3D SB_RDONLY;
> +				*flags |=3D SB_RDONLY;
> +			}
> 		} else if (vhdr->attributes &
> 				cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
> -			pr_warn("filesystem is marked journaled, leaving =
read-only.\n");
> -			sb->s_flags |=3D SB_RDONLY;
> -			*flags |=3D SB_RDONLY;
> +			if (force_journaled_rw) {
> +				pr_warn("filesystem is marked journaled, =
but writes have been force enabled.\n");
> +			} else {
> +				pr_warn("filesystem is marked journaled, =
leaving read-only.\n");
> +				sb->s_flags |=3D SB_RDONLY;
> +				*flags |=3D SB_RDONLY;
> +			}
> 		}
> 	}
> 	return 0;
> @@ -459,12 +477,20 @@ static int hfsplus_fill_super(struct super_block =
*sb, void *data, int silent)
> 	} else if (test_and_clear_bit(HFSPLUS_SB_FORCE, &sbi->flags)) {
> 		/* nothing */
> 	} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) =
{
> -		pr_warn("Filesystem is marked locked, mounting =
read-only.\n");
> -		sb->s_flags |=3D SB_RDONLY;
> +		if (force_locked_rw) {
> +			pr_warn("Filesystem is marked locked, but writes =
have been force enabled.\n");
> +		} else {
> +			pr_warn("Filesystem is marked locked, mounting =
read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +		}
> 	} else if ((vhdr->attributes & =
cpu_to_be32(HFSPLUS_VOL_JOURNALED)) &&
> 			!sb_rdonly(sb)) {
> -		pr_warn("write access to a journaled filesystem is not =
supported, use the force option at your own risk, mounting =
read-only.\n");
> -		sb->s_flags |=3D SB_RDONLY;
> +		if (force_journaled_rw) {
> +			pr_warn("write access to a journaled filesystem =
is not supported, but has been force enabled.\n");
> +		} else {
> +			pr_warn("write access to a journaled filesystem =
is not supported, use the force option at your own risk, mounting =
read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +		}
> 	}
>=20
> 	err =3D -EINVAL;
> --=20
> 2.38.1
>=20

