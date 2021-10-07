Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1C42553A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbhJGOXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhJGOXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:23:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1EC061570;
        Thu,  7 Oct 2021 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tiebx5SSQbjjXtJ/F2ySGSH38hhd1mVLQNuptCzTj4o=; b=IgYKb46tYN5qTq6wjl3kA3p3Q8
        aa9M6Wqp7g2OkITu6OoCZ5vivyh5lZYP1o593OGKaf/NCqnHAJeZHd8vR/cM07UV+KX4xUrBjOIvj
        z4Md+t2eQnc0BPRTvXQ18y9067OeBzwOzV2Jl/7Y/8ZCjRbTOZkbKrzeksqcZ4DoKoTA/Va7tfWBs
        NetpejEixd3XiroViatg+E3aWt9TrR5JHwUNi5wOLFf94zHs6lLXhQenpprZ7ZX5rOWvF001te7qI
        elxW0X8+NlIBmPeh/k90/KcIe6g47fzIqkZNOXceSiVWJWvPChNDEVi9q1wZwhCcoJ9gfSRyG519G
        RfXbDe7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYUFF-001vQF-Co; Thu, 07 Oct 2021 14:19:52 +0000
Date:   Thu, 7 Oct 2021 15:19:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: kernel BUG in block_invalidatepage
Message-ID: <YV8B+VGQ7TZoeJ8W@casper.infradead.org>
References: <CACkBjsZh7DCs+N+R=0+mnNqFZW8ck5cSgV4MpGM6ySbfenUJ+g@mail.gmail.com>
 <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsb0Hxam_e5+vOOanF_BfGAcf5UY+=Cc-pyphQftETTe8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 02:40:29PM +0800, Hao Sun wrote:
> Hello,
> 
> This crash can still be triggered repeatedly on the latest kernel.

I asked you three days ago to try a patch and report the results:

https://lore.kernel.org/linux-mm/YVtWhVNFhLbA9+Tl@casper.infradead.org/
