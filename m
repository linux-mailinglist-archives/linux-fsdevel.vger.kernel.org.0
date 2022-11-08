Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6977E6218F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 17:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiKHQA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 11:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiKHQA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:00:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839A75B87F
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 08:00:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a13so23234132edj.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Nov 2022 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFfZ5Bl5zhnH71PaGJAYrI//Xb3WWbjWoqFqkYPKW30=;
        b=C7OwW3FUJWQ9TsMP4XtJFWdFbq3CIFU6pSqTzLUuNeB55sqBurNd9+lK+4O64ax5nw
         sLHuW2BZWPNwW/HcxRsLULIhKy0426zbG2SmHFYjzexcTd9nih+dAA6GOaJuqGPnIlJp
         1nZOK9263PPnD7jUo2SElcu0BQprg/+ggeWhc9GM9gBFv6XxZxODbXJ1OOSJG0De8TjU
         TFUI9lToIWmJ9FDoEL1WLfETPa3grArpG45+0E7aAGCcNp9vSy2/3HGJfReROVxd2Utw
         XtSCF2zhCxlopPVvcacqaaSX4KJXfXQIedEUmZeOJLbdqt2wlmR4FMQ9nuaDqYZybzye
         Bucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFfZ5Bl5zhnH71PaGJAYrI//Xb3WWbjWoqFqkYPKW30=;
        b=zYcSc8gziPRtRC/X0CAzTrIAe5kUNMEPpGIfDyUjHTTAKOG+Pi+bMFWIN3AjBUemxR
         bFuj6kMNeteM3keKydpgL3T8K5H6xEfm28SEZXnp4Wox3arIJ2BgKAmBaNREOqq1qFzv
         EEglJ6wmmEkIoQWaD9kmNSM2iwzbX8A0MTl1qw2nuC7IOX4R1USyuVYLFzrhvrB0zSj6
         jpxc/8214XF/wk/pXXfw0vb3BeZXFhY8w6Fcv30qwBVFw+mrywKyQgRjzTpST5nx3r0q
         fHFXTAtrsakjnz+WztZdr0Q5jtrqZ7UvHbUNS058ms5F+gBi/dgnrq9+B3ptc6c3FAY3
         8VCg==
X-Gm-Message-State: ACrzQf3Aiis/faDc2iDXNCiBPfqERotfGqm5F/n1sHHfjhfSs0Fpc6/d
        AHygMKjpti+aayBKJw8JowzYNY9qQ2Mk8z4/G7p6sw==
X-Google-Smtp-Source: AMsMyM764Q6z1uaMrpLCjAMUVJWnIa32kDHXvdKz3wR3PYoFGk/3nY8ikLUuVdV2GstlG+PMkGKaZX23fir9c7kMHtY=
X-Received: by 2002:a05:6402:386:b0:463:c43f:6628 with SMTP id
 o6-20020a056402038600b00463c43f6628mr39052165edv.53.1667923224985; Tue, 08
 Nov 2022 08:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20221103145353.3049303-1-usama.anjum@collabora.com>
 <20221103145353.3049303-3-usama.anjum@collabora.com> <CABb0KFFaYZG62TS+iM3Y92+hDyB35XR8dTX-5hDgWrXCcDQx7Q@mail.gmail.com>
 <f394de31-b9c1-5a6c-eab2-74b84f2b3ba3@collabora.com>
In-Reply-To: <f394de31-b9c1-5a6c-eab2-74b84f2b3ba3@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Tue, 8 Nov 2022 17:00:14 +0100
Message-ID: <CABb0KFGbhM8V6qeDEzq7Lc_3cseScbK3zvfLndRdJfLstTO=2g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Nov 2022 at 15:25, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Micha=C5=82,
>
> Thank you so much for reviewing.
>
> On 11/7/22 5:26 PM, Micha=C5=82 Miros=C5=82aw wrote:
> >> +
> >> +/*
> >> + * struct page_region - Page region with bitmap flags
> >> + * @start:     Start of the region
> >> + * @len:       Length of the region
> >> + * bitmap:     Bits sets for the region
> >> + */
> >> +struct page_region {
> >> +       __u64 start;
> >> +       __u64 len;
> >> +       __u32 bitmap;
> >> +       __u32 __reserved;
> >
> > "u64 flags"? If an extension is needed it would already require a new
> > ioctl or something in the `arg` struct.
> I feel like the masks must have the same type as this bitmap variable as
> the return_mask specifies the flags to be returned in bitmap. All the
> masks are of type __u32. This is why I'd kept the bitmap of type _u32 as
> well. I've kept them of 32 bit size as currently we are adding support
> for 4 flags and there is still room to add 28 more bits in the future.
> Do you still think that I should update the masks and bitmap to _u64?

I agree that the `bitmap` (I'd rather call it `flags` though) should
have the type matching the masks in the request. But the size I'm not
sure about if u32 is enough compared to what is used (or will be in
the future) for page flags in MM code. I suppose the ioctl() is not
expected to be a fast path, so I would go with u64 and assume that
overhead of the extra bytes read by the kernel won't matter.

> >> + * @start:             Starting address of the region
> >> + * @len:               Length of the region (All the pages in this le=
ngth are included)
> >> + * @vec:               Address of page_region struct array for output
> >> + * @vec_len:           Length of the page_region struct array
> >> + * @max_pages:         Optional max return pages (It must be less tha=
n vec_len if specified)
> >
> > I think we discussed that this is not counting the same things as
> > vec_len, so there should not be a reference between the two. The limit
> > is whatever fits under both conditions (IOW: n_vecs <=3D vec_len &&
> > (!max_pages || n_pages <=3D max_pages).
> In worse case when pages cannot be folded into the page_region, the one
> page_region may have information of only one page. This is why I've
> compared them. I want to communicate to the user that if max_pages is
> used, the vec_len should be of equal or greater size (to cater worse
> case which can happen at any time). Otherwise in worse case, the api can
> return without finding the max_pages number of pages. I don't know how
> should I put this in the comment.

I'm not sure you need to, as this conclusion follows from the range vs
page distinction.
A user who wants to cater for the worst case will provide big-enough
`vec` array, but another, who might be memory-constrained, could
instead just retry the call with `start` updated to just after the
last returned page until the ioctl() returns less ranges than
`vec_len` allows.

Best Regards
Micha=C5=82 Miros=C5=82aw
