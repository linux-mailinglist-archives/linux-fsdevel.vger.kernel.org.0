Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F13AEB1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUOYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhFUOYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:24:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99253C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 07:22:37 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKop-00Ar8g-TS; Mon, 21 Jun 2021 14:22:31 +0000
Date:   Mon, 21 Jun 2021 14:22:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YNCgp7wkQ4mXAJP1@zeniv-ca.linux.org.uk>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk>
 <20210621135958.GA1013@lst.de>
 <YNCcG97WwRlSZpoL@casper.infradead.org>
 <20210621140956.GA1887@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621140956.GA1887@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 04:09:56PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 21, 2021 at 03:03:07PM +0100, Matthew Wilcox wrote:
> > i suggested that to viro last night, and he pointed out that ioctl(S_SYNC)
> 
> Where would that S_SYNC ioctl be implemented?

	S_SYNC is not an ioctl, it's an inode flag settable by such.
FS_IOC_SETFLAGS with FS_SYNC_FL in flags, or FS_IOC_FSSETXATTR
with FS_XFLAG_SYNC.
