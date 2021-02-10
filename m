Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7E317247
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 22:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhBJVYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 16:24:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:46735 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233516AbhBJVXJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:23:09 -0500
IronPort-SDR: BwQ+LmibILsn51LIKJDlluimr1FklBOJ/+9dEgXKB9yd5TM+YnerTPiW2GPTSoHfwEyQoe6ujs
 5KBupbDitFzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="178645165"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="178645165"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 13:22:29 -0800
IronPort-SDR: vLcPPosfFeI720bC7q2jpXy18vziRwYYrMpoxtOPHTVzo3YSWOA/doG5f00f+pgd30auxq7BNd
 XYo+94dUTmvA==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="436823973"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 13:22:28 -0800
Date:   Wed, 10 Feb 2021 13:22:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>, clm@fb.com,
        josef@toxicpanda.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210212228.GF3014244@iweiny-DESK2.sc.intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <20210210125502.GD2111784@infradead.org>
 <20210210162901.GB3014244@iweiny-DESK2.sc.intel.com>
 <20210210185606.GF308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210185606.GF308988@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:56:06PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 10, 2021 at 08:29:01AM -0800, Ira Weiny wrote:
> > And I thought it was a good idea.  Any file system development should have
> > tests with DEBUG_VM which should cover Matthew's concern while not having the
> > overhead in production.  Seemed like a decent compromise?
> 
> Why do you think these paths are only used during file system development?

I can't guarantee it but right now most of the conversions I have worked on are
in FS's.

> They're definitely used by networking, by device drivers of all kinds
> and they're probably even used by the graphics system.
> 
> While developers *should* turn on DEBUG_VM during development, a
> shockingly high percentage don't even turn on lockdep.

Honestly, I don't feel strongly enough to argue it.

Andrew?  David?  David this is going through your tree so would you feel more
comfortable with 1 or the other?

Ira

