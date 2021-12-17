Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E297A478C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 14:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhLQNNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 08:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbhLQNNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:13:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81AC061574;
        Fri, 17 Dec 2021 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KG1YXxFiuZUbxpQVPpmlOGMkd4ccqHyGA24slpmvC8M=; b=kHMD6TQkGOepJIlUYbYaU3k+Ev
        l8PDd5qgN8fEFznnwI6g3i48bIndkiMZdTT141I+okxKUM/PdaPBhZnMZURxMj08flHrRvJppYPvh
        DpciasNwhsIs2w+QQW+OXV2j6dfZvgK2aZowY0mlrCZ/0d952tU+JsHSFCvD8fxyem7WUCx6vddao
        thaH17VXdQmszHgeVsioOQjpnMlCzBtXNSLOaRe5rzRq/bnwml4Tu3/da1A/lfPOA5YkIiKDmcco9
        475kQ5ztarAdSRWvtAEtPdfHnT6IrRpYhKKOYHLMXQ9cI1XYOHYP7n5xXKT1k3FQM8sgIX77wzac6
        NLj52F9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myD2d-00GiEA-Tr; Fri, 17 Dec 2021 13:12:55 +0000
Date:   Fri, 17 Dec 2021 13:12:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, guro@fb.com, shy828301@gmail.com,
        alexs@kernel.org, richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 00/17] Optimize list lru memory consumption
Message-ID: <YbyM17OMHlEmLfhH@casper.infradead.org>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <745ddcd6-77e3-22e0-1f8e-e6b05c644eb4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <745ddcd6-77e3-22e0-1f8e-e6b05c644eb4@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:05:00PM +0800, xiaoqiang zhao wrote:
> 
> 
> 在 2021/12/14 0:53, Muchun Song 写道:
> > This series is based on Linux 5.16-rc3.
> > 
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > memory.
> > 
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
> 
> IIUC, you mean: "the memory consumption of kmalloc-32 slab cache is
> caused by list_lru_one allocation"
> 

Please trim the unnecessary parts.  You quoted almost 200 extra lines
after this that I (and everybody else reading) have to look through
to see if you said anything else.
