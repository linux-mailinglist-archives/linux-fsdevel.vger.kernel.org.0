Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1E1867F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgCPJf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:35:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730025AbgCPJf6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:35:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F37D59CC68CEA65AC63
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 17:35:54 +0800 (CST)
Received: from [10.173.111.60] (10.173.111.60) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 16 Mar
 2020 17:35:49 +0800
Subject: Re: [RFC][QUESTION] fuse: how to enlarge the max pages per request
To:     Miklos Szeredi <miklos@szeredi.hu>
References: <6149dfe9-1389-ada6-05db-eb71b989dcb2@huawei.com>
 <CAJfpeguDOYvNRuFg3UNVEnrfbvf-VAhO_bJ5Gbjei9X0gwvJaw@mail.gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <eec7e2d5-9439-7c86-6adf-979b40bb679c@huawei.com>
Date:   Mon, 16 Mar 2020 17:35:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJfpeguDOYvNRuFg3UNVEnrfbvf-VAhO_bJ5Gbjei9X0gwvJaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.111.60]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/3/16 17:24, Miklos Szeredi wrote:
> On Tue, Mar 10, 2020 at 11:03 AM piaojun <piaojun@huawei.com> wrote:
>>
>> Hi Miklos,
>>
>> From my test, a fuse write req can only contain 128KB which seems
>> limited by FUSE_DEFAULT_MAX_PAGES_PER_REQ in kernel. I wonder if I
>> could enlarge this macro to get more bandwidth, or some other adaption
>> should be done?
>>
>> Up to now, many userspace filesystem is designed for big data which
>> needs big bandwidth, such as 2MB or more. So could we add a feature to
>> let the user config the max pages per request? Looking forward for your
> 
> Currently maximum 1MB per write request is possible by setting
> FUSE_MAX_PAGES flag and max_pages=256 in  INIT reply.

Thanks for your reply. I got the point.

Jun
