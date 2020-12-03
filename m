Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED42CCFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 07:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgLCGsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 01:48:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:49692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgLCGsA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:48:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23B8EAC55;
        Thu,  3 Dec 2020 06:47:19 +0000 (UTC)
Subject: Re: [PATCH V2 2/2] block: rename the local variable for holding
 return value of bio_iov_iter_nvecs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201203022940.616610-1-ming.lei@redhat.com>
 <20201203022940.616610-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <09ae3a88-9522-e1fb-6ad3-0c9cd21b37b7@suse.de>
Date:   Thu, 3 Dec 2020 07:47:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203022940.616610-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/3/20 3:29 AM, Ming Lei wrote:
> Now the local variable for holding return value of bio_iov_iter_nvecs is
> 'nr_pages', which is a bit misleading, and the actual meaning is number
> of bio vectors, and it is also used for this way.
> 
> So rename the local variable, and no function change.
> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   fs/block_dev.c       | 30 +++++++++++++++---------------
>   fs/iomap/direct-io.c | 14 +++++++-------
>   2 files changed, 22 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
