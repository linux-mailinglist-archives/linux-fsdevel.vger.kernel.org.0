Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03283CF4E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbhGTGQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbhGTGQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:16:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB4C061762;
        Mon, 19 Jul 2021 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rUyUFQ8voiyLOL4QgzYUeIKrsbEW2QQn2ilYYWkianA=; b=rOvnEmvZ7GblIoSJKAkkuw2bEe
        0DxT5PoFHTjFhytj8lrzr5hjAB4oIysjmR5NiFWp9rfU4buens6WHV8t4oMs4iagAbj5TxWlsPR0s
        XgyEuE51qqIKEPcXJL0sbuK9S1EAhoW7ZjLiNzObxfIwNxcTz0LxaNm3aVCbQMTMshAkogiNCjh1p
        MP1PhtBxDxwGdrnPqe1AJuXo6Ej9WzQDfhAPZ6reKte885Xmz8DobG23tp0SVc77XxPVSKDoMER8w
        nTaUzvF8eLImwFft6r7eb0xnS+wCe294oC36ulXKcSVxw2PsBNtE0BcGeQQsV6Bl+D86W5TyAttkW
        pgPk967w==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jfM-007qT2-KO; Tue, 20 Jul 2021 06:55:51 +0000
Date:   Tue, 20 Jul 2021 08:55:42 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v15 07/17] iomap: Convert iomap_invalidatepage to use a
 folio
Message-ID: <YPZzbkz1B+S/lGa6@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:51PM +0100, Matthew Wilcox (Oracle) wrote:
> This is an address_space operation, so its argument must remain as a
> struct page, but we can use a folio internally.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
