Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA681D2577
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 05:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENDiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 23:38:21 -0400
Received: from namei.org ([65.99.196.166]:58860 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENDiU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 23:38:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 04E3bnC3001625;
        Thu, 14 May 2020 03:37:49 GMT
Date:   Thu, 14 May 2020 13:37:49 +1000 (AEST)
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
Subject: Re: [PATCH v17 05/10] fs,landlock: Support filesystem
 access-control
In-Reply-To: <20200511192156.1618284-6-mic@digikod.net>
Message-ID: <alpine.LRH.2.21.2005141335280.30052@namei.org>
References: <20200511192156.1618284-1-mic@digikod.net> <20200511192156.1618284-6-mic@digikod.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-1014880157-1589427470=:30052"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1014880157-1589427470=:30052
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 May 2020, Mickaël Salaün wrote:


> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 45cc10cdf6dd..2276642f8e05 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1517,6 +1517,11 @@ struct super_block {
>  	/* Pending fsnotify inode refs */
>  	atomic_long_t s_fsnotify_inode_refs;
>  
> +#ifdef CONFIG_SECURITY_LANDLOCK
> +	/* References to Landlock underlying objects */
> +	atomic_long_t s_landlock_inode_refs;
> +#endif
> +

This needs to be converted to the LSM API via superblock blob stacking.

See Casey's old patch: 
https://lore.kernel.org/linux-security-module/20190829232935.7099-2-casey@schaufler-ca.com/



-- 
James Morris
<jmorris@namei.org>

--1665246916-1014880157-1589427470=:30052--
