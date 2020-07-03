Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF22213553
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGCHoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 03:44:17 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:49652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgGCHoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:44:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 01971182CF665;
        Fri,  3 Jul 2020 07:44:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2736:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:3873:3874:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21324:21627:21740:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: peace82_23082f326e90
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 07:44:13 +0000 (UTC)
Message-ID: <d7c902f9eecffc51f3a5761fa343bedad89dff7e.camel@perches.com>
Subject: Re: [PATCH 16/23] seq_file: switch over direct seq_read method
 calls to seq_read_iter
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 03 Jul 2020 00:44:12 -0700
In-Reply-To: <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
References: <20200701200951.3603160-1-hch@lst.de>
         <20200701200951.3603160-17-hch@lst.de>
         <CANiq72=CaKKzXSayH9bRpzMkU2zyHGLA4a-XqTH--_mpTvO7ZQ@mail.gmail.com>
         <20200702135054.GA29240@lst.de>
         <CANiq72=8facdt7HBtoUZiJW5zfki-gYYESJzxjXf7wK7dYLm1Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-07-03 at 07:56 +0200, Miguel Ojeda wrote:
> On Thu, Jul 2, 2020 at 3:50 PM Christoph Hellwig <hch@lst.de> wrote:
> > Do you have a suggestion for an automated replacement which does?
> > I'll happily switch over to that.
> 
> I guess I'd simply find the unique set of cases that occur and create
> a replacement for each manually. A handful of them or so may already
> cover the majority of cases. CC'ing Joe since he deals with this sort
> of stuff all the time.

I do that with a diff and emacs script.

And I'd generally not bother with 80 column rewrapping
here as it both makes a diff harder for not much value and
it's only a few characters added to a few lines that might
now exceed 80 columns.

I presume that clang-format would work well enough too.

