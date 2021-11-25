Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C88245D69E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 10:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349919AbhKYJDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 04:03:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41020 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352941AbhKYJBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:01:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5E8F921B37;
        Thu, 25 Nov 2021 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637830711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8v94X25YY4fcAeTnaWPpMzCIwjzAXXnPYIj480Yedk=;
        b=Qcm5SY3iE4SX3JZQhUL2iqP90cRb0oV1+j2X5SDK7znkWEPosG3c9/PHBRQ0UqmmsmH9NW
        ke8Fxm9qKrz9s/eCLdO8ZFmRJc3rB6tMuCZiDageIxcROBvE7gVTN/IGzN3Laz3EN/tCnn
        UlAQB8QawNoWRNnXaJN7O1S5vbgaw4M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B666A3B8D;
        Thu, 25 Nov 2021 08:58:30 +0000 (UTC)
Date:   Thu, 25 Nov 2021 09:58:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Neil Brown <neilb@suse.de>, Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 0/4] extend vmalloc support for constrained allocations
Message-ID: <YZ9QNeHYt99mdfbZ@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211124225526.GM418105@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124225526.GM418105@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 25-11-21 09:55:26, Dave Chinner wrote:
[...]
> Correct __GFP_NOLOCKDEP support is also needed. See:
> 
> https://lore.kernel.org/linux-mm/20211119225435.GZ449541@dread.disaster.area/

I will have a closer look. This will require changes on both vmalloc and
sl?b sides.
-- 
Michal Hocko
SUSE Labs
