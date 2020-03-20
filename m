Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036D918D155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCTOn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:43:58 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:42312 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbgCTOn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:43:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 26B1B181D3039;
        Fri, 20 Mar 2020 14:43:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6120:6742:6743:7875:7901:9025:10004:10400:10848:11232:11658:11914:12043:12297:12438:12679:12740:12895:13069:13255:13311:13357:13439:13845:13894:14181:14659:14721:21080:21212:21627:21811:30054:30062:30083:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hair87_3eb7b513bed5c
X-Filterd-Recvd-Size: 3245
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 14:43:50 +0000 (UTC)
Message-ID: <b96c9dd4dba4afca5288a551158659bf545d29fb.camel@perches.com>
Subject: Re: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 20 Mar 2020 07:42:03 -0700
In-Reply-To: <20200320124251.GW1922688@smile.fi.intel.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
         <cover.1584699455.git.msuchanek@suse.de>
         <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
         <20200320103350.GV1922688@smile.fi.intel.com>
         <20200320112338.GP25468@kitsune.suse.cz>
         <20200320124251.GW1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-03-20 at 14:42 +0200, Andy Shevchenko wrote:
> On Fri, Mar 20, 2020 at 12:23:38PM +0100, Michal Suchánek wrote:
> > On Fri, Mar 20, 2020 at 12:33:50PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 20, 2020 at 11:20:19AM +0100, Michal Suchanek wrote:
> > > > While at it also simplify the existing perf patterns.
> > > And still missed fixes from parse-maintainers.pl.
> > 
> > Oh, that script UX is truly ingenious.
> 
> You have at least two options, their combinations, etc:
>  - complain to the author :-)
>  - send a patch :-)

Recently:

https://lore.kernel.org/lkml/4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com/


