Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158D953D285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbiFCTyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbiFCTyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:54:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53801D30E;
        Fri,  3 Jun 2022 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654286077; x=1685822077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CaFO/iXD7sRcghcUSPnu+r4c0rV8FNtB7V9ExAVELc0=;
  b=i1GCS2U2FXVhcjTOdvYv/CuebLdMmb2/uhBePB9vILb8VMZYEA/f/Rrv
   IKVmkSOLkXlu3JO+q8aiVGKDQ4t3bTCLLRVF0PupokI2s3UA+Z8Qp8LZy
   OSYiXDleCIstuWkoSr8Y3vS4iQVZ1ImMFa1guiS19V6pe0bZZuqkEYwv6
   L14HoDPgNl/GsyljwVQgPb9Qr1pqPG1cmCNISwA6oaqYFUNePpijrS+Uw
   McOVdIpgyYEfDtVyxsxAq1ZPaAJSlZK6WAoeOSw95wQ7E8zQvgg9L0u9W
   S1wYNZsnra33fqXsVmxMMP0eeFdMte69UFWknTQaI7i3pxG+KWGdlJUJP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="258416711"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="258416711"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 12:54:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="563953452"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 12:54:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxDNR-000SlB-9z;
        Fri, 03 Jun 2022 22:54:33 +0300
Date:   Fri, 3 Jun 2022 22:54:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] xarray: Replace kernel.h with the necessary
 inclusions
Message-ID: <Yppm+dpvOGjy7nlf@smile.fi.intel.com>
References: <20220603171153.48928-1-andriy.shevchenko@linux.intel.com>
 <YppCIr4qM3lVYi8N@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YppCIr4qM3lVYi8N@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 03, 2022 at 06:17:22PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 03, 2022 at 08:11:53PM +0300, Andy Shevchenko wrote:
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> > 
> > Replace kernel.h inclusion with the list of what is really being used.
> 
> Thanks.  Can you fix the test suite too?
> 
> (cd tools/testing/radix-tree; make)

Works for me. Anything special I should try?


-- 
With Best Regards,
Andy Shevchenko


