Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C524832A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHRKgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgHRKgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:36:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90132C061389;
        Tue, 18 Aug 2020 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PxEaa92aYsiybSQz7oa3HYw1NYI/WkEv9koOqjkqg9g=; b=ZIG+qq8oCuBvwA6kUWik1qng6i
        gsAHaPDDaBpBiqmSE+bS+HV0Am2meWwZ/5N2iApKqvG82BvkrYckosoFUPFeVdtoPIGxRJLIGHG5t
        RE8DMo8VfBnHb1OVTyx9cXhLAtMAO79PAXH2sn7L5XgU7REAOmlfJIiASqIf6wGbS/Gxha5Z/XUzH
        OAVioWo7QCzixURvFN8KwYPR/N9gkEcppIQDoY6sqf/DVwzGAhiOVqeRqAshnGTklMfHCDo6ojldT
        7qUlMgUAAii5usQ4/2CQiOvYqv91YNC56GXLP24yc3ZhYTRLZsxbPnXU6bHz/Goss7ihx+L07PvAd
        TK+aRVPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7yys-00020X-6A; Tue, 18 Aug 2020 10:36:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D802305DD1;
        Tue, 18 Aug 2020 12:36:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3214D2B2C8DCD; Tue, 18 Aug 2020 12:36:37 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:36:37 +0200
From:   peterz@infradead.org
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818103637.GR2674@hirez.programming.kicks-ass.net>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
 <20200818101844.GO2674@hirez.programming.kicks-ass.net>
 <20200818103059.GP28270@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818103059.GP28270@dhcp22.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:30:59PM +0200, Michal Hocko wrote:
> The proposal also aims at much richer interface to define the
> oom behavior.

Oh yeah, I'm not defending any of that prctl() nonsense.

Just saying that from a math / control theory point of view, the current
thing is a abhorrent failure.
