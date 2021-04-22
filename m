Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0D368740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbhDVTgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 15:36:23 -0400
Received: from namei.org ([65.99.196.166]:49506 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236668AbhDVTgW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:36:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 43A291446;
        Thu, 22 Apr 2021 19:31:53 +0000 (UTC)
Date:   Fri, 23 Apr 2021 05:31:53 +1000 (AEST)
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
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v34 00/13] Landlock LSM
In-Reply-To: <20210422154123.13086-1-mic@digikod.net>
Message-ID: <9c775578-627c-e682-873a-ec7b763a7fcd@namei.org>
References: <20210422154123.13086-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1978797647-1619119913=:395662"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1978797647-1619119913=:395662
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 22 Apr 2021, Mickaël Salaün wrote:

> Hi,
> 
> This updated patch series adds a new patch on top of the previous ones.
> It brings a new flag to landlock_create_ruleset(2) that enables
> efficient and simple backward compatibility checks for future evolutions
> of Landlock (e.g. new access-control rights).

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git 
landlock_lsm_v34

and it replaces the v33 branch in next-testing.


-- 
James Morris
<jmorris@namei.org>

--1665246916-1978797647-1619119913=:395662--
