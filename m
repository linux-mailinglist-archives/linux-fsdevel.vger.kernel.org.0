Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C463C70DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhGMNF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhGMNF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:05:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BCC0613DD;
        Tue, 13 Jul 2021 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QTFWZ70fPTxxGEfvpW72iHrISZ3ROumWvX7+BCwkJ0E=; b=WpZY2MwAsMub0Dpyaxn+R4FRAo
        WgnNZJlWVxz5235Wc62HNNBkKgC0R28TaOahiPk8q/dWIx3h1KiplTIONREJFaRDQdKs+aGRZyoNu
        OU9h3YiS2XtS0Cv3S2EGJBjoM3MeKEpXZ9D+NpUz/h0VN/80t1ai8S3AspZs2LXny6NITrT97g+T6
        SSsoraYw1DjXzAZ1fCNugbAbMVv7HTIU1NNDptus1BhndrabfeUR6OxcjAbyTDxK+nAqvmleK+Q+2
        TZdxfMhdz5W0KEQFS2WWI1Yb6EIHkMo1pt81H0JCYZBr3EaKfFf5fTqlWWBQS3i5OUfVhz9CCFwPC
        PHSeeC4Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3I32-0017Jd-Rs; Tue, 13 Jul 2021 13:02:10 +0000
Date:   Tue, 13 Jul 2021 14:02:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v13 15/18] mm/memcg: Add folio_lruvec()
Message-ID: <YO2OzFbjYLjd7WkD@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
 <20210712194551.91920-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712194551.91920-16-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 08:45:48PM +0100, Matthew Wilcox (Oracle) wrote:
> This replaces mem_cgroup_page_lruvec().  All callers converted.

Looks good, especially as it doesn't have much to do with
cgroups except as an implementation detail.  Shouldn't this
function also move out of memcontrol.h eventually?

Reviewed-by: Christoph Hellwig <hch@lst.de>
