Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4CE230C7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgG1OdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgG1OdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:33:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E10C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 07:33:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0QfD-004N24-Ao; Tue, 28 Jul 2020 14:33:07 +0000
Date:   Tue, 28 Jul 2020 15:33:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank van der Linden <fllinden@amazon.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] xattr: add a function to check if a namespace
 is supported
Message-ID: <20200728143307.GB951209@ZenIV.linux.org.uk>
References: <20200623223927.31795-1-fllinden@amazon.com>
 <20200623223927.31795-3-fllinden@amazon.com>
 <20200625204157.GB10231@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20200714171328.GB24687@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <CAHk-=wj=gr3F3ZTnz8fnpSqfxivYKaFLvB+8UJOq3nTF9gzzyw@mail.gmail.com>
 <03E295AE-984E-47B1-ABC2-167C69D6DCC2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03E295AE-984E-47B1-ABC2-167C69D6DCC2@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 10:17:07AM -0400, Chuck Lever wrote:
> Hi Linus-
> 
> > On Jul 14, 2020, at 2:46 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > On Tue, Jul 14, 2020 at 10:13 AM Frank van der Linden
> > <fllinden@amazon.com> wrote:
> >> 
> >> Again, Linus - this is a pretty small change, doesn't affect any existing
> >> codepaths, and it's already in the tree Chuck is setting up for 5.9. Could
> >> this go in through that directly?
> > 
> > Both ok by me, but I'd like to have Al ack them. Al?
> 
> I have the NFSD user xattr patches in the current series waiting to be
> merged into v5.9. I'd like to create the nfsd-5.9 merge tag soon, but I
> haven't heard any review comments from Al. How would you like me to
> proceed?

Looks sane, AFAICS.  Sorry, still digging myself from under the mounds of
mail...
