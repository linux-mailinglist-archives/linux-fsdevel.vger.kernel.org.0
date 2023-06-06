Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADA724C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjFFTEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbjFFTEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D310FE
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 12:04:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56561689700so105699757b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078258; x=1688670258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4awdlrIAeNpwHVWeIID1BUVh8RCTYusTWiK5XfdHg+o=;
        b=EM6Va8BzGwCED0zIh64Bnjix1yyjlAzWk5b48JtiXuhP31W1mbMccgQlZPFYy2Rc8v
         tMovnZrmg6i3waIkF808VpF/dEtWacRQ+yv83fbRyzUMvkWnAQduvEvPNXK1sSt1N2Cy
         PtYuLHfMT8qcUe5nsKygK7f4ppJDBYrYq77vKTy6tbx4tH0TKa3ANgH0owgHfn5b1Tx1
         OI+RAo/8et/7ti+hO4SSDEjjeJCABpVM+ohklHFBBqTgC2zed5wK6sgfxTCj5lcV8B7r
         QzmY/WCfEZ0p/5xV7lrrRx2FQaR4Eg7AC1b0TCHXbKQd5gKgaSLxDQ+6klKWy+rQ6YtV
         ePmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078258; x=1688670258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4awdlrIAeNpwHVWeIID1BUVh8RCTYusTWiK5XfdHg+o=;
        b=BDmphzuZlL0F1BIeA6iPCMpc8g2G9j+44avieoMXnodMqXaUyJjiuQRLWtUD3GKVia
         yKQoRffgPQzawZJqZNsbXD5diWAAVrcXcD3y0Y1EUxX3fLstRcmt/K/02iM+u2KzKNL2
         rA/unkBcMx8f1f0hmiLOtL4k6hGyzk3w2PrZHSfXKOd2ox4XDEQeZwaQblGODOMxSADs
         a5a74WJurCaXYCsz+Clz0zAS2lMTzbKIzXxWjx1XLq/3Cg81rSv5M6HDRnYHswrHaLAy
         +KhjOCpVFZL8sDhX2XMDQspCp9hd//k6xsE3muO4JfoXvH4beNN2S7yBOmDQewreK4Du
         IL7w==
X-Gm-Message-State: AC+VfDxlZHovQS6X/dYo6UGqwfXTvFPp0dDvYh6QRksntsbloTAdjp42
        305YYdYArSeTjcFQYTe8c3xreAIntuelRaP0gg==
X-Google-Smtp-Source: ACHHUZ7qnoxO8i1wmNBAi7fatM+eI5rwKFB4S/AWZNBrdb9BhmqSWgFoaD3eNX27zoBKSk99WIOAutKPR4Hz0jbmxQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:10c8:b0:ba8:797c:9bc7 with
 SMTP id w8-20020a05690210c800b00ba8797c9bc7mr1725260ybu.11.1686078258501;
 Tue, 06 Jun 2023 12:04:18 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:48 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <0ae157ec9e196f353ecf9036dbffdc295c994817.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 03/19] mm: hugetlb: Expose remove_inode_hugepages
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TODO may want to move this to hugetlb

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 fs/hugetlbfs/inode.c    | 3 +--
 include/linux/hugetlb.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3dab50d3ed88..4f25df31ae80 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -611,8 +611,7 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
  * Note: If the passed end of range value is beyond the end of file, but
  * not LLONG_MAX this routine still performs a hole punch operation.
  */
-static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
-				   loff_t lend)
+void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 023293ceec25..1483020b412b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -259,6 +259,8 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void hugetlb_zero_partial_page(struct hstate *h, struct address_space *mapping,
 			       loff_t start, loff_t end);
 
+void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend);
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
@@ -470,6 +472,8 @@ static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 static inline void hugetlb_zero_partial_page(
 	struct hstate *h, struct address_space *mapping, loff_t start, loff_t end) {}
 
+static inline void remove_inode_hugepages(struct inode *inode, loff_t lstart, loff_t lend) {}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
-- 
2.41.0.rc0.172.g3f132b7071-goog

