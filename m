Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AAF76A4DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 01:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGaXbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGaXbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713A2FB;
        Mon, 31 Jul 2023 16:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8596135E;
        Mon, 31 Jul 2023 23:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61741C433CB;
        Mon, 31 Jul 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690846292;
        bh=YpimYS7/JiWJ9sUlx73FOpDcr/5hAhkaCEvZwoTqg8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7f0p3ZbbIPxqN+cnCzOLBFfIh3N2zyO1xrKCYs9SRe+1iyiKaDo2FvoeWuDlqqkY
         AsgWSqvKVRKUWFhD3TD76OCrahkPFztLGrP+H0AeByt+6KUVZGDFht1xGdh4FkjoSc
         XbELuDf8jAqYuQEKsBvaeQMUdNAx6gfq6tMUIY0U0HmUawT24apEysSUAN70RLnZ8z
         vtmLSL93ei02YvbmB4sGznaTlVmxWS3p+X1ShJRVJKJn3I/lMjueIBW4xyDH+zgpuW
         2D9e/OrbaJDBxGrBqDDQ+tCVMimRUECgmiwVbe4SGdc5VXH0sQytOT7hSJFqpYmdiu
         GgsGnRJJUCtdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DE949CE109C; Mon, 31 Jul 2023 16:31:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, paulmck@kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH RFC v2 bootconfig 3/3] doc: Add /proc/bootconfig to proc.rst
Date:   Mon, 31 Jul 2023 16:31:30 -0700
Message-Id: <20230731233130.424913-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
MIME-Version: 1.0
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

Add /proc/bootconfig description to Documentation/filesystems/proc.rst.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/filesystems/proc.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c2aee55248a8..4b9e9510a53f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -684,6 +684,7 @@ files are there, and which are missing.
  File         Content
  ============ ===============================================================
  apm          Advanced power management info
+ bootconfig   Kernel command line obtained from boot config	(5.5)
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
  cmdline      Kernel command line, both from bootloader and embedded
-- 
2.40.1

