Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3C408643
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhIMISF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbhIMISF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:18:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFF3C061574;
        Mon, 13 Sep 2021 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vzoOqKPucIos1Sa6XxmINYvmyxF9IjulKwV36eq9XkU=; b=MgqJaJOYvmlMOGDQrMTf64S+/6
        7pOb4qgrUHfLtBACgJsMep6CF2oEzV7fQuCI1CQ3RZn2aqsGBfANr0JI40xlG7knCVknIxtAX0Wlj
        bKz9q163K3k4NtiE55i2fTzGfMjhuWMZ8DzQn0KlrTuQs7yA54YFTVrxZ0/c9R2bBAzY0E3VW1V/J
        RXjSF/HZPnJgx05BHlmXz/1fzVV/kekc33WeUFqQHoto5crYiS7is5Aw9oaoluIYFNapO/3ueRf/v
        ASZPMApJ0JoLDIpnLcocm22Gy+hPq1YMOWhV+XCT3YfPF62xJh9mzDC0uCy2iPAQYhivAzW2v6qIi
        7p4SuK0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPh6H-00DId2-PP; Mon, 13 Sep 2021 08:14:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABD86300093;
        Mon, 13 Sep 2021 10:13:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 944072BD296B8; Mon, 13 Sep 2021 10:13:54 +0200 (CEST)
Date:   Mon, 13 Sep 2021 10:13:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     cgel.zte@gmail.com
Cc:     yzaikin@google.com, liu.hailong6@zte.com.cn, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, mcgrof@kernel.org,
        keescook@chromium.org, pjt@google.com, yang.yang29@zte.com.cn,
        joshdon@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] sched: Add a new version sysctl to control child runs
 first
Message-ID: <YT8IQioxUARMus9w@hirez.programming.kicks-ass.net>
References: <20210912041222.59480-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912041222.59480-1-yang.yang29@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 12, 2021 at 04:12:23AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> The old version sysctl has some problems. First, it allows set value
> bigger than 1, which is unnecessary. Second, it didn't follow the
> rule of capabilities. Thirdly, it didn't use static key. This new
> version fixes all the problems.

Does any of that actually matter?
