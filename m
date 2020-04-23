Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733FB1B5FE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgDWPvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:51:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:18253 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgDWPvF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:51:05 -0400
IronPort-SDR: iCszd0G4Ujdr87T0eDt68upmV08vAgOF7rCJTERnu0X4jKCjiYfbVZI8gpqwPqeEeuYTb/kq6b
 ih85JsoUW98w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 08:51:04 -0700
IronPort-SDR: fDD7XH2iw6tpq8cmPtNFem6pcwSGiELXE8STeEdcYUZbOgmOY68Tia/PJ11IhAb5fVG/xKMBiO
 9LbfqUefDMXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,307,1583222400"; 
   d="scan'208";a="274271906"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2020 08:51:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jRe81-002fFB-Ot; Thu, 23 Apr 2020 18:51:05 +0300
Date:   Thu, 23 Apr 2020 18:51:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Message-ID: <20200423155105.GX185537@smile.fi.intel.com>
References: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
 <BYAPR04MB49654BB8430FA45980CB64D186D30@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49654BB8430FA45980CB64D186D30@BYAPR04MB4965.namprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 03:43:32PM +0000, Chaitanya Kulkarni wrote:
> On 04/23/2020 08:32 AM, Andy Shevchenko wrote:
> > There is a specific API to treat raw data as UUID, i.e. import_uuid().
> > Use it instead of uuid_copy() with explicit casting.
> >
> > Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> 
> At the end it does the same thing,

For now yes, who knows how uuid_t will look like in the future...

> I think we can avoid cast though.

This and possibility to change uuid_t if needed.

> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


