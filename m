Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6503494F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCYPJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:09:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:34476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhCYPJH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:09:07 -0400
IronPort-SDR: HexJjoS+zmQSUEZr9wgHn7WvUexPiilaOq34LDO5F+bV5kd3bwX/9Ob58WdzGaoMRX3J1mbN3r
 ZJ2z7CRIvenQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187645242"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="187645242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:09:07 -0700
IronPort-SDR: TdFsjK737sdvRzKo9OH8ApPIwJ7KYIKIbkmYaGTUalxVWLiB6dkDFjbzKYBEMfEIALjFk7Wsxm
 fC9V5/CgJMew==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="409406687"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 08:09:07 -0700
Date:   Thu, 25 Mar 2021 08:09:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com, clm@fb.com,
        dsterba@suse.com, ebiggers@kernel.org, hch@infradead.org,
        dave.hansen@intel.com
Subject: Re: [RFC PATCH 6/8] ext4: use memcpy_to_page() in pagecache_write()
Message-ID: <20210325150906.GW3014244@iweiny-DESK2.sc.intel.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-7-chaitanya.kulkarni@wdc.com>
 <YFycvk4aMoPAZcwJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFycvk4aMoPAZcwJ@mit.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:22:54AM -0400, Theodore Y. Ts'o wrote:
> On Sun, Feb 07, 2021 at 11:04:23AM -0800, Chaitanya Kulkarni wrote:
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >  fs/ext4/verity.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Hi, were you expecting to have file system maintainers take these
> patches into their own trees?  The ext4 patches look good, and unless
> you have any objections, I can take them through the ext4 tree.

I think going through the ext4 tree would be fine.

However, there was a fix needed in patch 2/8.  Chaitanya was a V1 sent?

Ira
