Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0D4701A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfFOM6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 08:58:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37949 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbfFOM6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:58:17 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCvtK2003696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 08:57:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE108420484; Sat, 15 Jun 2019 08:57:55 -0400 (EDT)
Date:   Sat, 15 Jun 2019 08:57:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 06/16] fs-verity: add inode and superblock fields
Message-ID: <20190615125755.GG6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-7-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:51:55AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Analogous to fs/crypto/, add fields to the VFS inode and superblock for
> use by the fs/verity/ support layer:
> 
> - ->s_vop: points to the fsverity_operations if the filesystem supports
>   fs-verity, otherwise is NULL.
> 
> - ->i_verity_info: points to cached fs-verity information for the inode
>   after someone opens it, otherwise is NULL.
> 
> - S_VERITY: bit in ->i_flags that identifies verity inodes, even when
>   they haven't been opened yet and thus still have NULL ->i_verity_info.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
