Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF546CC159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjC1Nra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjC1NrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:47:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB505A26B;
        Tue, 28 Mar 2023 06:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 489DCB81CFB;
        Tue, 28 Mar 2023 13:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F71EC4339B;
        Tue, 28 Mar 2023 13:47:11 +0000 (UTC)
Date:   Tue, 28 Mar 2023 09:47:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
Message-ID: <20230328094709.5feb741d@gandalf.local.home>
In-Reply-To: <87cz4tus9d.fsf@jogness.linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
        <20230302195618.156940-6-john.ogness@linutronix.de>
        <ZBnVkarywpyWlDWW@alley>
        <87y1nip3a1.fsf@jogness.linutronix.de>
        <ZCKjSpDbiBVabbP5@alley>
        <87cz4tus9d.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Mar 2023 11:48:06 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> > static_assert(sizeof(struct cons_state) == sizeof(atomic_long_t));  
> 
> I never realized the kernel code was allowed to have that. But it is
> everywhere! :-) Thanks. I've added and tested the following:

I didn't know about static_assert(), as I always used BUILD_BUG_ON().

The difference being that BUILD_BUG_ON() has to be used within a function,
where as static_assert() can be done outside of functions. Hmm, maybe I can
convert some of my BUILD_BUG_ON()s to static_assert()s.

Learn something new every day.

-- Steve
