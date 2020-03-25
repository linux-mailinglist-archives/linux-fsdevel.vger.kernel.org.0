Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F50C1932B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 22:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYVeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 17:34:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5CW2LFSFroNe8X3GnaRxYiUYrl2HMG+IcwPOPQea1Ao=; b=Lkr/Qdffvz/lLb8oqO84rvCguH
        1yC/g4K8NWh7BWqLVFMtgOFxWKRB8/ukcVcsZp5Ycb59TzvWdBjd6Te7vzuN3OoVjmsIsW1s8tr+a
        MrwBUT46+cqVPOC6Aylw1LqjCgJTPmdJ/T/jUqmmvMzZjHbqPeeoyHpAJ6KJxFaoJ7EbpayE6+M+Q
        SwoX9eDW06M+ergFueLKUCgLyokrqaDYc4xFTZ63ZgZn2SEGdIoPHOmrSOKunLTtALRRgltSdH4BF
        Rvw/GJe2bgyy8+RF2sQHxePFydd6Jj3pMQDrq5B3Lk4IDCyoDT3siPttWNoeVdGyk9IfwSVNDHa4A
        USlALxBw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHDf8-0006G3-1X; Wed, 25 Mar 2020 21:34:10 +0000
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>
References: <20200325212048.GA72586@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1538231-196e-c99e-db48-a802bbab049d@infradead.org>
Date:   Wed, 25 Mar 2020 14:34:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325212048.GA72586@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/25/20 2:20 PM, Bjorn Helgaas wrote:
> On Wed, Mar 25, 2020 at 05:01:43PM +0000, Lorenzo Pieralisi wrote:
>> On Wed, Mar 25, 2020 at 08:43:32PM +0530, Vidya Sagar wrote:

>>> Also, I wanted to know how can I catch this locally? i.e. How can I
>>> generate the config file attached by Randy locally so that I can get the
>>> source ready without these kind of issues?
> 
> Randy attached the config-r1578 file to his initial report.  I saved
> that attachment, then:
> 
>   $ git checkout next
>   $ make mrproper
>   $ cp ~/Downloads/config-r1578 .config
>   $ make drivers/pci/controller/

Hi Vidya,

All I do is run 20 of these on each linux-next and mmotm release:

$ make clean; make randconfig; make all

and see what happens.

-- 
~Randy

