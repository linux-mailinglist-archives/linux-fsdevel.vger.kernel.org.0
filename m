Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2942B24E0A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHUT17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 15:27:59 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:53570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725801AbgHUT15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:27:57 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2020 15:27:57 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 150751803EB5B;
        Fri, 21 Aug 2020 19:21:17 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 59C72181D2063;
        Fri, 21 Aug 2020 19:21:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2919:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:5007:6117:6120:6248:7901:7903:10004:10400:10848:11232:11658:11914:12048:12297:12679:12740:12760:12895:13069:13095:13181:13229:13255:13311:13357:13439:14659:14721:14777:21067:21080:21433:21627:21819:21939:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hate40_0c00a172703b
X-Filterd-Recvd-Size: 1695
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 19:21:14 +0000 (UTC)
Message-ID: <ed518871bf6182bb7d9a2b95074985cf8af1d5c4.camel@perches.com>
Subject: Re: [PATCH v2 00/10] fs: NTFS read-write driver GPL implementation
 by Paragon Software.
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Fri, 21 Aug 2020 12:21:12 -0700
In-Reply-To: <904d985365a34f0787a4511435417ab3@paragon-software.com>
References: <904d985365a34f0787a4511435417ab3@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-08-21 at 16:24 +0000, Konstantin Komarov wrote:
> This patch adds NTFS Read-Write driver to fs/ntfs3.

Thanks.
Proper ntfs read/write support will be great addition.

Trivia:

If this patchset is submitted again with a new version,
please use something like "git format-patch --cover-letter"
and "git send-email" so all parts of the patches and replies
have the a single message thread to follow.

That will add an "in-reply-to" header of the 0/m patch
message-id to all n/m parts.

One style oddity I noticed is the use of goto labels in
favor of if block indentation.  It's not terrible style,
just unusual for kernel code.


