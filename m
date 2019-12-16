Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F8121A87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLPUFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 15:05:32 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPUFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:05:31 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MMXYN-1iNLvi2f2t-00Jadv; Mon, 16 Dec 2019 21:05:05 +0100
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Greg Kurz <groug@kaod.org>, Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Henning Schild <henning.schild@siemens.com>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
References: <20191216091220.465626-1-laurent@vivier.eu>
 <20191216091220.465626-2-laurent@vivier.eu>
 <CAG48ez2xNCRmuzpNqYW5R+XMKzW8YiemsPUPgk42KSkSZXmvLg@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
Message-ID: <15d270a6-2264-adc5-3f56-fdb8b67ad267@vivier.eu>
Date:   Mon, 16 Dec 2019 21:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAG48ez2xNCRmuzpNqYW5R+XMKzW8YiemsPUPgk42KSkSZXmvLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K6VkjJJB4XpXh9Bhony50831o2928Yp72HCFAwyl4NuBakOa6lV
 hPfMJKDH+seZExY1aL3PjqWItt86RNcay9XowV4Rdz5Zxmhao2Qubnt16dYhoHlDW931FMz
 SE37db/vBEVesgmJp8AbUlynVNQr2k9Eg0ZgVmVjemPZ/+Vc5LeSf3XbaoYx4kPt98/SLJk
 4hrvvq8w4wPIoP1K4L1MQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2FvcbjYAgjI=:gqKq4uRAI824hPqGxinUbM
 TvKVVWk4YgLjzH2LWvHMpjw9vK0gcXNzoBe5IBVAZeofX1SqObZpPxWNpdjIraQlHlTm6r9IU
 bCVgs476GKVY38WfcvsmRfiSPkhbsnQDAiY8egNXP9/4Z3Y4v0EgbK6NXVxjH+H6cQsJn+Joj
 fKDIQ4vf/YDOriU6ii1yNKGT5o8lmSNNxk3EHK3Omd/+GPC2qF3lqzKjcl89SsJCukcuX46Pt
 HcI258ifPSJ17sqgLezcVAQjTDi+GJwRq2ZQ8YZNDlslUWJgHrfy20FU76WdUW80GW2bmErAb
 zOffOGpgxgFxf1d+xwdgOH1XhYNnV2Z7/ugQQ3wAbY2Ce/ZeAYoLLyyTxOArFkZdUI5ULfI00
 Mp9S7ftKB2KhRHtNRgC/iNPH9P7aLnY6H0oJAwoRiIa/5e1pQZvvzZkQfPBk6fwCJkI8Zl5KP
 PQpfjKgz4be4prarSintQyCm097sA9clFw/w4oAXpFor9f18/+Y5IxUmQyXinJhpBtyHyt69m
 bO5Nlry1xe378CbJvOc00UgEpUck5pfC/otW7phNikDn7p1VwmVV2R+pGuXhtwCzvr7j8uyL2
 VUNBfsnO91WiWVuvPuynnQr2heO2nOGFTYGotPKwa4/MlunmbqVMCTv6oQVM27yBVGYAIkZBO
 PJa8j8hPDvKg/WCWSsnsrW5LqA8DVjyRKleqMhEVQ0I7vMfHHNiFO7e0xmtFFyF9vy5hBYO2t
 7RbXn2gw35ry3AbgAFcz5DY6w1lNaKaMwvgi1ijYZsHpULKolF/Ng+6cZ3FxS9sTNlh6ipQZT
 6fa92bh2bbvPAEKLYevM52fEclAV2ZeDJrE333qa3c/C7KHdIiKsRHROBLMJ2Ez+kw193HxgF
 CCKK8LFY4nDZjFttnjug==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 16/12/2019 à 20:08, Jann Horn a écrit :
> On Mon, Dec 16, 2019 at 10:12 AM Laurent Vivier <laurent@vivier.eu> wrote:
>> This patch allows to have a different binfmt_misc configuration
>> for each new user namespace. By default, the binfmt_misc configuration
>> is the one of the previous level, but if the binfmt_misc filesystem is
>> mounted in the new namespace a new empty binfmt instance is created and
>> used in this namespace.
>>
>> For instance, using "unshare" we can start a chroot of another
>> architecture and configure the binfmt_misc interpreter without being root
>> to run the binaries in this chroot.
> 
> How do you ensure that when userspace is no longer using the user
> namespace and mount namespace, the entries and the binfmt_misc
> superblock are deleted? As far as I can tell from looking at the code,
> at the moment, if I create a user namespace+mount namespace, mount
> binfmt_misc in there, register a file format and then let all
> processes inside the namespaces exit, the binfmt_misc mount will be
> kept alive by the simple_pin_fs() stuff, and the binfmt_misc entries
> will also stay in memory.
> 
> [...]

Do you have any idea how I can fix this issue?

>> @@ -718,7 +736,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
>>         if (!inode)
>>                 goto out2;
>>
>> -       err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
>> +       ns = binfmt_ns(file_dentry(file)->d_sb->s_user_ns);
>> +       err = simple_pin_fs(&bm_fs_type, &ns->bm_mnt,
>> +                           &ns->entry_count);
> 
> When you call simple_pin_fs() here, the user namespace of `current`
> and the user namespace of the superblock are not necessarily related.
> So simple_pin_fs() may end up taking a reference on the mountpoint for
> a user namespace that has nothing to do with the namespace for which
> an entry is being created.

Do you have any idea how I can fix this issue?

> 
> [...]
>>  static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>>  {
>>         int err;
>> +       struct user_namespace *ns = sb->s_user_ns;
> [...]
>> +       /* create a new binfmt namespace
>> +        * if we are not in the first user namespace
>> +        * but the binfmt namespace is the first one
>> +        */
>> +       if (READ_ONCE(ns->binfmt_ns) == NULL) {
> 
> The READ_ONCE() here is unnecessary, right? AFAIK the VFS layer is
> going to ensure that bm_fill_super() can't run concurrently for the
> same namespace?

So I understand the "READ_ONCE()" is unnecessary and I will remove it.

> 
>> +               struct binfmt_namespace *new_ns;
>> +
>> +               new_ns = kmalloc(sizeof(struct binfmt_namespace),
>> +                                GFP_KERNEL);
>> +               if (new_ns == NULL)
>> +                       return -ENOMEM;
>> +               INIT_LIST_HEAD(&new_ns->entries);
>> +               new_ns->enabled = 1;
>> +               rwlock_init(&new_ns->entries_lock);
>> +               new_ns->bm_mnt = NULL;
>> +               new_ns->entry_count = 0;
>> +               /* ensure new_ns is completely initialized before sharing it */
>> +               smp_wmb();
>> +               WRITE_ONCE(ns->binfmt_ns, new_ns);
> 
> Nit: This would be a little bit semantically clearer if you used
> smp_store_release() instead of smp_wmb()+WRITE_ONCE().

I will.

> 
>> +       }
>> +
>>         err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
> [...]
>> +static void bm_free(struct fs_context *fc)
>> +{
>> +       if (fc->s_fs_info)
>> +               put_user_ns(fc->s_fs_info);
>> +}
> 
> Silly question: Why the "if"? Can you ever reach this with fc->s_fs_info==NULL?

So I understand the if is unnecessary and I will remove it.

> 
>> +
>>  static int bm_get_tree(struct fs_context *fc)
>>  {
>> -       return get_tree_single(fc, bm_fill_super);
>> +       return get_tree_keyed(fc, bm_fill_super, get_user_ns(fc->user_ns));
> 
> get_user_ns() increments the refcount of the namespace, but in the
> case where a binfmt_misc mount already exists, that refcount is never
> dropped, right? That would be a security bug, since an attacker could
> overflow the refcount of the user namespace and then trigger a UAF.
> (And the refcount hardening won't catch it because user namespaces
> still use raw atomics instead of refcount_t.)

Do you have any idea how I can fix this issue?

> [...]
>> +#if IS_ENABLED(CONFIG_BINFMT_MISC)
> 
> Nit: Isn't this kind of check normally written as "#ifdef"?
> 

What is the difference?

Thanks,
Laurent

