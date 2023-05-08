Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8926F9F57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 07:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjEHF7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjEHF7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 01:59:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263213854;
        Sun,  7 May 2023 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1dCjcKAEnQ411omHCOVFyvsOwdZaZO9UpsrQTgMf9e0=; b=eydKThLigQoQiMyZT/8tq81SNv
        nIGZonbM26SPCm8H2q/RTyXQlQa48evbD1At0CF6B5ErjHJTrUeOLHTYnszQwQw4Swz7sL2hBtlbu
        wUibt1d0iVdlWNFSJu0FJP9Z2xsvBTDcukFZqIKkXfyMQtiimEPdtDkIknaAOcLj0N4Ee2UdrMBAC
        M0wGVGrfUyzWFlc/5viiI+Oi3B//dNCoVQvSPzByjAHmwe7mnwG72iK4rdGzF1Tqb+7c8nOOo/2XU
        EA5MD9SN8gNTMbMUUhUiy4t6IIMiKH18MMZ5cxrUcwwlfpV+wJFymqJRgv+mTU8vXHOL0PGp1tygE
        P6gUT57Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pvtuC-00HLfV-2y;
        Mon, 08 May 2023 05:59:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Rob Landley <rob@landley.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Documentation/filesystems: ramfs-rootfs-initramfs: use :Author:
Date:   Sun,  7 May 2023 22:59:28 -0700
Message-Id: <20230508055928.3548-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the :Author: markup instead of making it a chapter heading.
This cleans up the table of contents for this file.

Fixes: 7f46a240b0a1 ("[PATCH] ramfs, rootfs, and initramfs docs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/filesystems/ramfs-rootfs-initramfs.rst |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -6,8 +6,7 @@ Ramfs, rootfs and initramfs
 
 October 17, 2005
 
-Rob Landley <rob@landley.net>
-=============================
+:Author: Rob Landley <rob@landley.net>
 
 What is ramfs?
 --------------
