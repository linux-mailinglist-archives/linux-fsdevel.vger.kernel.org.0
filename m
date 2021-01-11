Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592842F1093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 11:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbhAKKxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 05:53:12 -0500
Received: from verein.lst.de ([213.95.11.211]:50178 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbhAKKxM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:53:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB8D668AFE; Mon, 11 Jan 2021 11:52:29 +0100 (CET)
Date:   Mon, 11 Jan 2021 11:52:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 08/12] fs: drop redundant check from
 __writeback_single_inode()
Message-ID: <20210111105229.GC2502@lst.de>
References: <20210109075903.208222-1-ebiggers@kernel.org> <20210109075903.208222-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-9-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:58:59PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> wbc->for_sync implies wbc->sync_mode == WB_SYNC_ALL, so there's no need
> to check for both.  Just check for WB_SYNC_ALL.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
