Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB093B16F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWJhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:37:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84848C061574;
        Wed, 23 Jun 2021 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=suFUEnnBh47VEalkyVKQG0DaoortwBc65iKhQ335eJU=; b=reXMzGjqASlZeg0+A0kjQllnUM
        wmLKwGs7f8fPMP5T6uZaQm1KK2Rey6xe5C2uHdx7kHQJoOTYuhMFNMIyf6jhJcbjcXhFu0hJwGx2I
        QSzk1YWzyUVV/Q1RfgaD1J5RVtwsbxQeKU8HiMM6FEpc7M2S0c8l2yvuWr2kcvjwkiCMFFw2Nq07e
        RhD3kyXo/LClIQGApVoznmeT6u8vLhG0rmAKsdoABhsDq2pEwP5kv+hjfHgJh7A8yUFtSMYngFHN0
        96flUldaRLsKA88lFal8G35/JiT9cJ6P5uINkGMsSC3PDH1a+uMoURm/1899iECZKTzWbuLcBMvhu
        ShflwkhA==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzGt-00FGkt-LT; Wed, 23 Jun 2021 09:34:16 +0000
Date:   Wed, 23 Jun 2021 11:32:01 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/46] mm/writeback: Add filemap_dirty_folio()
Message-ID: <YNL/kb3E1miS28of@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-29-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-29-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:33PM +0100, Matthew Wilcox (Oracle) wrote:
> Reimplement __set_page_dirty_nobuffers() as a wrapper around
> filemap_dirty_folio().  This can use a cast to struct folio
> because we know that the ->set_page_dirty address space op
> is always called with a page pointer that happens to also be
> a folio pointer.  Saves 7 bytes of kernel text.

Modulo the cast comment from the last patch this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
