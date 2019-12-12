Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7611C9CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfLLJrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:47:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLJrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Fk23sNiF7D4wp1VER52CHJRGsu9XrrG8FvOVa2HQBk=; b=JcgNA+7CwnNjrDWjk4ZNnOZHK
        8/hzceQH8y62St+qwMaA52vj057cpcl6wtM9oTUMAYfBTgVfz3DLICzy7vNC6pGrFgxCMZEz+dJus
        hv+Ln6kZGzj4e4pcfxRjTzT/IBxwk8uSAqOtyXSYOfFRRByFHtI8Cn5buKqXOaDXCwPKs8FIwkYeK
        XHU5cHJz3dRHuXL61fhHExaEVCINFoWAkzL8DLPMW2hlP2XcImePIs+n0NPO6Wma15PQB1kgf0fj0
        Qu5N3zEeajjRd/Du4dwweQ1sCHcXbbQcY0YJ7ej2OT40iotc+3++0XGcRphPeTiGaIr0WxHb/zVyH
        YloNke+qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifL3r-0004QJ-28; Thu, 12 Dec 2019 09:47:07 +0000
Date:   Thu, 12 Dec 2019 01:47:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        dsterba@suse.cz, jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/8] iomap: add a filesystem hook for direct I/O bio
 submission
Message-ID: <20191212094707.GB15977@infradead.org>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212003043.31093-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:30:37PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while submitting for
> I/O. This could be post-write operations such as data CRC or data
> replication for fs-handled RAID.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
