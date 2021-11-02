Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43C442822
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBHVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhKBHVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:21:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA57CC061714;
        Tue,  2 Nov 2021 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=rYzd+eYGfJ6fsIL1bvrdH+6z6F
        /Z6hBNR00bFAg/rLz2gHbXhdm3JAEzUsgWG31jO2K0nSTgOWi0ssci1a+RwOlzp0S6wqHJUJ4AWJ0
        J1g6G+zSNmkjd2DnMUB7ZOH2Ow9+j+21sI4yaLuR05dnd78ybWcG1INB+M1lURnnEIGNB78ejAhEr
        739s4aA1+dHAXeby8VPPf+BklpAynJLZzjHnCMKZtEvLAvAjmXqeLGfkL6fZVANPO7bIw7vHXtQPS
        6R+TBL73pwKh4R+O72Sd0t41BeNRfySSc59haNnzTZMXG6isL30t2DH4ROw9Z4ezQcCjSjw1/pG54
        UUD4b2zw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho46-000kqt-8b; Tue, 02 Nov 2021 07:18:38 +0000
Date:   Tue, 2 Nov 2021 00:18:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/21] iomap: Convert iomap_read_inline_data to take a
 folio
Message-ID: <YYDmTnpDnN4xgHtC@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-13-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-13-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
