Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9412A0DAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgJ3SnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3SnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:43:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB62C0613CF;
        Fri, 30 Oct 2020 11:43:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYZMV-00CDS5-Go; Fri, 30 Oct 2020 18:42:55 +0000
Date:   Fri, 30 Oct 2020 18:42:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
Message-ID: <20201030184255.GP3576660@ZenIV.linux.org.uk>
References: <20201030152407.43598-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030152407.43598-1-cai@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:24:07AM -0400, Qian Cai wrote:
> We will need to call putname() before do_renameat2() returning -EINVAL
> to avoid memory leaks.
> 
> Fixes: 3c5499fa56f5 ("fs: make do_renameat2() take struct filename")
> Signed-off-by: Qian Cai <cai@redhat.com>

May I ask where has the original commit been posted for review?  And why
the bleeding hell does io_uring touch rename-related codepaths in the
first place?
