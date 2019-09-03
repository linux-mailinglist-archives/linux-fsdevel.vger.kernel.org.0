Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EBA6767
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfICL23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:28:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbfICL23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MSy6rk16glMIP3anAIh6EF2OBFZRVsR82f8zdfixoCk=; b=F2PHKlpmmB45KdYasG9TxsYMQ
        9yr6/fHFJq5d7D+Qe9Q4dYVF8pspl1L6nnYj+VtUSOE7Xd04SP2IpxW4c42LXnVNm+tKjXXIf/qqy
        8LNqBij7KQPgP7/yB09hkLV3RaTNUfPDSHx183dJhEnKBZtgSWSYIb7fnLVoHTcI7ltanLvHuDa4I
        nC0jiPZgA3BAQN3Htfuq6ZnByAl7rn01h1xSl47UslupMykd0jLHd4Tl/9Lm+pHFLaDJK2lnRr01o
        gST9hERkEqAUUlZWz6+FjVC1mCfXYnUJ1Tv/JGHHBLCN46bq36gUf7UHPnmwtTBLufS9HiOwe3sRH
        +nSXDcBqg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i56yz-0001Pp-3z; Tue, 03 Sep 2019 11:28:21 +0000
Date:   Tue, 3 Sep 2019 04:28:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: remove always false comparison in
 copy_fid_to_user
Message-ID: <20190903112818.GC29434@bombadil.infradead.org>
References: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567475654-6133-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:54:14AM +0800, zhengbin wrote:
> Fixes gcc warning:
> 
> fs/notify/fanotify/fanotify_user.c:252:19: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

When fixing bugs like this, please do a git log -p and cc the person
responsible for introducing the code you're fixing.  Also add a Fixes:
line.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
