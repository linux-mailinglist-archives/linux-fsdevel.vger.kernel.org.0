Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB1129E1AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbgJ2CDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:03:02 -0400
Received: from namei.org ([65.99.196.166]:38520 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgJ1Vsp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09S5USYt026992;
        Wed, 28 Oct 2020 05:30:28 GMT
Date:   Wed, 28 Oct 2020 16:30:28 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH v22 06/12] fs,security: Add sb_delete hook
In-Reply-To: <20201027200358.557003-7-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2010281630040.25689@namei.org>
References: <20201027200358.557003-1-mic@digikod.net> <20201027200358.557003-7-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1320537407-1603863028=:25689"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1320537407-1603863028=:25689
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Oct 2020, Mickaël Salaün wrote:

> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> The sb_delete security hook is called when shutting down a superblock,
> which may be useful to release kernel objects tied to the superblock's
> lifetime (e.g. inodes).
> 
> This new hook is needed by Landlock to release (ephemerally) tagged
> struct inodes.  This comes from the unprivileged nature of Landlock
> described in the next commit.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Al, Kees, JJ et al, any objections?

-- 
James Morris
<jmorris@namei.org>

--1665246916-1320537407-1603863028=:25689--
