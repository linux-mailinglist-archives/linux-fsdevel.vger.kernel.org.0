Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2C545A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 05:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiFJDAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 23:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:00:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F4B64;
        Thu,  9 Jun 2022 19:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654829999; x=1686365999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NpfjrUxwZjqz+oD34kwQKT0hlbpBzu6q8cyOoWDqa3E=;
  b=PkfJ8Wvv05DJIYZS0/WN2urroR35HKwEyWQor7VXFLS1oZtgOQ5jsPbu
   UkJLWUH7Lfq0auRyHVxl7LNNHd3eNksFbI7VEfmLnnB4sWfXyu82Mm5QK
   MEiqBMwGurYwnrJtY3mxWc7QBUqHD/jCNIdgGj3DzRcvVpdEotg2mX5jY
   /Ez2xCST2rPeH6KbA6yEegypQT7wVrD6yAHy439vQnEgFS3lNY9J31LOP
   Jo67zYup4kougnxSuaz1ZmQ1ee5/sbCO6vfbH13FU/fGrz7EZ7zbkQUb7
   YolnLS6KEjFDQU7IbIrIhcRh9ro5A3DeaJc4UCwXBR8vUclR5ankUfErH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="363820065"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="363820065"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:59:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="585961503"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:59:55 -0700
Date:   Fri, 10 Jun 2022 10:59:52 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
Subject: Re: [fs]  e1bbcd277a: xfstests.generic.633.fail
Message-ID: <20220610025952.GB6844@xsang-OptiPlex-9020>
References: <20220609081742.GA17678@xsang-OptiPlex-9020>
 <20220609083945.c2ezz7ldvqofunpm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609083945.c2ezz7ldvqofunpm@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi, Christian,
 
On Thu, Jun 09, 2022 at 10:39:45AM +0200, Christian Brauner wrote:
> 
> Since e1bbcd277a53 ("fs: hold writers when changing mount's idmapping")
> this behavior is expected and is explained in detail in the pull request
> that contained this patch.
> 
> Upstream xfstests has been updated in commit
> 781bb995a149 ("vfs/idmapped-mounts: remove invalid test")
> and would not fail.

Thanks for information! we would upgrade our xfstests.

> 
> Thanks!
> Christian
