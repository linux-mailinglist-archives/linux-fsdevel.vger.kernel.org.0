Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE974DB82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGJQwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGJQv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4AD180;
        Mon, 10 Jul 2023 09:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F04C86112C;
        Mon, 10 Jul 2023 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A12C433C7;
        Mon, 10 Jul 2023 16:51:52 +0000 (UTC)
Date:   Mon, 10 Jul 2023 12:51:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zehao Zhang <zhangzehao@vivo.com>, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: Add ftrace support for exfat and add some
 tracepoints
Message-ID: <20230710125149.6424268a@gandalf.local.home>
In-Reply-To: <20230711013723.1b677cae2870bd509f77babd@kernel.org>
References: <20230710092559.19087-1-zhangzehao@vivo.com>
        <20230711013723.1b677cae2870bd509f77babd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jul 2023 01:37:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> It seems like most of them are address_space_operations' operators.
> Is that OK to define those events (~= user exposed interface) from
> exFAT filesystem? I wonder why we can not make a generic VFS events
> for those. (Or all FS-wide generic events).

Probably because the VFS maintainer has NACK'd all trace events in the
generic VFS subsystem :-(

-- Steve
