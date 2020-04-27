Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B81B9773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0G2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 02:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgD0G2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:28:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBFC061A0F;
        Sun, 26 Apr 2020 23:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJpMkjG5DX5/M9LM8IYv/octmqJf4nqFAaGXSYoBAyA=; b=FAiKdO7KxOvy52OFUxVf9h5LdX
        02z9fddnhmmnCI1wuBUQNZChoTN44UpCMRw3U3uX6KdOewnCEaf0rwlwXad7Eq51cZT82r2VsV3hH
        JyYk5zxK0U0lxr+9kYTci5PyBNhk1ca4LHPoiQIBa4v7eaXCV8EHzIDlE8iZhmlJxat7R/nw5c6Bh
        VXs7nDmnQq3WSK1ut2L7k7xHkHNFvdL5HoSwDGoYyflTSUK2iwO+/E5/ItkvvtIIyB077rYKvxTVP
        breU9IKaBMcAfgRzLQKZib3d75Uarh4ixv51EGcZeHpd9fUSD6J1ftW0jRQbe3BW8lJlq1To8jqBw
        gpsP8V4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSxFS-0004Rw-7w; Mon, 27 Apr 2020 06:28:10 +0000
Date:   Sun, 26 Apr 2020 23:28:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200427062810.GA12930@infradead.org>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200424101153.GC456@infradead.org>
 <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
 <CAOQ4uxgiome-BnHDvDC=vHfidf4Ru3jqzOki0Z_YUkinEeYCRQ@mail.gmail.com>
 <20200425094350.GA11881@infradead.org>
 <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg2KOVBxqF400KW3VaQEaX4JGqfb_vCW=esTMkJqZWwvA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 01:49:43PM +0300, Amir Goldstein wrote:
> I would use as generic helper name generic_fiemap_checks()
> akin to generic_write_checks() and generic_remap_file_range_prep() =>
> generic_remap_checks().

None of the other fiemap helpers use the redundant generic_ prefix.
