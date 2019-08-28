Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583BCA0447
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfH1OJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 10:09:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfH1OJk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:09:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50EFEAE92;
        Wed, 28 Aug 2019 14:09:39 +0000 (UTC)
Date:   Wed, 28 Aug 2019 16:09:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Dan Williams <dan.j.williams@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
Message-ID: <20190828140938.GL28313@dhcp22.suse.cz>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190827142238.GB10223@dhcp22.suse.cz>
 <20190828080006.GG7386@dhcp22.suse.cz>
 <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-08-19 09:46:21, Waiman Long wrote:
> On 8/28/19 4:00 AM, Michal Hocko wrote:
> > On Tue 27-08-19 16:22:38, Michal Hocko wrote:
> >> Dan, isn't this something we have discussed recently?
> > This was http://lkml.kernel.org/r/20190725023100.31141-3-t-fukasawa@vx.jp.nec.com
> > and talked about /proc/kpageflags but this is essentially the same thing
> > AFAIU. I hope we get a consistent solution for both issues.
> >
> Yes, it is the same problem. The uninitialized page structure problem
> affects all the 3 /proc/kpage{cgroup,count,flags) files.
> 
> Toshiki's patch seems to fix it just for /proc/kpageflags, though.

Yup. I was arguing that whacking a mole kinda fix is far from good. Dan
had some arguments on why initializing those struct pages is a problem.
The discussion had a half open end though. I hoped that Dan would try
out the initialization side but I migh have misunderstood.
-- 
Michal Hocko
SUSE Labs
