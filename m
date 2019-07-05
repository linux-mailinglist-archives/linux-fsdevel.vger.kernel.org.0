Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2820E5FFA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGEDBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 23:01:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGEDBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=clMDBr0VH7M11Amw0B3Ri/sIv+DBHpDPWFocL6b0RWI=; b=KxxQ/EOQrixPXe7WpCSxNyecNu
        ou7W9wMn/5tSGt9EiUzbFPZmmXzPOlV/lF0IdeZFJsJVc/dwXq8Iw/fPPvCcb+Yg3MDGptSBjJ+cS
        1IfnAHgJmmclULvexo48g0cubarcVOznsqZHs0UoglMrBPHeUHgRmtcan+WzIonpUSZ1IEcshWQAr
        P5ielI9z2OAukUBQWXSNGPFVRxCTPWIPE//nlqO8F+lLDa0j0Whf57onB5xYFzoCN3tK+BZJ+sGlb
        dPgpEPd+Lir60dUQ7L1iFTtdjksURL91i9fSoVwvvFwjz69tGIkHE2Ql9YiMumPw9/jLEN6pagl86
        WoQnlhXA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjETE-00077l-Nd; Fri, 05 Jul 2019 03:01:08 +0000
Subject: Re: mmotm 2019-07-04-15-01 uploaded (mm/vmscan.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9cbdb785-b51d-9419-6b9a-ec282a4e4fa2@infradead.org>
Date:   Thu, 4 Jul 2019 20:01:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 


on i386:
CONFIG_SLOB=y <<<<<<<<<<


../mm/vmscan.c: In function ‘prealloc_memcg_shrinker’:
../mm/vmscan.c:220:3: error: implicit declaration of function ‘memcg_expand_shrinker_maps’ [-Werror=implicit-function-declaration]
   if (memcg_expand_shrinker_maps(id)) {
   ^
In file included from ../include/linux/rbtree.h:22:0,
                 from ../include/linux/mm_types.h:10,
                 from ../include/linux/mmzone.h:21,
                 from ../include/linux/gfp.h:6,
                 from ../include/linux/mm.h:10,
                 from ../mm/vmscan.c:17:
../mm/vmscan.c: In function ‘shrink_slab_memcg’:
../mm/vmscan.c:608:54: error: ‘struct mem_cgroup_per_node’ has no member named ‘shrinker_map’
  map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                                      ^
../include/linux/rcupdate.h:321:12: note: in definition of macro ‘__rcu_dereference_protected’
  ((typeof(*p) __force __kernel *)(p)); \
            ^
../mm/vmscan.c:608:8: note: in expansion of macro ‘rcu_dereference_protected’
  map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
        ^
../mm/vmscan.c:608:54: error: ‘struct mem_cgroup_per_node’ has no member named ‘shrinker_map’
  map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                                      ^
../include/linux/rcupdate.h:321:35: note: in definition of macro ‘__rcu_dereference_protected’
  ((typeof(*p) __force __kernel *)(p)); \
                                   ^
../mm/vmscan.c:608:8: note: in expansion of macro ‘rcu_dereference_protected’
  map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
        ^




-- 
~Randy
