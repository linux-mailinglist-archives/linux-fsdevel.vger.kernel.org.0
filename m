Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8F508191
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 08:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359543AbiDTHB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 03:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDTHBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:01:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B535276;
        Tue, 19 Apr 2022 23:58:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CC1A21F385;
        Wed, 20 Apr 2022 06:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650437917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4fTOnm8X7fTon8J5U2DDAjOf8lbd7MDCm+komIQ5sL0=;
        b=WMY2zI9jyNpoVyqQAkq9ncq+P8HDI7MTSGSrE4wMw3uGvgXvBbmaP1FXONFiJg1U6DFoei
        A3GPwI6uA0I7lxiDzAI9nl8t22BQJpI/yWt7l9XoE8pvd8UxtXD2EmfhJ/ZD6fjuALN07/
        ijsv9wKTyYoaEh60dM/LzVIfsk2EwPE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D58B2C14B;
        Wed, 20 Apr 2022 06:58:37 +0000 (UTC)
Date:   Wed, 20 Apr 2022 08:58:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org
Subject: Re: [PATCH 3/4] mm: Centralize & improve oom reporting in show_mem.c
Message-ID: <Yl+vHJ3lSLn5ZkWN@dhcp22.suse.cz>
References: <20220419203202.2670193-1-kent.overstreet@gmail.com>
 <20220419203202.2670193-4-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419203202.2670193-4-kent.overstreet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-04-22 16:32:01, Kent Overstreet wrote:
> This patch:
>  - Moves lib/show_mem.c to mm/show_mem.c

Sure, why not. Should be a separate patch.

>  - Changes show_mem() to always report on slab usage
>  - Instead of reporting on all slabs, we only report on top 10 slabs,
>    and in sorted order
>  - Also reports on shrinkers, with the new shrinkers_to_text().

Why do we need/want this? It would be also great to provide an example
of why the new output is better (in which cases) than the existing one.
-- 
Michal Hocko
SUSE Labs
