Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8627652D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjG0LrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjG0LrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:47:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367C273B
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:47:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11495a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690458428; x=1691063228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qlpFvFih5GNNFlLVS+kGv2ki2c8Ll+1BvaJ8aRuK9S8=;
        b=ujVW/hIeAcMqTgtHIGUFEu+YyAKGtrsu3UgdsoRPDPWXPqjjTrGvvT/+TomWCDMNEE
         smG9z1Hj5QXb9B+hICOfNKa8kLEmzcwPz3qTWSiklR+lXYz3qtHZO91BDB9j8kpe/ATD
         L/5QiEmFSsorHiikkg8KZV4hqg/R3PHGKYfX+JwX1FzSY7khHOQW/6pLNBQlejhGiton
         RCWGtAoaSzWHbWhwuUOi8b4fBhzW4zIbFwjr4uXFTJToDdyxMRkCQocqFpTlZz68+OpD
         l9uc8727PvEqzdQ8oZ3fUvbKoy1+whzmNxsGQZNtg/7ZLynTO+1j4UwVAuNnort5Wltn
         reMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458428; x=1691063228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlpFvFih5GNNFlLVS+kGv2ki2c8Ll+1BvaJ8aRuK9S8=;
        b=JEEKmA+ZU9bK9bZCM1WqyU3sqbVtGyzX11XNsrhy/jHJc+l6zrknfFglHkilpnfRuB
         WXFCoUuE2nhfGSdtChmrzqjCfFyB1EYktkrWrBYS848Yk80lScUigA2bfQ7c5Naqkdfl
         v3fKxfhqliDo8YgN8BURAdDGLaU/zk5GANdf6KnVpuF8euC0iyVI1nDxS6bp9/uw8skk
         Kn59mYcQPDQblOrGt1/gHJpHzUP2NNeOcYzKTY+tk759wO+MhnUBiD0cVpTLQ2L0dWXI
         w3+MTcjpv5YTCNEtPvQx+2XFguc5SUrb0wtdNmJ7hTYhM3Z6VJX6fKt3M+IbcErdrouV
         +7uA==
X-Gm-Message-State: ABy/qLZldfBylTnanj15qh9QLi6Z96Nf7DAhrnL7Q8ocKN64LvUObpKB
        giJ07g9XJbL4/ptGTgfAlUOODezd2iW+BS2A1ypq2A==
X-Google-Smtp-Source: APBJJlE3Ak6SrPpYNQym9CXnEyN4bE4ktVECrlEgTPLFQyDYNdtVYB9u6qLMyh0cL/BUEGDyLb+GfNuNoJPF3Vc8fY4=
X-Received: by 2002:a50:d0d2:0:b0:522:41c9:9b9 with SMTP id
 g18-20020a50d0d2000000b0052241c909b9mr83558edf.5.1690458427687; Thu, 27 Jul
 2023 04:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com> <20230727093637.1262110-3-usama.anjum@collabora.com>
In-Reply-To: <20230727093637.1262110-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 27 Jul 2023 13:46:55 +0200
Message-ID: <CABb0KFFphs6gLCH9+tenmoJ_3nNAop30pOMhKDwKT2Pthvb=6g@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 11:37, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
[...]
> +/*
> + * struct pm_scan_arg - Pagemap ioctl argument
> + * @size:              Size of the structure
> + * @flags:             Flags for the IOCTL
> + * @start:             Starting address of the region
> + * @end:               Ending address of the region
> + * @walk_end:          Ending address of the visited memory is returned
> + *                     (This helps if entire range hasn't been visited)

"Address where the scan stopped (written by kernel). walk_end == end
informs that the scan completed."

(To make the userspace life easier, we can copy `end` (only) in case
of full scan completion, so that the tag is retained.)

> + * @vec:               Address of page_region struct array for output
> + * @vec_len:           Length of the page_region struct array
> + * @max_pages:         Optional limit for number of returned pages (0 = disabled)
> + * @category_inverted: PAGE_IS_* categories which values match if 0 instead of 1
> + * @category_mask:     Skip pages for which any category doesn't match
> + * @category_anyof_mask: Skip pages for which no category matches
> + * @return_mask:       PAGE_IS_* categories that are to be reported in `page_region`s returned
> + */
