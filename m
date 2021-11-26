Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7845EAB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 10:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376530AbhKZJvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 04:51:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345583AbhKZJtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:49:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2EDC61FD37;
        Fri, 26 Nov 2021 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637919996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASGb3jWKnS1tVPmRo3qHJ8jvVsAgt13UooLGn+qWHqE=;
        b=sDc/xDplhsjJiDqxIu0KZ6ZUuCtNrFOuIBCNtDyNIZqJinTfZDjr/szwNZVE/e5w8O2fvr
        r1Ev7QHK+0/kmpSTyrFDTZnxXSYUrYD9p8izxpl4Irp0M8/zq4oqZW8picQMHK9yvyiiAC
        dO6Ndg0BNkjeasnUFHdbnviUcZxn6So=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05E7DA3B8B;
        Fri, 26 Nov 2021 09:46:35 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:46:35 +0100
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
Subject: Re: [PATCH v2 3/9] hung_task: Move hung_task sysctl interface to
 hung_task.c
Message-ID: <YaCs+wg2r2+4jyVa@alley>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202347.818157-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2021-11-23 12:23:41, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> The kernel/sysctl.c is a kitchen sink where everyone leaves
> their dirty dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to
> places where they actually belong. The proc sysctl maintainers
> do not want to know what sysctl knobs you wish to add for your own
> piece of code, we just care about the core logic.
> 
> So move hung_task sysctl interface to hung_task.c and use
> register_sysctl() to register the sysctl interface.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> [mcgrof: commit log refresh and fixed 2-3 0day reported compile issues]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
