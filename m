Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810AA398E9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhFBPcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhFBPcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:32:21 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425EC06174A;
        Wed,  2 Jun 2021 08:30:37 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 602B52E1A11;
        Wed,  2 Jun 2021 18:29:23 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id vhb8q9iysE-TN10Xxjr;
        Wed, 02 Jun 2021 18:29:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647763; bh=Je6JjAG7HYwmlqiLgvCvkf0C8JFJazSDuUXHnSgaC8k=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=V3NWpViDjUbGlY9k/GiKj/ospMfP9z70qEp2rBIQ/1rp80VyXcNvJM8Gq0HQpmzC9
         k/fiz/PgVOa6pYpdEUkXFn3bmR2+AfeaBWYPcrO3oYv7E9RwB0KZBVex24t7OzKwVL
         r5tmgiOmZwH87u0VWK/iRqOfw4jz5eNjOa44RM/0=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TMoi5vbJ;
        Wed, 02 Jun 2021 18:29:22 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 10/10] block: remove unused symbol bio_devname()
Date:   Wed,  2 Jun 2021 18:29:03 +0300
Message-Id: <20210602152903.910190-11-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
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
index a0b4cfdf62a4..d20e658ff16b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -488,8 +488,6 @@ void bio_truncate(struct bio *bio, unsigned new_size);
 void guard_bio_eod(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
 
-extern const char *bio_devname(struct bio *bio, char *buffer);
-
 #define bio_set_dev(bio, bdev) 				\
 do {							\
 	bio_clear_flag(bio, BIO_REMAPPED);		\
-- 
2.25.1

