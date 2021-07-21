Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E73D127C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbhGUOy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbhGUOyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4193C061575;
        Wed, 21 Jul 2021 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=F1HkRtwO5o+WxT6GOYP45YePCB4l9BbyHzYYxH5T5Xs=; b=eLsThB/CDlZCufGzaSX4ULp2zP
        P8jVsjC6f5zaTSeUh+umzjFydkjKQ/0M16si+HrUDIuBb4dGxA7JYdIj4NfUUwzRdjxURUWL/fYgI
        fgRIR5bdanCZ0Hoq2ecc/jzIhP++f65G0/OpTDpMtNdiS+QPK394RsN+hhTgE+X0fJwHIQckuFGY1
        TjUOS612P6+k72VSFEeoU9C6nghW4Hm9UtTlb/i8Yhw8XeMUn7J1fG8LLpTdjUnBFe9rpTxWYLkwb
        B4bbcaHIojEwGM2Q1X9ZCHWBQ2221Qvij2KsY2oEYCXCfNlG3nH/UCYlSwynJG7hbTyFQrX9NRaWo
        7mwBPACQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EFN-009L6G-OC; Wed, 21 Jul 2021 15:35:02 +0000
Date:   Wed, 21 Jul 2021 16:34:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter.Enderborg@sony.com
Cc:     hch@infradead.org, tege@sics.se, nborisov@suse.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
Message-ID: <YPg+oSsrb5iiWT4A@casper.infradead.org>
References: <20210721135926.602840-1-nborisov@suse.com>
 <YPgwATAQBfU2eeOk@infradead.org>
 <b1fdda4c-5f2a-a86a-0407-1591229bb241@suse.com>
 <YPgyQsG7PFLL8yE3@infradead.org>
 <YPg0Ylbmk4qIZ/63@casper.infradead.org>
 <0c3b5f75-3a8e-2b99-9032-d8e394db2a5d@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c3b5f75-3a8e-2b99-9032-d8e394db2a5d@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 03:17:53PM +0000, Peter.Enderborg@sony.com wrote:
> On 7/21/21 4:51 PM, Matthew Wilcox wrote:
> > On Wed, Jul 21, 2021 at 03:42:10PM +0100, Christoph Hellwig wrote:
> >> On Wed, Jul 21, 2021 at 05:35:42PM +0300, Nikolay Borisov wrote:
> >>>
> >>> On 21.07.21 ??. 17:32, Christoph Hellwig wrote:
> >>>> This seems to have lost the copyright notices from glibc.
> >>>>
> >>> I copied over only the code, what else needs to be brought up:
> >>>
> >>>  Copyright (C) 1991-2021 Free Software Foundation, Inc.
> >>>    This file is part of the GNU C Library.
> >>>    Contributed by Torbjorn Granlund (tege@sics.se).
> >>>
> >>> The rest is the generic GPL license txt ?
> >> Last time I checked glibc is under LGPL.
> > This particular file is under LGPL-2.1, so we can distribute it under
> > GPL 2.
> 
> Sure. But should not Torbjörn Granlund have some cred?

I didn't say we could remove his copyright.  It's clearly still
copyright Torbjörn.
