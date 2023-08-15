Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418F77C89C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 09:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjHOHeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjHOHd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:33:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22C172C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:33:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so692419566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692084835; x=1692689635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ptPuBEpK+bTuLrHXWomcWZqL5q0T5IOC69Hvw3A95bI=;
        b=h7n/uDShYxSNwBRM50GOcCYxuc5JsYL93sEbxiZjMXPXLrqKWNgGPMQHT55ERVVzUL
         rJ6DnJJzSLywuxsjaP6QrDBf6HopbKSrZ8QnrDztCvKFxUNp+GccUBrtgSDq/4TYZAKk
         fWvzz4oIF9Me0r7rMIjrl5MMY8kDEdukA6gUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692084835; x=1692689635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptPuBEpK+bTuLrHXWomcWZqL5q0T5IOC69Hvw3A95bI=;
        b=M/jA7adXU/6zLvIoWqgtuPp9bvmY++RKPthEDReA+jGPHdhy8yorYgebMJ4N887lBL
         XOSmF/LBhVmT4hQdKriK9vHEriNpc2kUAICZZ+CfbaCIcS2sSejZyWtOtqhuQUi4c9TL
         EgrQcNoWun3E21vVdCVI2ekSSBl7xcRMOgdAeBLRiG2jrOHcMBuWw55CJ5Nko3PJitlr
         Wf8OzE7LbSDXkUSQfMWlDQttt11ArKv+qdLkhsqWjviOXuUKve9sO9GNHCYRO8+6UJPQ
         AahPNk5hC4GnB8rjnNAoVoxZ/MU+APLTuG6LvDcTIkMsLl8RpnIcH+twzGWLylYqp47z
         Zicg==
X-Gm-Message-State: AOJu0YyDW7MazOPQ7jsrDbQLfybaaTTr2Dkbo9PAnX5rLtlzdEKQnAcg
        SWy2WE+eZfysQxshMxVqcJu0ILTy+mTlLXUN0qf+HnRB
X-Google-Smtp-Source: AGHT+IFxULyjAZ+X8WyUl5Vn3+Ctz7EPQBqQwpP0FPWp0YxZN13M9PiifJ8BVAuB5dvFu2lYIWfIAw==
X-Received: by 2002:a17:906:314c:b0:99b:64d0:f6c8 with SMTP id e12-20020a170906314c00b0099b64d0f6c8mr8911893eje.50.1692084835775;
        Tue, 15 Aug 2023 00:33:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709064d8a00b0099364d9f0e6sm6564582eju.117.2023.08.15.00.33.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 00:33:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-523bf06f7f8so5230777a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 00:33:53 -0700 (PDT)
X-Received: by 2002:a05:6402:290:b0:523:1004:1c9a with SMTP id
 l16-20020a056402029000b0052310041c9amr8202386edv.35.1692084833506; Tue, 15
 Aug 2023 00:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <202308151426.97be5bd8-oliver.sang@intel.com>
In-Reply-To: <202308151426.97be5bd8-oliver.sang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Aug 2023 07:33:36 +0000
X-Gmail-Original-Message-ID: <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
Message-ID: <CAHk-=whbOEhPUL1m8Ua-+-E7kJXED4xa+duzRF-wJKR84NAPWg@mail.gmail.com>
Subject: Re: [linus:master] [locking] c8afaa1b0f: stress-ng.zero.ops_per_sec
 6.3% improvement
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Aug 2023 at 07:12, kernel test robot <oliver.sang@intel.com> wrote:
>
> kernel test robot noticed a 6.3% improvement of stress-ng.zero.ops_per_sec on:

WTF? That's ridiculous. Why would that even test new_inode() at all?
And why would it make any difference anyway to prefetch a new inode?
The 'zero' test claims to just read /dev/zero in a loop...

[ Goes looking ]

>      39.35            -0.3       39.09        perf-profile.calltrace.cycles-pp.inode_sb_list_add.new_inode.shmem_get_inode.__shmem_file_setup.shmem_zero_setup

Ahh. It also does the mmap side, and the shared case ends up always
creating a new inode.

And while the test only tests *reading* and the mmap is read-only, the
/dev/zero file descriptor was opened for writing too, for a different
part of a test.

So even though the mapping is never written to, MAYWRITE is set, and
so the /dev/zero mapping is done as a shared memory mapping and we
can't do it as just a private one.

That's kind of stupid and looks unintentional, but whatever.

End result: that benchmark ends up being at least partly (and a fairly
noticeable part) a shmem setup benchmark, for no actual good reason.

Oh well. I certainly don't mind the removal apparently then also
helping some odd benchmark case, but I don't think this translates to
anything real. Very random.

                    Linus
