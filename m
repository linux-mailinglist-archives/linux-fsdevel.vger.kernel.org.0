Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB17A4223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 09:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjIRHSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240175AbjIRHSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:18:44 -0400
Received: from out-216.mta1.migadu.com (out-216.mta1.migadu.com [IPv6:2001:41d0:203:375::d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEB2189
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 00:18:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695021491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UfSW8jEm1VNQCD8pQwx0JLLdK+5bGgzdvIUujZD6iqI=;
        b=xDx23adUJq5H0ND0LkfTuGurXvDHBHI9PV6YTxEa06Kb/6sHlZwz4m5BsD3c4tuG6sM570
        9GThhUfP+ZzNSF0u16ob3x2ewc+WNyoSAvPezwqg2vBX12Z20FOSqLxL1MGhrmKuQEjten
        OdYGLFAeEXGjk1pQgP8j79Nabvccp2Y=
Mime-Version: 1.0
Subject: Re: [PATCH v6 44/45] mm: shrinker: hold write lock to reparent
 shrinker nr_deferred
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230911094444.68966-45-zhengqi.arch@bytedance.com>
Date:   Mon, 18 Sep 2023 15:17:38 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <807B2489-9F74-4B35-925D-B379E47E75AD@linux.dev>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-45-zhengqi.arch@bytedance.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2023, at 17:44, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
> For now, reparent_shrinker_deferred() is the only holder of read lock of
> shrinker_rwsem. And it already holds the global cgroup_mutex, so it will
> not be called in parallel.
> 
> Therefore, in order to convert shrinker_rwsem to shrinker_mutex later,
> here we change to hold the write lock of shrinker_rwsem to reparent.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

