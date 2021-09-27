Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A104198BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhI0QSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbhI0QSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7AC061575;
        Mon, 27 Sep 2021 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgsPp2q6Gx3KrsOata6iPHfIDOHhSAz68nEiT/7q9us=; b=qGudGH/afrOzkzqnuDCTW95KL6
        ncew57BzBi7/M6JN3tpoDfC5lMljDwByukZkFsLNz6ASnlKdwWCz5MOAUNQlE22aFQPKwG4tx+Isr
        hYCL4l9XVK3ovHiP/B+bkiG0153FJR9ShmbucpflFSZY8S4tqaouP0FgwkXVv1xgxZUYnejeKxebp
        XI5RXKa34qQpKGbkQEYULpUMFFijttxkFBszn04DBUta46Z98TpeVtv7cdjXV2Y9xvUe01+1HaOeB
        f5a/4tWzfwzMAQod1Sfcfxr2EIyhwXW+OMAn77wQUka6vt2QCnWrUzkvVVDSwk/vZvMqb5iTerLsS
        ls9wSOuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtIA-009vH2-Mi; Mon, 27 Sep 2021 16:16:05 +0000
Date:   Mon, 27 Sep 2021 17:15:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] aio: convert active_reqs into an array
Message-ID: <YVHuMnfxEgQxB2/i@infradead.org>
References: <20210927161047.200526-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927161047.200526-1-someguy@effective-light.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 12:10:47PM -0400, Hamza Mahfooz wrote:
> Commit 833f4154ed56 ("aio: fold lookup_kiocb() into its sole caller")
> suggests that, the fact that active_reqs is a linked-list means aio_kiocb
> lookups in io_cancel() are inefficient. So, to get faster lookups while
> maintaining similar characteristics elsewhere, turn active_reqs into an
> array and keep track of the free indices of the array (so we know which
> indices are safe to use).

As requested last time: please explain what workload you have where
cancellation performance actually matters.
