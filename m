Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5EB1221D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 03:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLQCH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 21:07:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfLQCH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 21:07:27 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ih2Gj-000354-4v; Tue, 17 Dec 2019 02:07:25 +0000
Date:   Tue, 17 Dec 2019 03:07:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com
Subject: Re: [PATCH v3 4/4] samples: Add example of using pidfd getfd in
 conjunction with user trap
Message-ID: <20191217020723.cluy5x2kg5q3ithf@wittgenstein>
References: <20191217010025.GA14479@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217010025.GA14479@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:00:27AM +0000, Sargun Dhillon wrote:
> This sample adds the usage of SECCOMP_RET_USER_NOTIF together with pidfd
> GETFD ioctl. It shows trapping a syscall, and handling it by extracting
> the FD into the parent process without stopping the child process.
> Although, in this example, there's no explicit policy separation in
> the two processes, it can be generalized into the example of a transparent
> proxy.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  samples/seccomp/.gitignore        |   1 +
>  samples/seccomp/Makefile          |   9 +-
>  samples/seccomp/user-trap-pidfd.c | 190 ++++++++++++++++++++++++++++++

This is a great sample.
Could you please also add tests without seccomp to the pidfd-testsuite
itself under tools/testing/selftests/pidfd. I want to have all pidfd
features tested in one place so that people don't need to run
seccomp-bpf, or compile the optional samples but can just run the pidfd
test-suite and it'll bang on all features.

Christian
