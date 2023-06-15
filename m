Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF37311BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbjFOIGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 04:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFOIGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:06:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73E1709;
        Thu, 15 Jun 2023 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686816364; x=1718352364;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cE0imxgo5OZIB2fcU90wVkO4chUCAdIiRch7+SIGZ98=;
  b=eLLmMuxsFcBLgHnJbBUC+IVMP0Ffb9LtO8MucPzbZ8DAk0leKnI6q2vV
   zGQn3rQGEPj9zkLfLluFTjxAFmbFHK+kOdIlrvkGEXOcg+TrFXs+fqbGM
   phaBNYpEYgIglaP+ONpqUWgjYWcDoCOkK0SSPkarxAxGmZDdqLmaD7qKf
   YuMDxeBtO5e9Nb8hSAOFoMrctmcB2atm+09ujR7kwIUCUD+hcVkUMoyHc
   WUCOy9Hyir73gAPxhYrLNdAlBYrjtgkUdo2Y55jAe6CWHVtAz3GtKittk
   HXZcEB4+TlOXfJTQaRglrGAeO9b+267SkR3I8pl47qON6NOu4jBU0ykbS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338471403"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="338471403"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 01:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886563710"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="886563710"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.136.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 01:06:02 -0700
Date:   Thu, 15 Jun 2023 10:05:57 +0200
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: deprecate md bitmap file support
Message-ID: <20230615100557.00003d8e@linux.intel.com>
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Jun 2023 08:48:29 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi Song,
> 
> the md bitmap file support is very problematic in how it bypasses the
> file system for file access.  I looked into fixing it in preparation
> for making buffer_head optionals but had to give up because it is so
> convoluted.  This series includes the cleanups I've started which seem
> useful even for the internal bitmap support, then makes the bitmap file
> support conditional and adds a deprecation warning.
> 
Hi Christoph,
I think that it is worthy to make mdadm aware of that. For example, by requiring
"--force" to make the volume with bitmap file now.

Thanks,
Mariusz
