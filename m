Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BDE5327B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 12:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiEXKcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 06:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbiEXKcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 06:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963A40910;
        Tue, 24 May 2022 03:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DABF160A2A;
        Tue, 24 May 2022 10:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9503C385AA;
        Tue, 24 May 2022 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653388316;
        bh=XBE2UPj4mf6M8L4Bath0SuXETkQ8FaDwLmUk5rSVXdc=;
        h=From:To:Cc:Subject:Date:From;
        b=sLWRaUGnpbT7yzK+xeEd1V6oKAbiyGZkfBfBjGXprxhUFoYLYwaqSzdWxhHN9f1jx
         cNV/5zgmBNOnI/4Ugc68XfGdr+EXtj3YhUZevaQ3mpWI8gBA0K9nEdSmA0w8FeKh+a
         mV9DbSDbwYmnJS+lD5i+Zm6BTCkCY25EwKtrLHcmvEO0bye1Y5EgWzluP05dQmemlF
         c5G3DWARm1HBtdamWPHE5RexxmmnYfyG9hAPgxKJhlcXdicKsotAHP+Yh3KTCWVeH3
         XNFL7yLipS19Qe5aWfAFLUbo+AzHuR3A5/XBFhNzQf//pqG5lsQxRU/HIOwkdfIxEH
         ueHNSpmJjy1Ig==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chuck.lever@oracle.com
Subject: [PATCH] MAINTAINERS: reciprocal co-maintainership for file locking and nfsd
Date:   Tue, 24 May 2022 06:31:54 -0400
Message-Id: <20220524103154.10827-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chuck has agreed to backstop me as maintainer of the file locking code,
and I'll do the same for him on knfsd.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50eeb7e837b6..397a97913bfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7571,6 +7571,7 @@ F:	include/uapi/scsi/fc/
 
 FILE LOCKING (flock() and fcntl()/lockf())
 M:	Jeff Layton <jlayton@kernel.org>
+M:	Chuck Lever <chuck.lever@oracle.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/fcntl.c
@@ -10653,6 +10654,7 @@ W:	http://kernelnewbies.org/KernelJanitors
 
 KERNEL NFSD, SUNRPC, AND LOCKD SERVERS
 M:	Chuck Lever <chuck.lever@oracle.com>
+M:	Jeff Layton <jlayton@kernel.org>
 L:	linux-nfs@vger.kernel.org
 S:	Supported
 W:	http://nfs.sourceforge.net/
-- 
2.36.1

