Return-Path: <linux-fsdevel+bounces-720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0B37CF02F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 08:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8B1C209C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB86126;
	Thu, 19 Oct 2023 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="NedFf5gf";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="WUhCjrIu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A665C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 06:37:40 +0000 (UTC)
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24A9122;
	Wed, 18 Oct 2023 23:37:38 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 84E0D1D37;
	Thu, 19 Oct 2023 06:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1697697095;
	bh=+tR/SuZ12C+bYNNqeuZZw4rfTtUeq8KRTtUUgfqHkLs=;
	h=Date:To:CC:From:Subject;
	b=NedFf5gfh5tADmdDx5q86t6uEtubFn1wv2MeXjZx0+0yVTst4PvpV7UcjcBgrWvnr
	 nEfQLilrW+VEiMJMfep48oPMi0Cf3spHQAV+J1jFSu3MuQnw5bOM/ntydf/szP2k7n
	 V4XKnyoPdNcaOC0j70rk/lTnPP9/e0LCXWCGGw+c=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 775971D0F;
	Thu, 19 Oct 2023 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1697697456;
	bh=+tR/SuZ12C+bYNNqeuZZw4rfTtUeq8KRTtUUgfqHkLs=;
	h=Date:To:CC:From:Subject;
	b=WUhCjrIuj9DWkUf07Y5v2FiNF+TvDI3o0/uSXL9Ll199ygCc/zw5rcBVgCHzjJo5V
	 G08crjljCF8UbWRvbEydVcFvFp6ma8zpZ+LRh9dRx4uqDtHOdMcBtbYWFVMF+q1NOW
	 Sz3PWmXq/OVhCp4PPzImCH0i/j+ks+hlKuYxm/SQ=
Received: from [172.16.192.129] (192.168.211.127) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 19 Oct 2023 09:37:35 +0300
Message-ID: <e7b035ea-320e-465f-966f-0c370f9848be@paragon-software.com>
Date: Thu, 19 Oct 2023 09:37:33 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <torvalds@linux-foundation.org>
CC: <ntfs3@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: Konstantin Komarovc <almaz.alexandrovich@paragon-software.com>
Subject: [GIT PULL] ntfs3: bugfixes for 6.6
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.127]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Hi Linus,

Please pull this branch containing ntfs3 code for 6.6.

Fixed:
- memory leak;
- some logic errors, NULL dereferences;
- some code was refactored.

Added:
- more checks.

All changed code was in linux-next branch for several weeks.

Regards,

Konstantin

----------------------------------------------------------------

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

    Linux 6.6-rc1 (Sun Sep 10 16:28:41 2023 -0700)

are available in the Git repository at:

    https://github.com/Paragon-Software-Group/linux-ntfs3.git ntfs3_for_6.6

for you to fetch changes up to e4494770a5cad3c9d1d2a65ed15d07656c0d9b82:

    fs/ntfs3: Avoid possible memory leak (Mon Sep 25 12:48:07 2023 +0800)

----------------------------------------------------------------

Gabriel Marcano (1):
   fs/ntfs3: Fix directory element type detection

Konstantin Komarov (14):
   fs/ntfs3: Add ckeck in ni_update_parent()
   fs/ntfs3: Write immediately updated ntfs state
   fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
   fs/ntfs3: Add more attributes checks in mi_enum_attr()
   fs/ntfs3: fix deadlock in mark_as_free_ex
   fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
   fs/ntfs3: Use inode_set_ctime_to_ts instead of inode_set_ctime
   fs/ntfs3: Allow repeated call to ntfs3_put_sbi
   fs/ntfs3: Fix alternative boot searching
   fs/ntfs3: Refactoring and comments
   fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
   fs/ntfs3: Do not allow to change label if volume is read-only
   fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
   fs/ntfs3: Fix NULL pointer dereference on error in
     attr_allocate_frame()

Pavel Skripkin (1):
   fs/ntfs3: Fix OOB read in ntfs_init_from_boot

Su Hui (1):
   fs/ntfs3: Avoid possible memory leak

Zeng Heng (1):
   fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Ziqi Zhao (1):
   fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

  fs/ntfs3/attrib.c   |  12 +++--
  fs/ntfs3/attrlist.c |  15 ++++++-
  fs/ntfs3/bitmap.c   |   4 +-
  fs/ntfs3/dir.c      |   6 ++-
  fs/ntfs3/file.c     |   4 +-
  fs/ntfs3/frecord.c  |   8 +++-
  fs/ntfs3/fslog.c    |   6 ++-
  fs/ntfs3/fsntfs.c   |  19 ++++----
  fs/ntfs3/index.c    |   3 ++
  fs/ntfs3/inode.c    |   5 ++-
  fs/ntfs3/namei.c    |   6 +--
  fs/ntfs3/ntfs.h     |   2 +-
  fs/ntfs3/ntfs_fs.h  |   4 +-
  fs/ntfs3/record.c   |  74 ++++++++++++++++++++++++-------
  fs/ntfs3/super.c    | 104 +++++++++++++++++++++++++++++++-------------
  fs/ntfs3/xattr.c    |   7 ++-
  16 files changed, 197 insertions(+), 82 deletions(-)



