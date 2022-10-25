Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96460C884
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJYJiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiJYJic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:38:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E216339D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 02:36:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31B0521FFA;
        Tue, 25 Oct 2022 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666690598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vPLU5EngDopdc+DIO58uimNXygVU44oYzyV9cK+242o=;
        b=t8DLtS7VTV7F4tQzGc85tnd32CRpjQJ9Hka1mmP3TfgMvjm9TbF9wDmNPB3tieG9kSfbvK
        4Aw7xGzUL4cuJ1GGjmJdkmkk7LX2NuVm/ad2r3TYNtQB1bLXt1lTWkZDoo9v0I1L3nwQqJ
        Ue3arz7vTbSWNmkT8McPUtlBuUIsHBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666690598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vPLU5EngDopdc+DIO58uimNXygVU44oYzyV9cK+242o=;
        b=eAg4WluYLo0t8Irid9JvHCYAI+G2oLrjC/lJOo8nTuH1MQTTI7I/zreb0tIa5T627G0/Ft
        gtWj6gnv0gbb2dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25D21134CA;
        Tue, 25 Oct 2022 09:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UQg5CSauV2MBRAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 25 Oct 2022 09:36:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC79DA06F5; Tue, 25 Oct 2022 11:36:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] maintainers: Add ISOFS entry
Date:   Tue, 25 Oct 2022 11:36:32 +0200
Message-Id: <20221025093632.24315-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We miss ISOFS entry in MAINTAINERS file. Add it and write me as the
maintainer there since ISOFS is pretty low effort these days. Less
random patches for Andrew to merge ;-).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..20667c64dad3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10893,6 +10893,13 @@ F:	drivers/isdn/Makefile
 F:	drivers/isdn/hardware/
 F:	drivers/isdn/mISDN/
 
+ISOFS FILESYSTEM
+M:	Jan Kara <jack@suse.cz>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	Documentation/filesystems/isofs.rst
+F:	fs/isofs/
+
 IT87 HARDWARE MONITORING DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.35.3

