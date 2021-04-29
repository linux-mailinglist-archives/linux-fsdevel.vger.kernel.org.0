Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638CD36E516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 08:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhD2Gum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Gum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:50:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D704C06138B;
        Wed, 28 Apr 2021 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MUKh3q8a4SHYsvnkYAfxbKChRjzMGvWP8fV8eM1XBoo=; b=lzN0Eb1bVt0buxA5hryBAMp41/
        kqRV2TMwDqX055zwFHsdTx5ZEYzk6OGKMxMYfoWZPGyKzZ8WHCb01+PCKPQ0tfWuCk8ByVTof0/oZ
        JWd02LFOJqD4HrfZIoPGorY25qNMw1co5KiaG/jhbSwihC4p4Zi2kAPNmTUb4oqssUnF2CWkkEVgi
        2tL+42POhWbblvqG4Ldl0fy/4VryFiYM4DaznVlbi4J2nZeSUn+uPkMdFc6Ex8leocm4jt9alMRwa
        RYvVlY3SFqU4qHhcaFFoSte8wuiBfGNs3VUvshTMs9vSYnMcDQ7pFbwg3EB3eQ5yZbuESQl5Jbp+Y
        nQDQ7IfA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lc0Sl-009IgJ-Fp; Thu, 29 Apr 2021 06:48:13 +0000
Date:   Thu, 29 Apr 2021 07:47:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 7/9] ida: introduce ida_max() to return the maximum
 allocated ID
Message-ID: <20210429064751.GA2216380@infradead.org>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210428094949.43579-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428094949.43579-8-songmuchun@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 05:49:47PM +0800, Muchun Song wrote:
> Introduce ida_max() to return the maximum allocated ID. This will be
> used by memory cgroup in the later patch.

Please also add a lower-level xa_max as this funcationalty would also
come in handy at the xarray level in a few places.
