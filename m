Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC942546C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgH0O0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH0OZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:25:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAFEC061233
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7NzD1gKfznZWf1LkUQkXxWpbHVPmKoibLPgjxPQ/270=; b=R4Sytix/0LHRKtNaufOhWPE8uD
        lFDlUqHzRLpg4SefXf8RJA/imvfGzBup/HDywHAQLEqlgmA2d90zFlxJ8A9u2qrIeOTLA05uwOHt+
        LnblOkfFZ/3rDP7pvU0F7OALVg6r5sg2fzH+S+YkEGSGynHyPAtp5A4kFXo1OLremRj4fo4t+JOFn
        lhzW48GEBLZn9J4iZXrAqQdyJOF27L1LBbchCNTk66khQuZSTuGe6hTVok6elbVJ4upTPUZCAd+s3
        xZvBDw5AohcjflyLEHsriUyrfzr8C7nFJ8C1DTUJo+MxYlWpKxJV40p88Ofzh5T6HIqG1yW0O95Zn
        HkIOqYGw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBIqY-000120-HW; Thu, 27 Aug 2020 14:25:46 +0000
Date:   Thu, 27 Aug 2020 15:25:46 +0100
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
Message-ID: <20200827142546.GI14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu>
 <3331978.UQhOATu6MC@silver>
 <20200827140107.GH14765@casper.infradead.org>
 <159855515.fZZa9nWDzX@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159855515.fZZa9nWDzX@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 04:23:24PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 27. August 2020 16:01:07 CEST Matthew Wilcox wrote:
> > On Thu, Aug 27, 2020 at 03:48:57PM +0200, Christian Schoenebeck wrote:
> > > On Donnerstag, 27. August 2020 14:25:55 CEST Matthew Wilcox wrote:
> > > > On Thu, Aug 27, 2020 at 02:02:42PM +0200, Christian Schoenebeck wrote:
> > > > > What I could imagine as delimiter instead; slash-caret:
> > > > >     /var/foo.pdf/^/forkname
> > > > 
> > > > Any ascii character is going to be used in some actual customer
> > > > workload.
> > > 
> > > Not exactly. "/foo/^/bar" is already a valid path today. So every Linux
> > > system (incl. all libs/apps) must be capable to deal with that path
> > > already, so it would not introduce a tokenization problem.
> > 
> > That's exactly the point.  I can guarantee you that some customer is
> > already using a file named exactly '^'.
> 
> You are contradicting yourself. Ditching the idea because a file "^" might 
> exist, implies ditching your idea of "💩" as it might already exist as well.

That's because THIS IS A SHIT IDEA.

> > You misunderstood.  This was my way of telling you that your idea is shit.
> 
> Be invited for making better suggestions. But one thing please: don't start 
> getting offending.

Oh, fuck off.

> No matter which delimiter you'd choose, something will break. It is just about 
> how much will it break und how likely it'll be in practice, not if.
> 
> If you are concerned about not breaking anything: keep forks disabled.

My way of keeping forks disabled is to tell you to fuck off.  You
can keep fucking off until you get there.  Then fuck off some more.
