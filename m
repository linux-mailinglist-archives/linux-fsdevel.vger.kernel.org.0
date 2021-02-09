Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D0315282
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 16:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBIPRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 10:17:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhBIPRS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:17:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17963B207;
        Tue,  9 Feb 2021 15:16:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DF346DA7C8; Tue,  9 Feb 2021 16:14:42 +0100 (CET)
Date:   Tue, 9 Feb 2021 16:14:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/btrfs: Use memcpy_[to|from]_page()
Message-ID: <20210209151442.GU1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Andrew Morton <akpm@linux-foundation.org>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210205232304.1670522-1-ira.weiny@intel.com>
 <20210205232304.1670522-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205232304.1670522-3-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:23:02PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>

There should be a short explanation what the patch does, eg.
"use helper for open coded kmap_atomic/memcpy/kunmap_atomic",
although I see there are conversions kmap_atomic -> kmap_local not in
the coccinelle script, probably done manually. This should be mentioned
too.

Also please use "btrfs:" followed by lowercase in the subject.
