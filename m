Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66428A15A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfH2KRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:17:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2KRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O3+6+Xmit/iBXjGaFlyx+KH2IoPd70pydps7Y3tqLMs=; b=OK+VlaS2swad6FpHWAVwBfPof
        YrNFFNkHtPbC62y7S+b0GwvxpacKcOoC1ZR3/ICif/qPte7ahF6AoApG2E3LSWqoTXq8zMhPI8+x3
        CPHvNJ3lzu7jR3MAgU/kO22jYXEGlkFmyRLN23DbcEzt/qaRtwik/Yz573oUMfW+DnJKh9SrxgIbS
        48lWz1jGHUPB4z8C2/rdb0cQhLDtkSfYN8hRL6eR+egZZsFQUSkM3S+VDr5s1/KvCzuh6dQMB5pAo
        ah9QvVGENKFE1lkQoBewtDE7dh82osonCH6oZ0ICcR/5mLvh33YRd/KDA2KdEideIVSKtDKpGX2Eb
        P4OZKxpiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3HUX-0004xZ-Fo; Thu, 29 Aug 2019 10:17:21 +0000
Date:   Thu, 29 Aug 2019 03:17:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 04/24] erofs: add raw address_space operations
Message-ID: <20190829101721.GD20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-5-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-5-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The actual address_space operations seem to largely duplicate
the iomap versions.  Please use those instead.  Also I don't think
any new file system should write up ->bmap these days.
