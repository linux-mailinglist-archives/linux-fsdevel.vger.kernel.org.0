Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD95649C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiGCUtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGCUtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:49:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246202BEC;
        Sun,  3 Jul 2022 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QpI+jTlk+Kd7BzRu5Sjdz+ugP8vrCHNRXJi4LJAgPOM=; b=nMWsgmAnRV9wPBZ4+pCkKG47eA
        c2pvj04f+V9+MY8ccDD5ZsWnM2KvoRSvYA8KIsFZwknqBuNEP2+p3J2jW8GZMRt518kWl/yQ8tCdE
        rD7hKxEji1afDmiVZ6x2yJwieGtZQilaGD+TS0qSbbCBX1GSHwahb0Fyo5RWyN38XC9fJcc2MdehG
        Zg/dDLM6DC85svVApSGonVWdO7M7+vGNQQCKQ5dg8OTulwrYj9dhctjusD1LAD23BUXhI8A5aPlCV
        2SSRnLVtGiXhF+AzhR1RaQ2+bBfX08AoEWbhomRncqQ6GZzZEb5uBFtcVK2NAXMHvq93Jk+obyOZd
        cb06p/iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o86Wo-00Gh7h-2q; Sun, 03 Jul 2022 20:49:14 +0000
Date:   Sun, 3 Jul 2022 21:49:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] treewide: idr: align IDR and IDA APIs
Message-ID: <YsIAypeKXFg97xbG@casper.infradead.org>
References: <20220703181739.387584-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220703181739.387584-1-dakr@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:17:38PM +0200, Danilo Krummrich wrote:
> For allocating IDs the ID allocator (IDA) provides the following
> functions: ida_alloc(), ida_alloc_range(), ida_alloc_min() and
> ida_alloc_max() whereas for IDRs only idr_alloc() is available.
> 
> In contrast to ida_alloc(), idr_alloc() behaves like ida_alloc_range(),
> which takes MIN and MAX arguments to define the bounds within an ID
> should be allocated - ida_alloc() instead implicitly uses the maximal
> bounds possible for MIN and MAX without taking those arguments.
> 
> In order to align the IDR and IDA APIs this patch provides
> implementations for idr_alloc(), idr_alloc_range(), idr_alloc_min() and
> idr_alloc_max(), which are analogue to the IDA API.

I don't really want to make any changes to the IDR API.  I want to get
rid of the IDR API.  I'm sorry you did all this work, but you should
probaby talk to the maintainer before embarking on such a big project.

If you're interested, converting IDR users to the XArray API is an
outstanding project that I'd be interested in encouraging.
