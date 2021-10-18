Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3B432419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbhJRQua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 12:50:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhJRQua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:50:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 44C081FD7F;
        Mon, 18 Oct 2021 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634575697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpctcjauyVkficDYMg8IelhquUlY3RQ3gG3mgqn4rI4=;
        b=JWa8KOxaNYFN8ROwf48IWm3jAlmENWZw5cnucHeqT7dlbzAIL7R49cKovCatW1ZVTH5qNn
        H+0oYw74kgvuJtFW/zeFfSbk8e+epAGDl3TOqsFPGPW3V6hpV3VXQB2/eu9K3fkBhJUvuP
        kJAWrN8ARVK9TjltBzuB9plTjRq9iQc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F5A2A3B81;
        Mon, 18 Oct 2021 16:48:17 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:48:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     linux-mm@kvack.org
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YW2lUDleoIpoD2sb@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018114712.9802-3-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fat fingers on my side. A follow up to fold
commit 63d1b80b9a298c9380e5175e2add7025b6bd2600
Author: Michal Hocko <mhocko@suse.com>
Date:   Mon Oct 18 18:47:04 2021 +0200

    fold me "mm/vmalloc: add support for __GFP_NOFAIL"

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3a5a178295d1..4ce9ccc33e33 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3034,7 +3034,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed",
 			real_size);
-		if (gfp_mask && __GFP_NOFAIL)
+		if (gfp_mask & __GFP_NOFAIL)
 			goto again;
 		goto fail;
 	}
-- 
Michal Hocko
SUSE Labs
