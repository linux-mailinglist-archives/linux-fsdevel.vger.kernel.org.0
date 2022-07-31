Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A93585FCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jul 2022 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiGaQYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jul 2022 12:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiGaQYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:24:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C524FD19
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Jul 2022 09:24:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9343754D;
        Sun, 31 Jul 2022 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659284675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p4L9Qkd2gdeZ2TNlApycON4Ljo8qjwPh+92ALTu8HKo=;
        b=0XWZo160rK2giUuYrakJYnU8Vn4sQtj4dfzJv4Gl4GGFa72u/QtKGWOoVQL3eaOM/AR6gI
        pq7BlYiTr1KzKinWb4Frxx7ruysi6WFgcS9b1B7GguU9/UeiLoPNjJXFWVQmLOFkyd0kcZ
        hUscoD0pO4FixE7vNUqO11QEEaChva4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659284675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=p4L9Qkd2gdeZ2TNlApycON4Ljo8qjwPh+92ALTu8HKo=;
        b=5mRATl7iXCJzzAgi2kyejHa2lxGyFlmL8zOc0bQ253ncrxWzq9vj6An1ZiZi1RQNhz1FCq
        E6/WYczyAiMyKLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CADF613416;
        Sun, 31 Jul 2022 16:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mkJ5L8Ks5mICGQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sun, 31 Jul 2022 16:24:34 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Petr Vorel <petr.vorel@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH 1/1] MAINTAINERS: Add Namjae's exfat git tree
Date:   Sun, 31 Jul 2022 18:24:27 +0200
Message-Id: <20220731162427.16362-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Petr Vorel <petr.vorel@gmail.com>

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..0cfde0f3544b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7573,6 +7573,7 @@ M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 F:	fs/exfat/
 
 EXT2 FILE SYSTEM
-- 
2.36.1

