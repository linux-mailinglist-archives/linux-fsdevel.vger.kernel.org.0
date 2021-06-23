Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE603B15C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFWIY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFWIY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:24:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E4C061574;
        Wed, 23 Jun 2021 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4zYYszFgczvB0o1ozidLhwNX0C+xzpCmOvZSNFXEiY=; b=VD6SIkTGjMly0UbNblIvzdrBS1
        vVl/Uwz/iRCrJxDsv5iNpt1h0pThXIhVEXUQS83Zcwzjm4DM7PNgTb1pstF7l2QagqDpi1ou+jI26
        GzPfhgvXinlUJKAscy+X71MXIdrkrjz1xsbUHzLIKkcf+KGmRP30Vn61SbT003yARpfB4AoRp4gMz
        dQmdhnutiokBxzrBc+9fUupQgEjO/GmFK/0TqYbJ5x1ZG/Q9IzzL5ZLxHbZbMdOBFY3ed7Xs3BoXA
        BmL2zDbRuKwobf+hhWVeVq9IxMEiq4ekkPbkxtnlLy03Vbp20Jy2UEKvgZMN+9KKW74RWY+V6SLZE
        9wIpR2Vw==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy8V-00FClm-EE; Wed, 23 Jun 2021 08:21:39 +0000
Date:   Wed, 23 Jun 2021 10:21:26 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/46] mm/memcg: Convert
 mem_cgroup_track_foreign_dirty_slowpath() to folio
Message-ID: <YNLvBjx3mqXTjj+b@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I wish we could come up with a shorter name for
mem_cgroup_track_foreign_dirty_slowpath somehow..
