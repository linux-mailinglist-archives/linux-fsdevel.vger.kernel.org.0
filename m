Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC918B951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCSO0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:26:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:29584 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgCSO0y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:26:54 -0400
IronPort-SDR: jkMZd+2+AWRiqyaOehU72nPQumHw732tr+Et8XJa6erIJ6nQngOhlUlR1hIxFnpfkGN5cZnYjm
 n6FofFRp/HgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 07:26:54 -0700
IronPort-SDR: 5wTAmaiKMB7UbpfYe+dYHV7dUABogcaNY8bPZRYQ71HS0BVNr9wCzGBPFMG42llbBUh2bSaoNo
 vUJevmIpj65Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="234187796"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2020 07:26:43 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jEw87-00B637-Ar; Thu, 19 Mar 2020 16:26:39 +0200
Date:   Thu, 19 Mar 2020 16:26:39 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
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
Message-ID: <20200319142639.GL1922688@smile.fi.intel.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584620202.git.msuchanek@suse.de>
 <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
 <CAHp75VegYhz-hwSUNHbGFB3yiatAWWytwB7Vctf=mCLyCJEy3Q@mail.gmail.com>
 <20200319140008.GI25468@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319140008.GI25468@kitsune.suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 03:00:08PM +0100, Michal Suchánek wrote:
> On Thu, Mar 19, 2020 at 03:37:03PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 19, 2020 at 2:21 PM Michal Suchanek <msuchanek@suse.de> wrote:
> > >
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > > v10: new patch
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index bc8dbe4fe4c9..329bf4a31412 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -13088,6 +13088,8 @@ F:      arch/*/kernel/*/perf_event*.c
> > >  F:     arch/*/kernel/*/*/perf_event*.c
> > >  F:     arch/*/include/asm/perf_event.h
> > >  F:     arch/*/kernel/perf_callchain.c
> > > +F:     arch/*/perf/*
> > > +F:     arch/*/perf/*/*
> > >  F:     arch/*/events/*
> > >  F:     arch/*/events/*/*
> > >  F:     tools/perf/
> > 
> > Had you run parse-maintainers.pl?
> Did not know it exists. The output is:
> 
> scripts/parse-maintainers.pl 
> Odd non-pattern line '
> Documentation/devicetree/bindings/media/ti,cal.yaml
> ' for 'TI VPE/CAL DRIVERS' at scripts/parse-maintainers.pl line 147,
> <$file> line 16756.

It is fixed in media tree and available in linux next as

d44535cb14c9 ("media: MAINTAINERS: Sort entries in database for TI VPE/CAL")

-- 
With Best Regards,
Andy Shevchenko


