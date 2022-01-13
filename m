Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6073948DAB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 16:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiAMPbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 10:31:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiAMPbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:31:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E36821129;
        Thu, 13 Jan 2022 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642087881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIXhxVVHGtk6ijZKhabiqkui6YCqOppbvprKjXD8XzM=;
        b=AaV+zMcbVcgg/XXoOO/p32goghWxiXPv2dtWCsrhkJwWM7gjx6zEoTun9YsoHH5c8BgNhV
        eTK3KKj9TrteV9EI25Oknd1kGmIeDMlpHOElE3BTeymNQznitD/rpkPj1ud/jBkAzBEJJJ
        L6zN42xHy+SegMUyC0zVT8kJjIi1QXQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 71C80A3B89;
        Thu, 13 Jan 2022 15:31:20 +0000 (UTC)
Date:   Thu, 13 Jan 2022 16:31:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     sxwjean@me.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH v3 2/2] proc: Add getting pages info of ZONE_DEVICE
 support
Message-ID: <YeBFxBwaHtfs8jmg@dhcp22.suse.cz>
References: <20220112143517.262143-1-sxwjean@me.com>
 <20220112143517.262143-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112143517.262143-3-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-01-22 22:35:17, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
> ignored.
> 
> The pfn_to_devmap_page() function can help to get page that belongs to
> ZONE_DEVICE.

Why is this needed? Who would consume that information and what for?
-- 
Michal Hocko
SUSE Labs
