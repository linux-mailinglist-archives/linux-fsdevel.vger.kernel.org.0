Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EC69D83A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 02:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjBUB6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 20:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjBUB6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:58:11 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ED293D7;
        Mon, 20 Feb 2023 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676944688; i=@fujitsu.com;
        bh=p5LQ96v2FUqck9sbaRQNfMpeltTdQczG7e4+IeL+63g=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=eiPDD7fWoyhDZDHfHYzOzBm2UkRb6Jv+f3Cu40yB29j7qn+zsokYUsezmmDXJvFZs
         d5lRXLnNJIrddYSpCl70D7QASvPxBMq/glvTdY7lRyKL8peJXImOnKK//e2gA+QMrn
         Kn+G1VJcRn5gjTiv0m2GN2bQPJeQgG1H2t8FZqa5GGaBXOZp47KKfxY52p5gaSCOir
         O/8UFzq/qfGJGvBIjITZkPrPvF+nyolWd9r2jHRIChgQTlL6ua3fALXSbUo1wNK8BW
         A7EVilvid0eQCmAQ3/kTUE/fp+JbDjEdiCUxYyRZG4btQZMtUxRa0fMP9lkEVFRmQf
         bKkIL+/XJkFYw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRWlGSWpSXmKPExsViZ8MxSVdX9Uu
  yweoOU4s569ewWUyfeoHRYsuxe4wWl5/wWZyesIjJYvfrm2wWe/aeZLG4t+Y/q8WuPzvYLVb+
  +MNq8fvHHDYHbo9TiyQ8Nq/Q8li85yWTx6ZVnWwemz5NYvc4MeM3i8eLzTMZPT4+vcXi8XmTX
  ABnFGtmXlJ+RQJrxoTO62wFa9kqtu6az9TAuJS1i5GLQ0hgC6PEx6tP2SGcFUwS1zYvgcpsZ5
  RofbiHrYuRk4NXwE7i9ftljCA2i4CqxLs9z1gh4oISJ2c+YQGxRQWSJY6dbwWrFxZwlNh1rA2
  sRkRATWLSpB3MIDazQAuTxJbuChBbSGAto8S7c8YgNpuAjsSFBX/B6jkFrCTaV51jgai3kFj8
  5iA7hC0v0bx1NtAcDg4JASWJmd3xIGEJgUqJ1g+/WCBsNYmr5zYxT2AUmoXkullIJs1CMmkBI
  /MqRtPi1KKy1CJdI72kosz0jJLcxMwcvcQq3US91FLd8tTiEl1DvcTyYr3U4mK94src5JwUvb
  zUkk2MwLhMKWbr3sG4vvev3iFGSQ4mJVHeb6c+JwvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4D2
  i9CVZSLAoNT21Ii0zB5giYNISHDxKIrzG/EBp3uKCxNzizHSI1ClGRSlx3kQVoIQASCKjNA+u
  DZaWLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5lUDmcKTmVcCN/0V0GImoMXuPz6ALC5JR
  EhJNTB5rSk5sCXV/G5+8P7Pvf/loyUnc54MdXX0Oapa6Xl2v1dO+uXQur3Xd55V02nO/eR4wz
  4s9bjg/NAd/val9zr+n7569mhl+6uObck89ysLYvbVTxF6eDO7rilpsrorl0PxQolDK2YUrQq
  ekBfygGfKgndTlkXMO2irfiK1+YXTpEbGwksrvlu4FHh93DFlVtP6MCH5JZlJ+Rz1vxaxTZsu
  vi55/7JE7xKm6282qmSrPDjF8zy6puv1nIIblXOWBHyZemXzU5lHsabsO19OlmjVEDC1CfVe0
  5P3Lyo2OVFHUGXlz6Jfpee+qAid//nmoBrjkeapT8ucQvx5Wy+1x2lkKChumyxwM/N7Ts6B3U
  eVWIozEg21mIuKEwGCeOF5xgMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1676944685!494971!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21281 invoked from network); 21 Feb 2023 01:58:05 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Feb 2023 01:58:05 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 6B29C1000DC;
        Tue, 21 Feb 2023 01:58:05 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5EE4C1000D2;
        Tue, 21 Feb 2023 01:58:05 +0000 (GMT)
Received: from [192.168.50.5] (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 21 Feb 2023 01:58:01 +0000
Message-ID: <b872f2e8-c451-697b-e9cf-63c5bae52a8a@fujitsu.com>
Date:   Tue, 21 Feb 2023 09:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <hch@infradead.org>, <jane.chu@oracle.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
 <20230220212506.GS360264@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230220212506.GS360264@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/2/21 5:25, Dave Chinner 写道:
> On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
>> xfs_notify_failure.c requires a method to invalidate all dax mappings.
>> drop_pagecache_sb() can do this but it is a static function and only
>> build with CONFIG_SYSCTL.  Now, move its implementation into super.c and
>> call it super_drop_pagecache().  Use its second argument as invalidator
>> so that we can choose which invalidate method to use.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> I got no repsonse last time, so I'll just post a link to the
> concerns I stated about this:
> 
> https://lore.kernel.org/linux-xfs/20230205215000.GT360264@dread.disaster.area/

Please see patch 3.  I changed the code: freeze the fs, then drop its 
caches.


--
Thanks,
Ruan.

> 
> -Dave.
