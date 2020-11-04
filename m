Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0B2A665E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 15:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKDO3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 09:29:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgKDO3e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:29:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12979AD5D;
        Wed,  4 Nov 2020 14:29:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A82C9DA6E3; Wed,  4 Nov 2020 15:27:54 +0100 (CET)
Date:   Wed, 4 Nov 2020 15:27:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>
Subject: Re: [PATCH] mm: Fix readahead_page_batch for retry entries
Message-ID: <20201104142754.GF6756@suse.cz>
Reply-To: dsterba@suse.cz
References: <20201103142852.8543-1-willy@infradead.org>
 <20201103171054.7d80b3010cac0bee705d0ae7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103171054.7d80b3010cac0bee705d0ae7@linux-foundation.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 05:10:54PM -0800, Andrew Morton wrote:
> On Tue,  3 Nov 2020 14:28:52 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Both btrfs and fuse have reported faults caused by seeing a retry
> > entry instead of the page they were looking for.  This was caused
> > by a missing check in the iterator.
> 
> Ambiguous.  What sort of "faults"?  Kernel pagefaults which cause
> oopses?
> 
> It would be helpful to to provide sufficient info so that a reader of
> this changelog can recognize whether this patch might fix some problem
> which is being observed.
> 
> > Reported-by: David Sterba <dsterba@suse.com>
> > Reported-by: Wonhyuk Yang <vvghjk1234@gmail.com>
> 
> Perhaps via links to these reports.

Reported by irc/mail, I'll try to dig the stack trace from the logs
again. The crash is hard to hit, there was just one occurence since 5.8
times.
