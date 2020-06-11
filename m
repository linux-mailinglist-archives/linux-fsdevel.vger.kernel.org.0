Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C871F6691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFKLYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgFKLYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:24:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7BC08C5C1;
        Thu, 11 Jun 2020 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qq2Iy8vRsv+5GToEZEr3De3lvTsl+HAJS9n4B3sidmk=; b=YT27lwEQYmP2PbQRi+lLN3ESJi
        RoOTtTN1kUg2a1QmB8+i8HoBLb65E6/4/dpn4kPxV5PaAERVszQZaBLaxk1J368KSUaM8fvQKXAvH
        KQhcfbmOvrQBwsFS7FDf1IYGUrF+q0Wa9FYF/lTC50SwWNSlnCUIZO+xgJUyH9ff3t2V13bIV3NK+
        b9LL2NnGp9AfxDF6YZFCJ1Y4QAUu3h5/mWRsy1c9aqD35gjNb0KtjkDf4dWlvzCpZjOZMDWDqx4w5
        I/wYx0SXB7wofhAsWAFlN2JV1BaQHL5iqzA9r0cOsRh0Izug1NMO55T3gQhwj53Iw3P8iAcc4ZUZD
        hV+JMHLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjLJd-0000YC-2X; Thu, 11 Jun 2020 11:24:13 +0000
Date:   Thu, 11 Jun 2020 04:24:12 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v6 00/51] Large pages in the page cache
Message-ID: <20200611112412.GA8681@bombadil.infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200611065954.GA21475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611065954.GA21475@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:59:54PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 10, 2020 at 01:12:54PM -0700, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > Another fortnight, another dump of my current large pages work.
> > I've squished a lot of bugs this time.  xfstests is much happier now,
> > running for 1631 seconds and getting as far as generic/086.  This patchset
> > is getting a little big, so I'm going to try to get some bits of it
> > upstream soon (the bits that make sense regardless of whether the rest
> > of this is merged).
> 
> At this size a git tree to pull would also be nice..

That was literally the next paragraph ...

It's now based on linus' master (6f630784cc0d), and you can get it from
http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-pa
+gecache
if you'd rather see it there (this branch is force-pushed frequently)

Or are you saying you'd rather see the git URL than the link to gitweb?
