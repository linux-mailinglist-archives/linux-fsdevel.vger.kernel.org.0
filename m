Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AE1254A56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgH0QQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:16:02 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:48044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgH0QP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:15:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A8A618384366;
        Thu, 27 Aug 2020 16:15:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2551:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:3872:4321:4605:5007:7576:7875:7903:7904:10004:10400:10848:11232:11658:11914:12048:12049:12050:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: drop48_1110f0b2706e
X-Filterd-Recvd-Size: 1744
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 16:15:57 +0000 (UTC)
Message-ID: <4a680693ac758647c8e936ef71f067571c12f46d.camel@perches.com>
Subject: Re: [PATCH v2 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Thu, 27 Aug 2020 09:15:55 -0700
In-Reply-To: <8fc9d4a25f25472384d9de2b6d5e8111@paragon-software.com>
References: <74de75d537ac486e9fcfe7931181a9b9@paragon-software.com>
         <63ae69b5-ee05-053d-feb6-6c9b5ed04499@infradead.org>
         <8fc9d4a25f25472384d9de2b6d5e8111@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-08-27 at 16:01 +0000, Konstantin Komarov wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Friday, August 21, 2020 8:23 PM
[]
> > > +- Full journaling support (currently journal replaying is supported) over JBD.
> > 
> >           journalling
> > seems to be preferred.
> > 
> Have to disagree on this. According to "journaling" term usage in
> different sources, the single-L seems to be the standard.

In the kernel it seems to be a tie:

$ git grep -i -w journalling | wc -l
109
$ git grep -i -w journaling | wc -l
111

I think 1 l better.


