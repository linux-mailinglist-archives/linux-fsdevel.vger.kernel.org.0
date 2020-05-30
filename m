Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186061E946A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgE3XQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 19:16:02 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:59144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729314AbgE3XQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DCE5F837F24A;
        Sat, 30 May 2020 23:16:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6742:8957:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14040:14096:14097:14181:14659:14721:14777:21080:21627:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: baby31_280098b26d70
X-Filterd-Recvd-Size: 2370
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 May 2020 23:15:58 +0000 (UTC)
Message-ID: <1a655e27fe1ac348ca98dd3f703270741311e458.camel@perches.com>
Subject: Re: [PATCH] checkpatch/coding-style: Allow 100 column lines
From:   Joe Perches <joe@perches.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Date:   Sat, 30 May 2020 16:15:57 -0700
In-Reply-To: <F5AE90A2-1661-4B8E-A884-C3CBAB0F603F@dilger.ca>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
         <20200528054043.621510-1-hch@lst.de>
         <22778.1590697055@warthog.procyon.org.uk>
         <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
         <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
         <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
         <9c360bfa43580ce7726dd3d9d247f1216a690ef0.camel@perches.com>
         <F5AE90A2-1661-4B8E-A884-C3CBAB0F603F@dilger.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-05-30 at 16:14 -0600, Andreas Dilger wrote:
> On May 29, 2020, at 5:12 PM, Joe Perches <joe@perches.com> wrote:
> > Change the maximum allowed line length to 100 from 80.
> 
> What is the benefit/motivation for changing this?  The vast majority
> of files are wrapped at 80 columns, and if some files start being
> wrapped at 100 columns they will either display poorly on 80-column
> terminals, or a lot of dead space will show in 100-column terminals.

YA Linus bleat in this thread.
I don't much care one way or any other.

https://lore.kernel.org/lkml/CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com/

and

https://lore.kernel.org/lkml/CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com/


