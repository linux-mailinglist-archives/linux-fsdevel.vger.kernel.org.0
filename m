Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0C49AA9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 05:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1323506AbiAYDmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 22:42:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47296 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S3415983AbiAYBxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:53:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2o6oRt_1643075619;
Received: from 30.225.24.84(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2o6oRt_1643075619)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 09:53:40 +0800
Message-ID: <bbb32b23-b32a-cc6f-c85b-7ccf2aa8b8bc@linux.alibaba.com>
Date:   Tue, 25 Jan 2022 09:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/20] fscache,erofs: fscache-based demand-read
 semantics
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
 <2351231.1643044980@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <2351231.1643044980@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/25/22 1:23 AM, David Howells wrote:
> Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> You could start a quick test by
>> https://github.com/lostjeffle/demand-read-cachefilesd

There is a quick test script in this repo in addition to the daemon
(temporarily named with cachefilesd2).

> 
> Can you pull this up to v5.17-rc1 or my netfs-lib branch?
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib

While this kernel patch set is basically rebased to v5.17-rc1, rather
than netfs-lib branch. I can see there's quite many refactoring for
netfs lib in netfs-lib branch.


> 
> I'll do my best to have a look at it tomorrow.
> 

Thanks a lot.

-- 
Thanks,
Jeffle
