Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA81E3B173C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFWJvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhFWJvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC99C061574;
        Wed, 23 Jun 2021 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWWzTz3d/E3f2fGekb7/l0j74niGTy484vF3Xv8Djxk=; b=bdb8xLaT/m4ojaXZ9PF5xjfz3+
        BZZB+x7J5pS7sMfkdWK24JR69AHUQBF9NkNkgdGDj1uvwMsVnsOUMTlRzEdyQtdhL3sRqhMPKD+KS
        GdrkKOjtVVynZJS7JVGEcOU8Kn6l9lEcW+PFA2nOkJiUF08hm3y/6FAmVAiUy+YEnlbi3AaLI1FoF
        c69ERwRPEBfBgONk+eJKb1Dma2g6hdFdjpnrzQKrEj+TC/BDJONBtZ1CPXN1UHc8h2+sfrONvYckd
        jqc9SDrnwrey+UqTySVJo5IcYm/JV40VwApMBYmWtrhCXdyWT9N8nc+lBFbecQ3kOmjFJqPtEVpNo
        oS8/eU+w==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvzUG-00FHWW-0J; Wed, 23 Jun 2021 09:48:08 +0000
Date:   Wed, 23 Jun 2021 11:47:58 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 35/46] mm/filemap: Add folio_mkwrite_check_truncate()
Message-ID: <YNMDTgeHh9/Sfd1/@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-36-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-36-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:40PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mkwrite_check_truncate().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Any reason that page_mkwrite_check_truncate isn't turned into a wrapper?
