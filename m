Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C0D0234
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfJHUgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 16:36:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZlXOPDGdWnZCwluNug0aJjYzAAN0QvHnKg8apMogRTM=; b=qe0vhPeTm79VWLdgH1qc7EyET
        QeoJeGO+azpsOEToTKQ765YKA9PRyC1FLbVcW1iKm3HLABHpMNgCxnWUf4qHnw7yX9PRy/NTm5IXW
        L2tyDC+QHicCpOov5Fa+0mkJGPpAavmFEjZ0IXBjC7MkcBjakXNlc1L18bxfwfaiGaa7OXPB7xwqg
        I4bQgshhhydsVMDfu06dkErEAK+0m8rfIp3FhB/FS2zMjWdMgyuP+/ckQGrPnuJkHdsGvuseH/u4R
        XHZZzwEa829ON0UgF28nua88UanfMfdAvMS/jnpTSgzOYV6q9f/qOm1QhqGR7ECKSdqZhRk8gD+Da
        GC+ldgoYQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHwDJ-00023z-7M; Tue, 08 Oct 2019 20:36:10 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs: fs-writeback.c: fix kernel-doc warning
Message-ID: <756645ac-0ce8-d47e-d30a-04d9e4923a4f@infradead.org>
Date:   Tue, 8 Oct 2019 13:36:08 -0700
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

Fix kernel-doc warning in fs/fs-writeback.c:

../fs/fs-writeback.c:913: warning: Excess function parameter 'nr_pages' description in 'cgroup_writeback_by_id'

Fixes: d62241c7a406 ("writeback, memcg: Implement cgroup_writeback_by_id()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/fs-writeback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20191008.orig/fs/fs-writeback.c
+++ linux-next-20191008/fs/fs-writeback.c
@@ -905,7 +905,7 @@ restart:
  * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
  * @bdi_id: target bdi id
  * @memcg_id: target memcg css id
- * @nr_pages: number of pages to write, 0 for best-effort dirty flushing
+ * @nr: number of pages to write, 0 for best-effort dirty flushing
  * @reason: reason why some writeback work initiated
  * @done: target wb_completion
  *

