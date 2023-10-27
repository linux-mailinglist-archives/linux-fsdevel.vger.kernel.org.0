Return-Path: <linux-fsdevel+bounces-1276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE07D8D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 05:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DFDB21433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92043D87;
	Fri, 27 Oct 2023 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QwpZrsQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082221FD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 03:39:01 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA11A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:38:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d11401516so1342589a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 20:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698377939; x=1698982739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MFgGxXvNH1IVbbEq5A6jp4J1ULe7/977xw27+McLJW4=;
        b=QwpZrsQ08rOzY7Yni6O9VQtQsxftPNeABVGthKkIIRlh+V2Kj9ToJFiIGiBXTYO4dW
         yWB271MPNjHUKYdc3CFgNHpiNiTuSt16v5GjS3EEerXWabEV8gCa0TvLhsnkulkF6afs
         MPe0J1Tpjxe9zwSpCJQ0OvsGmuP4DcXlvuAVE5OyaIBK7hATaWFyiIL3dY6hB/Ne2Jhe
         njdQfFw3RulDM5ylb29YmbI/7K78n3s7F5Dl1ywCxMqZ4P/R1YmfcDPlxrnxPdIphjGb
         OvQvNx4XjM1ycOwxpoMgFra1VrNcgjxvaEn5yhYgmUWcc4JG/MYWw4Pqa3DbkBe+NpJQ
         z49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698377939; x=1698982739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFgGxXvNH1IVbbEq5A6jp4J1ULe7/977xw27+McLJW4=;
        b=huHekwwQAq0DcBW3j4X5T4eE8EaW12Sc3k05HpZtEepJj62IYv9pf4eUFgXOL/1065
         f+CBHqor9m5tLwK2A9R3VSnDuAkxfA31uupHhO5h/AWLqexD45aCHnluZXCLPlQhmOcH
         qY88QM4+0wsRYqgioWvmlLlmoVeGz779qbErkTdSG6TduuPGH3qc8GMIapCZhlQfAJhi
         pis9kh98cPN7cjWOIiVo4K96V7xONJnEDlVSZluBMreZ2Q0iaAUEnn2xoHupi+SloX2t
         8Mej8FydBK7bgOvO0O5hfTt2lA3gIwZLAqjgkPaL0Ni7HnD97WEywvFtzkABVrvUEdyg
         Eahw==
X-Gm-Message-State: AOJu0YzBrbmwd7aPY471/wo52U8XL53wT6pYL0eFBNSw5QsIvYHYKeCQ
	deaNAdJBLLOtHEFwaKcdy70lgw==
X-Google-Smtp-Source: AGHT+IEEmEZXvlSfsc+xnqK4JaSioeT+GyhDkRyFZipkY36OlXg+1cEEFCqP5RPa0hVBvmajvf6Few==
X-Received: by 2002:a17:90a:fd01:b0:27f:ebfa:1112 with SMTP id cv1-20020a17090afd0100b0027febfa1112mr1401619pjb.5.1698377939105;
        Thu, 26 Oct 2023 20:38:59 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.38.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:38:58 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	willy@infradead.org,
	brauner@kernel.org,
	surenb@google.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	oliver.sang@intel.com,
	mst@redhat.com
Cc: zhangpeng.00@bytedance.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 00/10] Introduce __mt_dup() to improve the performance of fork()
Date: Fri, 27 Oct 2023 11:38:35 +0800
Message-Id: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series introduces __mt_dup() to improve the performance of fork(). During
the duplication process of mmap, all VMAs are traversed and inserted one by one
into the new maple tree, causing the maple tree to be rebalanced multiple times.
Balancing the maple tree is a costly operation. To duplicate VMAs more
efficiently, mtree_dup() and __mt_dup() are introduced for the maple tree. They
can efficiently duplicate a maple tree.

Here are some algorithmic details about {mtree,__mt}_dup(). We perform a DFS
pre-order traversal of all nodes in the source maple tree. During this process,
we fully copy the nodes from the source tree to the new tree. This involves
memory allocation, and when encountering a new node, if it is a non-leaf node,
all its child nodes are allocated at once.

This idea was originally from Liam R. Howlett's Maple Tree Work email, and I
added some of my own ideas to implement it. Some previous discussions can be
found in [1]. For a more detailed analysis of the algorithm, please refer to the
logs for patch [3/10] and patch [10/10].

There is a "spawn" in byte-unixbench[2], which can be used to test the
performance of fork(). I modified it slightly to make it work with
different number of VMAs.

Below are the test results. The first row shows the number of VMAs.
The second and third rows show the number of fork() calls per ten seconds,
corresponding to next-20231006 and the this patchset, respectively. The
test results were obtained with CPU binding to avoid scheduler load
balancing that could cause unstable results. There are still some
fluctuations in the test results, but at least they are better than the
original performance.

21     121   221    421    821    1621   3221   6421   12821  25621  51221
112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%

Thanks to Liam and Matthew for the review.

Changes since v6:
 - Add Liam's 'Reviewed-by' tag to all patches except for patch [3/10].
 - Modify the copyright statement according to Matthew's opinion.

[1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
[2] https://github.com/kdlucas/byte-unixbench/tree/master

v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
v2: https://lore.kernel.org/lkml/20230830125654.21257-1-zhangpeng.00@bytedance.com/
v3: https://lore.kernel.org/lkml/20230925035617.84767-1-zhangpeng.00@bytedance.com/
v4: https://lore.kernel.org/lkml/20231009090320.64565-1-zhangpeng.00@bytedance.com/
v5: https://lore.kernel.org/lkml/20231016032226.59199-1-zhangpeng.00@bytedance.com/
v6: https://lore.kernel.org/lkml/20231024083258.65750-1-zhangpeng.00@bytedance.com/

Peng Zhang (10):
  maple_tree: Add mt_free_one() and mt_attr() helpers
  maple_tree: Introduce {mtree,mas}_lock_nested()
  maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
  radix tree test suite: Align kmem_cache_alloc_bulk() with kernel
    behavior.
  maple_tree: Add test for mtree_dup()
  maple_tree: Update the documentation of maple tree
  maple_tree: Skip other tests when BENCH is enabled
  maple_tree: Update check_forking() and bench_forking()
  maple_tree: Preserve the tree attributes when destroying maple tree
  fork: Use __mt_dup() to duplicate maple tree in dup_mmap()

 Documentation/core-api/maple_tree.rst |   4 +
 include/linux/maple_tree.h            |   7 +
 include/linux/mm.h                    |  11 +
 kernel/fork.c                         |  40 ++-
 lib/maple_tree.c                      | 288 +++++++++++++++++++-
 lib/test_maple_tree.c                 | 123 +++++----
 mm/internal.h                         |  11 -
 mm/memory.c                           |   7 +-
 mm/mmap.c                             |   9 +-
 tools/include/linux/rwsem.h           |   4 +
 tools/include/linux/spinlock.h        |   1 +
 tools/testing/radix-tree/linux.c      |  45 +++-
 tools/testing/radix-tree/maple.c      | 363 ++++++++++++++++++++++++++
 13 files changed, 811 insertions(+), 102 deletions(-)

-- 
2.20.1


