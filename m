Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9431372E17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhEDQbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 12:31:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:24729 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhEDQbI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 12:31:08 -0400
IronPort-SDR: GGPRvK42POdnaWTzf6UJfObP2JUqQ2XnAYUAHLdNxbTStLLbT1l85a9kRZ/2XH/M939b9E4sd9
 X7btombBzlgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178233168"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178233168"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 09:26:47 -0700
IronPort-SDR: iMM1w5i1o/pe9dU/14bcL12UD6cXjhMvYK0OU+cZMK18Iq0hbFaE1zdoHh1z90uXql94CFZ+rQ
 m9Pp4g//h8rw==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="607069961"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 09:26:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ldxsf-009a36-1U; Tue, 04 May 2021 19:26:41 +0300
Date:   Tue, 4 May 2021 19:26:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 12/14] seq_file: Replace seq_escape() with inliner
Message-ID: <YJF1wQQk60ssutRV@smile.fi.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
 <20210504102648.88057-13-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504102648.88057-13-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 04, 2021 at 01:26:46PM +0300, Andy Shevchenko wrote:
> Convert seq_escape() to use seq_escape_mem() rather than using
> a separate symbol. At the same time move it to header as inliner.

Seems making it an inliner opened a can of worms. So, for now, I will drop that
part from the series, while keeping fixes in my tree for the issues that have
been reported by LKP.

-- 
With Best Regards,
Andy Shevchenko


