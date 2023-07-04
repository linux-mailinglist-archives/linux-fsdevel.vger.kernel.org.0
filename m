Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3174686F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 06:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDEq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 00:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGDEqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:46:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE498E7A;
        Mon,  3 Jul 2023 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=B4nvX/EnYj+edoXbvhTgiPbMRbiJCRZ7KDWEebyGAWg=; b=zsaxWMEx9PdbhQ+BdmET2A32r2
        rykIJlIQ/2csXBUMiXFlQgVDV/mLf6UQfDnsiOd2fljwzSD8dR6dbiLvcEDT8Vsl28Q+z0OUZOSwm
        qkicqsB5G8buxX5OTnkXhVsD/jFKt8DoDZghbZ7NUWWHR1FT0dFtVXcDuSd4CPevLc9wNuyjkPzx8
        4a5Of9aokHO68U4xTv7yF3Ahii9hrAv33ve/bUifK9UXzPqLD9dbyk/YdUKBTCamTOk+0ZwdcWras
        nzCaM/JIn0Mw7otjuu8r++9vJz8xRJeXDjROWoJebb/TDqvWT7CN16IKuJaSkjc42p8VkWzRjTCqi
        cWUS0KTg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGXw6-00C9DI-0x;
        Tue, 04 Jul 2023 04:46:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] libfs: fix table format warning
Date:   Mon,  3 Jul 2023 21:46:43 -0700
Message-ID: <20230704044643.8622-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the unnecessary colon to make the table formatting correct.
The colons are not needed and this file uses them sometimes and
doesn't at other times. Generally they are not preferred in
documentation tables IMO.

Also extend the table line widths to match the table text.

Fixes: 7a3472ae9614 ("libfs: Add directory operations for stable offsets")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20230704135149.014516c7@canb.auug.org.au/T/#u
Cc: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/locking.rst |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -90,9 +90,9 @@ prototypes::
 locking rules:
 	all may block
 
-==============	=============================================
+==============	==================================================
 ops		i_rwsem(inode)
-==============	=============================================
+==============	==================================================
 lookup:		shared
 create:		exclusive
 link:		exclusive (both)
@@ -116,8 +116,8 @@ atomic_open:	shared (exclusive if O_CREA
 tmpfile:	no
 fileattr_get:	no or exclusive
 fileattr_set:	exclusive
-get_offset_ctx: no
-==============	=============================================
+get_offset_ctx  no
+==============	==================================================
 
 
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
