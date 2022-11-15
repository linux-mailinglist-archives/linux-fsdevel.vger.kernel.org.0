Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1662935B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiKOIhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiKOIhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:37:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCF19B;
        Tue, 15 Nov 2022 00:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U6/3ofeiVaLo9TBWq2pxdKOcfHZdpVbG7f+Luo5asuI=; b=TQiNsjF/Lw8/3IeIFoM/veEM3s
        CbsKhfabPTMyHQIOdBT0HCZk683/kUJsjsffl8L+hQw13JPlXR/Vwi5f2wbzHWzldUNG7eiYTR1Jt
        abrOITc0SvusUK1lJefS9gMXi7JgVIGJ4H8R2EuvdNgvp+2AmLvKzBJTdCniFfTQDqNgo5XXhfF0C
        jUM4YtcNCGil8sYdK8FshSHQXCKOD0xXrUD+PSIJleo0ge5KO62i4xUN0fA4SoG8hoC55kum1CLa5
        lHuYlMFP91B5MthTyMRtXPEQhAM5fcbM4Mgc+nc4tjj26eKn0xZvV6Zi8kLq2njQ4tABY5JSrDce4
        MvZLHmaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourRR-008yYD-OI; Tue, 15 Nov 2022 08:37:13 +0000
Date:   Tue, 15 Nov 2022 00:37:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH 10/14] iomap: pass a private pointer to
 iomap_file_buffered_write
Message-ID: <Y3NPud63Ohd8sK+0@infradead.org>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
 <166801780087.3992140.16981045908489138660.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166801780087.3992140.16981045908489138660.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:16:40AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Allow filesystems to pass a filesystem-private pointer into iomap for
> writes into the pagecache.  This will now be accessible from
> ->iomap_begin implementations, which is key to being able to revalidate
> mappings after taking folio locks.

Looks good (and this is similar to what we already do for other
users of iomap):

Reviewed-by: Christoph Hellwig <hch@lst.de>
