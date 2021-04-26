Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D326B36B429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhDZNfk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:35:40 -0400
Received: from verein.lst.de ([213.95.11.211]:41313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhDZNfk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:35:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8375068C4E; Mon, 26 Apr 2021 15:34:56 +0200 (CEST)
Date:   Mon, 26 Apr 2021 15:34:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] open: don't silently ignore unknown O-flags in
 openat2()
Message-ID: <20210426133456.GB14812@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-2-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:10:36PM +0200, Christian Brauner wrote:
> There's a snafu here though stripping FMODE_* directly from flags would
> cause the upper 32 bits to be truncated as well due to integer promotion
> rules since FMODE_* is unsigned int, O_* are signed ints (yuck).
> 
> This change shouldn't regress old open syscalls since they silently
> truncate any unknown values.

So, this is a change in behavior for openat.  But given how new it is
and there are not flags defined yet in the truncated range I think
we should be fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
