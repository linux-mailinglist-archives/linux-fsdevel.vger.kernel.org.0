Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0378F7445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKKMos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 07:44:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKMor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:44:47 -0500
Received: from p54ac5540.dip0.t-ipconnect.de ([84.172.85.64] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iU93T-00015J-4X; Mon, 11 Nov 2019 12:44:27 +0000
Date:   Mon, 11 Nov 2019 13:44:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 12/23] y2038: syscalls: change remaining timeval to
 __kernel_old_timeval
Message-ID: <20191111124425.bmsdg5e4ikpdh5bu@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-3-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:12:11PM +0100, Arnd Bergmann wrote:
> All of the remaining syscalls that pass a timeval (gettimeofday, utime,
> futimesat) can trivially be changed to pass a __kernel_old_timeval
> instead, which has a compatible layout, but avoids ambiguity with
> the timeval type in user space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems reasonable.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
