Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAC5B92CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 04:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIOC41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOC40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:56:26 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF590825;
        Wed, 14 Sep 2022 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663210582; i=@fujitsu.com;
        bh=KYWApU6PxzEgeqj7O7Mhvqnj29zw7K55+D3skzJQUHY=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=mUMt3672IvUaWR7eLce86gAU5LNK14HL1Lr9FML4Sy3YodAZJ2XSyNlejsoVNvmuA
         Gehi1IVIwly0gWQJcRov/rASOG7BMP03w2ZrMG5SaWr53nuh2I6QUZxoSk7WkuxLf9
         BAB4+b+dZ3Op5G54U/E0COz4uHMaxObMSJ5FjTbJV8qFKMFMwgJTz+zawZrLv83sD3
         PvltV6HXJDnHeZi7za87rCgQU7X8gc0Ot/FrPrQoLcZaSTCZtdUOb5Jg3vxqiaiaLv
         YeE48zI/lapdVul6E8kKbW5MEM9ZFmHE3gC/LFJau4yCPohSr4DvLpKGbdDijgA/x1
         FqOHX/tVnqq1Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRWlGSWpSXmKPExsViZ8MxSTdkilK
  ywcvtShbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfVgcvj1CIJj80rtDwW73nJ5LFpVSebx6ZPk9g9Xmyeyejx8ektFo/Pm+QCOKJYM/OS8isSW
  DMOnjjPUvCKr+LjpVvsDYw3ubsYuTiEBLYwStz9M4cVwlnOJDF1/SV2CGc7o8TBGzvZuhg5OX
  gF7CSOfJ3JDmKzCKhKzD+xmRUiLihxcuYTFhBbVCBZ4u7h9WC2sICvxMP7t8BsEQFNiSPfrjG
  BDGUW+AQ09M1hNogNTxklbnUvANvAJqAjcWHBX7CpnAIaEk2dC8C6mQUsJBa/OcgOYctLNG+d
  zdzFyMEhIaAkMbM7HiQsIVAh0Tj9EBOErSZx9dwm5gmMQrOQ3DcLyaRZSCYtYGRexWibVJSZn
  lGSm5iZo2toYKBraGgKpI11DU2M9BKrdBP1Ukt18/KLSjJ0DfUSy4v1UouL9Yorc5NzUvTyUk
  s2MQLjMqU4vW8H48Z9v/QOMUpyMCmJ8jLJKSUL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuB9OhE
  oJ1iUmp5akZaZA0wRMGkJDh4lEd7aPqA0b3FBYm5xZjpE6hSjLsfahgN7mYVY8vLzUqXEefdP
  AioSACnKKM2DGwFLV5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfPuBpnCk5lXArfpFdART
  EBHGFnLgxxRkoiQkmpg2qV0Zvdcrk/X0urPFC09trP1+U3ly5aJ0lyOR263NGW7iCvt5Sl8H+
  rfsHCyVl7CDnmd9sXzF9nEFQn4KL57oXEp66BjaP9ivWlfXpwua45IdHq4/oN8t9xJtnMFXtd
  +Gm08r7dd2ls8od/je5/hB9Fd80xdOwSVoh78zwnzsxSxVphTpH5h+aQ3JcZdCzgPJ6UmLfR+
  8+PGd6deocXM7qy8+dkuAuwPRC+W7GS6+/d3ZoT5vJ/qC+vW8Mx8++NVskVJRus2xpAdvodr1
  qbPPWF35OLWmWn38z4n+cmytFyrfbzXRH6b4sqn66QDbC2lzGWznwmYsKc9LG6WufzdMSMt9T
  vretsL874fWKekxFKckWioxVxUnAgAJYLW2dIDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-728.messagelabs.com!1663210580!100538!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8838 invoked from network); 15 Sep 2022 02:56:20 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Sep 2022 02:56:20 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E42A11000CC;
        Thu, 15 Sep 2022 03:56:19 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D61B8100078;
        Thu, 15 Sep 2022 03:56:19 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 15 Sep 2022 03:56:15 +0100
Message-ID: <d3b5ce9e-dcdf-26b1-cdea-712d7e1be1f6@fujitsu.com>
Date:   Thu, 15 Sep 2022 10:56:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v8 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <dan.j.williams@intel.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@infradead.org>, <david@fromorbit.com>, <jane.chu@oracle.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
 <bf68da75-5b05-5376-c306-24f9d2b92e80@fujitsu.com>
 <YyIY0+8AzTIDKMVy@magnolia> <YyIaVZ36biogzQU3@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YyIaVZ36biogzQU3@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/9/15 2:15, Darrick J. Wong 写道:
> On Wed, Sep 14, 2022 at 11:09:23AM -0700, Darrick J. Wong wrote:
>> On Wed, Sep 07, 2022 at 05:46:00PM +0800, Shiyang Ruan wrote:
>>> ping
>>>
>>> 在 2022/9/2 18:35, Shiyang Ruan 写道:
>>>> Changes since v7:
>>>>     1. Add P1 to fix calculation mistake
>>>>     2. Add P2 to move drop_pagecache_sb() to super.c for xfs to use
>>>>     3. P3: Add invalidate all mappings after sync.
>>>>     4. P3: Set offset&len to be start&length of device when it is to be removed.
>>>>     5. Rebase on 6.0-rc3 + Darrick's patch[1] + Dan's patch[2].
>>>>
>>>> Changes since v6:
>>>>     1. Rebase on 6.0-rc2 and Darrick's patch[1].
>>>>
>>>> [1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
>>>> [2]: https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Just out of curiosity, is it your (or djbw's) intent to send all these
>> as bugfixes for 6.0 via akpm like all the other dax fixen?
> 
> Aha, this is 6.1 stuff, please ignore this question.

Actually I hope these patches can be merged ASAP. (But it seems a bit 
late for 6.0 now.)

And do you know which/whose branch has picked up your patch[1]?  I 
cannot find it.


--
Thanks,
Ruan.

> 
> --D
> 
>> --D
>>
>>>>
>>>> Shiyang Ruan (3):
>>>>     xfs: fix the calculation of length and end
>>>>     fs: move drop_pagecache_sb() for others to use
>>>>     mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
>>>>
>>>>    drivers/dax/super.c         |  3 ++-
>>>>    fs/drop_caches.c            | 33 ---------------------------------
>>>>    fs/super.c                  | 34 ++++++++++++++++++++++++++++++++++
>>>>    fs/xfs/xfs_notify_failure.c | 31 +++++++++++++++++++++++++++----
>>>>    include/linux/fs.h          |  1 +
>>>>    include/linux/mm.h          |  1 +
>>>>    6 files changed, 65 insertions(+), 38 deletions(-)
>>>>
