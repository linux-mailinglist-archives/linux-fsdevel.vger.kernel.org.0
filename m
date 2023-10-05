Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E268C7BA7E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJERYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjJERXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:23:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA846AE;
        Thu,  5 Oct 2023 10:17:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84356C433C8;
        Thu,  5 Oct 2023 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696526274;
        bh=dd281u/JTv/R6FmaGl1uLzRwofzwkxCFqbk7yrkrYr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTsWqTsfq+kPIKxVgE9A/E+ADoBxbMda9uH0NMeSYTUmoZkhJ5aA8bZFN2ipYQRap
         6KGadC9r4o/6b2g8JhWHpYGRxRqt4c2dDFyoJowgTaOnlfFHTBlHKNYYzIStoGgk6I
         7wOXykqBJqEceFppYFJZTxw/98pUgrAU1BE+6ysGb7vTi8pKOOFvg+Rf7HWaekNqiy
         wnRfYOvB+mjsO+nPNtKgi+IufB1O4nmYAH+7dpobx4X1+MSOjpyrzibr/6r3KeOBB/
         OA4eSdt7ynQVA7O4FSEdE0q7ukTyZW2lr+GYlQPcMdFUuFhof9o5MXYkai/o4vPsQy
         lOtI5vN+DTocQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1975FCE0976; Thu,  5 Oct 2023 10:17:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bootconfig 3/3] doc: Add /proc/bootconfig to proc.rst
Date:   Thu,  5 Oct 2023 10:17:47 -0700
Message-Id: <20231005171747.541123-3-paulmck@kernel.org>
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

Add /proc/bootconfig description to Documentation/filesystems/proc.rst.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/filesystems/proc.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5703b0e87cbe..a2c160f29632 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -689,6 +689,11 @@ files are there, and which are missing.
  File         Content
  ============ ===============================================================
  apm          Advanced power management info
+ bootconfig   Kernel command line obtained from boot config,
+ 	      and, if there were kernel parameters from the
+	      boot loader, a "# Parameters from bootloader:"
+	      line followed by a line containing those
+	      parameters prefixed by "# ".			(5.5)
  buddyinfo    Kernel memory allocator information (see text)	(2.5)
  bus          Directory containing bus specific information
  cmdline      Kernel command line, both from bootloader and embedded
-- 
2.40.1

