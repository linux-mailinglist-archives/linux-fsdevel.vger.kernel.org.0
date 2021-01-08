Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17E2EEF33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbhAHJLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:11:31 -0500
Received: from verein.lst.de ([213.95.11.211]:43163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbhAHJLb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:11:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74A2768C65; Fri,  8 Jan 2021 10:10:48 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:10:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/13] fs: clean up __mark_inode_dirty() a bit
Message-ID: <20210108091048.GA2587@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org> <20210105005452.92521-11-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-11-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:54:49PM -0800, Eric Biggers wrote:
> +	} else {
> +		/*
> +		 * Else it's either I_DIRTY_PAGES, I_DIRTY_TIME, or nothing.
> +		 * (We don't support setting both I_DIRTY_PAGES and I_DIRTY_TIME
> +		 * in one call to __mark_inode_dirty().)
> +		 */
> +		dirtytime = flags & I_DIRTY_TIME;
> +		WARN_ON_ONCE(dirtytime && (flags != I_DIRTY_TIME));

No need for the inner braces here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
