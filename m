Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E495482E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 07:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiACGcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 01:32:10 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51466 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231848AbiACGcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 01:32:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V0dXccU_1641191526;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V0dXccU_1641191526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Jan 2022 14:32:07 +0800
Message-ID: <d57c4609-a4c3-5e60-8257-a0704aaa30a5@linux.alibaba.com>
Date:   Mon, 3 Jan 2022 14:32:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 13/23] erofs: implement fscache-based data read
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-14-jefflexu@linux.alibaba.com>
In-Reply-To: <20211227125444.21187-14-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/27/21 8:54 PM, Jeffle Xu wrote:
>  
> +static inline void do_copy_page(struct page *from, struct page *to,
> +				size_t offset, size_t len)
> +{
> +	char *vfrom, *vto;
> +
> +	vfrom = kmap_atomic(from);
> +	vto = kmap_atomic(to);
> +	memcpy(vto, vfrom + offset, len);
> +	kunmap_atomic(vto);
> +	kunmap_atomic(vfrom);
> +}
> +

It seems that this private function can be replaced by memcpy_page().
Will be done in the next version.


-- 
Thanks,
Jeffle
