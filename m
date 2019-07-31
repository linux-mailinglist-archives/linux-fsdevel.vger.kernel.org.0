Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6FE7CA28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfGaRRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:17:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfGaRRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KaVjUWTTnVdkOk2Zg6cPSfY2fDbbbTfB5zwO5s7DZ4s=; b=spp6+pbvnz834aJ0eeqzIUdla
        6LkY/AxjVqEWXayDIBWYlkJMgNSdt8GGK3rcxtNCitA6xWOhQsfebCrSWviHjrF9WT2yQgOZzfxEN
        /VKiqn3cvhV6zchKXV0AO6jV4GTZIikIdS8L54ILQ3TkmpR8Prsx3pr+bR8P0VArNZQhNeY7mWwaF
        H61ldCoLvU+v3nRQsoxInhNY1zeca5psJ+wB0sfPo7cVM7BCdp0N1BCDaBNrQY/kF4+w/+l4oMxjP
        kHtMmn3rj60gliJ5IDfuWCVEQJ6x3TB1p7rm7jWJilqYIVXrP1O4p/uz+qQesKUUQRHV9p57NcO4a
        idSPZw8lg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hssEN-0005dG-3z; Wed, 31 Jul 2019 17:17:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC 0/2] iomap & xfs support for large pages
Date:   Wed, 31 Jul 2019 10:17:32 -0700
Message-Id: <20190731171734.21601-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Christoph sent me a patch a few months ago called "XFS THP wip".
I've redone it based on current linus tree, plus the page_size() /
compound_nr() / page_shift() patches currently found in -mm.  I fixed
the logic bugs that I noticed in his patch and may have introduced some
of my own.  I have only compile tested this code.

Matthew Wilcox (Oracle) (2):
  iomap: Support large pages
  xfs: Support large pages

 fs/iomap/buffered-io.c | 82 ++++++++++++++++++++++++++----------------
 fs/xfs/xfs_aops.c      | 37 +++++++++----------
 include/linux/iomap.h  |  2 +-
 3 files changed, 72 insertions(+), 49 deletions(-)

-- 
2.20.1

