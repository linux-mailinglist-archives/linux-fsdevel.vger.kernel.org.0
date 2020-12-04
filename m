Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C02CEF82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgLDOMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 09:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgLDOMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:12:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B69C0613D1;
        Fri,  4 Dec 2020 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LGx56xgp9qjEXeA8lKWYnMftFHX6kuyyVNYMLfZB01A=; b=Zyyuhxpi2UUOsDhs4KncGUQE2N
        LnQKR4+15yLvhkybkc+5Sy0zpnZywGJ+FS7LMzvJ7ah3/bgHJfsa1IkT+nrFZ9UuZI21GNk/exMuW
        J55Bo60H5JzJR0gGdNtULhgHHCyLAUS4s+hKKFnuy55oqNtEqrsz4rcXea8a97Ifr1p9UYZ0LR9aD
        r4W/xYq6lr0GYfwQO4cGvhkfcvIHOmNRNKc0uT1RpYUmKae4V8gx8Nptbtd8C6It64yVFEpKmFGpt
        USNH8o5F/JfTANyjhUe/UdCkRY+2YMNUi/cyzLnfpFZXQvXqeGYuaLhA+EKK2OT6Py/f5Qj2w4iot
        asllIRyg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klBoR-0008Kl-NL; Fri, 04 Dec 2020 14:11:56 +0000
Date:   Fri, 4 Dec 2020 14:11:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John David Anglin <dave.anglin@bell.net>
Cc:     Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-nvdimm@lists.01.org
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
Message-ID: <20201204141155.GO11935@casper.infradead.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
 <20201204034843.GM11935@casper.infradead.org>
 <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
 <20201204124402.GN11935@casper.infradead.org>
 <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3648e8d5-be75-ea2e-ddbc-5117fcd50a2b@bell.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 08:28:47AM -0500, John David Anglin wrote:
> (.mlocate): page allocation failure: order:5, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
>  [<000000004035416c>] __kmalloc+0x5e4/0x740
>  [<00000000040ddbe8>] nfsd_reply_cache_init+0x1d0/0x360 [nfsd]

Oof, order 5.  Fortunately, that one was already fixed by commit
8c38b705b4f4ca4e7f9cc116141bc38391917c30.
