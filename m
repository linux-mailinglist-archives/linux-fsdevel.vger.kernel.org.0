Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A837065E1C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 01:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbjAEAlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240707AbjAEAiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993B2C4D;
        Wed,  4 Jan 2023 16:38:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7985FB8198C;
        Thu,  5 Jan 2023 00:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF63AC4332C;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=uoGgcjGPKW6WOc/kv1zTqKaKBuXUOztQUJ0azz/FjbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mE82tqRjiTJ3LsNUM1pJG7Fd5iOdFe20DdzmxMYspIJIpqnztEbWgIsMeB2Uu+XgP
         imAOCjUHCBenTW19vhpGOW9IVC1l80oqLd4xAYyJBAbkcH55zeAFF75YFwkIDZLBdv
         9CRBNn4LFSoIETi5tP6d0XEN3QqO0X74dxFA1mK1pLR4ahGAKJRc1+WkWdw1sw5pDw
         C9r5ec0M+UaYk9tUNZO8dl5xCRQ2QkdhYAPb60lVegWFn/IWcEq1JkPY1/RuKtrJvt
         Y0pN1D0qzmpvWjMY/IOCLhs7DnZn4w6acwMNXsFyeLCuHY2nARw7rF+Gef0u1mmgzh
         9u9+Hmh4jEI7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DA7AB5C1C9F; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH rcu 20/27] fs/notify: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:38:06 -0800
Message-Id: <20230105003813.1770367-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/notify/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/notify/Kconfig b/fs/notify/Kconfig
index c020d26ba223e..c6c72c90fd253 100644
--- a/fs/notify/Kconfig
+++ b/fs/notify/Kconfig
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config FSNOTIFY
 	def_bool n
-	select SRCU
 
 source "fs/notify/dnotify/Kconfig"
 source "fs/notify/inotify/Kconfig"
-- 
2.31.1.189.g2e36527f23

