Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001D4F01F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 15:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354979AbiDBNGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 09:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354973AbiDBNGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:06:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298796548B;
        Sat,  2 Apr 2022 06:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD606149F;
        Sat,  2 Apr 2022 13:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01528C340EE;
        Sat,  2 Apr 2022 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648904677;
        bh=YeyJTjeUzRFfKXdl59MUSFMYpruHVEiGvG1DK+lObhw=;
        h=From:To:Cc:Subject:Date:From;
        b=I3tYUGA3ifeZUHr/DaGOHctUMa9zdkXd4Wuq1SgKCe1WQCMse4gnoV1c+e1ZLgqcv
         RGlQld5vjelbK482BgcUxulKPLYbeXJdHEHimvhWcsSRbHLkv5kg4Jr0NobhNua9/d
         Kwzpv36j4ne7zRP7x5O1yZKnpSLgAt18TrVowPglEVy+vVnIqM+T6NZ8RrZQcj9qDH
         8igJ0nUD6IvDfpDaZcL4X9naHwwts4JS/Cb6ol/Rx7E5+Pbr/6KxlxssdDZMXYLM8m
         XU9SKj7yR9DdhXJzWt2dLV5Xb6BO12gvMT1H27FXfQ3aEGfDv82e5Lyxf8kqd5uvsB
         az3EJ+/It8icA==
From:   Sasha Levin <sashal@kernel.org>
To:     stable-commits@vger.kernel.org, willy@infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Patch "iomap: Fix iomap_invalidatepage tracepoint" has been added to the 5.17-stable tree
Date:   Sat,  2 Apr 2022 09:04:35 -0400
Message-Id: <20220402130435.2055998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a note to let you know that I've just added the patch titled

    iomap: Fix iomap_invalidatepage tracepoint

to the 5.17-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iomap-fix-iomap_invalidatepage-tracepoint.patch
and it can be found in the queue-5.17 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 8f9b67c3d57e4cabb1f03a0e28a806b082cd683e
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Feb 9 20:21:22 2022 +0000

    iomap: Fix iomap_invalidatepage tracepoint
    
    [ Upstream commit 1241ebeca3f94b417751cb3ff62454cefdac75bc ]
    
    This tracepoint is defined to take an offset in the file, not an
    offset in the folio.
    
    Fixes: 1ac994525b9d ("iomap: Remove pgoff from tracepoints")
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
    Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
    Tested-by: Mike Marshall <hubcap@omnibond.com> # orangefs
    Tested-by: David Howells <dhowells@redhat.com> # afs
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6c51a75d0be6..d020a2e81a24 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -480,7 +480,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
 
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host,
+					folio_pos(folio) + offset, len);
 
 	/*
 	 * If we're invalidating the entire folio, clear the dirty state
