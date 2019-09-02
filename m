Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12D5A5597
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfIBMKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:10:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbfIBMKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hQ5+tDw53PoDHmTzryexyHxEXA6JRbMh+X19PgCT+YA=; b=DbCxDd2tPkRjQaOGfE0HIeStm
        uA7UinGsL/RJcuORoJiF4ieN6X2pyrEZT1RzWBoM5AMrNEVL1HYghRzWKPEjJJ5OZpEh+tpffR/Qj
        P7qXKDzDt9Ii8C+33dHgJqaAOimx1ybuNY6m4z0zPLU47MkgHAIp3b96ca2SMd+82OL1coem4Kisi
        YXB9obKi725hC//SNX9CFiFRbCyyqk9o8nIvj3Ht8gR863yXyLvsnc4qmm/uIgDi0z9tO11y1SMuW
        vMPij2nmXoMlRtmBXT62EmewgcmHw83gWuZ1ZbFAXkh2HH0++jJ0lnaPOx7mKTVwfIuYB4z6hhlxA
        ld0XLzexw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lA5-0006sq-6c; Mon, 02 Sep 2019 12:10:21 +0000
Date:   Mon, 2 Sep 2019 05:10:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH 07/21] erofs: use erofs_inode naming
Message-ID: <20190902121021.GG15931@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-8-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-8-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  {
> -	struct erofs_vnode *vi = ptr;
> -
> -	inode_init_once(&vi->vfs_inode);
> +	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);

Why doesn't this use EROFS_I?  This looks a little odd.
