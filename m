Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2728A31FE67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 18:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBSRyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 12:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhBSRx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:53:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F3C061756;
        Fri, 19 Feb 2021 09:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DpJIXqTDzO/x763liA6RQLEdv/ADHIQ+yoQ4Md32Szw=; b=U5N1GpYMNHkrngFmVypkXI6b3a
        XMTJJ3wGoaMJhaACv43pIp8/ZgYdjJaCFmAJv4lgLp74qh3qvaEE213+F+B7e3E09vqDduP9JayTA
        AqSYnZ0VQ3dL+hx7DQRt/xqWGByHvkVFrjzPrpc2acnYR2LF+kgzdS3yT1rnEF74fQRSfUL/SSUgb
        kjaO/Tl3m4SCyIZpOQj5nhwTe++Jh8KtO8+7zTb8vD5GYwCdLLCLG6fFD9MsC16vXWZXYbOo7bcMK
        v3X4/1fGfx8q+QrK+NP5Tp2IooRQiTFIEMjtYfIvgQMaWj78kLsCkmEeuRydFnTFBYJdxMiLRp3AZ
        1+KPicmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lD9vo-00382g-Sz; Fri, 19 Feb 2021 17:51:31 +0000
Date:   Fri, 19 Feb 2021 17:51:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210219175108.GV2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
 <20210219142201.GU2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219142201.GU2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:22:01PM +0000, Matthew Wilcox wrote:
> In the last decade, nobody's tried to fix it in mainline that I know of.
> As I said, some vendors have tried to fix it in their NAS products,
> but I don't know where to find that patch any more.

Arnd found it for me.

https://sourceforge.net/projects/dsgpl/files/Synology%20NAS%20GPL%20Source/25426branch/alpine-source/linux-3.10.x-bsp.txz/download

They've done a perfect job of making the source available while making it
utterly dreadful to extract anything useful from.

 16084 files changed, 1322769 insertions(+), 285257 deletions(-)

It's full of gratuitous whitespace changes to files that definitely
aren't used (arch/alpha?  really?) and they've stripped out a lot of
comments that they didn't need to touch.

Forward porting a patch from 10 years ago wouldn't be easy, even if
they hadn't tried very hard to obfuscate their patch.  I don't think
this will be a fruitful line of inquiry.
