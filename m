Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584DD1D0F22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbgEMKFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732876AbgEMKE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 06:04:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61156C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P+GDGr63i/GryzyacVzElgV97xC2KafWFYRcNg053vk=; b=UJ9815NK5Yy1i4frFJwhd9a+FY
        JR5xp84mw8k8pNE8FfcsDW1OMVf1VkIlTv48oHAa4wiJaYXVI14+sZbdRe1WwUJj+3PPwVjyHK8qp
        dxkzxG2jNmI8c7FDnXUbUId1Q4g1Z25mIoKe9Umrrh7H1b6V5LPqfqWD1Tw4DhuljJ6VCJu1Sti3y
        oHCMjoCZP2XhrzBFNaa8lmN3VRt4C4A9+ZZibXdhAn04QNG0rZpYAP9D8yXm7F//z9gcu3kzP+zoQ
        WwYWRnItDLRIoR1vD71AsyWUWweBSt7yZz3uQeSH8tRl9DTFW6Fxr8NHB7Rrn1TlPgJYJ8xckfg/x
        4LUX21aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoG1-00037G-VU; Wed, 13 May 2020 10:04:57 +0000
Date:   Wed, 13 May 2020 03:04:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/12] statx: don't clear STATX_ATIME on SB_RDONLY
Message-ID: <20200513100457.GE7720@infradead.org>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-8-mszeredi@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:10AM +0200, Miklos Szeredi wrote:
> IS_NOATIME(inode) is defined as __IS_FLG(inode, SB_RDONLY|SB_NOATIME), so
> generic_fillattr() will clear STATX_ATIME from the result_mask if the super
> block is marked read only.
> 
> This was probably not the intention, so fix to only clear STATX_ATIME if
> the fs doesn't support atime at all.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Acked-by: David Howells <dhowells@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
