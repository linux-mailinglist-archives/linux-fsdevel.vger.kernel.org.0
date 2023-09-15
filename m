Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDFE7A12AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIOBA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 21:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjIOBA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:00:28 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE91FE8;
        Thu, 14 Sep 2023 18:00:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7E9C83200981;
        Thu, 14 Sep 2023 21:00:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Sep 2023 21:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694739622; x=1694826022; bh=EMHXuxFrQtckqm0xBirePySXvbt3CcrfaVO
        hphckfLs=; b=HSsubA7dfjwk6/cnRxTOQ0uirFf9Gu9PicIpc0IRzOcjsTAgrM5
        f9LKB8B2XA1qgUXBC19ILZ+KPUBEHWMF+tO5JQpfZsgHhGAp2XIZ5BR1Z3Ji+B9+
        pYVFeUqTas32nfcvStjyb0WJTZzIEHPVKQdQK+KWFFj9ocZ6+Kv3vzPk+hieoybW
        WyKGz2IehR2fd7BJAfrKPOCnKHTEtzbEz1/Vao/2zVNjCIDiMeF/NgLhEbDky/nq
        /o1scyxxoMCkQv1FjDL7dG7PvVMjomd1rlcQuYymUykPaywU0BLeSMkHSEIiWHDz
        yepwHMQroaqQJDLn/jUtQHWYvYKbxYh+EEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694739622; x=1694826022; bh=EMHXuxFrQtckqm0xBirePySXvbt3CcrfaVO
        hphckfLs=; b=Nt7Fvwzydx2kf2ZlM99uXFbynkHXouVezinuEF4/PTj/k76DHsC
        P5rwjgrGV12XIFgbv4fzBgw545a0QLrcezFuwGFQ6A+966qMZv/WAbUns471wNec
        99StB9hlwq8VNbD71QLnp6x/MPfS5qyDhxPJp5DPHFYB+a7eLSX8baaODA5rwBKF
        xvp40kK+h34T6obof8MoB/PG8j7Y4l9YKf6IK4FRbI8yV7PQSwWqyg2iRfNKHOSu
        /KeWZEMPv8ZPeCBeQxr41vbfg3UBUDKS05xkev9KUV4WHgZkOsFFvBNTziNzRTLn
        sMQYvdmLg4RmlOXjZ4L8ITEWCEVMoQjpdLg==
X-ME-Sender: <xms:pawDZTcVZn0mGWVJHBbsXK2cG1yWizqeNp22pUKpfMQXOm8UvOfIjA>
    <xme:pawDZZOOMKSJ0rbt-xqhAUVz1qwKkshufkpDTWYCu0YhoebEfTt5Akg7JC4A36_07
    2WzoJ83Qla7>
X-ME-Received: <xmr:pawDZcgeqWnzF4m3ZkQJJ3tZmeP37meqJPJHNolB-1K9YXeOgErMW5lpPplh3JZ6RoCQCtKhbMFGYvdnYNxZZaM95pHbg80zmsWj3d4kwjT2mmRrsN1H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:pawDZU837QMEysNG0ioEKHukPPbEMoT4GDKgwipwSaEkuogsjgc8CQ>
    <xmx:pawDZftKyYaxD8Ij_ZXAFpMQYNOQu9wg6E5d0SHhJsbP3NKqVNuS2w>
    <xmx:pawDZTELXYe1iY6P5XUrYeIVuDh7aauNznM4lwhum3Bn3KOkkHEMNg>
    <xmx:pqwDZdLJiqa_bTptbahE4YBkaXLP8fPoRQVjuHsZg38ub1XvtCcsfw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 21:00:16 -0400 (EDT)
Message-ID: <eec71402-f347-fd86-6c9e-06b78c1ed2eb@themaw.net>
Date:   Fri, 15 Sep 2023 09:00:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/3] add listmnt(2) syscall
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-4-mszeredi@redhat.com>
 <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOQ4uxh4ETADj7cD56d=8+0t7L_DHaSQpoPGHmwHFqCreOQjdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/9/23 14:00, Amir Goldstein wrote:
> On Wed, Sep 13, 2023 at 6:22 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>> Add way to query the children of a particular mount.  This is a more
>> flexible way to iterate the mount tree than having to parse the complete
>> /proc/self/mountinfo.
>>
>> Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
>> needs to be queried based on path, then statx(2) can be used to first query
>> the mount ID belonging to the path.
>>
>> Return an array of new (64bit) mount ID's.  Without privileges only mounts
>> are listed which are reachable from the task's root.
>>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>>   fs/namespace.c                         | 51 ++++++++++++++++++++++++++
>>   include/linux/syscalls.h               |  2 +
>>   include/uapi/asm-generic/unistd.h      |  5 ++-
>>   4 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 6d807c30cd16..0d9a47b0ce9b 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -376,6 +376,7 @@
>>   452    common  fchmodat2               sys_fchmodat2
>>   453    64      map_shadow_stack        sys_map_shadow_stack
>>   454    common  statmnt                 sys_statmnt
>> +455    common  listmnt                 sys_listmnt
>>
>>   #
>>   # Due to a historical design error, certain syscalls are numbered differently
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 088a52043bba..5362b1ffb26f 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -4988,6 +4988,57 @@ SYSCALL_DEFINE5(statmnt, u64, mnt_id,
>>          return err;
>>   }
>>
>> +static long do_listmnt(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
>> +                     const struct path *root)
>> +{
>> +       struct mount *r, *m = real_mount(mnt);
>> +       struct path rootmnt = { .mnt = root->mnt, .dentry = root->mnt->mnt_root };
>> +       long ctr = 0;
>> +
>> +       if (!capable(CAP_SYS_ADMIN) &&
>> +           !is_path_reachable(m, mnt->mnt_root, &rootmnt))
>> +               return -EPERM;
>> +
>> +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
>> +               if (!capable(CAP_SYS_ADMIN) &&
>> +                   !is_path_reachable(r, r->mnt.mnt_root, root))
>> +                       continue;
>> +
>> +               if (ctr >= bufsize)
>> +                       return -EOVERFLOW;
>> +               if (put_user(r->mnt_id_unique, buf + ctr))
>> +                       return -EFAULT;
>> +               ctr++;
>> +               if (ctr < 0)
>> +                       return -ERANGE;
> I think it'd be good for userspace to be able to query required
> bufsize with NULL buf, listattr style, rather than having to
> guess and re-guess on EOVERFLOW.

Agreed, I also think that would be useful.


Ian

