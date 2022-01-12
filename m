Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893448BF80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 09:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351405AbiALIGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 03:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351400AbiALIGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:06:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88571C06173F;
        Wed, 12 Jan 2022 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5SYRKrelbUcT8UDzxAN+Nb5s1/112dY1hzNg3RG1SRc=; b=i7QUF05Al2ZZ8uol13811H1waT
        57T14Zi6fBxmF5qfsR6p6ZXZbzwjS44de2ALjymVVtwbHrTSdIfRnkoItkO82yApcDMPfersxvjSY
        KK4DPNkZhbdoIz9OTeFHh3p3At0fiOI3rRSy8oquFDfm3lKMv7tYpcksZpbNILbX5VITPk5JwaTNF
        lajusbsobFHnVAvc/Q/wwMVazB8RussDWqoZVQaXf8XO6IyFv+hNXXTAPWJznDJScHOdwcbwnAeDG
        NFj9FJ0qFpglPlYX6bZdQaUrVIWV25D8qDu8Do95n9PfuIraXvu4Gi4rzIZXkNp/FYQMfiZXMzp70
        WjFB0MuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7YeU-001T4W-Hv; Wed, 12 Jan 2022 08:06:38 +0000
Date:   Wed, 12 Jan 2022 00:06:38 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Lance Shelton <Lance.Shelton@hammerspace.com>,
        Richard Sharpe <Richard.Sharpe@hammerspace.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <Yd6MDkMJaU0ACMEH@infradead.org>
References: <20220111074309.GA12918@kili>
 <Yd1ETmx/HCigOrzl@infradead.org>
 <56202063c1eba6020b356a393178b9626652198e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56202063c1eba6020b356a393178b9626652198e.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 06:08:27PM +0000, Trond Myklebust wrote:
> So firstly, there already has been a discussion of this on linux-
> fsdevel (and linux-kernel):
> https://lore.kernel.org/lkml/20160429125813.23636.49830.stgit@warthog.procyon.org.uk/
> and the consensus at the time was that these attributes were not needed
> in statx.

And apparently someone now has a different opinion, so we should restart
it.

> 
> The other issue is that this is not a duplicate of stat. It's adding
> support for both _setting_ and reading back these attributes. The
> ability to supporting reading the archive bit / backup time, for
> example, is completely useless unless you can also set those values
> after backing up the file. Right now, there is no support in the VFS
> for setting any attributes that are not part of the standard POSIX set.

Either way this has no business being private in NFS.  We need to
come to an agreement to have a proper interface for CIFS, fat, exfat
and the 2 ntfs drivers as welŀ.  With the first three being the most
important ones.

So big fat nack for stashing something like this into nfs without proper
review and coordination.
