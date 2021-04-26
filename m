Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5436B425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhDZNdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:33:45 -0400
Received: from verein.lst.de ([213.95.11.211]:41303 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDZNdp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:33:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8FF7B68C7B; Mon, 26 Apr 2021 15:33:00 +0200 (CEST)
Date:   Mon, 26 Apr 2021 15:33:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] fcntl: remove unused VALID_UPGRADE_FLAGS
Message-ID: <20210426133300.GA14812@lst.de>
References: <20210423111037.3590242-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-1-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:10:35PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> We currently do not maky use of this feature and should we implement
> something like this in the future it's trivial to add it back.

Looks like that ->upgrade_mask field never made it into mainline?

Either way removing and unused mask always seems valid, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
