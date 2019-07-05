Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4805FF4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 03:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfGEBTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 21:19:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57162 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfGEBTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sMXRgiUX1St8pf2vFdCJ5XAY8S//wPffXNJgq0u7mgI=; b=sSzW9TRDObDlpQ3hPHMqVMDV+2
        /BK4mqdFc1ao6uAafeVWe9hOq2z91t1CiGapZyghouo+T/GqDrY+pCPChC83Gfjpxp61ZjZmNjf+i
        DcjwpwIVaEu9Kr2bYm1nlj8YW51ATZBnmaxDDz0uvSUkK0Cp7Tm3rxMGBCdB9EiFS6e8AhQrnKO8C
        TdfYJmp9l8zSJsH8ySZAfI/6apbt9hE5Po/dbtwniqRUPLvcl8RW/P3ULS3Aq4kCUEALcBKK9tOdC
        7m5eX4fuYHpLujfae/IYtEljs06/Vsz+S3erD3FPy1sO6fTv9r1SdSSEGmn36NzoLr9So15wVxnUu
        keG/DMsw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjCt7-0006mu-N1; Fri, 05 Jul 2019 01:19:45 +0000
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
 <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63db23ac-c642-3e0c-58a4-81df991ad637@infradead.org>
Date:   Thu, 4 Jul 2019 18:19:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/19 6:09 PM, Randy Dunlap wrote:
> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
> 
> I get a lot of these but don't see/know what causes them:
> 
> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
> 

[+ linux-kbuild]

It seems to have something to do with "modules.order".

But!!!
# CONFIG_DRM_I915 it not set

-- 
~Randy
