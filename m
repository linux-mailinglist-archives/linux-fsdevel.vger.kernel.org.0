Return-Path: <linux-fsdevel+bounces-18198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A98B6762
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41446B22336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2479F2;
	Tue, 30 Apr 2024 01:24:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5101FB2;
	Tue, 30 Apr 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440246; cv=none; b=l+y3ittb/d7tP4Crc7LYKm1e8U2A5YRxsZcOSo2s8SgrkvglfRUk/tEBQNMCWa9T5QGduhUyAYQmpM1raQnRsnkfGKsiSUbDRoLBsvf9bs0INLDDfJtN2eO3BgISMwVxFhwoRkZoTz8HdOSBkXJ5zkf29TyQPGv8QDv51DKOXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440246; c=relaxed/simple;
	bh=3OdmIOxGoAg3oqSjkLgmDOCC67m6RWSe7VeSKbm1z1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q6J8Mb9/oG5p3R9Uf7jQ+bVbNZmrNtZ0wlnZooUgkgCnUcYeUhhKcvqNtjOQEQfEgKWwWMTTOWAHsLHpV6wpF2zjnlJP+ryqVRjBZ37TsnNwDN/vkD6fhFJPYFAjFumz96lRk/x6BYp0rRfNM2hyk2bciOOP4SNU8eLrYz7Nm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VT2Sz3jgCz1RDTg;
	Tue, 30 Apr 2024 09:20:51 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B58B18005F;
	Tue, 30 Apr 2024 09:24:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 09:24:00 +0800
Message-ID: <6844a9d8-f1a7-738e-105c-e9c44f5c11f4@huawei.com>
Date: Tue, 30 Apr 2024 09:23:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] proc: Remove unnecessary interrupts.c include
To: Andrew Morton <akpm@linux-foundation.org>
CC: <mcgrof@kernel.org>, <j.granados@samsung.com>, <brauner@kernel.org>,
	<david@redhat.com>, <willy@infradead.org>, <oleg@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240428094847.42521-1-ruanjinjie@huawei.com>
 <20240429093549.f2b9c670f383bed627022f31@linux-foundation.org>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240429093549.f2b9c670f383bed627022f31@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/4/30 0:35, Andrew Morton wrote:
> On Sun, 28 Apr 2024 17:48:47 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> The irqnr.h is included in interrupts.h and the fs.h is included in
>> proc_fs.h, they are unnecessary included in interrupts.c, so remove it.
>>
>> ...
>>
>> --- a/fs/proc/interrupts.c
>> +++ b/fs/proc/interrupts.c
>> @@ -1,8 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include <linux/fs.h>
>>  #include <linux/init.h>
>>  #include <linux/interrupt.h>
>> -#include <linux/irqnr.h>
>>  #include <linux/proc_fs.h>
>>  #include <linux/seq_file.h>
> 
> Within limits, we prefer that .c files directly include the headers
> which they use.  If interrupts.c uses nothing from these headers then
> OK.  If, however, interrupts.c does use things which are defined in
> these headers then the inclusion of those headers is desired.

Thank you, sorry I'm just learning the rules now.

