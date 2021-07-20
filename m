Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3453CF81F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhGTKBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237372AbhGTKAh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D117061186;
        Tue, 20 Jul 2021 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777675;
        bh=ZbqPI2nz1jfF7wfeS228C/+/xihGTDZcfi1lFpp7wMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2f8RCGWJnyFuxT4NGfUMI/CRpMolP4wywW0Ki+AxOOQ/UKujeNsOt2p6F1dWZQuZ
         7+/tKrfLGZhUOxWaI48FAvpEwJ5ZrMjMgd+dApPSSu1iaR+GeEvHsmEmYZBoF9De84
         /IHdYe9nJTARZ6Y/0upP/ewxVG4wYc8/jCt+cRZcCZsalHiJnD7kBDAeZGq8EG0Kqo
         x0KOmRLGDRMRdCw2M8ryRylTRSPKcawVYq2WCqJsox/s2/QrrKPGDfqQYxziCNCHry
         5LWIiHHvJQggcgaC0GRR35C6xp6fFHenY0CnVlDvaD9MNRJksE1edjfUgiI3LgIuo8
         kdDCWAct+sWSA==
Date:   Tue, 20 Jul 2021 13:41:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 006/138] mm: Add folio reference count functions
Message-ID: <YPaoRFetNvFPbHfS@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-7-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:34:52AM +0100, Matthew Wilcox (Oracle) wrote:
> These functions mirror their page reference counterparts.  Also add
> the kernel-doc to the mm-api and correct the return type of
> page_ref_add_unless() to bool.  No change to generated code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  Documentation/core-api/mm-api.rst |  1 +
>  include/linux/page_ref.h          | 88 ++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

