Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17882249D50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgHSMES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgHSLsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5AC061757;
        Wed, 19 Aug 2020 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PyCpVLG0YmaMmn0Hw7lF/5EJbLhYg8ixJD4Pw8ysXnw=; b=b/vBVVWgosD9H72ynSTK/w4+19
        jGyp9XhE8K6E4mnDDmHIOnSKq928xRiSs9wQFe6gRsWtxj861kgb36gnvfVOzi0sDakBIwimphZlR
        Gobrv5KUET/42TFuNCUtIrnBp8q2ocJd94y7z1h+xHUv3fHSywHvvo3e5oRJw7Rnso3xFDz5W6zAY
        bcsyY7JhOEstZEzt8TPYZK5Qo9a64hr8qHYh909lYDEsgstdrfiQT7UmjsbuO1JWVnG8ZYo94NPOy
        XStpTsJI+vE9HrGBzbn/BLL24rqVBJvdF4Sqgt8BkPqFac5pjpyZ2Fo69n0FOvtm6v1G8E/nGPcMt
        iLPKPmRA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8MZP-00034x-W9; Wed, 19 Aug 2020 11:47:56 +0000
Date:   Wed, 19 Aug 2020 12:47:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Add function declaration of simple_dname
Message-ID: <20200819114755.GC17456@casper.infradead.org>
References: <20200819083259.919838-1-leon@kernel.org>
 <20200819113424.GA17456@casper.infradead.org>
 <20200819114001.GU7555@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819114001.GU7555@unreal>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:40:01PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 19, 2020 at 12:34:24PM +0100, Matthew Wilcox wrote:
> > On Wed, Aug 19, 2020 at 11:32:59AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > The simple_dname() is declared in internal header file as extern
> > > and this generates the following GCC warning.
> >
> > The fact that it's declared as extern doesn't matter.  You don't need
> > the change to internal.h at all.  The use of 'extern' on a function
> > declaration is purely decorative:
> >
> >   5 If the declaration of an identifier for a function has no
> >   storage-class specifier, its linkage is determined exactly as if it
> >   were declared with the storage-class specifier extern.
> 
> So why do we need to keep extern keyword if we use intenral.h directly?

We don't.  It's just personal preference.  I don't use extern keywords
on function declarations anywhere, but Al does and it's rude to change it.

