Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09406BC60D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 07:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCPGU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 02:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCPGU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:20:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B46FFE3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 23:20:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so356179pjp.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1678947625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wPR3q9bhQ1Pb4cLYVjM+WMJHH4UrfvHRDpmSQYh45Q=;
        b=ymrJCkke34gatJF/WH2IEEsOT5dLOKyOnvtWiWzV+wHUrPC5FQvAXkNGI5hq5cXPuQ
         0Vz782hbeFiIJBezDDH12SLc3jeuiQmldXWW8DH3oScWP+AdyMvKTEqxeBN6lxnRzjjj
         YQSkhmxi+5qDkFvzGGAErh5yrF4PLvOrdOSDN4qREYRw1Ee2iA2r2jXfw4q7iEYU1Dtn
         yUokH7W/tOybOKAYTAHWz6vAOp087Txz++i6Pbj9yFaIKegtSmzZtsrphHgv6UXX/G0m
         3jkFpSuc1TVEmfW96U/RwZdRgKRdWVHlBjVbQ6l6d+TvgQZNyzn6YrX9cHDl6LQDks/X
         BwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678947625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wPR3q9bhQ1Pb4cLYVjM+WMJHH4UrfvHRDpmSQYh45Q=;
        b=nqg9Oc1PNE8Z6fMLAVKwlkMa8dzZlIEsLFgH0jW4kWqiooHfECCVh3o5vtWT34dVOy
         IBgW/zAMxUs083Ua/H2FVJuA9R9w+krtlS+x2NV3mkEBTZ/zT01ZV04rBSPSiiglAMQk
         gWxlAAsX4yekE4fiW4srXzPZ560a6HOZaJD0F4zYN1aaxvKzdiHR1rstcUa2GIyOIFXP
         FQP234AlUygJvCwT1AzNw1p3QDbNOI9jiFs8A+jWb06LsUg+U5o7CDmoeG3OdoEujRsW
         KaDNZtLY0mmnzIWCucFkCY0IaTaXvLaparoY2qAgec6JYGMFOp8joMFO5AAnJwbmNUji
         4xvg==
X-Gm-Message-State: AO0yUKVLgz90a4rZ+gbceykf9TyavnJb2RLgfCbCr/4sN+q3HvfIwaIv
        qo/wrxAWSBshbMwAzMYLUMWO1Q==
X-Google-Smtp-Source: AK7set88RbQAZgVcArFixTGK4YC3GudAAxJKDA1JIEFoZI7mAR8cFVq1mva99DmtADR8ZlR37cOLCg==
X-Received: by 2002:a17:902:e38c:b0:19d:19fb:55ec with SMTP id g12-20020a170902e38c00b0019d19fb55ecmr1583739ple.6.1678947625286;
        Wed, 15 Mar 2023 23:20:25 -0700 (PDT)
Received: from [10.41.0.90] ([199.254.238.56])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b00195f242d0a0sm4622211pla.194.2023.03.15.23.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 23:20:24 -0700 (PDT)
Message-ID: <b0e04468-f313-047d-5bde-785bb826599b@efficientek.com>
Date:   Thu, 16 Mar 2023 06:20:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2] hostfs: handle idmapped mounts
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
References: <20230301015002.2402544-1-development@efficientek.com>
 <20230302083928.zek46ybxvuwgwdf5@wittgenstein>
 <20230304002846.48278199@crass-HP-ZBook-15-G2>
 <20230304120118.bhbilwzhmjt72fok@wittgenstein>
From:   Glenn Washburn <development@efficientek.com>
In-Reply-To: <20230304120118.bhbilwzhmjt72fok@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/23 12:01, Christian Brauner wrote:
> On Sat, Mar 04, 2023 at 12:28:46AM -0600, Glenn Washburn wrote:
>> On Thu, 2 Mar 2023 09:39:28 +0100
>> Christian Brauner <brauner@kernel.org> wrote:
>>
>>> On Tue, Feb 28, 2023 at 07:50:02PM -0600, Glenn Washburn wrote:
>>>> Let hostfs handle idmapped mounts. This allows to have the same
>>>> hostfs mount appear in multiple locations with different id
>>>> mappings.
>>>>
>>>> root@(none):/media# id
>>>> uid=0(root) gid=0(root) groups=0(root)
>>>> root@(none):/media# mkdir mnt idmapped
>>>> root@(none):/media# mount -thostfs -o/home/user hostfs mnt
>>>>
>>>> root@(none):/media# touch mnt/aaa
>>>> root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1
>>>> --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
>>>> root@(none):/media# ls -l mnt/aaa idmapped/aaa -rw-r--r-- 1 root
>>>> root 0 Jan 28 01:23 idmapped/aaa -rw-r--r-- 1 user user 0 Jan 28
>>>> 01:23 mnt/aaa
>>>>
>>>> root@(none):/media# touch idmapped/bbb
>>>> root@(none):/media# ls -l mnt/bbb idmapped/bbb
>>>> -rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
>>>> -rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb
>>>>
>>>> Signed-off-by: Glenn Washburn <development@efficientek.com>
>>>> ---
>>>> Changes from v1:
>>>>   * Rebase on to tip. The above commands work and have the results
>>>> expected. The __vfsuid_val(make_vfsuid(...)) seems ugly to get the
>>>> uid_t, but it seemed like the best one I've come across. Is there a
>>>> better way?
>>>
>>> Sure, I can help you with that. ;)
>>
>> Thank you!
>>
>>>>
>>>> Glenn
>>>> ---
>>>>   fs/hostfs/hostfs_kern.c | 13 +++++++------
>>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
>>>> index c18bb50c31b6..9459da99a0db 100644
>>>> --- a/fs/hostfs/hostfs_kern.c
>>>> +++ b/fs/hostfs/hostfs_kern.c
>>>> @@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap
>>>> *idmap, err = access_file(name, r, w, x);
>>>>   	__putname(name);
>>>>   	if (!err)
>>>> -		err = generic_permission(&nop_mnt_idmap, ino,
>>>> desired);
>>>> +		err = generic_permission(idmap, ino, desired);
>>>>   	return err;
>>>>   }
>>>>   
>>>> @@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap
>>>> *idmap, struct dentry *dentry, struct iattr *attr)
>>>>   {
>>>>   	struct inode *inode = d_inode(dentry);
>>>> +	struct user_namespace *fs_userns = i_user_ns(inode);
>>>
>>> Fyi, since hostfs can't be mounted in a user namespace
>>> fs_userns == &init_user_ns
>>> so it doesn't really matter what you use.
>>
>> What would you suggest as preferable?
> 
> I would leave init_user_ns hardcoded as it clearly indicates that hostfs
> can only be mounted in the initial user namespace. Plus, the patch is
> smaller.
> 
>>
>>>>   	struct hostfs_iattr attrs;
>>>>   	char *name;
>>>>   	int err;
>>>>   
>>>>   	int fd = HOSTFS_I(inode)->fd;
>>>>   
>>>> -	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
>>>> +	err = setattr_prepare(idmap, dentry, attr);
>>>>   	if (err)
>>>>   		return err;
>>>>   
>>>> @@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap
>>>> *idmap, }
>>>>   	if (attr->ia_valid & ATTR_UID) {
>>>>   		attrs.ia_valid |= HOSTFS_ATTR_UID;
>>>> -		attrs.ia_uid = from_kuid(&init_user_ns,
>>>> attr->ia_uid);
>>>> +		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap,
>>>> fs_userns, attr->ia_uid)); }
>>>>   	if (attr->ia_valid & ATTR_GID) {
>>>>   		attrs.ia_valid |= HOSTFS_ATTR_GID;
>>>> -		attrs.ia_gid = from_kgid(&init_user_ns,
>>>> attr->ia_gid);
>>>> +		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap,
>>>> fs_userns, attr->ia_gid));
>>>
>>> Heh, if you look include/linux/fs.h:
>>>
>>>          /*
>>>           * The two anonymous unions wrap structures with the same
>>> member. *
>>>           * Filesystems raising FS_ALLOW_IDMAP need to use
>>> ia_vfs{g,u}id which
>>>           * are a dedicated type requiring the filesystem to use the
>>> dedicated
>>>           * helpers. Other filesystem can continue to use ia_{g,u}id
>>> until they
>>>           * have been ported.
>>>           *
>>>           * They always contain the same value. In other words
>>> FS_ALLOW_IDMAP
>>>           * pass down the same value on idmapped mounts as they would
>>> on regular
>>>           * mounts.
>>>           */
>>>          union {
>>>                  kuid_t          ia_uid;
>>>                  vfsuid_t        ia_vfsuid;
>>>          };
>>>          union {
>>>                  kgid_t          ia_gid;
>>>                  vfsgid_t        ia_vfsgid;
>>>          };
>>>
>>> this just is:
>>>
>>> attrs.ia_uid = from_vfsuid(idmap, fs_userns, attr->ia_vfsuid));
>>> attrs.ia_gid = from_vfsgid(idmap, fs_userns, attr->ia_vfsgid));
>>
>> Its easy to miss from this patch because of lack of context, but attrs
>> is a struct hostfs_iattr, not struct iattr. And attrs.ia_uid is of type
>> uid_t, not kuid_t. So the above fails to compile. This is why I needed
> 
> Oh, I see. And then that raw value is used by calling
> fchmod()/chmod()/chown()/fchown() and so on. That's rather special.
> Ok, then I know what to do.
> 
>> to wrap make_vfsuid() in __vfsuid_val() (to get the uid_t).
> 
> Right. My point had been - independent of the struct hostfs_iattr issue
> you thankfully pointed out - that make_vfsuid() is wrong here.
> 
> make_vfsuid() is used to map a filesystem wide k{g,u}id_t according to
> the mount's idmapping that operation originated from. But that's done
> by the vfs way before we're calling into the filesystem. For example,
> it's done in chown_common().
> 
> So the value placed in struct iattr (the VFS struct) is already a
> vfs{g,u}id stored in iattr->ia_vfs{g,u}id. So you need to use
> from_vfs{g,u}id() here.
> 
>>
>> I had decided against using from_vfsuid() because then I thought I'd
>> need to use from_kuid() to get the uid_t. And from_kuid() takes the
>> namespace (again), which seemed uglier.
>>
>> Based on this, what do you suggest?
> 
> Ok, so just some details on the background before I paste what I think
> we should do.
> As soon as you support idmapped mounts you at least technically are
Thanks for the detailed explanation. I apologize for not getting back to 
this sooner.

> always dealing with two mappings:
> 
> (1) First, there's the filesystem wide idmapping which is taken from the
>      namespace the filessytem was mounted in. This idmapping is applied
>      when you read the raw uid/gid value from disk and turn into a kuid_t
>      type. That value is persistent and stored in inode->i_{g,u}id. All
>      things that are cached and that can be accessed from multiple mounts
>      concurrently can only ever cache k{g,u}id_t aka filesystem values.
> (2) Whenever we're dealing with an operation that's coming from an
>      idmapped mount we need to take the idmapping of the mount into
>      account. That idmapping is completely separate type struct
>      mnt_idmap that's opaque for filesystems and most of the vfs.
> 
>      That idmapping is used to generate the vfs{g,u}id_t. IOW, translates
>      from the filesystem representation to a mount/vfs representation.
> 
> So, in order to store the correct value on disk we need to invert those
> two idmappings to arrive at the raw value that we want to store:
> (U1) from_vfsuid() // map to the filesystem wide value aka something
>       that we can store in inode->i_{g,u}id and that's cacheable. This is
>       done in setattr_copy().
> (U2) from_kuid() // map the filesystem wide value to the raw value we
>       want to store on disk

It seems to me that there are actually 3 mappings, with the third being 
(U2) above (ie vfsuid_t -> kuid_t). And that from_vfsuid() does mappings 
(1) and (2) above. Is this incorrect?

Whats confusing to me is that from_vfsuid() takes both an idmap and a 
user namespace, so presumably it will handle both mapping types (1) and 
(2). And then there's from_kuid() which takes an idmap, so I thought it 
might also do a type (2) mapping. But looking at the code it doesn't 
seem to ever use its idmap parameter. Can you explain the rational 
behind having from_kuid() take an idmap? Is it legacy that will be 
cleaned up as this code settles down / stabilizes? Or perhaps its

> 
> For nearly all filesystems these steps almost never need to be performed
> explicitly. Instead, dedicated vfs helpers will do this:
> 
> (U1) i_{g,u}id_update() // map to filesystem wide value
> (U2) i_{g,u}id_read() // map to raw on-disk value
> 
> For filesystems that don't support being mounted in namespaces the (U2)
> step is always a nop. So technically there's no difference between:
> 
> (U2) from_kuid() and __kuid_val(kuid)
> 
> but it's cleaner to use the helpers even in that case.
> 
> So given how hostfs works these two steps need to be performed
> explicitly. So I suggest (untested):
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index c18bb50c31b6..72b7e1bcc32e 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -813,12 +813,22 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
>                  attrs.ia_mode = attr->ia_mode;
>          }
>          if (attr->ia_valid & ATTR_UID) {
> +               kuid_t kuid;
> +
>                  attrs.ia_valid |= HOSTFS_ATTR_UID;
> -               attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
> +               /* Map the vfs id into the filesystem. */
> +               kuid = from_vfsuid(idmap, &init_user_ns, attr->ia_vfsuid);
> +               /* Map the filesystem id to its raw on disk value. */
> +               attrs.ia_uid = from_kuid(&init_user_ns, kuid);

Its interesting that this is what I originally discarded, as an 
unfamiliar reader, it looks like you're doing two namespace mappings. 
But that's not happening because from_kuid() disregards its namespace 
parameter.

I've tested this and it does seems to work. Thanks!

Glenn

>          }
>          if (attr->ia_valid & ATTR_GID) {
> +               kgid_t kgid;
> +
>                  attrs.ia_valid |= HOSTFS_ATTR_GID;
> -               attrs.ia_gid = from_kgid(&init_user_ns, attr->ia_gid);
> +               /* Map the vfs id into the filesystem. */
> +               kgid = from_vfsgid(idmap, &init_user_ns, attr->ia_vfsgid);
> +               /* Map the filesystem id to its raw on disk value. */
> +               attrs.ia_gid = from_kgid(&init_user_ns, kgid);
>          }
>          if (attr->ia_valid & ATTR_SIZE) {
>                  attrs.ia_valid |= HOSTFS_ATTR_SIZE;

