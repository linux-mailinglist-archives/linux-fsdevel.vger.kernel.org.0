Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48254AC59E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241606AbiBGQbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 11:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378450AbiBGQSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:18:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B73C0401CE;
        Mon,  7 Feb 2022 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yoSKJ9Y5PsjWBGSNI/TFMdwBItW1u5exmmTOYSxThD8=; b=dh+OOMmjPt34uB61r8w1fBywg9
        ctC5sqpN9WwEJcrz+fZs6kj1ze5ztZdXG78tnFIZeNLQ7FAH+L5EAlBUCA89YTxqfH0SWHxSjTEh1
        ij4WtSU9jqteVHI1i8q6+pSepCm8tJ+LZ/7I+9TJYmk2M2ZTmDCrsY4fLKoOtsIdZBdfyouAiWwFg
        YMyqcCzMCka8EHbSavKgrZcHM/Imo3+LjADQJFL1TcqG+PrAayIV3ECReVIaxWgivzy9WoBKwaKC9
        RiKS/anY6Cx0d4ISIZ9r78djct1yKOO5VM+N6Tezqn7j4WrzGbrWwSKGtCdiWPJCpW1kA7WbiGmyz
        8kUjFGeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH6iQ-001SOE-SQ; Mon, 07 Feb 2022 16:18:10 +0000
Date:   Mon, 7 Feb 2022 16:18:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/2] Convert NFS from readpages to readahead
Message-ID: <YgFGQi/1RRPSSQpA@casper.infradead.org>
References: <20220122205453.3958181-1-willy@infradead.org>
 <Yff0la2VAOewGrhI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yff0la2VAOewGrhI@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:39:17PM +0000, Matthew Wilcox wrote:
> On Sat, Jan 22, 2022 at 08:54:52PM +0000, Matthew Wilcox (Oracle) wrote:
> > NFS is one of the last two users of the deprecated ->readpages aop.
> > This conversion looks straightforward, but I have only compile-tested
> > it.
> 
> These patches still apply to -rc2.

And they still apply to rc3.

I'm just going to send them to Linus as part of the general fs-folio
work I'm doing during the next merge window.  If anybody would like to
test them, I'm happy to stick a Tested-by on them.
