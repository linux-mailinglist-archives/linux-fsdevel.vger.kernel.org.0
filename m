Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71711497B12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiAXJJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 04:09:01 -0500
Received: from verein.lst.de ([213.95.11.211]:54754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbiAXJI7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:08:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B760268BEB; Mon, 24 Jan 2022 10:08:55 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:08:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] unicode: clean up the Kconfig symbol confusion
Message-ID: <20220124090855.GA23041@lst.de>
References: <20220118065614.1241470-1-hch@lst.de> <87zgnp51wo.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgnp51wo.fsf@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 08:10:47PM -0500, Gabriel Krisman Bertazi wrote:
> > Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I fixed the typo and pushed the patch to a linux-next visible branch
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=5298d4bfe80f6ae6ae2777bcd1357b0022d98573
> 
> I'm also sending a patch series shortly turning IS_ENABLED into part of
> the code flow where possible.

Thanks.  It might make sense to get the one patch to Linux for 5.17
so that we don't have the new Kconfig symbol for just one release.
