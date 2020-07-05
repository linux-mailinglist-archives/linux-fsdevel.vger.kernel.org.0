Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1F8214E25
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGERSO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 13:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgGERSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 13:18:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E05C061794;
        Sun,  5 Jul 2020 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=meRBG0WDaBJD6CmIInnlHgz0M+mJeuQO+VezbWOEA1g=; b=ZaipPT8oMZF6Up06bT/0mDRaZl
        +vzqt5dbH5i9qZ7y62JMhNPqdFc15FW2AKBb+jN2d6zkNomsECGrBrQ13Mzc93/0HtOySaT1UOU4H
        gYIAp7bIhj8zt/ivaF4LTDBlnJdN1OjAX7uKY31HSBFB9Yj+vKOpWo34vNLWBpe2GJvY98TDuTAOe
        aod48Q3Nwz91E4A3IwXHTH8RgYliFJERXH333Olb3kZBXk2Sd07SYNTvZafoXnMBfVLWHk5jbNs+l
        1nwpVh98iSAEyGp6bha8swSp9GB8itKOQoHQRwYKCbvF5XaEJx3Hw6hgFTBNMwNX6Hof04BMImMmA
        ij7Y/3xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1js8HK-00016Z-MN; Sun, 05 Jul 2020 17:18:10 +0000
Date:   Sun, 5 Jul 2020 18:18:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     yang che <chey84736@gmail.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] hung_task:add detecting task in D state milliseconds
 timeout
Message-ID: <20200705171810.GV25523@casper.infradead.org>
References: <1593698893-6371-1-git-send-email-chey84736@gmail.com>
 <20200702174346.GB25523@casper.infradead.org>
 <CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:18:28AM +0800, yang che wrote:
>   my understanding, KernelShark can't trigger panic, hung_task can
> trigger. According to my use,
> sometimes need to trigger panic to grab ramdump to analyze lock and
> memory problems.

You shouldn't need to trigger a panic to analyse locking or memory
problems.  KernelShark is supposed to be able to help you do that without
bringing down the system.  Give it a try, and if it doesn't work, Steven
Rostedt is very interested in making it work for your case.
