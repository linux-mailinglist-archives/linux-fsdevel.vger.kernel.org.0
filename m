Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E221799C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 21:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbgCDU0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 15:26:36 -0500
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:38018 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387926AbgCDU0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:26:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78662100E7B45;
        Wed,  4 Mar 2020 20:26:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3866:3867:3870:3872:4321:5007:7514:7903:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13132:13184:13229:13231:13311:13357:13439:13618:14181:14659:14721:21080:21451:21627:21740:21984:30054:30069:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hot73_565b5f8ad3729
X-Filterd-Recvd-Size: 1567
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Mar 2020 20:26:33 +0000 (UTC)
Message-ID: <9c1c1b5e3a59705a501cbb713f1d0e44cc71e788.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 12:24:59 -0800
In-Reply-To: <20200304131035.731a3947@lwn.net>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
         <20200304131035.731a3947@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-03-04 at 13:10 -0700, Jonathan Corbet wrote:
> On Wed,  4 Mar 2020 08:29:50 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
[]
> > ./scripts/get_maintainer.pl --self-test complains with 27
> > warnings on Documentation/filesystems/ of this kind:
> > 
> >   warning: no file matches F: Documentation/filesystems/...
[]
> Sigh, I need to work a MAINTAINERS check into my workflow...

checkpatch already bleats a warning on patches with any
file move or rename.

It would be difficult to impossible to implement a real
pattern verification mechanism in checkpatch though.


