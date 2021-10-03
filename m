Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BC42018B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhJCM0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 08:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhJCM0H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 940826187D;
        Sun,  3 Oct 2021 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263860;
        bh=in+tp59oRNFM1nFdN7IzWrPY2+bAk4lxSKywnk+1GYY=;
        h=From:To:Cc:Subject:Date:From;
        b=qw4EObboT027VEzBYxiB4a8ahvObtEHBkAV0I0kNerGmgm0VTAMIY2oLQZzTQ5PZ5
         XXE3HOM8q72bVh7JM0dtaSvhHOGdXJpFm7do1lWnF3hl7GOVkj+dOXUPKVw7KJ7JMP
         tS5m6Pc1xw4WWXM/mrpDVQssnyGOt5kjc9prpROJh3IEVlOEU9wqECHIwD4O7tXyVe
         pYXg3rQlkbdESsSjIGh71g6uNxGk1Z3H5iHahFMpgijwJEve8Z/V6ObCiB0b7cc1ob
         2BDye7EmKPQedE3JtSYDr4MVwE98zcgmUbwN6Bu2gw3fZjxDZEGwivwFUZWvSuf5aE
         O4J1+No17d4rw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     alx.manpages@gmail.com, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] fcntl.2: note that mandatory locking is fully deprecated as of v5.15
Date:   Sun,  3 Oct 2021 08:24:18 -0400
Message-Id: <20211003122418.10765-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/fcntl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: Use semantic newline per Alejandro's suggestion.

diff --git a/man2/fcntl.2 b/man2/fcntl.2
index 7b5604e3a699..4b53a0a2640b 100644
--- a/man2/fcntl.2
+++ b/man2/fcntl.2
@@ -620,7 +620,7 @@ and the fact that the feature is believed to be little used,
 since Linux 4.5, mandatory locking has been made an optional feature,
 governed by a configuration option
 .RB ( CONFIG_MANDATORY_FILE_LOCKING ).
-This is an initial step toward removing this feature completely.
+This feature is no longer supported at all in Linux 5.15 and above.
 .PP
 By default, both traditional (process-associated) and open file description
 record locks are advisory.
-- 
2.31.1

