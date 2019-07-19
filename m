Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB716E292
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfGSIcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 04:32:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43364 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfGSIcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:32:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6J8WALd020368;
        Fri, 19 Jul 2019 03:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563525130;
        bh=IVqQ1ovk/uB5I3+HYY88jIzu+tAVMCodVGet/Jwe4Qw=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=TA7Ls/ZEkH2MbrRXeYpK/I5F6jqRsO9SrdHYTKsvbb8YV35on1KfFQeB8SYPnL6re
         6NnLvVEyQ/sNskzSNhGBpXoW24Vu3AOGMPKwtXzVy9rmIuySPxWTc7hbTUkKRxRZh0
         RK1pIyAePXpb4zqaFDDjRbt9YttbGuTaI9GGpXn4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6J8WAor097464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jul 2019 03:32:10 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 19
 Jul 2019 03:32:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 19 Jul 2019 03:32:10 -0500
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6J8W6xV081189;
        Fri, 19 Jul 2019 03:32:07 -0500
Subject: Re: mmotm 2019-07-17-16-05 uploaded (MTD_HYPERBUS, HBMC_AM654)
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190717230610.zvRfipNL4%akpm@linux-foundation.org>
 <4b510069-5f5d-d079-1a98-de190321a97a@infradead.org>
CC:     <akpm@linux-foundation.org>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        <linux-mtd@lists.infradead.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <c3b93f7a-5861-475f-faeb-3ec7e8e9b728@ti.com>
Date:   Fri, 19 Jul 2019 14:02:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4b510069-5f5d-d079-1a98-de190321a97a@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 18/07/19 9:15 PM, Randy Dunlap wrote:
> On 7/17/19 4:06 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2019-07-17-16-05 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
> 
> on x86_64, when CONFIG_OF is not set/enabled:
> 
> WARNING: unmet direct dependencies detected for MUX_MMIO
>   Depends on [n]: MULTIPLEXER [=y] && (OF [=n] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - HBMC_AM654 [=y] && MTD [=y] && MTD_HYPERBUS [=y]
> 
> due to
> config HBMC_AM654
> 	tristate "HyperBus controller driver for AM65x SoC"
> 	select MULTIPLEXER
> 	select MUX_MMIO
> 
> Those unprotected selects are lacking something.
> 

Sorry for that! I have posted a fix here. Let me know if that works. Thanks!

https://patchwork.ozlabs.org/patch/1133946/

-- 
Regards
Vignesh
