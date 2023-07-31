Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0476A4DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGaXbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 19:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGaXbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399D9D;
        Mon, 31 Jul 2023 16:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC2416134A;
        Mon, 31 Jul 2023 23:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C11C433C7;
        Mon, 31 Jul 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690846292;
        bh=s85dfC0gVX9LRkZN5h09FQbiR2t0JYr2MrKPIlxbVnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+rBgbTUY0UZIQvFwc+M/+SHf9TmnxFH13Z8YWu+NDbQLTPeTxWFlePv7HhNYMHza
         cA1i7W2AyLyQQ4sW/FpuD01ARyra/nEut90ycndCYet/ahqE9uFNLYt3VbrSYln32/
         PATYHIknqclGbRhr7KHahVHmRIsqYYCIkzOOv3Yn20Hh7RW1Yy6ak1SHQfX4VVdEAG
         qefZ108MO80zOudxfXnIFFnaMzCPDyMITpTAtO+HclVc+9D94xdOAjGSZvkTu3bvWz
         icYZIkkyn24jvqw1A5r5RVc8JQa2gGhnVDRA50/2agG+5adJmayO/jTUDzSfJDq2QQ
         7S5faM7jC59Aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D90B2CE1065; Mon, 31 Jul 2023 16:31:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, paulmck@kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH RFC v2 bootconfig 1/3] doc: Update /proc/cmdline documentation to include boot config
Date:   Mon, 31 Jul 2023 16:31:28 -0700
Message-Id: <20230731233130.424913-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the /proc/cmdline documentation to explicitly state that this
file provides kernel boot parameters obtained via boot config from the
kernel image as well as those supplied by the boot loader.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 7897a7dafcbc..75a8c899ebcc 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,7 +686,8 @@ files are there, and which are missing.
  apm          Advanced power management info
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
- cmdline      Kernel command line
+ cmdline      Kernel command line, both from bootloader and embedded
+ 	      in the kernel image.
  cpuinfo      Info about the CPU
  devices      Available devices (block and character)
  dma          Used DMS channels
-- 
2.40.1

