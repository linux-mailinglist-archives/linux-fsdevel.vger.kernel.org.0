Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867373F29A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjF0D0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjF0DY0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:24:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055F297B;
        Mon, 26 Jun 2023 20:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9X6XpoIa6J8CXoid/9BIg6aA7tW5G1FGnuWyj8aQiYU=; b=JYEa1eFMI9GDLcVf8LtNRvdtYG
        +D7twy61VOFwm9zNXZIFpiP22EvUnBSBl+txxgZyi3Q3TtyUpItpIM5FYDARmB3+QwvlAIdTt3jxm
        p4ZwPnGr9ZsF5DE4imorCn6P1ba6nkIbDbqT0wojyrbQyttqBVgRRRBOsDyO+Ff6w00Rl6Qqjw36+
        VUutzo6Zvc0FvfE81HxkRi2PzFczEJ5INAupkvOwAp8QQG3NOP4Ly+MbLS3zNzraWf0eh9sK2JMFN
        4345PntBF13ZvSiudJEvyVXvivZapYINbYQ+hbPiyBE4XnzXaCyp7yFp0PlLFMefBZjGWmbsxSp/Q
        zjXViWTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDzEr-002KFo-QE; Tue, 27 Jun 2023 03:19:33 +0000
Date:   Tue, 27 Jun 2023 04:19:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZJpVRbBGjU7bvKy4@casper.infradead.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627023337.dordpfdxaad56hdn@moria.home.lan>
 <784c3e6a-75bd-e6ca-535a-43b3e1daf643@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784c3e6a-75bd-e6ca-535a-43b3e1daf643@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:59:44PM -0600, Jens Axboe wrote:
> On 6/26/23 8:33?PM, Kent Overstreet wrote:
> > On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> >> fs/bcachefs/alloc_background.c: In function ?bch2_check_alloc_info?:
> >> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >>  1526 | }
> >>       | ^
> >> fs/bcachefs/reflink.c: In function ?bch2_remap_range?:
> >> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> >>   388 | }
> >>       | ^
> > 
> > What version of gcc are you using? I'm not seeing either of those
> > warnings - I'm wondering if gcc recently got better about stack usage
> > when inlining.
> 
> Using:
> 
> gcc (Debian 13.1.0-6) 13.1.0
> 
> and it's on arm64, fwiw.

OOI what PAGE_SIZE do you have configured?  Sometimes fs data structures
are PAGE_SIZE dependent (haven't looked at this particular bcachefs data
structure).  We've also had weirdness with various gcc versions on some
architectures making different inlining decisions from x86.
