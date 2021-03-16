Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027933D277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 12:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhCPLKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 07:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhCPLJ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91A16AC1D;
        Tue, 16 Mar 2021 11:09:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0202FDA6E2; Tue, 16 Mar 2021 12:07:24 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:07:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: Convert more kmaps to kmap_local_page()
Message-ID: <20210316110724.GJ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210312194141.GT7604@suse.cz>
 <20210312200500.GG3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312200500.GG3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:05:00PM -0800, Ira Weiny wrote:
> On Fri, Mar 12, 2021 at 08:41:41PM +0100, David Sterba wrote:
> > On Tue, Feb 16, 2021 at 06:48:22PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > I am submitting these for 5.13.
> > > 
> > > Further work to remove more kmap() calls in favor of the kmap_local_page() this
> > > series converts those calls which required more than a common pattern which
> > > were covered in my previous series[1].  This is the second of what I hope to be
> > > 3 series to fully convert btrfs.  However, the 3rd series is going to be an RFC
> > > because I need to have more eyes on it before I'm sure about what to do.  For
> > > now this series should be good to go for 5.13.
> > > 
> > > Also this series converts the kmaps in the raid5/6 code which required a fix to
> > > the kmap'ings which was submitted in [2].
> > 
> > Branch added to for-next and will be moved to the devel queue next week.
> > I've added some comments about the ordering requirement, that's
> > something not obvious. There's a comment under 1st patch but that's
> > trivial to fix if needed. Thanks.
> 
> I've replied to the first patch.  LMK if you want me to respin it.

No need to respin, patchset now in misc-next. Thanks.
