Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B248447C9D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 00:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhLUXsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 18:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhLUXsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:48:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37768C061574;
        Tue, 21 Dec 2021 15:48:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928CE617CD;
        Tue, 21 Dec 2021 23:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80971C36AE9;
        Tue, 21 Dec 2021 23:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640130497;
        bh=nkeYhgSpZg8GwUUiGealAh8ivf01200zRJ3+PYAI5F8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lh6ssbN33FYDgwbEi+9vBxlu2T+MOua02MEpGQyzfKN01ZRCBbrE/do8B3o+73fsR
         Z/47DiCxrv85LJV0vBqhK6XzEiveRpNugmpuo7OJzQI7cDSCI3pIIXZ/g+p5kHEyEm
         GljPIXcmGYGWNt9J0C6wHsaoV3BaRvcQ9SyvolDo=
Date:   Tue, 21 Dec 2021 15:48:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, siglesias@igalia.com,
        kernel@gpiccoli.net
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
Message-Id: <20211221154816.4a7472c55073d06df0c25f74@linux-foundation.org>
In-Reply-To: <911e81d3-5ffe-b936-f668-bf1f6a9b6cfb@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
        <20211109202848.610874-3-gpiccoli@igalia.com>
        <20211130051206.GB89318@shbuild999.sh.intel.com>
        <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
        <Yb+R/OVeBkdYLWeH@bombadil.infradead.org>
        <911e81d3-5ffe-b936-f668-bf1f6a9b6cfb@igalia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Dec 2021 09:38:23 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> On 19/12/2021 17:11, Luis Chamberlain wrote:
> > mcgrof@sumo ~/linux-next (git::master)$ ./scripts/get_maintainer.pl
> > kernel/printk/
> > Petr Mladek <pmladek@suse.com> (maintainer:PRINTK)
> > Sergey Senozhatsky <senozhatsky@chromium.org> (maintainer:PRINTK)
> > Steven Rostedt <rostedt@goodmis.org> (reviewer:PRINTK)
> > John Ogness <john.ogness@linutronix.de> (reviewer:PRINTK)
> > linux-kernel@vger.kernel.org (open list)    
> > 
> > So I suggest you email the patches to those.
> > 
> >   Luis
> > 
> 
> Hi Luis, thank you! But I confess I'm very confused with this series. I
> saw emails from Andrew that the patches had been accepted and were
> available in -mm tree ([0] for example) but I'm not seeing them in
> linux-next nor mmotm/mmots (although I saw them in mmotm directory for a
> while before).
> 
> Andrew, could you clarify the state of them?

They'll turn up on ozlabs after I've tested it all then uploaded.  I do
this a couple of times a week, approx.
