Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB9E5F034F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 05:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiI3D3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 23:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI3D3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 23:29:11 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21C15935C;
        Thu, 29 Sep 2022 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664508548; i=@fujitsu.com;
        bh=mFMDaGi8NAVV6NLt5xFQz6xlRjSXLGOTDoBUXMnlFQw=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=YvI9HHbWtUdy10Gyo9J4dKfPuR9+DsUrs/Fh0ejEisHmRqwAD7fgrm89g/kws2BBy
         AUQhXF7Yyeo3eVnngcl8WxklfpuL05AR5dDLQr6Imngs59jAxfN2cSGHeoOlEinydQ
         P1YdzdgWQl9j1IWO5FdlXQ1jSM2lr23SvuYgO1kgy2WmHiKYbI9N+jOXhofIiHd7Fz
         aeoRKWPNpUBPuyTd0Pc/6WFn+cXeLk7fI5LBCpWSlv4WUVyML+n003McnfbNBCunx+
         w2CDRfVO9Ty9bJBJ3fssC8/cLl4rZ27ZstcHDtNwl6umgHGev+/31exhJxeL777x2d
         w8yf8UnUNaQCQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRWlGSWpSXmKPExsViZ8ORqNucZJZ
  sMK+Z32L61AuMFluO3WO0uPyEz+L0hEVMFnv2nmSxuLxrDpvFvTX/WS12/dnBbrHyxx9WB06P
  U4skPDav0PJYvOclk8emVZ1sHps+TWL3eLF5JqPH501yAexRrJl5SfkVCawZh360sRU84azY+
  O4uUwPjNfYuRi4OIYEtjBJbf99lgXCWM0nsaLvCCOFsZ5RYMe0/axcjJwevgJ3E6Tub2UBsFg
  FViVv9M1gg4oISJ2c+AbNFBZIlvk69yARiCwv4SmzYuwksziagI3FhwV9WkKEiApMYJY7duMk
  MkmAWSJBo/3INrEFIwEWiZ+9ZMJtTwFVi6ZRVTBA1FhKL3xxkh7DlJZq3zgbq5eCQEFCSmNkd
  DxKWEKiQmDWrjQnCVpO4em4T8wRGoVlIzpuFZNIsJJMWMDKvYrRKKspMzyjJTczM0TU0MNA1N
  DTVNdE1MrbUS6zSTdRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIjL2UYpb3Oxib+n
  7qHWKU5GBSEuW9wWeWLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCVzwRKCdYlJqeWpGWmQNMAzB
  pCQ4eJRHevZFAad7igsTc4sx0iNQpRl2OtQ0H9jILseTl56VKifNqJAAVCYAUZZTmwY2ApaRL
  jLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5heKBpvBk5pXAbXoFdAQT0BEfmYxBjihJREhJN
  TBF7bTt3bJ6Gs9lrnd3f3F5rQs6fngPv86bQu/J6z4s+Zd3oXixv/6nL3GBKx9rPbrF5t/hpT
  ht3tL0myxyNsanFid4+2jslGC0KFz9ZnNTyFGmCavWX9VY9EWusYCZjbPHLnP+jvwZL01L9H+
  sFfnuVzVNpPnxDaUZwa1PIpKSnfqOZXuuu3Pn4h5Ge03uzv/7z0dxhtx5vkWe91bO+tk17PvW
  +1aL++XJOrXE7zjStUDHpklq3UK7NQ88C+babst0uXVm5yeN3G0RngKflZU4TxybumtO8oE++
  elTOSXCHV7e3GK7V6qBtdPi72GGZ6W28x+ddnzzeEL/pcJFTMtPnD50dJXMm16p351Kj8u/Kr
  EUZyQaajEXFScCAF51o43EAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-585.messagelabs.com!1664508546!338429!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26973 invoked from network); 30 Sep 2022 03:29:07 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-6.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Sep 2022 03:29:07 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C9955100192;
        Fri, 30 Sep 2022 04:29:06 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id BD6FC100191;
        Fri, 30 Sep 2022 04:29:06 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 30 Sep 2022 04:29:03 +0100
Message-ID: <ba642a21-8876-0cd0-2627-6fb7e534c950@fujitsu.com>
Date:   Fri, 30 Sep 2022 11:28:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v9 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>
References: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
In-Reply-To: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Ping

在 2022/9/25 21:33, Shiyang Ruan 写道:
> Changes since v8:
>    1. P2: rename drop_pagecache_sb() to super_drop_pagecache().
>    2. P2: let super_drop_pagecache() accept invalidate method.
>    3. P3: invalidate all dax mappings by invalidate_inode_pages2().
>    4. P3: shutdown the filesystem when it is to be removed.
>    5. Rebase on 6.0-rc6 + Darrick's patch[1] + Dan's patch[2].
> 
> [1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
> [2]: https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/
> 
> Shiyang Ruan (3):
>    xfs: fix the calculation of length and end
>    fs: move drop_pagecache_sb() for others to use
>    mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
> 
>   drivers/dax/super.c         |  3 ++-
>   fs/drop_caches.c            | 35 ++----------------------------
>   fs/super.c                  | 43 +++++++++++++++++++++++++++++++++++++
>   fs/xfs/xfs_notify_failure.c | 36 ++++++++++++++++++++++++++-----
>   include/linux/fs.h          |  1 +
>   include/linux/mm.h          |  1 +
>   include/linux/pagemap.h     |  1 +
>   mm/truncate.c               | 20 +++++++++++++++--
>   8 files changed, 99 insertions(+), 41 deletions(-)
> 
