Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32354A7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 05:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiFNDpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 23:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:45:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A2038BD2;
        Mon, 13 Jun 2022 20:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9A9DB8171F;
        Tue, 14 Jun 2022 03:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3557BC3411B;
        Tue, 14 Jun 2022 03:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655178341;
        bh=E43p/1kIrr7HyaK7jk6FV/lC1nEfSk6tb8CtzMzfw/8=;
        h=From:To:Cc:Subject:Date:From;
        b=r/om+l2Z077ToQOFTNDRjZnjM0v/5agF/NWPdnHMVt9LPw/3AhwK1eybmAhewWfX8
         xuKgUCTGpauyuBrcEOqxqZnE9RKs6O0wzIVoQPUExZXDRJcINW0Vz7KqMhWClDu/rZ
         MYC3vMJ9PPNHRfuTXbeCQZDxubmxi6laVxU0G11AfHVvrdRgS4XKcBICd02dYi/3+2
         sg7iVQ4RF335gqk5nKLY6DP2U65wphOWQOEbfcEqtmF5LcYP1vQA3HNs9kKXjDRkK2
         uhys1pXgWN5DalxrnaHqXRTYc6eml/S5KDaUZ9thFUun+P+QMboDHdI97axO4ufdGV
         cTtlbSeqI074g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [man-pages PATCH] statx.2: correctly document STATX_ALL
Date:   Mon, 13 Jun 2022 20:44:59 -0700
Message-Id: <20220614034459.79889-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since kernel commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
STATX_ALL is deprecated.  It doesn't include STATX_MNT_ID, and it won't
include any future flags.  Update the man page accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man2/statx.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/statx.2 b/man2/statx.2
index a8620be6f..561e64f7b 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -244,8 +244,9 @@ STATX_SIZE	Want stx_size
 STATX_BLOCKS	Want stx_blocks
 STATX_BASIC_STATS	[All of the above]
 STATX_BTIME	Want stx_btime
+STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
+         	This is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
-STATX_ALL	[All currently available fields]
 .TE
 .in
 .PP

base-commit: 756761bf7f23e6fd679d708a1c2d1e94547f4fce
-- 
2.36.1

