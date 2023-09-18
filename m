Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA597A4255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 09:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjIRH3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbjIRH3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:29:36 -0400
Received: from out-223.mta1.migadu.com (out-223.mta1.migadu.com [IPv6:2001:41d0:203:375::df])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB732CD9
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 00:28:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695022112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C04c3T7CPMypSa/7UYEFGyEvy1PJ7O7uRagFAilmo1E=;
        b=hqvUUZdpXHo20BxYI1BLTP8hnm8wzT0VviHvtZeA5Wh+3T58nOQAsSaqZ3diSLRLsvVuCy
        Ikg338V0f1jHrIP7FA7m4ZehMp8mM3Hqq9AQhfnvSHCYdVsJd6lR3c96a9jA716SBV7Eaa
        o8zWWDj8PVuOyjXmIFH9aawFePzpVDs=
Mime-Version: 1.0
Subject: Re: [PATCH v6 15/45] rcu: dynamically allocate the rcu-lazy shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230911094444.68966-16-zhengqi.arch@bytedance.com>
Date:   Mon, 18 Sep 2023 15:27:54 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        yujie.liu@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <451F0654-71D6-4BC0-A704-CE9EF081CFD5@linux.dev>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-16-zhengqi.arch@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2023, at 17:44, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> Use new APIs to dynamically allocate the rcu-lazy shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

