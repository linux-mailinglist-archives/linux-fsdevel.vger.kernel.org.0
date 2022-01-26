Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA65C49C3C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 07:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiAZGpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 01:45:06 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52823 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232505AbiAZGpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:45:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2uAmSs_1643179502;
Received: from 30.225.24.77(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2uAmSs_1643179502)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 14:45:03 +0800
Message-ID: <34053029-8f6a-e8a6-5f72-3d62599e3619@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 14:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 11/20] erofs: add cookie context helper functions
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220118131216.85338-12-jefflexu@linux.alibaba.com>
 <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2812799.1643124872@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2812799.1643124872@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/25/22 11:34 PM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> +static int erofs_fscahce_init_ctx(struct erofs_fscache_context *ctx,
> 
> fscahce => fscache?
> 

Right. Thanks.

-- 
Thanks,
Jeffle
