Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595E73493EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 15:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCYOYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 10:24:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47937 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229731AbhCYOYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:24:10 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12PEMsvK022736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 10:22:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3E0E615C39CC; Thu, 25 Mar 2021 10:22:54 -0400 (EDT)
Date:   Thu, 25 Mar 2021 10:22:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com, clm@fb.com,
        ira.weiny@intel.com, dsterba@suse.com, ebiggers@kernel.org,
        hch@infradead.org, dave.hansen@intel.com
Subject: Re: [RFC PATCH 6/8] ext4: use memcpy_to_page() in pagecache_write()
Message-ID: <YFycvk4aMoPAZcwJ@mit.edu>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207190425.38107-7-chaitanya.kulkarni@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:04:23AM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/ext4/verity.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Hi, were you expecting to have file system maintainers take these
patches into their own trees?  The ext4 patches look good, and unless
you have any objections, I can take them through the ext4 tree.

Thanks,

    	     		       	    - Ted
