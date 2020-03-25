Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7030B192D72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgCYPwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 11:52:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49040 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCYPwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=G5IqHi85lKRyOGN1ba+XW+BgTmyu4gcHkmkrDclUbYk=; b=qXr6yoXABFiiDc+aEhIek/J1gD
        HjMSEHyvb8dbqZYv+Xr5CKG0JHdRg7FfX+TOyopbQ8wcU1TCpwyM9xKq+r0nceUtyAsqUVKikL2a/
        1tl1Q4i1H+NIC8CilxkP1XYSrXt+gwIMe8ocWGDv0Xl6o7xNULNmN6m09Wi/jN5DzsxsRGFCqBHxa
        imX5TqnFM68XU5lFMbCmkO8OJ5wIWaAw8obVXClXqUkQg3GVC1eMWtpCxMRauZg/lNo9Y6VDtCRy8
        gPqQhIFSiausVxoxpq+/TqiS6Lts56XDqT2fM7rOwNNcxsa0e7Q95Vd6w4GayuDqMTmYmf7oSmc4N
        EExKXaaQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8K9-0006qW-J4; Wed, 25 Mar 2020 15:52:09 +0000
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
To:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, lorenzo.pieralisi@arm.com
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>
References: <20200324161851.GA2300@google.com>
 <eb101f02-c893-e16e-0f3f-151aac223205@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20f349f0-872a-08fa-1a4e-53712b31e547@infradead.org>
Date:   Wed, 25 Mar 2020 08:52:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eb101f02-c893-e16e-0f3f-151aac223205@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/20 8:13 AM, Vidya Sagar wrote:
> 
> 
> On 3/24/2020 9:48 PM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
>>> On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
>>>> The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
>>>>
>>>>     http://www.ozlabs.org/~akpm/mmotm/
>>>>
>>>> mmotm-readme.txt says
>>>>
>>>> README for mm-of-the-moment:
>>>>
>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>
>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>> more than once a week.
>>>>
>>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>>
>>> on x86_64:
>>>
>>> ../drivers/pci/controller/dwc/pcie-tegra194.c: In function ‘tegra_pcie_dw_parse_dt’:
>>> ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_phy_get’? [-Werror=implicit-function-declaration]
>>>    pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
>>>                          ^~~~~~~~~~~~~~
>>>                          devm_phy_get
>>
>> Thanks a lot for the report!
>>
>> This was found on mmotm, but I updated my -next branch with Lorenzo's
>> latest pci/endpoint branch (current head 775d9e68f470) and reproduced
>> this build failure with the .config you attached.
>>
>> I dropped that branch from my -next branch for now and pushed it.
> I found that one header file inclusion is missing.
> The following patch fixes it.
> Also, I wanted to know how can I catch this locally? i.e. How can I generate the config file attached by Randy locally so that I can get the source ready without these kind of issues?
> 
> Bjorn/Lorenzo, would you be able to apply below change in your trees or do I need to send a patch for this?
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 97d3f3db1020..eeeca18892c6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -11,6 +11,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>

Yes, that works/fixes the problem.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

