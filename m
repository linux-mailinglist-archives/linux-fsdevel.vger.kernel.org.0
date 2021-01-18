Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBABB2FA2EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404907AbhAROYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 09:24:30 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:46452 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388726AbhARLot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:44:49 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A9C243AA;
        Mon, 18 Jan 2021 14:43:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1610970212;
        bh=jVpgbGpExsWnTkYnhLYwh/dz9H4Di6dMiBWqL70OqOc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=rnzHic1VAOP86/lYsApG23Y3CiDxizwVG1kUxLYZwtwGwPfiOUHEPAA32f465vdvq
         EElfy9ox0E16HUsLnDmqBtwMEaE9LeOBDXgl1aI/YBYxgqMrFbzRM0FZNZycYW1Er5
         MK6wy28ERA7Y9dwEhcc8m0nJjBQ8uBn4DBAhLVr0=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 18 Jan 2021 14:43:32 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Mon, 18 Jan 2021 14:43:32 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Kari Argillander <kari.argillander@gmail.com>
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
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
Subject: RE: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Topic: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Index: AQHW34lEkxIP5Qb5rEarjEX9L/0H2qoWSFWAgBcWrZA=
Date:   Mon, 18 Jan 2021 11:43:31 +0000
Message-ID: <baa71c9fa715473e87172c3afa3cc7d2@paragon-software.com>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-9-almaz.alexandrovich@paragon-software.com>
 <20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox>
In-Reply-To: <20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.0.64]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>
Sent: Monday, January 4, 2021 1:08 AM
> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@=
vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.=
com; mark@harmstone.com; nborisov@suse.com;
> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@ora=
cle.com; hch@lst.de; ebiggers@kernel.org;
> andy.lavr@gmail.com
> Subject: Re: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
>=20
> On Thu, Dec 31, 2020 at 06:23:59PM +0300, Konstantin Komarov wrote:
> > This adds Kconfig, Makefile and doc
> >
> > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software=
.com>
> > ---
> >  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++
> >  fs/ntfs3/Kconfig                    |  41 +++++++++++
> >  fs/ntfs3/Makefile                   |  31 ++++++++
>=20
> Also Documentation/filesystems/index.rst should contain ntfs3.
>=20
> >  3 files changed, 179 insertions(+)
> >  create mode 100644 Documentation/filesystems/ntfs3.rst
> >  create mode 100644 fs/ntfs3/Kconfig
> >  create mode 100644 fs/ntfs3/Makefile
> >
>=20
> > diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> > new file mode 100644
> > index 000000000000..f9b732f4a5a0
> > --- /dev/null
> > +++ b/fs/ntfs3/Kconfig
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NTFS3_FS
> > +	tristate "NTFS Read-Write file system support"
> > +	select NLS
> > +	help
> > +	  Windows OS native file system (NTFS) support up to NTFS version 3.1=
.
> > +
> > +	  Y or M enables the NTFS3 driver with full features enabled (read,
> > +	  write, journal replaying, sparse/compressed files support).
> > +	  File system type to use on mount is "ntfs3". Module name (M option)
> > +	  is also "ntfs3".
> > +
> > +	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
> > +
> > +config NTFS3_64BIT_CLUSTER
> > +	bool "64 bits per NTFS clusters"
> > +	depends on NTFS3_FS && 64BIT
> > +	help
> > +	  Windows implementation of ntfs.sys uses 32 bits per clusters.
> > +	  If activated 64 bits per clusters you will be able to use 4k cluste=
r
> > +	  for 16T+ volumes. Windows will not be able to mount such volumes.
> > +
> > +	  It is recommended to say N here.
> > +
> > +config NTFS3_LZX_XPRESS
> > +	bool "activate support of external compressions lzx/xpress"
> > +	depends on NTFS3_FS
> > +	help
> > +	  In Windows 10 one can use command "compact" to compress any files.
> > +	  4 possible variants of compression are: xpress4k, xpress8k, xpress1=
6 and lzx.
> > +	  To read such "compacted" files say Y here.
>=20
> It would be nice that we tell what is recommend. I think that this is rec=
ommend.
> Of course if this use lot's of resource that is different story but I do =
not
> think that is the case.
>=20
> > +
> > +config NTFS3_POSIX_ACL
> > +	bool "NTFS POSIX Access Control Lists"
> > +	depends on NTFS3_FS
> > +	select FS_POSIX_ACL
> > +	help
> > +	  POSIX Access Control Lists (ACLs) support additional access rights
> > +	  for users and groups beyond the standard owner/group/world scheme,
> > +	  and this option selects support for ACLs specifically for ntfs
> > +	  filesystems.
>=20
> Same here. Let's suggest what user should do. Is this recommend if we wan=
't
> to use volume also in Windows?

Hi! All done, thanks for pointing these out.
