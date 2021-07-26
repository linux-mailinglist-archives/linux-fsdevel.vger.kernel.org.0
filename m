Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927CC3D5CBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhGZOgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:36:05 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54389 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234892AbhGZOfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:35:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uh4K0r._1627312535;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uh4K0r._1627312535)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Jul 2021 23:15:37 +0800
Date:   Mon, 26 Jul 2021 23:15:35 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <YP7Rlwhd4yBXhANY@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
 <YP7Ph55kV0M8M1gW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP7Ph55kV0M8M1gW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Mon, Jul 26, 2021 at 04:06:47PM +0100, Matthew Wilcox wrote:
> 
> Please make the Subject: 'iomap: Support file tail packing' as there
> are clearly a number of ways to make the inline data support more
> flexible ;-)

Many thank all folks for the time and the review!

If Darrick is happy too, maybe leave him to update :-) 
(...I'm fear of screwing up anything now...)

> 
> Other than that:
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks,
Gao Xiang

