Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6331952F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhBKVdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 16:33:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:62873 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhBKVdQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:33:16 -0500
IronPort-SDR: npkp9PrmGxWvc9ER9Tp/eTfpo9Yg+C8nuVJ677aUa3pOxUT5ToppVd9h62f/ddhL+4PQCfMOAC
 kB44GN/kYxVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246387234"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="246387234"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 13:32:35 -0800
IronPort-SDR: 94fL2dEMOOjUai1Z6WRLjIcOaL566MkT4Yx4UtrDx0NKQ5rXJvT2HTbpxHigw+8AFoTZD4Oiwh
 kGkF2eke5vXA==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="578946605"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 13:32:35 -0800
Date:   Thu, 11 Feb 2021 13:32:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Andrew Morton <akpm@linux-foundation.org>,
        clm@fb.com, josef@toxicpanda.com,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] btrfs: convert kmaps to core page calls
Message-ID: <20210211213235.GK3014244@iweiny-DESK2.sc.intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210211193803.GH1993@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211193803.GH1993@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 08:38:03PM +0100, David Sterba wrote:
> On Tue, Feb 09, 2021 at 10:22:13PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Per the conversation on V1 it looks like Andrew would like this to go through
> > the btrfs tree.  I think that is fine.  The other users of
> > memcpy_[to|from]_page are probably not ready and I believe could be taken in an
> > early rc after David submits.
> > 
> > Is that ok with you David?
> 
> Yes.
> 
> The branch is now in
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=kmap-conversion
> let me know if I've missed acked-by or reviewed-by, I added those sent
> to the mailinglist and added mine to the btrfs ones and to the iov_iter
> patch.

Looks good.  Thank you!

> 
> I'll add the patchset to my for-next so it gets picked by linux-next and
> will keep testing it for at least a week.
> 
> Though this is less than the expected time before merge window, the
> reasoning is that it's exporting helpers that are going to be used in
> various subsystems. The changes in btrfs are simple and would allow to
> focus on the other less trivial conversions. ETA for the pull request is
> mid of the 2nd week of the merge window or after rc1.

Thanks for working with me on this.  Yes these were the more straight forward
conversions.  The next set will require more review and I should have them
posted soon at least for RFC.  Unfortunately, there are 2 places which are
proving difficult to follow the mapping orders required of kmap_local_page().
I'll open that discussion with the next round of conversions.

For now, thank you again,
Ira

