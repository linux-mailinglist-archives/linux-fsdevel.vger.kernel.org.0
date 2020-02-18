Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDB41162353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 10:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgBRJZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 04:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgBRJZm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:25:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20B85AFE3;
        Tue, 18 Feb 2020 09:25:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D3C5A1E0CF7; Tue, 18 Feb 2020 10:25:40 +0100 (CET)
Date:   Tue, 18 Feb 2020 10:25:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/8] mm: Speedup page cache truncation
Message-ID: <20200218092540.GA5761@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew!

Any resolution on this? I'd like to move this further...

								Honza

On Tue 04-02-20 15:25:06, Jan Kara wrote:
> Hello,
> 
> conversion of page cache to xarray (commit 69b6c1319b6 "mm: Convert truncate to
> XArray" in particular) has regressed performance of page cache truncation
> by about 10% (see my original report here [1]). This patch series aims at
> improving the truncation to get some of that regression back.
> 
> The first patch fixes a long standing bug with xas_for_each_marked() that I've
> uncovered when debugging my patches. The remaining patches then work towards
> the ability to stop clearing marks in xas_store() which improves truncation
> performance by about 6%.
> 
> The patches have passed radix_tree tests in tools/testing and also fstests runs
> for ext4 & xfs.
> 
> 								Honza
> 
> [1] https://lore.kernel.org/linux-mm/20190226165628.GB24711@quack2.suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
