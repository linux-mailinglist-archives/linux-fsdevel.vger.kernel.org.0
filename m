Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311405FD79A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 12:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJMKIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJMKIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:08:11 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D7F987C;
        Thu, 13 Oct 2022 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1665655687; i=@fujitsu.com;
        bh=dJcZNOD1TZqSJEBMvqyns3m1HsI0veOvDdlgGPnJ1P8=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=AdF5RmjYGd20CIIcNO+6W5vjlKnfsU+g/YEp6pkL3S/Y/BSv3wonQPSF8PLC9AdwZ
         kPoaDLqwi/rrR4Qe9tKduMqU/2BdFyliIT0y3r2VNPz1hGJuV66ljDHULp69cNNg4B
         Xrpx7MybT6ZOWG2rcSOL93n9RzIDv50m377Ccsu7pp2QW0yuf4/dk6SoqV0/MQQY2l
         cEP/Iw+3wxFbB/hG0ccBAsf9W1iY4C26SJ3QX9kl6o4GtcWwHAGPcpKLSutds/HdTI
         hVSbBD7ocO8Gkxww6ZF6P5hQ4nCgPjC2MUIeqFSzZH3e7KQfI6pQdm81/imElcPhrW
         W2Uac+37TTOhg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRWlGSWpSXmKPExsViZ8ORpNv22D3
  Z4PBzJYvpUy8wWmw5do/R4vITPovTExYxWezZe5LF4vKuOWwW99b8Z7XY9WcHu8XKH39YHTg9
  Ti2S8Ni8Qstj8Z6XTB6bVnWyeWz6NInd48XmmYwenzfJBbBHsWbmJeVXJLBmfPzRxVawmLvi1
  ImCBsZ3nF2MXBxCAhsZJY5s/sIC4SxhkjhzbzcThLOdUeJM2122LkZODl4BO4kDZz8zgdgsAq
  oSq87NZoSIC0qcnPmEBcQWFUiW+Dr1IliNsICvxIa9m8DibAI6EhcW/GUFGSoiMIlR4tiNm8w
  gCWaBBIn2L9fAGoQEKiR2PfkCFucUsJfY0HcDqsZCYvGbg+wQtrxE89bZQHEODgkBJYmZ3fEg
  YQmg1lmz2pggbDWJq+c2MU9gFJqF5LxZSCbNQjJpASPzKkbrpKLM9IyS3MTMHF1DAwNdQ0NTX
  WNzXUMzI73EKt1EvdRS3fLU4hJdILe8WC+1uFivuDI3OSdFLy+1ZBMjMPZSilUX7WDcv+qn3i
  FGSQ4mJVHed7fck4X4kvJTKjMSizPii0pzUosPMcpwcChJ8IY+BMoJFqWmp1akZeYA0wBMWoK
  DR0mEl+0RUJq3uCAxtzgzHSJ1ilGXY23Dgb3MQix5+XmpUuK8nx8AFQmAFGWU5sGNgKWkS4yy
  UsK8jAwMDEI8BalFuZklqPKvGMU5GJWEebtBVvFk5pXAbXoFdAQT0BFLT7mBHFGSiJCSamByz
  LG0cvRdMP3lldKL6wsCVecuOmi5s2q+bGvVuQNtOap5qU2bmsweyoXqTHnn6WOltEb+m+I/9r
  3tJ/5p3c99uvdwFMuB3g1bLpSplsaw+59zCf+6y7f1oGZ0nwyD6gz9db8qzTtL+XNEu/NeFa/
  bKKJstvA7Y8AiafbGt1zP9CTVmS6YPlgWyVRR9KtRxPTK5RvGC0QmRMdYbwp5ylmwz+3e/Z+F
  xdIHBWLenw7e81/4mEvypBNL9lxuMrSvD8wIjF/iKPFkajyztsmku0e//P1u37TgIuuCvH/Rb
  bVrTzp6vQ+rNOsIONkbcu2pwNM/Uo/OyAt9e+76WpyH7Vp/o2CG3Ca1wj0xDjWmE5VYijMSDb
  WYi4oTAWrVox7EAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-548.messagelabs.com!1665655686!107385!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22353 invoked from network); 13 Oct 2022 10:08:06 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-9.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Oct 2022 10:08:06 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 33D5F1B4;
        Thu, 13 Oct 2022 11:08:06 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 280971B3;
        Thu, 13 Oct 2022 11:08:06 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 13 Oct 2022 11:08:02 +0100
Message-ID: <7431bafb-97e2-f755-45ca-e7cce339fd88@fujitsu.com>
Date:   Thu, 13 Oct 2022 18:07:56 +0800
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
 <ba642a21-8876-0cd0-2627-6fb7e534c950@fujitsu.com>
In-Reply-To: <ba642a21-8876-0cd0-2627-6fb7e534c950@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping again~

在 2022/9/30 11:28, Shiyang Ruan 写道:
> Hi,
> 
> Ping
> 
> 在 2022/9/25 21:33, Shiyang Ruan 写道:
>> Changes since v8:
>>    1. P2: rename drop_pagecache_sb() to super_drop_pagecache().
>>    2. P2: let super_drop_pagecache() accept invalidate method.
>>    3. P3: invalidate all dax mappings by invalidate_inode_pages2().
>>    4. P3: shutdown the filesystem when it is to be removed.
>>    5. Rebase on 6.0-rc6 + Darrick's patch[1] + Dan's patch[2].
>>
>> [1]: https://lore.kernel.org/linux-xfs/Yv5wIa2crHioYeRr@magnolia/
>> [2]: 
>> https://lore.kernel.org/linux-xfs/166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Shiyang Ruan (3):
>>    xfs: fix the calculation of length and end
>>    fs: move drop_pagecache_sb() for others to use
>>    mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
>>
>>   drivers/dax/super.c         |  3 ++-
>>   fs/drop_caches.c            | 35 ++----------------------------
>>   fs/super.c                  | 43 +++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_notify_failure.c | 36 ++++++++++++++++++++++++++-----
>>   include/linux/fs.h          |  1 +
>>   include/linux/mm.h          |  1 +
>>   include/linux/pagemap.h     |  1 +
>>   mm/truncate.c               | 20 +++++++++++++++--
>>   8 files changed, 99 insertions(+), 41 deletions(-)
>>
