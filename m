Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2244283A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 08:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKBHX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhKBHX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:23:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF47C061714;
        Tue,  2 Nov 2021 00:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=tUIdAKmHtSYnBRe9KNwRh3h6zD
        2NzyOY9i6JHaYRDmWpZegFNA63JY69wGtslXHytNUB27NpQzL3QT3rIDXgOc9LxPF84CPpBQUNrgp
        KQCwxTW2/J4yfGgjb24b4DEqrB6z7ftOPiJO2aVk5KWBfIMaxRHxPPsoVBDglnH8weYFaEGYAOhQb
        cWP/Owz9IHXbHwZj7HGjeui6QwSKawzDGVhoAzz+zReMCxNX4JrhRs+kDE+oRcJs72ss8a9ar/Lfy
        ODhZDj10KRj5eu9mw8zpB82rOiYuxori1BWtKX3yrniuCO99YLurQiHRli4BAqtLPnyU9FTCCOwJx
        dhRwPN+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mho6h-000lHT-OR; Tue, 02 Nov 2021 07:21:19 +0000
Date:   Tue, 2 Nov 2021 00:21:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 14/21] iomap: Convert iomap_page_mkwrite to use a folio
Message-ID: <YYDm70FdOO5lp/p7@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101203929.954622-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
