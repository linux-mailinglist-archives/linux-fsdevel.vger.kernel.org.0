Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4223AB9A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgHCRWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 13:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgHCRWl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:22:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7850F20792;
        Mon,  3 Aug 2020 17:22:38 +0000 (UTC)
Date:   Mon, 3 Aug 2020 13:22:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Subject: Re: [PATCH v6 08/22] bootconfig: init: Allow admin to use
 bootconfig for init command line
Message-ID: <20200803132238.1e40aa37@oasis.local.home>
In-Reply-To: <20200803152959.GA1168816@rani.riverdale.lan>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
        <157867229521.17873.654222294326542349.stgit@devnote2>
        <202002070954.C18E7F58B@keescook>
        <20200207144603.30688b94@oasis.local.home>
        <20200802023318.GA3981683@rani.riverdale.lan>
        <20200804000345.f5727ac28647aa8c092cc109@kernel.org>
        <20200803152959.GA1168816@rani.riverdale.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Aug 2020 11:29:59 -0400
Arvind Sankar <nivedita@alum.mit.edu> wrote:

> > +	/* parse_args() stops at '--' and returns an address */
> > +	if (!IS_ERR(err) && err)
> > +		initargs_found = true;
> > +  
> 
> I think you can drop the second IS_ERR, since we already checked that.

Masami,

Can you send this with the update as a normal patch (not a Cc to this
thread). That way it gets caught by my patchwork scanning of my inbox.

Thanks!

(/me is currently going through all his patchwork patches to pull in
for the merge window.)

-- Steve
