Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33E018D4B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgCTQmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 12:42:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:50282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgCTQmM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:42:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3396AAFB1;
        Fri, 20 Mar 2020 16:42:07 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:42:04 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
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
Subject: Re: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
Message-ID: <20200320164204.GV25468@kitsune.suse.cz>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584699455.git.msuchanek@suse.de>
 <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
 <20200320103350.GV1922688@smile.fi.intel.com>
 <20200320112338.GP25468@kitsune.suse.cz>
 <20200320124251.GW1922688@smile.fi.intel.com>
 <b96c9dd4dba4afca5288a551158659bf545d29fb.camel@perches.com>
 <20200320163157.GF1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320163157.GF1922688@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:31:57PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 20, 2020 at 07:42:03AM -0700, Joe Perches wrote:
> > On Fri, 2020-03-20 at 14:42 +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 20, 2020 at 12:23:38PM +0100, Michal Suchánek wrote:
> > > > On Fri, Mar 20, 2020 at 12:33:50PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Mar 20, 2020 at 11:20:19AM +0100, Michal Suchanek wrote:
> > > > > > While at it also simplify the existing perf patterns.
> > > > > And still missed fixes from parse-maintainers.pl.
> > > > 
> > > > Oh, that script UX is truly ingenious.
> > > 
> > > You have at least two options, their combinations, etc:
> > >  - complain to the author :-)
> > >  - send a patch :-)
> > 
> > Recently:
> > 
> > https://lore.kernel.org/lkml/4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com/
> 
> But why?
> 
> Shouldn't we rather run MAINTAINERS clean up once and require people to use
> parse-maintainers.pl for good?

That cleanup did not happen yet, and I am not volunteering for one.
The difference between MAINTAINERS and MAINTAINERS.new is:

 MAINTAINERS | 5510 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 2755 insertions(+), 2755 deletions(-)

Thanks

Michal
