Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79EB3BC94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbfFJTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:41 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39105 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbfFJTOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id n2so6216142vso.6;
        Mon, 10 Jun 2019 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWvHhq8XxQsgdEEkuwdPbUPIjaH98CArgRPaOAub3ak=;
        b=UGM3lu2qIHghbQDu1EsRRuavlODvaP07lY9tARpBwIqOVzP5rUfP+otXPvOH45AbIn
         +q2gvV+wGnZYtNE2MViSJVHRWUI6IhueGI0T5o2nLX+gtRu0Rwf3H7Ky6Gdu7OKzQJmp
         TR9OY7pSkBYQeo3qJix4w/zCPD4tfmlQFHKdEpNokvXY3s8MIgQjcNyBsMxgHuA1Krv2
         9+GYTMwk3XwFdKHF+LbNFHmTqw93AbXVxU972IouXyhmJ+1/c3vyUjn/PLC4IICaQzsR
         Brb3VMHqpYnTTyPFXbvg5yjV5/ctGZgH5oIrdlvkvZeCvWyiWF2IQBICWcH2GIbNOUA0
         +45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWvHhq8XxQsgdEEkuwdPbUPIjaH98CArgRPaOAub3ak=;
        b=tYM6DCtYFl6iYpg+1je3DzC1W20V5wEzVBcam4PO2cLFZ8uRPfONyeHgM/Rj0s7X5+
         3bFhSaBTMAwLn9ERfWrMm/li+n6fQnqAWBj60P89Wod4i1vFXaR4CL/fVOqzd8ZPb1ef
         9GgszwEax5P5pAbgMTX6aYynuWAe4c9o3cFyV8OER5ZWtstKCmVlIBznblySYBuDo83O
         y1tMDqIqD6fdYa6PSqfW9OabQG6dfwVOtP2Je/tetKAW5qY2z0uIbBAH81tD9vHEXiVu
         V83WEoGiq4I0avDEMNfO5+rbrc2rkzXMAoM0FHY8EixPpmEt/+pRsKQoKIsytTj6nLJv
         4x2A==
X-Gm-Message-State: APjAAAWuNPo9mhMmQSN59zCf7+4s9+9ECPGB9DkTmjxNbYEYjsuH7eti
        aSkWqWCE5sn1wSqoS+fmIcToO7Ikzg==
X-Google-Smtp-Source: APXvYqyp9NIqoSDj8Nbh7rQIbCBMQwTNEntUK0tr2oYE/q/t7X0iHO7hy11ayPE3I91sFc8HgJ3JFw==
X-Received: by 2002:a67:f911:: with SMTP id t17mr3355596vsq.128.1560194079062;
        Mon, 10 Jun 2019 12:14:39 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:38 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 08/12] block: Add some exports for bcachefs
Date:   Mon, 10 Jun 2019 15:14:16 -0400
Message-Id: <20190610191420.27007-9-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 716510ecd7..a67aa6e0de 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -958,6 +958,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
@@ -1658,6 +1659,7 @@ void bio_set_pages_dirty(struct bio *bio)
 			set_page_dirty_lock(bvec->bv_page);
 	}
 }
+EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
 
 static void bio_release_pages(struct bio *bio)
 {
@@ -1731,6 +1733,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
+EXPORT_SYMBOL_GPL(bio_check_pages_dirty);
 
 void update_io_ticks(struct hd_struct *part, unsigned long now)
 {
-- 
2.20.1

