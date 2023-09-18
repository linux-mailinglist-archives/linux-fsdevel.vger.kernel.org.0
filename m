Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3B7A4232
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjIRHWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjIRHVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:21:41 -0400
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE9B189
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 00:21:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695021668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZfk+duZW4VQ/MbQhSPKDF4o6Gr2De3J0m92orGPEdA=;
        b=reKuPr6R4A2OebBT15ogzvxXqlrIqL3YM5B5K0D0Itd8hY9YrCFFyohlXkHWND6Oz7ywEs
        AtXODxG7wQjIo6yAbybIFkquYcCVmx4H2i+ADRaMMoCKV7nq23JdsYUv4QDW17xhLaGWQy
        qKAj7ehDrJLes7Irf5uDBWv2liv2Og8=
Mime-Version: 1.0
Subject: Re: [PATCH v6 41/45] mm: shrinker: rename
 {prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230911094444.68966-42-zhengqi.arch@bytedance.com>
Date:   Mon, 18 Sep 2023 15:20:28 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0410F06D-2C06-4B1D-905D-8C4764840F8A@linux.dev>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-42-zhengqi.arch@bytedance.com>
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
> With the new shrinker APIs, there is no action such as prealloc, so rename
> {prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}(),
> which corresponds to the idr_{alloc|remove}() inside the function.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
