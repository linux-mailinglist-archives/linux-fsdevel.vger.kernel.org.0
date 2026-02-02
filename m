Return-Path: <linux-fsdevel+bounces-76097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OPdGDcfgWm0EAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:03:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5223D1EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE8F302173C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47431AF2C;
	Mon,  2 Feb 2026 22:03:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6231AA80
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770069788; cv=none; b=I5FqIHhlwSmJcP/I8S8jf2pthrb3vOx2y7dMhX8UgazjWkcduGRrGcs8M53rx7WjUqZ9jcx60oedBMkTH9rAaPdJ6tXCYEzJVPQXVvkFjw3p0IE9Ob+sqDJTwvq5sK88pXmK49jj32aPSb/FwpdoujXtg8+Wj3Zy9tuxmc6mAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770069788; c=relaxed/simple;
	bh=pfU75v9LsaEldXNuCrabQtZE9JGsdqcPtv/KWJwcYrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AQaf8pnDp1qgqorHLD8NG5mT+rcdgfdott0wkTgEa0FB/92UIt4dtoiuCKqAqpAEogT9LoOhh+piGzIVVPXfIU7lwnZpxHwiC1SR+BfT8ehw2L94lCEaY9j00pOwIJwDJlf/e3F5rPKGMADQP76QlFHC/rajiT4QCH6DAas0qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f47610542so2790923b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 14:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770069786; x=1770674586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mnsrPeAYT553W/SAIsZ/oqG0wzuO/2CGoNdeM6J16E=;
        b=RU6ItvFYtYqvNIyMcAtcgm4mFwVqDSrMNHpT6rJHSKHUFOPusLzd17aL7ZcNrOJPWT
         pSqVp3aa25yTMEQok9Jt8PXjx7SEQFSnWuZ3h1bB+t8cyBVi+3R3QyfdIna2cfhrWt0K
         VuYABgDwBtMso8OVBecidUciLImLRswhY0HppYzJzKLUExRCDeIT3Yg5Vhl7UmcIxOBu
         xQ/Un2Iq/y5IYHlWEPNeQNkMZHSC4WCBzOUjgup5lrGS3v2jM5gElzq76WMoFa7S344b
         fQLLheUQJDFxdYlXE3gKNRtGKPRrUMSCBWT6zViKM9JBuK2EX6EO0T+kglbRRtiMjQxe
         pJ6w==
X-Gm-Message-State: AOJu0YyloctuVPDKRKRhuthPFvx2JlI1X/dY8i4Sl+OEaHl9i/+btOgg
	qFt+cGGfa7V7OnkMBzsSB26qiQQdvc04L9oanDZLIapyOTbRJ1H3vMFw
X-Gm-Gg: AZuq6aL90+YWJm9IqhP+z7uYSmlXBAx3j9V2zf7Ii/lxkSbFC6B4yHsDE4nn+QC8Z0F
	Aa3BtllgzzxpI9kthiXQV7y0gR/GnrZ9yAqf9ff+/vHGQdKbBFwwQ4EQXqy4UMONu9024P0JgeB
	k+r8W5Ni3IOC5r4ob4FkEQilqPHQJu7p2K0+23GLuam0WtnFnniw+X75aAC8WSRVihbwXG8ixrN
	FN0/dBQnUfq7GF3eMUOGYTKxD9Ewpk7Er/MQXKjdIqRueBp+fvHmeiowjviqs7MiTVgD3M4YedM
	iFUDm4v4UxqO4ZXbRmP3lraJ2wVI8OC0FdoSkzBB4a8141RdmXFZ+Zk9URaUpwmH/96G4bGU0rM
	H17mRYqksWB04M+XsEXH27S8W6qOHWV2jRPTeLk92+30kzE4DFsZrTXIh0a21hKBRrYC0hObJRY
	wSYTL6WiFdbpxhhQ7rdWRQdSHmvw==
X-Received: by 2002:aa7:9062:0:b0:823:d2c:b155 with SMTP id d2e1a72fcca58-823ab65f04amr12814157b3a.14.1770069786074;
        Mon, 02 Feb 2026 14:03:06 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm21019732b3a.29.2026.02.02.14.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 14:03:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v6 00/16] ntfs filesystem remake
Date: Tue,  3 Feb 2026 07:01:46 +0900
Message-Id: <20260202220202.10907-1-linkinjeon@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-76097-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: B5223D1EA6
X-Rspamd-Action: no action

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


Appendix: xfstests Results on ntfs
==================================

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

Namjae Jeon (16):
  Revert "fs: Remove NTFS classic"
  Documentation: filesystems: update NTFS driver documentation
  fs: add generic FS_IOC_SHUTDOWN definitions
  ntfs: update in-memory, on-disk structures and headers
  ntfs: update super block operations
  ntfs: update inode operations
  ntfs: update directory operations
  ntfs: update file operations
  ntfs: update iomap and address space operations
  ntfs: update attrib operations
  ntfs: update runlist handling and cluster allocator
  ntfs: add reparse and ea operations
  ntfs: update misc operations
  ntfs3: remove legacy ntfs driver support
  ntfs: add Kconfig and Makefile
  MAINTAINERS: update ntfs filesystem entry

 CREDITS                             |    9 +-
 Documentation/filesystems/index.rst |    1 +
 Documentation/filesystems/ntfs.rst  |  159 +
 MAINTAINERS                         |    9 +
 fs/Kconfig                          |    1 +
 fs/Makefile                         |    1 +
 fs/ntfs/Kconfig                     |   47 +
 fs/ntfs/Makefile                    |   10 +
 fs/ntfs/aops.c                      |  264 ++
 fs/ntfs/aops.h                      |   21 +
 fs/ntfs/attrib.c                    | 5432 +++++++++++++++++++++++++++
 fs/ntfs/attrib.h                    |  164 +
 fs/ntfs/attrlist.c                  |  289 ++
 fs/ntfs/attrlist.h                  |   20 +
 fs/ntfs/bdev-io.c                   |  109 +
 fs/ntfs/bitmap.c                    |  287 ++
 fs/ntfs/bitmap.h                    |  100 +
 fs/ntfs/collate.c                   |  146 +
 fs/ntfs/collate.h                   |   36 +
 fs/ntfs/compress.c                  | 1578 ++++++++
 fs/ntfs/debug.c                     |  171 +
 fs/ntfs/debug.h                     |   63 +
 fs/ntfs/dir.c                       | 1233 ++++++
 fs/ntfs/dir.h                       |   32 +
 fs/ntfs/ea.c                        |  947 +++++
 fs/ntfs/ea.h                        |   30 +
 fs/ntfs/file.c                      | 1150 ++++++
 fs/ntfs/index.c                     | 2117 +++++++++++
 fs/ntfs/index.h                     |  112 +
 fs/ntfs/inode.c                     | 3822 +++++++++++++++++++
 fs/ntfs/inode.h                     |  361 ++
 fs/ntfs/iomap.c                     |  858 +++++
 fs/ntfs/iomap.h                     |   23 +
 fs/ntfs/layout.h                    | 2346 ++++++++++++
 fs/ntfs/lcnalloc.c                  | 1043 +++++
 fs/ntfs/lcnalloc.h                  |  134 +
 fs/ntfs/logfile.c                   |  777 ++++
 fs/ntfs/logfile.h                   |  245 ++
 fs/ntfs/malloc.h                    |   77 +
 fs/ntfs/mft.c                       | 2915 ++++++++++++++
 fs/ntfs/mft.h                       |   93 +
 fs/ntfs/mst.c                       |  194 +
 fs/ntfs/namei.c                     | 1695 +++++++++
 fs/ntfs/ntfs.h                      |  294 ++
 fs/ntfs/object_id.c                 |  158 +
 fs/ntfs/object_id.h                 |   14 +
 fs/ntfs/quota.c                     |   95 +
 fs/ntfs/quota.h                     |   15 +
 fs/ntfs/reparse.c                   |  548 +++
 fs/ntfs/reparse.h                   |   20 +
 fs/ntfs/runlist.c                   | 2065 ++++++++++
 fs/ntfs/runlist.h                   |   97 +
 fs/ntfs/super.c                     | 2769 ++++++++++++++
 fs/ntfs/sysctl.c                    |   55 +
 fs/ntfs/sysctl.h                    |   26 +
 fs/ntfs/time.h                      |   87 +
 fs/ntfs/unistr.c                    |  477 +++
 fs/ntfs/upcase.c                    |   70 +
 fs/ntfs/volume.h                    |  296 ++
 fs/ntfs3/Kconfig                    |   10 +-
 fs/ntfs3/dir.c                      |    9 -
 fs/ntfs3/file.c                     |   10 -
 fs/ntfs3/inode.c                    |   16 +-
 fs/ntfs3/ntfs_fs.h                  |   11 -
 fs/ntfs3/super.c                    |   59 +-
 include/uapi/linux/fs.h             |   12 +
 66 files changed, 36218 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/filesystems/ntfs.rst
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile
 create mode 100644 fs/ntfs/aops.c
 create mode 100644 fs/ntfs/aops.h
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


