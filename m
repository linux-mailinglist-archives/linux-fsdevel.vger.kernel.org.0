Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4727BA190
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjJEOmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjJEOhD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0B73F016;
        Thu,  5 Oct 2023 07:02:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 08D525C025F;
        Thu,  5 Oct 2023 00:23:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Oct 2023 00:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696479821; x=1696566221; bh=Z9/BddHtqtTSTcngqikz3LcXGL1B2ri4Bu8
        DyrtBFpA=; b=ZATk2PEGSVbByPxxMHhCET54U+sK7GsAptaPN938K3RVWhuGZ5y
        1MPF+9p64wEAdmCwLrRQXrxD/Z8DVIFcnUnqWreXfhPid6+S7dKJ/TEGIN/wGi+b
        w7UeuMfX/bLTSQO+fVc34VBq1wO1dUgJOvxF0tpJTnyQf5cE3IPdC2sYfKA0jAjG
        5+IYUWyKC3qnAOwJfJdm5vsBkqiziGe+7EGb5i4r5JXCRTl9hWca88GkjTghPVez
        acMX6X1LbL2muWnR1934QI1V9CGQfyDgJAgufvqQ2Kw6mzMfrzzzygVbLH2Ee0dr
        54v+p6eYw+ouexAq5fVz/hwiI28hqHXDmsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696479821; x=1696566221; bh=Z9/BddHtqtTSTcngqikz3LcXGL1B2ri4Bu8
        DyrtBFpA=; b=l1tqXNRK10fDiiVcNwtJA0uOc/5R0o5gnOO61e6/GXPLBmaxAmP
        Oes8qYtqeVZfnPgVVCdc+RXPh8Gw9bfax7tqiszQxZsc85fSVpprBRMLvFkJmvnH
        AhuqzooUTZ3Ah1sL4WvIfKU7IApqwjqXF/qoM9FYe9hU9wotxuQwckbMOMgEs8JM
        TWOrzse4ZMt0lJw+bjUgBvNWj8zsbaiaoj4aFj16uOh6cmN1xnxFqsMEU0vEg1qx
        BnLb9yq7cETJbSx70aGg7piPq5Ve5NY2TfQmWSplWeVPXzqFIsG5cJ8txrx7Ofi+
        zpApTEwfl5TEODfW27Y5c9DHpS3Oza52BjQ==
X-ME-Sender: <xms:SzoeZVQem9RMqeDhYeJaTvhJcFyq8Erl84K7YNXvrekTeVeuRl77JQ>
    <xme:SzoeZex9sfi01AN7RobO41A27ETMlq08vkJbH__Szc2EzG4-TijY3Rs1Donu3wGlw
    2oRFxP9O-RN>
X-ME-Received: <xmr:SzoeZa39pA9oM1GJ4l2oTNh7mzcWmIitokwjaPOcg3v-vpVeSsY8LGcWiTNs_xPb6X8aH0DdfOhih5BftqSNWevnZ0dPSJDOjZDm1mo-eBNYrvT9r9S8pdCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egvdetvedvfeeivdeuueejgeetvdehlefhheethfekgfejueffgeeugfekudfhjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:SzoeZdDciAtZwRk0Yzved4E9M2AnwsGT0W61S7IhiM0cqL1pTlvSgQ>
    <xmx:SzoeZeiorAuaxLm_o3gm8qM5bD_cHVJOcDx1E1A_txs2tFOUDKYmXg>
    <xmx:SzoeZRr3Cn8PLYe1aG08RrTR45DiIX7qCZO690Qp2De1v4Np-NTcwg>
    <xmx:TToeZe5FzehY4x2bDePAxtenrqdu9Dbp12yeuFC_F0HeclaNBJgGDg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Oct 2023 00:23:33 -0400 (EDT)
Message-ID: <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net>
Date:   Thu, 5 Oct 2023 12:23:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230928130147.564503-1-mszeredi@redhat.com>
 <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/23 12:01, Miklos Szeredi wrote:
> On Wed, 4 Oct 2023 at 21:38, Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Sep 28, 2023 at 9:04 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>>> Add way to query the children of a particular mount.  This is a more
>>> flexible way to iterate the mount tree than having to parse the complete
>>> /proc/self/mountinfo.
>>>
>>> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
>>> based on path, then statx(2) can be used to first query the mount ID
>>> belonging to the path.
>>>
>>> Return an array of new (64bit) mount ID's.  Without privileges only mounts
>>> are listed which are reachable from the task's root.
>>>
>>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>>> ---
>>>   arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>>>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>>>   fs/namespace.c                         | 69 ++++++++++++++++++++++++++
>>>   include/linux/syscalls.h               |  3 ++
>>>   include/uapi/asm-generic/unistd.h      |  5 +-
>>>   include/uapi/linux/mount.h             |  3 ++
>>>   6 files changed, 81 insertions(+), 1 deletion(-)
>> ...
>>
>>> diff --git a/fs/namespace.c b/fs/namespace.c
>>> index 3326ba2b2810..050e2d2af110 100644
>>> --- a/fs/namespace.c
>>> +++ b/fs/namespace.c
>>> @@ -4970,6 +4970,75 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
>>>          return ret;
>>>   }
>>>
>>> +static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
>>> +                        const struct path *root, unsigned int flags)
>>> +{
>>> +       struct mount *r, *m = real_mount(mnt);
>>> +       struct path rootmnt = {
>>> +               .mnt = root->mnt,
>>> +               .dentry = root->mnt->mnt_root
>>> +       };
>>> +       long ctr = 0;
>>> +       bool reachable_only = true;
>>> +       int err;
>>> +
>>> +       err = security_sb_statfs(mnt->mnt_root);
>>> +       if (err)
>>> +               return err;
>>> +
>>> +       if (flags & LISTMOUNT_UNREACHABLE) {
>>> +               if (!capable(CAP_SYS_ADMIN))
>>> +                       return -EPERM;
>>> +               reachable_only = false;
>>> +       }
>>> +
>>> +       if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
>>> +               return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
>>> +
>>> +       list_for_each_entry(r, &m->mnt_mounts, mnt_child) {
>>> +               if (reachable_only &&
>>> +                   !is_path_reachable(r, r->mnt.mnt_root, root))
>>> +                       continue;
>> I believe we would want to move the security_sb_statfs() call from
>> above to down here; something like this I think ...
>>
>>    err = security_sb_statfs(r->mnt.mnt_root);
>>    if (err)
>>      /* if we can't access the mount, pretend it doesn't exist */
>>      continue;
> Hmm.  Why is this specific to listing mounts (i.e. why doesn't readdir
> have a similar filter)?
>
> Also why hasn't this come up with regards to the proc interfaces that
> list mounts?

The proc interfaces essentially use <mount namespace>->list to provide

the mounts that can be seen so it's filtered by mount namespace of the

task that's doing the open().


See fs/namespace.c:mnt_list_next() and just below the m_start(), m_next(),

etc.


Ian

>
> I just want to understand the big picture here.
>
> Thanks,
> Miklos
