Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0636371368
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhECKJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhECKJi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8F39AD05;
        Mon,  3 May 2021 10:08:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8809F1F2B6B; Mon,  3 May 2021 12:08:44 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Subject: [PATCH] MAINTAINERS: Add Matthew Bobrowski as a reviewer
Date:   Mon,  3 May 2021 12:08:39 +0200
Message-Id: <20210503100839.17305-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew helps with fanotify already for some time and he'd like to do
more so let's add him as a reviewer.

CC: Matthew Bobrowski <repnop@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

I plan to queue this update of MAINTAINER entry soon.

diff --git a/MAINTAINERS b/MAINTAINERS
index 121b1a12384a..48c6ba6d3191 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6921,6 +6921,7 @@ F:	net/core/failover.c
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
+R:	Matthew Bobrowski <repnop@google.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/notify/fanotify/
-- 
2.26.2

