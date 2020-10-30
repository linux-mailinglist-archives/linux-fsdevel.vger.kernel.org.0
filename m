Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B438F2A0A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgJ3PvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 11:51:13 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:36150 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbgJ3PvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:51:13 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1C9191D21;
        Fri, 30 Oct 2020 18:51:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1604073071;
        bh=9GP4n1/3kUo9xtQjP38LQz9IULvQeP9/jTJo14gQVIU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=iacMwHHlvIIUyCEHKGv4IcE/D3MNb2nLkwRNPRFuXK+cJjiw+BBzbQDgzsLjTgYEE
         duerL025mODm9V5wP66qPliXOGqgeIlCYzJPiiyggwIdgvagFJpq2AyQvqT6MA+OPo
         1wDc2QtYP4jJ8smeGOsyYO9ssHQL96IXkmz4uZCQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 30 Oct 2020 18:51:10 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 30 Oct 2020 18:51:10 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>
Subject: RE: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Topic: [PATCH v11 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Thread-Index: AQHWrs4AbuX6Qk1kykuA/KYohSTSz6mwEbcAgAA1JlA=
Date:   Fri, 30 Oct 2020 15:51:10 +0000
Message-ID: <5313baaad14c40d09738bf63e4659ac9@paragon-software.com>
References: <20201030150239.3957156-1-almaz.alexandrovich@paragon-software.com>
 <20201030152450.77mtzkxjove36qfd@pali>
In-Reply-To: <20201030152450.77mtzkxjove36qfd@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pali Roh=E1r <pali@kernel.org>
Sent: Friday, October 30, 2020 6:25 PM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmsto=
ne.com; nborisov@suse.com; linux-ntfs-
> dev@lists.sourceforge.net; anton@tuxera.com
> Subject: Re: [PATCH v11 00/10] NTFS read-write driver GPL implementation =
by Paragon Software
>=20
> Hello and thanks for update!
>=20
> I have just two comments for the last v11 version.
>=20
> I really do not like nls_alt mount option and I do not think we should
> merge this mount option into ntfs kernel driver. Details I described in:
> https://lore.kernel.org/linux-fsdevel/20201009154734.andv4es3azkkskm5@pal=
i/
>=20
> tl;dr it is not systematic solution and is incompatible with existing
> in-kernel ntfs driver, also incompatible with in-kernel vfat, udf and
> ext4 (with UNICODE support) drivers. In my opinion, all kernel fs
> drivers which deals with UNICODE should handle it in similar way.
>=20

Hello Pali! First of all, apologies for not providing a feedback on your pr=
evious
message regarding the 'nls_alt'. We had internal discussions on the topic a=
nd
overall conclusion is that: we do not want to compromise Kernel standards w=
ith
our submission. So we will remove the 'nls_alt' option in the next version.

However, there are still few points we have on the topic, please read below=
.

> It would be really bad if userspace application need to behave
> differently for this new ntfs driver and differently for all other
> UNICODE drivers.
>=20

The option does not anyhow affect userspace applications. For the "default"=
 example
of unzip/tar:
1 - if this option is not applied (e.g. "vfat case"), trying to unzip an ar=
chive with, e.g. CP-1251,
names inside to the target fs volume, will return error, and issued file(s)=
 won't be unzipped;
2 - if this option is applied and "nls_alt" is set, the above case will res=
ult in unzipping all the files;

Also, this issue in general only applies to "non-native" filesystems. I.e. =
ext4 is not affected by it
in any case, as it just stores the name as bytes, no matter what those byte=
s are. The above case
won't give an unzip error on ext4. The only symptom of this would be, maybe=
, "incorrect encoding"
marking within the listing of such files (in File Manager or Terminal, e.g.=
 in Ubuntu), but there won't
be an unzip process termination with incomplete unarchived fileset, unlike =
it is for vfat/exfat/ntfs
without "nls_alt".

> Second comment is simplification of usage nls_load() with UTF-8 parameter
> which I described in older email:
> https://lore.kernel.org/linux-fsdevel/948ac894450d494ea15496c2e5b8c906@pa=
ragon-software.com/
>=20
> You wrote that you have applied it, but seems it was lost (maybe during
> rebase?) as it is not present in the last v11 version.
>=20
> I suggested to not use nls_load() with UTF-8 at all. Your version of
> ntfs driver does not use kernel's nls utf8 module for UTF-8 support, so
> trying to load it should be avoided. Also kernel can be compiled without
> utf8 nls module (which is moreover broken) and with my above suggestion,
> ntfs driver would work correctly. Without that suggestion, mounting
> would fail.

Thanks for pointing that out. It is likely the "nls_load()" fixes were lost=
 during rebase.
Will recheck it and return them to the v12.

Best regards!
