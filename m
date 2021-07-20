Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A53CF4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhGTGK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhGTGKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:10:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF9C061574;
        Mon, 19 Jul 2021 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x2yTm/DqDIfqPMvkKIOtJxJ8p13cI0qfPpu6o0hMD1k=; b=HOGaACrEQvhORb6IlD+mh9ZlA3
        NgxbMGmLQBlDiZtt+ZxGf8VXp5r/HRGOcwiyQyMT/tx32W4TOrrqI0RWUNfcRe9laE5yAQ+wLySLX
        tHnIfFBU/8pSJl63aIjfnGPeFUZtFL5+3dofs3a5XYw9+IMgfgNbYnlmwt4h7CrNkO6Oxah8EjTrk
        uoe/kwV9bH4gJ336xFrlzQqeOYLEKmT+n2Fs9URyNHBg8fM6/I2Cybj9Rbn6xiJWdRZiNeQjgwMVY
        //UyIMOaoBsJzNAy0ITTkht9NznF/8Ur0i8k2JmPwK/XW9cuK/pD1pml7qPJKqxJNhUBwOh9CjZ/F
        rFT3TSYA==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5jaG-007qBP-RH; Tue, 20 Jul 2021 06:50:33 +0000
Date:   Tue, 20 Jul 2021 08:50:27 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v15 04/17] iomap: Convert iomap_page_create to take a
 folio
Message-ID: <YPZyM773p3cq97Pr@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
 <20210719184001.1750630-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719184001.1750630-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 07:39:48PM +0100, Matthew Wilcox (Oracle) wrote:
> This function already assumed it was being passed a head page, so
> just formalise that.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
