Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD745A2250
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbiHZHwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiHZHwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3BDD3E7A;
        Fri, 26 Aug 2022 00:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E82B82F77;
        Fri, 26 Aug 2022 07:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7296CC433C1;
        Fri, 26 Aug 2022 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661500370;
        bh=AZSQuTUMuhBCSTAYFJauQHwCcy1qF0ZF2OFYaJubPX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOaxH6Xbs4xleND4L7NXXvj2gkBXfyj7XXvIJpbBhuye/i/A1xdPd9YfeCUAWZoXp
         zYHkfIp4xzbPTe0aacaBajz2j+TU2kclI6++QUAiADH03LNAZ6DZvI4gD+wsrzxv2C
         jYyen8YC2N1IROJHAn9iiSSEtS0uEb+2dohyiYulvUTkaLt1wgZ3M0sdG4AfoYBq1o
         pvQkLUwsc8YV5LWRAR2E1FJDPSuCtL0jzKYG1dSFsDEqRHkVJka8pHuOfHO+EkdFvi
         T4vUZCfWFRnvfI63nEo/W4knzOGrffA4eovuffa512HD4h4fTKnPEYa2CmkDbevo9k
         ELmIFpck3Gl3g==
Date:   Fri, 26 Aug 2022 09:52:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dentry: Use preempt_[dis|en]able_nested()
Message-ID: <20220826075242.wrczbyj5742t5r4c@wittgenstein>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
 <20220825164131.402717-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220825164131.402717-3-bigeasy@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:41:25PM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded CONFIG_PREEMPT_RT conditional
> preempt_disable/enable() with the new helper.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
