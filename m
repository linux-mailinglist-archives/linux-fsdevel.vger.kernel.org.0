Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9672C30B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 20:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbgKXTVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 14:21:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:6100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390919AbgKXTVQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:21:16 -0500
IronPort-SDR: pS9IGid3UMhq7vQjDQySwdi7mA/+ewaLa+aFtTQ0QpjRbB2tRXkEu1RHAvd75seP2Q7exG86yG
 +XZcn+yUHbCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159047623"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="159047623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 11:21:14 -0800
IronPort-SDR: OLNL98UQqTjBcLDUXxkbsVgEdVfu7E4xZ239WXHSDV8ctQuGRixvVjwDyVnTWnRymaMZHSDKY/
 55TSGREREBhQ==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="478606996"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 11:21:14 -0800
Date:   Tue, 24 Nov 2020 11:21:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Steve French <sfrench@samba.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Brian King <brking@us.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/17] mm/highmem: Lift memcpy_[to|from]_page and
 memset_page to core
Message-ID: <20201124192113.GL1161629@iweiny-DESK2.sc.intel.com>
References: <20201124060755.1405602-1-ira.weiny@intel.com>
 <20201124060755.1405602-2-ira.weiny@intel.com>
 <20201124141941.GB4327@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124141941.GB4327@casper.infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:19:41PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 23, 2020 at 10:07:39PM -0800, ira.weiny@intel.com wrote:
> > +static inline void memzero_page(struct page *page, size_t offset, size_t len)
> > +{
> > +	memset_page(page, 0, offset, len);
> > +}
> 
> This is a less-capable zero_user_segments().

Actually it is a duplicate of zero_user()...  Sorry I did not notice those...
:-(

Why are they called '_user_'?

Ira
