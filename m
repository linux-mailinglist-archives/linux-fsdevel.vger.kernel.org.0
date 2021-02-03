Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6250B30DA95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBCNGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 08:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhBCNGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:06:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FBC06178C;
        Wed,  3 Feb 2021 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z+rMXPwnMv2uKjTcYlIREsImSSruLhtFxYFu3h8+JbY=; b=RtF7ds9jgELiLC7ZG6AHd/X98U
        kgtFNnZ6Rfs6g53b4tStqbKMuLV42A0Lz5bW2ifMSy7Vt40KFuYnyCgtZaXhTy0LcBNmnpPWHl3Pm
        xfe5ApNaVeu2f/oMM7IMF5/pkNwCcvniDA++7Oyhzl7oYLBpHZLXA1zvCnHH7b8z5WUnHxrepixhZ
        g9Y0tTJj4kl2SawJFxaFHVXlNvR0nZ09DrroWdI/anfQYT59YN+ZC+WZaWi9p85zHJwaeLsScaXua
        CwOmtval6imFgaK0wGJB9DUk+mai67woV98u5UQHVSyM9kuF7yXy3tjMwLME98ZcGOOMmjVqfYTzd
        Hky0NHeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Hq9-00GtiD-FF; Wed, 03 Feb 2021 13:05:03 +0000
Date:   Wed, 3 Feb 2021 13:05:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Message-ID: <20210203130501.GY308988@casper.infradead.org>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:40:54PM +0100, Miklos Szeredi wrote:
> This series adds the infrastructure and conversion of filesystems to the
> new API.
> 
> Two filesystems are not converted: FUSE and CIFS, as they behave
> differently from local filesystems (use the file pointer, don't perform
> permission checks).  It's likely that these two can be supported with minor
> changes to the API, but this requires more thought.

Why not change the API now?  ie pass the file instead of the dentry?
