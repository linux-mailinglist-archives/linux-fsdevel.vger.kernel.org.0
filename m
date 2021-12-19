Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4A47A202
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 21:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhLSULp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Dec 2021 15:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSULo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:11:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A124C061574;
        Sun, 19 Dec 2021 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4h6NPaUlmZgxir2424x/Qf/OO7HJPde/NgVzMLtT4Ig=; b=e0zd389yAG+hzti3DV7WFxKv8c
        A2Y8qkC1OJ+Siz/+zVwBEQA1dNMbJsg8TCsrbc3dIFx9VDBTxAvkdW3c4b19d8vhbwvEWz2VY1BGn
        V32jWf0HjcKLIuDlvpORzpEkz6qPys5xBX59QhK0C4mwOyLw5gdfZa6w+3SzMuxkyXiaS+UQGXMMB
        Dxb+8GROS8t4L89qod7wWnPxMqlu1+3daysJEosN0Lkxd6xViVTDJijvT2QBrsuqA5yxk2Fi47lNB
        8/WiE4kLFiRZ/Yc9XccsfyDKqEZwLvq3IuA/rM72FilyRb6T+VNXEdUO0GrIvH9G2bkZPZssiTGIC
        6g6d/4Kw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz2Wy-00GvAC-PT; Sun, 19 Dec 2021 20:11:40 +0000
Date:   Sun, 19 Dec 2021 12:11:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, siglesias@igalia.com,
        kernel@gpiccoli.net
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
Message-ID: <Yb+R/OVeBkdYLWeH@bombadil.infradead.org>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
 <20211130051206.GB89318@shbuild999.sh.intel.com>
 <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:09:06PM -0300, Guilherme G. Piccoli wrote:
> On 30/11/2021 02:12, Feng Tang wrote:
> > On Tue, Nov 09, 2021 at 05:28:47PM -0300, Guilherme G. Piccoli wrote:
> >> [...]
> > This looks to be helpful for debugging panic.
> > 
> > Reviewed-by: Feng Tang <feng.tang@intel.com>
> > 
> > Thanks,
> > Feng
> 
> Thanks a lot Feng, for both your reviews! Do you have any opinions about
> patch 3?
> 
> Also, as a generic question to all CCed, what is the way forward with
> this thread?
> Cheers,

mcgrof@sumo ~/linux-next (git::master)$ ./scripts/get_maintainer.pl
kernel/printk/
Petr Mladek <pmladek@suse.com> (maintainer:PRINTK)
Sergey Senozhatsky <senozhatsky@chromium.org> (maintainer:PRINTK)
Steven Rostedt <rostedt@goodmis.org> (reviewer:PRINTK)
John Ogness <john.ogness@linutronix.de> (reviewer:PRINTK)
linux-kernel@vger.kernel.org (open list)    

So I suggest you email the patches to those.

  Luis
