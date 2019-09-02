Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 859D7A5589
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfIBMGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:06:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfIBMGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vdCHakxL8nOAMypOUirqIzokbahTp5CH5o7r+UG46n0=; b=nQWgq9YQSIqAEMurkTtgflbR/
        SLxNTDrRY8P1IVBXbdsj457aQFCCtN/P0EgNeJawViE0B5li/1mmkgNAfBR6ubB1f0lA5IkzX7wCn
        ghjNbplBZOC77AtJwss5DJYVbsmYv8W2zuFm+fTIM/PILNHhvrZANwX4IcZOPEuAwC0ezoeTiidYl
        NZm/7Jw1NcHUyGu3+Q/CiUkVXYwCE9+LAhkPyUI2PEm3OKSIwt2hApX6FOvJYuPw25rWUJ7ftrHyX
        a5ghQ8zMJ0MPl1HyH17dhidDeMe3LAslHn8WA/mEetBuO2MEpULTk5EYy+UQBcCZYtyuL4Foojk+i
        2Bzfokeyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4l6K-0005TG-8K; Mon, 02 Sep 2019 12:06:28 +0000
Date:   Mon, 2 Sep 2019 05:06:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 03/21] erofs: some macros are much more readable as a
 function
Message-ID: <20190902120628.GC15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-4-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-4-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This looks much better now.
