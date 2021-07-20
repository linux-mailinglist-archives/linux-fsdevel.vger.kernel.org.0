Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80703CF8A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhGTK3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbhGTK3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:29:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F32C061574;
        Tue, 20 Jul 2021 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FYa1vrOxhsL4J+dsjH3v2WKh547oNJsLenp0YgNCV9w=; b=W1mvuHw1PFT2PcpbakXqkrY5pU
        ZCm3GD3vmA/BqdD1A1b99KnL2GNlaq504KUjikxyc/L8AjOtX7sMhsvNqXIrsaMJ9CrD8xVV9vy1C
        Td6aQITuPNAJigOZm0BWNCqRJSLUHIUtyADB4kKNlghmHizMqsETiyF8MPV/iS7NtUAXctCqQN+KX
        CNao0V5xI5VDZIpJzYLOCjf7oUkiR1mgE9tR1DA1IWrGvS47V13junRhdNJ6DuF4MflKdq0dMUecl
        Pa45VLzoIgGw8P+83aj6ZmO5G8bHz+sKDDHbr+quEr12eREwLbXUsJY+fGka15IDVvcocbiVGxkyi
        +uOHG7Wg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5ncC-0082Ew-FD; Tue, 20 Jul 2021 11:08:54 +0000
Date:   Tue, 20 Jul 2021 12:08:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 00/17] Folio support in block + iomap layers
Message-ID: <YPauvIzYONsQJxkr@casper.infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <YPaM7IsHKT0tu2Dc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPaM7IsHKT0tu2Dc@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 09:44:28AM +0100, Christoph Hellwig wrote:
> Btw, this seems to miss a Cc to linux-block.

hm?  i see it on linux-block, and so does lore.  maybe vger is being
slow again?

https://lore.kernel.org/linux-block/20210719184001.1750630-1-willy@infradead.org/
