Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4453F149696
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 17:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAYQXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 11:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYQXn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:23:43 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22F020704;
        Sat, 25 Jan 2020 16:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579969422;
        bh=+juifvxy/KgpR+N92xUOC0DtDVqNTqTxv05RieS1qmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfCHzU+D6ZZZCxopaMtjDddfjgfuvTMHcnOiGfY7CC6xd4C7o02bFu5tNDdLwQ/bL
         9l0wyNEVOEJ2zSS3B1b8a6Oi3PU6H8NDmVWYVyzYdngMGA71zdZlOhbcu11rZ89DJp
         ubvcEAG3XeGfqf8y4Wc4xKNOuBpkgLq0Obto/NYc=
Date:   Sat, 25 Jan 2020 18:23:39 +0200
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
Message-ID: <20200125162339.GA41770@unreal>
References: <20200125021115.731629-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125021115.731629-1-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 06:11:12PM -0800, John Hubbard wrote:
> Leon Romanovsky:
>
> If you get a chance, I'd love to have this short series (or even just
> the first patch; the others are just selftests) run through your test
> suite that was previously choking on my earlier v11 patchset. The huge
> page pincount limitations are removed, so I'm expecting a perfect test
> run this time!
>

I added those patches to our regression and I will post the in the
couple of days.

Thanks
