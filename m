Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C047DF58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbhLWHIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346713AbhLWHIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:08:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F03C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IKv0ui6ruBirAmuTxqmkD2OP/TEEgIxucZHEwo26To4=; b=siBPDTIucR41l5ekyKyR2G86Bv
        qzdtnMm/dVKcqjuYFcoFD+CjcUFKB5DRbknFuR6KBus9mokaIb4jrjbT7KlSUPdI4P1DzQNWnWGlm
        wFMq/54dWgxX8yO0o8idIhJ8vOGQZRpAwG/GX0wsyqBkRv3daqMAi634cYFnlbaO1Pr/KacPwxqqS
        wrgvJqhSH1x/Rq/3gSYXwVMoySHeO6tfhtBJoXb1NCkqxQrLPXnMVcSVw+na397dnj/puxtF1hwE2
        /5xdmo7pqlnZt/MGRNzYe4i67OZLW27wtPOv8KXS/iwwIIa9ZJWtbwFIRPtbDUZX+bi5QgpZKhe3m
        OLxmyIKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0ID2-00BxPM-Qi; Thu, 23 Dec 2021 07:08:16 +0000
Date:   Wed, 22 Dec 2021 23:08:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 14/48] filemap: Convert find_get_entry to return a folio
Message-ID: <YcQgYExFZs4NZ6bd@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-15-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:22AM +0000, Matthew Wilcox (Oracle) wrote:
> Convert callers to cope.  Saves 580 bytes of kernel text; all five
> callers are reduced in size.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
