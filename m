Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F52E2BC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 15:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLYO36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 09:29:58 -0500
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:52236 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgLYO35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:29:57 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 674927F4DB;
        Fri, 25 Dec 2020 17:29:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1608906555;
        bh=SjRuFnOir9ov00MT7KJb/UJDoRO9X7wmJGdxGII63Vc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=S4M4VbKc+MWIl/rXqN7ltDNbF3sLGw0opXoGPyDDL1K7Ka/xTy6NjEjLom8w+M6Qf
         HGCs93G3QIbbjFbmgFEePmjGn+ICF5wMrxzniAbigIBqtk0+FoLzLUGtVVkFCWjoGN
         sdyAJ4rFiWY3ZSEMsdsksYpdmshOTUvh0GOxWPao=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Dec 2020 17:29:15 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 25 Dec 2020 17:29:15 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH v14 06/10] fs/ntfs3: Add compression
Thread-Topic: [PATCH v14 06/10] fs/ntfs3: Add compression
Thread-Index: AQHWylTdIpZR6rup4EqAA/Bg1BTo06nnEmaAgAsMS3CAFeDpUA==
Date:   Fri, 25 Dec 2020 14:29:14 +0000
Message-ID: <e9a7b40787e14f6c93dfd6656735fed8@paragon-software.com>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
 <20201204154600.1546096-7-almaz.alexandrovich@paragon-software.com>
 <X8qCLXJOit0M+4X7@sol.localdomain>
 <d5b485fa9ced4923a47704c9ec19552e@paragon-software.com>
In-Reply-To: <d5b485fa9ced4923a47704c9ec19552e@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Komarov
> Sent: Friday, December 11, 2020 7:28 PM
> To: 'Eric Biggers' <ebiggers@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de
> Subject: RE: [PATCH v14 06/10] fs/ntfs3: Add compression
>=20
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Friday, December 4, 2020 9:39 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kerne=
l@vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> > aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perche=
s.com; mark@harmstone.com; nborisov@suse.com;
> > linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@o=
racle.com; hch@lst.de
> > Subject: Re: [PATCH v14 06/10] fs/ntfs3: Add compression
> >
> > On Fri, Dec 04, 2020 at 06:45:56PM +0300, Konstantin Komarov wrote:
> > > This adds compression
> > >
> > > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-softwa=
re.com>
> > > ---
> > >  fs/ntfs3/lib/common_defs.h       | 196 +++++++++++
> > >  fs/ntfs3/lib/decompress_common.c | 314 +++++++++++++++++
> > >  fs/ntfs3/lib/decompress_common.h | 558 +++++++++++++++++++++++++++++=
++
> > >  fs/ntfs3/lib/lzx_common.c        | 204 +++++++++++
> > >  fs/ntfs3/lib/lzx_common.h        |  31 ++
> > >  fs/ntfs3/lib/lzx_constants.h     | 113 +++++++
> > >  fs/ntfs3/lib/lzx_decompress.c    | 553 +++++++++++++++++++++++++++++=
+
> > >  fs/ntfs3/lib/xpress_constants.h  |  23 ++
> > >  fs/ntfs3/lib/xpress_decompress.c | 165 +++++++++
> > >  fs/ntfs3/lznt.c                  | 452 +++++++++++++++++++++++++
> > >  10 files changed, 2609 insertions(+)
> > >  create mode 100644 fs/ntfs3/lib/common_defs.h
> > >  create mode 100644 fs/ntfs3/lib/decompress_common.c
> > >  create mode 100644 fs/ntfs3/lib/decompress_common.h
> > >  create mode 100644 fs/ntfs3/lib/lzx_common.c
> > >  create mode 100644 fs/ntfs3/lib/lzx_common.h
> > >  create mode 100644 fs/ntfs3/lib/lzx_constants.h
> > >  create mode 100644 fs/ntfs3/lib/lzx_decompress.c
> > >  create mode 100644 fs/ntfs3/lib/xpress_constants.h
> > >  create mode 100644 fs/ntfs3/lib/xpress_decompress.c
> > >  create mode 100644 fs/ntfs3/lznt.c
> >
> > This really could use a much better commit message.  Including mentioni=
ng where
> > the LZX and XPRESS decompression code came from
> > (https://github.com/ebiggers/ntfs-3g-system-compression).
> >
>=20
> Hi Eric! Fixed in V15!
>=20
> > Also note you've marked the files as "SPDX-License-Identifier: GPL-2.0"=
,
> > but they really are "SPDX-License-Identifier: GPL-2.0-or-later".
> >
>=20
> Thanks, fixed as well.
>=20
> > Also I still think you should consider using the simpler version from
> > ntfs-3g-system-compression commit 3ddd227ee8e3, which I had originally =
intended
> > to be included in NTFS-3G itself.  That version was fewer lines of code=
 and
> > fewer files, as it was simplified for decompression-only.  The latest v=
ersion
> > (the one you're using) is shared with a project that also implements co=
mpression
> > (so that I can more easily maintain both projects), so it's more comple=
x than
> > needed for decompression-only support.  But in the kernel context it ma=
y make
> > sense to go with a simpler version.  There are a few performance optimi=
zations
> > you'd miss by going with the older version, but they weren't too signif=
icant,
> > and probably you don't need to squeeze out every bit of performance pos=
sible
> > when reading XPRESS and LZX-compressed files in this context?
> >
> > - Eric
>=20
> We used the newest code initially. Looking at the commit you've pointed o=
ut, but it will
> take some time as needs to pass full set of tests with new code. On the d=
ifferences you've
> mentioned between the first and latest code in ntfs-3g system compression=
: we've removed
> the optimizations (needed to go into kernel), also the reparse points stu=
ff is being parsed by
> ntfs3 driver itself. Given this, doesn't seems there are many differences=
 remain.
> Also, we'll follow your recommendations, if you highly recommend to stick=
 to the commit
> you've mentioned (but at this moment it seems "newer=3Dbetter" formula st=
ill valid).
>=20
> Thanks!

Hi Eric! The code in V16 is now based on the initial ntfs-3g plugin code, j=
ust as you suggested.

Best regards.
