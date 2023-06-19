Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D1734F34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjFSJLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjFSJLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:11:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D3D1CA;
        Mon, 19 Jun 2023 02:11:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C2DB2F4;
        Mon, 19 Jun 2023 02:11:47 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.28.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DBA43F64C;
        Mon, 19 Jun 2023 02:11:02 -0700 (PDT)
Date:   Mon, 19 Jun 2023 10:10:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Christopher James Halse Rogers <raof@ubuntu.com>
Subject: Re: [PATCH 28/32] stacktrace: Export stack_trace_save_tsk
Message-ID: <ZJAboGKqWKA18ryp@FVFF77S0Q05N>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-29-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-29-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:53PM -0400, Kent Overstreet wrote:
> From: Christopher James Halse Rogers <raof@ubuntu.com>
> 
> The bcachefs module wants it, and there doesn't seem to be any
> reason it shouldn't be exported like the other functions.

What is the bcachefs module using this for?

Is that just for debug purposes? Assuming so, mentioning that in the commit
message would be helpful.

Thanks,
Mark.

> Signed-off-by: Christopher James Halse Rogers <raof@ubuntu.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  kernel/stacktrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index 9ed5ce9894..4f65824879 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -151,6 +151,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
>  	put_task_stack(tsk);
>  	return c.len;
>  }
> +EXPORT_SYMBOL_GPL(stack_trace_save_tsk);
>  
>  /**
>   * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
> @@ -301,6 +302,7 @@ unsigned int stack_trace_save_tsk(struct task_struct *task,
>  	save_stack_trace_tsk(task, &trace);
>  	return trace.nr_entries;
>  }
> +EXPORT_SYMBOL_GPL(stack_trace_save_tsk);
>  
>  /**
>   * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
> -- 
> 2.40.1
> 
> 
