Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879F828EE7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgJOIa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgJOIa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:30:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32DC0613D2;
        Thu, 15 Oct 2020 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=hs1a/HABNkOgSjq8RJYWLVhxyU
        Un6eMycF8/n/oHRlOFfVqDK6y0f1VwnO2ympjgOkpwcO4Q00qbscwRzLBRd8Ii9qo1+/8GCffydqE
        SpHd0yfqOgsnYytKs2FGTDfgvc8zQXK/Tx5mEaBt+PaptvRYUVSbJurB8y1idNn15vBFRnOH/u3ne
        4wJh2iidfySvgxst9OeHEJIyY8hqIWGBTnSQ/N7FkwH1tM3Z0wx0r012aZLyJCQsPgawk1QnGAutb
        vpUhPKC/QAGV0+Lxod55b+v/LkNHNeRQcN/FZslZg7jO6nfYoX0pYiXN5WHE3YPB41ipHzw2LvC+l
        Xz5ibeHA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSyeR-0001TJ-Ub; Thu, 15 Oct 2020 08:30:20 +0000
Date:   Thu, 15 Oct 2020 09:30:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        willy@infradead.org, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 1/2] mm: Add become_kswapd and restore_kswapd
Message-ID: <20201015083019.GE4450@infradead.org>
References: <20201009125127.37435-1-laoar.shao@gmail.com>
 <20201009125127.37435-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009125127.37435-2-laoar.shao@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
