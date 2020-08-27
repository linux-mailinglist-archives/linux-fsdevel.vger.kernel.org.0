Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13B3254690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0OOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgH0OLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:11:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED758C06123D
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DqVXaGcKcAVCZHakiAPOteuqigl9ItOOuHNB+Ad9VN8=; b=fRD9Rw8+ViQSs7fGX0G8IZyaME
        KSX7YHgBuJqDIwn9Nt1aByHJjq80fZ+q+4HONYCtkw2U3LcgmuUwGJ547XMq9v2Vdq/Yxk/13/q5Y
        HTFwmjFe5dRMAP6o0ri1MUyHc+H+lcIpDAxOpzDY2hc430jqfO3xrQcLv9R4LIoElGqsdZLnWZZrD
        Cv1XB+MVE9kOvqWbd5O5h+rmW/tgVbiWgZnDO1ceq1aKohgM/b25QfNI/sS2TVSVfLL6OO7/C4cY7
        E9roa/YvGfv3A/CwN5Gxtq0MKvRNbWZAydmSB6F4dKTmTP755j163lKFuyCJZ6C33+w9uh2uq42D4
        8MWv1JSw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBISh-0007zJ-G8; Thu, 27 Aug 2020 14:01:07 +0000
Date:   Thu, 27 Aug 2020 15:01:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200827140107.GH14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu>
 <1803870.bTIpkxUbEX@silver>
 <20200827122555.GD14765@casper.infradead.org>
 <3331978.UQhOATu6MC@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3331978.UQhOATu6MC@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:48:57PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 27. August 2020 14:25:55 CEST Matthew Wilcox wrote:
> > On Thu, Aug 27, 2020 at 02:02:42PM +0200, Christian Schoenebeck wrote:
> > > What I could imagine as delimiter instead; slash-caret:
> > >     /var/foo.pdf/^/forkname
> > 
> > Any ascii character is going to be used in some actual customer workload.
> 
> Not exactly. "/foo/^/bar" is already a valid path today. So every Linux system 
> (incl. all libs/apps) must be capable to deal with that path already, so it 
> would not introduce a tokenization problem.

That's exactly the point.  I can guarantee you that some customer is
already using a file named exactly '^'.

> > I suggest we use a unicode character instead.
> > 
> > /var/foo.pdf/💩/badidea
> 
> Like I mentioned before, if you'd pick a unicode character (or binary), then 
> each shell will map their own ASCII-sequence on top of that. Because shell 
> users want ASCII. Which would defeat the primary purpose: a unified path 
> resolution.

You misunderstood.  This was my way of telling you that your idea is shit.
