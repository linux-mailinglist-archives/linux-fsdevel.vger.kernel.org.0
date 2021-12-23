Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301BE47DFAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhLWHmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhLWHmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:42:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1577C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1WbIDyvneo6FzdXekP16+AlihuWBwfsSFS6ufT2C0b0=; b=g3m3jdpyk2F65NMQjT8Er5w9pF
        f34+Rhc2WX2tRY1+vwT0HKfQv42pyP0h2JP7JJotAJL9oQBz39A96amHei3SuV0OQlWIXs99qQyGb
        lNhRqeIEwyxQOlIUibeDVifRBfBv/tPLGDWx2Dq5lGlpiCZiho5JkJNtZ7k/ARe3Om4szNFI56G1y
        slaXp0drMKB21PtvQZ/l9PgOaHRIibfpWdo92oBePLoELEH3Q0xGt6c6A7b9XzbFPayTUMXD4y6ys
        Ga/Op1mCxgNofo396TzRMTBMn9tsqXq4bEDVB/h9uDqwAfQKrv5S5umgfAPljBtWWjiSXIM2JpuhB
        yYCpu76A==;
Received: from 089144214178.atnat0023.highway.a1.net ([89.144.214.178] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IjV-00Bz69-3t; Thu, 23 Dec 2021 07:42:00 +0000
Date:   Thu, 23 Dec 2021 08:40:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 27/48] filemap: Convert page_cache_delete_batch to folios
Message-ID: <YcQn4b8EW0iIvpb9@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-28-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:35AM +0000, Matthew Wilcox (Oracle) wrote:
> Saves one call to compound_head() and reduces text size by 15 bytes.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
