Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5478254AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0QY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:24:28 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:48064 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgH0QYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:24:24 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id F0536820D7;
        Thu, 27 Aug 2020 19:24:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598545461;
        bh=OhOFVzvb94CEyYGinUxtmM6MzbSpiMNb4ADL68UbxqI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=YQiJIeRDYXzRKrD6UstupI2B9Byzits5GM/4ZweDN6WmWf/jAewKh9aQfyYHV1iBj
         amDG8JQLnktv2pNVBoEwWTyNNNZzD46xzYbY02IMkLGsVgq/x1Fy1eauh5GYnlRjRZ
         VmLl/Os2sTeYalyhf9U+lJ5vPyioFkjF7Jtd/YgE=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 19:24:21 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 19:24:21 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Topic: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Thread-Index: AdZ302F8VVG9og4hTA6+RhoU6EU4hgBSfjSAANwmvxA=
Date:   Thu, 27 Aug 2020 16:24:21 +0000
Message-ID: <c30f0c3684b44dada4697275b4443f15@paragon-software.com>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
 <20200823101643.2qljlqzxne4r32am@pali>
In-Reply-To: <20200823101643.2qljlqzxne4r32am@pali>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pali Roh=E1r <pali@kernel.org>
Sent: Sunday, August 23, 2020 1:17 PM
>=20
> On Friday 21 August 2020 16:25:37 Konstantin Komarov wrote:
> > +Mount Options
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The list below describes mount options supported by NTFS3 driver in ad=
dtion to
> > +generic ones.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +nls=3Dname		These options inform the driver how to interpret path
> > +			strings and translate them to Unicode and back. In case
> > +			none of these options are set, or if specified codepage
> > +			doesn't exist on the system, the default codepage will be
> > +			used (CONFIG_NLS_DEFAULT).
> > +			Examples:
> > +				'nls=3Dutf8'
> > +
> > +uid=3D
> > +gid=3D
>=20
> IIRC ntfs filesystem had concept of storing unix owner/group. Was it
> dropped? Or it is incompatible with current Windows implementation? I'm
> just curious if we cannot use ntfs-native unix permissions instead of
> forcing them from mount options. Maybe as improvement for future.
>=20
> Normally owner/group on ntfs is stored in that windows SID format.
> ntfs-3g fuse driver has some mount option where you can specify mapping
> table between SID and unix to make permissions compatible with existing
> windows installations.
>=20
> Such functionality could be a nice feature once somebody would have time
> to implement it in future...
>=20

If you mean the way on how WLS implements the unix ownership and permission=
s (using NTFS extended attributes to store values), then it seems to be qui=
te handy way of operation. Will be done in future versions.

> > +umask=3D			Controls the default permissions for files/directories crea=
ted
> > +			after the NTFS volume is mounted.
> > +
> > +fmask=3D
> > +dmask=3D			Instead of specifying umask which applies both to
> > +			files and directories, fmask applies only to files and
> > +			dmask only to directories.
> > +
> > +nohidden		Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDE=
N)
> > +			attribute will not be shown under Linux.
>=20
> What other people think? It is useful mount option which would disallow
> access to hidden files? Hidden attribute is normal attribute which even
> normal user without admin rights on Windows can set on its own files.
>=20
> Also concept of hidden files is already present for fat filesystems and
> we do not have such mount option nor for msdosfs, vfat nor for exfat.
>=20
> Konstantin, what is purpose of this mount option? I would like to know
> what usecases have this option.
>=20

It is indeed discussional mount option. The purpose of it is to protect use=
rs from modifying/deleting Windows system files, which may affect bootabili=
ty of the OS. Unlikely the case for fat32/exfat nowadays, but quite actual =
for ntfs (dual-boot win/lin configurations).

> > +sys_immutable		Files with the Windows-specific SYSTEM
> > +			(FILE_ATTRIBUTE_SYSTEM) attribute will be marked as system
> > +			immutable files.
> > +
> > +discard			Enable support of the TRIM command for improved performance
> > +			on delete operations, which is recommended for use with the
> > +			solid-state drives (SSD).
> > +
> > +force			Forces the driver to mount partitions even if 'dirty' flag
> > +			(volume dirty) is set. Not recommended for use.
> > +
> > +sparse			Create new files as "sparse".
> > +
> > +showmeta		Use this parameter to show all meta-files (System Files) on
> > +			a mounted NTFS partition.
> > +			By default, all meta-files are hidden.
> > +
> > +no_acs_rules		"No access rules" mount option sets access rights for
> > +			files/folders to 777 and owner/group to root. This mount
> > +			option absorbs all other permissions:
> > +			- permissions change for files/folders will be reported
> > +				as successful, but they will remain 777;
> > +			- owner/group change will be reported as successful, but
> > +				they will stay as root
>=20
> What about rather adding "mode=3D" and "dmode=3D" mount option which woul=
d
> specify permissions for all files and directories? Other filesystems
> have support for "mode=3D" mount option and I think it is better if
> filesystems have some "common" options and not each filesystem its own
> mount option for similar features.
>=20

According to what we can see: some file systems provide umask/dmask mount o=
ptions, others provide mode/dmode. It's hard for us to decide which pair sh=
ould be presented (and providing both may be a bit confusing for usage). Bu=
t as for implementation - it could be done easily, if needed.

> > diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> > new file mode 100644
> > index 000000000000..92a9c68008c8
> > --- /dev/null
> > +++ b/fs/ntfs3/Kconfig
> > @@ -0,0 +1,23 @@
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
>=20
> Would it be possible to change this compile time option into mount
> option?
>=20
> Because I do not see any benefit in compile time option which makes
> kernel's ntfs driver "fully" incompatible with Windows implementation.
>=20
> For me it looks like that mount option for such functionality is more
> suitable.

It would be possible, but I can't find any pros for this. Overall, having t=
he "switch" which will turn this off/on in the runtime won't give any benef=
its.=20
The support for 64bit-sized number of cluster won't break compatibility wit=
h Windows, it may just extend ntfs3 capabilities over the windows. Windows =
in general does not support volumes with more than 2^32 clusters for NTFS. =
NTFS3 will mount such volumes, Windows won't. But everthing mountable in Wi=
ndows, will be mountable by ntfs3 and, after this, by Windows again, nevert=
heless if this option is enabled or not.

Thanks.
