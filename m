Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F6C2B2C94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgKNKEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Nov 2020 05:04:12 -0500
Received: from verein.lst.de ([213.95.11.211]:49926 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgKNKEL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:04:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A60E367373; Sat, 14 Nov 2020 11:04:09 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:04:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v4 07/16] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201114100409.GH19102@lst.de>
References: <20201112212641.27837-1-willy@infradead.org> <20201112212641.27837-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212641.27837-8-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:26:32PM +0000, Matthew Wilcox (Oracle) wrote:
> Rewrite shmem_seek_hole_data() and move it to filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
