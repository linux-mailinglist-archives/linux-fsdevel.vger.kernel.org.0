Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADA14FAF7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2020 00:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgBAXge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 18:36:34 -0500
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:46016 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbgBAXge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 18:36:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B4860837F24A;
        Sat,  1 Feb 2020 23:36:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2903:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:7514:7974:10004:10400:10848:11232:11658:11914:12295:12296:12297:12555:12740:12760:12895:12986:13069:13095:13161:13229:13311:13357:13439:14093:14096:14097:14181:14659:14721:21080:21220:21324:21325:21433:21451:21611:21627:30054:30056:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: level58_1bec00691dd04
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Feb 2020 23:36:31 +0000 (UTC)
Message-ID: <5ac73de311101754a25aaeac3df1aca23dbaf2af.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: rectify radix-tree testing entry in XARRAY
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 15:35:23 -0800
In-Reply-To: <alpine.DEB.2.21.2002012231410.5859@felia>
References: <20200201180234.4960-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.21.2002012231410.5859@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-02-01 at 22:35 +0100, Lukas Bulwahn wrote:
> 
> On Sat, 1 Feb 2020, Lukas Bulwahn wrote:
> 
> > The initial commit 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> > missed a trailing slash to include all files and subdirectory files.
> > Hence, all files in tools/testing/radix-tree were not part of XARRAY,
> > but were considered to be part of "THE REST".
> > 
> > Rectify this to ensure patches reach the actual maintainer.
> > 
> > This was identified with a small script that finds all files only
> > belonging to "THE REST" according to the current MAINTAINERS file, and I
> > acted upon its output.
> > 
> > Fixes: 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Matthew, please pick this small fixup patch.
> > 
> > applies cleanly on current master and next-20200131
> > 
> 
> Matthew, Joe Perches just informed me that get_maintainers.pl is smart
> enough to handle the case below and does not strictly need a further 
> trailing slash.
> 
> Please ignore this patch; the commit message is actually wrong.

While the commit message may be inexact,
I think the actual change is good and
could/should still be applied.

The "Fixes:" tag is unnecessary though.


