Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7211D2552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 05:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENDKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 23:10:05 -0400
Received: from namei.org ([65.99.196.166]:58830 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgENDKE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 23:10:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04E39WDY032357;
        Thu, 14 May 2020 03:09:32 GMT
Date:   Thu, 14 May 2020 13:09:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v17 02/10] landlock: Add ruleset and domain management
In-Reply-To: <20200511192156.1618284-3-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2005141302330.30052@namei.org>
References: <20200511192156.1618284-1-mic@digikod.net> <20200511192156.1618284-3-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-408680353-1589425772=:30052"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-408680353-1589425772=:30052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 May 2020, Mickaël Salaün wrote:

> + * .. warning::
> + *
> + *   It is currently not possible to restrict some file-related actions
> + *   accessible through these syscall families: :manpage:`chdir(2)`,
> + *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> + *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`.
> + *   Future Landlock evolutions will enable to restrict them.

I have to wonder how useful Landlock will be without more coverage per 
the above.

It would be helpful if you could outline a threat model for this initial 
version, so people can get an idea of what kind of useful protection may
be gained from it.

Are there any distros or other major users who are planning on enabling or 
at least investigating Landlock?

Do you have any examples of a practical application of this scheme?



-- 
James Morris
<jmorris@namei.org>

--1665246916-408680353-1589425772=:30052--
