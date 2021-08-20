Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795A3F3259
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 19:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhHTRhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhHTRhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:37:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1EEC061575;
        Fri, 20 Aug 2021 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nwh62SeI7xlRBglEnBofl49VAYlpQ0bGiEPuAp9bi2g=; b=Ka7uOOzdBSWX6Yc5odX/K4txXA
        q+CTmyT9Ts1dNvvH/pCdhTC6bV0Yp4Q6417twThVVtlBe5uni8nURxuUeQBnn7iGqf8IHruCMoQQl
        tQTo1v7MnZTFu8WaRXy4E1kr/+wC0gINjlAoy+g1eUgAaiqhuVyNcXX+UNUJ8GG64a6n2rFHKf/Cd
        wRA9CjfneKGnwzV10RROcF5SuF4Q4JvPQlBUrWm2gUc/Qv9wfZZPhtfjzzNlzXG2Z4A8ahl83EDRB
        26GhYQ86QTYzPOlB4hIzmMzon57LdGXW67GPcr2fFStd7Fz6jIQztgADnh3TOyb0CkkHP5tM7VAzc
        0TsOW8xg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH8Qd-006nLA-O1; Fri, 20 Aug 2021 17:35:50 +0000
Date:   Fri, 20 Aug 2021 18:35:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Export PageHeadHuge()
Message-ID: <YR/n6zxxnfNp/tBk@infradead.org>
References: <162947608701.760537.640097323184606750.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162947608701.760537.640097323184606750.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 05:14:47PM +0100, David Howells wrote:
> Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
> folio_file_page() and folio_contains().

.. none of which are used in modular code in linux-next.
