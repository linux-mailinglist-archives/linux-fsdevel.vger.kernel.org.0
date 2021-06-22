Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5995F3B0DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFVT5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFVT5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:57:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40AC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 12:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kDvRdN9AuDwpYemr/zHFFc14vxjMOVAmwIvOyfUwgG8=; b=SXDhpaITZRKRNFUhG+fg7yyWbQ
        fHhxmKx8YtbKJNeOIfiQJmqbY2RJsbo/sxJ3t5/piZuvBRr8Vo6XexYixkECJ93921ZfidkAqljw8
        w1tIV/fev91LFkjAOq2dTtyebzXU8JIV8CWm7+h0F4G/FgzUSTyxra0frMotaZGnkBNjDbuTqQslU
        2CKT6dWDh/lzIn4y+n4UFS9BpGF9/5WrX9IzEZCWOykuMEu8Ohml/8q9cYNFModlBSqYjyczpbikN
        yg+PaGMndduai52UMk8YWU5Yiz9edVWDv1CzFd+EcdGYy/eib5otwIvIaYNx4AgZA43sd3emhQ5f+
        a3LRZ5hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvmUK-00EghN-C8; Tue, 22 Jun 2021 19:55:20 +0000
Date:   Tue, 22 Jun 2021 20:55:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Jens Axboe :" <axboe@kernel.dk>
Subject: Re: [PATCH] vfs: explicitly include fileattr.h dependency
Message-ID: <YNJAIJpRULVl5Ayr@casper.infradead.org>
References: <20210622194300.2617430-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622194300.2617430-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 12:43:00PM -0700, Keith Busch wrote:
> linux/fileattr.h has an implicit requirement that linux/fs.h be included
> first. Make that dependency explicit.
> 
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jens Axboe: <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
