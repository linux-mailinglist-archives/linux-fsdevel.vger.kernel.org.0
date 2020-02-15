Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3315FBEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 02:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBOBPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 20:15:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBOBPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLBAYvHDyQG068qFXc4PKikpMZL0O5lvrEMnkVr84hY=; b=pp4+jYrdtIiCu1ZmQd3UA6AYr/
        85A+NhPrb4RLR40lY3uBj4FXFTAWs54cubURwUY781EoXTIC1BHmzzNCBvBY8CryBQxMU/K9kCyDD
        Uej9VEruUNuHLfKPM4kfSaYvl7cRuRpvE6a4DUQXDHXn67rTy5ieMKlxLHoaPREJTum8bIQ9MN9Gw
        zdza5RTyE51eZi3yeNdHM+vbtFO0NAVQHI+/F7pxpuo7utWxpPvSsEQWVwOfY7b3Djjfu7uYZbJKq
        pEcZMax/EA/FGJvJyodBK0tcSq1rmhd9c8O3RFfEaCuHnm/yRy6hPamomhAD6zwSpAIRbrf8oTm28
        VPquc2zA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2m3k-00083J-V5; Sat, 15 Feb 2020 01:15:52 +0000
Date:   Fri, 14 Feb 2020 17:15:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 03/13] mm: Put readahead pages in cache earlier
Message-ID: <20200215011552.GE7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-4-willy@infradead.org>
 <b0cdd7b4-e103-a884-d8f7-2378905f7b3b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cdd7b4-e103-a884-d8f7-2378905f7b3b@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 07:36:38PM -0800, John Hubbard wrote:
> I see two distinct things happening in this patch, and I think they want to each be
> in their own patch:
> 
> 1) A significant refactoring of the page loop, and
> 
> 2) Changing the place where the page is added to the page cache. (Only this one is 
>    mentioned in the commit description.)
> 
> We'll be more likely to spot any errors if these are teased apart.

Thanks.  I ended up splitting this patch into three, each hopefully
easier to understand.
