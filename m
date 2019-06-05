Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0248D36120
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 18:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfFEQWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 12:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:58560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfFEQWI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:22:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 537BDAD81;
        Wed,  5 Jun 2019 16:22:07 +0000 (UTC)
Date:   Wed, 5 Jun 2019 11:22:04 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] The end of the DAX experiment
Message-ID: <20190605162204.jzou5hry5exly5wx@fiona>
References: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
 <20190214134622.GG4525@dhcp22.suse.cz>
 <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
 <20190214191013.GA3420@redhat.com>
 <CAPcyv4jLTdJyTOy715qvBL_j_deiLoBmu_thkUnFKZKMvZL6hA@mail.gmail.com>
 <20190214200840.GB12668@bombadil.infradead.org>
 <CAPcyv4hsDqvrV5yiDq8oWPuWb3WpuCEk_HB4qBxfiDpUwo75QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hsDqvrV5yiDq8oWPuWb3WpuCEk_HB4qBxfiDpUwo75QQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan/Jerome,

On 12:20 14/02, Dan Williams wrote:
> On Thu, Feb 14, 2019 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Feb 14, 2019 at 11:31:24AM -0800, Dan Williams wrote:
> > > On Thu, Feb 14, 2019 at 11:10 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > I am just again working on my struct page mapping patchset as well as
> > > > the generic page write protection that sits on top. I hope to be able
> > > > to post the v2 in couple weeks. You can always look at my posting last
> > > > year to see more details.
> > >
> > > Yes, I have that in mind as one of the contenders. However, it's not
> > > clear to me that its a suitable fit for filesystem-reflink. Others
> > > have floated the 'page proxy' idea, so it would be good to discuss the
> > > merits of the general approaches.
> >
> > ... and my preferred option of putting pfn entries in the page cache.
> 
> Another option to include the discussion.
> 
> > Or is that what you meant by "page proxy"?
> 
> Page proxy would be an object that a filesystem could allocate to
> point back to a single physical 'struct page *'. The proxy would
> contain an override for page->index.

Was there any outcome on this and its implementation? I am specifically
interested in this for DAX support on btrfs/CoW: The TODO comment on
top of dax_associate_entry() :)

If there are patches/git tree I could use to base my patches on, it would
be nice.

-- 
Goldwyn
