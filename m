Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD344A948
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhKIIjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbhKIIjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:39:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605E7C061764;
        Tue,  9 Nov 2021 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zTI8nQ3jMXNTmsVOkP1ahhIhMO162JA8Ib3ozvKtoFI=; b=TNb0MCaAjSQNXLYGlk4Mw7fows
        UJqfC/5+V/6P+j/Dqrs0tUeO7WB1xosjo1YMSs5bjhmURexhUidKy4xxBaMphmXeejatJK1IdYU8Z
        8P7t6zdyLhFTJkTSIThe0sePozzwqwAYDTNzrBrGrFGVIJZjXmf4WLV8m/MWs7QRdTxmNO+6xclR+
        Hv0JIYRgHWLT/duLSunKjGxkUSSyKnyymsuiJ4tEWYrdaCwKOkCIysbbEQ/NbtfT9ieO6FhKRJLWk
        J/HACKmFu0qeAQzfb6no9CJ0sZsJm1Ofu5LYGtqQ53cIv6AAQh+V7N2N0ciX3Xzxa0QSQhRGlBHA1
        OOWuFeaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMcj-0012e4-MD; Tue, 09 Nov 2021 08:36:57 +0000
Date:   Tue, 9 Nov 2021 00:36:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
Message-ID: <YYozKaEXemjKwEar@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:24AM +0000, Matthew Wilcox (Oracle) wrote:
> These architectures do not include asm-generic/cacheflush.h so need
> to declare it themselves.

In mainline mm/util.c implements flush_dcache_folio unless
ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO is set.  So I think you need to
define that for csky and sparc.
