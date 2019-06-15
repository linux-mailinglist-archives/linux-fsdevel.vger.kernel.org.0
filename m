Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C2346FF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfFOMlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 08:41:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35466 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbfFOMlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:41:13 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCemMs031646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 08:40:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 94DF5420484; Sat, 15 Jun 2019 08:40:48 -0400 (EDT)
Date:   Sat, 15 Jun 2019 08:40:48 -0400
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
Subject: Re: [PATCH v4 04/16] fs: uapi: define verity bit for FS_IOC_GETFLAGS
Message-ID: <20190615124048.GE6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-5-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:51:53AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add FS_VERITY_FL to the flags for FS_IOC_GETFLAGS, so that applications
> can easily determine whether a file is a verity file at the same time as
> they're checking other file flags.  This flag will be gettable only;
> FS_IOC_SETFLAGS won't allow setting it, since an ioctl must be used
> instead to provide more parameters.
> 
> This flag matches the on-disk bit that was already allocated for ext4.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
