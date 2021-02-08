Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD163129D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBHEms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 23:42:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:13382 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBHEmr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 23:42:47 -0500
IronPort-SDR: BiH4qD6/hl3RMmH460ZSzQMM+thi9DIIPFRK7bMfPWvHXHPhbAirBBMZL18mkKmhDMU0w4PbXm
 DJphH0Srn1Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="169341982"
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="169341982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 20:42:05 -0800
IronPort-SDR: lDzmoh8+UisZyVs1ZdC9r6kw83BmFeBWP09Iyvk1+CUVLR3QZX6dMgmpSW6/pKun3V1xaUAOt7
 PTdNFalIGYjw==
X-IronPort-AV: E=Sophos;i="5.81,161,1610438400"; 
   d="scan'208";a="376972543"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 20:42:05 -0800
Date:   Sun, 7 Feb 2021 20:42:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/8] use core page calls instead of kmaps
Message-ID: <20210208044205.GG5033@iweiny-DESK2.sc.intel.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655721C8EE8BAFF055EE2986B09@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655721C8EE8BAFF055EE2986B09@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 07:10:41PM +0000, Chaitanya Kulkarni wrote:
> On 2/7/21 11:04, Chaitanya Kulkarni wrote:
> > Chaitanya Kulkarni (8):
> >   brd: use memcpy_from_page() in copy_from_brd()
> >   brd: use memcpy_from_page() in copy_from_brd()
> I'm aware that couple of places in brd code we can use memcpy_to_page()
> and get rid the local variable, once I get some feedback I'll add those
> to the V1.

Except for the one comment I had this series look's good to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
Ira

