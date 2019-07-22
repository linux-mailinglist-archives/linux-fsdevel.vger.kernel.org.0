Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDEA97020D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfGVORH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 10:17:07 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146]:42948
        "EHLO sonic317-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbfGVORH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1563805023; bh=xECj9m2xLSVUpudrwyR6+luhiAWEZ0tY/RvhMhV/bZQ=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=qYB90E9n9p2hxZA0lEfH/3+0P3CXOotPsRediTaJtnxRqX8rXbkm3N7rw6ACqGVj/xDOFFQO2lBfZKb/IYG8btDSRpHbuoEM1XkuXTGtFVHbmEW3w+fUsHaSZ6JlmvtoiY3qzILebk8kajRcTBlffJvyyEpNiRIhAIZo6B33VuXuvpr5XcvWbHCQzMl289vIkhLWBrRD4tnJ+18OKng5gGxcHrU0t6Yn3AaapcoWqDYyBULprIwuC2Xy5au5zcijJTZvsmYdc0tYoQcLagJxe43BLhArPD8T2jpVC4aF7S8nXOAPKmOGZev1nr6kHyCUhVctjAsxyukzYrmY+u+HaQ==
X-YMail-OSG: H0aMGxQVM1mvOAgQM.BAOlrQE3d.1NSa3bvXBG0WEx9WjJxsItK445bMZKRUfVj
 12opgBUymkaVs.u7jpTtxwwa_9GIYRGzyhxP6dFJwVGqa21crki_tZyomWJOspBHrkG9SPzOKRBm
 D7ufuipeZJ7UXSx_RvAPo1oddnINNrEZbgnso0SMh553gm4Xt3I2HWp8fvGcF6wC3PGdYKtMa9jb
 578ArDg3h4v1MjhPDB6Yf2MNsqlnGKnShpZs.JY5Uv9ecp94VS.Xos8wHOoSC8S1EDaDh6IBNxvu
 uj7xNLnuYXObUN4PIY3VjFIDlpf_6R7gyqFs_MMqi4yvgBqOackLXCeycoj91kprPwdmyDJwqs.f
 qir7zoltA1FLl.Cj98THb5yimboDtcDxjbyuE.lCfxzOK4IYr2Vsv4uJbjBGzM7YKtqDwG6a1BFU
 5vXXwcxGBSMoAOhO2E._UA.d4RMenZngT0tdB29RPSnv9XwU9TfnEJiPRL2LUnFhSc4FORGXT.2O
 cw69s15OhmZoJQ6f28ofqR521zU.v26Y4Iec1F9ToyPo_MGHv9TBwI02C7DES2z7rA6YAQ3Mgj8o
 oIjXLO3uZgny.L4lKW78IIxNLfaOgz_y67rH1D_M6H6M_O52G9R_M91TaCDFALRslgEEZDaglPFc
 ZKN5_BPt65jOgxl8gJjJxvb4XNdvsp6HqydGveyY.rPIDQrxpS1C2hQQSPEoiN1u1D8rfKmBF4jn
 J2ETvbcvpMU2zbc4y9tCM7LxVzANwro0rulZ3cyLrlQczLrV0cNkZ0mxaJggRaFnekjy.3Wo87wS
 .c.iEQfKP0Iy3QCR.ncEBd2t0meT1xzXtXPBSuCMzkntXiJhpB08vTX_vvdnZRd0PCDGU7lHiY0x
 D1oqCQA2kTK0XjqzjSs3QXiLWscRb6qoJUsNpRKzg70YDMsmpzUySjxHcKk4AxSE8Uzaxgsb6mV7
 yD2xECQ56Ln6ogsx6pNFVewDSl3s.WnSrg.94IsYLIrKYwzUnELlNev9aaC_Ln6eaWFZfudS4Qsg
 swka882uKsWuYoaxWR1boPTytRoNqgmNKZ0UTHudEkDFBqvOOxamSY7ar5_FpTaW7Sp7AEzyhS0F
 pW6c_6jmAxUWcSiXK_t6sBXTwuAyBb7AI2DYphKjPe.j6jJUobyHkSPyAi.Vkve0W1fMbwwRkGof
 PUhAMEvlKm0rhLQsm_SnAx4sgaAMGCWQ.psCllwsv4F8tC2Bc3YOlLiNWdu.ncQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 14:17:03 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 947e087edc5dc48dc717612cdbe533da;
          Mon, 22 Jul 2019 14:16:59 +0000 (UTC)
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
 <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
 <20190722132513.GA5172@mit.edu>
From:   Gao Xiang <hsiangkao@aol.com>
Cc:     dsterba@suse.cz, Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Message-ID: <db672675-c471-5bc8-af15-91c1859e9008@aol.com>
Date:   Mon, 22 Jul 2019 22:16:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722132513.GA5172@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On 2019/7/22 ????9:25, Theodore Y. Ts'o wrote,
> On Mon, Jul 22, 2019 at 06:58:59PM +0800, Gao Xiang wrote:
>>> The number of individual Kconfig options is quite high, are you sure you
>>> need them to be split like that?
>>
>> You mean the above? these are 3 cache strategies, which impact the
>> runtime memory consumption and performance. I tend to leave the above
>> as it-is...
> 
> Unless cache strategies involve a huge amount of kernel code, I'd
> recommend always compiling all of the cache strategies, and then have
> a way to change the cache strategy via a mount option (and possibly
> remount, although that can get tricky if there is already cached
> information).  You could also specify a default in the erofs
> superblock, you think that would be useful.
OK, I will give a try. One point I think is how to deal with the case
if there is already cached information when remounting as well as you said.

As the first step, maybe the mount option can be defined as
allowing/forbiding caching from now on, which can be refined later.

Thanks,
Gao Xiang

> 
> 	    	      	   	    - Ted
> 
