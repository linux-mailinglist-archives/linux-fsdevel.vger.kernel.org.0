Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6072353D76A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jun 2022 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiFDPJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 11:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiFDPJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:09:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F910FC5;
        Sat,  4 Jun 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=9G/zSPx+CLMpKHrPxl1FVKSEiioSrq4tnYWynnTNq+w=; b=l0ro4SMs4eZxaRzmAHNIDIEg/A
        CREyFl5bAMIEiJegaXgUgMu8kuViLxZ4iT+iVfza6nlnw3/jKXXkvjTddcb918T691/8AtnfxiDBA
        5OD9MvKoKL1jsDkHgcvgANU43Cp+cIU5e8a65kQy1IzpBUs0xXYYVFyrdEbEix7Wp2gqsZt4PB29G
        sG6DwiboskksuDpYuGoogy7vEAqBTTNqj7c9FVPe0ZyAmPiZ3KdrKMj2p0S1lYTHBj+1EM5S/1mfk
        XwoavTYbJzu0elWmjVzArImufT48972stw6m7ou/1G7hdkF3dTWbFFKY+9UjMuyxHU10X1KuwoMO7
        lGwX//yA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxVOK-008m4p-HN; Sat, 04 Jun 2022 15:08:40 +0000
Date:   Sat, 4 Jun 2022 16:08:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     changbin.du@intel.com, sashal@kernel.org,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: export page young and skip_kasan_poison flag via
 kpageflags
Message-ID: <Ypt1eFD5QDteH1RS@casper.infradead.org>
References: <20220602154302.12634-1-xhao@linux.alibaba.com>
 <YpkBQTWWUuOzagvd@casper.infradead.org>
 <55263fe2-f8ae-f681-69fd-1064a74f2bb6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55263fe2-f8ae-f681-69fd-1064a74f2bb6@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 04, 2022 at 05:50:31PM +0800, Xin Hao wrote:
> 
> On 6/3/22 2:28 AM, Matthew Wilcox wrote:
> > On Thu, Jun 02, 2022 at 11:43:02PM +0800, Xin Hao wrote:
> > > Now the young and skip_kasan_poison flag are supported in
> > Why do we want userspace to know about whether skip_kasan_poison is set?
> > That seems like a kernel-internal detail to me.
> 
> the  skip_kasan_poison also a page flags, we use page_types tool to display
> them not only include user-internal,
> 
> but also  kernel-internal, add them, the page-types tool can more detail
> display the kernel-internal page flags,
> 
> just in case we don't miss some page flags when check the whole memory.

So you're just being completist?  You don't have a reason to expose this
information?
