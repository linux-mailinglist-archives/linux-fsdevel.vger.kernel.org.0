Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D122A3B0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 04:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKCDay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 22:30:54 -0500
Received: from smtprelay0180.hostedemail.com ([216.40.44.180]:59094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbgKCDay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:30:54 -0500
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 22:30:53 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id E94A218012002
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 03:23:00 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 96961100E7B43;
        Tue,  3 Nov 2020 03:22:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:7514:7875:10004:10400:10848:11232:11658:11914:12297:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: glove14_5108839272b5
X-Filterd-Recvd-Size: 2071
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Nov 2020 03:22:58 +0000 (UTC)
Message-ID: <35625559ea6fa7827e840905a4a03e624fdeb43f.camel@perches.com>
Subject: Re: [PATCH v2] fs/aio.c: Cosmetic
From:   Joe Perches <joe@perches.com>
To:     Andreas Dilger <adilger@dilger.ca>,
        Alejandro Colomar <colomar.6.4.3@gmail.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Nov 2020 19:22:57 -0800
In-Reply-To: <7CCB9FA6-DE85-4E3F-B3F1-7144F01589D4@dilger.ca>
References: <20201102152439.315640-1-colomar.6.4.3@gmail.com>
         <20201102215809.17312-1-colomar.6.4.3@gmail.com>
         <7CCB9FA6-DE85-4E3F-B3F1-7144F01589D4@dilger.ca>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-11-02 at 17:50 -0700, Andreas Dilger wrote:
> On Nov 2, 2020, at 2:58 PM, Alejandro Colomar <colomar.6.4.3@gmail.com> wrote:
> > Changes:
> > - Consistently use 'unsigned int', instead of 'unsigned'.
> > - Add a blank line after variable declarations.
> > - Move variable declarations to the top of functions.
> > - Add a blank line at the top of functions if there are no declarations.
> 
> I'd agree that the other changes are following kernel coding style, but
> I've never heard of leaving a blank line at the start of functions without
> any local variables.

I think that is odd as well.

> I don't see anything in process/coding-style.rst to
> support this change, nor are the majority of variable-less functions
> formatted this way, and it seems to just be a waste of vertical space.

checkpatch emits a --strict CHECK for those blank lines after
open braces


CHECK: Blank lines aren't necessary after an open brace '{'
#200: FILE: fs/aio.c:256:
 {
+

CHECK: Blank lines aren't necessary after an open brace '{'
#246: FILE: fs/aio.c:370:
 {
+

etc...


