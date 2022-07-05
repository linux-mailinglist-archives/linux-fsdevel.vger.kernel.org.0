Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B156769B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiGEShG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 14:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGEShF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25887C32;
        Tue,  5 Jul 2022 11:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6A5619FC;
        Tue,  5 Jul 2022 18:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4196C341C7;
        Tue,  5 Jul 2022 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657046223;
        bh=ob3iVAoGL5gc4y7VwpsWmyUUAfJFEI/t/J8hOryse5A=;
        h=From:To:Cc:Subject:Date:From;
        b=pnkLCuZXQrBoYlX810IWHUAX6v9ss5EDtolYNVz2i78QEUeyQ1JuVzd7cCaBAFNiZ
         tTBK5rj4lRRZGNG4zPnIYtWvMLPZGa3VarmmJ98u2h+LClDErQsE+YN2pZLb2QIEFB
         j47CNrm9gDpuEOpJF/TZWXZFXAaUHV9InDVM3mXYR/1/beoXFLlaaaW6zDsX4JWur3
         p1/Adfg6h8AYLSIRCD63WzXoKQS3DU7nNelMJzqqFRAQS+CmkHn1PObMZk4v8mh3uO
         YryjfrFjkCGj+GPkOrf2uvgxhf4oDnEA5ZyGrVbTmbieY7tkwdBl5CzEp8uvBtkY3F
         X5mp2F3OgBMWQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [man-pages PATCH RESEND] statx.2: correctly document STATX_ALL
Date:   Tue,  5 Jul 2022 11:36:14 -0700
Message-Id: <20220705183614.16786-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
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

From: Eric Biggers <ebiggers@google.com>

Since kernel commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
STATX_ALL is deprecated.  It doesn't include STATX_MNT_ID, and it won't
include any future flags.  Update the man page accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 man2/statx.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/statx.2 b/man2/statx.2
index a8620be6f..561e64f7b 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -244,8 +244,9 @@ STATX_SIZE	Want stx_size
 STATX_BLOCKS	Want stx_blocks
 STATX_BASIC_STATS	[All of the above]
 STATX_BTIME	Want stx_btime
+STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
+         	This is deprecated and should not be used.
 STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
-STATX_ALL	[All currently available fields]
 .TE
 .in
 .PP

base-commit: 88646725187456fad6f17552e96c50c93bd361dc
-- 
2.37.0

