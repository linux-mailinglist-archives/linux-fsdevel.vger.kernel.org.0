Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4335949B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfF1HKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 03:10:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1HKy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:10:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3B15B16F;
        Fri, 28 Jun 2019 07:10:51 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:10:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/2] mm, memcontrol: Add memcg_iterate_all()
Message-ID: <20190628071049.GA2751@dhcp22.suse.cz>
References: <20190624174219.25513-1-longman@redhat.com>
 <20190624174219.25513-2-longman@redhat.com>
 <20190627150746.GD5303@dhcp22.suse.cz>
 <2213070d-34c3-4f40-d780-ac371a9cbbbe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2213070d-34c3-4f40-d780-ac371a9cbbbe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-06-19 17:03:06, Waiman Long wrote:
> On 6/27/19 11:07 AM, Michal Hocko wrote:
> > On Mon 24-06-19 13:42:18, Waiman Long wrote:
> >> Add a memcg_iterate_all() function for iterating all the available
> >> memory cgroups and call the given callback function for each of the
> >> memory cgruops.
> > Why is a trivial wrapper any better than open coded usage of the
> > iterator?
> 
> Because the iterator is only defined within memcontrol.c. So an
> alternative may be to put the iterator into a header file that can be
> used by others. Will take a look at that.

That would be preferred.

Thanks!
-- 
Michal Hocko
SUSE Labs
