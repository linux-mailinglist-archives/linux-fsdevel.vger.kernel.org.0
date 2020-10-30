Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A5B2A0DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 19:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgJ3StV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 14:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3StV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:49:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469AC0613CF;
        Fri, 30 Oct 2020 11:49:21 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYZSg-00CDdq-FN; Fri, 30 Oct 2020 18:49:18 +0000
Date:   Fri, 30 Oct 2020 18:49:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Qian Cai <cai@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
Message-ID: <20201030184918.GQ3576660@ZenIV.linux.org.uk>
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:

> See other reply, it's being posted soon, just haven't gotten there yet
> and it wasn't ready.
> 
> It's a prep patch so we can call do_renameat2 and pass in a filename
> instead. The intent is not to have any functional changes in that prep
> patch. But once we can pass in filenames instead of user pointers, it's
> usable from io_uring.

You do realize that pathname resolution is *NOT* offloadable to helper
threads, I hope...
