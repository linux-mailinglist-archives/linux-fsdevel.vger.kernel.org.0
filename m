Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0904D45EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfJKQ5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:57:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40569 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfJKQ5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:57:13 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIyDz-0002Hx-WA; Fri, 11 Oct 2019 17:57:08 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIyDz-00044Y-Mc; Fri, 11 Oct 2019 17:57:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nsfs: include <linux/proc_fs.h> for open_related_ns
Date:   Fri, 11 Oct 2019 17:57:06 +0100
Message-Id: <20191011165706.15608-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011165706.15608-1-ben.dooks@codethink.co.uk>
References: <20191011165706.15608-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Include <linux/proc_fs.h> for the definition of open_related_ns.
Fixes the following sparse warning:

fs/nsfs.c:145:5: warning: symbol 'open_related_ns' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ea384d0f225a..3e1c6ce9deae 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -4,6 +4,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/proc_ns.h>
+#include <linux/proc_fs.h>
 #include <linux/magic.h>
 #include <linux/ktime.h>
 #include <linux/seq_file.h>
-- 
2.23.0

