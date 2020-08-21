Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0A24DAB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHUQZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:25:02 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59027 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728641AbgHUQYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:24:55 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id B9CDF8216F;
        Fri, 21 Aug 2020 19:24:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027090;
        bh=p7ELpXoegmwt3Cl7QwsvoavPZupsh5YjZJkRGTBnE28=;
        h=From:To:CC:Subject:Date;
        b=bUBWCZf8wGwB58DJLnHxMO/nt9i0/N6NIsDrVvDio19ef7Y2igBB/E5Oq0QhbTyq+
         rU/Bzbw24LEOkKTfXD9Gkj5xljb0bQIOjMcwXj6rP9wdBT19qAA2sVp+GfAkJ5ywIh
         yXVZguVkd5+NyNt88f2jjpNdHpbVYKtMWukUKnVI=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:24:50 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:24:50 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation by
 Paragon Software.
Thread-Topic: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation
 by Paragon Software.
Thread-Index: AdZ30n3KUTPgxpZ7Q/+ZtR0YneODPw==
Date:   Fri, 21 Aug 2020 16:24:50 +0000
Message-ID: <904d985365a34f0787a4511435417ab3@paragon-software.com>
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

This patch adds NTFS Read-Write driver to fs/ntfs3.

Having decades of expertise in commercial file systems development and huge
test coverage, we at Paragon Software GmbH want to make our contribution to
the Open Source Community by providing implementation of NTFS Read-Write
driver for the Linux Kernel.

This is fully functional NTFS Read-Write driver. Current version works with
NTFS(including v3.1) and normal/compressed/sparse files and supports journa=
l replaying.

We plan to support this version after the codebase once merged, and add new
features and fix bugs. For example, full journaling support over JBD will b=
e
added in later updates.

v2:
 - patch splitted to chunks (file-wise)
 - build issues fixed
 - sparse and checkpatch.pl errors fixed
 - NULL pointer dereference on mkfs.ntfs-formatted volume mount fixed=20
 - cosmetics + code cleanup

Konstantin Komarov (10):
  fs/ntfs3: Add headers and misc files
  fs/ntfs3: Add initialization of super block
  fs/ntfs3: Add bitmap
  fs/ntfs3: Add file operations and implementation
  fs/ntfs3: Add attrib operations
  fs/ntfs3: Add compression
  fs/ntfs3: Add NTFS journal
  fs/ntfs3: Add Kconfig, Makefile and doc
  fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
  fs/ntfs3: Add MAINTAINERS

 Documentation/filesystems/ntfs3.rst |   93 +
 MAINTAINERS                         |    7 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs3/Kconfig                    |   23 +
 fs/ntfs3/Makefile                   |   11 +
 fs/ntfs3/attrib.c                   | 1285 +++++++
 fs/ntfs3/attrlist.c                 |  455 +++
 fs/ntfs3/bitfunc.c                  |  144 +
 fs/ntfs3/bitmap.c                   | 1545 ++++++++
 fs/ntfs3/debug.h                    |   77 +
 fs/ntfs3/dir.c                      |  529 +++
 fs/ntfs3/file.c                     | 1179 ++++++
 fs/ntfs3/frecord.c                  | 2179 +++++++++++
 fs/ntfs3/fslog.c                    | 5217 +++++++++++++++++++++++++++
 fs/ntfs3/fsntfs.c                   | 2196 +++++++++++
 fs/ntfs3/index.c                    | 2640 ++++++++++++++
 fs/ntfs3/inode.c                    | 2068 +++++++++++
 fs/ntfs3/lznt.c                     |  449 +++
 fs/ntfs3/namei.c                    |  566 +++
 fs/ntfs3/ntfs.h                     | 1253 +++++++
 fs/ntfs3/ntfs_fs.h                  |  965 +++++
 fs/ntfs3/record.c                   |  612 ++++
 fs/ntfs3/run.c                      | 1188 ++++++
 fs/ntfs3/super.c                    | 1409 ++++++++
 fs/ntfs3/upcase.c                   |   78 +
 fs/ntfs3/xattr.c                    |  968 +++++
 27 files changed, 27138 insertions(+)
 create mode 100644 Documentation/filesystems/ntfs3.rst
 create mode 100644 fs/ntfs3/Kconfig
 create mode 100644 fs/ntfs3/Makefile
 create mode 100644 fs/ntfs3/attrib.c
 create mode 100644 fs/ntfs3/attrlist.c
 create mode 100644 fs/ntfs3/bitfunc.c
 create mode 100644 fs/ntfs3/bitmap.c
 create mode 100644 fs/ntfs3/debug.h
 create mode 100644 fs/ntfs3/dir.c
 create mode 100644 fs/ntfs3/file.c
 create mode 100644 fs/ntfs3/frecord.c
 create mode 100644 fs/ntfs3/fslog.c
 create mode 100644 fs/ntfs3/fsntfs.c
 create mode 100644 fs/ntfs3/index.c
 create mode 100644 fs/ntfs3/inode.c
 create mode 100644 fs/ntfs3/lznt.c
 create mode 100644 fs/ntfs3/namei.c
 create mode 100644 fs/ntfs3/ntfs.h
 create mode 100644 fs/ntfs3/ntfs_fs.h
 create mode 100644 fs/ntfs3/record.c
 create mode 100644 fs/ntfs3/run.c
 create mode 100644 fs/ntfs3/super.c
 create mode 100644 fs/ntfs3/upcase.c
 create mode 100644 fs/ntfs3/xattr.c

--=20
2.25.2

