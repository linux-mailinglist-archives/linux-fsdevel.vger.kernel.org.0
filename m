Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD7FE33A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfKOQuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:50:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56796 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKOQuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1jSbOlZpuPlHQvL9lJIAHgk9YFXh0y9OVEul338xhOk=; b=V/9cWllrxX/DDFWPtluUKg5k6
        orveUfASEO59asLwCnhdXlKsGm0uhUy4W50H5Kr92EQxDnV+u8iBqcrM/+DwPV+sHL49WDlSlF2vy
        nBf2RgJmgAgQVsMLkhCyI1WiEoW4OxtSUMhLLsdtr780vN3ch01HP9FbHNA6sQQoec/jgYYwaoput
        aLp5lkhCCFycCCQoOFCtUF7FoS+6XG49lTUAKHrAXuSeVImKHnXmv5xZz97gvZo8gP/2psJ/r3p0R
        wFWy5s/9T4ge/9nEFE5pG+YEfnZoXA+Afimzy8zjc+boDtLRL0UJ39C5a9ZMUUxmo6hlvTaoJzDsK
        NAZzKgAWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVenQ-0000xy-64; Fri, 15 Nov 2019 16:50:08 +0000
Date:   Fri, 15 Nov 2019 08:50:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 6/7] btrfs: flush dirty pages on compressed I/O for dio
Message-ID: <20191115165008.GD26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-7-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-7-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:16:59AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Port of "41bd9ca459a0 Btrfs: just do dirty page flush for the
> inode with compression before direct IO"

Doesn't this belong into the main patch as well?
