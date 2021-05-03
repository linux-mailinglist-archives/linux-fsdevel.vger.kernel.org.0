Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F31371370
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhECKNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:13:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233062AbhECKNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CAF9CB2A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 10:12:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E1B001F2B6F; Mon,  3 May 2021 12:12:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] udf: Remove unused declaration
Date:   Mon,  3 May 2021 12:12:29 +0200
Message-Id: <20210503101237.17576-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210503100931.5127-1-jack@suse.cz>
References: <20210503100931.5127-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove declaration of struct virtualAllocationTable15. It is unused.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/osta_udf.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
index 22bc4fb2feb9..1c83aeede52e 100644
--- a/fs/udf/osta_udf.h
+++ b/fs/udf/osta_udf.h
@@ -178,15 +178,6 @@ struct metadataPartitionMap {
 	uint8_t		reserved2[5];
 } __packed;
 
-/* Virtual Allocation Table (UDF 1.5 2.2.10) */
-struct virtualAllocationTable15 {
-	__le32		vatEntry[0];
-	struct regid	vatIdent;
-	__le32		previousVATICBLoc;
-} __packed;
-
-#define ICBTAG_FILE_TYPE_VAT15		0x00U
-
 /* Virtual Allocation Table (UDF 2.60 2.2.11) */
 struct virtualAllocationTable20 {
 	__le16		lengthHeader;
-- 
2.26.2

