Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50F738911
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjFUP3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjFUP3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:29:04 -0400
X-Greylist: delayed 386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 08:29:02 PDT
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54B91;
        Wed, 21 Jun 2023 08:29:02 -0700 (PDT)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
        by forward205a.mail.yandex.net (Yandex) with ESMTP id 2BC504727F;
        Wed, 21 Jun 2023 18:22:58 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 32548463C0;
        Wed, 21 Jun 2023 18:22:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UMkSjYADYGk0-nDgmRaci;
        Wed, 21 Jun 2023 18:22:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687360973;
        bh=b93M/kd7RtP0LNT+znv3PSo9p5SOOzFeXYgHQxmwv9I=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=MtTY+abfofItqx+ehR5syVfHqnMfG1FQeD12jGzYQ82kiujSkRSuCeFBB6O8nWzkc
         hVWRs5aMnczR2pQ/T/8cWAlTFji3iAc8pMjYR/6uN48E+Fr1bQ7t+Eph2OTBExkpN7
         rhVfefZq1Nc6+4kX45d6x2hZFyTVvCUY+/wm3XYc=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Stas Sergeev <stsp2@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Stas Sergeev <stsp2@yandex.ru>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH] fcntl.2: document F_UNLCK F_OFD_GETLK extension
Date:   Wed, 21 Jun 2023 20:22:14 +0500
Message-Id: <20230621152214.2720319-4-stsp2@yandex.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621152214.2720319-1-stsp2@yandex.ru>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

F_UNLCK has the special meaning when used as a lock type on input.
It returns the information about any lock found in the specified
region on that particular file descriptor. Locks on other file
descriptors are ignored by F_UNLCK.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org
CC: linux-api@vger.kernel.org

---
 man2/fcntl.2 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 7b5604e3a..e3e3e7b8c 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -604,6 +604,13 @@ then details about one of these locks are returned via
 .IR lock ,
 as described above for
 .BR F_GETLK .
+.B F_UNLCK
+has the special meaning when put into
+.I l_type
+as an input. It returns the information about any lock in the specified
+range on that particular file descriptor. The locks on other file
+descriptors are ignored by
+.BR F_UNLCK .
 .PP
 In the current implementation,
 .\" commit 57b65325fe34ec4c917bc4e555144b4a94d9e1f7
-- 
2.39.2

