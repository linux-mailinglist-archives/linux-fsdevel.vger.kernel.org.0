Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588BE218C59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgGHP6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbgGHP6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:58:41 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D85DC061A0B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 08:58:41 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7D40BBC06F;
        Wed,  8 Jul 2020 15:58:37 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: UNICODE SUBSYSTEM
Date:   Wed,  8 Jul 2020 17:58:31 +0200
Message-Id: <20200708155831.15102-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 fs/unicode/mkutf8data.c | 2 +-
 fs/unicode/utf8-norm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index ff2025ac5a32..33b76cbb3db3 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -244,7 +244,7 @@ utf8trie_t *nfdicf;
  * The shortest sequence requirement was introduced by:
  *    Corrigendum #1: UTF-8 Shortest Form
  * It can be found here:
- *    http://www.unicode.org/versions/corrigendum1.html
+ *    https://www.unicode.org/versions/corrigendum1.html
  *
  */
 
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 1d2d2e5b906a..7978d2b3634c 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(utf8version_latest);
  * The shortest sequence requirement was introduced by:
  *    Corrigendum #1: UTF-8 Shortest Form
  * It can be found here:
- *    http://www.unicode.org/versions/corrigendum1.html
+ *    https://www.unicode.org/versions/corrigendum1.html
  *
  */
 
-- 
2.27.0

