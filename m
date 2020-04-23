Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02FF1B53E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 07:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDWFF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 01:05:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:18180 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWFF6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:05:58 -0400
IronPort-SDR: Y57X/DpYbBwZsYAu72v3nflOw9HDXIo+5lw7p9S48WkK6tc/Lz/l3IHFJ5c0F0cinGZC1xd4Qt
 I2A60v+nv74w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 22:05:58 -0700
IronPort-SDR: R8/hwfbiquKx9lajTQNsTcvgWmgTd/VNiubmA7RVKIQGmk0QnYQGE4AemX6LmFqL0s28JKVffz
 70/jtdRlPJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="255868475"
Received: from unknown (HELO iweiny-DESK2.sc.intel.com) ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 22:05:57 -0700
Date:   Wed, 22 Apr 2020 22:05:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yasunori Goto <y-goto@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V10 04/11] Documentation/dax: Update Usage section
Message-ID: <20200423050557.GG3758470@iweiny-DESK2.sc.intel.com>
References: <20200422212102.3757660-1-ira.weiny@intel.com>
 <20200422212102.3757660-5-ira.weiny@intel.com>
 <2282176d-60c5-0e4b-3cf9-7a7682de380d@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2282176d-60c5-0e4b-3cf9-7a7682de380d@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:33:26AM +0900, Yasunori Goto wrote:
> Hello,
> 
> I'm trying use your patch now, and I have a small comment in this document.
> 
> On 2020/04/23 6:20, ira.weiny@intel.com wrote:
> 
> > +To clarify inheritance here are 3 examples:
> > +
> > +Example A:
> > +
> > +mkdir -p a/b/c
> > +xfs_io 'chattr +x' a
> 
> Probably, "-c" is necessary here.
> 
> xfs_io -c 'chattr +x' a

Yes! Thanks!
> 
> 
> > +mkdir a/b/c/d
> > +mkdir a/e
> > +
> > +	dax: a,e
> > +	no dax: b,c,d
> > +
> > +Example B:
> > +
> > +mkdir a
> > +xfs_io 'chattr +x' a
> ditto
> > +mkdir -p a/b/c/d
> > +
> > +	dax: a,b,c,d
> > +	no dax:
> > +
> > +Example C:
> > +
> > +mkdir -p a/b/c
> > +xfs_io 'chattr +x' c
> ditto

Thank you!  Updated.
Ira

> > +mkdir a/b/c/d
> > +
> > +	dax: c,d
> > +	no dax: a,b
> > +
> > +
> 
> ---
> 
> Yasunori Goto
> 
