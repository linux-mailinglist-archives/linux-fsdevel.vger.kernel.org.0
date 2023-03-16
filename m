Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864776BC283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 01:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjCPAbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 20:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjCPAbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:31:15 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B68A219F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id m9-20020a056a00164900b0062300619e03so163969pfc.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 17:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926672;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hT7y2XaFexWW4GTLeQpLaRg79NNFfwA0Go2glRLgBd0=;
        b=Nz5kUB5UsktVLM+1ioYn0/f+EE3tG8bYDmBZ7k4J/Gt/p5gTfQtvXXnoIclpQPuDya
         iUSZv4Ya8c29iPtlOA7O8kWfsasypPc8z6XfRhbOcsmBwYKUvOolqz9fQyk7NgQiLh/7
         c/HaSbFKMHr9gsoqPFgvukhunTri9uzxM+/T1bb2dlQR9ihIBftzfIgbbB2EA9ig0QfN
         QH/Qst7Frnk64y0MYkI8/9p+OMNZJnbfWHBkKL+LoqwoHnfU22JRu1wnbHr5/KauoW4g
         wseQ2RJb2qNMKAO2J1HN6p/Ws+7+zkBAtzloNtEG5key9qZ2BL1aJc7RLJD21ClZZS8U
         CQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926672;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT7y2XaFexWW4GTLeQpLaRg79NNFfwA0Go2glRLgBd0=;
        b=rC317eOMEVHPXH9MeMSJbvlszHJ93ZuCoQXwhQaCJID1VvaHk7KUdr8DlJHMOC8rjH
         0ZDNmWqajYwijH8stF3HTRrKw1D7TuoftAjvl19juULBH5p9TzD+5OujUMPNEYytI4y0
         iw/RKk1meTO8NYf5+3VqRpEyQowtrCZna7XJLglwOJ0fNofvQ9BwLlxBnKQuTbt0+ICd
         UPoG1lL8QQjo7ejPlfoh4A8iZI3qUZgVBrF4AU0+RECp34dwsQ2CXd1ArjWJum84ESjO
         gHxNodE+SEtSWgPtC3ekqFtjb6orpMO0vUf+f54zTV7Eokxc7DDDbPz7JdTyvjI/NMyo
         yH1A==
X-Gm-Message-State: AO0yUKU5LvEaPCeA25iEtPofj8TBgXfdjuY5372IfBr7Z6jwtJq10Ec9
        L2BBF4YhbfkIp9tP6buaq1bGKOR2P8GJJD4wgA==
X-Google-Smtp-Source: AK7set8RzBYOsHbOBr2r5L/IBVJur+dXP5lqulE2m7qrJjHyB4MEFVa/vv90/0ZD7J2Luh92QLgQMrMQJM0g7dhFsw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:ea89:b0:237:2516:f76a with
 SMTP id h9-20020a17090aea8900b002372516f76amr548955pjz.2.1678926672510; Wed,
 15 Mar 2023 17:31:12 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:30:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <cover.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 00/10] Additional selftests for restrictedmem
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This is a series containing additional selftests for restrictedmem,
prepared to be used with the next iteration of the restrictedmem
series after v10.

restrictedmem=C2=A0v10 is available at
https://lore.kernel.org/lkml/20221202061347.1070246-1-chao.p.peng@linux.int=
el.com/T/.

The tree can be found at
https://github.com/googleprodkernel/linux-cc/tree/restrictedmem-additional-=
selftests-rfc-v1/.

Dependencies
+ The next iteration of the restrictedmem series
    + branch: https://github.com/chao-p/linux/commits/privmem-v11.4
    + commit: https://github.com/chao-p/linux/tree/ddd2c92b268a2fdc6158f82a=
6169ad1a57f2a01d
+ Proposed fix to adjust VM's initial stack address to align with SysV
  ABI spec: https://lore.kernel.org/lkml/20230227180601.104318-1-ackerleytn=
g@google.com/

Ackerley Tng (10):
  KVM: selftests: Test error message fixes for memfd_restricted
    selftests
  KVM: selftests: Test that ftruncate to non-page-aligned size on a
    restrictedmem fd should fail
  KVM: selftests: Test that VM private memory should not be readable
    from host
  KVM: selftests: Exercise restrictedmem allocation and truncation code
    after KVM invalidation code has been unbound
  KVM: selftests: Generalize private_mem_conversions_test for parallel
    execution
  KVM: selftests: Default private_mem_conversions_test to use 1 memslot
    for test data
  KVM: selftests: Add vm_userspace_mem_region_add_with_restrictedmem
  KVM: selftests: Default private_mem_conversions_test to use 1
    restrictedmem file for test data
  KVM: selftests: Add tests around sharing a restrictedmem fd
  KVM: selftests: Test KVM exit behavior for private memory/access

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  46 ++-
 .../selftests/kvm/set_memory_region_test.c    |  29 +-
 .../kvm/x86_64/private_mem_conversions_test.c | 295 +++++++++++++++---
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 124 ++++++++
 tools/testing/selftests/vm/memfd_restricted.c |   9 +-
 7 files changed, 455 insertions(+), 53 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exit=
s_test.c

--
2.40.0.rc2.332.ga46443480c-goog
