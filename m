Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2318BD70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 18:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgCSRFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 13:05:05 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:58540 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727880AbgCSRFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:05:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B4C02100E7B42;
        Thu, 19 Mar 2020 17:05:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2691:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3871:3874:4321:5007:6120:6742:6743:7901:10004:10400:10848:11232:11657:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21451:21627:30054:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: nail76_487c79fbbf85c
X-Filterd-Recvd-Size: 3720
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 17:04:57 +0000 (UTC)
Message-ID: <9f8c9555e0c2a863b111654b4239c7ef0db06866.camel@perches.com>
Subject: Re: [PATCH v11 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
From:   Joe Perches <joe@perches.com>
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Date:   Thu, 19 Mar 2020 10:03:07 -0700
In-Reply-To: <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
References: <20200225173541.1549955-1-npiggin@gmail.com>
         <cover.1584620202.git.msuchanek@suse.de>
         <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-03-19 at 13:19 +0100, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v10: new patch
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc8dbe4fe4c9..329bf4a31412 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13088,6 +13088,8 @@ F:	arch/*/kernel/*/perf_event*.c
>  F:	arch/*/kernel/*/*/perf_event*.c
>  F:	arch/*/include/asm/perf_event.h
>  F:	arch/*/kernel/perf_callchain.c
> +F:	arch/*/perf/*
> +F:	arch/*/perf/*/*

While I understand the desire, I believe that
repetitive listings like this don't really
help much.

Having a single entry of:

F:	arch/*/perf/

would serve the same purpose.

Nominally, the difference between the 2 entries
vs the 1 entry is this:

F:	arch/*/perf/*

Only the specific files in any directory that matches
this pattern but not any files in their subdirectories
are maintained.

F:	arch/*/perf/*/*

Only the files in any top level subdirectory of any
directory that matches this pattern are maintained
but not files in any directory of those subdirectories.

F:	arch/*/perf/

Any file or any file in any subdirectory of any
directory that matches this pattern is maintained.


