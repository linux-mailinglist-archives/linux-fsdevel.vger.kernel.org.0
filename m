Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DBCA152A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfH2JvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 05:51:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH2JvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pM3wcAf7FIhzSl23I8rKYxtK3wexClX83D/gf9S1f5A=; b=IbneeKsWWuv4rxcM7lu8P5kA3
        doWzWkPrytBw/fszPm6xltgjTmTxL4JXhdnei6neL6afPwn9u60oKqq+j0LjxxyddOwzpI28yfX7z
        YqIOQk84pk3uiqKVHzitq1akCD1IhMzCmu/1Wlk0RbbBXe4jzjkDMDZ6K2domNXpvnEd/9SzBrhEy
        t4wPrN7JIs9cchyRrF8OQhxCd7qpHZcytVM+R4hsegY+/Ffs4w9XIzXznAsrcjlu8qZaKJOhaQfiX
        ZqnrA75QFzXsVcmfAYWUA/wxSpx7mPFqUZZLI6S7P5Yz5v6zJOSHgM4P2kghVVte5ohsYB48nqa5d
        1aXJs9T6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3H5I-0005Pa-Tv; Thu, 29 Aug 2019 09:51:16 +0000
Date:   Thu, 29 Aug 2019 02:51:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, yuchao0@huawei.com,
        miaoxie@huawei.com, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Zefan Li <lizefan@huawei.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829095116.GA20598@infradead.org>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829070149.GA155353@architecture4>
 <20190829082409.GA83154@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829082409.GA83154@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 04:24:09PM +0800, Gao Xiang wrote:
> It seems I misunderstood your idea, sorry about that... EROFS
> properly uses vfs interfaces (e.g. we also considered RCU symlink
> lookup path at the very beginning of our design as Al said [1],
> except for mount interface as Al mentioned [2] (thanks him for
> taking some time on it), it was used for our debugging use),
> and it didn't cause any extra burden to vfs or other subsystems.

It would still have been a lot less effort for everyone without
the idiotic staging detour.
