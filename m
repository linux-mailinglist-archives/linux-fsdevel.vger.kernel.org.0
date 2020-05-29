Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFA1E72ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 04:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407223AbgE2CzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:55:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53391 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406778AbgE2CzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:55:09 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T2sfhO021649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 22:54:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AB339420304; Thu, 28 May 2020 22:54:41 -0400 (EDT)
Date:   Thu, 28 May 2020 22:54:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     ira.weiny@intel.com
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/9] Enable ext4 support for per-file/directory DAX
 operations
Message-ID: <20200529025441.GI228632@mit.edu>
References: <20200528150003.828793-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528150003.828793-1-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 07:59:54AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Changes from V4:
> 	Fix up DAX mutual exclusion with other flags.
> 	Add clean up patch (remove jflags)
> 
> Changes from V3:
> 	Change EXT4_DAX_FL to bit24
> 	Cache device DAX support in the super block and use that is
> 		ext4_should_use_dax()
> 
> Changes from V2:
> 	Rework DAX exclusivity with verity and encryption based on feedback
> 	from Eric
> 
> Enable the same per file DAX support in ext4 as was done for xfs.  This series
> builds and depends on the V11 series for xfs.[1]
> 
> This passes the same xfstests test as XFS.
> 
> The only issue is that this modifies the old mount option parsing code rather
> than waiting for the new parsing code to be finalized.
> 
> This series starts with 3 fixes which include making Verity and Encrypt truly
> mutually exclusive from DAX.  I think these first 3 patches should be picked up
> for 5.8 regardless of what is decided regarding the mount parsing.
> 
> [1] https://lore.kernel.org/lkml/20200428002142.404144-1-ira.weiny@intel.com/
> 
> To: linux-ext4@vger.kernel.org
> To: Andreas Dilger <adilger.kernel@dilger.ca>
> To: "Theodore Y. Ts'o" <tytso@mit.edu>
> To: Jan Kara <jack@suse.cz>
> To: Eric Biggers <ebiggers@kernel.org>

Thanks, applied to the ext4-dax branch.

						- Ted
