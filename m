Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE64259653
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgIAQBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbgIAP6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FCC061245;
        Tue,  1 Sep 2020 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=K5eIje+dXHxfLWtnzeoqBqIaTntBT6FnczHUHcmj9NM=; b=BHj68uZerC2AED+VGnjrkLa0Jh
        nsJRW5vm091mrlQN4jasrWRgCM1ySYUPiKOPMQFvHehK/MlKtnHTq4wA553107TmfoWBqjYusFfYX
        hdHxpzv+daxEQOnuXf6LklRx/LX2GKJBoWUUuYJ/y29nMBNvIIiiJqjuYtLUkOMxx5BP8xZfY/Z4A
        CFzRy/RgRKCcS7Au+4o2s+j98ZQ2HjaNhxqv/ZtdIfcmckO7GlAMLvRgJLn00q/4ttYSbN93Dmike
        0zdupPRWnfslW66yg0S9XJuGo14FgsCVoZ5MV+EfsKdkYr2KNA9ctgbrNlF6+GHh2s9ZqbM0SlrKW
        GAfzhSYQ==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fP-0004OY-KR; Tue, 01 Sep 2020 15:57:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] Documentation/filesystems/locking.rst: remove an incorrect sentence
Date:   Tue,  1 Sep 2020 17:57:40 +0200
Message-Id: <20200901155748.2884-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unlock_native_capacity is never called from check_disk_change(), and
while revalidate_disk can be called from it, it can also be called
from two other places at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 64f94a18d97e75..c0f2c7586531b0 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -488,9 +488,6 @@ getgeo:			no
 swap_slot_free_notify:	no	(see below)
 ======================= ===================
 
-unlock_native_capacity and revalidate_disk are called only from
-check_disk_change().
-
 swap_slot_free_notify is called with swap_lock and sometimes the page lock
 held.
 
-- 
2.28.0

