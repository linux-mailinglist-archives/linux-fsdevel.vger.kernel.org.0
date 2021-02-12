Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4759731A823
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhBLWzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 17:55:44 -0500
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:49510 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229980AbhBLWwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 17:52:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C17B3100E7B44;
        Fri, 12 Feb 2021 22:51:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2561:2564:2682:2685:2693:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6248:7514:7652:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12555:12696:12737:12740:12760:12895:12986:13069:13095:13311:13357:13439:13845:14181:14659:14721:14777:21080:21433:21611:21627:21939:21972:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lace96_421607427625
X-Filterd-Recvd-Size: 1786
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Feb 2021 22:51:27 +0000 (UTC)
Message-ID: <130bc5f98c2fd501d32024d267ea73f1fb9d88b6.camel@perches.com>
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
From:   Joe Perches <joe@perches.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Feb 2021 14:51:26 -0800
In-Reply-To: <m1im6x0wtv.fsf@fess.ebiederm.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
         <m1im6x0wtv.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-02-12 at 16:01 -0600, Eric W. Biederman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > Convert S_<FOO> permissions to the more readable octal.
> > 
> > Done using:
> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=SYMBOLIC_PERMS fs/proc/*.[ch]
> > 
> > No difference in generated .o files allyesconfig x86-64
> > 
> > Link:
> > https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
> 
> 
> I will be frank.  I don't know what 0644 means.  I can never remember
> which bit is read, write or execute.  So I like symbolic constants.
> 
> I don't see a compelling reason to change the existing code.

Did you read Linus' message in the Link: above?

It was a reply to what Ingo Molnar suggested here:

https://lore.kernel.org/lkml/20160803081140.GA7833@gmail.com/


