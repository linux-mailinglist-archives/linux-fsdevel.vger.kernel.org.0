Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FBF1418E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 19:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgARSOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 13:14:46 -0500
Received: from [198.137.202.133] ([198.137.202.133]:43614 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgARSOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mvuOsQkcZjjRDowb6eekYJRCz3KvvZzwZFNceeJcvbs=; b=W6bNYhvVL1XqbFLh1uBK5Kgfa
        Eo/gkYdtwFumaJGiT4oAj7P37rAZOfHWhm2F9l0GhoOguuyyD98BbyjFE/b4NsmdW2qfQjttknBOH
        1ZTM114aqLm+H5LPu6GwSP50pnZy9EYW5JIpklykSGEhzl2wNpTOCbh5r/64GXm4cYWQqoK+1XGt5
        h2/ZdhZz9QFwY3Nq8FcelirJpsX8m+XRLk1PRqu56QkOeYeF4SMCIT3Nh0pT7vksdoNLv5DtTvqyk
        rmTstVJpG7mlgJOEFHOq3JliXwW1FnUls0BY7EIQo/QJjUzGNuyjsry3zd+jyrcg3q+J/NvlFd1Nt
        EC2tLrlZg==;
Received: from [2603:3004:32:9a00::ce80]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1issbp-0005ez-OT; Sat, 18 Jan 2020 18:14:09 +0000
Subject: Re: [PATCH v6 22/22] Documentation: tracing: Add boot-time tracing
 document
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867246028.17873.8047384554383977870.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <da3c941a-f7a2-537e-9201-862450cb69d9@infradead.org>
Date:   Sat, 18 Jan 2020 10:14:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157867246028.17873.8047384554383977870.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Here are a few editorial comments for you...


On 1/10/20 8:07 AM, Masami Hiramatsu wrote:
> Add a documentation about boot-time tracing options in
> boot config.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |    2 
>  Documentation/trace/boottime-trace.rst   |  184 ++++++++++++++++++++++++++++++
>  Documentation/trace/index.rst            |    1 
>  3 files changed, 187 insertions(+)
>  create mode 100644 Documentation/trace/boottime-trace.rst
> 

> diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
> new file mode 100644
> index 000000000000..1d10fdebf1b2
> --- /dev/null
> +++ b/Documentation/trace/boottime-trace.rst
> @@ -0,0 +1,184 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Boot-time tracing
> +=================
> +
> +:Author: Masami Hiramatsu <mhiramat@kernel.org>
> +
> +Overview
> +========
> +
> +Boot-time tracing allows users to trace boot-time process including
> +device initialization with full features of ftrace including per-event
> +filter and actions, histograms, kprobe-events and synthetic-events,
> +and trace instances.
> +Since kernel cmdline is not enough to control these complex features,
> +this uses bootconfig file to describe tracing feature programming.
> +
> +Options in the Boot Config
> +==========================
> +
> +Here is the list of available options list for boot time tracing in
> +boot config file [1]_. All options are under "ftrace." or "kernel."
> +refix. See kernel parameters for the options which starts

   prefix.

> +with "kernel." prefix [2]_.
> +
> +.. [1] See :ref:`Documentation/admin-guide/bootconfig.rst <bootconfig>`
> +.. [2] See :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
> +
> +Ftrace Global Options
> +---------------------
> +
> +Ftrace global options have "kernel." prefix in boot config, which means
> +these options are passed as a part of kernel legacy command line.
> +
> +kernel.tp_printk
> +   Output trace-event data on printk buffer too.
> +
> +kernel.dump_on_oops [= MODE]
> +   Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
> +   on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.
> +
> +kernel.traceoff_on_warning
> +   Stop tracing if WARN_ON() occurs.
> +
> +kernel.fgraph_max_depth = MAX_DEPTH
> +   Set MAX_DEPTH to maximum depth of fgraph tracer.
> +
> +kernel.fgraph_filters = FILTER[, FILTER2...]
> +   Add fgraph tracing function filters.
> +
> +kernel.fgraph_notraces = FILTER[, FILTER2...]
> +   Add fgraph non tracing function filters.

                 non-tracing

> +
> +
> +Ftrace Per-instance Options
> +---------------------------
> +
> +These options can be used for each instance including global ftrace node.
> +
> +ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]]
> +   Enable given ftrace options.
> +
> +ftrace.[instance.INSTANCE.]trace_clock = CLOCK
> +   Set given CLOCK to ftrace's trace_clock.
> +
> +ftrace.[instance.INSTANCE.]buffer_size = SIZE
> +   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
> +   for that SIZE.
> +
> +ftrace.[instance.INSTANCE.]alloc_snapshot
> +   Allocate snapshot buffer.
> +
> +ftrace.[instance.INSTANCE.]cpumask = CPUMASK
> +   Set CPUMASK as trace cpu-mask.
> +
> +ftrace.[instance.INSTANCE.]events = EVENT[, EVENT2[...]]
> +   Enable given events on boot. You can use a wild card in EVENT.
> +
> +ftrace.[instance.INSTANCE.]tracer = TRACER
> +   Set TRACER to current tracer on boot. (e.g. function)
> +
> +ftrace.[instance.INSTANCE.]ftrace.filters
> +   This will take an array of tracing function filter rules

end with '.' as above descriptions.

> +
> +ftrace.[instance.INSTANCE.]ftrace.notraces
> +   This will take an array of NON-tracing function filter rules

ditto

> +
> +
> +Ftrace Per-Event Options
> +------------------------
> +
> +These options are setting per-event options.
> +
> +ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable
> +   Enables GROUP:EVENT tracing.

      Enable

> +
> +ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER
> +   Set FILTER rule to the GROUP:EVENT.
> +
> +ftrace.[instance.INSTANCE.]event.GROUP.EVENT.actions = ACTION[, ACTION2[...]]
> +   Set ACTIONs to the GROUP:EVENT.
> +
> +ftrace.[instance.INSTANCE.]event.kprobes.EVENT.probes = PROBE[, PROBE2[...]]
> +   Defines new kprobe event based on PROBEs. It is able to define
> +   multiple probes on one event, but those must have same type of
> +   arguments. This option is available only for the event which
> +   group name is "kprobes".
> +
> +ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2[...]]
> +   Defines new synthetic event with FIELDs. Each field should be
> +   "type varname".
> +
> +Note that kprobe and synthetic event definitions can be written under
> +instance node, but those are also visible from other instances. So please
> +take care for event name conflict.
> +
> +
> +Examples
> +========
> +
> +For example, to add filter and actions for each event, define kprobe
> +events, and synthetic events with histogram, write a boot config like
> +below::
> +
> +  ftrace.event {
> +        task.task_newtask {
> +                filter = "pid < 128"
> +                enable
> +        }
> +        kprobes.vfs_read {
> +                probes = "vfs_read $arg1 $arg2"
> +                filter = "common_pid < 200"
> +                enable
> +        }
> +        synthetic.initcall_latency {
> +                fields = "unsigned long func", "u64 lat"
> +                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat"
> +        }
> +        initcall.initcall_start {
> +                actions = "hist:keys=func:ts0=common_timestamp.usecs"
> +        }
> +        initcall.initcall_finish {
> +                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)"
> +        }
> +  }
> +
> +Also, boottime tracing supports "instance" node, which allows us to run

         boot-time  [for consistency]

> +several tracers for different purpose at once. For example, one tracer
> +is for tracing functions start with "user\_", and others tracing "kernel\_"

                            starting

> +functions, you can write boot config as below::
> +
> +  ftrace.instance {
> +        foo {
> +                tracer = "function"
> +                ftrace.filters = "user_*"
> +        }
> +        bar {
> +                tracer = "function"
> +                ftrace.filters = "kernel_*"
> +        }
> +  }
> +
> +The instance node also accepts event nodes so that each instance
> +can customize its event tracing.
> +
> +This boot-time tracing also supports ftrace kernel parameters via boot
> +config.
> +For example, following kernel parameters::
> +
> + trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
> +
> +This can be written in boot config like below::
> +
> +  kernel {
> +        trace_options = sym-addr
> +        trace_event = "initcall:*"
> +        tp_printk
> +        trace_buf_size = 1M
> +        ftrace = function
> +        ftrace_filter = "vfs*"
> +  }
> +
> +Note that parameters start with "kernel" prefix instead of "ftrace".

HTH.
-- 
~Randy
