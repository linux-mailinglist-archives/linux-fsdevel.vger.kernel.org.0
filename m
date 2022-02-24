Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892594C33F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiBXRrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 12:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiBXRq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:46:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F65279469;
        Thu, 24 Feb 2022 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1WdzptLcvU69z6TcnQKEUU0O4QbFw1jllXY4KPf6BEY=; b=dsNH3HsKu65edNdpcJnnGtONR4
        lbI25QnHh5IFR24Oi/YkAyUTAyo+NYW6ZFqq+Ut7EoWt+8LfGybYJzejWRQ+8Ga6W4vElKKzZEUHd
        v8sfRw0pDEzjbsJpuJHjUoYR9nDauVo6NaUdVHx9EZoH4MdPwpACJVnYRJrZJq0Rj0EZarunLCxSm
        EwfF0lBbflXucRuiGts8wx7oQqV/BkxteCEfTA6aXrRXt4QvzehOxxY6/dVFFkrp/z8G3vZ1DThGX
        0z8gLRoIGixBJnzr/NuO80D6bcEFVl8P1rO2iEg6DHs7U8Y2F8qXO2dewOPvPKZ2wj3ovgKsGcsrz
        cShUO97A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNIC2-00CgT2-ME; Thu, 24 Feb 2022 17:46:19 +0000
Message-ID: <97e0c66c-82e3-9016-f71a-cd78a83f7a77@infradead.org>
Date:   Thu, 24 Feb 2022 09:46:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-23-21-20 uploaded (iwlwifi + rfkill)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220224052137.BFB10C340E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/23/22 21:21, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-02-23-21-20 has been uploaded to
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

# CONFIG_RFKILL is not set

In file included from ../drivers/net/wireless/intel/iwlwifi/mvm/fw.c:19:0:
../drivers/net/wireless/intel/iwlwifi/mvm/mvm.h: In function ‘iwl_mvm_mei_set_sw_rfkill_state’:
../drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:2215:24: error: implicit declaration of function ‘rfkill_soft_blocked’; did you mean ‘rfkill_blocked’? [-Werror=implicit-function-declaration]
   mvm->hw_registered ? rfkill_soft_blocked(mvm->hw->wiphy->rfkill) : false;
                        ^~~~~~~~~~~~~~~~~~~
                        rfkill_blocked
In file included from ../drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:22:0:
../drivers/net/wireless/intel/iwlwifi/mvm/mvm.h: In function ‘iwl_mvm_mei_set_sw_rfkill_state’:
../drivers/net/wireless/intel/iwlwifi/mvm/mvm.h:2215:24: error: implicit declaration of function ‘rfkill_soft_blocked’; did you mean ‘rfkill_blocked’? [-Werror=implicit-function-declaration]
   mvm->hw_registered ? rfkill_soft_blocked(mvm->hw->wiphy->rfkill) : false;
                        ^~~~~~~~~~~~~~~~~~~
                        rfkill_blocked

-- 
~Randy
