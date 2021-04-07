Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5A356200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 05:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDGDiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 23:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhDGDiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:38:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E623C06174A;
        Tue,  6 Apr 2021 20:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zfGn3ZCEYuUX2Zf7T586Kb/7P467f6W2NugI8PaU3MA=; b=uwO6woSxzpLnvc5VAiSrRrX58X
        57Jt16kVTMPztCETXMy9MjChJnEPS15auGf7iBLyOQ6AjNa1QDF1Za1yH+6z8q9aTHxW2/ZitaPk0
        KmOkrVX9UqNuBxjV0DW9wwJ4oGE4YoJL03Jsh2LHmVH+argW9dN/ry1XQ7s+0VmIEwa5z79hNhQ03
        mwxzFD/GxGropZW0P30ax7ihtn6RcPtam1+ZVcQnMsEawXWEovPNuNVA3pJ4nWv02OgZli9/5cSpx
        YjuoWNjuiqFU55eEmfuuaW+j9lhl5NXCy4fxhDlVy4+8OWdcX1ySi4eia0TzlpiNjPEaHAj8TzZy/
        yhcGZApQ==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTz0l-00DptI-Ux; Wed, 07 Apr 2021 03:37:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] vfs: fs_parser: clean up kernel-doc warnings
Date:   Tue,  6 Apr 2021 20:37:43 -0700
Message-Id: <20210407033743.9701-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix kernel-doc notation function arguments to eliminate two
kernel-doc warnings:

fs_parser.c:322: warning: Excess function parameter 'name' description in 'validate_constant_table'
fs_parser.c:367: warning: Function parameter or member 'name' not described in 'fs_validate_description'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fs_parser.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210406.orig/fs/fs_parser.c
+++ linux-next-20210406/fs/fs_parser.c
@@ -310,7 +310,6 @@ EXPORT_SYMBOL(fs_param_is_path);
 #ifdef CONFIG_VALIDATE_FS_PARSER
 /**
  * validate_constant_table - Validate a constant table
- * @name: Name to use in reporting
  * @tbl: The constant table to validate.
  * @tbl_size: The size of the table.
  * @low: The lowest permissible value.
@@ -360,6 +359,7 @@ bool validate_constant_table(const struc
 
 /**
  * fs_validate_description - Validate a parameter description
+ * @name: The parameter name to search for.
  * @desc: The parameter description to validate.
  */
 bool fs_validate_description(const char *name,
