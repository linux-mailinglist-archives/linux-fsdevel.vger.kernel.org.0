Return-Path: <linux-fsdevel+bounces-76291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DmpDLASg2kPhQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 10:34:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D5E3E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A60530160F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AD63ACF01;
	Wed,  4 Feb 2026 09:34:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E203A1D18
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197676; cv=none; b=a+TAJBgH1ergaQTuYNZtBppZZ++dM6KsC5M8dRCvy9htuG0hEM3BMaxfV917yGslPGGdXD/DKzdLOuw2XHmn2ArxucYVJJHgaUdoEGyEEi+U7WLAX4yOOXhxp2+hn3EFrzSVBzAUIvF4d4EFY2JNs/eh+KlYSNkOQdXG+/wI/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197676; c=relaxed/simple;
	bh=LHBNxEJ7dRd1+WiDCCECcBiA81mrCqnKmcG28h6xXIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F+WDxIaFocd1bPgHlWmlViabYhzNV3Lektriv6M9KvN7fxKbQbiz/NRmpwDteXEobHDHYmoYCwiyngfAZo04Ra6iVXDEaQwTyM+2Z+IRVaACTP7sbHV98Wr27oxUvR8KbTU3oG8HdwFDKm+Nr6airqw5HZ03X8R2iKFHZdbxSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8947e17968eso75733026d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 01:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197675; x=1770802475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDLW+cpRJ9IHhEsZZ6z3ECtsVYVax+7oYzWbFy6AKow=;
        b=qW0rILmQDkScoSoMDcwIuPWEABdjEIrUDZ3n6kcuGRlMKwb/EscSaGW38GJ1ZkD8H+
         l+P7j1DenBNOkQCVDUmid3JfM0KXwno8Sqt2v5SssBTCHlgkn086poTNFfbD35LgU3Af
         ewfg8vbRvtRuCBNYPpQt9bw5dKjQXPJedT80Vh8NSPF1IRXCPX/b9VAxw8iN5P7Valo0
         x3JvuUGl5XG1o7N9KVkgFJmMWTBuJ2s7Cdl8kU8V5gaYdVWWLjaZ5+CVlma6M8qAZwbh
         Mm99Ggz/4QC6pcj6nfzkMNa+oVwaLpgwWHOCcGpKZht3FRkqwceXfRKPHlDPJ92LpBxk
         sRzw==
X-Gm-Message-State: AOJu0Yz+b75xJSQtw2e0LAMbG4v5BPlby4jqmacW8cfHWEvpdKkW2RzI
	HRH+J+hHvvrZQjvTTYxG/Ohu/IMJmIMu0XFdlTthnBFhLdP+zAPkHkCEDDkl4w==
X-Gm-Gg: AZuq6aIFQCZCMNw0h7icxetP4rooWTbIYQ+yLBonvqSx8drdDtWONNfHTvyq+f3sjQy
	SBksIQdZCCHNMspyN9i7OW5quc+D+x8b6Deyz6obY57sq6J8/dNWXXcbg9fiywG6aOWjFqN31Ku
	DYQyD3Cl29VPS54OPHuxQLYNmbQSd4O72Hb66VGPoLgaqvm7DRnWb3JEOmBAXfDoKF64T4mSnz1
	5laJADU7EswZrlWZWwxoVZy9W6lO+tIn9a4cuLZ9ckSemPLgazqr7B9XMWdeQzfDGsDzSolUSnj
	H6quIdj5C3h8phET80HqLwrl7wKix3Nfa9+d9lBA7oMJaGeABEhJ5hDkAFdv0YW3oo/eKHe3k5v
	EayIEaLBx8Ao2Gw3urVTEKxXPJi5mkU5GYcEG/KftYkhFdh6V0BNZiRl6a1wOBEe2pS6IXQRfPJ
	UMtYiHySeuu7ONF+4Zdb3L/UrwVYN4OY3b9PrR
X-Received: by 2002:a05:6a21:a95:b0:343:6c90:77b5 with SMTP id adf61e73a8af0-39372090f9cmr2335693637.15.1770191286554;
        Tue, 03 Feb 2026 23:48:06 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933967771sm14554875ad.82.2026.02.03.23.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:48:05 -0800 (PST)
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
Subject: [PATCH v7 00/17] ntfs filesystem remake
Date: Wed,  4 Feb 2026 16:47:38 +0900
Message-Id: <20260204074755.9058-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-76291-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marc.info:url,wikipedia.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 9B6D5E3E86
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
 fs/ntfs/bdev-io.c                   |  109 +
 fs/ntfs/bitmap.c                    |  287 ++
 fs/ntfs/bitmap.h                    |  100 +
 fs/ntfs/collate.c                   |  146 +
 fs/ntfs/collate.h                   |   36 +
 fs/ntfs/compress.c                  | 1577 ++++++++
 fs/ntfs/debug.c                     |  171 +
 fs/ntfs/debug.h                     |   63 +
 fs/ntfs/dir.c                       | 1233 ++++++
 fs/ntfs/dir.h                       |   32 +
 fs/ntfs/ea.c                        |  947 +++++
 fs/ntfs/ea.h                        |   30 +
 fs/ntfs/file.c                      | 1158 ++++++
 fs/ntfs/index.c                     | 2117 +++++++++++
 fs/ntfs/index.h                     |  111 +
 fs/ntfs/inode.c                     | 3821 +++++++++++++++++++
 fs/ntfs/inode.h                     |  359 ++
 fs/ntfs/iomap.c                     |  870 +++++
 fs/ntfs/iomap.h                     |   23 +
 fs/ntfs/layout.h                    | 2346 ++++++++++++
 fs/ntfs/lcnalloc.c                  | 1047 ++++++
 fs/ntfs/lcnalloc.h                  |  134 +
 fs/ntfs/logfile.c                   |  778 ++++
 fs/ntfs/logfile.h                   |  245 ++
 fs/ntfs/malloc.h                    |   77 +
 fs/ntfs/mft.c                       | 2920 ++++++++++++++
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
 65 files changed, 36240 insertions(+), 116 deletions(-)
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


