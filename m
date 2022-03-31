Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66F4EDDEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiCaPwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbiCaPwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:52:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7E45BE44;
        Thu, 31 Mar 2022 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=EW47Oov3HTfA9FlJ1gMHnPyF8JciNSm/LuKu+cor2cc=; b=VqI+KEmHJ4N7pGmsFNG74XYwow
        Tto7JaFe/yuhtcnlPNe5Oq2Ks3afKgvj09Stjrpj8VTa5a/NC+/jcJCcopbJMWntu2NU9JsnkCGdQ
        JXMCuAlgVGfEL9vBuHJ2kNrYla+GQOS+3xH+x/T2AIx1b8nxAuTK65Ey2wR30dycO0xlMs2TmnACD
        9Sf7bv86ukOTk0mLjsEkif1BzEvJaOPyR9NmflZyV2+A+zO95WHMp/jzCPaTlKArs81wZGwZEdU/4
        yB7h5gXHuENJ/77eGJCmkLvqQm1R6P2xijcFV0nkLVg/2Z0mDPJAUblTN/WOrWgKtQB+MqaOEYuO3
        zEj2/0+w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZx4R-0005HN-4u; Thu, 31 Mar 2022 15:50:47 +0000
Message-ID: <5a0b94c3-406e-463e-d93e-d1dc2a260b47@infradead.org>
Date:   Thu, 31 Mar 2022 08:50:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-30-13-01 uploaded (drivers/platform/x86/amd-pmc.o)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20220330200158.2F031C340EC@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220330200158.2F031C340EC@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/30/22 13:01, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-03-30-13-01 has been uploaded to
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

on x86_64:
when CONFIG_SUSPEND is not set:

drivers/platform/x86/amd-pmc.o: in function `amd_pmc_remove':
amd-pmc.c:(.text+0x11d): undefined reference to `acpi_unregister_lps0_dev'
ld: drivers/platform/x86/amd-pmc.o: in function `amd_pmc_probe':
amd-pmc.c:(.text+0x20be): undefined reference to `acpi_register_lps0_dev'



-- 
~Randy
