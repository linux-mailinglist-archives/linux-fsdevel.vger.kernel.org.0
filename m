Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4F47DFA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbhLWHhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLWHhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:37:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6527AC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vRuGGVR17Eaw5L4S4jIlNw83rAhhD+mXf4QcgiPDK30=; b=eDhR/Un3pICEbzbmHT2rcsWmg7
        wsNr4QBTO9i9nlJDA3hBTW4xkBbJm7UvcmHIcRG2OfB9uBXPnIHw/AdkyHQqzx9PNKMhzlJXwD8kg
        IDvTcYogcr8NJelAPJxsjc4Tg4nL+lQt32+KMFLJrFJylCGotsX5zGKtq+L0TAfyo0hqCKW/d7GQx
        ygJqJWoplg9ayIbTMku2hVWQ04Bqb69bXLnYHZqogb7w29lpkwigEfoIFB3Pjrk/IwnHWE9Q7FUX/
        oZmE3PJdc0locolaQSbFtKtztsn4QHHu/iv3wRaMZ0fBF4adBH0d1u1YL/6dv1Oqm8qRrvyCfzUy6
        PFts45kw==;
Received: from 089144214178.atnat0023.highway.a1.net ([89.144.214.178] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IfL-00ByhM-2U; Thu, 23 Dec 2021 07:37:33 +0000
Date:   Thu, 23 Dec 2021 08:36:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 33/48] mm: Add unmap_mapping_folio()
Message-ID: <YcQnDZ/Yr5L2otnX@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-34-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-34-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:41AM +0000, Matthew Wilcox (Oracle) wrote:
> Convert both callers of unmap_mapping_page() to call unmap_mapping_folio()
> instead.  Also move zap_details from linux/mm.h to mm/internal.h

In fact it could even move to mm/memory.c as no one needs it outside of
that file. __oom_reap_task_mm always passes a NULL zap_details argument
to unmap_page_range.

Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
