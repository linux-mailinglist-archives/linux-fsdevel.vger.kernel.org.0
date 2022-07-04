Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CE565871
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 16:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiGDORw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiGDORl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:17:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99DAA476;
        Mon,  4 Jul 2022 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=huYW5fOCoYaiUBbhRo6fWg29z4s9u/uhB0RtQtP9fR8=; b=S/zPSmDd4SjssIXtvMa1sEport
        3orBKSAruqOvQ1OXIpQSfYfin4hO7my+1MGd+jWN6xXqQzZR10PqQgZeOwznxD6mPER2N3Nepoqoj
        rEVnkAsFq+iSgmbUSqjzyJJIW2kDtqEaTUr1+Ces1ZUp+PC9RGrgJ7T3rRsywg+c9qwCWWPY+tUj+
        Sw2NhDahbDNGD5pLk84KKA1Ud8CSfbagZH8PTyFj/71BaC4boySWruZur+f9FqIKEjz2xreno1KnF
        CfZC1aAZ0+XfGhSdc/PceMmcZI57TzbD01JOnJ40+SPiT01LjLT5TP2Km0JZQ7ZLdr+tDX/VxXPBo
        41QUBYbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8MtN-00HM68-Ml; Mon, 04 Jul 2022 14:17:37 +0000
Date:   Mon, 4 Jul 2022 15:17:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2af3bc9585be7f23f290@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] WARNING in mark_buffer_dirty (4)
Message-ID: <YsL2gTVwHL0wFvmI@casper.infradead.org>
References: <0000000000008f6f7405e2f81ce9@google.com>
 <YsLHQCvp8W5oObv2@casper.infradead.org>
 <CACT4Y+ZvK0Oxf=Hw7mznmFU=x_zCwC4Ev_Zxo2N0p79DNNi-jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZvK0Oxf=Hw7mznmFU=x_zCwC4Ev_Zxo2N0p79DNNi-jw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:13:13PM +0200, Dmitry Vyukov wrote:
> On Mon, 4 Jul 2022 at 12:56, Matthew Wilcox <willy@infradead.org> wrote:
> > It's clearly none of those commits.  This is a bug in minix, afaict.
> > Judging by the earlier errors, I'd say that it tried to read something,
> > failed, then marked it dirty, at which point we hit an assertion that
> > you shouldn't mark a !uptodate buffer as dirty.  Given that this is
> > minix, I have no interest in pursuing this bug further.  Why is syzbot
> > even testing with minix?
> 
> Shouldn't it? Why? It does not seem to depend on BROKEN.

There is no entry for minix in MAINTAINERS.  Nobody cares about it.
