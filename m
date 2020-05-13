Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A221A1D0F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbgEMKFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbgEMKFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:05:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5DBC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YWkgl9jq1gV5k+2ojGAvcbKkK8
        QNMK60jg4IrvvP1hNkkMUA8brmqVrMuda1owcE4VTPcZdlQPOT8tBhTBV7bNchZgkpJjtam2y8A5o
        msuRKKivmISpUWgAQhs/w0Q/AVQ/t9I32A8IGzf4AkGa2v6XxoZ0oe2cmPDI/c3N6Bv5gi9euN11/
        YhT9Pw/D4IsDmkFZ9X2bsx0umhaJuMkwdymOAmdBMXz6YAXCSZeGKwVWL/B0UrZ11JtrW77hs+n0R
        g7QxPOiv+P0WEULf+7QlkcpDp40hGKjPkTVdIjJ08qmtbk9AAu+b490X4c3kqmSAnFVKcDSDAhJqi
        Xbc7Y8ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoGl-0005ab-7Y; Wed, 13 May 2020 10:05:43 +0000
Date:   Wed, 13 May 2020 03:05:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Lennart Poettering <mzxreary@0pointer.de>,
        "J . Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 09/12] statx: add mount_root
Message-ID: <20200513100543.GG7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-10-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
