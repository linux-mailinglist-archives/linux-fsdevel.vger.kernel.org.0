Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D5AA1A24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfH2MeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:34:14 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:58188 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfH2MeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:34:14 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7TCYCNm004874
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 08:34:12 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7TCY7Ll008749
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 08:34:12 -0400
Received: by mail-qt1-f197.google.com with SMTP id p56so3155369qtb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 05:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=ORBeCnNYXTlYaOX4yJ+TSR4xwn2mIsSRwMfswcxkhZM=;
        b=o2+FhOkjJuiPSIX3DldLWnWO0BucelxBb/cA1VTAph6g5FmXauAd2dZLOZ0vmTqJlR
         GAwUsejoIm7TFO8hwaB+0FXHB7DlffIm45Yvn4czN2ysdaahL3q6va17+shoNQGjUGei
         bs6gZZdqy7lVTmaXNye0IYuEkUS+/LJwu4GjTa9X9rV/AZE/Tleo8HNYl+i46cQg5GwZ
         jXjhpH2FmQwKI5MaLlQqf9dFFztA73eKgBMdRRsE/lAWEeU/+rwblTYfvOB99yIk8mCF
         js5WQ0+Lnma2Z5xeAWEHTSiZqvLsha7KTKB8Inv5GAylMnp4+ZJk7Jq3lgezDyyOugGg
         WxAw==
X-Gm-Message-State: APjAAAUk/gvnbfQvf76C9rUyROrxUN7+ULMGGcWGkrLKObnwlP13FE68
        PbMJoEz1AXeQY01R+RhJrUFQ6B1gFdzkq/NQSlrZ/R0FAUMSTwlkjNphlgTykneXgET6Nf9KVlW
        mNfFmh+DKrn0pabW0S7JyJi+YPINLRcJsnSJb
X-Received: by 2002:ae9:c107:: with SMTP id z7mr8923143qki.245.1567082047544;
        Thu, 29 Aug 2019 05:34:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxaDa0b+S9n3TC9x3RzUIgHC9MqSnXzCbeKQg97M3BeOqzYftKcNhL6eLT1sObNqoJv0/h4EA==
X-Received: by 2002:ae9:c107:: with SMTP id z7mr8923119qki.245.1567082047269;
        Thu, 29 Aug 2019 05:34:07 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id z20sm1040924qts.47.2019.08.29.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 05:34:05 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20190829121435.bsl5cnx7yqgakpgb@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829121435.bsl5cnx7yqgakpgb@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567082044_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Aug 2019 08:34:04 -0400
Message-ID: <81682.1567082044@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567082044_4251P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2019 14:14:35 +0200, Pali Roh=E1r said:
> On Wednesday 28 August 2019 18:08:17 Greg Kroah-Hartman wrote:
> > The full specification of the filesystem can be found at:
> >   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specifi=
cation
>
> This is not truth. This specification is not =22full=22. There are miss=
ing
> important details, like how is TexFAT implemented.=20

Well..given that the spec says it's an extension used by Windows CE...

> 1.5 Windows CE and TexFAT

> TexFAT is an extension to exFAT that adds transaction-safe operational
> semantics on top of the base file system. TexFAT is used by Windows CE.=
 TexFAT
> requires the use of the two FATs and allocation bitmaps for use in
> transactions. It also defines several additional structures including p=
adding
> descriptors and security descriptors.

And these two pieces of info:

> 3.1.13.1 ActiveFat Field

> The ActiveFat field shall describe which FAT and Allocation Bitmap are =
active
> (and implementations shall use), as follows:

> 0, which means the First FAT and First Allocation Bitmap are active

> 1, which means the Second FAT and Second Allocation Bitmap are active a=
nd is
> possible only when the NumberOfFats field contains the value 2

> Implementations shall consider the inactive FAT and Allocation Bitmap a=
s stale.
> Only TexFAT-aware implementations shall switch the active FAT and Alloc=
ation
> Bitmaps (see Section 7.1).

> 3.1.16 NumberOfFats Field
> The NumberOfFats field shall describe the number of FATs and Allocation=
 Bitmaps
> the volume contains.

> The valid range of values for this field shall be:

> 1, which indicates the volume only contains the First FAT and First All=
ocation Bitmap

> 2, which indicates the volume contains the First FAT, Second FAT, First=

> Allocation Bitmap, and Second Allocation Bitmap; this value is only val=
id for
> TexFAT volumes

I think we're OK if we just set ActiveFat to 0 and NumberOfFats to 1.

Unless somebody has actual evidence of a non-WindowsCE extfat that has
NumberOfFats =3D=3D 2....

--==_Exmh_1567082044_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWfGOwdmEQWDXROgAQKhFxAAgGBZUG/72DPXrzEGMXN4uGnAqENh9XKZ
UPbCD+T20xWMxB8rIhVlqrvY1sR/lbFJ82PvHeqZqR7gNsmF4wpKRHOlnlmbIVok
OSka2RrlznkFYWtFx5IBEp+MfOSa6zr0IEDPkEQ+ga7nzl/EucZLgJaY7ux9JTOM
KYDHT50oWHVUOm5BbJdTWXlTURugDfsMz1e5xZw+KFSuIrNIwv6mF4b6ItLwBvh9
RsFAjUIE62CPIPY1L5yCw3ljOBEaV7Tmc95Awj4iXn3hhkiAHG5UzF3YfH4i9fRh
VkQhQt9VbXmo/g3GpxjeNhtehHTyzpm9BU9Uo4oeknhVfXKo4lE2HtUOUMjdnpf+
4Z8H796j+VK7mqMWxkWpG3WsL04LS5Gykc0gEkB431sE/6B9//zlDB8wGnX9aj2u
PkIcdCrmySYtOLlt9SqrE3Ci4lez/psZri+vYi2Ni+mb1rLAwQv9quHAHKkwGt6x
M9OiepCzjvDa25VyCsS09Otu5ZU9bdgJe2i+twKyFN20sBtCKYCJym43FdtIwen0
wnUAbezfXttfk+7kjUnNmwGDpX3JbDVCiPu8M3KYIJWr7TP4VvynWOU/cR/hOK3o
dsRdbxVVKvfrzpLQR4MQ552sCi6R7u0nyZJZhdcIT6e3YwQwEZeA8GIGT5IM0gQT
W+VVlrNbci4=
=bt3G
-----END PGP SIGNATURE-----

--==_Exmh_1567082044_4251P--
