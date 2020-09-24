Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD3277A9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIXUlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXUlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:41:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B9C0613CE;
        Thu, 24 Sep 2020 13:41:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600980108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WNniJWdtgjbCmAKCV5jnu3oJVt7te+w/KnOSYyq8oA=;
        b=v6GsUj4E+a6Ddc28kWc8d+YBtldn0eV+kqcjGfmQTVigq9s6EuKdfT9nl5vDnN68lig1yg
        rKNSe/206egSdsVvu7h8LrOQMDT8CmIl6lcFXJ1xlcC/BFOx8moTpICOwtvgQxwsbStjkr
        egm9903o5v7m3x1gOPryTaLG1U6WYOWsXBgfjta6p/E+8GScN59e24agDF2Pzr5Rxpa1zn
        kuyKdpP0DJIhwZWm2/YRpQHnOIUFEmTE7fgwuzMIDs42UT3bWHwVZylKqPnModAKkz/a5o
        ANgfiYGmFqmi41hIDxfslh6rfhQNw0WDFUAdp12g9Tf01boCDhc8wEh8V9GDyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600980108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WNniJWdtgjbCmAKCV5jnu3oJVt7te+w/KnOSYyq8oA=;
        b=ENLxqsoFgO8+73NZNe5v++5gNI5im64u7V6WHDCTITTDQpCLurEvjU2TdPmDJ0WF/8KH0c
        qyET6F8Udu81VXBg==
To:     Tom Hromatka <tom.hromatka@oracle.com>, tom.hromatka@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fweisbec@gmail.com, mingo@kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH v2 1/2] tick-sched: Do not clear the iowait and idle times
In-Reply-To: <20200915193627.85423-2-tom.hromatka@oracle.com>
References: <20200915193627.85423-1-tom.hromatka@oracle.com> <20200915193627.85423-2-tom.hromatka@oracle.com>
Date:   Thu, 24 Sep 2020 22:41:47 +0200
Message-ID: <87r1qq7vqs.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15 2020 at 13:36, Tom Hromatka wrote:
> Prior to this commit, the cpu idle and iowait data in /proc/stat were
> cleared when a CPU goes down.  When the CPU came back online, both idle
> and iowait times were restarted from 0.

Starting a commit message with 'Prior to this commit' is
pointless. Describe the factual problem which made you come up with this
change.

>
> This commit preserves the CPU's idle and iowait values when a CPU goes
> offline and comes back online.

'This commit does' is just a variation of 'This patch does'.

git grep 'This patch' Documentation/process/

Thanks,

        tglx
