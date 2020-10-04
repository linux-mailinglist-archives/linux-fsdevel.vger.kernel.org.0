Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15387282882
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJDENk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 00:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJDENk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 00:13:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3245C0613CE;
        Sat,  3 Oct 2020 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HtvH4OYsRI91H4kCX61ekxhCqm1/VG8Jy/sK/CHxDxc=; b=l8C07FyN9OFE16l02mRi190J5K
        ssiM8cRWpYGSRPv7TOxmh/CpQCxz/v0GGTWQJtV5NMN9xsgHXXfeELDKKLSLiHYTW0eGovKB1h4Kh
        k2T3lVthrbPRdxBA5nJI9jQDRasNqmm5ODsgzmfFwCqpBmlSe0ehfI8C3qQenFFubKAUbUNgNegDB
        g0QX/NxEp6V8uWJe4fFV23M1WjFX/z5lppy6BiuQJ1Vz3RipvzkgvR/LiS0pwICDDmpCVCM4/Q0gx
        8qXEGlgay4wBZCI0K1MTHpnW64Yft0lyBY3iB6S9mWPRvClL9fw0+0Hz8Ys+nGZd1dSZpa62G7C+P
        WY8KIaUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOvOs-0000fR-5Z; Sun, 04 Oct 2020 04:13:34 +0000
Date:   Sun, 4 Oct 2020 05:13:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20201004041330.GF20115@casper.infradead.org>
References: <20200924152755.GY32101@casper.infradead.org>
 <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org>
 <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org>
 <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org>
 <CA+icZUULTKouG4L-dFYbGUi=aLXTZ083tZ=kzw6P+pKcSj-6hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUULTKouG4L-dFYbGUi=aLXTZ083tZ=kzw6P+pKcSj-6hQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 03, 2020 at 08:52:55PM +0200, Sedat Dilek wrote:
> Will you send this as a separate patch or fold into the original?
> 
> I have tested the original patch plus this (debug) assertion diff on
> top of Linux v5.9-rc7.

I'm going to wait for the merge window to open, Darrick's tree to be
merged, then send a backport of all the accumulated fixes to Greg for
the 5.9-stable tree.  I'm also going to do a 5.4 backport.
