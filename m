Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D3C49FBDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349324AbiA1Oh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 09:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbiA1Ohx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:37:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F9C061714;
        Fri, 28 Jan 2022 06:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6/tqkDCZHAhUA6Pgzhrdj6aflFqIsB1t/60EdxYL26A=; b=kfqTzMcYLeCxCfj0kM6yMOqHoi
        +pNC/+IgEbKvxSTwQ9KtdUIFM2gXH3sTBzClug9h24MYw4QhPMAn2rN0bta5/xbTporgpSYN8bjC9
        NtDrEYlKE98LUVyZtbS7E9sVxAl0BMaxY6TuzxNyVOFW+6ATC5UGXbDV8jhu3SxNTrIC+VVBtXZ9W
        9biGi7uU3TcNv42dCcSSmu8hsDbcgq4hIo0A8Uq0fd5LvB0CyeOTPhyxJfDIaaL23x+W16zTm2VzP
        eulJhZT2kVOpvqyJiedTefGX6sCsUSysoSwzt8mz8MzMy58+lWXumE+49CvtePdgjy9VfqnPenyT/
        f1ezjCDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDSNV-004Zzy-8c; Fri, 28 Jan 2022 14:37:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A90433002C5;
        Fri, 28 Jan 2022 15:37:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EC672142D5E2; Fri, 28 Jan 2022 15:37:26 +0100 (CET)
Date:   Fri, 28 Jan 2022 15:37:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: move autogroup sysctls into its own file
Message-ID: <YfP/pquU1Zho+4gA@hirez.programming.kicks-ass.net>
References: <20220128095025.8745-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128095025.8745-1-nizhen@uniontech.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:50:25PM +0800, Zhen Ni wrote:
> move autogroup sysctls to autogroup.c and use the new
> register_sysctl_init() to register the sysctl interface.
> 
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

Thanks!
