Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80F648E839
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbiANKSs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 05:18:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33000 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiANKSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:18:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A863E21940;
        Fri, 14 Jan 2022 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642155526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWddwJSL1o1Vp5zBtOWqmgsbQtzopDy7PEJEHXyvaFA=;
        b=lFjyX/WQB8eQn8Cx1M1xLjGpIm3TtyamT9rIjr6HViTm/dozNA44nJRPWIfnhKGp7w3c0V
        A/Q/InTc66rhdHrnCeikgPWyAMUAQeiNbrSliotwPorA0DF2fQpnPLXwT6Q8LaTlOW/Pzl
        FDfj92IHU9nu4ovRTey66DCwFQ9qGI0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12E58A3B8E;
        Fri, 14 Jan 2022 10:18:46 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:18:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>, dan.j.williams@intel.com,
        osalvador@suse.de, naoya.horiguchi@nec.com,
        thunder.leizhen@huawei.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] proc: Add getting pages info of ZONE_DEVICE
 support
Message-ID: <YeFOBWz1OZTpEuwt@dhcp22.suse.cz>
References: <20220112143517.262143-1-sxwjean@me.com>
 <20220112143517.262143-3-sxwjean@me.com>
 <YeBFxBwaHtfs8jmg@dhcp22.suse.cz>
 <CAEVVKH-L-6Yra75XEWUNiq=ajJmtWauDTcmN=b1VCcJ0NVS7OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH-L-6Yra75XEWUNiq=ajJmtWauDTcmN=b1VCcJ0NVS7OA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 14-01-22 18:03:04, Xiongwei Song wrote:
> HI Michal,
> 
> On Thu, Jan 13, 2022 at 11:31 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 12-01-22 22:35:17, sxwjean@me.com wrote:
> > > From: Xiongwei Song <sxwjean@gmail.com>
> > >
> > > When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
> > > ignored.
> > >
> > > The pfn_to_devmap_page() function can help to get page that belongs to
> > > ZONE_DEVICE.
> >
> > Why is this needed? Who would consume that information and what for?
> 
> It's for debug purpose, which checks page flags in system wide. No any other
> special thought. But it looks like it's not appropriate to expose now from my
> understand, which is from David's comment.
> https://lore.kernel.org/linux-mm/20220110141957.259022-1-sxwjean@me.com/T/#m4eccbb2698dbebc80ec00be47382b34b0f64b4fc

yes, I do agree with David. This is the reason I am asking because I do
remember we have deliberately excluded those pages. If there is no real
user to use that information then I do not think we want to make the
code more complex and check for memmap and other peculiarities.

Thanks!
-- 
Michal Hocko
SUSE Labs
