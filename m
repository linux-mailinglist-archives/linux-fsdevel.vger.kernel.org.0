Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873613057BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 11:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhA0KEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S316784AbhAZXJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:09:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704AC061574;
        Tue, 26 Jan 2021 15:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=y5GH5/INyOBYDQ0PQ+MjQ5G7czP55YrI15equg5lKBM=; b=WB4I/Ivtfdn740+LicDwFXoakl
        28apnJDDF394Bwd+0UGFs9+Pwk9OhyDcdhNiX4CGVATjZRXRwujLslBNQSfKRWcmMYA+HF+v1qSdt
        GGgypm3HOSu8rPjZSDlxPzQK2vIcvvd+i0U1sshjQgbPuZryewgVv9wWVbbOBai4JQjiG7dBMEcsA
        otzVRooXfExepGg3KA/9Jpz3YWnM9uO0eHjZm2IZ9vxtQhwZbMaUFauJ/1A39u3yqEiKIljYyjwsS
        5qMWWp7Qoy+O8ty479ZXDa+73LwGsOX+JHWaLYcrwNB+Rh6H3NtNFLNg+yqFLsJO8fr9T6MKXrMsk
        sJaUdvWQ==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4XSQ-0007iB-Fn; Tue, 26 Jan 2021 23:09:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RESEND] asm-generic: fcntl: drop a repeated word
Date:   Tue, 26 Jan 2021 15:09:01 -0800
Message-Id: <20210126230901.22265-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
Add Arnd to Cc: and resend.

 include/uapi/asm-generic/fcntl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/asm-generic/fcntl.h
+++ linux-next-20200714/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
