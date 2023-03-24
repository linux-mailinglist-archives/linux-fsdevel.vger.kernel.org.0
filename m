Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED16C7C88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCXK2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 06:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCXK2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:28:38 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D2620544;
        Fri, 24 Mar 2023 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679653710; i=@fujitsu.com;
        bh=Q/bH+Td5mtaZDBbP5aHrv4xc85YaJ+KduTCswEaO3j8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ELxEXRQvlz1/CLKFc/PsKCOEBPXW2CCA5z4zH+Qeyrd9+z71FvVSCdVzW0Ucl8qTh
         p15LvMTAizncXem2GG1QCZetltnX4f44SilPcHQnRb+3HYzzG1niRcXuD+HPamMhwF
         BvF4tElsaSlaZC24DAH0N7hWuMLZaA+kRAy0lt18RJSn3Z0wAciaWbdbyqIMi2/BCP
         /SM0MlFwPQJaQ+06oaVfX7CUJKfktgMh1XUcwSMsoUEBiirgAE2wRcNeVB8CYucGWu
         6r+ULLas4Lp4JI7rPpmszOo1elJvIqP41KsqB9nFT2IVKAkxIcP/9TSc1CJZgDm7hO
         hv03LK4E9/Kzw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRWlGSWpSXmKPExsViZ8OxWde3Wjb
  FYP87VYs569ewWUyfeoHR4vITPovZ05uZLPbsPclisevPDnaLlT/+sFr8/jGHzYHDY/MKLY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnqcWXCE3ePzJrkA9ijWzLyk/IoE1oy/V58xF/QKVEzf+Iaxg
  XEFbxcjF4eQwEZGifdNB9ggnMVMEifm3mOHcI4xSvybtp+pi5GTg01AR+LCgr+sILaIQLTE/D
  l/mUFsZoEKicZF/8BsYQFTiSlLZoPVswioSmw6Np0NxOYVcJb48WUuO4gtIaAgMeXhe2aIuKD
  EyZlPWCDmSEgcfPGCGaJGSeLi1zusEDbQ/OmHmCBsNYmr5zYxT2Dkn4WkfRaS9gWMTKsYzYpT
  i8pSi3QNjfSSijLTM0pyEzNz9BKrdBP1Ukt1y1OLS3QN9RLLi/VSi4v1iitzk3NS9PJSSzYxA
  mMhpZj5xQ7GH31/9Q4xSnIwKYnySoRKpwjxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4GWqkE0REi
  xKTU+tSMvMAcYlTFqCg0dJhLe6ECjNW1yQmFucmQ6ROsWoKCXOe7YSKCEAksgozYNrg6WCS4y
  yUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEeW+UA03hycwrgZv+CmgxE9Bi5xoZkMUliQgpqQam
  Gua2nH1hCucLNrx7tUcs+nzMLc8P8ZFbHr5KmDyPd+W20H/20h1rvJ1WbD77nc8zwGRnjyhbI
  Kez3Uy9sIoZZ+6HShWeWbD42J6H/zhzZ/5xZlmjVMG6xSbk18msLTfu3LBNmxszy5NZvT5bYK
  305LPawcpaOkXV7yap+bz6eOuEbt65l1F6ly/tvH7lo5lPPIvhF0fhysOiE5s6799JKNpQaWu
  d9q7sS8pWq9lyYfoZ62Y6Tvz/YP/zR4+uzvl9Z9I/gU1NaUFKARON2+WLD6j9mHfT+l7VPC8r
  ya6bgosvTr055dQ+tnRNP3Hmcxd3n567zsfjTNqrL8Wci3OSIyyZjIybN1g842FcHpW+S4mlO
  CPRUIu5qDgRAPRRKAeAAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-20.tower-591.messagelabs.com!1679653709!709252!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5527 invoked from network); 24 Mar 2023 10:28:29 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-20.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Mar 2023 10:28:29 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 2F5B0150;
        Fri, 24 Mar 2023 10:28:29 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 2296C73;
        Fri, 24 Mar 2023 10:28:29 +0000 (GMT)
Received: from d6710f1449dd.g08.fujitsu.local (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 24 Mar 2023 10:28:25 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
Subject: [PATCH] fsdax: force clear dirty mark if CoW
Date:   Fri, 24 Mar 2023 10:28:00 +0000
Message-ID: <1679653680-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

XFS allows CoW on non-shared extents to combat fragmentation[1].  The
old non-shared extent could be mwrited before, its dax entry is marked
dirty.  To be able to delete this entry, clear its dirty mark before
invalidate_inode_pages2_range().

[1] https://lore.kernel.org/linux-xfs/20230321151339.GA11376@frogsfrogsfrogs/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/dax.c b/fs/dax.c
index 5d2e9b10030e..2ababb89918d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -781,6 +781,33 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	return ret;
 }
 
+static int __dax_clear_dirty_range(struct address_space *mapping,
+		pgoff_t start, pgoff_t end)
+{
+	XA_STATE(xas, &mapping->i_pages, start);
+	unsigned int scanned = 0;
+	void *entry;
+
+	xas_lock_irq(&xas);
+	xas_for_each(&xas, entry, end) {
+		entry = get_unlocked_entry(&xas, 0);
+		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		put_unlocked_entry(&xas, entry, WAKE_NEXT);
+
+		if (++scanned % XA_CHECK_SCHED)
+			continue;
+
+		xas_pause(&xas);
+		xas_unlock_irq(&xas);
+		cond_resched();
+		xas_lock_irq(&xas);
+	}
+	xas_unlock_irq(&xas);
+
+	return 0;
+}
+
 /*
  * Delete DAX entry at @index from @mapping.  Wait for it
  * to be unlocked before deleting it.
@@ -1440,6 +1467,16 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	 * written by write(2) is visible in mmap.
 	 */
 	if (iomap->flags & IOMAP_F_NEW || cow) {
+		/*
+		 * Filesystem allows CoW on non-shared extents. The src extents
+		 * may have been mmapped with dirty mark before. To be able to
+		 * invalidate its dax entries, we need to clear the dirty mark
+		 * in advance.
+		 */
+		if (cow)
+			__dax_clear_dirty_range(iomi->inode->i_mapping,
+						pos >> PAGE_SHIFT,
+						(end - 1) >> PAGE_SHIFT);
 		invalidate_inode_pages2_range(iomi->inode->i_mapping,
 					      pos >> PAGE_SHIFT,
 					      (end - 1) >> PAGE_SHIFT);
-- 
2.39.2

