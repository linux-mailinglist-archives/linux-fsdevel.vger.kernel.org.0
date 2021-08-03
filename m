Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC63DE37D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 02:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhHCAV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 20:21:56 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57288 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232311AbhHCAVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 20:21:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UhorE70_1627950102;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhorE70_1627950102)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 08:21:44 +0800
Date:   Tue, 3 Aug 2021 08:21:42 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: iomap 5.15 branch construction ...
Message-ID: <YQiMFsO5DQouSPs/@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
References: <20210802221114.GG3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802221114.GG3601466@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:11:14PM -0700, Darrick J. Wong wrote:
> Hi everyone!
> 
> iomap has become very popular for this cycle, with seemingly a lot of
> overlapping patches and whatnot.  Does this accurately reflect all the
> stuff that people are trying to send for 5.15?
> 
> 1. So far, I think these v2 patches from Christoph are ready to go:
> 
> 	iomap: simplify iomap_readpage_actor
> 	iomap: simplify iomap_add_to_ioend
> 
> 2. This is the v9 "iomap: Support file tail packing" patch from Gao,
> with a rather heavily edited commit:
> 
> 	iomap: support reading inline data from non-zero pos
> 
> Should I wait for a v10 patch with spelling fixes as requested by
> Andreas?  And if there is a v10 submission, please update the commit
> message.

I've already sent out v10 with these changes:
https://lore.kernel.org/r/20210803001727.50281-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang
