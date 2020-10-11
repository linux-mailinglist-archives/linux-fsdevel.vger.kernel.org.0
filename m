Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E00228A91A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgJKSBd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgJKSBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 14:01:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946DC0613CE;
        Sun, 11 Oct 2020 11:01:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRfeY-00FWTv-92; Sun, 11 Oct 2020 18:01:02 +0000
Date:   Sun, 11 Oct 2020 19:01:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: remove do_mounts
Message-ID: <20201011180102.GB3576660@ZenIV.linux.org.uk>
References: <20200917082236.2518236-1-hch@lst.de>
 <20200917082236.2518236-6-hch@lst.de>
 <20201011141749.GA126978@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011141749.GA126978@roeck-us.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 11, 2020 at 07:17:49AM -0700, Guenter Roeck wrote:

> Someone didn't bother test building this patch.
> 
> arch/alpha/kernel/osf_sys.c: In function '__do_sys_osf_mount':
> arch/alpha/kernel/osf_sys.c:437:14: error: 'path' redeclared as different kind of symbol

Quite.  Matter of fact, there's another problem (path_mount()
that needs to be moved from fs/internal.h for that) and IMO this
is simply not worth bothering with.  I don't see any benefits
in the last commit in there; the next-to-last one has some
point, and it's not hard to fix, but since it clearly got
no testing whatsoever...  Christoph, if you want it back,
resend it later, *after* having tested it.  qemu-system-alpha
works well enough to boot the last released debian/alpha. 

For now I'm dropping the last two commits from that branch.
