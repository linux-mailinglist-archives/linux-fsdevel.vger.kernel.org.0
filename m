Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1E3B15BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWIXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:23:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5612C061574;
        Wed, 23 Jun 2021 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lupc2K9WWLP7yjyLXhXKGqDnyOWZO98xG9W27Gok5W4=; b=iHGbBdJKjLkIsMxIln1XNGJQ+g
        lFAFu+9uJeDCHKOQQ4rhmm36ayxese6yudLpoT+qg84nTqLDKR43ZrghiKD/qWL8pdP1xVZ6a/dp2
        pqdXSwRtazxnzBE9uw0y/wDMWdm+29stKzTeib78W9gqXPm+/LeW6pZF9iD8neIR/Jug8n0a0+O0a
        b7vl5HTE5gLiU9r3R7aai0IIX+sJkFywq/fsaA58D5dg1HUwOIqxn/4SCxZmTCJ6gWcKJir6vVzSI
        llkoH7ICcg+EPMlN5bGSuyQ/OLy7TmgfwCKQTGIEUtjIKEQ3NehCh3bcuI7rD8GqfslvmPeD9vpgb
        LnAQGIfQ==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvy6T-00FCbA-S5; Wed, 23 Jun 2021 08:19:40 +0000
Date:   Wed, 23 Jun 2021 10:19:20 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/46] mm/memcg: Add folio_migrate_cgroup()
Message-ID: <YNLuiGp5onZV+WGL@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622121551.3398730-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:15:21PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all callers of mem_cgroup_migrate() to call folio_migrate_cgroup()
> instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
