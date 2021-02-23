Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C56323441
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 00:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhBWXgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 18:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhBWX2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:28:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498AFC061574;
        Tue, 23 Feb 2021 15:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q5XVodoHDTZdgJ0yWJ3OcVB1WnWj1JW3zCsrFT39dRQ=; b=RofC7flCtm+ms9vSAIzCP/Ba8e
        i9LejeFEc5bXhp8tQpCWjTx2Ys4SZMk+J+0q1+AefmHRyhAajK7DwygnepnFS5sHwprK41cJGaO9m
        ONoILqgSDzkb0gaA84KbVyrJOBpSfEvfmVlUxf+GPJ7RUgtLsjxYTNw1zAxgG0u3dinMu3a+XHBSM
        57wqUm8HNNx5jz27XzrvRmccpM+i9V8ZGCU8OmZH3Ky4Ejy9iJ3BaGtnSyuzM1wDUwQTwISqj4PKM
        T6qadHu3Ozdywcrr79elfJhg4e7le4kRezE6hvzMNEAzLpYNOEcAsQ0KK9LYn92evwRDJgXIoVLmV
        7PXn+7Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lEh5W-008f7c-GQ; Tue, 23 Feb 2021 23:27:31 +0000
Date:   Tue, 23 Feb 2021 23:27:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hughd@google.com, hch@lst.de, hannes@cmpxchg.org,
        yang.shi@linux.alibaba.com, dchinner@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-ID: <20210223232730.GN2858050@casper.infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
 <20210223145836.cb588a6ec6c34e54ad26f9bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223145836.cb588a6ec6c34e54ad26f9bf@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:58:36PM -0800, Andrew Morton wrote:
> Do you feel this patchset is ready to merge up?

I think so.

> https://lore.kernel.org/linux-mm/000000000000f6914405b49d9c9d@google.com/
> was addressed by 0060ef3b4e6dd ("mm: support THPs in
> zero_user_segments"), yes?

Correct.

> "mm/truncate,shmem: Handle truncates that split THPs" and "mm/filemap:
> Return only head pages from find_get_entries" were dropped.  I guess
> you'll be having another go at those sometime?

That's right.

> https://lore.kernel.org/linux-fsdevel/20201114100648.GI19102@lst.de/
> wasn't responded to?

It didn't really seem worth replying to ... I'm not particularly
sympathetic to "please refactor the patch series" when there's no
compelling reason, and having a large function inlined really isn't a
problem when it only has one caller.
