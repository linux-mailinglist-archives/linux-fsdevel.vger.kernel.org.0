Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C21257B40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHaOZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:25:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59894 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726503AbgHaOZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:25:50 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07VEPXZu026207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 10:25:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0A732420128; Mon, 31 Aug 2020 10:25:33 -0400 (EDT)
Date:   Mon, 31 Aug 2020 10:25:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200831142532.GC4267@mit.edu>
References: <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831132339.GD14765@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:23:39PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
> > On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > As I said to Dave, you and I have a strong difference of opinion here.
> > > I think that what you are proposing is madness.  You're making it too
> > > flexible which comes with too much opportunity for abuse.
> > 
> > Such as?
> 
> One proposal I saw earlier in this thread was to do something like
> $ runalt /path/to/file ls
> which would open_alt() /path/to/file, fchdir to it and run ls inside it.
> That's just crazy.

As I've said before, malware authors would love that features.  Most
system administrators won't.

Oh, one other question about ADS; if a file system supports reflink,
what is supposed to happen when you reflink a file?  You have to
consider all of the ADS's to be reflinked as well?  In some ways, this
is good, because the overhead and complexity will probably cause most
file system maintainers to throw up their had, say this is madness,
and refuse to implement it.  :-)

						- Ted
