Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BEE406599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhIJCQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 22:16:16 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:44565 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhIJCQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:16:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Unqfv0i_1631240102;
Received: from B-W5MSML85-1937.local(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Unqfv0i_1631240102)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 10:15:03 +0800
From:   "taoyi.ty" <escape@linux.alibaba.com>
Subject: Re: [RFC PATCH 2/2] support cgroup pool in v1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <03e2b37678c9b2aef4f5dee303b3fb87a565d56b.1631102579.git.escape@linux.alibaba.com>
 <YTiuLES5qd086qRu@kroah.com>
Message-ID: <a91912e2-606a-0868-7a0c-38dec5012b02@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 10:15:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTiuLES5qd086qRu@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2021/9/8 下午8:35, Greg KH wrote:
> I thought cgroup v1 was "obsolete" and not getting new features added to
> it.  What is wrong with just using cgroups 2 instead if you have a
> problem with the v1 interface?
>
>    

There are two reasons for developing based on cgroup v1:


1. In the Internet scenario, a large number of services

are still using cgroup v1, cgroup v2 has not yet been

popularized.


2. The mechanism of cgroup pool refers to cgroup1_rename,

but for some reasons, a similar rename mechanism is not

implemented on cgroup v2, and I don't know the thoughts

behind this.

