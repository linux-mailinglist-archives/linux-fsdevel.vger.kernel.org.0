Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC618CBAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 11:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCTKd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 06:33:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:1057 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgCTKd6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:33:58 -0400
IronPort-SDR: tsiJb2PXNe6dG/YOdJo0BY4Xw+EBdz0Eqf3MAUdZD7Kx/etQnH71yUWNjH8n7RknkHKnxj4XqV
 z/8plm6znvoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 03:33:57 -0700
IronPort-SDR: dvyOOwpm3ck0vNEcjFg0Ln9rtXpCUZTdZcp6iT/sMJoJaRldBYM8OWYnTUButP6k1/hcmEEsxM
 R4UhrSvV447g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="446612540"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2020 03:33:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jFEyM-00BKoR-Uc; Fri, 20 Mar 2020 12:33:50 +0200
Date:   Fri, 20 Mar 2020 12:33:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Suchanek <msuchanek@suse.de>
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
Subject: Re: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
Message-ID: <20200320103350.GV1922688@smile.fi.intel.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584699455.git.msuchanek@suse.de>
 <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:20:19AM +0100, Michal Suchanek wrote:
> While at it also simplify the existing perf patterns.
> 

And still missed fixes from parse-maintainers.pl.

I see it like below in the linux-next (after the script)

PERFORMANCE EVENTS SUBSYSTEM
M:      Peter Zijlstra <peterz@infradead.org>
M:      Ingo Molnar <mingo@redhat.com>
M:      Arnaldo Carvalho de Melo <acme@kernel.org>
R:      Mark Rutland <mark.rutland@arm.com>
R:      Alexander Shishkin <alexander.shishkin@linux.intel.com>
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>
L:      linux-kernel@vger.kernel.org
S:      Supported
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
F:      arch/*/events/*
F:      arch/*/events/*/*
F:      arch/*/include/asm/perf_event.h
F:      arch/*/kernel/*/*/perf_event*.c
F:      arch/*/kernel/*/perf_event*.c
F:      arch/*/kernel/perf_callchain.c
F:      arch/*/kernel/perf_event*.c
F:      include/linux/perf_event.h
F:      include/uapi/linux/perf_event.h
F:      kernel/events/*
F:      tools/perf/

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13080,7 +13080,7 @@ R:	Namhyung Kim <namhyung@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>  S:	Supported
> -F:	kernel/events/*
> +F:	kernel/events/
>  F:	include/linux/perf_event.h
>  F:	include/uapi/linux/perf_event.h
>  F:	arch/*/kernel/perf_event*.c
> @@ -13088,8 +13088,8 @@ F:	arch/*/kernel/*/perf_event*.c
>  F:	arch/*/kernel/*/*/perf_event*.c
>  F:	arch/*/include/asm/perf_event.h
>  F:	arch/*/kernel/perf_callchain.c
> -F:	arch/*/events/*
> -F:	arch/*/events/*/*
> +F:	arch/*/events/
> +F:	arch/*/perf/
>  F:	tools/perf/
>  
>  PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS

-- 
With Best Regards,
Andy Shevchenko


