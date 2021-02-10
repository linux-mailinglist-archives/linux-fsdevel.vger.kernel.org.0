Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C599316E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 19:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhBJSUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:20:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:52012 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234162AbhBJSSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:18:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A113AB98;
        Wed, 10 Feb 2021 18:17:49 +0000 (UTC)
Subject: Re: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
To:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-7-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cbdf0d68-db66-842e-2d4c-261e3e69245d@suse.cz>
Date:   Wed, 10 Feb 2021 19:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209174646.1310591-7-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 6:46 PM, Yang Shi wrote:
> The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> will add more dereference places.
> 
> So extract the dereference into a helper to make the code more readable.  No
> functional change.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
