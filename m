Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831423BC1DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGEQ6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGEQ6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:58:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA3CC061574;
        Mon,  5 Jul 2021 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NdRCp8+0TuhsupJ3z/cTsd8ADSgNPkIWGdRhbHg3jpg=; b=MS1cUT++EtPaw4HGLHppDVLph5
        iMngsE8IOneAqXBPjJXiauZ8ZeXPcHjDr39IJnD+IgeQ6Tbgoji7bAl2O9KzRHjQ8qnQBoWjWtzkD
        8/o82SRvTWlNmmpRhtBlKGCPe6KR2k5H2XMCRJaXWTfsaIM7IJ4pHIRMEZIrGgWXL6GSFM4Ffia72
        bz2IJvhlWpyoUwTDVWabBqDAyL+H4EW1cGilnVy87R3FkDq3wfdtmdJ7c03vqaNaxLEYTSOhGT5fN
        Ur+xo8Df+1gYFTltjFzGqGJoIcV1VkMs2+TZDibm39EI+R0Qhp2+LCw8Fr+K5I7FVjK34aB43F8or
        3ELJjNbg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0Rsn-00ARRr-0c; Mon, 05 Jul 2021 16:55:46 +0000
Date:   Mon, 5 Jul 2021 17:55:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YOM5kbDXD7QJGg0k@infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org>
 <YNpGW2KNMF9f77bk@casper.infradead.org>
 <YNqvzNd+7+YtXfQj@infradead.org>
 <CAHc6FU7+Q0D_pnjUbLXseeHfVQZ2nHTKMzH+0ppLh9cpX-UaPg@mail.gmail.com>
 <CAHc6FU6NWgVGPkvLM_mb+TpK3aM2BK+RrLgKgfS20kCLVV=ECg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6NWgVGPkvLM_mb+TpK3aM2BK+RrLgKgfS20kCLVV=ECg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 05, 2021 at 05:51:22PM +0200, Andreas Gruenbacher wrote:
> On Wed, Jun 30, 2021 at 2:29 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Darrick,
> >
> > will you pick up those two patches and push them to Linus? They both
> > seem pretty safe.
> 
> Hello, is there anybody out there?
> 
> I've put the two patches here with the sign-offs they've received:

Please send out an updated series likey everyone else.
