Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC0702615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjEOHaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjEOHaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:30:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60779D9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:29:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so21929706a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1684135796; x=1686727796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xB/H7Jo2uEMNG/RV83jejDcjqMFS0mnYDpQFTZKPFzw=;
        b=Cj4BOE2twEMed27WIrgQyfZdTny1qLi30IXKTx1U/6zbHirj67Xnf+tEvLb9wRQ9aG
         BGy1kvcTkM/1fQ0WIAg/BGSLwZEIz/4mRhBsGfwXHnLnkhTJazmYEzC1NHuzj8M4WQkE
         PmeIE82Vpm3iTLPFK5R456zDBXDgmE+MigJa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135796; x=1686727796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xB/H7Jo2uEMNG/RV83jejDcjqMFS0mnYDpQFTZKPFzw=;
        b=aec1348fPfbk9wZYeOM13ZAIm/TRhtxrbL8NMvA+jjeZb0PxqzY8EdIC4QoNWlY+/u
         72eyZwacmobYeVW2mATq0CK747XQP7hBDoxoteu4NdCSw8tWYrX2dGcY40v5CSk3qdVw
         vy3A2GM1R9+AQqNw/eGAgj4wx1Y3SkSdHxtDdr6F8w7clL8plqshrnMq629CIpmKge23
         GqvsXVem08K4s4meGj5Wx3fMCmC0R+vhyJkHarUpph4ZhmCthBNCYddkAU7RI0jOEd6q
         5N4gZMP0vh94up0thKUXGDh5X13Kew0vl12b5v0/e7fQKQX+4nh4p88X8Whe7jz3c7zF
         UM/w==
X-Gm-Message-State: AC+VfDz5gQqw3HCWau2dCI5YiA+X56F8Bzb/jkZ1hrrxdFDveoQy0Sju
        SgHfXds42nqzJ+M8dcvS8nAHvs+wGo9yKEyUuxCk5Q==
X-Google-Smtp-Source: ACHHUZ5GqVh6BSqiM04nh0j407yAmJjjJSnHNlfwcMiXTmthP8URs+b6hfFPXsEGkjRuwK2kpbRvOfgsqqnCqvqfQPU=
X-Received: by 2002:a17:906:58c9:b0:94f:6218:191d with SMTP id
 e9-20020a17090658c900b0094f6218191dmr32784034ejs.32.1684135795846; Mon, 15
 May 2023 00:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
 <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
 <CAJfpegvbMKadnsBZmEvZpCxeWaMEGDRiDBqEZqaBSXcWyPZnpA@mail.gmail.com>
 <CAOQ4uxgXhVOpF8NgAcJCeW67QMKBOytzMXwy-GjdmS=DGGZ0hA@mail.gmail.com> <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxg2k3DsTdiMKNm4ESZinjS513Pj2EeKGW4jQR_o5Mp3-Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 May 2023 09:29:44 +0200
Message-ID: <CAJfpegv1ByQg750uHTGOTZ7CJ4OrYp6i4MKXU13mwZPUEk+pnA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 May 2023 at 21:37, Amir Goldstein <amir73il@gmail.com> wrote:

> I was waiting for LSFMM to see if and how FUSE-BPF intends to
> address the highest value use case of read/write passthrough.
>
> From what I've seen, you are still taking a very broad approach of
> all-or-nothing which still has a lot of core design issues to address,
> while these old patches already address the most important use case
> of read/write passthrough of fd without any of the core issues
> (credentials, hidden fds).
>
> As far as I can tell, this old implementation is mostly independent of your
> lookup based approach - they share the low level read/write passthrough
> functions but not much more than that, so merging them should not be
> a blocker to your efforts in the longer run.
> Please correct me if I am wrong.
>
> As things stand, I intend to re-post these old patches with mandatory
> FOPEN_PASSTHROUGH_AUTOCLOSE to eliminate the open
> questions about managing mappings.
>
> Miklos, please stop me if I missed something and if you do not
> think that these two approaches are independent.

Do you mean that the BPF patches should use their own passthrough mechanism?

I think it would be better if we could agree on a common interface for
passthough (or per Paul's suggestion: backing) mechanism.

Let's see this patchset and then we can discuss how this could be
usable for the BPF case as well.

Thanks,
Miklos
