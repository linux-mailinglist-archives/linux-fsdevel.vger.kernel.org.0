Return-Path: <linux-fsdevel+bounces-77090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMzfNHzejmlSFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:19:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2661133EC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1AAF303672B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00731D750;
	Fri, 13 Feb 2026 08:18:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB231AF33
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970696; cv=none; b=CfqfawqopH046QFFDUTRnIIyPxHxjR2Vuh8hrF/7O+wtZ2G1kzO+3OhrGGjgCsY73QxaOMFkjtlNvFr76Po/NaPc7M+hJPG9qlcCpzfaWeavH9I4RGwFpdLPwBsCFJEreR2AbXOCoefBPLJWQBmaJA9t9lSEuzNC7OgzYX/NpvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970696; c=relaxed/simple;
	bh=bGADW5lSfkHOzkBfPGZbRnsS6ScTBI7TNXq4K5sn8lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P1ED/54kDtd9vq52MtTSP3+NpHgvNtRiUi+9AgqmRreCU920JODZ730tSKYUoHD12ojhkN+X65tXEjsst9WouDD5OazMNSAD0TMd2q3AQio2dSKphBUtIBWXoxoZBuZjvglkn58Q3+etgLLC1waRgi3bMWYLUZt/QcChgQ698WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso4252595ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770970694; x=1771575494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YjArLz1+oJ/3X3rCvkrENZhVwiqMkIKUUmtUBr7QY4=;
        b=SVZlRWRP9hU3i9pUE1S+xoUS3sUsVhkZJgyQ80qGSImbjltDZRHk3YobPIzNTDaZJr
         G/dF3/qVB6L6TaNv0fLg0OVlw9sW0k5SB/C60AicXRIG9sGZbaj5x6qR9qu1mF5Zvbr0
         b0N/s8FX6ezrHjPx3Agp++iYMrKlXoO4mkEu6dn1BSutSw+FqdQwsbVok/jpqcGm01zg
         Z8lUUzTkyzS+TDmZfswnDF95M23lawoCkpGPR5Kf3G2HmktQX7UDREd2OfsPiBAH1oY8
         uLM1mTMJjesvcJhBW3zuOwOefWemRVXXRV9mXiT9/ovMDwhoOJrVoVnjk1+wvw6CV7LD
         L4Hw==
X-Gm-Message-State: AOJu0Yzwd4Ng+DWIlrrM2kHZb6yrxAGQsk4Ma40Db5IvPYGJAghv4Dad
	PjA9R57p6qOZkDjQRrmzVI3u8Lc5ZxEr56c/DUMqv+F9I1QRrc/e2+7p
X-Gm-Gg: AZuq6aK/1X9we/uslWkrFfPaGVhhTrtYV2rHj/07S4aYDWWjS9xBPWabITyd1SiGbr7
	6g8Nkb94+8ueS8qjWhfcXI/dzE76gLL6OBzFQ4jLY5SoA3HJCTi0p0hHe5/reGwC1Z7q63CDM5U
	pyB5J+SBqNPH74XWo7iOM2dHtZI0ylnRyoSogoEJOgYJOsZxbZg3VH6txMByefBCxv5HngBzmXE
	4HwBLVOl7zbyNPX2PY+GkmcxgRw6tySduPgw315qW9QeqY2XOANhkqvfbnq//yHJfG1+a+TSrCD
	ckYPG+0fV2KY3bwFvqN41UEm7NherpAIlloAIwsUZRF1GqZdm/d3QJMF2d5tiekF7DrWD8+BAKl
	Vkjq/VChQQF9cOB9q31cHZ2tZwXRFiH31dQKongyG/i6Ixp5NHy+mG8CmbMHjXd+olIUeDTVZea
	mhzFNcPj8ZBnBxH19rRie8yApm+JtClbErfxvPwA==
X-Received: by 2002:a17:902:cf4a:b0:2aa:df82:ed87 with SMTP id d9443c01a7336-2ab505d69aemr10129865ad.57.1770970693467;
        Fri, 13 Feb 2026 00:18:13 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm75236495ad.6.2026.02.13.00.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:18:12 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	amir73il@gmail.com,
	xiang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v9 00/17] ntfs filesystem remake
Date: Fri, 13 Feb 2026 17:17:47 +0900
Message-Id: <20260213081804.13351-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77090-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F2661133EC6
X-Rspamd-Action: no action

v9:
  - Rebased onto 7.0-rc1 to follow changes during the merge window:
    - kernel.h no longer includes hex.h.
    - Use posix_acl_to_xattr() that allocates the buffer internally.
    - Add generic_setlease to retain the ability to set leases.
    - Stop using __getname().
  - Fix failure to load attribute list on mount.
  - Fix stale attribute pointer in MFT extension (Reported by Mobin Aydinfar).

Introduction
============

The NTFS filesystem[1] still remains the default filesystem for Windows
and The well-maintained NTFS driver in the Linux kernel enhances
interoperability with Windows devices, making it easier for Linux users
to work with NTFS-formatted drives. Currently, ntfs support in Linux was
the long-neglected NTFS Classic (read-only), which has been removed from
the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
many problems and is poorly maintained, so users and distributions are
still using the old legacy ntfs-3g.

The remade ntfs is an implementation that supports write and the essential
requirements(iomap, no buffer-head, utilities, xfstests test result) based
on read-only classic NTFS.
The old read-only ntfs code is much cleaner, with extensive comments,
offers readability that makes understanding NTFS easier. This is why
new ntfs was developed on old read-only NTFS base.
The target is to provide current trends(iomap, no buffer head, folio),
enhanced performance, stable maintenance, utility support including fsck.


Key Features
============

- Write support:
   Implement write support on classic read-only NTFS. Additionally,
   integrate delayed allocation to enhance write performance through
   multi-cluster allocation and minimized fragmentation of cluster bitmap.

- Switch to using iomap:
   Use iomap for buffered IO writes, reads, direct IO, file extent mapping,
   readpages, writepages operations.

- Stop using the buffer head:
   The use of buffer head in old ntfs and switched to use folio instead.
   As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig also.

- Public utilities include fsck[2]:
   While ntfs-3g includes ntfsprogs as a component, it notably lacks
   the fsck implementation. So we have launched a new ntfs utilitiies
   project called ntfsprogs-plus by forking from ntfs-3g after removing
   unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
   testing with xfstests as well as for recovering corrupted NTFS device.

- Performance Enhancements:

   - ntfs vs. ntfs3:

     * Performance was benchmarked using iozone with various chunk size.
        - In single-thread(1T) write tests, ntfs show approximately
          3~5% better performance.
        - In multi-thread(4T) write tests, ntfs show approximately
          35~110% better performance.
        - Read throughput is identical for both ntfs implementations.

     1GB file      size:4096           size:16384           size:65536
     MB/sec       ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     read          399 | 399           426 | 424           429 | 430
     ─────────────────────────────────────────────────────────────────
     write(1T)     291 | 276           325 | 305           333 | 317
     write(4T)     105 | 50            113 | 78            114 | 99.6


     * File list browsing performance. (about 12~14% faster)

                  files:100000        files:200000        files:400000
     Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86


     * mount time.

             parti_size:1TB      parti_size:2TB      parti_size:4TB
     Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
     ─────────────────────────────────────────────────────────────────
     mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51

   The following are the reasons why ntfs performance is higher
    compared to ntfs3:
     - Use iomap aops.
     - Delayed allocation support.
     - Optimize zero out for newly allocated clusters.
     - Optimize runlist merge overhead with small chunck size.
     - pre-load mft(inode) blocks and index(dentry) blocks to improve
       readdir + stat performance.
     - Load lcn bitmap on background.

- Stability improvement:
   a. Pass more xfstests tests:
      ntfs passed 326 tests, significantly higher than ntfs3's 256.
      ntfs passed tests are a complete superset of the tests passed
      by ntfs3. ntfs implement fallocate, idmapped mount and permission,
      etc, resulting in a significantly high number of xfstests passing
      compared to ntfs3.
   b. Bonnie++ issue[3]:
      The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
      error during file deletion. ntfs3 currently iterates directory
      entries by reading index blocks one by one. When entries are deleted
      concurrently, index block merging or entry relocation can cause
      readdir() to skip some entries, leaving files undeleted in
      workloads(bonnie++) that mix unlink and directory scans.
      ntfs implement leaf chain traversal in readdir to avoid entry skip
      on deletion.

- Journaling support:
   ntfs3 does not provide full journaling support. It only implement journal
   replay[4], which in our testing did not function correctly. My next task
   after upstreaming will be to add full journal support to ntfs.


The feature comparison summary
==============================

Feature                               ntfs       ntfs3
===================================   ========   ===========
Write support                         Yes        Yes
iomap support                         Yes        No
No buffer head                        Yes        No
Public utilities(mkfs, fsck, etc.)    Yes        No
xfstests passed                       326        256
Idmapped mount                        Yes        No
Delayed allocation                    Yes        No
Bonnie++                              Pass       Fail
Journaling                            Planned    Inoperative
===================================   ========   ===========


References
==========
[1] https://en.wikipedia.org/wiki/NTFS
[2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
[3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4WwTy3Qe4Bqm6V0g@mail.gmail.com/
[4] https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox


Available in the Git repository at:
===================================
git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntfs-next


v8:
 - Acked-by from Christoph Hellwig for the whole series.
 - Remove unneeded check for unsigned lowest_vcn found by smatch.
 - Use LCN_HOLE instead of hardcoded -1 in runlist validation.

v7:
 - Fix mount options indentation in Documentation.
 - Add FMODE_CAN_ODIRECT in file open.
 - Use -EOPNOTSUPP for unsupported EFS-encrypted I/O and add the comments.
 - Remove lcn_seek_trunc field and O_TRUNC workaround codes.
 - Move preallocated size trim to helper in file release.
 - Use lowercase for reparse data structures.
 - Split complex reparse validation into readable checks.
 - Use early return in reparse tag validation.
 - Consolidate memalloc_nofs_restore to single exit point.
 - Remove useless headers from aops.c.
 - Fix comment in ntfs_readahead.
 - Rename mark_ntfs_record_dirty to ntfs_mft_mark_dirty.
 - Move ntfs_mft_mark_dirty to mft.c.
 - Remove empty aops.h.
 - Simplify __ntfs_iomap_read_begin.
 - Split ntfs_zero_range.
 - Refactor __ntfs_write_iomap_begin, ntfs_write_iomap_end and
   ntfs_iomap_put_folio.

v6:
 - Update ntfs.rst documentation.(Removed historical comparisons and
   temporal terms as per review feedback)
 - Remove outdated Linux-NTFS project references.
 - Add missing return comments for functions.
 - Move comments above in structure.
 - Replace wait_for_stable_page with filemap_write_and_wait_range.
 - Dereference the ntfs_inode field instead of the casts.
 - Remove malloc.h file and use kvmalloc and friends.
 - Update help text for NTFS_FS_POSIX_ACL in Kconfig.
 - Remove __always_unused directives.
 - Change #ifndef to #ifdef in debug.
 - Refactor ntfs_collate_ntofs_ulongs.
 - Change type of key length for index.
 - Remove verbose debug logs from ntfs_collate.
 - Fix sparse warnings.
 - Move initialization into declaration line.
 - Don't type cast from pointer to void.
 - Refactor ntfs_collate.
 - Re-implement llseek using iomap.
 - Don't allow acl mount option when config is disabled.
 - Fix kerneldoc warnings.
 - Update comments for magic constants.
 - Use sizeof(unsigned char) instead of UCHAR_T_SIZE_BITS.
 - Replace macros with inline helpers.
 - Add/use generic FS_IOC_SHUTDOWN definitions.
 - Remove flush_dcache_folio.
 - Introduce address space operations for $MFT.
 - Add comment for ntfs_bio_end_io.
 - Add ntfs_get_locked_folio helper.
 - Remove outdated ntfs_setattr comment.
 - Remove unnecessary kernel-doc comments.
 - Fix missing error handling for compressed/encrypted files in setattr.
 - Refactor ATTR_SIZE handling into ntfs_setattr_size().
 - Rely on iomap for direct I/O alignment state.
 - Report advanced file attributes and DIO alignment in getattr.
 - Move ntfs_attr_expand and ntfs_extend_initialized_size to ntfs iomap.
 - Factor out ntfs_dio_write_iter from ntfs_write_iter().
 - Remove unneeded IS_IMMUTABLE in ntfs_filemap_page_mkwrite.
 - Remove regular file check in ntfs_fallocate.
 - Change COMPRESS_CONTEXT to lowercase.
 - Add the comment for hash multiplier.
 - Fix potential deadlock when inode is freed.
 - Fix generic/321 failure when acl is enabled.
 - use bdev_rw_virt in ntfs_bdev_read.
 - Remove mft_writepage from ntfs_writepages.
 - let ntfs_mft_writepages call ntfs_write_mft_block instead of
   ntfs_mft_writepage.
 - Move ntfs_write_mft_block into mft.c.
 - Move ntfs_bdev_read/write into bdev-io.c
 - Move ntfs_mft_writepages to mft.c.

v5:
 - Update outdated comments to match implementation.
 - Remove unused types.h and endians.h.
 - Replace submit_bio_wait() with submit_bio().
 - Fix lockdep warnings caused by the latest xfstets and scratch_mkfs_sized support.
 - Rename ntfs_convert_folio_index_into_lcn() to lcn_from_index().
 - Fix warnings reported by Smatch static checker.
 - Fix typos patch description of MAINTAINERS.

v4:
 - remove choice variable in fs/Kconfig and make ntfs and ntfs3 mutually
   exclusive in simpler way.
 - Original revert commit includes MAINTAINERS and CREDITS and update ntfs
   entry in MAITAINERS and Anton's info in CREDITS.
 - Original revert commit include documentation and update it instead of
   adding a new one.
 - Fix generic/401 test failure and indicate that ntfs passed tests are
   a complete superset of those for ntfs3.
 - Remove unnecessary comments and warning options from Makefile.
 - Add patch description to original revert patch and the patch that
   remove legacy ntfs driver related codes in ntfs.
 - Support timestamps prior to epoch (fix generic/258).
 - Fix xfstests generic/683, 684, 686, 687, 688.

v3:
 - Add generic helpers to convert cluster to folio index, cluster to
   byte, byte to sector, etc.
 - Remove bio null check and ntfs_setup_bio().
 - Remove unneeded extra handling from old ntfs leftover.
 - Allow readahead for $MFT file.
 - Change memcpy to memcpy_from_folio or memcpy_to_folio.
 - Never switche between compressed and non-compressed for live inodes.
 - Add the comments for iomap_valid and iomap_put_folio.
 - Split the resident and non-resident cases into separate helpers.
 - Use kmalloc instead of page allocation for iomap inline data.
 - Use iomap_zero_range instead of ntfs_buffered_zero_clusters.
 - Use blkdev_issue_zeroout instead of ntfs_zero_clusters.
 - Remove 2TB limitation on 32-bit system.
 - Rename ntfsplus to ntfs.
 - Remove -EINTR handing for read_mapping_folio.
 - Rename ntfs_iomap.c to iomap.c
 - Revert alias for the legacy ntfs driver in ntfs3.
 - Restrict built-in NTFS seclection to one driver, allow both as
   modules.
 - Use static_assert() instead of the sizeof comments.
 - Update the wrong iocharset comments in ntfs.rst.

v2:
 - Add ntfs3-compatible mount options(sys_immutable, nohidden,
   hide_dot_files, nocase, acl, windows_names, disable_sparse, discard).
 - Add iocharset mount option.
 - Add ntfs3-compatible dos attribute and ntfs attribute load/store
   in setxattr/getattr().
 - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
 - Add support for FITRIM ioctl.
 - Fix the warnings(duplicate symbol, __divdi3, etc) from kernel test robot.
 - Prefix pr_xxx() with ntfsplus.
 - Add support for $MFT File extension.
 - Add Documentation/filesystems/ntfsplus.rst.
 - Mark experimental.
 - Remove BUG traps warnings from checkpatch.pl.

Appendix: xfstests Results on ntfs

Summary
- Total tests run: 787
- Passed: 326
- Failed: 38
- Not run / skipped: 423

Failed test cases and reasons
  - Requires metadata journaling (34 tests)
    043, 056, 051, 057, 065, 066, 073, 104, 225, 335, 336, 341, 342, 343,
    348, 376, 388, 417, 475, 498, 502, 510, 526, 527, 530, 552,
    640, 690, 764, 771, 779, 782, 784, 785

  - Others (4 tests)
    094: Not supported by NTFS on-disk format (no unwritten extent concept).
    563: cgroup v2 aware writeback accounting not supported.
    631: RENAME_WHITEOUT support is required on ntfs.
    787: NFS delegation test.


Namjae Jeon (17):
  Revert "fs: Remove NTFS classic"
  fs: add generic FS_IOC_SHUTDOWN definitions
  ntfs: update in-memory, on-disk structures and headers
  ntfs: update super block operations
  ntfs: update inode operations
  ntfs: update mft operations
  ntfs: update directory operations
  ntfs: update file operations
  ntfs: update iomap and address space operations
  ntfs: update attrib operations
  ntfs: update runlist handling and cluster allocator
  ntfs: add reparse and ea operations
  ntfs: update misc operations
  ntfs3: remove legacy ntfs driver support
  ntfs: add Kconfig and Makefile
  Documentation: filesystems: update NTFS driver documentation
  MAINTAINERS: update ntfs filesystem entry

 CREDITS                             |    9 +-
 Documentation/filesystems/index.rst |    1 +
 Documentation/filesystems/ntfs.rst  |  159 +
 MAINTAINERS                         |    9 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs/Kconfig                     |   47 +
 fs/ntfs/Makefile                    |   10 +
 fs/ntfs/aops.c                      |  263 ++
 fs/ntfs/attrib.c                    | 5425 +++++++++++++++++++++++++++
 fs/ntfs/attrib.h                    |  164 +
 fs/ntfs/attrlist.c                  |  289 ++
 fs/ntfs/attrlist.h                  |   20 +
 fs/ntfs/bdev-io.c                   |  117 +
 fs/ntfs/bitmap.c                    |  287 ++
 fs/ntfs/bitmap.h                    |  100 +
 fs/ntfs/collate.c                   |  146 +
 fs/ntfs/collate.h                   |   36 +
 fs/ntfs/compress.c                  | 1577 ++++++++
 fs/ntfs/debug.c                     |  171 +
 fs/ntfs/debug.h                     |   63 +
 fs/ntfs/dir.c                       | 1236 ++++++
 fs/ntfs/dir.h                       |   32 +
 fs/ntfs/ea.c                        |  942 +++++
 fs/ntfs/ea.h                        |   30 +
 fs/ntfs/file.c                      | 1161 ++++++
 fs/ntfs/index.c                     | 2117 +++++++++++
 fs/ntfs/index.h                     |  111 +
 fs/ntfs/inode.c                     | 3820 +++++++++++++++++++
 fs/ntfs/inode.h                     |  359 ++
 fs/ntfs/iomap.c                     |  870 +++++
 fs/ntfs/iomap.h                     |   23 +
 fs/ntfs/layout.h                    | 2346 ++++++++++++
 fs/ntfs/lcnalloc.c                  | 1047 ++++++
 fs/ntfs/lcnalloc.h                  |  134 +
 fs/ntfs/logfile.c                   |  778 ++++
 fs/ntfs/logfile.h                   |  245 ++
 fs/ntfs/malloc.h                    |   77 +
 fs/ntfs/mft.c                       | 2922 +++++++++++++++
 fs/ntfs/mft.h                       |   94 +
 fs/ntfs/mst.c                       |  194 +
 fs/ntfs/namei.c                     | 1695 +++++++++
 fs/ntfs/ntfs.h                      |  294 ++
 fs/ntfs/object_id.c                 |  158 +
 fs/ntfs/object_id.h                 |   14 +
 fs/ntfs/quota.c                     |   95 +
 fs/ntfs/quota.h                     |   15 +
 fs/ntfs/reparse.c                   |  573 +++
 fs/ntfs/reparse.h                   |   20 +
 fs/ntfs/runlist.c                   | 2066 ++++++++++
 fs/ntfs/runlist.h                   |   97 +
 fs/ntfs/super.c                     | 2770 ++++++++++++++
 fs/ntfs/sysctl.c                    |   55 +
 fs/ntfs/sysctl.h                    |   26 +
 fs/ntfs/time.h                      |   87 +
 fs/ntfs/unistr.c                    |  477 +++
 fs/ntfs/upcase.c                    |   70 +
 fs/ntfs/volume.h                    |  296 ++
 fs/ntfs3/Kconfig                    |   10 +-
 fs/ntfs3/dir.c                      |   10 -
 fs/ntfs3/file.c                     |   11 -
 fs/ntfs3/inode.c                    |   16 +-
 fs/ntfs3/ntfs_fs.h                  |   11 -
 fs/ntfs3/super.c                    |   59 +-
 include/uapi/linux/fs.h             |   12 +
 65 files changed, 36252 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/filesystems/ntfs.rst
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile
 create mode 100644 fs/ntfs/aops.c
 create mode 100644 fs/ntfs/attrib.c
 create mode 100644 fs/ntfs/attrib.h
 create mode 100644 fs/ntfs/attrlist.c
 create mode 100644 fs/ntfs/attrlist.h
 create mode 100644 fs/ntfs/bdev-io.c
 create mode 100644 fs/ntfs/bitmap.c
 create mode 100644 fs/ntfs/bitmap.h
 create mode 100644 fs/ntfs/collate.c
 create mode 100644 fs/ntfs/collate.h
 create mode 100644 fs/ntfs/compress.c
 create mode 100644 fs/ntfs/debug.c
 create mode 100644 fs/ntfs/debug.h
 create mode 100644 fs/ntfs/dir.c
 create mode 100644 fs/ntfs/dir.h
 create mode 100644 fs/ntfs/ea.c
 create mode 100644 fs/ntfs/ea.h
 create mode 100644 fs/ntfs/file.c
 create mode 100644 fs/ntfs/index.c
 create mode 100644 fs/ntfs/index.h
 create mode 100644 fs/ntfs/inode.c
 create mode 100644 fs/ntfs/inode.h
 create mode 100644 fs/ntfs/iomap.c
 create mode 100644 fs/ntfs/iomap.h
 create mode 100644 fs/ntfs/layout.h
 create mode 100644 fs/ntfs/lcnalloc.c
 create mode 100644 fs/ntfs/lcnalloc.h
 create mode 100644 fs/ntfs/logfile.c
 create mode 100644 fs/ntfs/logfile.h
 create mode 100644 fs/ntfs/malloc.h
 create mode 100644 fs/ntfs/mft.c
 create mode 100644 fs/ntfs/mft.h
 create mode 100644 fs/ntfs/mst.c
 create mode 100644 fs/ntfs/namei.c
 create mode 100644 fs/ntfs/ntfs.h
 create mode 100644 fs/ntfs/object_id.c
 create mode 100644 fs/ntfs/object_id.h
 create mode 100644 fs/ntfs/quota.c
 create mode 100644 fs/ntfs/quota.h
 create mode 100644 fs/ntfs/reparse.c
 create mode 100644 fs/ntfs/reparse.h
 create mode 100644 fs/ntfs/runlist.c
 create mode 100644 fs/ntfs/runlist.h
 create mode 100644 fs/ntfs/super.c
 create mode 100644 fs/ntfs/sysctl.c
 create mode 100644 fs/ntfs/sysctl.h
 create mode 100644 fs/ntfs/time.h
 create mode 100644 fs/ntfs/unistr.c
 create mode 100644 fs/ntfs/upcase.c
 create mode 100644 fs/ntfs/volume.h

-- 
2.25.1


