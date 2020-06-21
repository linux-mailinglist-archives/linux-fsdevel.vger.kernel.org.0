Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD8202A8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 14:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgFUMq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 08:46:27 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:61385 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgFUMq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 08:46:26 -0400
Date:   Sun, 21 Jun 2020 12:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1592743582;
        bh=o7oADJo0vJuRKcp5TG0sjztoofAY/q6zn+gdMVXU/GQ=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=kZYQnAe+0TNQTKsA3aMy0leOxXUaskrYFNn7A1suGYSWjTQaMPmCXkN8ERgKujCNv
         qyU05tFqExaDLTgsHhZrZdt7SJAiikGuXAN4R04dFdyhEcOipoCSaGQ+w2eAcjn21e
         L8PgELoRu2U7+Ehi3MbrvUHpOzkMbH8cm1qOjkss=
To:     linux-fsdevel@vger.kernel.org
From:   Rob Gill <rrobgill@protonmail.com>
Cc:     Rob Gill <rrobgill@protonmail.com>
Reply-To: Rob Gill <rrobgill@protonmail.com>
Subject: [PATCH] fs Add MODULE_DESCRIPTION entries to kernel modules
Message-ID: <20200621124607.24573-1-rrobgill@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The user tool modinfo is used to get information on kernel modules, includi=
ng a
description where it is available.

This patch adds a brief MODULE_DESCRIPTION to modules, text taken when
available from code comments or information within Kconfig.

Signed-off-by: Rob Gill <rrobgill@protonmail.com>
---
 fs/9p/v9fs.c      | 1 +
 fs/adfs/super.c   | 1 +
 fs/autofs/init.c  | 1 +
 fs/btrfs/super.c  | 1 +
 fs/cramfs/inode.c | 1 +
 fs/efs/super.c    | 1 +
 fs/hfs/super.c    | 1 +
 fs/hpfs/super.c   | 1 +
 fs/isofs/inode.c  | 1 +
 fs/jbd2/journal.c | 1 +
 fs/minix/inode.c  | 1 +
 fs/nfs/inode.c    | 1 +
 fs/nfsd/nfsctl.c  | 1 +
 fs/qnx4/inode.c   | 1 +
 fs/qnx6/inode.c   | 1 +
 fs/sysv/super.c   | 1 +
 fs/ufs/super.c    | 1 +
 17 files changed, 17 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 15a99f9c7..a9b5d0d25 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -739,3 +739,4 @@ MODULE_AUTHOR("Latchesar Ionkov <lucho@ionkov.net>");
 MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
 MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Plan 9 Resource Sharing Support (9P2000)");
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index a3cc8ecb5..dd5c4a7d8 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -492,3 +492,4 @@ static void __exit exit_adfs_fs(void)
 module_init(init_adfs_fs)
 module_exit(exit_adfs_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Acorn Disc Filing System support");
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index d3f55e874..291ef8de9 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -44,3 +44,4 @@ static void __exit exit_autofs_fs(void)
 module_init(init_autofs_fs)
 module_exit(exit_autofs_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kernel automounter support");
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bc73fd670..c1b2eaa53 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2518,3 +2518,4 @@ MODULE_SOFTDEP("pre: crc32c");
 MODULE_SOFTDEP("pre: xxhash64");
 MODULE_SOFTDEP("pre: sha256");
 MODULE_SOFTDEP("pre: blake2b-256");
+MODULE_DESCRIPTION("Btrfs general purpose copy-on-write filesystem");
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600..94df29184 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -1011,3 +1011,4 @@ static void __exit exit_cramfs_fs(void)
 module_init(init_cramfs_fs)
 module_exit(exit_cramfs_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Compressed ROM file system support (cramfs)");
diff --git a/fs/efs/super.c b/fs/efs/super.c
index 4a6ebff2a..cc6acac88 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -42,6 +42,7 @@ static struct file_system_type efs_fs_type =3D {
 =09.fs_flags=09=3D FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("efs");
+MODULE_DESCRIPTION("EFS file system support (read only)");
=20
 static struct pt_types sgi_pt_types[] =3D {
 =09{0x00,=09=09"SGI vh"},
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index c33324686..c48a51ab3 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -29,6 +29,7 @@
 static struct kmem_cache *hfs_inode_cachep;
=20
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Apple Macintosh file system support");
=20
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 0a677a9aa..7f59cded8 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -792,3 +792,4 @@ static void __exit exit_hpfs_fs(void)
 module_init(init_hpfs_fs)
 module_exit(exit_hpfs_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OS/2 HPFS file system support");
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d634561f8..0db1209a6 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1615,3 +1615,4 @@ static void __exit exit_iso9660_fs(void)
 module_init(init_iso9660_fs)
 module_exit(exit_iso9660_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ISO 9660 CDROM file system support");
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e4944436e..1abd25b32 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2759,6 +2759,7 @@ static void __exit journal_exit(void)
 }
=20
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("generic journaling layer");
 module_init(journal_init);
 module_exit(journal_exit);
=20
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 7cb5fd38e..cf770ae20 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -686,4 +686,5 @@ static void __exit exit_minix_fs(void)
 module_init(init_minix_fs)
 module_exit(exit_minix_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Minix file system support");
=20
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0bf1f835d..cbb88f16e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2307,6 +2307,7 @@ static void __exit exit_nfs_fs(void)
 /* Not quite true; I just maintain it */
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS Network File System protocol support");
 module_param(enable_ino64, bool, 0644);
=20
 module_init(init_nfs_fs)
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b68e96681..deb964034 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1580,5 +1580,6 @@ static void __exit exit_nfsd(void)
=20
 MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS server support");
 module_init(init_nfsd)
 module_exit(exit_nfsd)
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde8..cf7b396a7 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -421,4 +421,5 @@ static void __exit exit_qnx4_fs(void)
 module_init(init_qnx4_fs)
 module_exit(exit_qnx4_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("QNX4 file system support (read only)");
=20
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 755293c8c..a7e0fb162 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -680,3 +680,4 @@ static void __exit exit_qnx6_fs(void)
 module_init(init_qnx6_fs)
 module_exit(exit_qnx6_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("QNX6 file system");
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index cc8e2ed15..e1c871d47 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -592,3 +592,4 @@ static void __exit exit_sysv_fs(void)
 module_init(init_sysv_fs)
 module_exit(exit_sysv_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("System V/Xenix/V7/Coherent file system support");
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 1da0be667..7c4e37bda 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1543,3 +1543,4 @@ static void __exit exit_ufs_fs(void)
 module_init(init_ufs_fs)
 module_exit(exit_ufs_fs)
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UFS file system support (read only)");
--=20
2.17.1


