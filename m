Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700E820D0DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 20:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgF2Sgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:36:42 -0400
Received: from verein.lst.de ([213.95.11.211]:58732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgF2Sgl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:36:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 425DD68CEE; Mon, 29 Jun 2020 20:36:37 +0200 (CEST)
Date:   Mon, 29 Jun 2020 20:36:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200629183636.GA6539@lst.de>
References: <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com> <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com> <20200629180730.GA4600@lst.de> <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whzz81Cjfn+SNbLT8WvRxfQYbiAemKrQ5jpNAgxxDQhZA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 11:29:22AM -0700, Linus Torvalds wrote:
> I didn't look at the compat cases, but if anything I'd expect those to
> become simpler by having kernel pointers. And there doesn't actually
> seem to be that many of them (possibly because the "int" case si so
> common that it all ends up being the same?)

Having resurrect my work there really are tons of int cases.  Which
makes me thing that splitting out a setsockopt_int method which gets
passed value instead of a pointer, then converting all the simple cases
to that first and then doing the real shit later sounds like a promіsing
idea.  Let me think a bit more about that.

And yes, a lot of the common methods have tons of cases and
sub-dispatchers and everything else you'd expect from an ioctl-like
interface..
