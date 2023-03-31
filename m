Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8316D2481
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjCaP5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjCaP5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:57:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286CFFF0D
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 08:57:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ew6so91394892edb.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680278225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUqPxRAuAHrc1y6VCqhIsZPLfTNQYcDlCWZh8QFbAXg=;
        b=bkZ4l/r93KAdsfu5vhV8HHA7H+tUt8+RCUdzBWrzIs7sG+RCRM8k4Y3YH7QTYnsH/W
         9oXe2S3FFnucf0XXTHbmngcR/JOQsMaGTcztEr+Rz83Zi7jLjQ01txfmjjQ3K2d2NCYJ
         vKjMYcQFsFhfJjhZf5QxUh5bcJSbEGuqESthyKBchb5q/IWM4c2k7EHOd4IRAK3T4YPy
         M2DgTeRmyJpBvjyFLsScUlylCNVe+bxzq2LlDxmvBCawObRb5Z4U1gEB3nPmVRpTN9TF
         N/wvzvo4hcCvNpviCA8V4IbPZ27nOJBomb9wTvpV6D6RQCvluq7bpN7aPhjhiGMexceG
         wQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUqPxRAuAHrc1y6VCqhIsZPLfTNQYcDlCWZh8QFbAXg=;
        b=EL81sTclcYpDN9K4kM3c/+SdRCT2jTLvIiKqcRTh1oxThUNyYkNxWZfF8jqUKm8dVv
         uXfSMrxp6/jsNT8aGgohKIEiuFJL+F59xCuJR74SVxxq67j8szRN//pkmVR4XX8hxwZ2
         9s0J95PbPUKhJrNPGpEOQul30JQW678Qx0QMsvSgDGRcrfBDkgN1fAUXSaOiJZSD84Zj
         okJqyD2hv5VuE4YP60RD6RImOp3lF+aVdqsXswz2+mT0cV6iO0p3wDGc7cA0ffU0OJdG
         gaa7wJbz8R8p752E9KG6X43Xpab8hg4CzPQgypXIhJ85aiF+yiQoiFbvVsz4tLdJigkZ
         yk0g==
X-Gm-Message-State: AAQBX9fIgMEMCjQkpf8f9/309w1vVCk6t9v8LOrBtD+RInYuXIzOou8h
        ILC352+cvptJ+dhVBWqfR3QZRhUSlskmrlTu8BSjwA==
X-Google-Smtp-Source: AKy350YeU3SBnfFyD4Pfud1dHmqGIMxXnNo9n3lah5R3ayWKJr0l5EdZnUMm+T5gAOWjW7sp5RniVOOJKfQVkRGy9IU=
X-Received: by 2002:a50:ce58:0:b0:502:6d4b:40f5 with SMTP id
 k24-20020a50ce58000000b005026d4b40f5mr3720859edj.7.1680278225487; Fri, 31 Mar
 2023 08:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <7c7933df-43da-24e3-2144-0551cde05dcd@redhat.com>
 <CGME20230331114220epcas2p2d5734efcbdd8956f861f8e7178cd5288@epcas2p2.samsung.com>
 <20230331114220.400297-1-ks0204.kim@samsung.com> <ZCbjRsmoy1acVN0Z@casper.infradead.org>
In-Reply-To: <ZCbjRsmoy1acVN0Z@casper.infradead.org>
From:   Frank van der Linden <fvdl@google.com>
Date:   Fri, 31 Mar 2023 08:56:54 -0700
Message-ID: <CAPTztWYGdkcdq+yO4aG2C8YYZ0SokxhHQxQK7JmRxXLAuwV00Q@mail.gmail.com>
Subject: Re: RE: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>, david@redhat.com,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 6:42=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Mar 31, 2023 at 08:42:20PM +0900, Kyungsan Kim wrote:
> > Given our experiences/design and industry's viewpoints/inquiries,
> > I will prepare a few slides in the session to explain
> >   1. Usecase - user/kernespace memory tiering for near/far placement, m=
emory virtualization between hypervisor/baremetal OS
> >   2. Issue - movability(movable/unmovable), allocation(explicit/implici=
t), migration(intented/unintended)
> >   3. HW - topology(direct, switch, fabric), feature(pluggability,error-=
handling,etc)
>
> I think you'll find everybody else in the room understands these issues
> rather better than you do.  This is hardly the first time that we've
> talked about CXL, and CXL is not the first time that people have
> proposed disaggregated memory, nor heterogenous latency/bandwidth
> systems.  All the previous attempts have failed, and I expect this
> one to fail too.  Maybe there's something novel that means this time
> it really will work, so any slides you do should focus on that.
>
> A more profitable discussion might be:
>
> 1. Should we have the page allocator return pages from CXL or should
>    CXL memory be allocated another way?
> 2. Should there be a way for userspace to indicate that it prefers CXL
>    memory when it calls mmap(), or should it always be at the discretion
>    of the kernel?
> 3. Do we continue with the current ZONE_DEVICE model, or do we come up
>    with something new?
>
>

Point 2 is what I proposed talking about here:
https://lore.kernel.org/linux-mm/a80a4d4b-25aa-a38a-884f-9f119c03a1da@googl=
e.com/T/

With the current cxl-as-numa-node model, an application can express a
preference through mbind(). But that also means that mempolicy and
madvise (e.g. MADV_COLD) are starting to overlap if the intention is
to use cxl as a second tier for colder memory.  Are these the right
abstractions? Might it be more flexible to attach properties to memory
ranges, and have applications hint which properties they prefer?

It's an interesting discussion, and I hope it'll be touched on at
LSF/MM, happy to participate there.

- Frank
