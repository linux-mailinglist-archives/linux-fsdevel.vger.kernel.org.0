Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAA2EEF4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbhAHJQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:16:07 -0500
Received: from verein.lst.de ([213.95.11.211]:43183 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbhAHJQH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:16:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C5B1468AFE; Fri,  8 Jan 2021 10:15:24 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:15:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/13] xfs: remove a stale comment from
 xfs_file_aio_write_checks()
Message-ID: <20210108091522.GD2587@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org> <20210105005452.92521-13-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-13-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:54:51PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The comment in xfs_file_aio_write_checks() about calling file_modified()
> after dropping the ilock doesn't make sense, because the code that
> unconditionally acquires and drops the ilock was removed by
> commit 467f78992a07 ("xfs: reduce ilock hold times in
> xfs_file_aio_write_checks").
> 
> Remove this outdated comment.

Yes, this looks good, I actually have the removal included in a WIP
patch as well, but splitting it out like this look good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
