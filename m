Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB56B371C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCJHJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCJHJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:09:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFA65C5E
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 23:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EDcvvrQIIqqj0w26NDf1+/t5fnp1BRSxAGSW1ypGQIQ=; b=RAkcQ7ImmS2lTehUIQeXCjKfWe
        gDjW1Oxl1C39goN0YsPidlehNPnMZ8naXwWEIZqQGdju+dFDdmgrkMO4qIBupT3j+4XBhM8l5xbyX
        nCRQTWV35y86IfOnPWxLn0eSGVHRfq5WckAyEZxoQf7q6/62tjHLnSPZg4yP3u8BVCRvDJaocCnta
        qng6KHuff+gmazh9o/ww1jRDeGQLhKPYd4yTkoI2ZmQgGzen++y+dVZlNHmbl6raBYtpfxuVp42vN
        jL2TWM2gcWlrIX/qGB1HVajNBan8w49oB1xTY4jSBRhrjt8nKQ66SlqTIGJCI1numMagLrs62qTOu
        O/rtojtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paWsE-00FERr-1S;
        Fri, 10 Mar 2023 07:09:06 +0000
Date:   Fri, 10 Mar 2023 07:09:06 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] ufs: don't flush page immediately for DIRSYNC
 directories
Message-ID: <20230310070906.GT3390869@ZenIV>
References: <20230307143125.27778-1-hch@lst.de>
 <20230307143125.27778-2-hch@lst.de>
 <20230310035353.GM3390869@ZenIV>
 <20230310063756.GA13484@lst.de>
 <20230310065235.GR3390869@ZenIV>
 <20230310070047.GB13563@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310070047.GB13563@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 08:00:47AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 10, 2023 at 06:52:35AM +0000, Al Viro wrote:
> > > > Umm...  I'll throw it in ufs pile, I guess (tomorrow - I'll need to
> > > > sort out Fabio's patches in the area as well; IIRC, the latest
> > > > had been in late December).
> > > 
> > > Well, the three patches really should go together, otherwise we miss
> > > yet another merge window.
> > 
> > Umm...  Do you need them in the same (never-rebased?) branch, or would
> > it suffice to have all of them reach mainline by 6.4-rc1?
> 
> The latter.  But patch 3 depends on 1 and 2.

Obviously, but that's not hard to arrange.  OK, will do tomorrow; remind me
if all three are not in vfs.git by Monday...
