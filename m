Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982F3727E44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbjFHLGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjFHLGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:06:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FC2D7F;
        Thu,  8 Jun 2023 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=POouKGvveG/KhITgHpTZ7KYqo/RAGhaN1xR2Wciupo0=; b=EcIzCKB9dEH30RjdEI/DabgwV/
        6ZE+m+wtvZk6OlgaAm4++oJn5FTLnCIoCYvUSixjcb5vsY48DtbyAF4PDNJ/rUJORL1vNC823Al4U
        VogmIfb6HzJmAK7DP+LO5jRK6FEnbun1AtQpt1pPcF50L3s5FmpYxmyflfpxPuE7q7N0wzfVyrSB8
        mNHn32tzxgxj01b+nT/bN6+F8F6UZG8I0kTELL4n7KxuHYSBQ/GlztYhMGyhnBDpN7FKP/M06AY4h
        ARLvSfsMwWJCnbdIol8AZA7AQ8Dfm329oHy3IynpXfnam/tcuzu3MT53AqEu8DXAUCaDdLeh7/WED
        B7h06UbQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DR5-0092kv-0m;
        Thu, 08 Jun 2023 11:04:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/30] ubd: remove commented out code in ubd_open
Date:   Thu,  8 Jun 2023 13:02:52 +0200
Message-Id: <20230608110258.189493-25-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code has been dead forever, make sure it doesn't show up in code
searches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ubd_kern.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 8b79554968addb..20c1a16199c503 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1170,13 +1170,6 @@ static int ubd_open(struct gendisk *disk, fmode_t mode)
 	}
 	ubd_dev->count++;
 	set_disk_ro(disk, !ubd_dev->openflags.w);
-
-	/* This should no more be needed. And it didn't work anyway to exclude
-	 * read-write remounting of filesystems.*/
-	/*if((mode & FMODE_WRITE) && !ubd_dev->openflags.w){
-	        if(--ubd_dev->count == 0) ubd_close_dev(ubd_dev);
-	        err = -EROFS;
-	}*/
 out:
 	mutex_unlock(&ubd_mutex);
 	return err;
-- 
2.39.2

