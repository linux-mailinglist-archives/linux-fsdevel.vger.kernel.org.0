Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59AE48E00E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiAMWIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 17:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiAMWIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:08:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCAFC061574;
        Thu, 13 Jan 2022 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ObkbUowJj9pU6tYM19V7wYeIf7IaR9PcGIW4/UXvp5Y=; b=myfNmQp4ZFoxoumjDgODhaPx9Z
        BV4TLrLYOBbqxy3tzDdgqugD7fQxJcjKYhKWYCyKRMxFU0dfu7U0N9vJIAkjq2H1A9WQV302MUfmX
        2IJVwSkiHRx4cQE9hdF06SYio2Axk8HjvfA8ocEC88hwtGX4NPfnsYypdXDGEmwySvR7xDfWljVy6
        hPdHjWdjp+t6mg6Uo4NSQmpGviFyTcZ+iovB/ae5lGxY/Sy+fCLkt8FHknmfn72K7MVJqg1DoRE5w
        cYms2ci277dZLR4NaNdlDllnkPhYVQtJ6OY40yQpfZTU7vhI81LeV89JpBtPtUyaDwJCqHFDkOq7p
        SjNV83Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n88Gc-005HEU-9o; Thu, 13 Jan 2022 22:08:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/2] A small folio API enhancement for 5.17
Date:   Thu, 13 Jan 2022 22:08:14 +0000
Message-Id: <20220113220816.1257657-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It turns out I want to use folio_put_refs() in two completely different
places (which would likely be in separate pull requests) for 5.18, and
there's a useful place to use it in 5.17, so I'm planning on sending
Linus a pull request for this pair of patches next week.  The reviews
on patch 1 come from the folio GUP reviews over the last week, but I
doubt I've shown patch 2 to anybody before.

Matthew Wilcox (Oracle) (2):
  mm: Add folio_put_refs()
  filemap: Use folio_put_refs() in filemap_free_folio()

 include/linux/mm.h | 20 ++++++++++++++++++++
 mm/filemap.c       | 10 ++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.33.0

