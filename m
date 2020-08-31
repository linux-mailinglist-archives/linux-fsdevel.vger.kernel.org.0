Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E7257F14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHaQwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 12:52:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:32509 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbgHaQwZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:52:25 -0400
IronPort-SDR: uQmyXIbDaE76I5btjcgNkFxTP1fKaZTdxPVobPta2pd2ZBrk4qboaYcFZNqR7Qx0PIk30Bi9Ck
 Ej+u7pulqyXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175066387"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="175066387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 09:52:23 -0700
IronPort-SDR: W2+IE27pQLjMaQbC7PYHRurSpcOOAvO8WlyMWDfsKP/zKKBAXOlnNvxMwl67pea2uOmir0Z/fg
 4h0UqW2z0TEg==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="476800745"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 09:52:23 -0700
Date:   Mon, 31 Aug 2020 09:52:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] bio: convert get_user_pages_fast() -->
 pin_user_pages_fast()
Message-ID: <20200831165222.GD1422350@iweiny-DESK2.sc.intel.com>
References: <20200831071439.1014766-1-jhubbard@nvidia.com>
 <20200831071439.1014766-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831071439.1014766-4-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:14:39AM -0700, John Hubbard wrote:
> @@ -1113,8 +1113,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		} else {
>  			if (is_bvec)
>  				ret = __bio_iov_bvec_add_pages(bio, iter);
> -			else
> -				ret = __bio_iov_iter_get_pages(bio, iter);
> +		else
> +			ret = __bio_iov_iter_get_pages(bio, iter);

Why the white space change?

Ira

