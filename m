Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EFC14C619
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 06:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgA2FsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 00:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgA2FsC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:48:02 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221AE2071E;
        Wed, 29 Jan 2020 05:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580276881;
        bh=Y+9aIhN4apiy5tD4uo8NEkUkqCFQBUmX8iUUCn+SJz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GA4xldnrfCZ/hBa/e+u4jH+ceiMp46v485VEdcIQS+PL2onNs2Lp344hOSwut0cl5
         kMjlKcFvkhxbeePcWEiAlqewXAYnKlDFlVtI4vZlErWp9sEeIGhuDBlR6Xyf3B/MvB
         77hB3BnefN51UHOfzz/YcUfa9FLW3mE857JX1mzU=
Date:   Wed, 29 Jan 2020 07:47:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] mm/gup: track FOLL_PIN pages (follow on from v12)
Message-ID: <20200129054756.GB3326@unreal>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
 <20200125162339.GA41770@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125162339.GA41770@unreal>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 25, 2020 at 06:23:39PM +0200, Leon Romanovsky wrote:
> On Fri, Jan 24, 2020 at 06:11:12PM -0800, John Hubbard wrote:
> > Leon Romanovsky:
> >
> > If you get a chance, I'd love to have this short series (or even just
> > the first patch; the others are just selftests) run through your test
> > suite that was previously choking on my earlier v11 patchset. The huge
> > page pincount limitations are removed, so I'm expecting a perfect test
> > run this time!
> >
>
> I added those patches to our regression and I will post the in the
> couple of days.

Hi John,

The patches survived our RDMA verification night runs.

Thanks

>
> Thanks
>
