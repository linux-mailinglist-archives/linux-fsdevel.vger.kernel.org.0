Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92B068172C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjA3RDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 12:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3RD3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:03:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A727A5D2;
        Mon, 30 Jan 2023 09:03:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE36611E6;
        Mon, 30 Jan 2023 17:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A355C433D2;
        Mon, 30 Jan 2023 17:03:26 +0000 (UTC)
Date:   Mon, 30 Jan 2023 12:03:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 07/20] mm: add tracepoints to ksm
Message-ID: <20230130120324.24928c7a@gandalf.local.home>
In-Reply-To: <20230123173748.1734238-8-shr@devkernel.io>
References: <20230123173748.1734238-1-shr@devkernel.io>
        <20230123173748.1734238-8-shr@devkernel.io>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Jan 2023 09:37:35 -0800
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
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 123216b76534..990a28bdc263 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13482,6 +13482,7 @@ F:	include/linux/memory_hotplug.h
>  F:	include/linux/mm.h
>  F:	include/linux/mmzone.h
>  F:	include/linux/pagewalk.h
> +F:	include/trace/events/ksm.h
>  F:	mm/
>  F:	tools/testing/selftests/vm/
>  

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
