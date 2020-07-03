Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80996213105
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 03:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGCBer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCBeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:34:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0BC08C5C1;
        Thu,  2 Jul 2020 18:34:46 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrAbB-004Hg1-8m; Fri, 03 Jul 2020 01:34:41 +0000
Date:   Fri, 3 Jul 2020 02:34:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] sysctl: Call sysctl_head_finish on error
Message-ID: <20200703013441.GR2786714@ZenIV.linux.org.uk>
References: <20200701200951.3603160-1-hch@lst.de>
 <20200701200951.3603160-20-hch@lst.de>
 <20200702003240.GW25523@casper.infradead.org>
 <20200702051512.GA30361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702051512.GA30361@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 07:15:12AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 02, 2020 at 01:32:40AM +0100, Matthew Wilcox wrote:
> > On Wed, Jul 01, 2020 at 10:09:47PM +0200, Christoph Hellwig wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > This error path returned directly instead of calling sysctl_head_finish().
> > > 
> > > Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > I think this one needs to go to Linus before 5.8, not get stuck in the
> > middle of a large patch series.
> 
> I've only kept it here because it didn't show up in Linus tree yet.
> If you send it and it gets picked up I can trivially drop it.

I'll send it tonight, if it's not there yet...
