Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA00B678043
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 16:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjAWPpl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 10:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjAWPpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:45:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831E3E04B;
        Mon, 23 Jan 2023 07:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205F360F7A;
        Mon, 23 Jan 2023 15:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C4AC433A0;
        Mon, 23 Jan 2023 15:45:34 +0000 (UTC)
Date:   Mon, 23 Jan 2023 10:45:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, acme@redhat.com, akpm@linux-foundation.org,
        bobwxc@email.cn, brauner@kernel.org, brho@google.com,
        broonie@kernel.org, catalin.marinas@arm.com, cgel.zte@gmail.com,
        corbet@lwn.net, dave@stgolabs.net, ebiederm@xmission.com,
        eugenis@google.com, hannes@cmpxchg.org, linmiaohe@huawei.com,
        mhiramat@kernel.org, mhocko@suse.com, ran.xiaokai@zte.com.cn,
        rppt@kernel.org, shuah@kernel.org, shy828301@gmail.com,
        song@kernel.org, Vincenzo.Frascino@arm.com, will@kernel.org,
        willy@infradead.org, yang.yang29@zte.com.cn,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 07/20] mm: add tracepoints to ksm
Message-ID: <20230123104530.4ec0aeb4@gandalf.local.home>
In-Reply-To: <20230123050042.1752641-8-shr@devkernel.io>
References: <20230123050042.1752641-1-shr@devkernel.io>
        <20230123050042.1752641-8-shr@devkernel.io>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 22 Jan 2023 21:00:29 -0800
Stefan Roesch <shr@devkernel.io> wrote:

> This adds the following tracepoints to ksm:
> - start / stop scan
> - ksm enter / exit
> - merge a page
> - merge a page with ksm
> - remove a page
> - remove a rmap item
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>  MAINTAINERS                |   1 +
>  include/trace/events/ksm.h | 257 +++++++++++++++++++++++++++++++++++++
>  mm/ksm.c                   |  20 ++-
>  3 files changed, 276 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/ksm.h

From the tracing pov:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
