Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155355B00CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIGJqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGJqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:46:15 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECDBAB400;
        Wed,  7 Sep 2022 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662543971; i=@fujitsu.com;
        bh=tirKYeQVFZpCtn4kxRPrTN8XmF01/d/HAUe+01mJjBU=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Ic8tDoGmqPFtJppVsiDegCrz3ODHSmyreE1X2857PemJz0o+Eln7pdFYi1RXtCamv
         88ndAhzyt0G/gP64QdXtPl+n3kcUnW9loPheZ8uKhwtFVB2VxLdEg2mjUkKCfOVuJN
         svnrTO+gSsaJ8zirKf5Fk0Jj05tyq1taUnUW4B0bi4zWqQU0U8oGo3MEu5UOM/ebN3
         oTFfGM73qZQHwNbEvWq/a0FCjrsLfV8cCW94ezovpW788dGx1IWxEEcZguEKS+LxGi
         KFk0hMWhpySejnuS14oBd24PSmrUuHbbUNB7k1Otdy1zlybcuDUhhTHqGu8ifqPcZ4
         75jbee10hevIg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRWlGSWpSXmKPExsViZ8ORqJuUIZF
  ssP+GtMX0qRcYLbYcu8docfkJn8XpCYuYLHa/vslmsWfvSRaLy7vmsFncW/Of1WLXnx3sFit/
  /GF14PI4tUjCY/MKLY/Fe14yeWxa1cnmsenTJHaPF5tnMnp8fHqLxePzJrkAjijWzLyk/IoE1
  ox/myewFGznrHjwfw9zA+NG9i5GTg4hgS2MEsu21HQxcgHZy5kkjq1awAzhbGOUaLj1jQmkil
  fATuL+pP9sIDaLgIpEw6pvbBBxQYmTM5+wgNiiAskSdw+vB7OFBXwlHt6/BWazCehIXFjwl7W
  LkYNDRMBYYlpTIsh8ZoFrjBLbnjxjB4kLCVRIrN7OAVLOKeAqsb3nNthaZgELicVvDrJD2PIS
  zVtnM4OUSwgoSczsjgcJSwB1Nk4/xARhq0lcPbeJeQKj0Cwkx81CMmkWkkkLGJlXMVolFWWmZ
  5TkJmbm6BoaGOgaGprqGpvrGlrqJVbpJuqlluqWpxaX6BrpJZYX66UWF+sVV+Ym56To5aWWbG
  IERmJKsarwDsaOlT/1DjFKcjApifLGeUkkC/El5adUZiQWZ8QXleakFh9ilOHgUJLgjQsFygk
  WpaanVqRl5gCTAkxagoNHSYR3SjJQmre4IDG3ODMdInWKUZdjbcOBvcxCLHn5ealS4ryJ6UBF
  AiBFGaV5cCNgCeoSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe+jSgKTyZeSVwm14BHcEEd
  MTWQHGQI0oSEVJSDUxlotMMF/K8mHTq60+rfRLve2fP9QwQv6AoFysyj1vNcFoSy4ynOfaWYS
  E3o6IZ3l0vfrREwY/9X/OOoID4nFYRnY2bz/3p9IhnfTdLuXnOZVf748f3XI+dJ33p/rejDz+
  ++L+FMWkj8zWje0WdvREnXgfnpT+0ajxgM91zsyz7B616/ZJurU3+/VabY1LjliousY+O25zz
  +NOkLcdvnynxm7B9Qu/N2yXdfg+Xrost1Hy5bulyo0yf9OkeezqXvDI0iX+XdHTfoashKZkW+
  e8/BP2JP1g0lfGY6eq+9Gm/fKWniUWIHhVrbSmy29vdtIR/yoUE4RXXd8YIFgWpPI173SiWWf
  7AtLWPo/CdXqsSS3FGoqEWc1FxIgAWB9RHywMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-565.messagelabs.com!1662543970!133438!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15620 invoked from network); 7 Sep 2022 09:46:10 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-4.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Sep 2022 09:46:10 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 1A961100192;
        Wed,  7 Sep 2022 10:46:10 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 0E01D10018D;
        Wed,  7 Sep 2022 10:46:10 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 7 Sep 2022 10:46:06 +0100
Message-ID: <bf68da75-5b05-5376-c306-24f9d2b92e80@fujitsu.com>
Date:   Wed, 7 Sep 2022 17:46:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v8 0/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <david@fromorbit.com>, <jane.chu@oracle.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
In-Reply-To: <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping

在 2022/9/2 18:35, Shiyang Ruan 写道:
> Changes since v7:
>    1. Add P1 to fix calculation mistake
>    2. Add P2 to move drop_pagecache_sb() to super.c for xfs to use
>    3. P3: Add invalidate all mappings after sync.
>    4. P3: Set offset&len to be start&length of device when it is to be removed.
>    5. Rebase on 6.0-rc3 + Darrick's patch[1] + Dan's patch[2].
> 
> Changes since v6:
>    1. Rebase on 6.0-rc2 and Darrick's patch[1].
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
>   fs/drop_caches.c            | 33 ---------------------------------
>   fs/super.c                  | 34 ++++++++++++++++++++++++++++++++++
>   fs/xfs/xfs_notify_failure.c | 31 +++++++++++++++++++++++++++----
>   include/linux/fs.h          |  1 +
>   include/linux/mm.h          |  1 +
>   6 files changed, 65 insertions(+), 38 deletions(-)
> 
