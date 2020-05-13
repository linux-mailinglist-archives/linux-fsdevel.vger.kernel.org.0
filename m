Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371AE1D1E74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbgEMTCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:02:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8BC061A0C;
        Wed, 13 May 2020 12:02:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYwdr-007hbz-H3; Wed, 13 May 2020 19:02:07 +0000
Date:   Wed, 13 May 2020 20:02:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/20] FIEMAP: don't bother with access_ok()
Message-ID: <20200513190207.GV23230@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-4-viro@ZenIV.linux.org.uk>
 <20200510070241.GA23496@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510070241.GA23496@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 12:02:41AM -0700, Christoph Hellwig wrote:
> On Sun, May 10, 2020 at 12:45:41AM +0100, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > we use copy_to_user() on that thing anyway (and always had).
> 
> I already have this patch in this series:
> 
> https://lore.kernel.org/linux-fsdevel/20200507145924.GA28854@lst.de/T/#t
> 
> which is waiting to be picked up [1], and also has some chance for conflicts
> due to changes next to the access_ok.
> 
> [1] except for the first two patches, which Ted plans to send for 5.7

I can drop this commit, of course, it's not a prereq for anything else in there.
Or I could pick your series into never-rebased branch, but it would complicate
the life wrt ext4 tree - up to you and Ted...
