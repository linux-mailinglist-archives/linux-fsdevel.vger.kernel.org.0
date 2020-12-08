Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E422D334B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgLHUQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731125AbgLHUO0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:14:26 -0500
Date:   Tue, 8 Dec 2020 20:49:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607456918;
        bh=fVuT0f/k7wNMSytrCZt2RdlSHHbmk3oh0C5hQ/KHqAM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOAjwlFc6AKEDgOZAKZ413OBcPqthc1QuRJ6L7zvwjcM86KI9UXhpKIX1X9OL3AUF
         jh5dn/VYBleIOhfrRzFbuU4dCDSfCppl2e3nuNunkFJIc0Tn5r6OVDp6vdE8BqK/kN
         UkEjdyHX3kUyzMiuyl/JaqJxI2jdxKIRoy+sPk1k=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <X8/Y5BXZDcFGzLIW@kroah.com>
References: <20201115155355.GR3576660@ZenIV.linux.org.uk>
 <20201115214125.GA317@Ryzen-9-3900X.localdomain>
 <20201115233814.GT3576660@ZenIV.linux.org.uk>
 <20201115235149.GA252@Ryzen-9-3900X.localdomain>
 <20201116002513.GU3576660@ZenIV.linux.org.uk>
 <20201116003416.GA345@Ryzen-9-3900X.localdomain>
 <20201116032942.GV3576660@ZenIV.linux.org.uk>
 <20201127162902.GA11665@lst.de>
 <20201208163552.GA15052@lst.de>
 <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPeddM90zqyaHzd6g6Cc3NUpg+2my2gX5mR1ydd0ZjNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:34:45AM -0800, Linus Torvalds wrote:
> On Tue, Dec 8, 2020 at 8:35 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Shouldn't this go to Linus before v5.10 is released?
> >
> > ping?
> 
> So by now I'm a bit worried about this series, because the early fixes
> caused more problems than the current state.
> 
> So considering the timing and Al having been spotty, I think this is
> post-5.10 and marked for stable.

If you want some sort of "do these really work" validation, these have
been running for a while now in the android 5.10-rc kernels just fine,
as I cherry-picked the patches there to get past their testing issues.

But if you want to wait until after 5.10 is out, that's fine with me
too, it's up to Al.

thanks,

greg k-h
