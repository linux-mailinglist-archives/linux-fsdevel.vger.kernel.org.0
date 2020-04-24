Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD2C1B730D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgDXL1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDXL1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:27:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D88C09B045;
        Fri, 24 Apr 2020 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BaUnhm35mfRc1JfopP3T5A1oElwrEEtPp+xIJRuYYo4=; b=QiA54ST77KjVPv6mdDJJj6wZEa
        AWqPVRGZ7+Z112KY06YZpGSENhgZOTIlroXEb9Mw42MrUh9mG9qsP647bC1USfTOJiLBqPaF4BbEn
        9qjEX8vFB12X5O1wifC5UUMwRBqW0FQcu5H/Pp7ani0Gc7U/8CPADi0eHvK6/4noVlHDnGIMdJbSp
        FAkSIc/3ybD2JKte+Ru5tbdyN5lSt7WMb/5mBK10D+kLR/yI/3hhO3NxpW2apYbM7kCMz6LvlaT7w
        VRzBueYVMsozVr/r6XWekrSczlIwDH1zGwZsw5Ns8jlPkxHxNly99blm8B6S++2gBYlQqccRC15v7
        x+9S/p0A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRwUL-0007nc-Vm; Fri, 24 Apr 2020 11:27:21 +0000
Date:   Fri, 24 Apr 2020 04:27:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH] fs/seq_file.c: Rename the "Fill" label to avoid build
 failure
Message-ID: <20200424112721.GE13910@bombadil.infradead.org>
References: <1587716944-28250-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587716944-28250-1-git-send-email-chenhc@lemote.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 04:29:04PM +0800, Huacai Chen wrote:
> MIPS define a "Fill" macro as a cache operation in cacheops.h, this
> will cause build failure under some special configurations. To avoid
> this failure we rename the "Fill" label in seq_file.c.

You should rename the Fill macro in the mips header instead.
I'd suggest Fill_R4000 of R4000_Fill.
