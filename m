Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEF1D9600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgESMNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 08:13:25 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60043 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESMNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 08:13:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49RFCK6Rfkz1rtjY;
        Tue, 19 May 2020 14:13:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49RFCK50Dsz1qtwF;
        Tue, 19 May 2020 14:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ElnYnYpihtKs; Tue, 19 May 2020 14:13:15 +0200 (CEST)
X-Auth-Info: BdzxRw3MNxoi9lJoK1v0SRv148N2LL0c3F0NDN4KiaTBfn48ivwksZx6pZAVP+Kr
Received: from igel.home (ppp-46-244-171-2.dynamic.mnet-online.de [46.244.171.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 19 May 2020 14:13:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id CC0142C0C39; Tue, 19 May 2020 14:12:59 +0200 (CEST)
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
        <87blmk3ig4.fsf@x220.int.ebiederm.org> <87mu64uxq1.fsf@igel.home>
        <87sgfwuoi3.fsf@x220.int.ebiederm.org>
X-Yow:  HOW could a GLASS be YELLING??
Date:   Tue, 19 May 2020 14:12:59 +0200
In-Reply-To: <87sgfwuoi3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 19 May 2020 06:56:36 -0500")
Message-ID: <87eergunqs.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mai 19 2020, Eric W. Biederman wrote:

> I am wondering if there are source trees for libc4 or libc5 around
> anywhere that we can look at to see how usage of uselib evolved.

libc5 is available from archive.debian.org.

http://archive.debian.org/debian-archive/debian/pool/main/libc/libc/libc_5.4.46.orig.tar.gz

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
