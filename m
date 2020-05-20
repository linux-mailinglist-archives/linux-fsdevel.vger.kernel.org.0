Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077191DA89B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgETDbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 23:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgETDbn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 23:31:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8AA207E8;
        Wed, 20 May 2020 03:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589945503;
        bh=xgjmAbinfDSoCTxkb9giIOWRyJP7B6MDWh7oghCmOlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2N1qoMb88ufl9xF8wieppgQDWMSoQrpe15LOVgWDT/Bmu8uNvcG1M/d5LT8/xajMG
         liOV2ScdOV9JsDIv7NH6UmL9oU2ZXvz3YgrKe+sOv/g6YlbiwbhiHb8cDXXslpUzK0
         o1IpKRvF737IbbmSxIcJFuuZiB+nq0aj2szDXTFQ=
Date:   Tue, 19 May 2020 20:31:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <mhocko@suse.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <vbabka@suse.cz>,
        <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
Subject: Re: [PATCH v4 0/4] cleaning up the sysctls table (hung_task
 watchdog)
Message-Id: <20200519203141.f3152a41dce4bc848c5dded7@linux-foundation.org>
In-Reply-To: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 19 May 2020 11:31:07 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:

> Kernel/sysctl.c

eek!

> 
>  fs/proc/proc_sysctl.c        |   2 +-
>  include/linux/sched/sysctl.h |  14 +--
>  include/linux/sysctl.h       |  13 ++-
>  kernel/hung_task.c           |  77 +++++++++++++++-
>  kernel/sysctl.c              | 214 +++++++------------------------------------
>  kernel/watchdog.c            | 101 ++++++++++++++++++++
>  6 files changed, 224 insertions(+), 197 deletions(-)

Here's what we presently have happening in linux-next's kernel/sysctl.c:

 sysctl.c | 3109 ++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 1521 insertions(+), 1588 deletions(-)


So this is not a good time for your patch!

Can I suggest that you set the idea aside and take a look after 5.8-rc1
is released?

