Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63E845EA99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376380AbhKZJqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:46:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhKZJoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:44:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2DBD02193C;
        Fri, 26 Nov 2021 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637919660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9R66uW+sTKtJrmOSMzAsGdQdsIi7wg7o88TxJQ45k3s=;
        b=Ejz/Xl3WcL95Apd76khpqjETR6fiwr5X1p5YL4yuqbM81yS4KvjmvqCs+c8CD/kXW6+tjf
        xrBjgMzwTgsdtyBIb42F6xwy03QlwJlTuYqLG4woksmJ5nxFMzf9H1x+ji9IFSsN8MOVq2
        ryzEMec46swSiFq0BIeus/QdO6xQm7g=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B12BA3B90;
        Fri, 26 Nov 2021 09:40:58 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:40:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        peterz@infradead.org, gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        senozhatsky@chromium.org, wangqing@vivo.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: move watchdog sysctl interface to
 watchdog.c
Message-ID: <YaCrpyoYSSftes6i@alley>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202347.818157-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-23 12:23:42, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> The kernel/sysctl.c is a kitchen sink where everyone leaves
> their dirty dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to
> places where they actually belong. The proc sysctl maintainers
> do not want to know what sysctl knobs you wish to add for your own
> piece of code, we just care about the core logic of proc sysctl.
> 
> So, move the watchdog syscl interface to watchdog.c.
> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the
> same time.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> [mcgrof: justify the move on the commit log]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
