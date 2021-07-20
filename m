Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554E23CF82E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhGTKDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237327AbhGTKAX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:00:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D0A461107;
        Tue, 20 Jul 2021 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777650;
        bh=ge+pwhNCmkx9TULItGaopnOxjBqUdeZK/HlzPHA99TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2J/7mANZoUyiZ1KLkgqaCWp5RpBy40GyvSXvCaVCGlE5HrddS95s8Krug1QqBEHW
         Tyqu2eXhp3sP84wmPHnKz2mr7F9faFmGrctbPshVckJQARiA0/xN6e37xr8SVGZvXT
         ayDzohFtD22pgIaOnZz8tvCuJ/KGuCqtICK9OsX3Z12XgLR65scTJ/HKBdDPcXvFLi
         GLHDF2VNVtg/KWzEF48nYZ91FMOx7YvDTkiNUZjJB8sPhwB8omezujil7xHKGLJ00O
         rsjJtilVeamRLEt0XAA0sf/khTU06DD2PIHxlX41WN9QFih/QaIPjevksH8jeKSCqO
         Bbexu6GYTmbiw==
Date:   Tue, 20 Jul 2021 13:40:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 005/138] mm/debug: Add VM_BUG_ON_FOLIO() and
 VM_WARN_ON_ONCE_FOLIO()
Message-ID: <YPaoKwKl56n/M8t/@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-6-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:51AM +0100, Matthew Wilcox (Oracle) wrote:
> These are the folio equivalents of VM_BUG_ON_PAGE and
> VM_WARN_ON_ONCE_PAGE.  No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mmdebug.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

