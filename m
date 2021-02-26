Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBC326733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 20:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBZTFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 14:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZTFi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:05:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B1D464F1B;
        Fri, 26 Feb 2021 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614366295;
        bh=PfeQuDYBIjQHtNJ4RxOXOTAV74C+Re27WPBrWtzUDU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nGGKVLRykjmczWP3FyivF6q0SYw6J8EAG4OIZIx2MxP8mAiZ/Isk3756eCG1HlOdt
         E/oCaXcPPD8hThBiCj/+yfoWeN0n2CjA/Z/05xkmNmTvaxvC1Tmwpj9PM+P6+2q7zT
         1w2DKcFQSLF7aMWyQc2Zr1L3FiSB1ZR1/RjUmfWcmebygeM6qp0oenFuBe1DutDFWw
         2iXkgZarGC5e6UNsbo+wm3l93zCTzETISjYVwRYJZGJwUvovCL9yboyyXfx4sLxw+y
         qGOl89rmrHNo9QgYn5VEseoY1bwzOSPMtj4cw8YtZWrBYgo4prpP+aUsJsoXaYAW5S
         kdxN4BoF0OWHg==
Date:   Fri, 26 Feb 2021 11:04:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
Message-ID: <20210226190454.GD7272@magnolia>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> Hi, guys
> 
> Beside this patchset, I'd like to confirm something about the
> "EXPERIMENTAL" tag for dax in XFS.
> 
> In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> when we mount a pmem device with dax option, has been existed for a
> while.  It's a bit annoying when using fsdax feature.  So, my initial
> intention was to remove this tag.  And I started to find out and solve
> the problems which prevent it from being removed.
> 
> As is talked before, there are 3 main problems.  The first one is "dax
> semantics", which has been resolved.  The rest two are "RMAP for
> fsdax" and "support dax reflink for filesystem", which I have been
> working on.  

<nod>

> So, what I want to confirm is: does it means that we can remove the
> "EXPERIMENTAL" tag when the rest two problem are solved?

Yes.  I'd keep the experimental tag for a cycle or two to make sure that
nothing new pops up, but otherwise the two patchsets you've sent close
those two big remaining gaps.  Thank you for working on this!

> Or maybe there are other important problems need to be fixed before
> removing it?  If there are, could you please show me that?

That remains to be seen through QA/validation, but I think that's it.

Granted, I still have to read through the two patchsets...

--D

> 
> Thank you.
> 
> 
> --
> Ruan Shiyang.
