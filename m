Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C518B874
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCSOAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:00:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgCSOAO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31271AD48;
        Thu, 19 Mar 2020 14:00:11 +0000 (UTC)
Date:   Thu, 19 Mar 2020 15:00:08 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v11 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
Message-ID: <20200319140008.GI25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
 <CAHp75VegYhz-hwSUNHbGFB3yiatAWWytwB7Vctf=mCLyCJEy3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VegYhz-hwSUNHbGFB3yiatAWWytwB7Vctf=mCLyCJEy3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:37:03PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 19, 2020 at 2:21 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v10: new patch
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bc8dbe4fe4c9..329bf4a31412 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13088,6 +13088,8 @@ F:      arch/*/kernel/*/perf_event*.c
> >  F:     arch/*/kernel/*/*/perf_event*.c
> >  F:     arch/*/include/asm/perf_event.h
> >  F:     arch/*/kernel/perf_callchain.c
> > +F:     arch/*/perf/*
> > +F:     arch/*/perf/*/*
> >  F:     arch/*/events/*
> >  F:     arch/*/events/*/*
> >  F:     tools/perf/
> 
> Had you run parse-maintainers.pl?
Did not know it exists. The output is:

scripts/parse-maintainers.pl 
Odd non-pattern line '
Documentation/devicetree/bindings/media/ti,cal.yaml
' for 'TI VPE/CAL DRIVERS' at scripts/parse-maintainers.pl line 147,
<$file> line 16756.

Thanks

Michal
