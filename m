Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EE351BC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhDASLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 14:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237278AbhDASDj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617287853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJrA00uxIGXmEJZOjpdMpdaaSrHyC5HALtOFInOMB88=;
        b=P0jFij1KoLqdUY5uwbXKSbR/LbYWyxi4Wk+q4F34B0IOYeUGzbxTVr3vKcCDt9FtsbE27w
        9dHbGfZzGBYaU+qoeDZJ9UxWwnym0QoMmahTbtKn3jCFalv31tYB1tc8Ei6GEW/lZcFg1w
        azGlcTsmU9JcyFTemfJobLE5oBejI9c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA704B230;
        Thu,  1 Apr 2021 14:37:33 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:37:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] writeback: fix obtain a reference to a
 freeing memcg css
Message-ID: <YGXaqcLOHjlCkNkt@dhcp22.suse.cz>
References: <20210401093343.51299-1-songmuchun@bytedance.com>
 <YGWf1C/gIZgs0AhR@dhcp22.suse.cz>
 <CAMZfGtX9V898aezb-huMEYU_-NjqfL6HbXeaZr2Q2MUa+VG3qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX9V898aezb-huMEYU_-NjqfL6HbXeaZr2Q2MUa+VG3qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-04-21 21:59:13, Muchun Song wrote:
> On Thu, Apr 1, 2021 at 6:26 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > Even if the css ref count is not really necessary it shouldn't cause any
> > harm and it makes the code easier to understand. At least a comment
> > explaining why that is not necessary would be required without it
> 
> OK. I will add a comment here to explain why we need to hold a
> ref.

I do not think this is necessary. Taking the reference is a standard
way and I am not sure it requires a comment. I meant to say that not
having a reference should really have a comment explaining why.

Thanks!
-- 
Michal Hocko
SUSE Labs
