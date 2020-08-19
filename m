Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C1249CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 13:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHSL6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 07:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgHSL6Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:58:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C2E2072D;
        Wed, 19 Aug 2020 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597838305;
        bh=+KzvlrBA8Y1hfNHoDtGEqigNI9kRf2X7V+bdyuzh9LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zruNW+fgYSvWrhjePFXyJYq++njgi7vwQe62Jg1qH+yewDhZ5yg/j7+PCKb31AOLp
         j5feP3i7jxTq+N1lM0mV/H/yQCh8b4g8LXjhugxZu7iq8dO6dIWWoRYTCjqgXlVNIn
         ZPhNQ4sY2LuAQBTlXH9dGmk3aVp21JRA8B3AY+rg=
Date:   Wed, 19 Aug 2020 14:58:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Add function declaration of simple_dname
Message-ID: <20200819115821.GV7555@unreal>
References: <20200819083259.919838-1-leon@kernel.org>
 <20200819113424.GA17456@casper.infradead.org>
 <20200819114001.GU7555@unreal>
 <20200819114755.GC17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819114755.GC17456@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:47:55PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 02:40:01PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 19, 2020 at 12:34:24PM +0100, Matthew Wilcox wrote:
> > > On Wed, Aug 19, 2020 at 11:32:59AM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > >
> > > > The simple_dname() is declared in internal header file as extern
> > > > and this generates the following GCC warning.
> > >
> > > The fact that it's declared as extern doesn't matter.  You don't need
> > > the change to internal.h at all.  The use of 'extern' on a function
> > > declaration is purely decorative:
> > >
> > >   5 If the declaration of an identifier for a function has no
> > >   storage-class specifier, its linkage is determined exactly as if it
> > >   were declared with the storage-class specifier extern.
> >
> > So why do we need to keep extern keyword if we use intenral.h directly?
>
> We don't.  It's just personal preference.  I don't use extern keywords
> on function declarations anywhere, but Al does and it's rude to change it.

I didn't have any intention to be rude, just like you, I don't use extern keyword.

I'll resend to make a progress.

Thanks

>
