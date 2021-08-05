Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF633E1BFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhHETEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:12 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36613 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242166AbhHETEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:06 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 83F4A5810B7;
        Thu,  5 Aug 2021 15:03:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 15:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=zNBa+DPw6skCL
        5zqb415g/XSwtRXkYRjfljqWc0rqOw=; b=DyQb67WDvRtWM6HaUooUM/LJ7FBVe
        RHKFGNkJpgMc/hVEhEU3bBY0j9e1ACpLPdzYhMBgcjDe25DJVAzXtC8OyYQaCVVT
        DVkY8uIRXHprEmZd7qBlwTwWuaxBZ9hOYHN4GMeCh1CiCofOD28h/6oouXhqIR0t
        oKln8pn7sD+jD8rKJ0OfZcRP17juq9szZlAFNHgLyTc/QAno4D+VnlxhSsuynNfP
        61sbW9SZYU5psQ4GG81DYucrG+Xv1iJYadVgCmDdHfkO6F3fiRucb/vyijDk16O9
        /Tu4nUObFASN79yNgjfLeDeMHRAtJC2KV1GiUeMazMZWkFNAisJysmBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zNBa+DPw6skCL5zqb415g/XSwtRXkYRjfljqWc0rqOw=; b=gWQXO1i0
        jN0W7VaDRO9ZJs7svTKOs6Zt3cVW8ykYAN5L20lmCsOwVLSyKKEZwcwAy8VLeDO+
        +cKpfta9nOpdlS3fPnazuUW3DIx4T86hKG9WnNFqjnCwKTmzfFsvE9oh/Mdk21IY
        ZVbWKhhb5FA53N0Ec0CWeZHZKCmTAAiFT07RnyvlxwVi6mE/6AZGO8VqkOWJuOan
        ijipS8ZISTZ+UgBOT8KfSFZxVWMUbObBRGAXGyM93Vp8IG6cNc/lcud6npqT4vDF
        sQHBgCvQgM9uEJk8sIkfHmI/yaEFNhrihPBkIuGmwTxRC6bG58BsFou2qiW9cT3Z
        UG97Hfi+X2S+MA==
X-ME-Sender: <xms:FjYMYWW4oxNHvU7lI9eRIpHTG09e0c1my46csr1FG6tiDZEgWRK3Ng>
    <xme:FjYMYSldck-jKxeuI4jDQIm-p7e-gf_xoiLpMP2QCv3kTflx-f9AKry1liyYwnNQu
    9UzwjhwjbNzQdtY0w>
X-ME-Received: <xmr:FjYMYabYkPq_xiag4riYUMLB3Rzd6rBLmmCuas3wkTxJWcq_klWVrjKCvcT3p-Td0tjAhhf->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:FjYMYdXOPMQeHnQByY3au_gzNEx7nTJIcu47Ewhok_eBMOBld7rgag>
    <xmx:FjYMYQkzV85mgqK4o_O-z-OHWrPy8bM9RR-q2VsmdhktdC0XgAZw5Q>
    <xmx:FjYMYSdtLY7nyjI8pkKPgaNOIjJxast0TW71rRW0fFrj-Szwapk43Q>
    <xmx:FzYMYekZVBc0z-UMbrmd-RymDusXtIvlcGjmK4G8K2deWYBaunPf1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:50 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Ying Chen <chenying.kernel@bytedance.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 08/15] fs: proc: use PAGES_PER_SECTION for page offline checking period.
Date:   Thu,  5 Aug 2021 15:02:46 -0400
Message-Id: <20210805190253.2795604-9-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

It keeps the existing behavior after MAX_ORDER is increased beyond
a section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Ying Chen <chenying.kernel@bytedance.com>
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 3f148759a5fd..77b7ba48fb44 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -486,7 +486,7 @@ read_kcore(struct file *file, char __user *buffer, size=
_t buflen, loff_t *fpos)
 			}
 		}
=20
-		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES =3D=3D 0) {
+		if (page_offline_frozen++ % PAGES_PER_SECTION =3D=3D 0) {
 			page_offline_thaw();
 			cond_resched();
 			page_offline_freeze();
--=20
2.30.2

