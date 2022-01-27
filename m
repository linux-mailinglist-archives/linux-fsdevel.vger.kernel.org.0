Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438149DAAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiA0Gbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 01:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiA0Gbs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:31:48 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70BC061714;
        Wed, 26 Jan 2022 22:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=iUqvms9+CgYq6dBbsKbOGY6IPx8/6JD1QpNM1DWf7/4=; b=QGovpg2C/otvkBp+KirpN8cXCL
        RP8olyz70BF4bzO3OiAVCsMmCCZ3G+PZpzPqRhzW0F9aE9RFioQP11iGcuLJ0gYPeX4FbjMRDHWqm
        CJScF2STTrjnRABFfqJbiqfEgWIbl9f1vANukl1gs+E8xKw1LA1/ylZhOBudqs/Vx7+TxrWLcAEBJ
        57kLhw1ziV9ZXzF5jKuWFnMXwhkA3Kb0bCvIb/n78RqzrnNLlcMNhsx83OD1RO/nxleNGqUqySDTM
        XDL14eyJs35a9ZOTBiJGmS8+Iv3c5hZmTVvIwHwN+yQU4+WKW7vfBLT4+hbcJ0+19X/uUHiLWI8/g
        Uuns43GA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyJk-00457S-Qc; Thu, 27 Jan 2022 06:31:37 +0000
Message-ID: <97434c08-b536-bb09-5770-6b752672393b@infradead.org>
Date:   Wed, 26 Jan 2022 22:31:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: mmotm 2022-01-26-21-04 uploaded (drivers/mtd/nand.raw/Kconfig
 warning)
Content-Language: en-US
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/26/22 21:04, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2022-01-26-21-04 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.


on i386:
(from linux-next.patch)


WARNING: unmet direct dependencies detected for OMAP_GPMC
  Depends on [n]: MEMORY [=y] && OF_ADDRESS [=n]
  Selected by [m]:
  - MTD_NAND_OMAP2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] && (ARCH_OMAP2PLUS || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST [=y]) && HAS_IOMEM [=y]



-- 
~Randy
