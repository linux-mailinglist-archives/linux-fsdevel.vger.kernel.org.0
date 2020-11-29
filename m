Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555AC2C7BBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 23:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgK2Wcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 17:32:36 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:54750 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbgK2Wcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 17:32:35 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BCA761802926E;
        Sun, 29 Nov 2020 22:31:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2892:2898:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12048:12050:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:21080:21627:21740:30012:30029:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: truck72_1107d5f2739c
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Nov 2020 22:31:53 +0000 (UTC)
Message-ID: <9dfe4206580f2c0d59ca0a9e510054ce378cb2d8.camel@perches.com>
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tom Rix <trix@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 29 Nov 2020 14:31:51 -0800
In-Reply-To: <ec43cf0faa4bfeaa4495b4e1f1c61e617d468591.camel@HansenPartnership.com>
References: <20201127190707.2844580-1-trix@redhat.com>
         <20201127195323.GZ4327@casper.infradead.org>
         <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
         <d65cd737-61a5-4b31-7f25-e72f0a7f4ec2@infradead.org>
         <ec43cf0faa4bfeaa4495b4e1f1c61e617d468591.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-11-29 at 10:15 -0800, James Bottomley wrote:
> I think nowadays we should always use static inlines for argument
> checking unless we're capturing debug information like __FILE__ or
> __LINE__ or something that a static inline can't.

IMO: __LINE__ should never be used.

__func__ is the only thing that can't be captured correctly as
the inline gets its own name.

__builtin_return_address(1) would generally work well enough
for the inlines.

> There was a time when we had problems with compiler expansion of static
> inlines, so we shouldn't go back and churn the code base to change it
> because there's thousands of these and possibly some old compiler used
> for an obscure architecture that still needs the define.

That's not a very compelling argument to me.

Those old compilers and obscure architectures should continue
to use the old versions of the code.


