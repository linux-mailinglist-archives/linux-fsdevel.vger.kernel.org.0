Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C331CFCDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfJHOz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:55:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:37759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfJHOz6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:55:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 07:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="218307702"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2019 07:55:54 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHqu0-00030Q-Jo; Tue, 08 Oct 2019 17:55:52 +0300
Date:   Tue, 8 Oct 2019 17:55:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, changbin.du@intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH linux-kselftest-test 2/3] kunit: allow kunit to be loaded
 as a module
Message-ID: <20191008145552.GS32742@smile.fi.intel.com>
References: <1570545832-32326-1-git-send-email-alan.maguire@oracle.com>
 <1570545832-32326-3-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570545832-32326-3-git-send-email-alan.maguire@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:43:51PM +0100, Alan Maguire wrote:
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.

> +#ifdef MODULE

> +#endif /* MODULE */

This is strange. Why do you need ifdef?

-- 
With Best Regards,
Andy Shevchenko


