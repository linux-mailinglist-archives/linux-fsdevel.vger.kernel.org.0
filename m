Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DBD4D3E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 01:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiCJAlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 19:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiCJAlg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:41:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB25125516
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 16:40:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso5426944pjc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 16:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzBwZmXuL2mtDGId2fRGQ9cdH48yHESLY1EUls+Y0mA=;
        b=3fblK4Lx9eyAfaGQJ50OJygXLr3+yngV/09AYMG9DMOQXco1UvGBl0AA0tGjTcpBuL
         qHt6ZCzQlf8sISB0V93pZihkUafr9czsnHqjVeIJB64e7Odk4gEDbBLGV7HMcnb4CNqe
         2ZNlLK9eCP8cYoVJIeqOzgqErWYFpZzaGGpTl6YSYDkjL3SmiSahCh+xtHEDjO0njdJK
         1yi1kqR3uM1lGNvzVBUU6G3FKCEUFo9CWrmmN/lwTOnG6fRdAzpVscQ6LsXIDFtDZ9nk
         89nyYEbe1yTf8OUZXOg10LSsxznBJiSXMT/KFTyNyCSDq5UlCiSA4eUHry3XcY/oaIw4
         Fcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzBwZmXuL2mtDGId2fRGQ9cdH48yHESLY1EUls+Y0mA=;
        b=hJgH3+Nn5eab5ygmTv0bUhfKDnrah2bJDgr8QQTUOJUwFj+wOrlmuV7rGu5ubXrRiM
         nDbcixRGgPHlPXr1uIFeYTMUxUuAlEk3MdOpJBiJ28CfxPINJBfhQxXPHHjcu0CizYmD
         ThtQANS5nIkFCxUIG8Cs2ilpMG6qbI6Ntb4GGtADobszMkPgHwyPgCF5bkuWLLx6vveh
         iIfVjXN5ffKD5aZXcIwaiR8bTi+o/YCzzGdYfjMlHpz6j1S/C+RSTTEotowBBc1xt5/t
         7w9gwvU86E6Z6bFRLDpvpWUFK/XhpbYP5SpRWvn2X0T8H8BGJNLBZp05SK470QfOmSg1
         7OUQ==
X-Gm-Message-State: AOAM530ywgQ5s9afSlAJh/6o1L8lWZAYdQSf27iTkCsL64eIbQgjIOUR
        20rjLPjPdZnSj7QMleH78iI6oVvH0b3oapGTGXUiLIRqHtI=
X-Google-Smtp-Source: ABdhPJwFz17SQgb4pCOtnBdy5++/qwKC6LSIgtrRreuv2Nn2kEZn09A8yZqo+ZyLEO0m2rhpRcsK1XX++GWIEmAQt2U=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr2235610pjp.220.1646872836330; Wed, 09
 Mar 2022 16:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com>
 <20220302082718.32268-4-songmuchun@bytedance.com> <CAPcyv4iv4LXLbmj=O0ugzo7yju1ePbEWWrs5VQ3t3VgAgOLYyw@mail.gmail.com>
In-Reply-To: <CAPcyv4iv4LXLbmj=O0ugzo7yju1ePbEWWrs5VQ3t3VgAgOLYyw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 16:40:25 -0800
Message-ID: <CAPcyv4hSg8tZdKSxZtk_iqm=8h-iVyWA_Qj+aqL5aEddnsXEDg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 4:26 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 2, 2022 at 12:29 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The page_mkclean_one() is supposed to be used with the pfn that has a
> > associated struct page, but not all the pfns (e.g. DAX) have a struct
> > page. Introduce a new function pfn_mkclean_range() to cleans the PTEs
> > (including PMDs) mapped with range of pfns which has no struct page
> > associated with them. This helper will be used by DAX device in the
> > next patch to make pfns clean.
>
> This seems unfortunate given the desire to kill off
> CONFIG_FS_DAX_LIMITED which is the only way to get DAX without 'struct
> page'.
>
> I would special case these helpers behind CONFIG_FS_DAX_LIMITED such
> that they can be deleted when that support is finally removed.

...unless this support is to be used for other PFN_MAP scenarios where
a 'struct page' is not available? If so then the "(e.g. DAX)" should
be clarified to those other cases.
