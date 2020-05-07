Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C011C9EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEGXGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgEGXGU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:06:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFC3208D6;
        Thu,  7 May 2020 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892779;
        bh=HAilGWe4lV9oUELeIOkLoxMN5NMr+o3TPnQtyqGETY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QQMh0MejIC3msVJ9Mc0Vp4sql4itOWA1pUrx0ZwApVELQEAwDpfiMzam77C31caYN
         pIz3jTKcKsduV3DgmQiI4p+NYGVTPM0QaTknaUdLT2KvSVAtHrNUD9kI5Azml5xP1p
         3fofpirtshBXkSU3cHNb9wbZlP09cV+p9Gfe6dQ0=
Date:   Thu, 7 May 2020 16:06:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, mcgrof@kernel.org,
        vbabka@suse.cz, kernel@gpiccoli.net
Subject: Re: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot
 parameters to sysctl aliases
Message-Id: <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
In-Reply-To: <20200507214624.21911-1-gpiccoli@canonical.com>
References: <20200507214624.21911-1-gpiccoli@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  7 May 2020 18:46:24 -0300 "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> After a recent change introduced by Vlastimil's series [0], kernel is
> able now to handle sysctl parameters on kernel command line; also, the
> series introduced a simple infrastructure to convert legacy boot
> parameters (that duplicate sysctls) into sysctl aliases.
> 
> This patch converts the watchdog parameters softlockup_panic and
> {hard,soft}lockup_all_cpu_backtrace to use the new alias infrastructure.
> It fixes the documentation too, since the alias only accepts values 0
> or 1, not the full range of integers. We also took the opportunity here
> to improve the documentation of the previously converted hung_task_panic
> (see the patch series [0]) and put the alias table in alphabetical order.

We have a lot of sysctls.  What is the motivation for converting these
particular ones?
