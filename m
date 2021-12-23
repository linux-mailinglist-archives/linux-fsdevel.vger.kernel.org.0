Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3090147DF28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhLWGsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWGsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:48:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC7C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t26BzzDsNkIKQOy0wDELJ5VwkpFOuQBUXM56pC3ESiE=; b=Nuaj75WCG9R4bHblQBQE+4drxG
        SmnSEfPePn4JLoz4BjU8UFrDDRwm/kpn62H3OyfNIjfSYrdbMfWog5m7Ka9inOidtUAphtv4UHawh
        wCi787/6UckLxrww7YvvBnAaAdfxomgWEQOnsl+7+DeKNrFeTthb+SRYx1Nm3UuO5f5Cc4UznhlLS
        POUOsBzA64+zL+yaKV1hYJaVToCnSOaSvqeXZn4228IhTEB0dlNyGgh/huUzCZO+oUjTBghnOR/ZY
        Gn1Sz235cqrioiYqRFlweECu9KAM64z4kcFALwykcPIvCx68JKYksuHd72d6DawxHSbsJ0iWJ1gwe
        tpCHOXmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Hto-00BwTd-9X; Thu, 23 Dec 2021 06:48:24 +0000
Date:   Wed, 22 Dec 2021 22:48:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/48] filemap: Remove PageHWPoison check from
 next_uptodate_page()
Message-ID: <YcQbuBlss21ug1PI@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:09AM +0000, Matthew Wilcox (Oracle) wrote:
> Pages are individually marked as suffering from hardware poisoning.
> Checking that the head page is not hardware poisoned doesn't make
> sense; we might be after a subpage.  We check each page individually
> before we use it, so this was an optimisation gone wrong.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
