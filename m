Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2B44A989
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbhKIIqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbhKIIqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:46:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53EDC061764;
        Tue,  9 Nov 2021 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QQtAGYhEi8Xd6U0JV0ZtAK0tw8NuZjQp+BlUK4dpco4=; b=B0sU9h8+G9lJVAR4u+CJM3YPti
        lx29/t9S1UcMT/sSdUWDMLRwvL+A8m0BR6k8L/lpdtcdv5e+RoXlfLEUReexYeagAEA4DL8WFksj7
        /ebRuoMg5lc1lB+rYY9BCFZueWerjkviylrlcUYGkmj5a0d7uHqmriCWFyMaz++fNYavXmct3KxaS
        uBr5NwLu9XX8FOj1arHZvd/6cjFlGuCV0u36S903yQ3ecLZ7VGXwmPFAcyjVVYaK9vkm6xX2RQZFd
        yN5Ic1zZicRv5VvbYpZs0u06Vt55j3cTG6gvAQfQakI89WTfdLMVzlpqy5axnDRuvAofPpjuzS86J
        PF6LSZiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMio-0014Bg-OV; Tue, 09 Nov 2021 08:43:14 +0000
Date:   Tue, 9 Nov 2021 00:43:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 17/28] iomap: Convert readahead and readpage to use a
 folio
Message-ID: <YYo0oi/iOzSTVrj2@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:40AM +0000, Matthew Wilcox (Oracle) wrote:
> Handle folios of arbitrary size instead of working in PAGE_SIZE units.
> readahead_folio() decreases the page refcount for you, so this is not
> quite a mechanical change.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

