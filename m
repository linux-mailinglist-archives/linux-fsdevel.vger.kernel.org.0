Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB12F108D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbhAKKwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 05:52:44 -0500
Received: from verein.lst.de ([213.95.11.211]:50165 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbhAKKwo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:52:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C478967373; Mon, 11 Jan 2021 11:52:01 +0100 (CET)
Date:   Mon, 11 Jan 2021 11:52:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 04/12] fat: only specify I_DIRTY_TIME when needed in
 fat_update_time()
Message-ID: <20210111105201.GB2502@lst.de>
References: <20210109075903.208222-1-ebiggers@kernel.org> <20210109075903.208222-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-5-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:58:55PM -0800, Eric Biggers wrote:
> +	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> +		dirty_flags |= I_DIRTY_SYNC;

fat does not support i_version updates, so this bit can be skipped.
