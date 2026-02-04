Return-Path: <linux-fsdevel+bounces-76288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDkECh0Jg2lLgwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:53:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8000E3588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D618A3006805
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CB739B488;
	Wed,  4 Feb 2026 08:53:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87B39A7FF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195226; cv=none; b=qCA0SKsFs/ZPUGQ7yfo3ldoGH+d5tRvhYBA/uK4msjO48NBESYVOAio32HFaAK1N8jEXmeTuNp7gR/C6sL5BevpJ6KY/hxemScAjQ3eK7hArTXbx9+nQSiJBS6mUtePuBJmutDDeg6nojcWJ6eCl+cQ4uCs9hIOG+HKBenQyr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195226; c=relaxed/simple;
	bh=lqBdqVyY+xGo8izIXMDgB6QdZ7EKU2iAj6ms4V+NNV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZQ+p4ftuMOdZhPpu1/IXZAfFn1+94nnOXSShuFOh+l2Wq6aeaKGEN6Kc+ih0w72c1wBOKs9i31Np4KVuouJQls3TMFj9HNW1ryJL6RaAfO+74ukTfqmd3S1IHxYu9zRsRhP2LrhhOS4HEVu/opmx3QSxGZYiowyiteNVVgo1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c636487ccaeso235071a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195225; x=1770800025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Ds4YrsNmj2UjNgUDZhvIWDcpDn0ZbvKk8Xs4GXJl0A=;
        b=uK5EssSlY5w6/cwxXj+J5fBuIuqgBZiI3bxz9VjPt9fJQDmRt+R523mkAsED+K7+Q2
         KfCwXQ8LdLiVSGlA9MUOex9NuzDVCGGgLejbvco0hQAva+/AbVJLXnw6lEjbQSjlp8Bk
         /XN8uGLZWlvkNrG1Zi5GgloSl+Ul+oZljIHLs3OSrCgtfO50eOG5MroJQlehf2IhC1DY
         GJuTJCMI0xEbpDTsMHHspnSW2wRQEPWtbEnuRjeVE/v95cIZPzoqbYcNzXzqMcWO+bNx
         geOUH+TsOmKYeh1mJS/TZU8K31d+6IJ+oZp8jP9ICpNjqzu1ivZKJehI50oG/5/JjoCj
         J37g==
X-Gm-Message-State: AOJu0YzqTNIz4FFBTpEpanjuK4o5vI+qckeIKkWtN66JOXs3WQjw6Csx
	dNkim+am66K7ZM0WAekiH5qPXiuJBuqOOzL0YKPg4y0BVViIihYJBr6BmsZ1Aw7J
X-Gm-Gg: AZuq6aLd1MMc/3RIsbYcsXs4cARTyfPTgT9kRZtRZOTIsvMN3lXwJTytbb+Ruo4U1n7
	d+Dy3jDuvKEWbyIdnfpWWqGsIshvoW/u9Ga1m5wJoUkqn27Xq/fzJgsf+7QLitKCKleQlJhAP6F
	wNjzFecFk+3adN7Hskp0ST2PdtC9e14cC5V+n8REOwLji+EkSN9H+PTh+FU+IExBDjRC1o7t2mQ
	5jMihDKIeJPFBidu0Xb5UzzktVGQRShLtQb3E6ytEAikVNDC5m1aM6SqlUa11fA0cAMn2VW99B9
	B/VTYkB5M1854WZ49835Y4apKuUUhPBBDSIu2FbjMDAPitalnocdBJ6GxjzXXJWQ/hEyuQCSsVS
	8pSHUP5HuP02YqZO8nYiGJH+WkPOkZOSTKT7fQ/MDZVXlcBn1/K9u/BN+kQX1OO6Crezjui6Tt8
	Ge62HD3EsMMByiHLR3MVeEwxH9bQ==
X-Received: by 2002:a17:903:15c3:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a933fdd6a9mr21556915ad.57.1770195224992;
        Wed, 04 Feb 2026 00:53:44 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851270sm16847735ad.2.2026.02.04.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:53:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH RESEND v7 16/17] Documentation: filesystems: update NTFS driver documentation
Date: Wed,  4 Feb 2026 17:29:30 +0900
Message-Id: <20260204082931.13915-17-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76288-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,freenode.net:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-ntfs.org:url]
X-Rspamd-Queue-Id: B8000E3588
X-Rspamd-Action: no action

Update the NTFS driver documentation to reflect the update implementation.
Remove outdated sections (web site, old features list, known bugs,
volume/stripe sets with MD/DM driver, limitations of old driver), add a
concise overview of current driver features and long-term maintenance
focus, add a utilities support section pointing to ntfsprogs-plus project
and update mount options list with current supported options.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 Documentation/filesystems/index.rst |   1 +
 Documentation/filesystems/ntfs.rst  | 563 +++++++---------------------
 2 files changed, 129 insertions(+), 435 deletions(-)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..0d1f88185b73 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -98,6 +98,7 @@ Documentation for filesystem implementations.
    isofs
    nilfs2
    nfs/index
+   ntfs
    ntfs3
    ocfs2
    ocfs2-online-filecheck
diff --git a/Documentation/filesystems/ntfs.rst b/Documentation/filesystems/ntfs.rst
index 5bb093a26485..e5a02f9af0f6 100644
--- a/Documentation/filesystems/ntfs.rst
+++ b/Documentation/filesystems/ntfs.rst
@@ -1,466 +1,159 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-================================
+=================================
 The Linux NTFS filesystem driver
-================================
+=================================
 
 
 .. Table of contents
 
    - Overview
-   - Web site
-   - Features
+   - Utilities support
    - Supported mount options
-   - Known bugs and (mis-)features
-   - Using NTFS volume and stripe sets
-     - The Device-Mapper driver
-     - The Software RAID / MD driver
-     - Limitations when using the MD driver
 
 
 Overview
 ========
 
-Linux-NTFS comes with a number of user-space programs known as ntfsprogs.
-These include mkntfs, a full-featured ntfs filesystem format utility,
-ntfsundelete used for recovering files that were unintentionally deleted
-from an NTFS volume and ntfsresize which is used to resize an NTFS partition.
-See the web site for more information.
-
-To mount an NTFS 1.2/3.x (Windows NT4/2000/XP/2003) volume, use the file
-system type 'ntfs'.  The driver currently supports read-only mode (with no
-fault-tolerance, encryption or journalling) and very limited, but safe, write
-support.
-
-For fault tolerance and raid support (i.e. volume and stripe sets), you can
-use the kernel's Software RAID / MD driver.  See section "Using Software RAID
-with NTFS" for details.
+NTFS is a Linux kernel filesystem driver that provides full read and write
+support for NTFS volumes. It is designed for high performance, modern
+kernel infrastructure (iomap, folio), and stable long-term maintenance.
 
 
-Web site
-========
-
-There is plenty of additional information on the linux-ntfs web site
-at http://www.linux-ntfs.org/
+Utilities support
+=================
 
-The web site has a lot of additional information, such as a comprehensive
-FAQ, documentation on the NTFS on-disk format, information on the Linux-NTFS
-userspace utilities, etc.
+The NTFS utilities project, called ntfsprogs-plus, provides mkfs.ntfs,
+fsck.ntfs, and other related tools (e.g., ntfsinfo, ntfsclone, etc.) for
+creating, checking, and managing NTFS volumes. These utilities can be used
+for filesystem testing with xfstests as well as for recovering corrupted
+NTFS devices.
 
+The project is available at:
 
-Features
-========
+  https://github.com/ntfsprogs-plus/ntfsprogs-plus
 
-- This is a complete rewrite of the NTFS driver that used to be in the 2.4 and
-  earlier kernels.  This new driver implements NTFS read support and is
-  functionally equivalent to the old ntfs driver and it also implements limited
-  write support.  The biggest limitation at present is that files/directories
-  cannot be created or deleted.  See below for the list of write features that
-  are so far supported.  Another limitation is that writing to compressed files
-  is not implemented at all.  Also, neither read nor write access to encrypted
-  files is so far implemented.
-- The new driver has full support for sparse files on NTFS 3.x volumes which
-  the old driver isn't happy with.
-- The new driver supports execution of binaries due to mmap() now being
-  supported.
-- The new driver supports loopback mounting of files on NTFS which is used by
-  some Linux distributions to enable the user to run Linux from an NTFS
-  partition by creating a large file while in Windows and then loopback
-  mounting the file while in Linux and creating a Linux filesystem on it that
-  is used to install Linux on it.
-- A comparison of the two drivers using::
-
-	time find . -type f -exec md5sum "{}" \;
-
-  run three times in sequence with each driver (after a reboot) on a 1.4GiB
-  NTFS partition, showed the new driver to be 20% faster in total time elapsed
-  (from 9:43 minutes on average down to 7:53).  The time spent in user space
-  was unchanged but the time spent in the kernel was decreased by a factor of
-  2.5 (from 85 CPU seconds down to 33).
-- The driver does not support short file names in general.  For backwards
-  compatibility, we implement access to files using their short file names if
-  they exist.  The driver will not create short file names however, and a
-  rename will discard any existing short file name.
-- The new driver supports exporting of mounted NTFS volumes via NFS.
-- The new driver supports async io (aio).
-- The new driver supports fsync(2), fdatasync(2), and msync(2).
-- The new driver supports readv(2) and writev(2).
-- The new driver supports access time updates (including mtime and ctime).
-- The new driver supports truncate(2) and open(2) with O_TRUNC.  But at present
-  only very limited support for highly fragmented files, i.e. ones which have
-  their data attribute split across multiple extents, is included.  Another
-  limitation is that at present truncate(2) will never create sparse files,
-  since to mark a file sparse we need to modify the directory entry for the
-  file and we do not implement directory modifications yet.
-- The new driver supports write(2) which can both overwrite existing data and
-  extend the file size so that you can write beyond the existing data.  Also,
-  writing into sparse regions is supported and the holes are filled in with
-  clusters.  But at present only limited support for highly fragmented files,
-  i.e. ones which have their data attribute split across multiple extents, is
-  included.  Another limitation is that write(2) will never create sparse
-  files, since to mark a file sparse we need to modify the directory entry for
-  the file and we do not implement directory modifications yet.
 
 Supported mount options
 =======================
 
-In addition to the generic mount options described by the manual page for the
-mount command (man 8 mount, also see man 5 fstab), the NTFS driver supports the
-following mount options:
-
-======================= =======================================================
-iocharset=name		Deprecated option.  Still supported but please use
-			nls=name in the future.  See description for nls=name.
+The NTFS driver supports the following mount options:
 
-nls=name		Character set to use when returning file names.
-			Unlike VFAT, NTFS suppresses names that contain
-			unconvertible characters.  Note that most character
-			sets contain insufficient characters to represent all
-			possible Unicode characters that can exist on NTFS.
-			To be sure you are not missing any files, you are
-			advised to use nls=utf8 which is capable of
-			representing all Unicode characters.
+======================= ===================================================
+iocharset=name          Character set to use for converting between
+                        the encoding is used for user visible filename and
+                        16 bit Unicode characters.
 
-utf8=<bool>		Option no longer supported.  Currently mapped to
-			nls=utf8 but please use nls=utf8 in the future and
-			make sure utf8 is compiled either as module or into
-			the kernel.  See description for nls=name.
+nls=name                Deprecated option.  Still supported but please use
+                        iocharset=name in the future.
 
 uid=
 gid=
-umask=			Provide default owner, group, and access mode mask.
-			These options work as documented in mount(8).  By
-			default, the files/directories are owned by root and
-			he/she has read and write permissions, as well as
-			browse permission for directories.  No one else has any
-			access permissions.  I.e. the mode on all files is by
-			default rw------- and for directories rwx------, a
-			consequence of the default fmask=0177 and dmask=0077.
-			Using a umask of zero will grant all permissions to
-			everyone, i.e. all files and directories will have mode
-			rwxrwxrwx.
+umask=                  Provide default owner, group, and access mode mask.
+                        These options work as documented in mount(8).  By
+                        default, the files/directories are owned by root
+                        and he/she has read and write permissions, as well
+                        as browse permission for directories.  No one else
+                        has any access permissions.  I.e. the mode on all
+                        files is by default rw------- and
+                        for directories rwx------, a consequence of
+                        the default fmask=0177 and dmask=0077.
+                        Using a umask of zero will grant all permissions to
+                        everyone, i.e. all files and directories will have
+                        mode rwxrwxrwx.
 
 fmask=
-dmask=			Instead of specifying umask which applies both to
-			files and directories, fmask applies only to files and
-			dmask only to directories.
-
-sloppy=<BOOL>		If sloppy is specified, ignore unknown mount options.
-			Otherwise the default behaviour is to abort mount if
-			any unknown options are found.
-
-show_sys_files=<BOOL>	If show_sys_files is specified, show the system files
-			in directory listings.  Otherwise the default behaviour
-			is to hide the system files.
-			Note that even when show_sys_files is specified, "$MFT"
-			will not be visible due to bugs/mis-features in glibc.
-			Further, note that irrespective of show_sys_files, all
-			files are accessible by name, i.e. you can always do
-			"ls -l \$UpCase" for example to specifically show the
-			system file containing the Unicode upcase table.
-
-case_sensitive=<BOOL>	If case_sensitive is specified, treat all file names as
-			case sensitive and create file names in the POSIX
-			namespace.  Otherwise the default behaviour is to treat
-			file names as case insensitive and to create file names
-			in the WIN32/LONG name space.  Note, the Linux NTFS
-			driver will never create short file names and will
-			remove them on rename/delete of the corresponding long
-			file name.
-			Note that files remain accessible via their short file
-			name, if it exists.  If case_sensitive, you will need
-			to provide the correct case of the short file name.
-
-disable_sparse=<BOOL>	If disable_sparse is specified, creation of sparse
-			regions, i.e. holes, inside files is disabled for the
-			volume (for the duration of this mount only).  By
-			default, creation of sparse regions is enabled, which
-			is consistent with the behaviour of traditional Unix
-			filesystems.
-
-errors=opt		What to do when critical filesystem errors are found.
-			Following values can be used for "opt":
-
-			  ========  =========================================
-			  continue  DEFAULT, try to clean-up as much as
-				    possible, e.g. marking a corrupt inode as
-				    bad so it is no longer accessed, and then
-				    continue.
-			  recover   At present only supported is recovery of
-				    the boot sector from the backup copy.
-				    If read-only mount, the recovery is done
-				    in memory only and not written to disk.
-			  ========  =========================================
-
-			Note that the options are additive, i.e. specifying::
-
-			   errors=continue,errors=recover
-
-			means the driver will attempt to recover and if that
-			fails it will clean-up as much as possible and
-			continue.
-
-mft_zone_multiplier=	Set the MFT zone multiplier for the volume (this
-			setting is not persistent across mounts and can be
-			changed from mount to mount but cannot be changed on
-			remount).  Values of 1 to 4 are allowed, 1 being the
-			default.  The MFT zone multiplier determines how much
-			space is reserved for the MFT on the volume.  If all
-			other space is used up, then the MFT zone will be
-			shrunk dynamically, so this has no impact on the
-			amount of free space.  However, it can have an impact
-			on performance by affecting fragmentation of the MFT.
-			In general use the default.  If you have a lot of small
-			files then use a higher value.  The values have the
-			following meaning:
-
-			      =====	    =================================
-			      Value	     MFT zone size (% of volume size)
-			      =====	    =================================
-				1		12.5%
-				2		25%
-				3		37.5%
-				4		50%
-			      =====	    =================================
-
-			Note this option is irrelevant for read-only mounts.
-======================= =======================================================
-
-
-Known bugs and (mis-)features
-=============================
-
-- The link count on each directory inode entry is set to 1, due to Linux not
-  supporting directory hard links.  This may well confuse some user space
-  applications, since the directory names will have the same inode numbers.
-  This also speeds up ntfs_read_inode() immensely.  And we haven't found any
-  problems with this approach so far.  If you find a problem with this, please
-  let us know.
-
-
-Please send bug reports/comments/feedback/abuse to the Linux-NTFS development
-list at sourceforge: linux-ntfs-dev@lists.sourceforge.net
-
-
-Using NTFS volume and stripe sets
-=================================
-
-For support of volume and stripe sets, you can either use the kernel's
-Device-Mapper driver or the kernel's Software RAID / MD driver.  The former is
-the recommended one to use for linear raid.  But the latter is required for
-raid level 5.  For striping and mirroring, either driver should work fine.
-
-
-The Device-Mapper driver
-------------------------
-
-You will need to create a table of the components of the volume/stripe set and
-how they fit together and load this into the kernel using the dmsetup utility
-(see man 8 dmsetup).
-
-Linear volume sets, i.e. linear raid, has been tested and works fine.  Even
-though untested, there is no reason why stripe sets, i.e. raid level 0, and
-mirrors, i.e. raid level 1 should not work, too.  Stripes with parity, i.e.
-raid level 5, unfortunately cannot work yet because the current version of the
-Device-Mapper driver does not support raid level 5.  You may be able to use the
-Software RAID / MD driver for raid level 5, see the next section for details.
-
-To create the table describing your volume you will need to know each of its
-components and their sizes in sectors, i.e. multiples of 512-byte blocks.
-
-For NT4 fault tolerant volumes you can obtain the sizes using fdisk.  So for
-example if one of your partitions is /dev/hda2 you would do::
-
-    $ fdisk -ul /dev/hda
-
-    Disk /dev/hda: 81.9 GB, 81964302336 bytes
-    255 heads, 63 sectors/track, 9964 cylinders, total 160086528 sectors
-    Units = sectors of 1 * 512 = 512 bytes
-
-	Device Boot      Start         End      Blocks   Id  System
-	/dev/hda1   *          63     4209029     2104483+  83  Linux
-	/dev/hda2         4209030    37768814    16779892+  86  NTFS
-	/dev/hda3        37768815    46170809     4200997+  83  Linux
-
-And you would know that /dev/hda2 has a size of 37768814 - 4209030 + 1 =
-33559785 sectors.
-
-For Win2k and later dynamic disks, you can for example use the ldminfo utility
-which is part of the Linux LDM tools (the latest version at the time of
-writing is linux-ldm-0.0.8.tar.bz2).  You can download it from:
-
-	http://www.linux-ntfs.org/
-
-Simply extract the downloaded archive (tar xvjf linux-ldm-0.0.8.tar.bz2), go
-into it (cd linux-ldm-0.0.8) and change to the test directory (cd test).  You
-will find the precompiled (i386) ldminfo utility there.  NOTE: You will not be
-able to compile this yourself easily so use the binary version!
-
-Then you would use ldminfo in dump mode to obtain the necessary information::
-
-    $ ./ldminfo --dump /dev/hda
-
-This would dump the LDM database found on /dev/hda which describes all of your
-dynamic disks and all the volumes on them.  At the bottom you will see the
-VOLUME DEFINITIONS section which is all you really need.  You may need to look
-further above to determine which of the disks in the volume definitions is
-which device in Linux.  Hint: Run ldminfo on each of your dynamic disks and
-look at the Disk Id close to the top of the output for each (the PRIVATE HEADER
-section).  You can then find these Disk Ids in the VBLK DATABASE section in the
-<Disk> components where you will get the LDM Name for the disk that is found in
-the VOLUME DEFINITIONS section.
-
-Note you will also need to enable the LDM driver in the Linux kernel.  If your
-distribution did not enable it, you will need to recompile the kernel with it
-enabled.  This will create the LDM partitions on each device at boot time.  You
-would then use those devices (for /dev/hda they would be /dev/hda1, 2, 3, etc)
-in the Device-Mapper table.
-
-You can also bypass using the LDM driver by using the main device (e.g.
-/dev/hda) and then using the offsets of the LDM partitions into this device as
-the "Start sector of device" when creating the table.  Once again ldminfo would
-give you the correct information to do this.
-
-Assuming you know all your devices and their sizes things are easy.
-
-For a linear raid the table would look like this (note all values are in
-512-byte sectors)::
-
-    # Offset into	Size of this	Raid type	Device		Start sector
-    # volume	device						of device
-    0		1028161		linear		/dev/hda1	0
-    1028161		3903762		linear		/dev/hdb2	0
-    4931923		2103211		linear		/dev/hdc1	0
-
-For a striped volume, i.e. raid level 0, you will need to know the chunk size
-you used when creating the volume.  Windows uses 64kiB as the default, so it
-will probably be this unless you changes the defaults when creating the array.
-
-For a raid level 0 the table would look like this (note all values are in
-512-byte sectors)::
-
-    # Offset   Size	    Raid     Number   Chunk  1st        Start	2nd	  Start
-    # into     of the   type     of	      size   Device	in	Device	  in
-    # volume   volume	     stripes			device		  device
-    0	   2056320  striped  2	      128    /dev/hda1	0	/dev/hdb1 0
-
-If there are more than two devices, just add each of them to the end of the
-line.
-
-Finally, for a mirrored volume, i.e. raid level 1, the table would look like
-this (note all values are in 512-byte sectors)::
-
-    # Ofs Size   Raid   Log  Number Region Should Number Source  Start Target Start
-    # in  of the type   type of log size   sync?  of     Device  in    Device in
-    # vol volume		 params		     mirrors	     Device	  Device
-    0    2056320 mirror core 2	16     nosync 2	   /dev/hda1 0   /dev/hdb1 0
-
-If you are mirroring to multiple devices you can specify further targets at the
-end of the line.
-
-Note the "Should sync?" parameter "nosync" means that the two mirrors are
-already in sync which will be the case on a clean shutdown of Windows.  If the
-mirrors are not clean, you can specify the "sync" option instead of "nosync"
-and the Device-Mapper driver will then copy the entirety of the "Source Device"
-to the "Target Device" or if you specified multiple target devices to all of
-them.
-
-Once you have your table, save it in a file somewhere (e.g. /etc/ntfsvolume1),
-and hand it over to dmsetup to work with, like so::
-
-    $ dmsetup create myvolume1 /etc/ntfsvolume1
-
-You can obviously replace "myvolume1" with whatever name you like.
-
-If it all worked, you will now have the device /dev/device-mapper/myvolume1
-which you can then just use as an argument to the mount command as usual to
-mount the ntfs volume.  For example::
-
-    $ mount -t ntfs -o ro /dev/device-mapper/myvolume1 /mnt/myvol1
-
-(You need to create the directory /mnt/myvol1 first and of course you can use
-anything you like instead of /mnt/myvol1 as long as it is an existing
-directory.)
-
-It is advisable to do the mount read-only to see if the volume has been setup
-correctly to avoid the possibility of causing damage to the data on the ntfs
-volume.
-
-
-The Software RAID / MD driver
------------------------------
-
-An alternative to using the Device-Mapper driver is to use the kernel's
-Software RAID / MD driver.  For which you need to set up your /etc/raidtab
-appropriately (see man 5 raidtab).
-
-Linear volume sets, i.e. linear raid, as well as stripe sets, i.e. raid level
-0, have been tested and work fine (though see section "Limitations when using
-the MD driver with NTFS volumes" especially if you want to use linear raid).
-Even though untested, there is no reason why mirrors, i.e. raid level 1, and
-stripes with parity, i.e. raid level 5, should not work, too.
-
-You have to use the "persistent-superblock 0" option for each raid-disk in the
-NTFS volume/stripe you are configuring in /etc/raidtab as the persistent
-superblock used by the MD driver would damage the NTFS volume.
-
-Windows by default uses a stripe chunk size of 64k, so you probably want the
-"chunk-size 64k" option for each raid-disk, too.
-
-For example, if you have a stripe set consisting of two partitions /dev/hda5
-and /dev/hdb1 your /etc/raidtab would look like this::
-
-    raiddev /dev/md0
-	    raid-level	0
-	    nr-raid-disks	2
-	    nr-spare-disks	0
-	    persistent-superblock	0
-	    chunk-size	64k
-	    device		/dev/hda5
-	    raid-disk	0
-	    device		/dev/hdb1
-	    raid-disk	1
-
-For linear raid, just change the raid-level above to "raid-level linear", for
-mirrors, change it to "raid-level 1", and for stripe sets with parity, change
-it to "raid-level 5".
-
-Note for stripe sets with parity you will also need to tell the MD driver
-which parity algorithm to use by specifying the option "parity-algorithm
-which", where you need to replace "which" with the name of the algorithm to
-use (see man 5 raidtab for available algorithms) and you will have to try the
-different available algorithms until you find one that works.  Make sure you
-are working read-only when playing with this as you may damage your data
-otherwise.  If you find which algorithm works please let us know (email the
-linux-ntfs developers list linux-ntfs-dev@lists.sourceforge.net or drop in on
-IRC in channel #ntfs on the irc.freenode.net network) so we can update this
-documentation.
-
-Once the raidtab is setup, run for example raid0run -a to start all devices or
-raid0run /dev/md0 to start a particular md device, in this case /dev/md0.
-
-Then just use the mount command as usual to mount the ntfs volume using for
-example::
-
-    mount -t ntfs -o ro /dev/md0 /mnt/myntfsvolume
-
-It is advisable to do the mount read-only to see if the md volume has been
-setup correctly to avoid the possibility of causing damage to the data on the
-ntfs volume.
-
-
-Limitations when using the Software RAID / MD driver
------------------------------------------------------
-
-Using the md driver will not work properly if any of your NTFS partitions have
-an odd number of sectors.  This is especially important for linear raid as all
-data after the first partition with an odd number of sectors will be offset by
-one or more sectors so if you mount such a partition with write support you
-will cause massive damage to the data on the volume which will only become
-apparent when you try to use the volume again under Windows.
-
-So when using linear raid, make sure that all your partitions have an even
-number of sectors BEFORE attempting to use it.  You have been warned!
-
-Even better is to simply use the Device-Mapper for linear raid and then you do
-not have this problem with odd numbers of sectors.
+dmask=                  Instead of specifying umask which applies both to
+                        files and directories, fmask applies only to files
+                        and dmask only to directories.
+
+showmeta=<BOOL>
+show_sys_files=<BOOL>   If show_sys_files is specified, show the system
+                        files in directory listings.  Otherwise the default
+                        behaviour is to hide the system files.
+                        Note that even when show_sys_files is specified,
+                        "$MFT" will not be visible due to bugs/mis-features
+                        in glibc. Further, note that irrespective of
+                        show_sys_files, all files are accessible by name,
+                        i.e. you can always do "ls -l \$UpCase" for example
+                        to specifically show the system file containing
+                        the Unicode upcase table.
+
+case_sensitive=<BOOL>   If case_sensitive is specified, treat all filenames
+                        as case sensitive and create file names in
+                        the POSIX namespace (default behavior). Note,
+                        the Linux NTFS driver will never create short
+                        filenames and will remove them on rename/delete of
+                        the corresponding long file name. Note that files
+                        remain accessible via their short file name, if it
+                        exists.
+
+nocase=<BOOL>           If nocase is specified, treat filenames
+                        case-insensitively.
+
+disable_sparse=<BOOL>   If disable_sparse is specified, creation of sparse
+                        regions, i.e. holes, inside files is disabled for
+                        the volume (for the duration of this mount only).
+                        By default, creation of sparse regions is enabled,
+                        which is consistent with the behaviour of
+                        traditional Unix filesystems.
+
+errors=opt              Specify NTFS behavior on critical errors: panic,
+                        remount the partition in read-only mode or
+                        continue without doing anything (default behavior).
+
+mft_zone_multiplier=    Set the MFT zone multiplier for the volume (this
+                        setting is not persistent across mounts and can be
+                        changed from mount to mount but cannot be changed
+                        on remount).  Values of 1 to 4 are allowed, 1 being
+                        the default.  The MFT zone multiplier determines
+                        how much space is reserved for the MFT on the
+                        volume.  If all other space is used up, then the
+                        MFT zone will be shrunk dynamically, so this has no
+                        impact on the amount of free space.  However, it
+                        can have an impact on performance by affecting
+                        fragmentation of the MFT. In general use the
+                        default.  If you have a lot of small files then use
+                        a higher value.  The values have the following
+                        meaning:
+
+                        =====   =================================
+                        Value   MFT zone size (% of volume size)
+                        =====   =================================
+                          1             12.5%
+                          2             25%
+                          3             37.5%
+                          4             50%
+                        =====   =================================
+
+                        Note this option is irrelevant for read-only mount.
+
+preallocated_size=      Set preallocated size to optimize runlist merge
+                        overhead with small chunck size.(64KB size by
+                        default)
+
+acl=<BOOL>              Enable POSIX ACL support. When specified, POSIX
+                        ACLs stored in extended attributes are enforced.
+                        Default is off. Requires kernel config
+                        NTFS_FS_POSIX_ACL enabled.
+
+sys_immutable=<BOOL>    Make NTFS system files (e.g. $MFT, $LogFile,
+                        $Bitmap, $UpCase, etc.) immutable to user initiated
+                        modifications for extra safety. Default is off.
+
+nohidden=<BOOL>         Hide files and directories marked with the Windows
+                        "hidden" attribute. By default hidden items are
+                        shown.
+
+hide_dot_files=<BOOL>   Hide names beginning with a dot ("."). By default
+                        dot files are shown. When enabled, files and
+                        directories created with a leading '.' will be
+                        hidden from directory listings.
+
+windows_names=<BOOL>    Refuse creation/rename of files with characters or
+                        reserved device names disallowed on Windows (e.g.
+                        CON, NUL, AUX, COM1, LPT1, etc.). Default is off.
+discard=<BOOL>          Issue block device discard for clusters freed on
+                        file deletion/truncation to inform underlying
+                        storage.
+======================= ==================================================
-- 
2.25.1


