Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035D73B161B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFWIrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWIrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:47:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F916C061574;
        Wed, 23 Jun 2021 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pGyg3TxGxSwTUf4kKztMzOWHjbCqMVwpOLy612N/GIw=; b=S7/g0HThhEN3YZ4H9tYEmH4O6S
        Q22Ei0sZ5qvVXhEETSVgKXkXjnLwyY6Aq/7rx0XpeYjBfDiCbAxrSS56GjP16MI71JZvbj6y3hFTA
        aT8mQ6WfnBKEdjNgEhi2oXWWSuywoCapUFhUePmUmBlaj5Y91bV8esY0jOH+mFw85tgohMLHIK2Ye
        nTkijeR/AGO8cBHdkSJD1/iUWQNpC3LUgULxWD+pQOXvEpis+KCWvO+TqxyfmMWQ11IfXkdJ+0l2X
        OQuQSVpuA1VWdIBPBY7pGNIxLAsp6A2qZ1eYz2bC6QsqbE4ZtCJTzDT4U8DxzCf2ClJEJ3qaW1+Gr
        CyZ6Mo5Q==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvyUP-00FDwU-5s; Wed, 23 Jun 2021 08:44:13 +0000
Date:   Wed, 23 Jun 2021 10:41:54 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/46] flex_proportions: Allow N events instead of 1
Message-ID: <YNLz0ojo4qB29O52@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-23-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:27PM +0100, Matthew Wilcox (Oracle) wrote:
> When batching events (such as writing back N pages in a single I/O), it
> is better to do one flex_proportion operation instead of N.  There is
> only one caller of __fprop_inc_percpu_max(), and it's the one we're
> going to change in the next patch, so rename it instead of adding a
> compatibility wrapper.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
