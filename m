Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1162DFD811
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 09:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKOIo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 03:44:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:56496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfKOIo5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:44:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2FDBAC6F;
        Fri, 15 Nov 2019 08:44:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54295DA783; Fri, 15 Nov 2019 09:44:57 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:44:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Documentation/fs: Move swap_[de]activate() to
 file_operations
Message-ID: <20191115084457.GM3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ira.weiny@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20191114231943.11220-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114231943.11220-1-ira.weiny@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:19:43PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the documentation for the move of the swap_* functions out of
> address_space_operations and into file_operations.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Follow on to the V2 series sent earlier.  If I need to spin a V3 I will squash
> this into patch 2/2 "fs: Move swap_[de]activate to file_operations"

Reviewed-by: David Sterba <dsterba@suse.com>
