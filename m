Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8145D2DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 03:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhKYCHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhKYCFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 21:05:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C0C061A1A;
        Wed, 24 Nov 2021 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=qYw5RIZBYu+7TC3KjriRLSrZwn1E3iMtbuXhHAISxsY=; b=yGbXk3L+x2f8HhRmR6X1X25pSa
        wGsZIl/Rbsf/xlDcxMSq8Wf94/PcPWJ+9mlpAoJj/EmWa1YSoGFbVKUz+wyn41B583pr36qTKlmEs
        VO7Kom827tHmWzwmS9yw+mmeSwxmfIoWVmXLK2r5mLDJeKX2NYNT/4i8YKqVF54zBr2PkMz+Pt7qr
        gSANvH66vibc9Bplw3++VO0sA3X0O2YvhtkyNmrNiM6+g1tgNGK5GCET5YQzLqLCJ5WRf/4n6qGsE
        uI0L4sp/KfdfmuT4pKXL7WDs/FrcAucukzFICpMEqDDUtXc95SpzeCwZPuzuafV0wd/YLXB4wkXHE
        m8JMl8Kg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq3j9-006El5-N1; Thu, 25 Nov 2021 01:39:07 +0000
Subject: Re: mmotm 2021-11-24-15-49 uploaded (drivers/usb/host/xhci-hub.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-usb@vger.kernel.org
References: <20211124234931.iDJQctzrQ%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b4fcff8-d7a0-b235-c94d-147e19738d72@infradead.org>
Date:   Wed, 24 Nov 2021 17:39:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124234931.iDJQctzrQ%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/24/21 3:49 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-11-24-15-49 has been uploaded to
> 
>     https://www.ozlabs.org/~akpm/mmotm/
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


on i386:

../drivers/usb/host/xhci-hub.c: In function ‘xhci_create_usb3x_bos_desc’:
./../include/linux/compiler_types.h:335:38: error: call to ‘__compiletime_assert_608’ declared with attribute error: FIELD_PREP: value too large for the field
   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                       ^
./../include/linux/compiler_types.h:316:4: note: in definition of macro ‘__compiletime_assert’
     prefix ## suffix();    \
     ^~~~~~
./../include/linux/compiler_types.h:335:2: note: in expansion of macro ‘_compiletime_assert’
   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                      ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:49:3: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
    BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
    ^~~~~~~~~~~~~~~~
../include/linux/bitfield.h:94:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
    ^~~~~~~~~~~~~~~~
../drivers/usb/host/xhci-hub.c:220:4: note: in expansion of macro ‘FIELD_PREP’
     FIELD_PREP(USB_SSP_SUBLINK_SPEED_LSM, lane_mantissa));
     ^~~~~~~~~~


$ gcc --version
gcc (SUSE Linux) 7.5.0


-- 
~Randy
