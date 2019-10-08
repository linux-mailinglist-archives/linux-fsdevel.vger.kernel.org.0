Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A13D0233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfJHUgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 16:36:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oPI82iM1CN95fitETf5b2pJsa8u46nEj7YnKrqWajqQ=; b=pAebMn1pLDePrvf/dH3kvw4EV
        i47HSkWK+CofMC+y3N1mOgIEJW7JGslOTME6meF8T7GUGZZWUgjyA/eQ+vAZqlta79/s7MrdLK2q6
        zJ7jRMYEkE/TEdq+BqNY54q75M2IzTdoAQwClPJyalR7SGHsYeafirnKF/E/s8KQQwNx3Auda8VIN
        rcdAQgnvCDgJmQCXpE2XQO5mY0x0NqFwBz/eoh7K+dGwrd6doEYIcmuvPWSi0yiH1KYHw5My6uiPP
        heaqXf6+K42lmCTGZajOKFaEJZ2M9N4QOaZc/BxMmeucr1qcPHdBIliJCx4+x1UshX/GdoIvOkD5V
        z9r2/rjCA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwD6-00022H-Bd; Tue, 08 Oct 2019 20:35:56 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs: fix libfs.c kernel-doc warning
Message-ID: <5fc9d70b-e377-0ec9-066a-970d49579041@infradead.org>
Date:   Tue, 8 Oct 2019 13:35:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning in fs/libfs.c:

../fs/libfs.c:496: warning: Excess function parameter 'available' description in 'simple_write_end'

Fixes: ad2a722f196d ("libfs: Open code simple_commit_write into only user")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boaz Harrosh <boazh@netapp.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
# mainline

 fs/libfs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20191008.orig/fs/libfs.c
+++ linux-next-20191008/fs/libfs.c
@@ -472,8 +472,7 @@ EXPORT_SYMBOL(simple_write_begin);
 
 /**
  * simple_write_end - .write_end helper for non-block-device FSes
- * @available: See .write_end of address_space_operations
- * @file: 		"
+ * @file: See .write_end of address_space_operations
  * @mapping: 		"
  * @pos: 		"
  * @len: 		"

