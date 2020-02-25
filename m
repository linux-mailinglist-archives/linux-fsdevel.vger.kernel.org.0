Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3116BA14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 07:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBYGtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 01:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgBYGtN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:49:13 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B6321744;
        Tue, 25 Feb 2020 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582613352;
        bh=DgXDiUaDUM9m4hJUwy/jMW/TY8iDZez/caDnBcs+TS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3RVTcQJfBNPwsb4skoqS2dVbQxIWH6roiPfXWm2KtrVipw+BbELKguGsR4dgLle9
         tzpnSsYo02/LUUpDAm3BAS3u6VvWME0nsYCRgRRL/1zz+hLQwYmAKxHQfjjfP2CxVF
         xeBLEZHGTmFqAMOZW5sjDFIY0sq4AuUKUJfBj0aI=
Date:   Tue, 25 Feb 2020 15:49:03 +0900
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
Message-Id: <20200225154903.f636acde809a304bfccf4995@kernel.org>
In-Reply-To: <25dd284f-6122-c01b-ef22-901c3e0bdf37@web.de>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
        <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
        <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
        <20200221191637.e9eed4268ff607a98200628c@kernel.org>
        <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
        <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
        <370e675a-598e-71db-8213-f5494b852a71@web.de>
        <20200223005615.79f308e2ca0717132bb2887b@kernel.org>
        <8cc7e621-c5e3-28fa-c789-0bb7c55d77d6@web.de>
        <20200224121302.5b730b519d550eb34da720a5@kernel.org>
        <25dd284f-6122-c01b-ef22-901c3e0bdf37@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 24 Feb 2020 11:00:31 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > OK, I'll try to make a split EBNF file and include it.
> 
> Thanks for your positive feedback.
> 
> 
> How do you think about to clarify any additional software design options
> around involved data structures?

Sorry, what would you mean the "involved data structures" here?
Would you mean the usage of APIs or when to use bootconfig or command line?

Thank you,

> 
> Regards,
> Markus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
