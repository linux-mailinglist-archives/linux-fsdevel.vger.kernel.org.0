Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90647480921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhL1Mee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 07:34:34 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36465 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbhL1Med (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:34:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V06peAr_1640694869;
Received: from 30.225.24.30(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V06peAr_1640694869)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 20:34:30 +0800
Message-ID: <de5dfac5-9c33-a4e2-e5f1-39547a409fd0@linux.alibaba.com>
Date:   Tue, 28 Dec 2021 20:34:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v1 01/23] cachefiles: add cachefiles_demand devnode
Content-Language: en-US
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-2-jefflexu@linux.alibaba.com>
 <d066131d-1bcb-e64d-a10b-b3dbb4506b96@linux.alibaba.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <d066131d-1bcb-e64d-a10b-b3dbb4506b96@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/28/21 10:47 AM, Joseph Qi wrote:

> 
> Better to prepare the on-demand read() and poll() first, and then add
> the on-demand cachefiles dev.
> 

Regards. Thanks.

-- 
Thanks,
Jeffle
