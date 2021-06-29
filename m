Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC363B7006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 11:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhF2JWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 05:22:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42238 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhF2JWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:22:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2B3522648;
        Tue, 29 Jun 2021 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624958392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QxwrAufgZF2xHtW9ffDfZZsEtvBCGeowmWxmcFSjC+w=;
        b=wzw6Gy7TY6M2iwIDPn9jEQHY5AEphmPdXGqFRPwHykOeed0EyNpfHmZmnCMWhdr+0yb4ls
        eSTnYzvuk8Hy0VT0Me8Y/T9Lys+y+EN38ByptchCO81JVFC9TgiR4dvi0TFPOEr8IeJF8i
        smnxEkudbjO8VSf1CpYQlYgRK7500Pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624958392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QxwrAufgZF2xHtW9ffDfZZsEtvBCGeowmWxmcFSjC+w=;
        b=LSxLsn1G+uvtIR3z1xZHIk7UeqEtvrynWeTK9tYetUAKDHRBokXc0zXKs+Gb/ZCWyvTE6H
        xiv7nCkx0/QPy2Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6FAAD11906;
        Tue, 29 Jun 2021 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624958392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QxwrAufgZF2xHtW9ffDfZZsEtvBCGeowmWxmcFSjC+w=;
        b=wzw6Gy7TY6M2iwIDPn9jEQHY5AEphmPdXGqFRPwHykOeed0EyNpfHmZmnCMWhdr+0yb4ls
        eSTnYzvuk8Hy0VT0Me8Y/T9Lys+y+EN38ByptchCO81JVFC9TgiR4dvi0TFPOEr8IeJF8i
        smnxEkudbjO8VSf1CpYQlYgRK7500Pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624958392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QxwrAufgZF2xHtW9ffDfZZsEtvBCGeowmWxmcFSjC+w=;
        b=LSxLsn1G+uvtIR3z1xZHIk7UeqEtvrynWeTK9tYetUAKDHRBokXc0zXKs+Gb/ZCWyvTE6H
        xiv7nCkx0/QPy2Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 0ujVGbjl2mANWgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 29 Jun 2021 09:19:52 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/1] MAINTAINERS: Add VFS git tree
Date:   Tue, 29 Jun 2021 11:19:46 +0200
Message-Id: <20210629091946.10215-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8ae6ea3b99fc..fd171968f9dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7040,6 +7040,7 @@ FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 F:	fs/*
 F:	include/linux/fs.h
 F:	include/linux/fs_types.h
-- 
2.32.0

