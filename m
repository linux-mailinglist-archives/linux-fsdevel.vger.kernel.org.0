Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3906D5216
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 22:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjDCUTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCUTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:19:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913F3586;
        Mon,  3 Apr 2023 13:19:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E05D5C0081;
        Mon,  3 Apr 2023 16:19:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Apr 2023 16:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680553143; x=1680639543; bh=Pt
        E34Mi5e7fcyqY/yn1ZOTjs4FeBAcshGnyuLTQZvAU=; b=B9s/caMaukwcV+M6dZ
        kL9rfGdE67qmnEh6DZ+AUJ55B1lwYnKkiaFZvFvxWifT6Qeb1s+1Qzsdmuhybud9
        yEJBjwhl17/yloWHzzlfAv0RE9u/jJDvDsBPxlC3V/+RtFzChmK/Iew9OQXh+BnW
        vTvWyK6zGm2BkJ3cYwL/+pUM0bq2Q/612wWE9WO7Y8w7gx1bxVRfySjBY8ffm+2S
        ouTUAk1Df/BVj5cSdbAM3AJY67x4h7boC1NsLkdywmHS5e/oU/GBeCPrrA795zDu
        mVP7OA8dK3cDuGuXOCDx9ca+E4uiXThMzuwRIeF+5edpSmRg7vFYqsxfu4jyB/j7
        HY4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680553143; x=1680639543; bh=P
        tE34Mi5e7fcyqY/yn1ZOTjs4FeBAcshGnyuLTQZvAU=; b=hdQl9dH6VQ/26IqYX
        DLyWdDnhElnsE5R5dMTtqP9vEPsjctti3fMutSNYYpRDF6z4WAhpyOlLdqQR/y5Z
        xko0rDzCgzEgEh/VJwcwic9W9BvKECkYWUtgNXga7PhLmmQUFPmi0LC5kx6zvKlX
        1q18Xnd7DIGG0EupwueU/TfD14QpewPnBuxdDStvScTEMTYwylClaaoqhqvvJ/o2
        9rLR0o+Q1ksTidiE0O+b+/7jCIzNyYaI/CLOfG5Gt6AJaT+HqXYBkhxzxzPOSGrU
        gE+Kd3Bjs59c9LjTGyD/ArDHxMJ9XS4JJwvMONKrytkBORXYOG7b4UYyTpZGs09T
        c9qqA==
X-ME-Sender: <xms:tjQrZMN2gja3Oe5fG7-mKFH26_rU4ABTH8Q8XFg3Ck9OnfER9W4oLQ>
    <xme:tjQrZC_f-UlcEhOO_rDCm_iS505hYekLK2Zf-fCS-sCnqzfQbnplx4ovSgHPkjwz5
    LSwwIhAXiai0kghVw>
X-ME-Received: <xmr:tjQrZDSZnHaRL67rW-lUftdyWfADOJRfA1FfRjBBBdyyuA5oafyJ4s_MGAFYyU_aiqE_iiWzJfyOpWzU1pRTsEiuQLOf_pc8DYLYOombcgwPZEoP1sZydDOAOh8N5rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepvdeiue
    dthedttdfhgeevkeeuveefvdeuheejledtvefgjeetkedugfdvleevkeffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:tjQrZEtfJcvkWMD1pazyxNcS_IWGnXUBPXziAvubh5OtKHfW1FDfzw>
    <xmx:tjQrZEe57jG9TosSu5qJGEMlrRhJ_YJ34dLFONQ3XnLt7WdtamoInw>
    <xmx:tjQrZI1JdZ2HM4jBSSaFS1pAii6POwCAZdUJHbdghkb-6LtWKPJbxA>
    <xmx:tzQrZD-dvR3Mok-Pdf0cwl473T7rMI5nUHfW4RMNGwangipgprf2hg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 16:19:02 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/7] Split a folio to any lower order folios
Date:   Mon,  3 Apr 2023 16:18:32 -0400
Message-Id: <20230403201839.4097845-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
and uses it during file folio truncate operations.

The patchset is on top of mm-everything-2023-03-27-21-20.

Changelog=20
=3D=3D=3D
Since v2
---
1. Fixed an issue in __split_page_owner() introduced during my rebase

Since v1
---
1. Changed split_page_memcg() and split_page_owner() parameter to use order
2. Used folio_test_pmd_mappable() in place of the equivalent code

Details
=3D=3D=3D

* Patch 1 changes split_page_memcg() to use order instead of nr_pages
* Patch 2 changes split_page_owner() to use order instead of nr_pages
* Patch 3 and 4 add new_order parameter split_page_memcg() and
  split_page_owner() and prepare for upcoming changes.
* Patch 5 adds split_huge_page_to_list_to_order() to split a huge page
  to any lower order. The original split_huge_page_to_list() calls
  split_huge_page_to_list_to_order() with new_order =3D 0.
* Patch 6 uses split_huge_page_to_list_to_order() in large pagecache folio
  truncation instead of split the large folio all the way down to order-0.
* Patch 7 adds a test API to debugfs and test cases in
  split_huge_page_test selftests.

Comments and/or suggestions are welcome.

[1] https://lore.kernel.org/linux-mm/Y%2FblF0GIunm+pRIC@casper.infradead.or=
g/

Zi Yan (7):
  mm/memcg: use order instead of nr in split_page_memcg()
  mm/page_owner: use order instead of nr in split_page_owner()
  mm: memcg: make memcg huge page split support any order split.
  mm: page_owner: add support for splitting to any order in split
    page_owner.
  mm: thp: split huge page to any lower order pages.
  mm: truncate: split huge page cache page to a non-zero order if
    possible.
  mm: huge_memory: enable debugfs to split huge pages to any order.

 include/linux/huge_mm.h                       |  10 +-
 include/linux/memcontrol.h                    |   4 +-
 include/linux/page_owner.h                    |  10 +-
 mm/huge_memory.c                              | 137 ++++++++---
 mm/memcontrol.c                               |  10 +-
 mm/page_alloc.c                               |   8 +-
 mm/page_owner.c                               |   8 +-
 mm/truncate.c                                 |  21 +-
 .../selftests/mm/split_huge_page_test.c       | 225 +++++++++++++++++-
 9 files changed, 365 insertions(+), 68 deletions(-)

--=20
2.39.2

