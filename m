Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43EA47E051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347106AbhLWIW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbhLWIWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:22:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349EFC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BcnYe9upZJd7+xDxx6trjufVArgGy6tQ3GuBTOq5LBs=; b=pMHyw5rpJyIu612nmI7apjRSeP
        tc1bUjrkJBMhuZHGQX8xT4V89SXr5rZUu7/FZwXMhDm9VVMDwjeDERY18FctrE9xVjAmX8van8Lwu
        JkazipqX0lX9fNeAayIsFB8rEuH8WVvtG2yiTrA04WedNzG5FIhGUEP9YGGjmoEd277r1xEKY/UxC
        Q6A59V3YH5e8qJeJFLX6JbTB8O/q+VhybEbcUkoz+qs+slu8tSb6EvD5EGAABoCgA8DsgMKmE8jMX
        ZmWI5fssrWN2zaizx0g3HDbiQEuomoFhpu0BKO1JKOxqT/AiqnUhk4bX/cFQOP88PFsJ5wXMRYbd5
        LIfW9gHg==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JMm-00CCsS-8U; Thu, 23 Dec 2021 08:22:24 +0000
Date:   Thu, 23 Dec 2021 09:22:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 42/48] mm: Convert find_lock_entries() to use a
 folio_batch
Message-ID: <YcQxvbuQP3LuhEDz@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-43-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-43-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good (modulo the include chain thing):

Reviewed-by: Christoph Hellwig <hch@lst.de>
