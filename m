Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B812C5498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbgKZNG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389873AbgKZNG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:06:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD5FC0617A7;
        Thu, 26 Nov 2020 05:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1+4fu59prkKRojykQDqvT3W9Bijlh50O/kXwJOb/aME=; b=ZWV6LH7GEdGqHLvLjkur8QuLUx
        6DTPcwjuwJwmTtqZBu17E9jYrMVvxknLW/h+G1f1+n7ZI3yB9ZIeIDK3oJkM2YeI7jAGd6/2dQ+EN
        o2hfHA9TQoFx8zvOjztvNVjPx8GWsFxbIJ2lME0gDljvC6aMUkmfZkzZ2SzYY0POT+9s5Jca+rlHS
        TEqycrmW8t5TROrwUU1cPNQzGaOHm+WRr+1fhUPIPUd9mr1Su4PKLUCx3jKFiq1zOUOsViqGD1OEm
        Ldun6cMM/WOhBDyiLooximthVpA4fFxT3jvk9QO7EJKAzSi5eeqgmzN1UBtCj90T8twk1411PaHhx
        naQFEDJg==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGz1-0003yN-95; Thu, 26 Nov 2020 13:06:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/44] block: remove a duplicate __disk_get_part prototype
Date:   Thu, 26 Nov 2020 14:03:48 +0100
Message-Id: <20201126130422.92945-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/genhd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 46553d6d602563..22f5b9fd96f8bf 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -250,7 +250,6 @@ static inline dev_t part_devt(struct hd_struct *part)
 	return part_to_dev(part)->devt;
 }
 
-extern struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
 extern struct hd_struct *disk_get_part(struct gendisk *disk, int partno);
 
 static inline void disk_put_part(struct hd_struct *part)
-- 
2.29.2

