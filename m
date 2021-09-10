Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11B406589
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 04:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhIJCNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 22:13:08 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48205 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhIJCNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:13:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UnqtAnz_1631239913;
Received: from B-W5MSML85-1937.local(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0UnqtAnz_1631239913)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Sep 2021 10:11:54 +0800
From:   "taoyi.ty" <escape@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
References: <cover.1631102579.git.escape@linux.alibaba.com>
 <YTiugxO0cDge47x6@kroah.com>
Message-ID: <a0c67d71-8045-d8b6-40c2-39f2603ec7c1@linux.alibaba.com>
Date:   Fri, 10 Sep 2021 10:11:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTiugxO0cDge47x6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/9/8 下午8:37, Greg KH wrote:

> Perhaps you shouldn't be creating that many containers all at once?
> What normal workload requires this?

Thank you for your reply.


The scenario is the function computing of the public

cloud. Each instance of function computing will be

allocated about 0.1 core cpu and 100M memory. On

a high-end server, for example, 104 cores and 384G,

it is normal to create hundreds of containers at the

same time if burst of requests comes.

thanks,

Yi Tao

