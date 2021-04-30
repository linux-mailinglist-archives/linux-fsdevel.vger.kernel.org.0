Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C205A36FFDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhD3RqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhD3RqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:46:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC18FC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WN6I38ELZb9P+gbpxxi2QOF6JhVvyYiALP0FFTCIIUw=; b=MtJ5cV22KUMh0ystRZCLApmCI1
        csIR4YxILd431S1ZSX9ZsrajvgkcB5z0wMlhU4a2lAfxq7nVhwaKY/qdCGxnod0tBOjYjjzR1KngD
        y8TbtMFm30MDCoOwG9zBAn5dbhny0NZkrHN24kP3T0OIQmldD7Hfy/AsFmX7MUT4CjnHMhcdFPjIf
        WkTK4wKx2anW8p63yfLkWnVKZ1iBV+qgRzfs6L+IALXoSWcNYoucNApMcXRdD6crnEJ0aHvKV+QhO
        mlNQ6UQd2IlQJcXiJ5iqAFsu/0dfGSajnzd2F3dwUYhJ3Zfv7sEt0sFKkQFZe5hLVzoqMvoja/71N
        xnf8bslg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXBw-00BKf7-JN; Fri, 30 Apr 2021 17:44:46 +0000
Date:   Fri, 30 Apr 2021 18:44:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v8 00/27] Memory Folios
Message-ID: <20210430174440.GO1847222@casper.infradead.org>
References: <20210430172235.2695303-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430172235.2695303-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:22:08PM +0100, Matthew Wilcox (Oracle) wrote:

Argh.  This is the wrong version.  My apologies.  I'll send a v8.1.
