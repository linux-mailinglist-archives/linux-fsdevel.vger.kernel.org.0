Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC19B471201
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 06:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhLKFs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 00:48:27 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:39478 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhLKFs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:48:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-DNfxn_1639201487;
Received: from 192.168.31.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-DNfxn_1639201487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Dec 2021 13:44:48 +0800
Message-ID: <a95618c5-723d-bfaa-bf7a-48950be8d31d@linux.alibaba.com>
Date:   Sat, 11 Dec 2021 13:44:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [Linux-cachefs] [RFC 09/19] netfs: refactor netfs_rreq_unlock()
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     chao@kernel.org, tao.peng@linux.alibaba.com,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        linux-cachefs@redhat.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, xiang@kernel.org,
        gerry@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        eguan@linux.alibaba.com
References: <20211210073619.21667-10-jefflexu@linux.alibaba.com>
 <20211210073619.21667-1-jefflexu@linux.alibaba.com>
 <292572.1639150908@warthog.procyon.org.uk>
 <fba8a28b-14c1-bf58-0578-32415c95f55d@linux.alibaba.com>
In-Reply-To: <fba8a28b-14c1-bf58-0578-32415c95f55d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/11/21 1:23 PM, JeffleXu wrote:
> 
> 
> On 12/10/21 11:41 PM, David Howells wrote:
>> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>> In demand-read case, the input folio of netfs API is may not the page
>>
>> "is may not the page"?  I think you're missing a verb (and you have too many
>> auxiliary verbs;-)
>>
> 
> Sorry for my poor English... What I want to express is that
> 
> "In demand-read case, the input folio of netfs API may not be the page
> cache inside the address space of the netfs file."
> 

By the way, can we change the current address_space based netfs API to
folio-based, which shall be more general? That is, the current
implementation of netfs API uses (address_space, page_offset, len) tuple
to describe the destination where the read data shall be store into.
While in the demand-read case, the input folio may not be the page
cache, and thus there's no address_space attached with it.

-- 
Thanks,
Jeffle
