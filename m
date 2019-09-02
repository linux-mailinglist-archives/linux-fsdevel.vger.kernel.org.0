Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 360C0A55CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfIBMVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:21:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfIBMVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DcDTJdsbKkcGL74GhQUxYXcV5qsdaOSH3uA0oSIUmcs=; b=liPSsaE7otBSZyKOaR2DnUNit
        H/FOmcdMQ6YQOysknSLsxrmkgHVivjk/2rsq+JYFOXdfRSueXibB/asYYl0nhn0IYX9Ql/FF5mGwf
        3gxSQXiBXWq3I7bKvh5cwzUJaya0vJZjVfB8PNb41SN7h48MWzq6Y32rFxEaU5Siwj7jF0bfy4H5Z
        q1p1RAKXqjUqBvE2uBcojIeH6EEz2szUmS1SzXRr/IHdNcZqtzBEAb8EnFSbVbwm2wm2Fko33F1di
        6gCP6HBjQNGSqwcuBIMj8jjbldicfyxYx1Fkh4lMWN44xkDvpnydbkhRoGcJKFv/OEuXg8TdzgbhE
        Ghu8Jwzfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lKT-00024c-V6; Mon, 02 Sep 2019 12:21:05 +0000
Date:   Mon, 2 Sep 2019 05:21:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 14/21] erofs: kill prio and nofail of
 erofs_get_meta_page()
Message-ID: <20190902122105.GM15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-15-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-15-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

much better.  I'm still hoping REQ_PRIO in this current form will go
entirely away soon as well.
