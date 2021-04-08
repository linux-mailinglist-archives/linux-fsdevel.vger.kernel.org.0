Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442C358E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 22:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhDHUcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 16:32:25 -0400
Received: from namei.org ([65.99.196.166]:37518 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhDHUcY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:32:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 0EC185A6;
        Thu,  8 Apr 2021 20:28:45 +0000 (UTC)
Date:   Fri, 9 Apr 2021 06:28:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
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
Subject: Re: [PATCH v33 07/12] landlock: Support filesystem access-control
In-Reply-To: <20210407160726.542794-8-mic@digikod.net>
Message-ID: <5f4dfa1-f9ac-f31f-3237-dcf976cabbfc@namei.org>
References: <20210407160726.542794-1-mic@digikod.net> <20210407160726.542794-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-304441139-1617913725=:4030621"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-304441139-1617913725=:4030621
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Apr 2021, Mickaël Salaün wrote:

> Changes since v31:
> * Gracefully forbid reparenting by returning EXDEV in hook_path_link()
>   and hook_path_rename() (hinted by Al Viro).
> * Replace excessive WARN_ON_ONCE() with unlikely() in
>   hook_path_rename() and use ENOENT instead of EACCES.
> * Improve comment in unmask_layers() (pointed out by Al Viro).  Also use
>   filesystem "topology" instead of "layout", which seems more
>   appropriate.
> * Add access(2) to the documented list of unsupported syscall families.
> * Replace "option" with "flag" in hook_sb_mount() comment.

Good to see these changes.

Al: any further comments now on this patch?

-- 
James Morris
<jmorris@namei.org>

--1665246916-304441139-1617913725=:4030621--
