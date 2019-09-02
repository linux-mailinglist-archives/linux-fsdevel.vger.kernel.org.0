Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853C2A559B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfIBML3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:11:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbfIBML3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P97jGVi72ADJPMlsAbOI9xpj/R2E6oJp4xFdCCHH4ug=; b=HAQiigwpWOxLS+UoiZ2WHf6q0
        S56oFtu9YVKeKXckPUiBlWLDFAes9wE9pu1CgPK0FJY+88ZwgrJ43iUCdqyP7tEpOonbTAiMirfrW
        lATxQALKa65CZSAnGgWggWc3sVIBdV6/70wbpZU08YHMKK1qxyF/UpByRzziLFT5l3wNq7+uLv278
        2ZHJ+YWrsTM+jrATggPtsOwkH6hoQXtZ5jpaFtyYutIj9jgXB7HudGEDvdu2W6te2/cqhwOSWbf6d
        Rq+eDb0K4uyqd/nmDPjUXaG2RsDIkXrJG4XJmjOoHStEOTR/UD/JaFlNRg/fFerCQJ8bHFA9TA/Bj
        8eRGXe37Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lB8-0006vI-FN; Mon, 02 Sep 2019 12:11:26 +0000
Date:   Mon, 2 Sep 2019 05:11:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 09/21] erofs: update erofs symlink stuffs
Message-ID: <20190902121126.GH15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-10-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-10-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, this looks much better.

>  fs/erofs/inode.c    | 35 ++++++++++-------------------------
>  fs/erofs/internal.h | 10 ----------
>  fs/erofs/super.c    |  5 ++---
>  3 files changed, 12 insertions(+), 38 deletions(-)

And that diffstat ain't bad either.
