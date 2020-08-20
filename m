Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A113824B7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHTLEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:04:04 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:58708 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731373AbgHTK7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:59:23 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id CCF3A821EC;
        Thu, 20 Aug 2020 13:59:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1597921155;
        bh=/G4ClTatYbNc8NxLLIvGhk7wy/zotPptuhCDIH3E+SQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=NkfVgGe6ekDpYeVZB9ZORxdbkNwIVRGPvRJQ0rybcJlywu4honSmfpm1TfS46YYxz
         UK2yZrfmvCgMMwyevyqWmLTqYgBx9lcQMb6tWSZxh5p6hL+ZYkPiiUKLP01AtD5gjW
         SE8YHmKYhpxynd+MXu5EQN3DB6xHy675nukXT0Cs=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 20 Aug 2020 13:59:15 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 20 Aug 2020 13:59:15 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Index: AdZyNcmjSkpkGje7R9K6YobJrVDyZ///4zWA//aNcGA=
Date:   Thu, 20 Aug 2020 10:59:15 +0000
Message-ID: <416846245360401380734c4ee2a82f5c@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
 <20200814134056.GV2026@twin.jikos.cz>
In-Reply-To: <20200814134056.GV2026@twin.jikos.cz>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Sterba <dsterba@suse.cz>
Sent: Friday, August 14, 2020 4:41 PM
> In case somebody wants to compile it, this fixup is needed to let 'make
> fs/ntfs3/' actually work, besides enabling it in the config.
>=20
> diff --git a/fs/Makefile b/fs/Makefile
> index 1c7b0e3f6daa..b0b4ad8affa0 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_SYSV_FS)		+=3D sysv/
>  obj-$(CONFIG_CIFS)		+=3D cifs/
>  obj-$(CONFIG_HPFS_FS)		+=3D hpfs/
>  obj-$(CONFIG_NTFS_FS)		+=3D ntfs/
> +obj-$(CONFIG_NTFS3_FS)		+=3D ntfs3/
>  obj-$(CONFIG_UFS_FS)		+=3D ufs/
>  obj-$(CONFIG_EFS_FS)		+=3D efs/
>  obj-$(CONFIG_JFFS2_FS)		+=3D jffs2/
> diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
> index 4d4fe198b8b8..d99dd1af43aa 100644
> --- a/fs/ntfs3/Makefile
> +++ b/fs/ntfs3/Makefile
> @@ -5,7 +5,7 @@
>=20
>  obj-$(CONFIG_NTFS3_FS) +=3D ntfs3.o
>=20
> -ntfs3-objs :=3D bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
> +ntfs3-y :=3D bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
>  	    index.o attrlist.o record.o attrib.o run.o xattr.o\
>  	    upcase.o super.o file.o dir.o namei.o lznt.o\
>  	    fslog.o

Thanks! Indeed these fixups are needed to the patch (lost them during final=
 polishing of the code before submitting). Will be fixed in v2.
