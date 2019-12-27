Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159C012B0C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 03:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfL0C4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 21:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfL0C4r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 21:56:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0627E2080D;
        Fri, 27 Dec 2019 02:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577415406;
        bh=0YahA+kvULGCzgYTT42hVi0RhV0OrR9aY60pCf42HFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sSeru6vWGtL9u3Fpf4KCIntPCRYwJCs1WtLdg2U6hnAIsq7JAL+R3jxHlMRDKmVF9
         Z7eN83Ar28MkrbRRvYBbjorunwCzgwxtb7IFCR5ysSpPmUiko2ovtE5ULv/JkhrjkG
         +k1pqaNG0Fs23lKT4ED8wuVeLQr+QfwwP5raKSCc=
Date:   Fri, 27 Dec 2019 11:56:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH v5 21/22] tracing/boot: Add function tracer filter
 options
Message-Id: <20191227115639.d6c33d51d2b10f33dbd05796@kernel.org>
In-Reply-To: <201912270227.Dwa2YddH%lkp@intel.com>
References: <157736928302.11126.8760178688093051786.stgit@devnote2>
        <201912270227.Dwa2YddH%lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Oops, the ftrace_set_filter/notrace_filter depend on CONFIG_DYNAMIC_FTRACE, not CONFIG_FUNCTION_TRACER

Thanks, I'll fix it.

On Fri, 27 Dec 2019 02:05:11 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on lwn/docs-next linus/master v5.5-rc3]
> [cannot apply to tip/perf/core next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-bootconfig-Boot-time-tracing-and-Extra-boot-config/20191227-002009
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from kernel/trace/trace_boot.c:9:0:
> >> include/linux/ftrace.h:719:50: error: expected identifier or '(' before '{' token
>     #define ftrace_set_filter(ops, buf, len, reset) ({ -ENODEV; })
>                                                      ^
> >> kernel/trace/trace_boot.c:249:12: note: in expansion of macro 'ftrace_set_filter'
>     extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
>                ^~~~~~~~~~~~~~~~~
>    include/linux/ftrace.h:720:51: error: expected identifier or '(' before '{' token
>     #define ftrace_set_notrace(ops, buf, len, reset) ({ -ENODEV; })
>                                                       ^
> >> kernel/trace/trace_boot.c:251:12: note: in expansion of macro 'ftrace_set_notrace'
>     extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
>                ^~~~~~~~~~~~~~~~~~
> --
>    In file included from kernel//trace/trace_boot.c:9:0:
> >> include/linux/ftrace.h:719:50: error: expected identifier or '(' before '{' token
>     #define ftrace_set_filter(ops, buf, len, reset) ({ -ENODEV; })
>                                                      ^
>    kernel//trace/trace_boot.c:249:12: note: in expansion of macro 'ftrace_set_filter'
>     extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
>                ^~~~~~~~~~~~~~~~~
>    include/linux/ftrace.h:720:51: error: expected identifier or '(' before '{' token
>     #define ftrace_set_notrace(ops, buf, len, reset) ({ -ENODEV; })
>                                                       ^
>    kernel//trace/trace_boot.c:251:12: note: in expansion of macro 'ftrace_set_notrace'
>     extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
>                ^~~~~~~~~~~~~~~~~~
> 
> vim +/ftrace_set_filter +249 kernel/trace/trace_boot.c
> 
>    246	
>    247	#ifdef CONFIG_FUNCTION_TRACER
>    248	extern bool ftrace_filter_param __initdata;
>  > 249	extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
>    250				     int len, int reset);
>  > 251	extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
>    252				      int len, int reset);
>    253	static void __init
>    254	trace_boot_set_ftrace_filter(struct trace_array *tr, struct xbc_node *node)
>    255	{
>    256		struct xbc_node *anode;
>    257		const char *p;
>    258		char *q;
>    259	
>    260		xbc_node_for_each_array_value(node, "ftrace.filters", anode, p) {
>    261			q = kstrdup(p, GFP_KERNEL);
>    262			if (!q)
>    263				return;
>    264			if (ftrace_set_filter(tr->ops, q, strlen(q), 0) < 0)
>    265				pr_err("Failed to add %s to ftrace filter\n", p);
>    266			else
>    267				ftrace_filter_param = true;
>    268			kfree(q);
>    269		}
>    270		xbc_node_for_each_array_value(node, "ftrace.notraces", anode, p) {
>    271			q = kstrdup(p, GFP_KERNEL);
>    272			if (!q)
>    273				return;
>    274			if (ftrace_set_notrace(tr->ops, q, strlen(q), 0) < 0)
>    275				pr_err("Failed to add %s to ftrace filter\n", p);
>    276			else
>    277				ftrace_filter_param = true;
>    278			kfree(q);
>    279		}
>    280	}
>    281	#else
>    282	#define trace_boot_set_ftrace_filter(tr, node) do {} while (0)
>    283	#endif
>    284	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


-- 
Masami Hiramatsu <mhiramat@kernel.org>
