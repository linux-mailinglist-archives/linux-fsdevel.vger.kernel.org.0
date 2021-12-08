Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934F246DB4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhLHSnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 13:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhLHSna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:43:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE5C061746;
        Wed,  8 Dec 2021 10:39:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF24ECE2132;
        Wed,  8 Dec 2021 18:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E54C00446;
        Wed,  8 Dec 2021 18:39:53 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:39:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org, pmladek@suse.com,
        david@redhat.com, arnaldo.melo@gmail.com,
        andrii.nakryiko@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH -mm 1/5] elfcore: replace old hard-code 16 with
 TASK_COMM_LEN_16
Message-ID: <20211208133952.730c5fc2@gandalf.local.home>
In-Reply-To: <20211204095256.78042-2-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
        <20211204095256.78042-2-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  4 Dec 2021 09:52:52 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> A new macro TASK_COMM_LEN_16 is introduced for the old hard-coded 16 to
> make it more grepable. As explained above this marco, the difference
> between TASK_COMM_LEN and TASK_COMM_LEN_16 is that TASK_COMM_LEN_16 must
> be a fixed size 16 and can't be changed.

You could add:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
