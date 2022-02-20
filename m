Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893864BD01B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 18:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbiBTRGE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 12:06:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBTRGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:06:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10E3CA65;
        Sun, 20 Feb 2022 09:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70DFCB80D2C;
        Sun, 20 Feb 2022 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09452C340EB;
        Sun, 20 Feb 2022 17:05:36 +0000 (UTC)
Date:   Sun, 20 Feb 2022 12:05:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     mingo@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com
Subject: Re: [PATCH 02/11] kernel/trace: move stack_tracer_enabled sysctl to
 its own file
Message-ID: <20220220120535.50380537@gandalf.local.home>
In-Reply-To: <20220220060017.13285-1-tangmeng@uniontech.com>
References: <20220220060017.13285-1-tangmeng@uniontech.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 20 Feb 2022 14:00:17 +0800
tangmeng <tangmeng@uniontech.com> wrote:

> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> All filesystem syctls now get reviewed by fs folks. This commit
> follows the commit of fs, move the stack_tracer_enabled sysctl to its
> own file, kernel/trace/trace_stack.c.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
