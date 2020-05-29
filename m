Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E194B1E8119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2PBv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2PBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 11:01:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C55C03E969;
        Fri, 29 May 2020 08:01:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jegVz-0000ER-E3; Fri, 29 May 2020 15:01:43 +0000
Date:   Fri, 29 May 2020 16:01:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 04/20] FIEMAP: don't bother with access_ok()
Message-ID: <20200529150143.GF23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
 <20200510070241.GA23496@infradead.org>
 <20200513190207.GV23230@ZenIV.linux.org.uk>
 <20200513193801.GC484@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513193801.GC484@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 12:38:01PM -0700, Christoph Hellwig wrote:
> On Wed, May 13, 2020 at 08:02:07PM +0100, Al Viro wrote:
> > > https://lore.kernel.org/linux-fsdevel/20200507145924.GA28854@lst.de/T/#t
> > > 
> > > which is waiting to be picked up [1], and also has some chance for conflicts
> > > due to changes next to the access_ok.
> > > 
> > > [1] except for the first two patches, which Ted plans to send for 5.7
> > 
> > I can drop this commit, of course, it's not a prereq for anything else in there.
> > Or I could pick your series into never-rebased branch, but it would complicate
> > the life wrt ext4 tree - up to you and Ted...
> 
> I really don't care - the first two really need to go in ASAP and
> Ted promised to pick them up, but I've not seen them in linux-next
> yet.  The rest can go wherever once the first ones hit mainline.

OK, dropped
