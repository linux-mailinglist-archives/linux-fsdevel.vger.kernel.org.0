Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DE45AD0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhKWUMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:12:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33786 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbhKWUMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:12:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AEC251FD5A;
        Tue, 23 Nov 2021 20:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637698152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=to1JiEtdgAtTYZuUmNGxh55YpOijfzoRjl9rgnGo0kU=;
        b=rwsoiFBlvBOCmcthSMKTyiXhvbpaatiGRe7XJFXSLF11qVvGpjJErOyVE7J3vW/EXuOp25
        Fyu+b6KnNEnn94da7+wIyLCE/3Dgn3WKFCvmkH3v3epiJWa44NdW43rR/nD7RwubwJeFZh
        gUeXZaoG6uroXUUV+6hX3NSTX8i0zMI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85519A3B85;
        Tue, 23 Nov 2021 20:09:12 +0000 (UTC)
Date:   Tue, 23 Nov 2021 21:09:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ1KZKkHSHcSBnBV@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ06nna7RirAI+vJ@pc638.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 20:01:50, Uladzislau Rezki wrote:
[...]
> I have raised two concerns in our previous discussion about this change,
> well that is sad...

I definitely didn't mean to ignore any of the feedback. IIRC we were in
a disagreement in the failure mode for retry loop - i.e. free all the
allocated pages in case page table pages cannot be allocated. I still
maintain my position and until there is a wider consensus on that I will
keep my current implementation. The other concern was about failures
warning but that shouldn't be a problem when basing on the current Linus
tree. Am I missing something?
-- 
Michal Hocko
SUSE Labs
