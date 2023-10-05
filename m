Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59807BA7DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJERYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjJERXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:23:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C390C3C11;
        Thu,  5 Oct 2023 10:17:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CF9C433C8;
        Thu,  5 Oct 2023 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526269;
        bh=M0TvMEEC0UkMcAlSj1zsQkX0mGMTYLQ+X6r3nS6NweY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVEF7H0nkibHxARzVD/nXBIu6ArBL5iFtEu7rnBLlPxHD2K3MAqRj48fJkmcSH6aJ
         gDBRevessxNx1OI5B8UOCpMl0ImASgVrv6dyqH+BdiV5Bw7TRCCtA6lqHfKL/tjpqp
         6SfZBx47ZPt/CFWSM7ldEvhwoKozZ9yFcXrUHUnZdcg+uxNz3+Ii63RKz5UfavzPue
         3AOueAT+osDfYj4ewBfwKvlILqMSiTLtyM9NwOE7JS73M36ifzafG6I4qnQAcTS1Z4
         P2JWXvhnfYLvBA+Tr9wDOo+AxtUG7t7A6przoESj4fEAq7JPr4zU+V95nFttXIrH48
         odOxsKJf8ORqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 135D3CE0869; Thu,  5 Oct 2023 10:17:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH bootconfig 1/3] doc: Update /proc/cmdline documentation to include boot config
Date:   Thu,  5 Oct 2023 10:17:45 -0700
Message-Id: <20231005171747.541123-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update the /proc/cmdline documentation to explicitly state that this
file provides kernel boot parameters obtained via boot config from the
kernel image as well as those supplied by the boot loader.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@kernel.org>
---
 Documentation/filesystems/proc.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2b59cff8be17..5703b0e87cbe 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -691,7 +691,8 @@ files are there, and which are missing.
  apm          Advanced power management info
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
- cmdline      Kernel command line
+ cmdline      Kernel command line, both from bootloader and embedded
+ 	      in the kernel image
  cpuinfo      Info about the CPU
  devices      Available devices (block and character)
  dma          Used DMS channels
-- 
2.40.1

