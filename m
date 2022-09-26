Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493DA5EAB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiIZPhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiIZPfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:35:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFE10D7;
        Mon, 26 Sep 2022 07:22:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C81E21F461;
        Mon, 26 Sep 2022 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664202168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yLX9jiGt/X8iPSs+diqbjzj/sEqeVPl/cgX6IPnAclQ=;
        b=owoBoNPN6hzhkVrlEdmEWds7d+Yws3GrA1dOyCFZx7a19XO2YX5PYa4QZgQ0FZLQ+gfS75
        t3MWBQw09M7WI4C0MvIWG1ZhwnI0qQjtKEMdkyiPS1HlcHVOVXOSoIeR0zo+RAC5LQnN+9
        msa+UwQ/HICZNTAtF+/roX9Zr/OUsmc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A72C32C17E;
        Mon, 26 Sep 2022 14:22:48 +0000 (UTC)
Date:   Mon, 26 Sep 2022 16:22:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 02/18] printk: Declare log_wait properly
Message-ID: <YzG1uDoNQeoPdkWh@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2022-09-24 02:10:38, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> kernel/printk/printk.c:365:1: warning: symbol 'log_wait' was not declared. Should it be static?
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
