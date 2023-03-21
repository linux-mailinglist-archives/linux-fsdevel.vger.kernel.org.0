Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72A6C267C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCUAs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCUAsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:48:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF772113FB;
        Mon, 20 Mar 2023 17:48:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DAE775C019B;
        Mon, 20 Mar 2023 20:48:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Mar 2023 20:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679359729; x=1679446129; bh=oG
        kjK2TbqrODiZ27bwpufFy80dPhzmLH1tKePfQCcsg=; b=v2FnbI7Rk9K6GPSwoV
        xTFz47m9B3DRkVgQxdK6L5tpwV54Pkk7nXPDW8hO9SqjDMl1ZpssfT6uEk2Yrbnj
        95keebwa6R3FM4Pf/+d9dgLdWAhDmVitG2jRZLxpi4Fj9X2ICuP9iusyKQv0yjdV
        vy6xo2bGVmW2P9VxdwPsscbPDhoLYU4CrDQS9TRgNrj1bs+YmyjAYIfVFNyHwbdN
        PTjHUe5eyOqJdy5/nDUl2mESU2Nj5bSt8b7fGgACtHwaf+DfXEeltmX7FpBE23oS
        GF6nRFzvAOu0tobGk2qS0ijszzwi7x63ONxjyyVMfRQUr1ZGxwmrJfkEaoum/gBk
        EJgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679359729; x=1679446129; bh=o
        GkjK2TbqrODiZ27bwpufFy80dPhzmLH1tKePfQCcsg=; b=DzX6tcpSYSk9j7QHV
        +EMwBA/10OxE8TVWLr6K+huXm9MJ53Bi6IxUgPIubvFX74ivmSImfisv3iXPZAIs
        uVJo45bg4cO2YTOSRzkZXiBSFQkiuPYjDsuJORjml0Bs/fO+u16RAic6UHbGuIK8
        BkW333wARlfN/fCdjK1KeJS4UPSDYszqbsUqyVNcOBm47PQqJt5HQ5R5oQ0k9DYJ
        PQi1X64ymp6bOKP4HS60cIr/T/k1jeklixqZaPsRpz3ERurcT93fmsn/uPNkRrp6
        g1aKzOcYnI9aUdBrHnAqfYGDjCz8DWeeaAA3vEqEzL0U1fyFK9/gNbyplQlRoCOl
        HIjEA==
X-ME-Sender: <xms:8f4YZHEziw9O6xYv0zVNgw6T5KNDv0jZBP24KUVax6_f9c5kAOVfeg>
    <xme:8f4YZEWJnmADW3GVHsM-lq3Vo3ymhF2A5ylT2oDxdljkzUTMifyYFQgJSHIvbEiyu
    80JzBBlGIQ-yF2kTA>
X-ME-Received: <xmr:8f4YZJLI0Osvud0r1x7HmlmDU62gVviQcZlTvhZYd3HoWJtkmTk9c3XWmof7ouDsB8OVe8VMGG6kInjngkkp5PnWUPnpyYQ3mjJjFNNc7tryYJpBTpcDMbztK2E8_Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpedvieeutd
    ehtddthfegveekueevfedvueehjeeltdevgfejteekudfgvdelveekffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:8f4YZFH-k8MiCb1AZT43rTC3Iusm4DYChWfdn1O7rbkLHccCwp98ew>
    <xmx:8f4YZNXSbymnOShVpJgEw9q3xgk_qPF3ltqHwPv9n39b64mXlJys6A>
    <xmx:8f4YZAO_Sq9MbNIpY2wSkutSGsqo8wyNv-YovTm2jWWDtazPhbQ6rQ>
    <xmx:8f4YZJr5alsmT1CNYtBtsUXuZPnPu-aGkmIpZ0HUUWBoQeT4MVhU6g>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 20:48:49 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] Split a folio to any lower order folios
Date:   Mon, 20 Mar 2023 20:48:24 -0400
Message-Id: <20230321004829.2012847-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

File folio supports any order and people would like to support flexible ord=
ers
for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
page to order-0 pages, but splitting to orders higher than 0 is also useful.
This patchset adds support for splitting a huge page to any lower order pag=
es
and uses it during folio truncate operations.

The patchset is on top of mm-everything-2023-03-19-21-50.

* Patch 1 and 2 add new_order parameter split_page_memcg() and
  split_page_owner() and prepare for upcoming changes.
* Patch 3 adds split_huge_page_to_list_to_order() to split a huge page
  to any lower order. The original split_huge_page_to_list() calls
  split_huge_page_to_list_to_order() with new_order =3D 0.
* Patch 4 uses split_huge_page_to_list_to_order() in large pagecache folio
  truncation instead of split the large folio all the way down to order-0.
* Patch 5 adds a test API to debugfs and test cases in
  split_huge_page_test selftests.

Comments and/or suggestions are welcome.

[1] https://lore.kernel.org/linux-mm/Y%2FblF0GIunm+pRIC@casper.infradead.or=
g/

Zi Yan (5):
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages.
  mm: truncate: split huge page cache page to a non-zero order if
    possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |  10 +-
 include/linux/memcontrol.h                    |   5 +-
 include/linux/page_owner.h                    |  12 +-
 mm/huge_memory.c                              | 138 ++++++++---
 mm/memcontrol.c                               |   8 +-
 mm/page_alloc.c                               |   8 +-
 mm/page_owner.c                               |  11 +-
 mm/truncate.c                                 |  21 +-
 .../selftests/mm/split_huge_page_test.c       | 225 +++++++++++++++++-
 9 files changed, 368 insertions(+), 70 deletions(-)

--=20
2.39.2

