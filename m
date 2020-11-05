Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BE2A8ABB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 00:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgKEX2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbgKEX2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9BC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2020 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=thgZEfOCH+4gWcPUgVLFul4MikTj/htowuKZ7NMZ53M=; b=v6kApVJY+byocjFXDD1iZ2ZXdh
        8lN7M7mePzvduurjMQMIvSLCgvWEXCFPv8mlttMHI+/SCSZg1YY54q9nMjsKTVOOAOfBjMWi2pfhV
        SbHJfvfEi1BnpPfPqlQRv1K186ABV25LulIOC0NZ99tSIfvX5UrY8ooCCcGuZSZZsGiJKpiyxBcAE
        x7t2ImG3/VeB5PkMRJSnjbUU1IoRsWAAdeMX3rdSM0v7tWuuYcPI5JMt1uPKKEuq72n99lElx7X6s
        yzKDt4pKmRc8ZX4GTDHlmpbBmiP0B8q5nWIi6qJ5UwmP4xn01hUk8hpdng6D3T3tF5QFCmDC/61u8
        i6ttVmxA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaogM-00062U-Dn; Thu, 05 Nov 2020 23:28:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 0/3] bcachefs: Convert to readahead
Date:   Thu,  5 Nov 2020 23:28:36 +0000
Message-Id: <20201105232839.23100-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This version actually passes xfstests as opposed to freezing on
the first time you use readahead like v1 did.  I think there are
further simplifications that can be made, but this works.

Matthew Wilcox (Oracle) (3):
  bcachefs: Convert to readahead
  bcachefs: Remove page_state_init_for_read
  bcachefs: Use attach_page_private and detach_page_private

 fs/bcachefs/fs-io.c | 112 +++++++++-----------------------------------
 fs/bcachefs/fs-io.h |   3 +-
 fs/bcachefs/fs.c    |   2 +-
 3 files changed, 23 insertions(+), 94 deletions(-)

-- 
2.28.0

