Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE10711A0A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 02:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLKBmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 20:42:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfLKBmU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:42:20 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 77713DE273F4AEDB334D;
        Wed, 11 Dec 2019 09:42:18 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 09:42:10 +0800
Subject: Re: mmotm 2019-12-06-19-46 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20191207034723.OPvz2A9wZ%akpm@linux-foundation.org>
 <c0691301-fa72-b9fe-5cb8-815275f84555@hisilicon.com>
 <20191210173507.5f4b46bde9586456c2132560@linux-foundation.org>
CC:     <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        jinyuqi <jinyuqi@huawei.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <f4596325-a5cd-935e-38a3-61ca36aae9ae@hisilicon.com>
Date:   Wed, 11 Dec 2019 09:42:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20191210173507.5f4b46bde9586456c2132560@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

On 2019/12/11 9:35, Andrew Morton wrote:
> On Mon, 9 Dec 2019 14:31:55 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> Hi Andrew,
>>
>> About this patch,
>> https://lore.kernel.org/lkml/1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com/
>>
>> It is not in linux-next or your trees now, has it been dropped?
> 
> Yes, I dropped it with a "to be updated" note.  Michal is asking for
> significant changelog updates (at least).

Ok, Shall I rebase on 5.5-rc1 and send patch v4?

Thanks,
Shaokun

> 
> 
> .
> 

