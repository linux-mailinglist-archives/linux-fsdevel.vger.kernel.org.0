Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6969FD0231
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbfJHUfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 16:35:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ErombO4uho8JM5R4Aob5dXslRAGneHZGM8h8lRtDPYs=; b=mHMuJRWYNrVMTQz+9rN5+yTKE
        nlUjS9qvAmMmEgWb6GLZ5EWHdJD6p5Y3aC/0ySSwRJcSPeDi6GansivG1E8nrXulvuwXarVR7O5V6
        QdNtglz5BAxyNbWp+bCc5/O0HA6AhrzwMxGvEt8gHbCRtnbe9tSBJH6O29W8uIUOxzCqs/i6p/1Hv
        r9BWy1fbC/HoEvWRiLRgxojWJhV66GwLDkkFwc9aYNSY7HSvQGu0Nm4KdE9cTeNZfXUmszSKuEz0S
        rggFs7BWlWshT/GmcGE8a7HE9kNp5jx4jrALc4KnfD4KpKT0sOdt2P6V25tUXcka8e82Z2pPOV6Dq
        p3550j2Nw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwCw-00021W-3V; Tue, 08 Oct 2019 20:35:46 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Zach Brown <zab@zabbo.net>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs: fix direct-io.c kernel-doc warning
Message-ID: <97908511-4328-4a56-17fe-f43a1d7aa470@infradead.org>
Date:   Tue, 8 Oct 2019 13:35:44 -0700
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

Fix kernel-doc warning in fs/direct-io.c:

../fs/direct-io.c:258: warning: Excess function parameter 'offset' description in 'dio_complete'

Also, don't mark this function as having kernel-doc notation since
it is not exported.

Fixes: 6d544bb4d901 ("dio: centralize completion in dio_complete()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Zach Brown <zab@zabbo.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/direct-io.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20191008.orig/fs/direct-io.c
+++ linux-next-20191008/fs/direct-io.c
@@ -241,9 +241,8 @@ void dio_warn_stale_pagecache(struct fil
 	}
 }
 
-/**
+/*
  * dio_complete() - called when all DIO BIO I/O has been completed
- * @offset: the byte offset in the file of the completed operation
  *
  * This drops i_dio_count, lets interested parties know that a DIO operation
  * has completed, and calculates the resulting return code for the operation.


