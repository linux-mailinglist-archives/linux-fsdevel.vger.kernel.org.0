Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82EE2A0085
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 09:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ3I4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJ3I4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:56:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF503C0613D2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=smYnUjQBgapN3eA0+P5daW7CKEUWfFk6+G2bVAIGXxM=; b=aekYuMFXouJQMlazLZ4j0vPeu+
        N/uHosedtuDsFIDwLHUM50TIpttAvo26fKi+kTYBSmptb2Az6tTTDMCyWy10mn9awRzFr1hj85yh0
        HtIDH2tKjRGBdykwfnmBGxB8bedptEghmzGy4lsJT1EJgIg9yMP8S07S4pjyTo9g8y6oaiKDkhoW0
        e/g7o8opS1HrBrOYQ7jcaAhPZmJnZc77RL8/QfBphUNukKlDYz7ZArDmYxGH4RrCJhpCHlGCNW82R
        iBjdp6Ka+MfiUuEN+dx6w+dkmExlII0tJKboDKXodH2/psttx7qIlQIzlsqA6qEzKyAr4QXHUOkss
        bEcWRjCA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYQCY-0002lg-UQ; Fri, 30 Oct 2020 08:56:03 +0000
Date:   Fri, 30 Oct 2020 08:56:02 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201030085602.GA10556@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I actually had a series to clean a lot of this up based on the previous
version of the generic_file_buffered_read.  Give me a chance to
resurrect that..
