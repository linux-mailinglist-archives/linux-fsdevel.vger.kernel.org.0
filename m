Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BAE340F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhCRUmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhCRUmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:42:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356BCC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s2so5152971qtx.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOAtzI6XfjgzBwIu+EtPFo8QNNgd7hESHH8Nk+Ja34k=;
        b=YiuPthPTj9K4DZzonYzJpHPIHwQFHfF2KQ1rQlIwX6jagxxhiwkVQ7qtZWE6Sh//gx
         kVneIcG1TrbLMGNO4Qv0mCX5ZXOmsuWbmsfv5A6djSOfChuDMzqK3uIEADvP9IDBF5zv
         8mj2R9ABhCWW9j9570+xb0MtoF6XCFuohQqyVDDs701NHJjZE5jOVk76/vjLM7iutOnd
         MiOTzt/LpoK+PxTYfrebP1jIj7az8gvF/Uq5jJuT4hJkyVos7Njz9nzh/iHJYP9PuDDY
         zLTcNSZWa07fgNa8VnsVKJmMvf4mcT2bWjtYXEybPS/DORjvuvb0dvf9KAAPpeqT9f1M
         dKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOAtzI6XfjgzBwIu+EtPFo8QNNgd7hESHH8Nk+Ja34k=;
        b=mCgfCNl3dDcIH5sHoA5WuOxDQm34nYf0Fyng1l7Dc25d//H106jrxKFWO1lN9i5MGH
         vJD5KB0LiCf+iPRfcWZApxmeDIo7kknxinVpXtL3vyOscmNu88p5noBnqhV4nnFJw1U8
         sE2JrGMrOfgsgdjyLmuLkUlPGlTBOl7bEHoa34RsqeZg6zDTCC/wVBxdtNlkIoaZrLVt
         z2ReAP5HDElhXT6dtIveHJ0TdaLvvIC3Qs2bD5jL9oWGdtYxC7FAIhRZpBbFs+ncdHyS
         wcRFXxF0JJJYom/+b5sppvZarN4Qu8LqnWcA+yo/5PO4blEfjPqMfg3msh092ETKtY3C
         zUOw==
X-Gm-Message-State: AOAM530QNL/lAZfLs/0Zcqm790aCd7xRZEz1WgY1/+Vllr9SswDBTtfk
        GN5YBvtgPPH58zA4i0OnzCleb4bVHM3/BrCct+WqTQ==
X-Google-Smtp-Source: ABdhPJwbbwbQtsKdXGidS0XzrLmAq2xIk32hRRm0JCeqaQMKwgMzpgTOHvND+KsVFVSUU6lW++UO6E5dgGWp55eEBMQ=
X-Received: by 2002:aed:2b06:: with SMTP id p6mr5496809qtd.101.1616100130193;
 Thu, 18 Mar 2021 13:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210317045949.1584952-1-joshdon@google.com> <20210318143158.GB17012@xsang-OptiPlex-9020>
In-Reply-To: <20210318143158.GB17012@xsang-OptiPlex-9020>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 18 Mar 2021 13:41:59 -0700
Message-ID: <CABk29Nu0+k3dLa5T-Z99EE7FdVSa1wb_OT3zTbXKUaf5Tb-iWA@mail.gmail.com>
Subject: Re: [sched] 663017c554: WARNING:at_kernel/sched/core.c:#scheduler_tick
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Paul Turner <pjt@google.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The warning is WAI (holding spinlock for 100ms). However, since this
is expected for locktorture, it makes sense to not have the warning
enabled while the test is running. I can add that to the patch.
