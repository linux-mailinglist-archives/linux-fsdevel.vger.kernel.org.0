Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514136E865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhD2KIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 06:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhD2KId (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:08:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB819613FF;
        Thu, 29 Apr 2021 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619690867;
        bh=VzjPKPK/cmePsjDFGEZjjuJ2zFB4L/Mth+h/t8LCH1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGgbe3jsmGDhoEfb8w9Kr+NCAPqFsplN2yyPxceD5/2LvDGFHlnuLl+xlEtE/O3eq
         MONl+8NDYUdJzwqOuwuX1ZhOpzdpT2eNies1pm3rDAVKW9OAwS9k5EozFvjYsedlWd
         QjDyIlzas82eCSJyDwGvrDSOxzk/sKGjy0EdowDo=
Date:   Thu, 29 Apr 2021 12:07:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] proc: Use seq_read_iter for /proc/*/maps
Message-ID: <YIqFcHj3O2t+JJak@kroah.com>
References: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
 <20210429100508.18502-1-arek_koz@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429100508.18502-1-arek_koz@o2.pl>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 12:05:08PM +0200, Arkadiusz Kozdra (Arusekk) wrote:
> Since seq_read_iter looks mature enough to be used for /proc/<pid>/maps,
> re-allow applications to perform zero-copy data forwarding from it.
> 
> Some executable-inspecting tools rely on patching entry point
> instructions with minimal machine code that uses sendfile to read
> /proc/self/maps to stdout.  The sendfile call allows them to do it
> faster and without excessive allocations.

What programs do that today?  You might want to list them here.

> 
> This is inspired by the series by Cristoph Hellwig (linked).
> 
> Changes since v1:
> 
> only change proc_pid_maps_operations

This should go below the --- line, like the documentation states.

thanks,

greg k-h
