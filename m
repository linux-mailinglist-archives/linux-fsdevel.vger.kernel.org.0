Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578EA168FEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgBVP4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 10:56:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbgBVP4W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 10:56:22 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC23C206EF;
        Sat, 22 Feb 2020 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582386982;
        bh=YDQaHQ4HoiCOvY4NXJWuU84Ut3b5JPOGNOmSnmDw1qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MuA2irKY2IdcB2C8kkAZ41BTJYIeAHYgD2CQTHcG4xiO70M0ikEE13LvwG4+CPC3w
         2SY6ynXy4oi5kZfFJYRDK3po397myrUeL/B2Urn/l3yuFF8agkWSpAZTeDu/wDuliA
         StTnY59MZl1QRQ2V0vouCYW2Imj6v8G/Js3RCzXM=
Date:   Sun, 23 Feb 2020 00:56:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [for-next][12/26] Documentation: bootconfig: Add a doc for
 extended boot config
Message-Id: <20200223005615.79f308e2ca0717132bb2887b@kernel.org>
In-Reply-To: <370e675a-598e-71db-8213-f5494b852a71@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
        <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
        <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
        <20200221191637.e9eed4268ff607a98200628c@kernel.org>
        <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
        <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
        <370e675a-598e-71db-8213-f5494b852a71@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 22 Feb 2020 10:48:28 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> * Will a file format description become helpful in the way of
> >>   an extended Backus–Naur form?
> >
> > Good suggestion! Let me try to write an EBNF section.
> 
> Is there a need to provide two format descriptions as separate files
> (so that they can help more for different software users)?
> 
> * RST
> * EBNF

Hmm, since RST is enough flexible, we can write it as a section.
Then user can copy & paste if they need it.

> 
> 
> Will it matter to adjust another wording?
> 
> -/proc/bootconfig is a user-space interface of the boot config.
> +The file “/proc/bootconfig” is an user-space interface to the configuration
> +of system boot parameters.

OK.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
