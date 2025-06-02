Return-Path: <linux-fsdevel+bounces-50291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54461ACAB12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1C417AB87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3540C1AF4D5;
	Mon,  2 Jun 2025 09:03:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4638BE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854980; cv=none; b=gNB5Ry6YfuXGdxuWCN65SIigYHS4INZtjpKan4UafpywXvgthory4G16SukuCsfrgFwMMGx3LdvER6lNVxOPqO2K53zlNtv+TPDOToxWfP+cGfghSXrwQnpBg5C06W26N5oLKEuVgVTW5QQGhSV8RhEADkSg7yw8tMdrDA+vM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854980; c=relaxed/simple;
	bh=FG0EVU+DM2OXRnJBF3yjyikHbFdWlgs+QlnXdJdZEXY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QEajaf6fQ4nLLOy1PjKFzfEbftPPPsOuFpvNJCe/ScHEq1+lDefCxhHDwE02UHsg11DGHgGtD2bhpdaPuK3AZCoDF8p44zTbsYcueDBILJEqfYs4yIXXIVDD1k+OFwhaAZz9xFQE5bo6GzLxYRspQMZs3y3g3RrpTqfESoTkCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b9nnx0hZZzCtYY;
	Mon,  2 Jun 2025 16:59:01 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8500D180239;
	Mon,  2 Jun 2025 17:02:48 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Jun
 2025 17:02:47 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <sandeen@redhat.com>,
	<lihongbo22@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v4 0/7] f2fs: new mount API conversion
Date: Mon, 2 Jun 2025 09:02:17 +0000
Message-ID: <20250602090224.485077-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

In this version, we have finished the issues pointed in v3.
First, I'd like to express my sincere thanks to Jaegeuk and Chao
for reviewing this patch series and providing corrections. I also
appreciate Eric for rebasing the patches onto the latest branch to
ensure forward compatibility.

The latest patch series has addressed all the issues mentioned in
the previous set. For modified patches, I've re-added Signed-off-by
tags (SOB) and uniformly removed all Reviewed-by tags.

v4:
  - Change is_remount as bool type in patch 2.
  - Remove the warning reported by Dan for patch 5.
  - Enhance sanity check and fix some coding style suggested by
    Jaegeuk in patch 5.
  - Change the log info when compression option conflicts in patch 5.
  - Fix the issues reported by code-reviewing in patch 5.
  - Context modified in patch 7.

V3: https://lore.kernel.org/all/20250423170926.76007-1-sandeen@redhat.com/
- Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
  dev branch
- Fix up some 0day robot warnings

(Here is the origianl cover letter:)

Since many filesystems have done the new mount API conversion,
we introduce the new mount API conversion in f2fs.

The series can be applied on top of the current mainline tree
and the work is based on the patches from Lukas Czerner (has
done this in ext4[1]). His patch give me a lot of ideas.

Here is a high level description of the patchset:

1. Prepare the f2fs mount parameters required by the new mount
API and use it for parsing, while still using the old API to
get mount options string. Split the parameter parsing and
validation of the parse_options helper into two separate
helpers.

  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt

2. Remove the use of sb/sbi structure of f2fs from all the
parsing code, because with the new mount API the parsing is
going to be done before we even get the super block. In this
part, we introduce f2fs_fs_context to hold the temporary
options when parsing. For the simple options check, it has
to be done during parsing by using f2fs_fs_context structure.
For the check which needs sb/sbi, we do this during super
block filling.

  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking

3. Switch the f2fs to use the new mount API for mount and
remount.

  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

[1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/

Hongbo Li (7):
  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt
  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking
  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

 fs/f2fs/super.c | 2108 +++++++++++++++++++++++++++--------------------
 1 file changed, 1197 insertions(+), 911 deletions(-)

-- 
2.33.0


