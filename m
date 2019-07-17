Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299336B5BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 07:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfGQFCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 01:02:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQFCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rzj35sDzzvONUCEHjA7/WQXWVefZRVnqFZXIu8ez+i4=; b=qzK8v1a2FswW5+4/S9Fp83AWC
        ecSryhPxkDeEfayGc0hJBLfcjVhdPd9EUADw0O9TiZebc9G8A9HZDF0nlKLUBVi6A8ZVhYQ6z0049
        lCW2ZKWGNtuAnPgAk1Q6cnV/1eX18yCF3VgANRegEo+LWk6tPdFWrdVFNSTwPFpUJQFv0rw5Et03V
        7nWe2f90XlfAcb9gIk6mWfDcL6K5fcAo5YhVdsEsZ+Tc/Mm75+bBo/NzvKkdCVOUqm2cgOZ1NmJdB
        j3kB+EP6BLRsuHhYGzdG1p1ZUa7DX/5uivm7fZtz+mdOZ+jf1ufnP2ZLLoaqIUzmZzNF3N+7oMzoa
        zcG7XSPtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnc5S-0003OQ-Tr; Wed, 17 Jul 2019 05:02:42 +0000
Date:   Tue, 16 Jul 2019 22:02:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     hch@infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agruenba@redhat.com
Subject: Re: [PATCH 5/9] iomap: move the direct IO code into a separate file
Message-ID: <20190717050242.GE7113@infradead.org>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321359210.148361.15859054191407967804.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156321359210.148361.15859054191407967804.stgit@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -0,0 +1,562 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2010 Red Hat, Inc.
> + * Copyright (c) 2016-2018 Christoph Hellwig.
> + */

While Dave did some significant improvements here they are much newer
than 2010, but we can probably just fix this up later.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
