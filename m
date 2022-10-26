Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670160E686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiJZRbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 13:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiJZRbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:31:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E04DFB7A;
        Wed, 26 Oct 2022 10:31:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so984287pjd.4;
        Wed, 26 Oct 2022 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KEX8H9AH+VpJzTG5dP3lIPlij9N0zbSJwy+i7UPqHg=;
        b=cGCfgC4hjmQQkF1Pxvr7cLXhW9PwDG011Q1yYpkKlGkU1OdLX/EXJIuLnwqbTCMenA
         qQcxLWZcGJwon4OZ/EY7D/3JZcT+CmJYRc+SMzVP+aoV5fpH0LlOcHeQ5Rvu5/TVKZfu
         7zs0vqSrqvQhdjoUVr9e4w8kyQepA7Bh73nOUhsTf8dbXvD5yNraTKvL9vXLLNDXcIk3
         PFw+FqKwfN6Qkd1BQoOhVO/0zCAaQKI7rU5r6TuvH7WyVvQZUdOUIhL0305Fdfo6F+7N
         bwu2wgky+pRe17X5czHVGnuD+R53XZYyqR79oq0bSJ8jTMTnfmqG7ITY+PjsZzrUcEcH
         Fu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KEX8H9AH+VpJzTG5dP3lIPlij9N0zbSJwy+i7UPqHg=;
        b=7ypswvZG8t3K3PB90TPAMabnAdWl5E0oLmOqVH3DSCT1QnzC06x4zCL9lvG+p9sw7M
         jBNpHfNpmIoMS2g8eahVdn/bFZ+lo5TExu5S4ozhHF3uoiZDzoTfoblKdqa/DKj1l58u
         jjtJ1I9bDL8+cBR53lNTWlL6y5MLt1eHfkkyeCaw02gervxnGMGZrOG7QTo9beXHA8eD
         0wMyMSRK8Ywk993blLmcHxmA7ftCeTGOyaiilTWtUR8pBqhqed9SjpSmtMNFAjDC8EAn
         bLaia/25LHdatSeHU4GftXCW8hea2qJH7awPCuyiWZ90Wn7BXzRW3Wjpr4cHhkBw2xNX
         pAJQ==
X-Gm-Message-State: ACrzQf3PcyQPtIDlE1XGDQwS4jJybPeYw+eZg5x/JOb9/1V3pAODpJk1
        3TA1zWwaPCGTxB0N706UMmw=
X-Google-Smtp-Source: AMsMyM5iyIsTFBeWCWiI/ZizQ3W6VbjiybP1poF7CjbEgG2VkVSvkP2kgtm+tVjWT4X2rpwsf2fFIQ==
X-Received: by 2002:a17:902:6542:b0:172:95d8:a777 with SMTP id d2-20020a170902654200b0017295d8a777mr45124260pln.61.1666805507753;
        Wed, 26 Oct 2022 10:31:47 -0700 (PDT)
Received: from localhost ([192.55.54.55])
        by smtp.gmail.com with ESMTPSA id y7-20020aa78f27000000b0056c814a501dsm436498pfr.10.2022.10.26.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 10:31:47 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:31:45 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        isaku.yamahata@gmail.com
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221026173145.GA3819453@ls.amr.corp.intel.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:13:37PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> +int restrictedmem_get_page(struct file *file, pgoff_t offset,
> +			   struct page **pagep, int *order)
> +{
> +	struct restrictedmem_data *data = file->f_mapping->private_data;
> +	struct file *memfd = data->memfd;
> +	struct page *page;
> +	int ret;
> +
> +	ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);

shmem_getpage() was removed.
https://lkml.kernel.org/r/20220902194653.1739778-34-willy@infradead.org

I needed the following fix to compile.

thanks,

diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index e5bf8907e0f8..4694dd5609d6 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -231,13 +231,15 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
 {
        struct restrictedmem_data *data = file->f_mapping->private_data;
        struct file *memfd = data->memfd;
+       struct folio *folio = NULL;
        struct page *page;
        int ret;
 
-       ret = shmem_getpage(file_inode(memfd), offset, &page, SGP_WRITE);
+       ret = shmem_get_folio(file_inode(memfd), offset, &folio, SGP_WRITE);
        if (ret)
                return ret;
 
+       page = folio_file_page(folio, offset);
        *pagep = page;
        if (order)
                *order = thp_order(compound_head(page));
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
