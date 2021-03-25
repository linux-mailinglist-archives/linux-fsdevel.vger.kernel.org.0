Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53511348CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCYJ3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 05:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCYJ3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:29:08 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B08C061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 02:29:03 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F5ftj1bChzMqSFq;
        Thu, 25 Mar 2021 10:29:01 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4F5ftZ3sl9zlh8TD;
        Thu, 25 Mar 2021 10:28:54 +0100 (CET)
Subject: Re: [PATCH v30 02/12] landlock: Add ruleset and domain management
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-3-mic@digikod.net> <202103191114.C87C5E2B69@keescook>
 <acda4be1-4076-a31d-fcfd-27764dd598c8@digikod.net>
 <c9dc8adb-7fab-14a1-a658-40b288419fdf@namei.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <25f701bf-fddf-8e9c-1ac1-c50a38579096@digikod.net>
Date:   Thu, 25 Mar 2021 10:29:35 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <c9dc8adb-7fab-14a1-a658-40b288419fdf@namei.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 24/03/2021 21:31, James Morris wrote:
> On Fri, 19 Mar 2021, Mickaël Salaün wrote:
> 
>>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> Acked-by: Serge Hallyn <serge@hallyn.com>
>>>> Link: https://lore.kernel.org/r/20210316204252.427806-3-mic@digikod.net
>>>
>>> (Aside: you appear to be self-adding your Link: tags -- AIUI, this is
>>> normally done by whoever pulls your series. I've only seen Link: tags
>>> added when needing to refer to something else not included in the
>>> series.)
>>
>> It is an insurance to not lose history. :)
> 
> How will history be lost? The code is in the repo and discussions can 
> easily be found by searching for subjects or message IDs.

The (full and ordered) history may be hard to find without any
Message-ID in commit messages. The Lore links keep that information (in
the commit message) and redirect to the related archived email thread,
which is very handy. For instance, Linus can rely on those links to
judge the quality of a patch:
https://lore.kernel.org/lkml/CAHk-=wh7xY3UF7zEc0BNVNjOox59jYBW-Gfi7=emm+BXPWc6nQ@mail.gmail.com/

> 
> Is anyone else doing this self linking?
> 

I don't know, but it doesn't hurt. This way, if you're using git am
without b4 am -l (or forgot to add links manually), the history is still
pointed out by these self-reference links. I find it convenient and it
is a safeguard to not forget them, no matter who takes the patches.
