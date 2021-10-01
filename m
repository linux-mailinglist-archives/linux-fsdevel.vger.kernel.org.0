Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34AB41ED29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354335AbhJAMOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 08:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354311AbhJAMOv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:14:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 510EA619E7;
        Fri,  1 Oct 2021 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633090387;
        bh=pPgxMq0U5wKnAG+FvvoW1f4xApRT3cLSGCNvlB0Q2Vw=;
        h=From:To:Cc:Subject:Date:From;
        b=UW0PeLVxBtyLP/Of2EeRhoDDR8j2UJC1qm1k6K1cbz3ADTitIcLNoPaZp3mS5HyGS
         bzbHoWgunGorrpT/jIx/iUJQoPmcd3lYeSp16Q7+GpXrYlsEvGjNV1CaafQF8e5Qqg
         GPxB6HX8/29sf+UNt0IiqieEuxuLLmm0Uh+XotG/9ofHqVfv8Jko19iUhtJkPCoYL/
         T78iNViMM6+UIEQ03jh9oAsWKLF8DsGfjKnjmt+rNOYbAvFy2kf29zu9xxwHEJc782
         w6+7ccrFYFvyM7cn7ucDRS+o8t/WiSs6mIDkD2CmOhWKb8WEmS5Dgs3kZdA3+njtRZ
         wC0uj2tJaIqeg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     alx.manpages@gmail.com, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] fcntl.2: note that mandatory locking is fully deprecated as of v5.15
Date:   Fri,  1 Oct 2021 08:13:06 -0400
Message-Id: <20211001121306.17339-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/fcntl.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 7b5604e3a699..90e4c4a9f379 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -619,8 +619,8 @@ Because of these bugs,
 and the fact that the feature is believed to be little used,
 since Linux 4.5, mandatory locking has been made an optional feature,
 governed by a configuration option
-.RB ( CONFIG_MANDATORY_FILE_LOCKING ).
-This is an initial step toward removing this feature completely.
+.RB ( CONFIG_MANDATORY_FILE_LOCKING ). This feature is no longer
+supported at all in Linux 5.15 and above.
 .PP
 By default, both traditional (process-associated) and open file description
 record locks are advisory.
-- 
2.31.1

