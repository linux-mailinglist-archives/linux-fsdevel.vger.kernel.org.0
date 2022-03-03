Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E144CC944
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 23:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiCCWkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 17:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiCCWke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:40:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CD154709;
        Thu,  3 Mar 2022 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=8xS4vyGXrvaXNSOoyEcAyKtTk6VII0GHY+1sEXjj3ZU=; b=Rcw5rZDPcRxvOBX/MWRLhvjObC
        TRLMEin0NOHkkJylcRVj4A3PpWkMgnYl4tavHCyPUssyKSe2djvNzofUU1gk8S2nz0GAFygh+nuwR
        O31wvhqdWnRLnp+l8t2g4ddXWAIjh/2bJObFM2ICcgRTj/6DflgExi/wpPdSTp57TJ90O9sJjNSzC
        T2WIKZ8VDxldgThha0UkE1k2V0Wcb/z2Bbbdb+GaGL36tnnV4De2KeBKtPDJhwnmFgzGoCaiyApow
        5f/YUwfnY/HqoLJmT4240vVtk4VLwwlqr7vftKdCCg4MMJkBZQbcmB2jdPq6fUQ0v36toepHhAuYN
        YWy4Iy5g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPu6m-00C3HB-VQ; Thu, 03 Mar 2022 22:39:41 +0000
Message-ID: <f2b86182-97d1-4341-1b2c-9598a90fdecc@infradead.org>
Date:   Thu, 3 Mar 2022 14:39:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-23-21-20 uploaded (Kconfig warning:
 SND_SOC_WCD938X)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
 <6bd5ec04-dedc-5d1f-23d7-4fd6f4efb95f@infradead.org>
In-Reply-To: <6bd5ec04-dedc-5d1f-23d7-4fd6f4efb95f@infradead.org>
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

Still seeing this build (Kconfig) warning in
mmotm of 20220322:

On 2/24/22 09:13, Randy Dunlap wrote:
> 
> 
> On 2/23/22 21:21, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2022-02-23-21-20 has been uploaded to
>>
>>    https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
> 
> on x86_64:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WCD938X
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_WCD938X_SDW [=n] && (SOUNDWIRE [=n] || !SOUNDWIRE [=n])
>   Selected by [m]:
>   - SND_SOC_SC7280 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && SND_SOC_QCOM [=m] && (I2C [=y] && SOUNDWIRE [=n] || COMPILE_TEST [=y])
> 
> 
> Full randconfig file is attached.
> 

-- 
~Randy
