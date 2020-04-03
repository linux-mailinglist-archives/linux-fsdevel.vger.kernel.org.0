Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4E19D611
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgDCLve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 07:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:37400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDCLve (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2341AC50;
        Fri,  3 Apr 2020 11:51:29 +0000 (UTC)
Date:   Fri, 3 Apr 2020 13:51:27 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Neuling <mikey@neuling.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v11 3/8] powerpc/perf: consolidate read_user_stack_32
Message-ID: <20200403115127.GY25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <184347595442b4ca664613008a09e8cea7188c36.1584620202.git.msuchanek@suse.de>
 <1585039473.da4762n2s0.astroid@bobo.none>
 <20200324193833.GH25468@kitsune.suse.cz>
 <1585896170.ohti800w9v.astroid@bobo.none>
 <20200403105234.GX25468@kitsune.suse.cz>
 <1585913065.zoacp2kzsv.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585913065.zoacp2kzsv.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:26:27PM +1000, Nicholas Piggin wrote:
> Michal Suchánek's on April 3, 2020 8:52 pm:
> > Hello,
> > 
> > there are 3 variants of the function
> > 
> > read_user_stack_64
> > 
> > 32bit read_user_stack_32
> > 64bit read_user_Stack_32
> 
> Right.
> 
> > On Fri, Apr 03, 2020 at 05:13:25PM +1000, Nicholas Piggin wrote:
> [...]
> >>  #endif /* CONFIG_PPC64 */
> >>  
> >> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> >> +{
> >> +	return __read_user_stack(ptr, ret, sizeof(*ret));
> > Does not work for 64bit read_user_stack_32 ^ this should be 4.
> > 
> > Other than that it should preserve the existing logic just fine.
> 
> sizeof(int) == 4 on 64bit so it should work.
> 
Right, the type is different for the 32bit and 64bit version.

Thanks

Michal
