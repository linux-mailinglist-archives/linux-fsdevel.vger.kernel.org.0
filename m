Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8502A3555C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbhDFNxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbhDFNxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:53:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BFC06174A;
        Tue,  6 Apr 2021 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=dsLwuK9w6gOKehdRAGmLP4gajK
        k2PrAfRMI1tTKPHgwEdFyPk9iOtaIzkIN4UdcAryViIbM+6r8xNqYcEfwP/yXKEX6pVciWMdffM06
        f2u/XwTHYQdgl5zaY8/VmYs3ilAaijBLQFaSweOP/N971hSVdTSMJH8HFK76Tvkf3MNQ+8qBeEJEF
        wnihHLNkBH6D3SfHW4ykGv+m5ynZZQJD5Ui+L+f3n71a/AM2i6IO2jSzg/ZAB3qqR2VAO5EzF/0E7
        BW9kYu9Skj+6VUwQpF5vvUQ4qAbNEBrGcXtUCSb885B6/+K6Ijfn+qefUxzIsp9HOH6ayezmIc8pF
        c/e8TszA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTm8B-00CtJ5-Jw; Tue, 06 Apr 2021 13:52:39 +0000
Date:   Tue, 6 Apr 2021 14:52:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v6 17/27] mm/filemap: Add lock_folio
Message-ID: <20210406135235.GP3062550@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
 <20210331184728.1188084-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331184728.1188084-18-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
