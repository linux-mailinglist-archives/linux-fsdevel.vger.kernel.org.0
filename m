Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4401DF7EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgEWPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 11:08:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA2FC061A0E;
        Sat, 23 May 2020 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+L1qyjeYez4naHDlqKEQbGA3dUqIQLDkuxoqpeTg+yU=; b=mkEKmCtliH+55rZa+ipwPcNydW
        KUDIjF1IVH5CRKZVarYUmqPVt1DebfFDImGBfPnLWgtiULFkkWwqPtCf9nH6LrAv5jgzcFsMnTpga
        BANYf6hhvxkAXJBCf+5QGmwEAWGZfMce6wNj95EtRmfQXS5S4XnRpY2Ifl33zSS0yqmDFWrjzgJ14
        QAhpTu+NaoQiHrjqtGAVv+jSNJ8x7D0yzW0MZeSCEYECHAAfcvomHoX4YQ6Y/ODowCbLsUrph7Qdi
        1/JYPHAM+4TpXTdf3cfjuJPWAQ4Mi/ND1/krdbgbl7pzNxUjYu7f0EWbr9Yn4KcLnKyJuGRubzJjB
        IBTFUwvA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcVlM-0004y7-QT; Sat, 23 May 2020 15:08:36 +0000
Subject: Re: mmotm 2020-05-22-20-35 uploaded (phy/intel/phy-intel-combo.c)
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200523033645.-uo7X483o%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9960b5aa-4a8e-15a4-6e0b-63561f760d3a@infradead.org>
Date:   Sat, 23 May 2020 08:08:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523033645.-uo7X483o%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/20 8:36 PM, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2020-05-22-20-35 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 
> 

on i386:

  CC      drivers/phy/intel/phy-intel-combo.o
In file included from ../include/linux/build_bug.h:5:0,
                 from ../include/linux/bitfield.h:10,
                 from ../drivers/phy/intel/phy-intel-combo.c:8:
../drivers/phy/intel/phy-intel-combo.c: In function ‘combo_phy_w32_off_mask’:
../include/linux/compiler.h:447:38: error: call to ‘__compiletime_assert_39’ declared with attribute error: FIELD_PREP: mask is not constant
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
../include/linux/compiler.h:428:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
../include/linux/compiler.h:447:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:46:3: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
   ^~~~~~~~~~~~~~~~
../include/linux/bitfield.h:94:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro ‘FIELD_PREP’
  reg_val |= FIELD_PREP(mask, val);
             ^~~~~~~~~~
../include/linux/compiler.h:447:38: error: call to ‘__compiletime_assert_43’ declared with attribute error: BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
../include/linux/compiler.h:428:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
../include/linux/compiler.h:447:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
../include/linux/build_bug.h:21:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
  ^~~~~~~~~~~~
../include/linux/bitfield.h:54:3: note: in expansion of macro ‘__BUILD_BUG_ON_NOT_POWER_OF_2’
   __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +   \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:94:3: note: in expansion of macro ‘__BF_FIELD_CHECK’
   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
   ^~~~~~~~~~~~~~~~
../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro ‘FIELD_PREP’
  reg_val |= FIELD_PREP(mask, val);
             ^~~~~~~~~~


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
