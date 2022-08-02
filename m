Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30627588228
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiHBTBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiHBTBI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:01:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB820BF4;
        Tue,  2 Aug 2022 12:00:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3607238294;
        Tue,  2 Aug 2022 19:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659466857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65QO5pW9ACE7qc/gKTwtNzBM4PCqrgF1JUz/Mzzo59g=;
        b=O4jUbB9me8IC8JCWvDQHZQV0nFduWzwu0GwVyZQJ4zDxY9jz0Y2U4nvu1Tza4Fgl1CDHrO
        nejPoETe/BfCAaNGiODvH9as9QKXNes9h2EO4hvutVCPsTh11NypUeah4D53aWwvnAZ4I8
        803pY60A+vhbPvYXVHvL5UQX3tTHIs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659466857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65QO5pW9ACE7qc/gKTwtNzBM4PCqrgF1JUz/Mzzo59g=;
        b=2PXGXQYmUCPxvULfQURvyw4MS894Cce0DI+SBGTi3BKZL39YVZ8p97VEcNj3zqFfSRs/pz
        Jf6AvxlUw2vM4TDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2410813A8E;
        Tue,  2 Aug 2022 19:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xTvWNWd06WLbXwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 19:00:55 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tom@talpey.com,
        samba-technical@lists.samba.org, pshilovsky@samba.org,
        jlayton@kernel.org, rpenny@samba.org
Subject: [RFC PATCH v2 1/5] cifs: change module name to "smbfs.ko"
Date:   Tue,  2 Aug 2022 16:00:44 -0300
Message-Id: <20220802190048.19881-2-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220802190048.19881-1-ematsumiya@suse.de>
References: <20220802190048.19881-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename "cifs.ko" module to "smbfs.ko", but keep "cifs" as a module alias
for compatibility with existing scripts/tools.

TODO: update spnego and idmap key names, cifs-utils, etc, warn about
      module rename
To discuss: procfs entries (/proc/fs/cifs)

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/Kconfig                    |   4 +-
 fs/Makefile                   |   2 +-
 fs/cifs/Kconfig               | 108 +++++++++++++++++-----------------
 fs/cifs/Makefile              |  24 ++++----
 fs/cifs/cifs_debug.c          |  72 +++++++++++------------
 fs/cifs/cifs_debug.h          |   4 +-
 fs/cifs/cifs_dfs_ref.c        |   2 +-
 fs/cifs/cifs_spnego.c         |   4 +-
 fs/cifs/cifs_swn.h            |   4 +-
 fs/cifs/cifsacl.c             |   6 +-
 fs/cifs/cifsglob.h            |  26 ++++----
 fs/cifs/cifspdu.h             |   6 +-
 fs/cifs/cifsproto.h           |  10 ++--
 fs/cifs/cifssmb.c             |  14 ++---
 fs/cifs/connect.c             |  36 ++++++------
 fs/cifs/{cifsfs.c => core.c}  |  49 +++++++--------
 fs/cifs/dfs_cache.c           |   2 +-
 fs/cifs/dir.c                 |   2 +-
 fs/cifs/export.c              |   8 +--
 fs/cifs/file.c                |  16 ++---
 fs/cifs/fs_context.c          |  20 +++----
 fs/cifs/fscache.h             |   6 +-
 fs/cifs/inode.c               |  10 ++--
 fs/cifs/ioctl.c               |   6 +-
 fs/cifs/link.c                |   2 +-
 fs/cifs/misc.c                |  14 ++---
 fs/cifs/netmisc.c             |   2 +-
 fs/cifs/ntlmssp.h             |   2 +-
 fs/cifs/readdir.c             |   4 +-
 fs/cifs/sess.c                |  10 ++--
 fs/cifs/smb1ops.c             |   4 +-
 fs/cifs/smb2file.c            |   2 +-
 fs/cifs/smb2inode.c           |   2 +-
 fs/cifs/smb2ops.c             |  32 +++++-----
 fs/cifs/smb2pdu.c             |  22 +++----
 fs/cifs/smb2transport.c       |   2 +-
 fs/cifs/smbdirect.h           |   2 +-
 fs/cifs/{cifsfs.h => smbfs.h} |  12 ++--
 fs/cifs/transport.c           |   4 +-
 fs/cifs/xattr.c               |  18 +++---
 40 files changed, 287 insertions(+), 288 deletions(-)
 rename fs/cifs/{cifsfs.c => core.c} (98%)
 rename fs/cifs/{cifsfs.h => smbfs.h} (97%)

diff --git a/fs/Kconfig b/fs/Kconfig
index 5976eb33535f..860ca257c681 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -377,8 +377,8 @@ source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
 	tristate
-	default y if CIFS=y || SMB_SERVER=y
-	default m if CIFS=m || SMB_SERVER=m
+	default y if SMBFS=y || SMB_SERVER=y
+	default m if SMBFS=m || SMB_SERVER=m
 
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 208a74e0b00e..a07039e124ce 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -99,7 +99,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-y				+= unicode/
 obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_SMBFS_COMMON)	+= smbfs_common/
-obj-$(CONFIG_CIFS)		+= cifs/
+obj-$(CONFIG_SMBFS)		+= cifs/
 obj-$(CONFIG_SMB_SERVER)	+= ksmbd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 3b7e3b9e4fd2..c2157720ffc1 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config CIFS
-	tristate "SMB3 and CIFS support (advanced network filesystem)"
+config SMBFS
+	tristate "SMBFS support (protocol versions 1, 2, and 3)"
 	depends on INET
 	select NLS
 	select CRYPTO
@@ -37,9 +37,9 @@ config CIFS
 	  and similar very old servers.
 
 	  This module provides an advanced network file system client
-	  for mounting to SMB3 (and CIFS) compliant servers.  It includes
-	  support for DFS (hierarchical name space), secure per-user
-	  session establishment via Kerberos or NTLM or NTLMv2, RDMA
+	  for mounting to SMB-compliant servers.  It includes support for
+	  DFS (hierarchical name space), secure per-user session
+	  establishment via Kerberos or NTLM or NTLMv2, RDMA
 	  (smbdirect), advanced security features, per-share encryption,
 	  directory leases, safe distributed caching (oplock), optional packet
 	  signing, Unicode and other internationalization improvements.
@@ -47,29 +47,29 @@ config CIFS
 	  In general, the default dialects, SMB3 and later, enable better
 	  performance, security and features, than would be possible with CIFS.
 	  Note that when mounting to Samba, due to the CIFS POSIX extensions,
-	  CIFS mounts can provide slightly better POSIX compatibility
+	  SMBFS mounts can provide slightly better POSIX compatibility
 	  than SMB3 mounts. SMB2/SMB3 mount options are also
 	  slightly simpler (compared to CIFS) due to protocol improvements.
 
 	  If you need to mount to Samba, Azure, Macs or Windows from this machine, say Y.
 
-config CIFS_STATS2
+config SMBFS_STATS2
 	bool "Extended statistics"
-	depends on CIFS
+	depends on SMBFS
 	default y
 	help
 	  Enabling this option will allow more detailed statistics on SMB
 	  request timing to be displayed in /proc/fs/cifs/DebugData and also
 	  allow optional logging of slow responses to dmesg (depending on the
-	  value of /proc/fs/cifs/cifsFYI). See Documentation/admin-guide/cifs/usage.rst
+	  value of /proc/fs/cifs/cifsFYI). See Documentation/admin-guide/smbfs/usage.rst
 	  for more details. These additional statistics may have a minor effect
 	  on performance and memory utilization.
 
 	  If unsure, say Y.
 
-config CIFS_ALLOW_INSECURE_LEGACY
+config SMBFS_ALLOW_INSECURE_LEGACY
 	bool "Support legacy servers which use less secure dialects"
-	depends on CIFS
+	depends on SMBFS
 	default y
 	help
 	  Modern dialects, SMB2.1 and later (including SMB3 and 3.1.1), have
@@ -78,69 +78,69 @@ config CIFS_ALLOW_INSECURE_LEGACY
 	  of legacy dialects (SMB1/CIFS and SMB2.0) is discouraged.
 
 	  Disabling this option prevents users from using vers=1.0 or vers=2.0
-	  on mounts with cifs.ko
+	  on mounts with smbfs.ko
 
 	  If unsure, say Y.
 
-config CIFS_UPCALL
+config SMBFS_UPCALL
 	bool "Kerberos/SPNEGO advanced session setup"
-	depends on CIFS
+	depends on SMBFS
 	help
-	  Enables an upcall mechanism for CIFS which accesses userspace helper
+	  Enables an upcall mechanism for SMBFS which accesses userspace helper
 	  utilities to provide SPNEGO packaged (RFC 4178) Kerberos tickets
 	  which are needed to mount to certain secure servers (for which more
 	  secure Kerberos authentication is required). If unsure, say Y.
 
-config CIFS_XATTR
+config SMBFS_XATTR
 	bool "CIFS extended attributes"
-	depends on CIFS
+	depends on SMBFS
 	help
 	  Extended attributes are name:value pairs associated with inodes by
 	  the kernel or by users (see the attr(5) manual page for details).
-	  CIFS maps the name of extended attributes beginning with the user
+	  SMBFS maps the name of extended attributes beginning with the user
 	  namespace prefix to SMB/CIFS EAs.  EAs are stored on Windows
 	  servers without the user namespace prefix, but their names are
-	  seen by Linux cifs clients prefaced by the user namespace prefix.
+	  seen by Linux SMBFS clients prefaced by the user namespace prefix.
 	  The system namespace (used by some filesystems to store ACLs) is
 	  not supported at this time.
 
 	  If unsure, say Y.
 
-config CIFS_POSIX
-	bool "CIFS POSIX Extensions"
-	depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY && CIFS_XATTR
+config SMBFS_POSIX
+	bool "SMBFS POSIX Extensions"
+	depends on SMBFS && SMBFS_ALLOW_INSECURE_LEGACY && SMBFS_XATTR
 	help
-	  Enabling this option will cause the cifs client to attempt to
+	  Enabling this option will cause SMBFS to attempt to
 	  negotiate a newer dialect with servers, such as Samba 3.0.5
 	  or later, that optionally can handle more POSIX like (rather
 	  than Windows like) file behavior.  It also enables
 	  support for POSIX ACLs (getfacl and setfacl) to servers
 	  (such as Samba 3.10 and later) which can negotiate
-	  CIFS POSIX ACL support.  If unsure, say N.
+	  SMBFS POSIX ACL support.  If unsure, say N.
 
-config CIFS_DEBUG
-	bool "Enable CIFS debugging routines"
+config SMBFS_DEBUG
+	bool "Enable SMBFS debugging routines"
 	default y
-	depends on CIFS
+	depends on SMBFS
 	help
 	  Enabling this option adds helpful debugging messages to
-	  the cifs code which increases the size of the cifs module.
+	  the SMBFS code which increases the size of the module.
 	  If unsure, say Y.
 
-config CIFS_DEBUG2
-	bool "Enable additional CIFS debugging routines"
-	depends on CIFS_DEBUG
+config SMBFS_DEBUG2
+	bool "Enable additional SMBFS debugging routines"
+	depends on SMBFS_DEBUG
 	help
 	  Enabling this option adds a few more debugging routines
-	  to the cifs code which slightly increases the size of
-	  the cifs module and can cause additional logging of debug
+	  to the SMBFS code which slightly increases the size of
+	  the module and can cause additional logging of debug
 	  messages in some error paths, slowing performance. This
 	  option can be turned off unless you are debugging
-	  cifs problems.  If unsure, say N.
+	  SMBFS problems.  If unsure, say N.
 
-config CIFS_DEBUG_DUMP_KEYS
+config SMBFS_DEBUG_DUMP_KEYS
 	bool "Dump encryption keys for offline decryption (Unsafe)"
-	depends on CIFS_DEBUG
+	depends on SMBFS_DEBUG
 	help
 	  Enabling this will dump the encryption and decryption keys
 	  used to communicate on an encrypted share connection on the
@@ -148,55 +148,55 @@ config CIFS_DEBUG_DUMP_KEYS
 	  encrypted network captures. Enable this carefully.
 	  If unsure, say N.
 
-config CIFS_DFS_UPCALL
+config SMBFS_DFS_UPCALL
 	bool "DFS feature support"
-	depends on CIFS
+	depends on SMBFS
 	help
 	  Distributed File System (DFS) support is used to access shares
 	  transparently in an enterprise name space, even if the share
 	  moves to a different server.  This feature also enables
-	  an upcall mechanism for CIFS which contacts userspace helper
+	  an upcall mechanism for SMBFS which contacts userspace helper
 	  utilities to provide server name resolution (host names to
 	  IP addresses) which is needed in order to reconnect to
 	  servers if their addresses change or for implicit mounts of
 	  DFS junction points. If unsure, say Y.
 
-config CIFS_SWN_UPCALL
+config SMBFS_SWN_UPCALL
 	bool "SWN feature support"
-	depends on CIFS
+	depends on SMBFS
 	help
 	  The Service Witness Protocol (SWN) is used to get notifications
 	  from a highly available server of resource state changes. This
-	  feature enables an upcall mechanism for CIFS which contacts a
+	  feature enables an upcall mechanism for SMBFS which contacts a
 	  userspace daemon to establish the DCE/RPC connection to retrieve
 	  the cluster available interfaces and resource change notifications.
 	  If unsure, say Y.
 
-config CIFS_NFSD_EXPORT
-	bool "Allow nfsd to export CIFS file system"
-	depends on CIFS && BROKEN
+config SMBFS_NFSD_EXPORT
+	bool "Allow nfsd to export SMBFS file system"
+	depends on SMBFS && BROKEN
 	help
-	  Allows NFS server to export a CIFS mounted share (nfsd over cifs)
+	  Allows NFS server to export a SMBFS mounted share (nfsd over SMBFS)
 
-config CIFS_SMB_DIRECT
+config SMBFS_SMB_DIRECT
 	bool "SMB Direct support"
-	depends on CIFS=m && INFINIBAND && INFINIBAND_ADDR_TRANS || CIFS=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
+	depends on SMBFS=m && INFINIBAND && INFINIBAND_ADDR_TRANS || SMBFS=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
 	help
 	  Enables SMB Direct support for SMB 3.0, 3.02 and 3.1.1.
 	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
 	  say Y.
 
-config CIFS_FSCACHE
-	bool "Provide CIFS client caching support"
-	depends on CIFS=m && FSCACHE || CIFS=y && FSCACHE=y
+config SMBFS_FSCACHE
+	bool "Provide SMBFS client caching support"
+	depends on SMBFS=m && FSCACHE || SMBFS=y && FSCACHE=y
 	help
-	  Makes CIFS FS-Cache capable. Say Y here if you want your CIFS data
+	  Makes SMBFS FS-Cache capable. Say Y here if you want your SMBFS data
 	  to be cached locally on disk through the general filesystem cache
 	  manager. If unsure, say N.
 
-config CIFS_ROOT
+config SMBFS_ROOT
 	bool "SMB root file system (Experimental)"
-	depends on CIFS=y && IP_PNP
+	depends on SMBFS=y && IP_PNP
 	help
 	  Enables root file system support over SMB protocol.
 
diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index 8c9f2c00be72..07096b742b1d 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Makefile for Linux CIFS/SMB2/SMB3 VFS client
+# Makefile for Linux SMBFS VFS client
 #
-ccflags-y += -I$(src)		# needed for trace events
-obj-$(CONFIG_CIFS) += cifs.o
+ccflags-y += -I$(src) # needed for trace events
+obj-$(CONFIG_SMBFS) += smbfs.o
 
-cifs-y := trace.o cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o \
+smbfs-y := trace.o core.o cifssmb.o cifs_debug.o connect.o dir.o file.o \
 	  inode.o link.o misc.o netmisc.o smbencrypt.o transport.o \
 	  cifs_unicode.o nterr.o cifsencrypt.o \
 	  readdir.o ioctl.o sess.o export.o unc.o winucase.o \
@@ -17,18 +17,18 @@ $(obj)/asn1.o: $(obj)/cifs_spnego_negtokeninit.asn1.h
 
 $(obj)/cifs_spnego_negtokeninit.asn1.o: $(obj)/cifs_spnego_negtokeninit.asn1.c $(obj)/cifs_spnego_negtokeninit.asn1.h
 
-cifs-$(CONFIG_CIFS_XATTR) += xattr.o
+smbfs-$(CONFIG_SMBFS_XATTR) += xattr.o
 
-cifs-$(CONFIG_CIFS_UPCALL) += cifs_spnego.o
+smbfs-$(CONFIG_SMBFS_UPCALL) += cifs_spnego.o
 
-cifs-$(CONFIG_CIFS_DFS_UPCALL) += cifs_dfs_ref.o dfs_cache.o
+smbfs-$(CONFIG_SMBFS_DFS_UPCALL) += cifs_dfs_ref.o dfs_cache.o
 
-cifs-$(CONFIG_CIFS_SWN_UPCALL) += netlink.o cifs_swn.o
+smbfs-$(CONFIG_SMBFS_SWN_UPCALL) += netlink.o cifs_swn.o
 
-cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o
+smbfs-$(CONFIG_SMBFS_FSCACHE) += fscache.o
 
-cifs-$(CONFIG_CIFS_SMB_DIRECT) += smbdirect.o
+smbfs-$(CONFIG_SMBFS_SMB_DIRECT) += smbdirect.o
 
-cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
+smbfs-$(CONFIG_SMBFS_ROOT) += cifsroot.o
 
-cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += smb1ops.o
+smbfs-$(CONFIG_SMBFS_ALLOW_INSECURE_LEGACY) += smb1ops.o
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 11fd85de7217..ae588a8caa90 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -15,12 +15,12 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "fs_context.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 #include "smbdirect.h"
 #endif
 #include "cifs_swn.h"
@@ -35,7 +35,7 @@ cifs_dump_mem(char *label, void *data, int length)
 
 void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 {
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	struct smb_hdr *smb = buf;
 
 	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d\n",
@@ -43,12 +43,12 @@ void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
 		 smb->Flags, smb->Flags2, smb->Mid, smb->Pid);
 	cifs_dbg(VFS, "smb buf %p len %u\n", smb,
 		 server->ops->calc_smb_size(smb, server));
-#endif /* CONFIG_CIFS_DEBUG2 */
+#endif /* CONFIG_SMBFS_DEBUG2 */
 }
 
 void cifs_dump_mids(struct TCP_Server_Info *server)
 {
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	struct mid_q_entry *mid_entry;
 
 	if (server == NULL)
@@ -63,7 +63,7 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 			 mid_entry->pid,
 			 mid_entry->callback_data,
 			 mid_entry->mid);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 		cifs_dbg(VFS, "IsLarge: %d buf: %p time rcv: %ld now: %ld\n",
 			 mid_entry->large_buf,
 			 mid_entry->resp_buf,
@@ -79,7 +79,7 @@ void cifs_dump_mids(struct TCP_Server_Info *server)
 		}
 	}
 	spin_unlock(&server->mid_lock);
-#endif /* CONFIG_CIFS_DEBUG2 */
+#endif /* CONFIG_SMBFS_DEBUG2 */
 }
 
 #ifdef CONFIG_PROC_FS
@@ -176,7 +176,7 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
 	seq_puts(m, "# Version:1\n");
 	seq_puts(m, "# Format:\n");
 	seq_puts(m, "# <tree id> <persistent fid> <flags> <count> <pid> <uid>");
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	seq_printf(m, " <filename> <mid>\n");
 #else
 	seq_printf(m, " <filename>\n");
@@ -196,7 +196,7 @@ static int cifs_debug_files_proc_show(struct seq_file *m, void *v)
 						cfile->pid,
 						from_kuid(&init_user_ns, cfile->uid),
 						cfile->dentry);
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 					seq_printf(m, " %llu\n", cfile->fid.mid);
 #else
 					seq_printf(m, "\n");
@@ -225,39 +225,39 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 		    "---------------------------------------------------\n");
 	seq_printf(m, "CIFS Version %s\n", CIFS_VERSION);
 	seq_printf(m, "Features:");
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	seq_printf(m, " DFS");
 #endif
-#ifdef CONFIG_CIFS_FSCACHE
+#ifdef CONFIG_SMBFS_FSCACHE
 	seq_printf(m, ",FSCACHE");
 #endif
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	seq_printf(m, ",SMB_DIRECT");
 #endif
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	seq_printf(m, ",STATS2");
 #else
 	seq_printf(m, ",STATS");
 #endif
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	seq_printf(m, ",DEBUG2");
-#elif defined(CONFIG_CIFS_DEBUG)
+#elif defined(CONFIG_SMBFS_DEBUG)
 	seq_printf(m, ",DEBUG");
 #endif
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 	seq_printf(m, ",ALLOW_INSECURE_LEGACY");
 #endif
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 	seq_printf(m, ",CIFS_POSIX");
 #endif
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 	seq_printf(m, ",UPCALL(SPNEGO)");
 #endif
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	seq_printf(m, ",XATTR");
 #endif
 	seq_printf(m, ",ACL");
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 	seq_puts(m, ",WITNESS");
 #endif
 	seq_putc(m, '\n');
@@ -279,7 +279,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 
 		if (server->hostname)
 			seq_printf(m, "Hostname: %s ", server->hostname);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 		if (!server->rdma)
 			goto skip_rdma;
 
@@ -498,12 +498,12 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 
 	rc = kstrtobool_from_user(buffer, count, &bv);
 	if (rc == 0) {
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 		int i;
 
 		atomic_set(&total_buf_alloc_count, 0);
 		atomic_set(&total_small_buf_alloc_count, 0);
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 		atomic_set(&tcpSesReconnectCount, 0);
 		atomic_set(&tconInfoReconnectCount, 0);
 
@@ -514,7 +514,7 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
 			server->max_in_flight = 0;
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 			for (i = 0; i < NUMBER_OF_SMB2_COMMANDS; i++) {
 				atomic_set(&server->num_cmds[i], 0);
 				atomic_set(&server->smb2slowcmd[i], 0);
@@ -522,7 +522,7 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 				server->slowest_cmd[i] = 0;
 				server->fastest_cmd[0] = 0;
 			}
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 			list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
 				list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 					atomic_set(&tcon->num_smbs_sent, 0);
@@ -546,7 +546,7 @@ static ssize_t cifs_stats_proc_write(struct file *file,
 static int cifs_stats_proc_show(struct seq_file *m, void *v)
 {
 	int i;
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	int j;
 #endif /* STATS2 */
 	struct TCP_Server_Info *server;
@@ -562,11 +562,11 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
 			cifs_min_rcv + tcpSesAllocCount.counter);
 	seq_printf(m, "SMB Small Req/Resp Buffer: %d Pool size: %d\n",
 			small_buf_alloc_count.counter, cifs_min_small);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	seq_printf(m, "Total Large %d Small %d Allocations\n",
 				atomic_read(&total_buf_alloc_count),
 				atomic_read(&total_small_buf_alloc_count));
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 
 	seq_printf(m, "Operations (MIDs): %d\n", atomic_read(&mid_count));
 	seq_printf(m,
@@ -581,7 +581,7 @@ static int cifs_stats_proc_show(struct seq_file *m, void *v)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
 		seq_printf(m, "\nMax requests in flight: %d", server->max_in_flight);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 		seq_puts(m, "\nTotal time spent processing by command. Time ");
 		seq_printf(m, "units are jiffies (%d per second)\n", HZ);
 		seq_puts(m, "  SMB3 CMD\tNumber\tTotal Time\tFastest\tSlowest\n");
@@ -630,7 +630,7 @@ static const struct proc_ops cifs_stats_proc_ops = {
 	.proc_write	= cifs_stats_proc_write,
 };
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 #define PROC_FILE_DEFINE(name) \
 static ssize_t name##_write(struct file *file, const char __user *buffer, \
 	size_t count, loff_t *ppos) \
@@ -702,11 +702,11 @@ cifs_proc_init(void)
 
 	proc_create("mount_params", 0444, proc_fs_cifs, &cifs_mount_params_proc_ops);
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	proc_create("dfscache", 0644, proc_fs_cifs, &dfscache_proc_ops);
 #endif
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	proc_create("rdma_readwrite_threshold", 0644, proc_fs_cifs,
 		&cifs_rdma_readwrite_threshold_proc_fops);
 	proc_create("smbd_max_frmr_depth", 0644, proc_fs_cifs,
@@ -742,10 +742,10 @@ cifs_proc_clean(void)
 	remove_proc_entry("LookupCacheEnabled", proc_fs_cifs);
 	remove_proc_entry("mount_params", proc_fs_cifs);
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	remove_proc_entry("dfscache", proc_fs_cifs);
 #endif
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	remove_proc_entry("rdma_readwrite_threshold", proc_fs_cifs);
 	remove_proc_entry("smbd_max_frmr_depth", proc_fs_cifs);
 	remove_proc_entry("smbd_keep_alive_interval", proc_fs_cifs);
@@ -972,7 +972,7 @@ static ssize_t cifs_security_flags_proc_write(struct file *file,
 
 	cifs_security_flags_handle_must_flags(&flags);
 
-	/* flags look ok - update the global security flags for cifs module */
+	/* flags look ok - update global security flags */
 	global_secflags = flags;
 	if (global_secflags & CIFSSEC_MUST_SIGN) {
 		/* requiring signing implies signing is allowed */
diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
index ee4ea2b60c0f..fd6d563b0e81 100644
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -26,7 +26,7 @@ void dump_smb(void *, int);
 #define VFS 1
 #define FYI 2
 extern int cifsFYI;
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 #define NOISY 4
 #else
 #define NOISY 0
@@ -37,7 +37,7 @@ extern int cifsFYI;
  *	debug ON
  *	--------
  */
-#ifdef CONFIG_CIFS_DEBUG
+#ifdef CONFIG_SMBFS_DEBUG
 
 
 /*
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index b0864da9ef43..c58e67bf62f0 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -18,7 +18,7 @@
 #include <linux/inet.h>
 #include "cifsglob.h"
 #include "cifsproto.h"
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "dns_resolve.h"
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 342717bf1dc2..fd49a1490daf 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -161,13 +161,13 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
 	revert_creds(saved_cred);
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {
 		struct cifs_spnego_msg *msg = spnego_key->payload.data[0];
 		cifs_dump_mem("SPNEGO reply blob:", msg->data, min(1024U,
 				msg->secblob_len + msg->sesskey_len));
 	}
-#endif /* CONFIG_CIFS_DEBUG2 */
+#endif /* CONFIG_SMBFS_DEBUG2 */
 
 out:
 	kfree(description);
diff --git a/fs/cifs/cifs_swn.h b/fs/cifs/cifs_swn.h
index 8a9d2a5c9077..1b9da6281131 100644
--- a/fs/cifs/cifs_swn.h
+++ b/fs/cifs/cifs_swn.h
@@ -13,7 +13,7 @@ struct cifs_tcon;
 struct sk_buff;
 struct genl_info;
 
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 extern int cifs_swn_register(struct cifs_tcon *tcon);
 
 extern int cifs_swn_unregister(struct cifs_tcon *tcon);
@@ -48,5 +48,5 @@ static inline void cifs_swn_check(void) {}
 static inline bool cifs_swn_set_server_dstaddr(struct TCP_Server_Info *server) { return false; }
 static inline void cifs_swn_reset_server_dstaddr(struct TCP_Server_Info *server) {}
 
-#endif /* CONFIG_CIFS_SWN_UPCALL */
+#endif /* CONFIG_SMBFS_SWN_UPCALL */
 #endif /* _CIFS_SWN_H */
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index bf861fef2f0c..67e06386cfff 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -717,7 +717,7 @@ static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
 }
 
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
 {
 	int num_subauth;
@@ -803,7 +803,7 @@ static void parse_dacl(struct cifs_acl *pdacl, char *end_of_acl,
 
 		for (i = 0; i < num_aces; ++i) {
 			ppace[i] = (struct cifs_ace *) (acl_base + acl_size);
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 			dump_ace(ppace[i], end_of_acl);
 #endif
 			if (mode_from_special_sid &&
@@ -1162,7 +1162,7 @@ static int parse_sid(struct cifs_sid *psid, char *end_of_acl)
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	if (psid->num_subauth) {
 		int i;
 		cifs_dbg(FYI, "SID revision %d num_auth %d\n",
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 3070407cafa7..58db1157d53c 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -691,7 +691,7 @@ struct TCP_Server_Info {
 	unsigned int total_read; /* total amount of data read in this pass */
 	atomic_t in_send; /* requests trying to send */
 	atomic_t num_waiters;   /* blocked waiting to get in sendrecv */
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	atomic_t num_cmds[NUMBER_OF_SMB2_COMMANDS]; /* total requests by cmd */
 	atomic_t smb2slowcmd[NUMBER_OF_SMB2_COMMANDS]; /* count resps > 1 sec */
 	__u64 time_per_cmd[NUMBER_OF_SMB2_COMMANDS]; /* total time per cmd */
@@ -728,11 +728,11 @@ struct TCP_Server_Info {
 #define CIFS_SERVER_IS_CHAN(server)	(!!(server)->primary_server)
 	struct TCP_Server_Info *primary_server;
 
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 	bool use_swn_dstaddr;
 	struct sockaddr_storage swn_dstaddr;
 #endif
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	bool is_dfs_conn; /* if a dfs connection */
 	struct mutex refpath_lock; /* protects leaf_fullpath */
 	/*
@@ -1252,14 +1252,14 @@ struct cifs_tcon {
 	__u32 max_chunks;
 	__u32 max_bytes_chunk;
 	__u32 max_bytes_copy;
-#ifdef CONFIG_CIFS_FSCACHE
+#ifdef CONFIG_SMBFS_FSCACHE
 	u64 resource_id;		/* server resource id */
 	struct fscache_volume *fscache;	/* cookie for share */
 #endif
 	struct list_head pending_opens;	/* list of incomplete opens */
 	struct cached_fid crfid; /* Cached root fid */
 	/* BB add field for back pointer to sb struct(s)? */
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	struct list_head ulist; /* cache update list */
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
@@ -1384,7 +1384,7 @@ struct cifs_fid {
 	__u32 access;
 	struct cifs_pending_open *pending_open;
 	unsigned int epoch;
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	__u64 mid;
 #endif /* CIFS_DEBUG2 */
 	bool purge_cache;
@@ -1481,7 +1481,7 @@ struct cifs_readdata {
 				struct iov_iter *iter);
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	struct smbd_mr			*mr;
 #endif
 	unsigned int			pagesz;
@@ -1506,7 +1506,7 @@ struct cifs_writedata {
 	unsigned int			bytes;
 	int				result;
 	struct TCP_Server_Info		*server;
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	struct smbd_mr			*mr;
 #endif
 	unsigned int			pagesz;
@@ -1689,7 +1689,7 @@ struct mid_q_entry {
 	__u32 pid;		/* process id */
 	__u32 sequence_number;  /* for CIFS signing */
 	unsigned long when_alloc;  /* when mid was created */
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	unsigned long when_sent; /* time when smb send finished */
 	unsigned long when_received; /* when demux complete (taken off wire) */
 #endif
@@ -1740,7 +1740,7 @@ static inline void cifs_num_waiters_dec(struct TCP_Server_Info *server)
 	atomic_dec(&server->num_waiters);
 }
 
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 static inline void cifs_save_when_sent(struct mid_q_entry *mid)
 {
 	mid->when_sent = jiffies;
@@ -1878,7 +1878,7 @@ result of setting MUST flags more than once will be to
 require use of the stronger protocol */
 #define   CIFSSEC_MUST_NTLMV2	0x04004
 #define   CIFSSEC_MUST_KRB5	0x08008
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 #define   CIFSSEC_MASK          0x8F08F /* flags supported if no weak allowed */
 #else
 #define	  CIFSSEC_MASK          0x87087 /* flags supported if no weak allowed */
@@ -2023,7 +2023,7 @@ extern atomic_t tconInfoReconnectCount;
 /* Various Debug counters */
 extern atomic_t buf_alloc_count;	/* current number allocated  */
 extern atomic_t small_buf_alloc_count;
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 extern atomic_t total_buf_alloc_count; /* total allocated over all time */
 extern atomic_t total_small_buf_alloc_count;
 extern unsigned int slow_rsp_threshold; /* number of secs before logging */
@@ -2063,7 +2063,7 @@ extern mempool_t *cifs_mid_poolp;
 /* Operations for different SMB versions */
 #define SMB1_VERSION_STRING	"1.0"
 #define SMB20_VERSION_STRING    "2.0"
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
 extern struct smb_version_operations smb20_operations;
diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
index aeba371c4c70..0c24fcbb6622 100644
--- a/fs/cifs/cifspdu.h
+++ b/fs/cifs/cifspdu.h
@@ -2152,7 +2152,7 @@ typedef struct {
 #define CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP  0x00000200 /* must do  */
 #define CIFS_UNIX_PROXY_CAP             0x00000400 /* Proxy cap: 0xACE ioctl and
 						      QFS PROXY call */
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 /* presumably don't need the 0x20 POSIX_PATH_OPS_CAP since we never send
    LockingX instead of posix locking call on unix sess (and we do not expect
    LockingX to use different (ie Windows) semantics than posix locking on
@@ -2162,7 +2162,7 @@ typedef struct {
 #define CIFS_UNIX_CAP_MASK              0x000003db
 #else
 #define CIFS_UNIX_CAP_MASK              0x00000013
-#endif /* CONFIG_CIFS_POSIX */
+#endif /* CONFIG_SMBFS_POSIX */
 
 
 #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for new QFSInfo */
@@ -2607,7 +2607,7 @@ struct data_blob {
 } __attribute__((packed));
 
 
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 /*
 	For better POSIX semantics from Linux client, (even better
 	than the existing CIFS Unix Extensions) we need updated PDUs for:
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index d59aebefa71c..fd225e5d2456 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -9,7 +9,7 @@
 #define _CIFSPROTO_H
 #include <linux/nls.h>
 #include "trace.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
 
@@ -284,11 +284,11 @@ extern void cifs_put_tcp_session(struct TCP_Server_Info *server,
 				 int from_reconnect);
 extern void cifs_put_tcon(struct cifs_tcon *tcon);
 
-#if IS_ENABLED(CONFIG_CIFS_DFS_UPCALL)
+#if IS_ENABLED(CONFIG_SMBFS_DFS_UPCALL)
 extern void cifs_dfs_release_automount_timer(void);
-#else /* ! IS_ENABLED(CONFIG_CIFS_DFS_UPCALL) */
+#else /* ! IS_ENABLED(CONFIG_SMBFS_DFS_UPCALL) */
 #define cifs_dfs_release_automount_timer()	do { } while (0)
-#endif /* ! IS_ENABLED(CONFIG_CIFS_DFS_UPCALL) */
+#endif /* ! IS_ENABLED(CONFIG_SMBFS_DFS_UPCALL) */
 
 void cifs_proc_init(void);
 void cifs_proc_clean(void);
@@ -656,7 +656,7 @@ int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix);
 char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
 			       const char *old_path,
 			       const struct nls_table *nls_codepage,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 04a4c304d004..3177fc3a2321 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -32,11 +32,11 @@
 #include "smb2proto.h"
 #include "fscache.h"
 #include "smbdirect.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
 
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 static struct {
 	int index;
 	char *name;
@@ -56,7 +56,7 @@ static struct {
 #endif
 
 /* define the number of elements in the cifs dialect array */
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 #define CIFS_NUM_PROT 2
 #else /* not posix */
 #define CIFS_NUM_PROT 1
@@ -1528,7 +1528,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	}
 
 	/* how much data is in the response? */
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	use_rdma_mr = rdata->mr;
 #endif
 	data_len = server->ops->read_data_length(buf, use_rdma_mr);
@@ -1914,7 +1914,7 @@ cifs_writedata_release(struct kref *refcount)
 {
 	struct cifs_writedata *wdata = container_of(refcount,
 					struct cifs_writedata, refcount);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	if (wdata->mr) {
 		smbd_deregister_mr(wdata->mr);
 		wdata->mr = NULL;
@@ -3360,7 +3360,7 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 }
 
 
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 
 /*Convert an Access Control Entry from wire format to local POSIX xattr format*/
 static void cifs_convert_ace(struct posix_acl_xattr_entry *ace,
@@ -6054,7 +6054,7 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 /*
  * Do a path-based QUERY_ALL_EAS call and parse the result. This is a common
  * function used by listxattr and getxattr type calls. When ea_name is set,
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1362210f3ece..90d0254e2735 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -45,7 +45,7 @@
 #include "smb2proto.h"
 #include "smbdirect.h"
 #include "dns_resolve.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
 #include "fs_context.h"
@@ -68,7 +68,7 @@ struct mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	struct cifs_ses *root_ses;
 	uuid_t mount_id;
 	char *origin_fullpath, *leaf_fullpath;
@@ -429,7 +429,7 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 static int __reconnect_target_unlocked(struct TCP_Server_Info *server, const char *target)
 {
 	int rc;
@@ -841,7 +841,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 void
 dequeue_mid(struct mid_q_entry *mid, bool malformed)
 {
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	mid->when_received = jiffies;
 #endif
 	spin_lock(&mid->server->mid_lock);
@@ -983,7 +983,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	kfree(server->origin_fullpath);
 	kfree(server->leaf_fullpath);
 #endif
@@ -1238,7 +1238,7 @@ cifs_demultiplex_thread(void *p)
 				cifs_dump_mem("Received Data is: ", bufs[i],
 					      HEADER_SIZE(server));
 				smb2_add_credits_from_hdr(bufs[i], server);
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 				if (server->ops->dump_detail)
 					server->ops->dump_detail(bufs[i],
 								 server);
@@ -1467,7 +1467,7 @@ cifs_find_tcp_session(struct smb3_fs_context *ctx)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
 		spin_lock(&server->srv_lock);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 		/*
 		 * DFS failover implementation in cifs_reconnect() requires unique tcp sessions for
 		 * DFS connections to do failover properly, so avoid sharing them with regular
@@ -1621,7 +1621,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	INIT_DELAYED_WORK(&tcp_ses->resolve, cifs_resolve_server);
 	INIT_DELAYED_WORK(&tcp_ses->reconnect, smb2_reconnect_server);
 	mutex_init(&tcp_ses->reconnect_mutex);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	mutex_init(&tcp_ses->refpath_lock);
 #endif
 	memcpy(&tcp_ses->srcaddr, &ctx->srcaddr,
@@ -1647,8 +1647,8 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	else
 		tcp_ses->echo_interval = SMB_ECHO_INTERVAL_DEFAULT * HZ;
 	if (tcp_ses->rdma) {
-#ifndef CONFIG_CIFS_SMB_DIRECT
-		cifs_dbg(VFS, "CONFIG_CIFS_SMB_DIRECT is not enabled\n");
+#ifndef CONFIG_SMBFS_SMB_DIRECT
+		cifs_dbg(VFS, "CONFIG_SMBFS_SMB_DIRECT is not enabled\n");
 		rc = -ENOENT;
 		goto out_err_crypto_release;
 #endif
@@ -2496,7 +2496,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	}
 
 	tcon->use_witness = false;
-	if (IS_ENABLED(CONFIG_CIFS_SWN_UPCALL) && ctx->witness) {
+	if (IS_ENABLED(CONFIG_SMBFS_SWN_UPCALL) && ctx->witness) {
 		if (ses->server->vals->protocol_id >= SMB30_PROT_ID) {
 			if (tcon->capabilities & SMB2_SHARE_CAP_CLUSTER) {
 				/*
@@ -3052,7 +3052,7 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 		}
 
 		cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 		if (cap & CIFS_UNIX_FCNTL_CAP)
 			cifs_dbg(FYI, "FCNTL cap\n");
 		if (cap & CIFS_UNIX_EXTATTR_CAP)
@@ -3285,7 +3285,7 @@ static int mount_setup_tlink(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
 	return 0;
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 /* Get unique dfs connections */
 static int mount_get_dfs_conns(struct mount_ctx *mnt_ctx)
 {
@@ -3486,7 +3486,7 @@ static int is_path_remote(struct mount_ctx *mnt_ctx)
 	struct cifs_tcon *tcon = mnt_ctx->tcon;
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	char *full_path;
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	bool nodfs = cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
 #endif
 
@@ -3505,7 +3505,7 @@ static int is_path_remote(struct mount_ctx *mnt_ctx)
 
 	rc = server->ops->is_path_accessible(xid, tcon, cifs_sb,
 					     full_path);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	if (nodfs) {
 		if (rc == -EREMOTE)
 			rc = -EOPNOTSUPP;
@@ -3536,7 +3536,7 @@ static int is_path_remote(struct mount_ctx *mnt_ctx)
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 static void set_root_ses(struct mount_ctx *mnt_ctx)
 {
 	if (mnt_ctx->ses) {
@@ -3996,7 +3996,7 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
 	spin_unlock(&cifs_sb->tlink_tree_lock);
 
 	kfree(cifs_sb->prepath);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	dfs_cache_put_refsrv_sessions(&cifs_sb->dfs_mount_id);
 #endif
 	call_rcu(&cifs_sb->rcu, delayed_free);
@@ -4383,7 +4383,7 @@ cifs_prune_tlinks(struct work_struct *work)
 				TLINK_IDLE_EXPIRE);
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 /* Update dfs referral path of superblock */
 static int update_server_fullpath(struct TCP_Server_Info *server, struct cifs_sb_info *cifs_sb,
 				  const char *target)
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/core.c
similarity index 98%
rename from fs/cifs/cifsfs.c
rename to fs/cifs/core.c
index af4c5632490e..8b135c1cd5ae 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/core.c
@@ -4,7 +4,7 @@
  *   Copyright (C) International Business Machines  Corp., 2002,2008
  *   Author(s): Steve French (sfrench@us.ibm.com)
  *
- *   Common Internet FileSystem (CIFS) client
+ *   SMBFS client
  *
  */
 
@@ -28,7 +28,7 @@
 #include <linux/xattr.h>
 #include <uapi/linux/magic.h>
 #include <net/ipv6.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #define DECLARE_GLOBALS_HERE
 #include "cifsglob.h"
@@ -39,10 +39,10 @@
 #include <linux/key-type.h>
 #include "cifs_spnego.h"
 #include "fscache.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 #include "netlink.h"
 #endif
 #include "fs_context.h"
@@ -90,7 +90,7 @@ atomic_t tconInfoReconnectCount;
 atomic_t mid_count;
 atomic_t buf_alloc_count;
 atomic_t small_buf_alloc_count;
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 atomic_t total_buf_alloc_count;
 atomic_t total_small_buf_alloc_count;
 #endif/* STATS2 */
@@ -115,7 +115,7 @@ module_param(cifs_max_pending, uint, 0444);
 MODULE_PARM_DESC(cifs_max_pending, "Simultaneous requests to server for "
 				   "CIFS/SMB1 dialect (N/A for SMB3) "
 				   "Default: 32767 Range: 2 to 32767.");
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 unsigned int slow_rsp_threshold = 1;
 module_param(slow_rsp_threshold, uint, 0644);
 MODULE_PARM_DESC(slow_rsp_threshold, "Amount of time (in seconds) to wait "
@@ -266,12 +266,12 @@ cifs_read_super(struct super_block *sb)
 		goto out_no_root;
 	}
 
-#ifdef CONFIG_CIFS_NFSD_EXPORT
+#ifdef CONFIG_SMBFS_NFSD_EXPORT
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
 		cifs_dbg(FYI, "export ops supported\n");
 		sb->s_export_op = &cifs_export_ops;
 	}
-#endif /* CONFIG_CIFS_NFSD_EXPORT */
+#endif /* CONFIG_SMBFS_NFSD_EXPORT */
 
 	return 0;
 
@@ -759,7 +759,7 @@ static void cifs_umount_begin(struct super_block *sb)
 	return;
 }
 
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 {
 	/* BB FIXME */
@@ -797,7 +797,7 @@ static const struct super_operations cifs_super_ops = {
 	as opens */
 	.show_options = cifs_show_options,
 	.umount_begin   = cifs_umount_begin,
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	.show_stats = cifs_show_stats,
 #endif
 };
@@ -1116,6 +1116,7 @@ struct file_system_type cifs_fs_type = {
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("cifs");
+MODULE_ALIAS("cifs");
 
 struct file_system_type smb3_fs_type = {
 	.owner = THIS_MODULE,
@@ -1612,7 +1613,7 @@ init_cifs(void)
 
 	atomic_set(&buf_alloc_count, 0);
 	atomic_set(&small_buf_alloc_count, 0);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	atomic_set(&total_buf_alloc_count, 0);
 	atomic_set(&total_small_buf_alloc_count, 0);
 	if (slow_rsp_threshold < 1)
@@ -1620,7 +1621,7 @@ init_cifs(void)
 	else if (slow_rsp_threshold > 32767)
 		cifs_dbg(VFS,
 		       "slow response threshold set higher than recommended (0 to 32767)\n");
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 
 	atomic_set(&mid_count, 0);
 	GlobalCurrentXid = 0;
@@ -1693,21 +1694,21 @@ init_cifs(void)
 	if (rc)
 		goto out_destroy_mids;
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	rc = dfs_cache_init();
 	if (rc)
 		goto out_destroy_request_bufs;
-#endif /* CONFIG_CIFS_DFS_UPCALL */
-#ifdef CONFIG_CIFS_UPCALL
+#endif /* CONFIG_SMBFS_DFS_UPCALL */
+#ifdef CONFIG_SMBFS_UPCALL
 	rc = init_cifs_spnego();
 	if (rc)
 		goto out_destroy_dfs_cache;
-#endif /* CONFIG_CIFS_UPCALL */
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#endif /* CONFIG_SMBFS_UPCALL */
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 	rc = cifs_genl_init();
 	if (rc)
 		goto out_register_key_type;
-#endif /* CONFIG_CIFS_SWN_UPCALL */
+#endif /* CONFIG_SMBFS_SWN_UPCALL */
 
 	rc = init_cifs_idmap();
 	if (rc)
@@ -1728,15 +1729,15 @@ init_cifs(void)
 out_init_cifs_idmap:
 	exit_cifs_idmap();
 out_cifs_swn_init:
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 	cifs_genl_exit();
 out_register_key_type:
 #endif
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 	exit_cifs_spnego();
 out_destroy_dfs_cache:
 #endif
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	dfs_cache_destroy();
 out_destroy_request_bufs:
 #endif
@@ -1768,13 +1769,13 @@ exit_cifs(void)
 	unregister_filesystem(&smb3_fs_type);
 	cifs_dfs_release_automount_timer();
 	exit_cifs_idmap();
-#ifdef CONFIG_CIFS_SWN_UPCALL
+#ifdef CONFIG_SMBFS_SWN_UPCALL
 	cifs_genl_exit();
 #endif
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 	exit_cifs_spnego();
 #endif
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	dfs_cache_destroy();
 #endif
 	cifs_destroy_request_bufs();
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index a9b6c3eba6de..f0d2d2c49f9e 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -334,7 +334,7 @@ const struct proc_ops dfscache_proc_ops = {
 	.proc_write	= dfscache_proc_write,
 };
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 static inline void dump_tgts(const struct cache_entry *ce)
 {
 	struct cache_dfs_tgt *t;
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index ce9b22aecfba..5b3728631552 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -13,7 +13,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/file.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/fs/cifs/export.c b/fs/cifs/export.c
index 37c28415df1e..0395ef73b06d 100644
--- a/fs/cifs/export.c
+++ b/fs/cifs/export.c
@@ -4,8 +4,6 @@
  *   Copyright (C) International Business Machines  Corp., 2007
  *   Author(s): Steve French (sfrench@us.ibm.com)
  *
- *   Common Internet FileSystem (CIFS) client
- *
  *   Operations related to support for exporting files via NFSD
  *
  */
@@ -30,9 +28,9 @@
 #include <linux/exportfs.h>
 #include "cifsglob.h"
 #include "cifs_debug.h"
-#include "cifsfs.h"
+#include "smbfs.h"
 
-#ifdef CONFIG_CIFS_NFSD_EXPORT
+#ifdef CONFIG_SMBFS_NFSD_EXPORT
 static struct dentry *cifs_get_parent(struct dentry *dentry)
 {
 	/* BB need to add code here eventually to enable export via NFSD */
@@ -50,5 +48,5 @@ const struct export_operations cifs_export_ops = {
 	.encode_fs =  */
 };
 
-#endif /* CONFIG_CIFS_NFSD_EXPORT */
+#endif /* CONFIG_SMBFS_NFSD_EXPORT */
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index a592fdf04313..90567ae51fa7 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -22,7 +22,7 @@
 #include <linux/swap.h>
 #include <linux/mm.h>
 #include <asm/div64.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -2942,7 +2942,7 @@ cifs_resend_wdata(struct cifs_writedata *wdata, struct list_head *wdata_list,
 			if (wdata->cfile->invalidHandle)
 				rc = -EAGAIN;
 			else {
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 				if (wdata->mr) {
 					wdata->mr->need_invalidate = true;
 					smbd_deregister_mr(wdata->mr);
@@ -3455,7 +3455,7 @@ cifs_readdata_release(struct kref *refcount)
 {
 	struct cifs_readdata *rdata = container_of(refcount,
 					struct cifs_readdata, refcount);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	if (rdata->mr) {
 		smbd_deregister_mr(rdata->mr);
 		rdata->mr = NULL;
@@ -3599,7 +3599,7 @@ uncached_fill_pages(struct TCP_Server_Info *server,
 		if (iter)
 			result = copy_page_from_iter(
 					page, page_offset, n, iter);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 		else if (rdata->mr)
 			result = n;
 #endif
@@ -3676,7 +3676,7 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 			if (rdata->cfile->invalidHandle)
 				rc = -EAGAIN;
 			else {
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 				if (rdata->mr) {
 					rdata->mr->need_invalidate = true;
 					smbd_deregister_mr(rdata->mr);
@@ -4212,7 +4212,7 @@ cifs_page_mkwrite(struct vm_fault *vmf)
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
-#ifdef CONFIG_CIFS_FSCACHE
+#ifdef CONFIG_SMBFS_FSCACHE
 	if (PageFsCache(page) &&
 	    wait_on_page_fscache_killable(page) < 0)
 		return VM_FAULT_RETRY;
@@ -4367,7 +4367,7 @@ readpages_fill_pages(struct TCP_Server_Info *server,
 		if (iter)
 			result = copy_page_from_iter(
 					page, page_offset, n, iter);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 		else if (rdata->mr)
 			result = n;
 #endif
@@ -4960,7 +4960,7 @@ static void cifs_swap_deactivate(struct file *file)
  * Mark a page as having been made dirty and thus needing writeback.  We also
  * need to pin the cache object to write back to.
  */
-#ifdef CONFIG_CIFS_FSCACHE
+#ifdef CONFIG_SMBFS_FSCACHE
 static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
 	return fscache_dirty_folio(mapping, folio,
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 8dc0d923ef6a..a8366986bf73 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -13,7 +13,7 @@
 #include <linux/magic.h>
 #include <linux/security.h>
 #include <net/net_namespace.h>
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
 */
@@ -25,7 +25,7 @@
 #include <linux/mount.h>
 #include <linux/parser.h>
 #include <linux/utsname.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -339,7 +339,7 @@ cifs_parse_smb_version(struct fs_context *fc, char *value, struct smb3_fs_contex
 	substring_t args[MAX_OPT_ARGS];
 
 	switch (match_token(value, cifs_smb_version_tokens, args)) {
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 	case Smb_1:
 		if (disable_legacy_dialects) {
 			cifs_errorf(fc, "mount with legacy dialect disabled\n");
@@ -825,7 +825,7 @@ static int smb3_reconfigure(struct fs_context *fc)
 	smb3_cleanup_fs_context_contents(cifs_sb->ctx);
 	rc = smb3_fs_context_dup(cifs_sb->ctx, ctx);
 	smb3_update_mnt_flags(cifs_sb);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	if (!rc)
 		rc = dfs_cache_remount_fs(cifs_sb);
 #endif
@@ -1291,16 +1291,16 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			goto cifs_parse_mount_err;
 		break;
 	case Opt_witness:
-#ifndef CONFIG_CIFS_SWN_UPCALL
-		cifs_errorf(fc, "Witness support needs CONFIG_CIFS_SWN_UPCALL config option\n");
+#ifndef CONFIG_SMBFS_SWN_UPCALL
+		cifs_errorf(fc, "Witness support needs CONFIG_SMBFS_SWN_UPCALL config option\n");
 			goto cifs_parse_mount_err;
 #endif
 		ctx->witness = true;
 		pr_warn_once("Witness protocol support is experimental\n");
 		break;
 	case Opt_rootfs:
-#ifndef CONFIG_CIFS_ROOT
-		cifs_dbg(VFS, "rootfs support requires CONFIG_CIFS_ROOT config option\n");
+#ifndef CONFIG_SMBFS_ROOT
+		cifs_dbg(VFS, "rootfs support requires CONFIG_SMBFS_ROOT config option\n");
 		goto cifs_parse_mount_err;
 #endif
 		ctx->rootfs = true;
@@ -1399,8 +1399,8 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		pr_warn("Mount option noac not supported. Instead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
 		break;
 	case Opt_fsc:
-#ifndef CONFIG_CIFS_FSCACHE
-		cifs_errorf(fc, "FS-Cache support needs CONFIG_CIFS_FSCACHE kernel config option set\n");
+#ifndef CONFIG_SMBFS_FSCACHE
+		cifs_errorf(fc, "FS-Cache support needs CONFIG_SMBFS_FSCACHE kernel config option set\n");
 		goto cifs_parse_mount_err;
 #endif
 		ctx->fsc = true;
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index aa3b941a5555..ac2e5eb01af5 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -33,7 +33,7 @@ struct cifs_fscache_inode_coherency_data {
 	__le32 last_change_time_nsec;
 };
 
-#ifdef CONFIG_CIFS_FSCACHE
+#ifdef CONFIG_SMBFS_FSCACHE
 
 /*
  * fscache.c
@@ -119,7 +119,7 @@ static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
 	return true;
 }
 
-#else /* CONFIG_CIFS_FSCACHE */
+#else /* CONFIG_SMBFS_FSCACHE */
 static inline
 void cifs_fscache_fill_coherency(struct inode *inode,
 				 struct cifs_fscache_inode_coherency_data *cd)
@@ -159,6 +159,6 @@ static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 	return true; /* May release page */
 }
 
-#endif /* CONFIG_CIFS_FSCACHE */
+#endif /* CONFIG_SMBFS_FSCACHE */
 
 #endif /* _CIFS_FSCACHE_H */
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 3ad303dd5e5a..9da2c5644960 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -14,7 +14,7 @@
 #include <linux/wait_bit.h>
 #include <linux/fiemap.h>
 #include <asm/div64.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -57,7 +57,7 @@ static void cifs_set_ops(struct inode *inode)
 			inode->i_data.a_ops = &cifs_addr_ops;
 		break;
 	case S_IFDIR:
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 		if (IS_AUTOMOUNT(inode)) {
 			inode->i_op = &cifs_dfs_referral_inode_operations;
 		} else {
@@ -552,7 +552,7 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *path,
 static int cifs_sfu_mode(struct cifs_fattr *fattr, const unsigned char *path,
 			 struct cifs_sb_info *cifs_sb, unsigned int xid)
 {
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	ssize_t rc;
 	char ea_value[4];
 	__u32 mode;
@@ -956,7 +956,7 @@ cifs_get_inode_info(struct inode **inode,
 		rc = server->ops->query_path_info(xid, tcon, cifs_sb,
 						 full_path, tmp_data,
 						 &adjust_tz, &is_reparse_point);
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 		if (rc == -ENOENT && is_tcon_dfs(tcon))
 			rc = cifs_dfs_query_info_nonascii_quirk(xid, tcon,
 								cifs_sb,
@@ -1833,7 +1833,7 @@ cifs_posix_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode,
 
 	d_instantiate(dentry, newinode);
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	cifs_dbg(FYI, "instantiated dentry %p %pd to inode %p\n",
 		 dentry, dentry, newinode);
 
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index 0359b604bdbc..01f70c5352fd 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -17,7 +17,7 @@
 #include "cifsglob.h"
 #include "cifsproto.h"
 #include "cifs_debug.h"
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifs_ioctl.h"
 #include "smb2proto.h"
 #include "smb2glob.h"
@@ -332,7 +332,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 				break;
 			tcon = tlink_tcon(pSMBFile->tlink);
 			caps = le64_to_cpu(tcon->fsUnixInfo.Capability);
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 			if (CIFS_UNIX_EXTATTR_CAP & caps) {
 				__u64	ExtAttrMask = 0;
 				rc = CIFSGetExtAttr(xid, tcon,
@@ -345,7 +345,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 				if (rc != EOPNOTSUPP)
 					break;
 			}
-#endif /* CONFIG_CIFS_POSIX */
+#endif /* CONFIG_SMBFS_POSIX */
 			rc = 0;
 			if (CIFS_I(inode)->cifsAttrs & ATTR_COMPRESSED) {
 				/* add in the compressed bit */
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index bbdf3281559c..640a8724ac8e 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -9,7 +9,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 7a906067db04..5b03978e658c 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -18,8 +18,8 @@
 #include "nterr.h"
 #include "cifs_unicode.h"
 #include "smb2pdu.h"
-#include "cifsfs.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#include "smbfs.h"
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dns_resolve.h"
 #endif
 #include "fs_context.h"
@@ -175,9 +175,9 @@ cifs_buf_get(void)
 	/* for most paths, more is cleared in header_assemble */
 	memset(ret_buf, 0, buf_size + 3);
 	atomic_inc(&buf_alloc_count);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	atomic_inc(&total_buf_alloc_count);
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 
 	return ret_buf;
 }
@@ -208,9 +208,9 @@ cifs_small_buf_get(void)
 	/* No need to clear memory here, cleared in header assemble */
 	/*	memset(ret_buf, 0, sizeof(struct smb_hdr) + 27);*/
 	atomic_inc(&small_buf_alloc_count);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	atomic_inc(&total_small_buf_alloc_count);
-#endif /* CONFIG_CIFS_STATS2 */
+#endif /* CONFIG_SMBFS_STATS2 */
 
 	return ret_buf;
 }
@@ -1246,7 +1246,7 @@ void cifs_put_tcp_super(struct super_block *sb)
 	__cifs_put_super(sb);
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 int match_target_ip(struct TCP_Server_Info *server,
 		    const char *share, size_t share_len,
 		    bool *result)
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index 28caae7aed1b..8d461b29c0e2 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -16,7 +16,7 @@
 #include <asm/div64.h>
 #include <asm/byteorder.h>
 #include <linux/inet.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/fs/cifs/ntlmssp.h b/fs/cifs/ntlmssp.h
index 55758b9ec877..d22bf9591c3c 100644
--- a/fs/cifs/ntlmssp.h
+++ b/fs/cifs/ntlmssp.h
@@ -93,7 +93,7 @@ typedef struct _NEGOTIATE_MESSAGE {
 struct ntlmssp_version {
 	__u8	ProductMajorVersion;
 	__u8	ProductMinorVersion;
-	__le16	ProductBuild; /* we send the cifs.ko module version here */
+	__le16	ProductBuild; /* we send the module version here */
 	__u8	Reserved[3];
 	__u8	NTLMRevisionCurrent; /* currently 0x0F */
 } __packed;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 384cabdf47ca..acfe26e3ec0e 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -18,7 +18,7 @@
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "smb2proto.h"
 #include "fs_context.h"
 
@@ -29,7 +29,7 @@
  */
 #define UNICODE_NAME_MAX ((4 * NAME_MAX) + 2)
 
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 static void dump_cifs_file_struct(struct file *file, char *label)
 {
 	struct cifsFileInfo *cf;
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 02c8b2906196..a6288850c7cc 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -18,7 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifs_spnego.h"
 #include "smb2proto.h"
 #include "fs_context.h"
@@ -1376,7 +1376,7 @@ sess_auth_ntlmv2(struct sess_data *sess_data)
 	ses->auth_key.response = NULL;
 }
 
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 static void
 sess_auth_kerberos(struct sess_data *sess_data)
 {
@@ -1515,7 +1515,7 @@ sess_auth_kerberos(struct sess_data *sess_data)
 	ses->auth_key.response = NULL;
 }
 
-#endif /* ! CONFIG_CIFS_UPCALL */
+#endif /* ! CONFIG_SMBFS_UPCALL */
 
 /*
  * The required kvec buffers have to be allocated before calling this
@@ -1792,13 +1792,13 @@ static int select_sec(struct sess_data *sess_data)
 		sess_data->func = sess_auth_ntlmv2;
 		break;
 	case Kerberos:
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 		sess_data->func = sess_auth_kerberos;
 		break;
 #else
 		cifs_dbg(VFS, "Kerberos negotiated but upcall support disabled!\n");
 		return -ENOSYS;
-#endif /* CONFIG_CIFS_UPCALL */
+#endif /* CONFIG_SMBFS_UPCALL */
 	case RawNTLMSSP:
 		sess_data->func = sess_auth_rawntlmssp_negotiate;
 		break;
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index f36b2d2d40ca..f60b6696a1c1 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -926,7 +926,7 @@ cifs_unix_dfs_readlink(const unsigned int xid, struct cifs_tcon *tcon,
 		       const unsigned char *searchName, char **symlinkinfo,
 		       const struct nls_table *nls_codepage)
 {
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	int rc;
 	struct dfs_info3_param referral = {0};
 
@@ -1226,7 +1226,7 @@ struct smb_version_operations smb1_operations = {
 	.wp_retry_size = cifs_wp_retry_size,
 	.dir_needs_close = cifs_dir_needs_close,
 	.select_sectype = cifs_select_sectype,
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	.query_all_EAs = CIFSSMBQAllEAs,
 	.set_EA = CIFSSMBSetEA,
 #endif /* CIFS_XATTR */
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index f5dcc4940b6d..82887064569a 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <asm/div64.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 8571a459c710..66b2d03ea231 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <asm/div64.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 82dd2e973753..012b8b8a96ba 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -14,7 +14,7 @@
 #include <crypto/aead.h>
 #include <linux/fiemap.h>
 #include <uapi/linux/magic.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifsglob.h"
 #include "smb2pdu.h"
 #include "smb2proto.h"
@@ -379,7 +379,7 @@ smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
 static void
 smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 {
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 
 	cifs_server_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
@@ -437,7 +437,7 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	/* start with specified wsize, or default */
 	wsize = ctx->wsize ? ctx->wsize : SMB3_DEFAULT_IOSIZE;
 	wsize = min_t(unsigned int, wsize, server->max_write);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	if (server->rdma) {
 		if (server->sign)
 			/*
@@ -485,7 +485,7 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	/* start with specified rsize, or default */
 	rsize = ctx->rsize ? ctx->rsize : SMB3_DEFAULT_IOSIZE;
 	rsize = min_t(unsigned int, rsize, server->max_read);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	if (server->rdma) {
 		if (server->sign)
 			/*
@@ -930,7 +930,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
@@ -1132,7 +1132,7 @@ smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 static ssize_t
 move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 		     struct smb2_file_full_ea_info *src, size_t src_size,
@@ -1544,7 +1544,7 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 	cfile->fid.persistent_fid = fid->persistent_fid;
 	cfile->fid.volatile_fid = fid->volatile_fid;
 	cfile->fid.access = fid->access;
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	cfile->fid.mid = fid->mid;
 #endif /* CIFS_DEBUG2 */
 	server->ops->set_oplock_level(cinode, oplock, fid->epoch,
@@ -4352,7 +4352,7 @@ smb3_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 	}
 }
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 static bool
 smb2_is_read_op(__u32 oplock)
 {
@@ -4941,7 +4941,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	}
 
 	data_offset = server->ops->read_data_offset(buf);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	use_rdma_mr = rdata->mr;
 #endif
 	data_len = server->ops->read_data_length(buf, use_rdma_mr);
@@ -5073,7 +5073,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				      dw->ppages, dw->npages, dw->len,
 				      true);
 		if (rc >= 0) {
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 			mid->when_received = jiffies;
 #endif
 			if (dw->server->ops->is_network_name_deleted)
@@ -5460,7 +5460,7 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 struct smb_version_operations smb20_operations = {
 	.compare_fids = smb2_compare_fids,
 	.setup_request = smb2_setup_request,
@@ -5544,7 +5544,7 @@ struct smb_version_operations smb20_operations = {
 	.dir_needs_close = smb2_dir_needs_close,
 	.get_dfs_refer = smb2_get_dfs_refer,
 	.select_sectype = smb2_select_sectype,
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	.query_all_EAs = smb2_query_eas,
 	.set_EA = smb2_set_ea,
 #endif /* CIFS_XATTR */
@@ -5647,7 +5647,7 @@ struct smb_version_operations smb21_operations = {
 	.notify = smb3_notify,
 	.get_dfs_refer = smb2_get_dfs_refer,
 	.select_sectype = smb2_select_sectype,
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	.query_all_EAs = smb2_query_eas,
 	.set_EA = smb2_set_ea,
 #endif /* CIFS_XATTR */
@@ -5761,7 +5761,7 @@ struct smb_version_operations smb30_operations = {
 	.receive_transform = smb3_receive_transform,
 	.get_dfs_refer = smb2_get_dfs_refer,
 	.select_sectype = smb2_select_sectype,
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	.query_all_EAs = smb2_query_eas,
 	.set_EA = smb2_set_ea,
 #endif /* CIFS_XATTR */
@@ -5875,7 +5875,7 @@ struct smb_version_operations smb311_operations = {
 	.receive_transform = smb3_receive_transform,
 	.get_dfs_refer = smb2_get_dfs_refer,
 	.select_sectype = smb2_select_sectype,
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 	.query_all_EAs = smb2_query_eas,
 	.set_EA = smb2_set_ea,
 #endif /* CIFS_XATTR */
@@ -5891,7 +5891,7 @@ struct smb_version_operations smb311_operations = {
 	.is_network_name_deleted = smb2_is_network_name_deleted,
 };
 
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+#ifdef CONFIG_SMBFS_ALLOW_INSECURE_LEGACY
 struct smb_version_values smb20_values = {
 	.version_string = SMB20_VERSION_STRING,
 	.protocol_id = SMB20_PROT_ID,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 131bec79d6fd..86decb4642aa 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -36,7 +36,7 @@
 #include "cifs_spnego.h"
 #include "smbdirect.h"
 #include "trace.h"
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
 
@@ -1319,7 +1319,7 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 	else
 		req->SecurityMode = 0;
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 	req->Capabilities = cpu_to_le32(SMB2_GLOBAL_CAP_DFS);
 #else
 	req->Capabilities = 0;
@@ -1402,7 +1402,7 @@ SMB2_sess_establish_session(struct SMB2_sess_data *sess_data)
 	return rc;
 }
 
-#ifdef CONFIG_CIFS_UPCALL
+#ifdef CONFIG_SMBFS_UPCALL
 static void
 SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 {
@@ -1638,7 +1638,7 @@ SMB2_sess_auth_rawntlmssp_authenticate(struct SMB2_sess_data *sess_data)
 	}
 
 	rc = SMB2_sess_establish_session(sess_data);
-#ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
+#ifdef CONFIG_SMBFS_DEBUG_DUMP_KEYS
 	if (ses->server->dialect < SMB30_PROT_ID) {
 		cifs_dbg(VFS, "%s: dumping generated SMB2 session keys\n", __func__);
 		/*
@@ -3026,7 +3026,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	oparms->fid->persistent_fid = rsp->PersistentFileId;
 	oparms->fid->volatile_fid = rsp->VolatileFileId;
 	oparms->fid->access = oparms->desired_access;
-#ifdef CONFIG_CIFS_DEBUG2
+#ifdef CONFIG_SMBFS_DEBUG2
 	oparms->fid->mid = le64_to_cpu(rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
@@ -4057,7 +4057,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 			io_parms->persistent_fid,
 			io_parms->tcon->tid, io_parms->tcon->ses->Suid,
 			io_parms->offset, io_parms->length);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	/*
 	 * If we want to do a RDMA write, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of read request
@@ -4177,7 +4177,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	default:
 		rdata->result = -EIO;
 	}
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	/*
 	 * If this rdata has a memmory registered, the MR can be freed
 	 * MR needs to be freed as soon as I/O finishes to prevent deadlock
@@ -4411,7 +4411,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		wdata->result = -EIO;
 		break;
 	}
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	/*
 	 * If this wdata has a memory registered, the MR can be freed
 	 * The number of MRs available is limited, it's important to recover
@@ -4484,7 +4484,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 
 	trace_smb3_write_enter(0 /* xid */, wdata->cfile->fid.persistent_fid,
 		tcon->tid, tcon->ses->Suid, wdata->offset, wdata->bytes);
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	/*
 	 * If we want to do a server RDMA read, fill in and append
 	 * smbd_buffer_descriptor_v1 to the end of write request
@@ -4536,7 +4536,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	rqst.rq_npages = wdata->nr_pages;
 	rqst.rq_pagesz = wdata->pagesz;
 	rqst.rq_tailsz = wdata->tailsz;
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	if (wdata->mr) {
 		iov[0].iov_len += sizeof(struct smbd_buffer_descriptor_v1);
 		rqst.rq_npages = 0;
@@ -4545,7 +4545,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
 	cifs_dbg(FYI, "async write at %llu %u bytes\n",
 		 wdata->offset, wdata->bytes);
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 	/* For RDMA read, I/O size is in RemainingBytes not in Length */
 	if (!wdata->mr)
 		req->Length = cpu_to_le32(wdata->bytes);
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index f64922f340b3..00313a488e6f 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -454,7 +454,7 @@ generate_smb3signingkey(struct cifs_ses *ses,
 	if (rc)
 		return rc;
 
-#ifdef CONFIG_CIFS_DEBUG_DUMP_KEYS
+#ifdef CONFIG_SMBFS_DEBUG_DUMP_KEYS
 	cifs_dbg(VFS, "%s: dumping generated AES session keys\n", __func__);
 	/*
 	 * The session id is opaque in terms of endianness, so we can't
diff --git a/fs/cifs/smbdirect.h b/fs/cifs/smbdirect.h
index a87fca82a796..922344c8d5c1 100644
--- a/fs/cifs/smbdirect.h
+++ b/fs/cifs/smbdirect.h
@@ -7,7 +7,7 @@
 #ifndef _SMBDIRECT_H
 #define _SMBDIRECT_H
 
-#ifdef CONFIG_CIFS_SMB_DIRECT
+#ifdef CONFIG_SMBFS_SMB_DIRECT
 #define cifs_rdma_enabled(server)	((server)->rdma)
 
 #include "cifsglob.h"
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/smbfs.h
similarity index 97%
rename from fs/cifs/cifsfs.h
rename to fs/cifs/smbfs.h
index 81f4c15936d0..d067be5d3184 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/smbfs.h
@@ -115,7 +115,7 @@ extern int cifs_readdir(struct file *file, struct dir_context *ctx);
 extern const struct dentry_operations cifs_dentry_ops;
 extern const struct dentry_operations cifs_ci_dentry_ops;
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
+#ifdef CONFIG_SMBFS_DFS_UPCALL
 extern struct vfsmount *cifs_dfs_d_automount(struct path *path);
 #else
 #define cifs_dfs_d_automount NULL
@@ -127,12 +127,12 @@ extern const char *cifs_get_link(struct dentry *, struct inode *,
 extern int cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 			struct dentry *direntry, const char *symname);
 
-#ifdef CONFIG_CIFS_XATTR
+#ifdef CONFIG_SMBFS_XATTR
 extern const struct xattr_handler *cifs_xattr_handlers[];
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 #else
-# define cifs_xattr_handlers NULL
-# define cifs_listxattr NULL
+#define cifs_xattr_handlers NULL
+#define cifs_listxattr NULL
 #endif
 
 extern ssize_t cifs_file_copychunk_range(unsigned int xid,
@@ -148,9 +148,9 @@ struct smb3_fs_context;
 extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
 					 int flags, struct smb3_fs_context *ctx);
 
-#ifdef CONFIG_CIFS_NFSD_EXPORT
+#ifdef CONFIG_SMBFS_NFSD_EXPORT
 extern const struct export_operations cifs_export_ops;
-#endif /* CONFIG_CIFS_NFSD_EXPORT */
+#endif /* CONFIG_SMBFS_NFSD_EXPORT */
 
 /* when changing internal version - update following two lines at same time */
 #define SMB3_PRODUCT_BUILD 38
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 160463e22c95..cd689b47d0d9 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -77,7 +77,7 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
 			container_of(refcount, struct mid_q_entry, refcount);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	__le16 command = midEntry->server->vals->lock_cmd;
 	__u16 smb_cmd = le16_to_cpu(midEntry->command);
 	unsigned long now;
@@ -96,7 +96,7 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 		cifs_buf_release(midEntry->resp_buf);
 	else
 		cifs_small_buf_release(midEntry->resp_buf);
-#ifdef CONFIG_CIFS_STATS2
+#ifdef CONFIG_SMBFS_STATS2
 	now = jiffies;
 	if (now < midEntry->when_alloc)
 		cifs_server_dbg(VFS, "Invalid mid allocation time\n");
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 9d486fbbfbbd..bce40126e1a9 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -10,7 +10,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
-#include "cifsfs.h"
+#include "smbfs.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -202,7 +202,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 	}
 
 	case XATTR_ACL_ACCESS:
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 		if (!value)
 			goto out;
 		if (sb->s_flags & SB_POSIXACL)
@@ -210,11 +210,11 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 				value, (const int)size,
 				ACL_TYPE_ACCESS, cifs_sb->local_nls,
 				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
+#endif  /* CONFIG_SMBFS_POSIX */
 		break;
 
 	case XATTR_ACL_DEFAULT:
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 		if (!value)
 			goto out;
 		if (sb->s_flags & SB_POSIXACL)
@@ -222,7 +222,7 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 				value, (const int)size,
 				ACL_TYPE_DEFAULT, cifs_sb->local_nls,
 				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
+#endif  /* CONFIG_SMBFS_POSIX */
 		break;
 	}
 
@@ -366,23 +366,23 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
 	}
 
 	case XATTR_ACL_ACCESS:
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 		if (sb->s_flags & SB_POSIXACL)
 			rc = CIFSSMBGetPosixACL(xid, pTcon, full_path,
 				value, size, ACL_TYPE_ACCESS,
 				cifs_sb->local_nls,
 				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
+#endif  /* CONFIG_SMBFS_POSIX */
 		break;
 
 	case XATTR_ACL_DEFAULT:
-#ifdef CONFIG_CIFS_POSIX
+#ifdef CONFIG_SMBFS_POSIX
 		if (sb->s_flags & SB_POSIXACL)
 			rc = CIFSSMBGetPosixACL(xid, pTcon, full_path,
 				value, size, ACL_TYPE_DEFAULT,
 				cifs_sb->local_nls,
 				cifs_remap(cifs_sb));
-#endif  /* CONFIG_CIFS_POSIX */
+#endif  /* CONFIG_SMBFS_POSIX */
 		break;
 	}
 
-- 
2.35.3

