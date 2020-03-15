Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30B82185E5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 17:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgCOQDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 12:03:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgCOQDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mxPfarIqbjUZhPb5nQkaPXUh1yhCYouVFUvHtSwUDGM=; b=JQNh4D538Svr63J6jYaKx9G39Z
        IlVEKG+q6yPIOXW75VEBehECfximavxxhfWCBg8PhqWYFuMV/8VhZgB7FnzOEUb3zno8Ck9qbci7t
        It54I8kSJ8LEv4FmF+FC56e4t9Epx+Q4qz1VEEZ2+4P1YwF5IKLChaHmyM3hegaNi6hxnTKysE7w/
        YsAT4/a677bCG8ExF4g9dR626CS4EGzW/ujs4Tz6voXGtf6MMtFPxriiqPRtR3j5RZGTtd+yUS1Xu
        FcU52OVYFy3XG8nRDPUoHmW7xonRNN/JJpeRHsI0nPTA775qwZdZpz9HsjdE6SoCfCuSUgUvZfAdQ
        Y85sLSNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDVjg-0000nP-Ge; Sun, 15 Mar 2020 16:03:32 +0000
Date:   Sun, 15 Mar 2020 09:03:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mm, list_lru: make memcg visible to lru walker
 isolation function
Message-ID: <20200315160332.GW22433@bombadil.infradead.org>
References: <20200315095342.10178-1-laoar.shao@gmail.com>
 <20200315095342.10178-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315095342.10178-2-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 15, 2020 at 05:53:40AM -0400, Yafang Shao wrote:
> +#define for_each_mem_cgroup_tree(iter, root)		\
> +	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
> +	     iter != NULL;				\
> +	     iter = mem_cgroup_iter(root, iter, NULL))
[...]
> +#define for_each_mem_cgroup_tree(iter)		\
> +	for (iter = NULL; iter; )
> +

That's not the same signature ...
