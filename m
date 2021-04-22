Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4783686FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 21:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhDVTNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 15:13:17 -0400
Received: from namei.org ([65.99.196.166]:49432 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVTNQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:13:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 15803508;
        Thu, 22 Apr 2021 19:08:47 +0000 (UTC)
Date:   Fri, 23 Apr 2021 05:08:46 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v34 08/13] landlock: Add syscall implementations
In-Reply-To: <20210422154123.13086-9-mic@digikod.net>
Message-ID: <d4684742-452b-6e88-dd51-f1e9c29cb34d@namei.org>
References: <20210422154123.13086-1-mic@digikod.net> <20210422154123.13086-9-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-299225943-1619118527=:394812"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-299225943-1619118527=:394812
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Apr 2021, Mickaël Salaün wrote:

> +
> +	/* No flag for now. */
> +	if (flags)
> +		return -EINVAL;

Good, returning an error here instead of ignoring it is the right 
approach, so apps don't start using this and then break later.


-- 
James Morris
<jmorris@namei.org>

--1665246916-299225943-1619118527=:394812--
