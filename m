Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7765C3B0BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhFVRsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhFVRsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:48:09 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EDC06175F;
        Tue, 22 Jun 2021 10:45:46 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2DE052E1A85;
        Tue, 22 Jun 2021 20:45:45 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id fTGXKtoGXc-jgRG91kJ;
        Tue, 22 Jun 2021 20:45:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1624383945; bh=D5FdBs7hiLx6N/l+Kg941H9511zh48w07aCqgmvPoKA=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=xtmRdqGARnsVzdgZWe0yJJzRJlQ59jcBATOqCv9sGQsT1PSNlTh2dQXNcEWXFO5rD
         4velSx8pe3SYAZMuNb4/u2+RlOjDZx0RLuWMjKuMB9CKu2CII57zClgkgyKEK2qIA8
         ZgDe4yI+kmux9j1NzevKgXZdLdl8+hTjoC1T+jkY=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 7QtSYYEtH8-jgNKe9pb;
        Tue, 22 Jun 2021 20:45:42 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     willy@infradead.org
Cc:     dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, warwish@yandex-team.ru
Subject: [PATCH v2 10/10] block: remove unused symbol bio_devname()
Date:   Tue, 22 Jun 2021 20:45:30 +0300
Message-Id: <20210622174530.137161-1-warwish@yandex-team.ru>
In-Reply-To: <YLe9eDbG2c/rVjyu@casper.infradead.org>
References: <YLe9eDbG2c/rVjyu@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch removes not used any more bio_devname() symbol.
It should be only applied after all other patches in the series applied.

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 block/bio.c         | 6 ------
 include/linux/bio.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44205dfb6b60..8674f9a4e527 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -684,12 +684,6 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-const char *bio_devname(struct bio *bio, char *buf)
-{
-	return bdevname(bio->bi_bdev, buf);
-}
-EXPORT_SYMBOL(bio_devname);
-
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d2b98efb5cc5..835933a175e0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,8 +484,6 @@ void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
 
-extern const char *bio_devname(struct bio *bio, char *buffer);
-
 #define bio_set_dev(bio, bdev) 				\
 do {							\
 	bio_clear_flag(bio, BIO_REMAPPED);		\
-- 
2.25.1

