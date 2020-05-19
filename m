Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA40D1D9230
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgESIhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 04:37:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40654 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESIhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 04:37:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49R8QK0Grqz1qrf4;
        Tue, 19 May 2020 10:37:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49R8QJ5zQ7z1qsq7;
        Tue, 19 May 2020 10:37:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id slUeY5zBMP1u; Tue, 19 May 2020 10:37:27 +0200 (CEST)
X-Auth-Info: FqBIyAr0MyUGIS5Ip8Q7OSzRYusW2FcZjUE71QeBiiTFJFnlwZ4bNMhWHvnp6j06
Received: from igel.home (ppp-46-244-171-2.dynamic.mnet-online.de [46.244.171.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 19 May 2020 10:37:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C49402C0C39; Tue, 19 May 2020 10:37:26 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
References: <20200518055457.12302-1-keescook@chromium.org>
        <20200518055457.12302-2-keescook@chromium.org>
        <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
        <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
        <20200518144627.sv5nesysvtgxwkp7@wittgenstein>
        <87blmk3ig4.fsf@x220.int.ebiederm.org>
X-Yow:  Two with FLUFFO, hold th' BEETS..side of SOYETTES!
Date:   Tue, 19 May 2020 10:37:26 +0200
In-Reply-To: <87blmk3ig4.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 18 May 2020 18:57:15 -0500")
Message-ID: <87mu64uxq1.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mai 18 2020, Eric W. Biederman wrote:

> If it was only libc4 and libc5 that used the uselib system call then it
> can probably be removed after enough time.

Only libc4 used it, libc5 was already ELF.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
