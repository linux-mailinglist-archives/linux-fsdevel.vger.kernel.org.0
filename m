Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C574746C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 16:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhLNPrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 10:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhLNPru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:47:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD1C061574;
        Tue, 14 Dec 2021 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZNFHZQjTOXyoInxQ8Rw72YQwQcKhBNeR9xhzBXqc+d8=; b=0xC+kpJFNTmPq6U3ipdNM88wOw
        4lGneUDqguN6kksfMMdrtOQhTl7yugQHt5H4m0GikMZlQyAFQ0H59Yo8ROEaqq5Vhm2YgzJzQshLC
        YL0HEnJKcpIfbrOHxi07kZSgyl3m1Hm0kGfuVSZc87L/I6wkSFkHg5MUOYm6LEQd2dpmM1KH5oMr0
        OVsahS5PmS7slhP9/8d0T7O8118Cq3ZqolZzNoHQvSnSWyzWXVUXW0AKGddRMsDhnWkHyZpQuAuKl
        H2Of89G8mqoVrxaUIAyUcCsGp6DGOKqYPndGtdH+lJIZwEBzw+7cfthU7H4LwRZN1cp94cqL8jLcI
        E0h+WNEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxA1u-00Ek7m-DX; Tue, 14 Dec 2021 15:47:50 +0000
Date:   Tue, 14 Dec 2021 07:47:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v8 7/9] dax: add dax holder helper for filesystems
Message-ID: <Ybi8pmieExZbd/Ee@infradead.org>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
 <20211202084856.1285285-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202084856.1285285-8-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:48:54PM +0800, Shiyang Ruan wrote:
> Add these helper functions, and export them for filesystem use.

What is the point of adding these wrappers vs just calling the
underlying functions?
