Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160145B8193
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiINGoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 02:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiINGoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:44:22 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FB64D26F;
        Tue, 13 Sep 2022 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1663137859; i=@fujitsu.com;
        bh=efVAjPYse3rF9WCV59EbTeWjJLleTTblkfqti2c1zJ4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=Ga0zCV01hbaJdTiiC6tj4M/Q+T+SEw271GrlewpO7CtfJvgFDX7VeGy4pRve0dy9a
         rxwVO+H8AL/T+JcLzB4NDM8Q6ddev0eFWN4C8TUZT/zE7+Bva57pxdJg4S2SwLGXj0
         df7g33KTrVHFGk+O2rbauhLcyNjAdz+ZdwZ/iipqr3i42IGUkgcxrT+LZYdgLSPtBY
         790XxoOo4xa5042Gf6240gnHD+TpMh1quZZObX996ZODOITPCB+G5xDufA+P4zUeHE
         eG54coK7DXchcKwP/bRjV8BOTtSppJR3VNrOscnGvACr/MtuXBKYrx2p6MpQ+HBqVO
         JYZkgdOnaougQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsViZ8ORpOtUoZh
  s0Ldcz+Ld5yqLLcfuMVpcfsJncXrCIiaLPXtPslhc3jWHzWLXnx3sFit//GF14PA4tUjCY/MK
  LY9NqzrZPF5snsno8X7fVTaPz5vkAtiiWDPzkvIrElgz9mxsZCnYwl2x7dl15gbG9RxdjFwcQ
  gIbGSXWTVvIAuEsYZLo6utjhXC2MUqsf/SSrYuRk4NXwE5iws4HrCA2i4CqxPP3d9gh4oISJ2
  c+YQGxRQWSJK5uuAtWIyzgK7F2Ux8ziC0CZK/oXc4EMpRZ4AOTRM/f30wQG+YwSxxumQJWxSb
  gKDFv1kawbZwC6hL9J36BTWUWsJBY/OYgO4QtL7H97RywegkBRYm2Jf/YIewKicbph5ggbDWJ
  q+c2MU9gFJqF5MBZSEbNQjJqASPzKkarpKLM9IyS3MTMHF1DAwNdQ0NTXWMjXUMTvcQq3US91
  FLd8tTiEl0jvcTyYr3U4mK94src5JwUvbzUkk2MwEhLKVbg28HYvOqn3iFGSQ4mJVHeD18Vko
  X4kvJTKjMSizPii0pzUosPMcpwcChJ8D4vVUwWEixKTU+tSMvMAUY9TFqCg0dJhHdSPlCat7g
  gMbc4Mx0idYpRl+P8zv17mYVY8vLzUqXEeaeUAxUJgBRllObBjYAloEuMslLCvIwMDAxCPAWp
  RbmZJajyrxjFORiVhHmrQabwZOaVwG16BXQEE9ARRtbyIEeUJCKkpBqYlD6/XaKS82W7wZQFv
  wsap60V15T/qbVpya8TYqlr3jXsKc5avHRT1uGcL3H28SZR0dva9V+U3pp1borL6YU71Y79ef
  JCY92Ogq5Ta85FurM5CXxs89QtmXd5/dSkyXGffM7lXpScknlio0B75tugCGBi4F7F8Jdlid4
  znZI/9gyTVC/fL+lVmlQ/hSdsZm1FdnZyoEdn1zvRv+uYJqvNuTVfN6a+74TV3hP7vjfu7kxk
  uDz7zcurM6OMzBqCjff3Bx79p1Ka5z2j49v9lI1vVooo76rKCxc2sf1qesjtxKxZn3bcnnPls
  WbwgXPOwdMWLlLibvx8e+fRKbvPThHc0h9dqf5ZyWP16bNPeT5skFViKc5INNRiLipOBACaOs
  WkuwMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-6.tower-565.messagelabs.com!1663137858!333528!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4763 invoked from network); 14 Sep 2022 06:44:18 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Sep 2022 06:44:18 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 65D121AF;
        Wed, 14 Sep 2022 07:44:18 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 5A13E1AC;
        Wed, 14 Sep 2022 07:44:18 +0100 (BST)
Received: from [10.167.215.54] (10.167.215.54) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 14 Sep 2022 07:44:14 +0100
Message-ID: <7fdc9e88-f255-6edb-7964-a5a82e9b1292@fujitsu.com>
Date:   Wed, 14 Sep 2022 14:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     Brian Foster <bfoster@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
 <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com> <Yxs5Jb7Yt2c6R6eW@bfoster>
From:   =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
In-Reply-To: <Yxs5Jb7Yt2c6R6eW@bfoster>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/9/9 21:01, Brian Foster wrote:
> Yes.. I don't recall all the internals of the tools and test, but IIRC
> it relied on discard to perform zeroing between checkpoints or some such
> and avoid spurious failures. The purpose of running on dm-thin was
> merely to provide reliable discard zeroing behavior on the target device
> and thus to allow the test to run reliably.

Hi Brian,

As far as I know, generic/470 was original designed to verify 
mmap(MAP_SYNC) on the dm-log-writes device enabling DAX. Due to the 
reason, we need to ensure that all underlying devices under 
dm-log-writes device support DAX. However dm-thin device never supports 
DAX so
running generic/470 with dm-thin device always returns "not run".

Please see the difference between old and new logic:

          old logic                          new logic
---------------------------------------------------------------
log-writes device(DAX)                 log-writes device(DAX)
            |                                       |
PMEM0(DAX) + PMEM1(DAX)       Thin device(non-DAX) + PMEM1(DAX)
                                          |
                                        PMEM0(DAX)
---------------------------------------------------------------

We think dm-thin device is not a good solution for generic/470, is there 
any other solution to support both discard zero and DAX?

BTW, only log-writes, stripe and linear support DAX for now.

Best Regards,
Xiao Yang
