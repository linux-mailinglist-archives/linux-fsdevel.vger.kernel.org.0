Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD87514C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbiD2OJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377154AbiD2OJM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:09:12 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Apr 2022 06:59:14 PDT
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FC5DEB9E
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 06:59:14 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Fri, 29 Apr 2022 13:57:56 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH] docs: Add small intro to idmap examples
Date:   Fri, 29 Apr 2022 15:57:48 +0200
Message-Id: <20220429135748.481301-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reading the documentation, I didn't understand why this list
examples of things that fail without using the mount idmap feature.
It seems pretty pointless and I doubted if I was missing something,
until I finished the examples, the next section and saw the examples
revisited.  After that, it all made sense.

Let's add one small sentence before, so the reader knows where this is
going and why examples that don't might seem relevant are used.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 Documentation/filesystems/idmappings.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index 7a879ec3b6bf..c1db8748389c 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -369,6 +369,11 @@ kernel maps the caller's userspace id down into a kernel id according to the
 caller's idmapping and then maps that kernel id up according to the
 filesystem's idmapping.
 
+Let's see some examples with caller/filesystem idmapping but without mount
+idmappings. This will exhibit some problems we can hit. After that we will
+revisit/reconsider these examples, this time using mount idmappings, to see how
+they can solve the problems we observed before.
+
 Example 1
 ~~~~~~~~~
 
-- 
2.35.1

