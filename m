Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0164D63F3E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiLAP3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiLAP3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:33 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C7ABA0D;
        Thu,  1 Dec 2022 07:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908569; i=@fujitsu.com;
        bh=VLgjPObXgDpD1EhbJ2E6IzLMPYjKp+jmi2A+kdHqNOM=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ZHqViv6f4ubT/O7/fDQ/o7jHdDwUCU+09tQjn10UaML/hPQfxjU7njJU00mskzezU
         w86eFLSpAETBvOb8DDYGnQYnMBcPOfMHwYI98jHsMkp5Li8JxoGTdmI+AYzPjz/Hue
         OCksRXQBYfQdHvb2/BwA3p5jWB/VOJt0J7zCQQEU9SxJgsnvL6SuIF9cjxmxvhFeC4
         BYwKO9Dfm4OHXY8xNndOfN6WEvjFuZ4hAMCOgNsYDaUSQy2ZEqMWVLn4COlK0cqVau
         X7+TRnwfMXlfQVvZNdM70oIjbiayo2z3pcBo1M3Dk0Vfk/pYzlQdTJf9Te8z7FhkAn
         lpNHs0HfI0owg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42Kxs+FI0o080ZF
  s8OKhuMWc9WvYLKZPvcBoseXYPUaLy0/4LPbsPclicXnXHDaLXX92sFus/PGH1YHD49QiCY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnp83iQXwBbFmpmXlF+RwJqxdsZW1oIWiYp9FxpZGhi7RLoYu
  TiEBDYyShxu38QI4SxmkmhvmMYM4exhlLh9dhKQw8nBJqAjcWHBX9YuRg4OEYFqiVtL2UDCzA
  IZEsev/AErERYIlLj2djkriM0ioCKxd+8RJhCbV8BF4sSUyewgtoSAgsSUh+/B6jkFXCVe/t0
  IFhcCqrnefJAZol5Q4uTMJywQ8yUkDr54wQyyVkJASWJmdzzEmAqJWbPamCBsNYmr5zYxT2AU
  nIWkexaS7gWMTKsYTYtTi8pSi3RN9JKKMtMzSnITM3P0Eqt0E/VSS3XLU4tLdA31EsuL9VKLi
  /WKK3OTc1L08lJLNjECYyWlmM1nB+O/pX/0DjFKcjApifJq7+tIFuJLyk+pzEgszogvKs1JLT
  7EKMPBoSTBm7IHKCdYlJqeWpGWmQOMW5i0BAePkggv3zGgNG9xQWJucWY6ROoUoy7H2oYDe5m
  FWPLy81KlxHkvghQJgBRllObBjYClkEuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHm3bQOa
  wpOZVwK36RXQEUxAR0SKtYEcUZKIkJJqYDJO4H37W+l94N/vNzJ450xeZBC0buuvbGV2Hs7pr
  ueZ81LnZjcF7tKvXPhekz/0p4Tgo6pSxW/nPaqStx1xjFure2DK4pcy3gsqed5U1fzzPZq3rO
  CryNZJMfOafNWmKB1O58mOPvJgztcv62XeMAXMqvptePvNE9sUi4f33kfzpIlcibFptX84b03
  CDYGbdRfOtKqnh0S/yuKYHdldEyxRNOtTxK47V/5eW5klqWS1ccISdha2p+GpFxqb/UoPzF/J
  E/b3kdGr/af3W/+sdeoKlQ+75DtRV7zlZdaeH8943Gafjbo89ai29DfvrV+qvJ/9z+PK8arp/
  5ciy7KZ8eGNzMdzG713a6/S5Xw6c54SS3FGoqEWc1FxIgCPb58anAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-11.tower-591.messagelabs.com!1669908569!125677!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15571 invoked from network); 1 Dec 2022 15:29:29 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-11.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:29:29 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id ECD0B1B6;
        Thu,  1 Dec 2022 15:29:28 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E13417B;
        Thu,  1 Dec 2022 15:29:28 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:29:25 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 4/8] fsdax,xfs: set the shared flag when file extent is shared
Date:   Thu, 1 Dec 2022 15:28:54 +0000
Message-ID: <1669908538-55-5-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a dax page is shared, mapread at different offsets can also trigger
page fault on same dax page.  So, change the flag from "cow" to
"shared".  And get the shared flag from filesystem when read.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c           | 19 +++++++------------
 fs/xfs/xfs_iomap.c |  2 +-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6b6e07ad8d80..f1eb59bee0b5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -846,12 +846,6 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
 		(iter->iomap.flags & IOMAP_F_DIRTY);
 }
 
-static bool dax_fault_is_cow(const struct iomap_iter *iter)
-{
-	return (iter->flags & IOMAP_WRITE) &&
-		(iter->iomap.flags & IOMAP_F_SHARED);
-}
-
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -865,13 +859,14 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
-	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
-	bool cow = dax_fault_is_cow(iter);
+	bool write = iter->flags & IOMAP_WRITE;
+	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
+	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
-	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
+	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -883,12 +878,12 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				cow);
+				shared);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -908,7 +903,7 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
-	if (cow)
+	if (write && shared)
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
 
 	xas_unlock_irq(xas);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 07da03976ec1..881de99766ca 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1215,7 +1215,7 @@ xfs_read_iomap_begin(
 		return error;
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, 0);
-	if (!error && (flags & IOMAP_REPORT))
+	if (!error && ((flags & IOMAP_REPORT) || IS_DAX(inode)))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
 	xfs_iunlock(ip, lockmode);
 
-- 
2.38.1

