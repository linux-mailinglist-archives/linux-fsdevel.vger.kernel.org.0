Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31922C1B79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 03:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgKXCi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 21:38:57 -0500
Received: from namei.org ([65.99.196.166]:55480 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgKXCi5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:38:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AO2c09B015621;
        Tue, 24 Nov 2020 02:38:00 GMT
Date:   Tue, 24 Nov 2020 13:38:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Jann Horn <jannh@google.com>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v24 12/12] landlock: Add user and kernel documentation
In-Reply-To: <CAG48ez0S1_jd0YzXZ9tx94gU0sw-WeXgG336d=3YP7+iZvRgaA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2011241337530.26713@namei.org>
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-13-mic@digikod.net> <CAG48ez0S1_jd0YzXZ9tx94gU0sw-WeXgG336d=3YP7+iZvRgaA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1736655908-1606185482=:26713"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1736655908-1606185482=:26713
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 21 Nov 2020, Jann Horn wrote:

> On Thu, Nov 12, 2020 at 9:52 PM Mickaël Salaün <mic@digikod.net> wrote:
> > This documentation can be built with the Sphinx framework.
> >
> > Cc: James Morris <jmorris@namei.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Serge E. Hallyn <serge@hallyn.com>
> > Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> > Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
> 
> Reviewed-by: Jann Horn <jannh@google.com>
> 

Thanks, Jann!

-- 
James Morris
<jmorris@namei.org>

--1665246916-1736655908-1606185482=:26713--
