Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153F92BDA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 05:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfE1DWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 23:22:22 -0400
Received: from ozlabs.org ([203.11.71.1]:42241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbfE1DWW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 23:22:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45CfKQ6Xj1z9s5c;
        Tue, 28 May 2019 13:22:17 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christian Brauner <christian@brauner.io>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com
Cc:     jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com,
        tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] tests: add close_range() tests
In-Reply-To: <20190524111047.6892-4-christian@brauner.io>
References: <20190524111047.6892-1-christian@brauner.io> <20190524111047.6892-4-christian@brauner.io>
Date:   Tue, 28 May 2019 13:22:10 +1000
Message-ID: <87zhn7p8kd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:
> This adds basic tests for the new close_range() syscall.
> - test that no invalid flags can be passed
> - test that a range of file descriptors is correctly closed
> - test that a range of file descriptors is correctly closed if there there
>   are already closed file descriptors in the range
> - test that max_fd is correctly capped to the current fdtable maximum
>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Dmitry V. Levin <ldv@altlinux.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-api@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> ---
> v1: unchanged
> v2:
> - Christian Brauner <christian@brauner.io>:
>   - verify that close_range() correctly closes a single file descriptor
> v3:
> - Christian Brauner <christian@brauner.io>:
>   - add missing Cc for Shuah
>   - add missing Cc for linux-kselftest

Sorry I replied to v2, but I think my comments still apply:

https://lore.kernel.org/lkml/8736kzqpdm.fsf@concordia.ellerman.id.au/

cheers
