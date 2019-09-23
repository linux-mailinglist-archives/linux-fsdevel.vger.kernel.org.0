Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86A8BBBE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbfIWS5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 14:57:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfIWS5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wu+Vz9bwwQ8XY+ZG0DU7WreZpAj7L+s+8VYRLKVH1mo=; b=YRtXCfihHwuAXZy0F1ATYoqqt
        wWyRWoqCsyWErW6HQfrFL+k/XiqQR704A88WoAHlPci2b9DzEG4oH1Ig935Y+SPf2R6tiT/iPozRL
        F1BaKlDeG5mECEwnjjxmkrl7aeRt1qSHYD3lLD+SXYajGapg5yTtEg3CXxIwePVYT2EQG6LnguZnv
        Bq8kjO4qmPLMnR6xrb7WHMaN9qdmEkodkcMDqc3q+u9+UMo707HkfFodhqsXxWdQay+WIyVllGafX
        zPdu9VwSGmS5V/jJeqJBKJSZwdVYsp7xhxlQ8TUgFkdopeTPybr9UIbzxaBRGEMzNbU3tebwTmuVR
        dapYaV+Sw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCTWp-0004z8-Na; Mon, 23 Sep 2019 18:57:43 +0000
Date:   Mon, 23 Sep 2019 11:57:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190923185743.GA1855@bombadil.infradead.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826111627.7505-3-vbabka@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:16:27PM +0200, Vlastimil Babka wrote:
> @@ -98,6 +98,10 @@ limited. The actual limit depends on the hardware and the kernel
>  configuration, but it is a good practice to use `kmalloc` for objects
>  smaller than page size.
>  
> +The address of a chunk allocated with `kmalloc` is aligned to at least
> +ARCH_KMALLOC_MINALIGN bytes. For sizes of power of two bytes, the

"For sizes which are a power of two, the"

> +alignment is also guaranteed to be at least to the respective size.

s/to //

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
