Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0ED76B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 14:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfJOMmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 08:42:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfJOMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K8My3sl/gg2JmTvVxZoaNJwh8oIqZH5oOgN3ys0cXS4=; b=bhvh6DZxNpf0Nd8suS3/lOV+C
        ulOYht8EVPIoDG3pluiw186pLIKGnnu9BW1/Io0jaonzd7FvhTGpd6K6NX5UhoWr36b7CIwFykMSs
        PL9/NnzznAFK+SUOupvtss7BvVHDBPmsGRPhcou7RsykrdhCqTWda+3N9jFQhlcHEsy5DOWgKRqeJ
        xZ7ufOoKtTDqtH1uoK4/E31dQKerlfNSNoUsfDxD9vlNi5tFSAgTeV/FthmI0nXqacfqC1Lz70SRb
        1Z09bx8ehD/HA0HIAXtFPVCCmWRUJ6u43i0gbz/2n0eUBja1aACF6KgiYuhe0U+1RfxQeCeTPXhOS
        XA3scbLAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKM9C-0007lQ-SE; Tue, 15 Oct 2019 12:41:54 +0000
Date:   Tue, 15 Oct 2019 05:41:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namespace: add __user to open_tree and move_mount
 syscalls
Message-ID: <20191015124154.GA23798@infradead.org>
References: <20191015103502.27691-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015103502.27691-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:35:02AM +0100, Ben Dooks wrote:
> -SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
> +SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)

Please make sure to wrap lines after 80 characters.

Otherwise this looks good.
