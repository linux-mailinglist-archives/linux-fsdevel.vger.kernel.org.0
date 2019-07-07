Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0766861631
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfGGSyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 14:54:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47080 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727373AbfGGSyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:54:49 -0400
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net [75.104.86.74] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67IsJgr016282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Jul 2019 14:54:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7EC8C42002E; Sun,  7 Jul 2019 14:54:18 -0400 (EDT)
Date:   Sun, 7 Jul 2019 14:54:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 15/17] ext4: add fs-verity read support
Message-ID: <20190707185418.GD19775@mit.edu>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-16-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701153237.1777-16-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:32:35AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make ext4_mpage_readpages() verify data as it is read from fs-verity
> files, using the helper functions from fs/verity/.
> 
> To support both encryption and verity simultaneously, this required
> refactoring the decryption workflow into a generic "post-read
> processing" workflow which can do decryption, verification, or both.
> 
> The case where the ext4 block size is not equal to the PAGE_SIZE is not
> supported yet, since in that case ext4_mpage_readpages() sometimes falls
> back to block_read_full_page(), which does not support fs-verity yet.
> 
> Co-developed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  Since there's a S-o-B, some might claim that a
Reviewed-by: is not necessary, but to the extent that you modified
this code as well:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

							- Ted
