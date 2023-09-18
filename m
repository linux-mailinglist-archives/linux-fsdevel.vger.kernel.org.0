Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942B7A424E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbjIRH1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjIRH1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:27:20 -0400
Received: from out-215.mta0.migadu.com (out-215.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EF199
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 00:26:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695022015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/0iJCH1fIu/X7pk5fmy2pP/xhBJ2sGyrVjINSk+lnk=;
        b=qdVpF+sIYY47r085N7dkDcT8fEd3NkXZDIzHFQJbq58e2ICjV9ZmbmJhcWLVZS0WJhdb6+
        xWwgmtbdwYsT/TlpR5lMarCPwAnYuFi6HANjwn35WMcG9tVZhAsfIy18nXqlU3pDmA/qT+
        Jkiynnw9tE2gMceA5ENBASH+CEPt15U=
Mime-Version: 1.0
Subject: Re: [PATCH v6 19/45] mm: workingset: dynamically allocate the
 mm-shadow shrinker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230911094444.68966-20-zhengqi.arch@bytedance.com>
Date:   Mon, 18 Sep 2023 15:26:19 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        tkhai@ya.ru, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <380A9D89-FA6E-42AD-B5CA-7F411364FB3A@linux.dev>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-20-zhengqi.arch@bytedance.com>
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
> Use new APIs to dynamically allocate the mm-shadow shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

