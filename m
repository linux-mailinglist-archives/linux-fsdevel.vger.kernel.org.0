Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916A73B1576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFWINC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWINC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:13:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F8C061574;
        Wed, 23 Jun 2021 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tn5mUoclSL67o5mAEW0wcfdSB+Yyi6BBic5gI2QIlu8=; b=bnvaG1qWKGboRvs5pGdlaCa/Hi
        8OiHPiDmEL4zhG82gowXftEqM0hW9oK7aXBuGXJki9EhNlbzPM5leP4yExpT+bAmfmBHBx01JZWMV
        PhHTJSgKoz3D2Ttan036ysf57ljixKvvJwIOODMTufqJr3dOIKwkVX/mP4ksQHNkTfRrhswV8eafm
        zw/jyNlVxXr+KYHExL5wOtPS8H/xvXm/9Feu4nnSeG8eRnvC7oBibI/s+PrZM30U/INSSGWRmvBhR
        wfYuDRxvw8+8njdC0IBRw3bGkmOR73yx3rcvAN8GrhEIB5dSkSTwKjtpl9glYUDFKxlWqkiPmLpdN
        9JmarJmQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvxwl-00FC27-7l; Wed, 23 Jun 2021 08:09:37 +0000
Date:   Wed, 23 Jun 2021 10:09:18 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/46] mm/memcg: Remove 'page' parameter to
 mem_cgroup_charge_statistics()
Message-ID: <YNLsLicAmEPZGamx@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-12-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:16PM +0100, Matthew Wilcox (Oracle) wrote:
> The last use of 'page' was removed by commit 468c398233da ("mm:
> memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
> the parameter from the function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
