Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AEC61639
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2019 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfGGSzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 14:55:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47135 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727373AbfGGSzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:55:19 -0400
Received: from callcc.thunk.org (75-104-86-74.mobility.exede.net [75.104.86.74] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x67Isor0016470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Jul 2019 14:54:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6983542002E; Sun,  7 Jul 2019 14:54:50 -0400 (EDT)
Date:   Sun, 7 Jul 2019 14:54:50 -0400
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
Subject: Re: [PATCH v6 16/17] ext4: update on-disk format documentation for
 fs-verity
Message-ID: <20190707185450.GE19775@mit.edu>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-17-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701153237.1777-17-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 01, 2019 at 08:32:36AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the format of verity files on ext4, and the corresponding inode
> and superblock flags.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks!

					- Ted
