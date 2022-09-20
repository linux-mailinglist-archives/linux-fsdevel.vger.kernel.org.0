Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35CC5BD941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 03:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiITBRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 21:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITBRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:17:24 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913F1422DD;
        Mon, 19 Sep 2022 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663636640; i=@fujitsu.com;
        bh=D8XfSt7EsVqxu3xA7NaRDArw/jwaG+CKPnYKQWjU1+A=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=F1YiOkQtfzMgn8TwgFdnyHazVmrQ0qVlEqyJV4tgCsurMW7LLQ/+UD6PRs8IpYIR6
         fiL0h40I6d+aPLaX9H0DHYovh3YkAqDr9KQ5B5ERFFS4KijhkQSK5ybc0Xn9Mn1CPy
         mN/bDiuAMY6jLZuWL8e51T1JVN038zQuz+V841aGdO6qhmLg1pUoKsLGUuA4oyehPb
         aKoY8syfFy4LR+sdVtWLqhyp1kreicYvikdKMqi6kuWsszeeZrr9l9U9YkU/j5YVj7
         acWLvLbR3Ouz9IE7fLZvR0ODLnCWOtjvzavk/3CbyJpHdUy5pMSeb0gl5Xso+oGnnf
         WOkXLiSRxROwQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRWlGSWpSXmKPExsViZ8ORqDtPRDP
  ZYNFycYvpUy8wWmw5do/R4vITPos9e0+yWFzeNYfN4t6a/6wWu/7sYLdY+eMPqwOHx6lFEh6L
  97xk8ti0qpPNY9OnSeweLzbPZPT4vEkugC2KNTMvKb8igTVjYkMXY8EtzYo3e56xNTCuVu5i5
  OIQEtjCKPH/3RZmCGc5k8TN8/PYIZztjBJzbnUzdjFycPAK2Em0zLTtYuTkYBFQlfi+eAkjiM
  0rIChxcuYTFhBbVCBZ4u7h9WC2sICjxKupLWA1IgJqEpMm7QBbwCxwhFHix/IWqAVLGCVOTr7
  EDlLFJqAjcWHBX1YQm1PAWmLiuQlgNrOAhcTiNwfZIWx5ieats5lBDpIQUJKY2R0PEpYQqJBo
  nH6ICcJWk7h6bhPzBEahWUjum4Vk0iwkkxYwMq9itE4qykzPKMlNzMzRNTQw0DU0NNW1NNM1N
  NNLrNJN1Est1c3LLyrJ0DXUSywv1kstLtYrrsxNzknRy0st2cQIjLWU4gSBHYx79/3SO8Qoyc
  GkJMrLVaeRLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC115QM1lIsCg1PbUiLTMHGPcwaQkOHiU
  R3jJuoDRvcUFibnFmOkTqFKMux9TZ//YzC7Hk5eelSonzzgWZIQBSlFGaBzcCloIuMcpKCfMy
  MjAwCPEUpBblZpagyr9iFOdgVBLm7QRZxZOZVwK36RXQEUxAR9xQUQc5oiQRISXVwCR1aH8la
  8/Dm0/5dTRjgg+s3G08T++O0/H+jw6hBgtSDn4+Os3k3IbZv3/8Lj9+X/rItYtTU1nWS1kcnp
  /9yJrbIvK1nF/T/U1isrfv/lv46tuPrCBPttBC5lDRmTFamnOj1ZR5GRr0ygNtAlw954idPT3
  rm+w7rm/sUS2FQR6JDeEJLx5oXjn0a86Rlxu4MhyOuk3gzrov7fraVWHZof1NfpJdJu3Ped8u
  m5k9tc4i3mu+3PMVc9fXFSod0yqM0nd6fjPh5Ql9i5p1d/VVua4kn9I7vfjD/yczJRdc+OBo6
  FfAFqpc96orfqH3PI/jnNzh0rlFxf/Xp1nYPPilJcRo8agl6xBXpPj5ysiZb5VYijMSDbWYi4
  oTAZ9sfPi8AwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-728.messagelabs.com!1663636637!206431!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13415 invoked from network); 20 Sep 2022 01:17:18 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-9.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Sep 2022 01:17:18 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id B496010019A;
        Tue, 20 Sep 2022 02:17:17 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A6134100197;
        Tue, 20 Sep 2022 02:17:17 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 20 Sep 2022 02:17:14 +0100
Message-ID: <1bc45fd2-f5e2-dd7b-0c9e-e3ab2527d736@fujitsu.com>
Date:   Tue, 20 Sep 2022 09:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] xfs: drop experimental warning for fsdax
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>
References: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20220919045003.GJ3600936@dread.disaster.area>
 <20220919211533.GK3600936@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220919211533.GK3600936@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

在 2022/9/20 5:15, Dave Chinner 写道:
> On Mon, Sep 19, 2022 at 02:50:03PM +1000, Dave Chinner wrote:
>> On Thu, Sep 15, 2022 at 09:26:42AM +0000, Shiyang Ruan wrote:
>>> Since reflink&fsdax can work together now, the last obstacle has been
>>> resolved.  It's time to remove restrictions and drop this warning.
>>>
>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>
>> I haven't looked at reflink+DAX for some time, and I haven't tested
>> it for even longer. So I'm currently running a v6.0-rc6 kernel with
>> "-o dax=always" fstests run with reflink enabled and it's not
>> looking very promising.
>>
>> All of the fsx tests are failing with data corruption, several
>> reflink/clone tests are failing with -EINVAL (e.g. g/16[45]) and
>> *lots* of tests are leaving stack traces from WARN() conditions in
>> DAx operations such as dax_insert_entry(), dax_disassociate_entry(),
>> dax_writeback_mapping_range(), iomap_iter() (called from
>> dax_dedupe_file_range_compare()), and so on.
>>
>> At thsi point - the tests are still running - I'd guess that there's
>> going to be at least 50 test failures by the time it completes -
>> in comparison using "-o dax=never" results in just a single test
>> failure and a lot more tests actually being run.
> 
> The end results with dax+reflink were:
> 
> SECTION       -- xfs_dax
> =========================
> 
> Failures: generic/051 generic/068 generic/074 generic/075
> generic/083 generic/091 generic/112 generic/127 generic/164
> generic/165 generic/175 generic/231 generic/232 generic/247
> generic/269 generic/270 generic/327 generic/340 generic/388
> generic/390 generic/413 generic/447 generic/461 generic/471
> generic/476 generic/517 generic/519 generic/560 generic/561
> generic/605 generic/617 generic/619 generic/630 generic/649
> generic/650 generic/656 generic/670 generic/672 xfs/011 xfs/013
> xfs/017 xfs/068 xfs/073 xfs/104 xfs/127 xfs/137 xfs/141 xfs/158
> xfs/168 xfs/179 xfs/243 xfs/297 xfs/305 xfs/328 xfs/440 xfs/442
> xfs/517 xfs/535 xfs/538 xfs/551 xfs/552
> Failed 61 of 1071 tests
> 
> Ok, so I did a new no-reflink run as a baseline, because it is a
> while since I've tested DAX at all:
> 
> SECTION       -- xfs_dax_noreflink
> =========================
> Failures: generic/051 generic/068 generic/074 generic/075
> generic/083 generic/112 generic/231 generic/232 generic/269
> generic/270 generic/340 generic/388 generic/461 generic/471
> generic/476 generic/519 generic/560 generic/561 generic/617
> generic/650 generic/656 xfs/011 xfs/013 xfs/017 xfs/073 xfs/297
> xfs/305 xfs/517 xfs/538
> Failed 29 of 1071 tests
> 
> Yeah, there's still lots of warnings from dax_insert_entry() and
> friends like:
> 
> [43262.025815] WARNING: CPU: 9 PID: 1309428 at fs/dax.c:380 dax_insert_entry+0x2ab/0x320
> [43262.028355] Modules linked in:
> [43262.029386] CPU: 9 PID: 1309428 Comm: fsstress Tainted: G W          6.0.0-rc6-dgc+ #1543
> [43262.032168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [43262.034840] RIP: 0010:dax_insert_entry+0x2ab/0x320
> [43262.036358] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 84 b1 5a 00 eb a4 48 81 e6
> [43262.042255] RSP: 0018:ffffc9000a0cbb78 EFLAGS: 00010002
> [43262.043946] RAX: ffffea0018cd1fc0 RBX: 0000000000000001 RCX: 0000000000000001
> [43262.046233] RDX: ffffea0000000000 RSI: 0000000000000221 RDI: ffffea0018cd2000
> [43262.048518] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
> [43262.050762] R10: ffff888241a6d318 R11: 0000000000000001 R12: ffffc9000a0cbc58
> [43262.053020] R13: ffff888241a6d318 R14: ffffc9000a0cbe20 R15: 0000000000000000
> [43262.055309] FS:  00007f8ce25e2b80(0000) GS:ffff8885fec80000(0000) knlGS:0000000000000000
> [43262.057859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [43262.059713] CR2: 00007f8ce25e1000 CR3: 0000000152141001 CR4: 0000000000060ee0
> [43262.061993] Call Trace:
> [43262.062836]  <TASK>
> [43262.063557]  dax_fault_iter+0x243/0x600
> [43262.064802]  dax_iomap_pte_fault+0x199/0x360
> [43262.066197]  __xfs_filemap_fault+0x1e3/0x2c0
> [43262.067602]  __do_fault+0x31/0x1d0
> [43262.068719]  __handle_mm_fault+0xd6d/0x1650
> [43262.070083]  ? do_mmap+0x348/0x540
> [43262.071200]  handle_mm_fault+0x7a/0x1d0
> [43262.072449]  ? __kvm_handle_async_pf+0x12/0xb0
> [43262.073908]  exc_page_fault+0x1d9/0x810
> [43262.075123]  asm_exc_page_fault+0x22/0x30
> [43262.076413] RIP: 0033:0x7f8ce268bc23

Thanks for testing.  I just ran the xfstests and got these failures too. 
  The failure at dax_insert_entry() appeared during my development but 
was fixed before I sent the patchset.  Now I am looking for what's wrong 
with it.

BTW, which groups did you test?  I usually test quick,clone group.


--
Thanks,
Ruan.

> 
> So it looks to me like DAX is well and truly broken in 6.0-rc6. And,
> yes, I'm running the fixes in mm-hotifxes-stable branch that allow
> xfs/550 to pass.
> 
> Who is actually testing this DAX code, and what are they actually
> testing on? These are not random failures - I haven't run DAX
> testing since ~5.18, and none of these failures were present on the
> same DAX test VM running the same configuration back then....
> 
> -Dave.
