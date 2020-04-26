Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08151B90BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDZNq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 09:46:58 -0400
Received: from elvis.franken.de ([193.175.24.41]:55783 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgDZNq5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:46:57 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jShcS-0000jA-02; Sun, 26 Apr 2020 15:46:52 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 36453C0301; Sun, 26 Apr 2020 15:46:28 +0200 (CEST)
Date:   Sun, 26 Apr 2020 15:46:28 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] fs/seq_file.c: Rename the "Fill" label to avoid build
 failure
Message-ID: <20200426134628.GC8299@alpha.franken.de>
References: <1587716944-28250-1-git-send-email-chenhc@lemote.com>
 <20200424112721.GE13910@bombadil.infradead.org>
 <CAAhV-H4obH6BS7TNJzpZvxhBo6W8qRamOh8K92rk1OaB4PxosA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4obH6BS7TNJzpZvxhBo6W8qRamOh8K92rk1OaB4PxosA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:54:23AM +0800, Huacai Chen wrote:
> On Fri, Apr 24, 2020 at 7:27 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Apr 24, 2020 at 04:29:04PM +0800, Huacai Chen wrote:
> > > MIPS define a "Fill" macro as a cache operation in cacheops.h, this
> > > will cause build failure under some special configurations. To avoid
> > > this failure we rename the "Fill" label in seq_file.c.
> >
> > You should rename the Fill macro in the mips header instead.
> > I'd suggest Fill_R4000 of R4000_Fill.
> 
> What do you think about this? If you agree to rename the "Fill" macro
> in cacheops.h, I want to rename it to Fill_I, because it has the same
> coding style as other cache operations in cacheops.h.

works for me, I've merged your patch to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
