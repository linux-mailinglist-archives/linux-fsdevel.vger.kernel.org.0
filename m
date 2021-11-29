Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCC461A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbhK2PBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 10:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbhK2O7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:59:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C257C043CDC;
        Mon, 29 Nov 2021 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uFslM07ffLLvzbH8XfuLXOVOfxxiSvhqEg9B4ukKHeA=; b=pS/6NVkLnN99rjMs4qifjOJLCg
        DyTIjKlMryTgcRczKYUcA0OMgK6PsE8651vd/qjUNIgSBXxla2SMOZJniI2EIGXF+j8tWFvK4Fcl0
        hrBev5zy4oRX9N+CCcArUX+ke+Ie62gm+BpgiHnEa/1Uc6LNlba2jenpNeg/LK4ipbqDdDmCFKbIj
        4SCZTTuY5sskQkqcLmNfhE94H4e051/4VmsuVst1IpREXbtUWDKhVt5KwNSvQRQbxvB5zj8pu4VWm
        cMK26EpFTiYhwkGyg0v8pzsH1jxjDzIlm6483vXKjo8RP5DuZZDTdezyGNQLzE0rvRcVfvFPpu26c
        e+9ty1mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrgZ3-007gQb-Dd; Mon, 29 Nov 2021 13:19:25 +0000
Date:   Mon, 29 Nov 2021 13:19:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
Message-ID: <YaTTXSTiOpL1/ymL@casper.infradead.org>
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
 <941c9239-3b73-c2ae-83aa-f83d4e587fc8@infradead.org>
 <e06a86b2-1624-986c-9e97-ffac121dc240@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e06a86b2-1624-986c-9e97-ffac121dc240@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:06:09PM +0800, Tianjia Zhang wrote:
> Hi Randy,
> 
> On 11/17/21 7:00 AM, Randy Dunlap wrote:
> > On 11/16/21 12:06 AM, Tianjia Zhang wrote:
> > > Eliminate the following clang compilation warnings by adding or
> > > fixing function comment:
> > 
> > These are from clang?  They all appear to be from scripts/kernel-doc.
> > 
> > Can someone please clarify?
> > 
> > thanks.
> 
> Yes, compile with W=1, clang will report this warning.

No, clang has nothing to do with it.  The warnings are from kernel-doc,
not clang.  Nor gcc.
