Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84DA3FB4D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfKMQTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:19:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36217 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfKMQTW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:19:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so3258969lja.3;
        Wed, 13 Nov 2019 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7q0LZz55qiLXCLO3cYRIglXjE7xsHXGROHGLHX16zOY=;
        b=hCupdneRc9+s4dAK+Uu58Ry5YbKYmoYjF0nknVFegxtEwSk7SvIPlUSjfllkcTwmfb
         nwk6vHpy/hOl+pxSL/NoPFQOPN2q9EDG+AdFR4z7QH4Qkavzkp0OPGfwYcLbvG6MJndi
         D0yAuqHYGQAbFY2O0PLJPtkD0ITp6rUVRM2J6Sfu0R6ccOAKDTmHtEkkIj8/BFfge1E3
         iyrzA8CiGd5G2fax9ZNz2D6X8Ky1SGsdtzBhsNYlvzThUB9L/8dxPQgrNighakb4gWoH
         3hbPN/wtOiEGwMANw0VnNKWWpVxZLL2At+VzR3lfuy1VeA4ADdZo47tCRQs23NjE97xP
         VwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7q0LZz55qiLXCLO3cYRIglXjE7xsHXGROHGLHX16zOY=;
        b=KuvFLmTGdYsgkOCO+14jiqY3FsHTvrWe4FT0/dNMCX+6UDbOWrymYYqP3qqHw+mhCA
         nGVZ8xz2CkkmGvGpY9hBV3vU9lIuWt/oA3x9Mx3mhjv+HHQR+zbuwmQnjdvoQtVgWQmN
         P9bzR8dGF18iF2US6AdwftfI7rgMFT0lIXQh5yE0OcfqQXsgjsWxoRVV7M/4LEnGU3r/
         l6AEbF0hV/fOblxpSloQJlnkgrcGKANa5DMjfPG5s0oWLhDEjR3Zjvdm5wOcsoqneWNL
         bA47Z6Rnot/o9aHfzY2IiEmImLu7oj4KFEB7T4DdtxHJvK4rbOw8bV1Si7jOiAPKa3iU
         5tqQ==
X-Gm-Message-State: APjAAAVujk9e3jXoI2iJaaOEh3CqQdvUhCmgt3TnWzaeFpqYlYJKa0ER
        /wLMymXfc6Pi2+meoOCJsm0=
X-Google-Smtp-Source: APXvYqxXw+EGCcS+eCaEOXxYLXSmU8MWKfnJwqd5tsR6aVrY3Zs4KN3r+06UIIxjBGrWB/r3cUTMDQ==
X-Received: by 2002:a2e:b163:: with SMTP id a3mr3177191ljm.72.1573661959688;
        Wed, 13 Nov 2019 08:19:19 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id 186sm1372730lfb.28.2019.11.13.08.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:19:19 -0800 (PST)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Jann Horn <jannh@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191112232239.yevpeemgxz4wy32b@wittgenstein>
 <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <13bc7935-8341-bb49-74ea-2eb58f72fd1f@gmail.com>
Date:   Wed, 13 Nov 2019 18:19:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.11.2019 18.00, Jann Horn wrote:
> On Wed, Nov 13, 2019 at 12:22 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
>> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
>>> Several items in /proc/sys need not be accessible to unprivileged
>>> tasks. Let the system administrator change the permissions, but only
>>> to more restrictive modes than what the sysctl tables allow.
>>>
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>> ---
>>>   fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
>>>   1 file changed, 31 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>> index d80989b6c344..88c4ca7d2782 100644
>>> --- a/fs/proc/proc_sysctl.c
>>> +++ b/fs/proc/proc_sysctl.c
>>> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
>>> mask)
>>>          if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>>>                  return -EACCES;
>>>
>>> +       error = generic_permission(inode, mask);
>>> +       if (error)
>>> +               return error;
> 
> In kernel/ucount.c, the ->permissions handler set_permissions() grants
> access based on whether the caller has CAP_SYS_RESOURCE. And in
> net/sysctl_net.c, the handler net_ctl_permissions() grants access
> based on whether the caller has CAP_NET_ADMIN. This added check is
> going to break those, right?
> 

Right. The comment above seems then a bit misleading:
	/*
	 * sysctl entries that are not writeable,
	 * are _NOT_ writeable, capabilities or not.
	 */

-Topi
