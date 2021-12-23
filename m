Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2731147E045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 09:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbhLWIVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 03:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhLWIVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:21:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BABC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K7c0caqUccsLWxthTQic3oQytvRJY/kJmewHNnTi2ss=; b=lobjFcAuTbUksaQ9vfVe5tYybM
        tORjayBWqmLySjfMF9cjeUcqF4qOO/ihBEkZrN5PnYnSjvGt3Jl09bjBaMBE0uVJ51jZSAyX9bK+p
        /KiV/aD16RZLRKAr3MPDLGNwWMe35lnwsWQpfxLOACoE97t+zhhD9eq7AyBqYRn0i3/qoSDlSr+P6
        E0PRG7h9PBv6Dv6SOpyJqgSXQ/JMp0UPXTAdWyWMhPobqVhIGTUCjbrqDui5drGMsuK5jLSB2cPpU
        mS5delnNJX9TQfNsGHz2RY16wRZkGY/XeVKG9Ws8GuKt6xmBgYvTucxWEXqyrR+WgVFR7XZPw+3Lt
        lQez4OOw==;
Received: from [46.183.103.8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0JLY-00CCPC-1v; Thu, 23 Dec 2021 08:21:08 +0000
Date:   Thu, 23 Dec 2021 09:21:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 29/48] filemap: Use a folio in filemap_map_pages
Message-ID: <YcQxcRhAUTjVMoYz@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-30-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:37AM +0000, Matthew Wilcox (Oracle) wrote:
> Saves 61 bytes due to fewer calls to compound_head().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
