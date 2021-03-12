Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BE338950
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhCLJ4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhCLJzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:55:47 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA00C061761;
        Fri, 12 Mar 2021 01:55:46 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lKeW1-00F7m8-Ug; Fri, 12 Mar 2021 10:55:30 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/6] .gitignore: also ignore gcda files
Date:   Fri, 12 Mar 2021 10:55:23 +0100
Message-Id: <20210312104627.77a4bc149381.I4f7b3002fa9ef4a168fca1f7952a277b52cae695@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312095526.197739-1-johannes@sipsolutions.net>
References: <20210312095526.197739-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We already ignore gcno files that are created by the compiler
at build time for -ftest-coverage. However, with ARCH=um it's
possible to select CONFIG_GCOV which actually has the kernel
binary write out gcda files (rather than have them in debugfs
like CONFIG_GCOV_KERNEL does), so an in-tree build can create
them. Ignore them so the tree doesn't look dirty for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 3af66272d6f1..91e46190d418 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@
 *.dwo
 *.elf
 *.gcno
+*.gcda
 *.gz
 *.i
 *.ko
-- 
2.29.2

