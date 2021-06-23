Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA33B1584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFWIQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFWIQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:16:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CDDC061574;
        Wed, 23 Jun 2021 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UFLOn37BVD0dha7t28OCu5BqNs533BGxbwrSqZ8cBtk=; b=VHdo6rdDdWzjURWo4Sx3oEEP7l
        yv9P+jAVCDuGFujNamF/q4HuNrwd4g3+3yrnbu2Nf3rrcpeCAm2+SynClSMuyv4WC1eP0FNR9DbTn
        PetTqRIJTV7HVZVIPPHHewba0qv0pmu9h6hYVT7+3bhyZ8iw2vDPBph2KxhcqGvhBj3KNIddg5/Im
        L5dd901+wVdU+3xUxCrxXjS4v2gy4ruft0fErAGteBDkLDO5IDy49h9wyQ4AtfPgEFIpAUXV2WjR4
        ftlHCz9GXqbkqwOw+h4MeuTVEgo1NhSH8EjCaY4TmgX/Wg2GNaDwTDpfpbyQc7WdCNMFSDF4nZEIl
        Vpyn2K9g==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy0s-00FCGO-Oa; Wed, 23 Jun 2021 08:13:42 +0000
Date:   Wed, 23 Jun 2021 10:13:33 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/46] mm/memcg: Convert commit_charge() to take a
 folio
Message-ID: <YNLtLa3Wp9IsH1RA@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:18PM +0100, Matthew Wilcox (Oracle) wrote:
> The memcg_data is only set on the head page, so enforce that by
> typing it as a folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
