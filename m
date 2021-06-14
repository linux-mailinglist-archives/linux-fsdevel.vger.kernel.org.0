Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB57A3A667A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhFNM0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 08:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhFNM0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:26:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD2C061574;
        Mon, 14 Jun 2021 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yr77KObtXWoCfBJmGjjbDCtdtoVUU/LuJUPsFZSj7WQ=; b=XCJN3bkwurBAhJkz94NPpmjseo
        hP8asJscT7b4VSXvd9ChTSxQ2RbU8lyw/JrR76vuDJJtyPHZrmuznLmirVey8wlNfB64+u4lTfq7s
        7EUzUbPYNSjMuF9yLtYjqVU1bdSpD6avcxtB+TQ3kGQDDILKabi1FS8/lT946ylpCF69uQCIt64RV
        o2AA2YwEfhFeGM+YenorbjVvveeXFy8zafreMJkfVYtCLnGMUhajqZrPVn5T43jdFl+jpKM9qTyni
        vpXGMzVGXQ1TdeZs+VccyLCDFAmtr1b8SCJdj7TSuPa5E5A3HqHDp6egOyJrKEofMPSz0x6Nxx4Ad
        z+2O5K3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lslch-005Obc-0i; Mon, 14 Jun 2021 12:23:28 +0000
Date:   Mon, 14 Jun 2021 13:23:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove the implicit .set_page_dirty default
Message-ID: <YMdKOst/Psnlxh8a@casper.infradead.org>
References: <20210614061512.3966143-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:15:09AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up a few lose ends around ->set_page_dirty, most
> importantly removes the default to the buffer head based on if no
> method is wired up.

i have a somewhat similar series in the works ...

https://git.infradead.org/users/willy/pagecache.git/commitdiff/1e7e8c2d82666b55690705d5bbe908e31d437edb
https://git.infradead.org/users/willy/pagecache.git/commitdiff/bf767a4969c0bc6735275ff7457a8082eef4c3fd

... the other patches rather depend on the folio work.
