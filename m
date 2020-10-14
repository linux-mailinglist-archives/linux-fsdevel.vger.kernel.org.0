Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB228E603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgJNSIO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 14:08:14 -0400
Received: from namei.org ([65.99.196.166]:35594 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgJNSIN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:08:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 09EI7CpI027390;
        Wed, 14 Oct 2020 18:07:13 GMT
Date:   Thu, 15 Oct 2020 05:07:12 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v21 07/12] landlock: Support filesystem access-control
In-Reply-To: <20201008153103.1155388-8-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2010150504360.26012@namei.org>
References: <20201008153103.1155388-1-mic@digikod.net> <20201008153103.1155388-8-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-928235661-1602698835=:26012"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-928235661-1602698835=:26012
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 8 Oct 2020, Mickaël Salaün wrote:

> +config ARCH_EPHEMERAL_STATES
> +	def_bool n
> +	help
> +	  An arch should select this symbol if it does not keep an internal kernel
> +	  state for kernel objects such as inodes, but instead relies on something
> +	  else (e.g. the host kernel for an UML kernel).
> +

This is used to disable Landlock for UML, correct? I wonder if it could be 
more specific: "ephemeral states" is a very broad term.

How about something like ARCH_OWN_INODES ?


-- 
James Morris
<jmorris@namei.org>

--1665246916-928235661-1602698835=:26012--
