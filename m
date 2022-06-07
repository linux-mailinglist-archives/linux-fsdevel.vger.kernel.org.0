Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8994E53F91C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 11:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiFGJJT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 05:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiFGJJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:09:16 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72E8D140A1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 02:09:15 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A160VbaBUdL66ThVW/xXhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fVge93TIn1jECmmBNDzzTM/yPY2v3Kd92bYy+oB5S6JKAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/EZpeGZfSTXXcu7iheun2HX6/lnCgc9NJcA9+BrDHt?=
 =?us-ascii?q?m8uYRIzQAKBuEgoqexLO9V/kpiN8vIdfmOKsBtXx6izLUF/ArRdbEWaqi2DPy9?=
 =?us-ascii?q?F/cnegXRbCHOZVfMmEpMXz9j9R0Eg9/IPoDcC2A3xETqwFllW8=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEQFsvauTWPQLvCi/N6VQ2BuF7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxrbHNoB19726MtN9xYgBHpTnuAsa9qB/nhPpICMwqTNCftWrd1l?=
 =?us-ascii?q?dATrsP0WKK+VSJcEeSygce79YET0EUMr3N5DZB/KXHCUWDcurI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124756644"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Jun 2022 17:09:15 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 914724D17162;
        Tue,  7 Jun 2022 17:09:14 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 7 Jun 2022 17:09:14 +0800
Received: from [192.168.22.78] (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 7 Jun 2022 17:09:14 +0800
Message-ID: <52859779-2e81-f870-118e-368538cd17e8@fujitsu.com>
Date:   Tue, 7 Jun 2022 17:09:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] fsdax: output address in dax_iomap_pfn() and rename
 it
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-fsdevel@vger.kernel.org>
References: <Yp8FUZnO64Qvyx5G@kili>
 <8d640912-d253-bcbb-fcd1-cff645fb09a2@fujitsu.com>
 <20220607090405.GP2168@kadam>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220607090405.GP2168@kadam>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 914724D17162.ABF5D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/6/7 17:04, Dan Carpenter 写道:
> On Tue, Jun 07, 2022 at 04:54:29PM +0800, Shiyang Ruan wrote:
>>
>>
>> 在 2022/6/7 15:59, Dan Carpenter 写道:
>>> Hello Shiyang Ruan,
>>>
>>> The patch 1447ac26a964: "fsdax: output address in dax_iomap_pfn() and
>>> rename it" from Jun 3, 2022, leads to the following Smatch static
>>> checker warning:
>>>
>>> 	fs/dax.c:1085 dax_iomap_direct_access()
>>> 	error: uninitialized symbol 'rc'.
>>>
>>> fs/dax.c
>>>       1052 static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
>>>       1053                 size_t size, void **kaddr, pfn_t *pfnp)
>>>       1054 {
>>>       1055         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>>>       1056         int id, rc;
>>>       1057         long length;
>>>       1058
>>>       1059         id = dax_read_lock();
>>>       1060         length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
>>>       1061                                    DAX_ACCESS, kaddr, pfnp);
>>>       1062         if (length < 0) {
>>>       1063                 rc = length;
>>>       1064                 goto out;
>>>       1065         }
>>>       1066         if (!pfnp)
>>>       1067                 goto out_check_addr;
>>>
>>> Is this an error path?
>>>
>>>       1068         rc = -EINVAL;
>>>       1069         if (PFN_PHYS(length) < size)
>>>       1070                 goto out;
>>>       1071         if (pfn_t_to_pfn(*pfnp) & (PHYS_PFN(size)-1))
>>>       1072                 goto out;
>>>       1073         /* For larger pages we need devmap */
>>>       1074         if (length > 1 && !pfn_t_devmap(*pfnp))
>>>       1075                 goto out;
>>>       1076         rc = 0;
>>>       1077
>>>       1078 out_check_addr:
>>>       1079         if (!kaddr)
>>>       1080                 goto out;
>>>
>>> How is it supposed to be handled if both "pfnp" and "kaddr" are NULL?
>>>
>>> Smatch says that "kaddr" can never be NULL so this code is just future
>>> proofing but I didn't look at it carefully.
>>
>> Yes, we always pass the @kaddr in all caller, it won't be NULL now.  And
>> even @kaddr and @pfnp are both NULL, it won't cause any error.  So, I think
>> the rc should be initialized to 0 :
>>
>>   {
>>          pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>> -       int id, rc;
>> +       int id, rc = 0;
>>          long length;
>>
>> Do I need to fix this and resend a patch to the list?  Or you could help me
>> fix this?
> 
> Could you handle this?  Is this in Andrew's tree?  I think you send a
> follow on patch and he'll eventually fold it into the original patch.

OK, got it.


--
Thanks,
Ruan.

> 
> regards,
> dan carpenter
> 


