Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97771724C7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjFFTHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbjFFTGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:06:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870A10F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:05:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b878so10281308276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078284; x=1688670284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xVPr1dIpnxklN0GMh0WV40gxjr+XB/duCXqFm/4Eedk=;
        b=OpWI8RPhFgIw5MoV+RS2cmQpFpGPXsQqq6sU1K61/owOmBB1Ql0+w7FJ3nZldnf8p9
         +qYBb0NtRqwQu8dWDMwOUTG0ATZVJvom27ARS7xgWW5TfboiScGSMfZ8N45qzVKLAY2H
         4CU726nNQYrYfpWC/qzLp0r9J8us1SCC2lEqZrYJr9OdHyFq/TUwds9iZNdlTcobAHRr
         ZZALUwW7mEujbc7yxykj2/g4xPWE/5QaSH6KTAlpAQ02/2PJYX27kEua6tRoLiCjwPDV
         pyCH4FFtF/i8mbhld01B2RuTsSf6teTynYWziBlTcigs4W2oRa0ZqtYf/T+WFi+IMehY
         DIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078284; x=1688670284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVPr1dIpnxklN0GMh0WV40gxjr+XB/duCXqFm/4Eedk=;
        b=b+FujZSPDY/Sh0KRK455cK6ijAqJiVPmWL5Xb9IuOoO9/aKBFwSReWWivKFn3WShgS
         kPelpBBh7jrrTgVgal45ttLBxFYce/94geAczZDpyRfiW+KSMS/TtFohgoDFb67PdGBW
         dAdctFEhXchetQ+7/v0CiM3/hYRE+0/l41xXwfFhEmMu4nKYzlF2nvN7X3l5lygtAV+V
         BnyAC/bcVDGGbSiDufTiav+wjN2Kvxn3NzptAlAqBHGmQPTUv9mDPyaxZZkU18qKezRu
         SmcyrbPT+iZdRvxxN9pX5Z/VUafZzit+4Fb8PF6RdZEDDpB/vogOBMDzsoFQJTIqMbPV
         xhKg==
X-Gm-Message-State: AC+VfDyLJzcwALWyBfHdOqA9f+HTM3Wk/9zNh0fhHV1tVz2Rbja0z6dl
        8EMxW4Hnunz8X8RjEsVpKyxpr7h0pOixbYadMQ==
X-Google-Smtp-Source: ACHHUZ6iw5MaJvx6Biay/guXDPe54wqyOEjmtoFNQ8eDgpYM8NsdWofxvbuGdqaNO+FVNrUBL1ysZvJNR4qrxfEOBQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:72d:b0:ba1:d0:7f7c with SMTP
 id l13-20020a056902072d00b00ba100d07f7cmr1128681ybt.2.1686078284464; Tue, 06
 Jun 2023 12:04:44 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:04:02 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <2b26bcc8b10f8a11e6405d4cea5f1235e82e83c9.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 17/19] KVM: selftests: Add basic selftests for
 hugetlbfs-backed guest_mem
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tests for 2MB and 1GB page sizes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 059b33cdecec..6e24631119c6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -90,20 +90,14 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }
 
-
-int main(int argc, char *argv[])
+void test_guest_mem(struct kvm_vm *vm, uint32_t flags, size_t page_size)
 {
-	size_t page_size;
-	size_t total_size;
 	int fd;
-	struct kvm_vm *vm;
+	size_t total_size;
 
-	page_size = getpagesize();
 	total_size = page_size * 4;
 
-	vm = vm_create_barebones();
-
-	fd = vm_create_guest_memfd(vm, total_size, 0);
+	fd = vm_create_guest_memfd(vm, total_size, flags);
 
 	test_file_read_write(fd);
 	test_mmap(fd, page_size);
@@ -112,3 +106,24 @@ int main(int argc, char *argv[])
 
 	close(fd);
 }
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	printf("Test guest mem 4K\n");
+	test_guest_mem(vm, 0, getpagesize());
+	printf("        PASSED\n");
+
+	printf("Test guest mem hugetlb 2M\n");
+	test_guest_mem(
+		vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_2MB, 2UL << 20);
+	printf("        PASSED\n");
+
+	printf("Test guest mem hugetlb 1G\n");
+	test_guest_mem(
+		vm, KVM_GUEST_MEMFD_HUGETLB | KVM_GUEST_MEMFD_HUGE_1GB, 1UL << 30);
+	printf("        PASSED\n");
+
+	return 0;
+}
-- 
2.41.0.rc0.172.g3f132b7071-goog

