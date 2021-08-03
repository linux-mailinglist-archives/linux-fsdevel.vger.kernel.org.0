Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841CF3DF1B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhHCPmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhHCPmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:42:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB09C061757;
        Tue,  3 Aug 2021 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=II/VenbTUw24iLWpdlipuMpQAdm4Yh3pDdJ39f5fTfs=; b=t+L/oQEKWQG7u56lNMjVf66Qoh
        PuEpLd7XoUvqyNSUWG4kg+YaislStlAu3rT0agQT3mKDaPTJIJ0LzNHGsJTf3uBOntKhQweGPOZ1j
        d+rhzTgI5pdfiKJ6xMRSg2DdLRsLDjtOjZCiU0bT5w7jtH1Ak6N6/BG3DLMXUMQJJwyYUc/gWInMy
        kfgPtEnWUGINhJy8dwlyDK4GN+wVnV62oiRP07RGl/KXvTt0REaGYEP4dCYSI3/EBZtCkDJv3Qb5T
        pxlB25SXe7TmG/7p57cp0sJgdiy2MAjiid0hfyxjairpZE8X3DE7+DNo/Iopzxu7ACN0hmkAlNS5H
        PLzw6iFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAwYF-004ppV-K7; Tue, 03 Aug 2021 15:42:03 +0000
Date:   Tue, 3 Aug 2021 16:41:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH] Restyle comments to better align with kernel-doc
Message-ID: <YQljw+wozb9vIGnU@casper.infradead.org>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
 <20210803133833.GL25548@kadam>
 <20210803152619.hva737erzqnksfxu@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803152619.hva737erzqnksfxu@kari-VirtualBox>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 06:26:19PM +0300, Kari Argillander wrote:
> I would not even try to make these kind of changes if ntfs3 patch series
> was already merged to kernel. But probably I will try to bring kernel doc
> style funtion comments in future when ntfs3 gets merged.

There's very little value to adding kernel-doc comments to individual
filesystems.  Filesystems don't usually provide services to the rest of
the kernel.  It's a much better use of your time to write kernel-doc
comments for functions and structures in the VFS and MM that are used
by many filesystems and device drivers.
