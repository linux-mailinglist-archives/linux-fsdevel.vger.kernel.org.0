Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B77AC4FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Sep 2023 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIWTvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Sep 2023 15:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIWTvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:51:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7DAB;
        Sat, 23 Sep 2023 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V8TjP83fX1t1uCCFMjF07+NfXsno1RWfHesTfIPCgz4=; b=nOdhIhQ2vQFZ8T+nshOQ6XbE+V
        GYpo0CgkU954FFwbBWsJfFyXHslWVTv0D7aPvHaOFh2RvPlicq3XSGm9nwmY63hSgWVKCY32CVaHC
        5g0d2nNDqzDiv9eYDYpafiZ+N1R3XYhT3DuSpBtg50146FSRLp6+KxME61t5iLlAnwz7B3+y9T6id
        cFZqEQnU1nLniqjeENqGmczaDeXo2umK7yVfb/30chyokpCW3UPDKu0ePx40COfCyWn9AipyWjkdV
        NR9sM3IpFC22Wl0bJeKXM95kESENKb/N0UbCxeRDfWAe9r3+DbE8vwd0U3SW28JYGo7EOEZrnmd97
        tZIzJxJA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qk8fK-00BPAS-02;
        Sat, 23 Sep 2023 19:51:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Glauber Costa <glommer@openvz.org>
Subject: [PATCH] docs: admin-guide: sysctl: fix details of struct dentry_stat_t
Date:   Sat, 23 Sep 2023 12:51:44 -0700
Message-ID: <20230923195144.26043-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit c8c0c239d5ab moved struct dentry_stat_t to fs/dcache.c but
did not update its location in Documentation, so update that now.
Also change each struct member from int to long as done in
commit 3942c07ccf98.

Fixes: c8c0c239d5ab ("fs: move dcache sysctls to its own file")
Fixes: 3942c07ccf98 ("fs: bump inode and dentry counters to long")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Glauber Costa <glommer@openvz.org>
---
 Documentation/admin-guide/sysctl/fs.rst |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff -- a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -42,16 +42,16 @@ pre-allocation or re-sizing of any kerne
 dentry-state
 ------------
 
-This file shows the values in ``struct dentry_stat``, as defined in
-``linux/include/linux/dcache.h``::
+This file shows the values in ``struct dentry_stat_t``, as defined in
+``fs/dcache.c``::
 
   struct dentry_stat_t dentry_stat {
-        int nr_dentry;
-        int nr_unused;
-        int age_limit;         /* age in seconds */
-        int want_pages;        /* pages requested by system */
-        int nr_negative;       /* # of unused negative dentries */
-        int dummy;             /* Reserved for future use */
+        long nr_dentry;
+        long nr_unused;
+        long age_limit;         /* age in seconds */
+        long want_pages;        /* pages requested by system */
+        long nr_negative;       /* # of unused negative dentries */
+        long dummy;             /* Reserved for future use */
   };
 
 Dentries are dynamically allocated and deallocated.
