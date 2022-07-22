Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299FF57DE51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiGVJ1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiGVJ13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:27:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C9B5545
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:17:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso3694083pjq.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aE7Qaa6YGAPXPWQy12S5Iix2+yGCMPWdaS0g7+LUqto=;
        b=Q2SqP57JWoRCnOQGdCej3NxHpU/kRVDlsoSw+4tS56LbudmV1r378vp2IPb0/W0/PF
         CIu+i6R1Z3bDh24PLqhfx0gc041PGuE5mNWyQTGLgYu8VcRrRirS/fDFyn2qos6TVMnC
         OYNxEZNuAcjLWLqhk31pav4HPWJqdeJBebx7Mrmq7mcqW9h1SFGMTfNQcrMdrvgz7cte
         u8tItyHdewMX03PKM0Yd3sMPBqJ1kE7oFc6i5mNxEfCqCb9wn1WNnXAJ/qiN+0DLvYjL
         +jRfCW9PFri6ZntiQ8quApX596KPn3TAnEszeffGxykBZljyJXjtp3o+ZYIawfnnDidY
         fHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aE7Qaa6YGAPXPWQy12S5Iix2+yGCMPWdaS0g7+LUqto=;
        b=6l4lIkRsP+c9IFYzfo/JwkKm9AiupEgZv42S3CJBRiEVtKxNwV8L5rQOUA6K8PgJEq
         KhqS++JrTjIYjbTe9/knKlOls9OXfpfKzAfmdKAhOljwR6vGr+NKSQSW5wifg1GMvk2B
         hOB1lqFx/UeVWoWD98wmvUa7sp4uyRN8PgHjJ01SrDrUU2jN5Slir+WIWnK6Yo1lMq+5
         ShsXid8pEIABYtVwX06uO2gN3vD7Tgse4YpCsYQOI1v5ivG00CBDUgQHyKvdMwTI4tj6
         8g8e241R/OS0R8aqR69FSb7QXIvK060+iLiKulAKTSOaAnbyRQTT+FiQMm00jdgZywQ1
         FgLA==
X-Gm-Message-State: AJIora9sR1HByHUg9N2J9HrOHdiLYRpyglJr0adJ3+R3VRFT1EKOa8is
        IrpLh48eqHuTWz+vufwMWMNISg==
X-Google-Smtp-Source: AGRyM1tDN0P90CtGkZ5VkVTElh+f6JOLMKlzBg9uUOgIEFyO8zRIijbwTbJxjQOymAr1eszYmNVmLw==
X-Received: by 2002:a17:902:ef8c:b0:16d:1e1a:4a9f with SMTP id iz12-20020a170902ef8c00b0016d1e1a4a9fmr2371139plb.45.1658481435509;
        Fri, 22 Jul 2022 02:17:15 -0700 (PDT)
Received: from [10.70.253.132] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b0015e8d4eb1f7sm3148532pls.65.2022.07.22.02.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:17:15 -0700 (PDT)
Message-ID: <8dd86f42-0dee-b5c5-0859-6b2bd491348f@bytedance.com>
Date:   Fri, 22 Jul 2022 17:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC] proc: fix create timestamp of files in proc
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-api@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20220721081617.36103-1-zhangyuchen.lcr@bytedance.com>
 <Ytl772fRS74eIneC@bombadil.infradead.org>
 <CAMZfGtXjK2BgpwTOGsWdKs9-3i0X9ohdbXJk=0DAmpEKUymS5w@mail.gmail.com>
From:   Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
In-Reply-To: <CAMZfGtXjK2BgpwTOGsWdKs9-3i0X9ohdbXJk=0DAmpEKUymS5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Maybe I have some problem with my presentation, sorry.

I actually don't think any of these three suggestions are a good idea.
But I don't know if there is a better solution.
This RFC just wants to raise the question.

Thanks for your replies.


On 2022/7/22 11:43, Muchun Song wrote:
> On Fri, Jul 22, 2022 at 12:16 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> On Thu, Jul 21, 2022 at 04:16:17PM +0800, Zhang Yuchen wrote:
>>> A user has reported a problem that the /proc/{pid} directory
>>> creation timestamp is incorrect.
>>
>> The directory?
>>
>>> He believes that the directory was created when the process was
>>> started, so the timestamp of the directory creation should also
>>> be when the process was created.
>>
>> A quick glance at Documentation/filesystems/proc.rst reveals there
>> is documentation that the process creation time is the start_time in
>> the stat file for the pid. It makes absolutely no mention of the
>> directory creation time.
>>
> 
> Hi Luis,
> 
> Right.
> 
>> The directory creation time has been the way it is since linux history [0]
>> commit fdb2f0a59a1c7 ("[PATCH] Linux-0.97.3 (September 5, 1992)) and so this
>> has been the way .. since the beginning.
>>
>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/
>>
>> The last change was by Deepa to correct y2038 considerations through
>> commit 078cd8279e659 ("fs: Replace CURRENT_TIME with current_time() for
>> inode timestamps").
>>
>> Next time you try to report something like this please be very sure
>> to learn to use git blame, and then git blame foo.c <commit-id>~1 and
>> keep doing this until you get to the root commit, this will let you
>> determine *how long has this been this way*. When you run into a
>> commit history which lands to the first git commit on linux you can
>> use the above linux history.git to go back further as I did.
>>
> 
> A good instruction for a newbie.
> 
>>> The file timestamp in procfs is the timestamp when the inode was
>>> created. If the inode of a file in procfs is reclaimed, the inode
>>> will be recreated when it is opened again, and the timestamp will
>>> be changed to the time when it was recreated.
>>
>> The commit log above starts off with a report of the directory
>> of a PID. When does the directory of a PID change dates when its
>> respective start_time does not? When does this reclaim happen exactly?
>> Under what situation?
>>
> 
> IMHO, when the system is under memory pressure, then the proc
> inode can be reclaimed, it is also true when we `echo 3 >
> /proc/sys/vm/drop_caches`. After this operation, the proc inode's
> timestamp is changed.
> 
>> And if that is not happening, can you name *one* file in a process
>> directory under proc which does get reclaimed for, for which this
>> does happen?
>>
>>> In other file systems, this timestamp is typically recorded in
>>> the file system and assigned to the inode when the inode is created.
>>
>> I don't understand, which files are we reclaiming in procfs which
>> get re-recreated which your *user* is having issues with? What did
>> they report exactly, I'm *super* curious what your user reported
>> exactly. Do you have a bug report somewhere? Or any information
>> about its bug report. Can you pass it on to Muchun for peer review?
>> What file were they monitoring and what tool were they using which
>> made them realize there was a sort of issue?
>>
>>> This mechanism can be confusing to users who are not familiar with it.
>>
>> Why are they monitoring it? Why would a *new* inode having a different
>> timestamp be an issue as per existing documentation?
>>
> 
> Maybe the users think the timestamp of /proc/$pid directory is equal to
> the start_time of a process, I think it is because of a comment of
> shortage about the meaning of the timestamp of /proc files.
> 
>>> For users who know this mechanism, they will choose not to trust this time.
>>> So the timestamp now has no meaning other than to confuse the user.
>>
>> That is unfair given this is the first *user* to report confusion since
>> the inception of Linux, don't you think?
>>
>>> It needs fixing.
>>
>> A fix is for when there is an issue. You are not reporting a bug or an
>> issue, but you seem to be reporting something a confused user sees and
>> perhaps lack of documentation for something which is not even tracked
>> or cared for. This is the way things have been done since the beginning.
>> It doesn't mean things can't change, but there needs to be a good reason.
>>
>> The terminology of "fix" implies something is broken. The only thing
>> seriouly broken here is this patch you are suggesting and the mechanism
>> which is enabling you to send patches for what you think are issues and
>> seriously wasting people's time. That seriously needs to be fixed.
>>
>>> There are three solutions. We don't have to make the timestamp
>>> meaningful, as long as the user doesn't trust the timestamp.
>>>
>>> 1. Add to the kernel documentation that the timestamp in PROC is
>>>     not reliable and do not use this timestamp.
>>>     The problem with this solution is that most users don't read
>>>     the kernel documentation and it can still be misleading.
>>>
>>> 2. Fix it, change the timestamp of /proc/pid to the timestamp of
>>>     process creation.
>>>
>>>     This raises new questions.
>>>
>>>     a. Users don't know which kernel version is correct.
>>>
>>>     b. This problem exists not only in the pid directory, but also
>>>        in other directories under procfs. It would take a lot of
>>>        extra work to fix them all. There are also easier ways for
>>>        users to get the creation time information better than this.
>>>
>>>     c. We need to describe the specific meaning of each file under
>>>        proc in the kernel documentation for the creation time.
>>>        Because the creation time of various directories has different
>>>        meanings. For example, PID directory is the process creation
>>>        time, FD directory is the FD creation time and so on.
>>>
>>>     d. Some files have no associated entity, such as iomem.
>>>        Unable to give a meaningful time.
>>>
>>> 3. Instead of fixing it, set the timestamp in all procfs to 0.
>>>     Users will see it as an error and will not use it.
>>>
>>> I think 3 is better. Any other suggestions?
>>>
>>> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
>>
>> The logic behind this patch is way off track, a little effort
>> alone should have made you reach similar conflusions as I have.
>> Your patch does your suggested step 3), so no way! What you are
>> proposing can potentially break things! Have you put some effort
>> into evaluating the negative possible impacts of your patch? If
>> not, can you do that now?  Did you even *boot* test your patch?
>>
>> It makes all of the proc files go dated back to Jan 1 1970.
>>
>> How can this RFC in any way shape or form have been sent with
>> a serious intent?
>>
>> Sadly the lack of any serious consideration of the past and then
>> for you to easily suggest to make a new change which could easily
>> break existing users makes me needing to ask you to please have
>> one of your peers at bytedance.com such as Muchun Song to please
>> review your patches prior to you posting them, because otherwise
>> this is creating noise and quite frankly make me wonder if you
>> are intentially trying to break things.
>>
>> Muchun Song, sorry but can you please help here ensure that your
>> peers don't post this level of quality of patches again? It would be
>> seriously appreciated.
>>
> 
> It's my bad. Sorry. I should review it carefully. Zhang Yuchen is a newbie
> for Linux kernel development, I think he just want to point out the potential
> confusion to the users. Yuchen is not sure if this change is the best, I suspect
> this is why there is RFC is the patch's subject. I think at least we
> should point
> it out in Documentation/filesystems/proc.rst so that users can know what does
> the timestamp of proc files/directories mean.
> 
> Thanks.
> 
>> Users exist for years without issue and now you want to change things
>> for a user which finds something done which is not documented and want
>> to purposely *really* change things for *everyone* to ways which have
>> 0 compatibility with what users may have been expecting before.
>>
>> How can you conclude this?
>>
>> This suggested patch is quite alarming.
>>
>>    Luis
>>
>> Below is just nonsense.
>>
>>> ---
>>>   fs/proc/base.c        | 4 +++-
>>>   fs/proc/inode.c       | 3 ++-
>>>   fs/proc/proc_sysctl.c | 3 ++-
>>>   fs/proc/self.c        | 3 ++-
>>>   fs/proc/thread_self.c | 3 ++-
>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index 0b72a6d8aac3..af440ef13091 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -1892,6 +1892,8 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
>>>        struct proc_inode *ei;
>>>        struct pid *pid;
>>>
>>> +     struct timespec64 ts_zero = {0, 0};
>>> +
>>>        /* We need a new inode */
>>>
>>>        inode = new_inode(sb);
>>> @@ -1902,7 +1904,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
>>>        ei = PROC_I(inode);
>>>        inode->i_mode = mode;
>>>        inode->i_ino = get_next_ino();
>>> -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>>> +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>>>        inode->i_op = &proc_def_inode_operations;
>>>
>>>        /*
>>> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
>>> index fd40d60169b5..efb1c935fa8d 100644
>>> --- a/fs/proc/inode.c
>>> +++ b/fs/proc/inode.c
>>> @@ -642,6 +642,7 @@ const struct inode_operations proc_link_inode_operations = {
>>>   struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>>>   {
>>>        struct inode *inode = new_inode(sb);
>>> +     struct timespec64 ts_zero = {0, 0};
>>>
>>>        if (!inode) {
>>>                pde_put(de);
>>> @@ -650,7 +651,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>>>
>>>        inode->i_private = de->data;
>>>        inode->i_ino = de->low_ino;
>>> -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>>> +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>>>        PROC_I(inode)->pde = de;
>>>        if (is_empty_pde(de)) {
>>>                make_empty_dir_inode(inode);
>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>> index 021e83fe831f..c670f9d3b871 100644
>>> --- a/fs/proc/proc_sysctl.c
>>> +++ b/fs/proc/proc_sysctl.c
>>> @@ -455,6 +455,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>>>        struct ctl_table_root *root = head->root;
>>>        struct inode *inode;
>>>        struct proc_inode *ei;
>>> +     struct timespec64 ts_zero = {0, 0};
>>>
>>>        inode = new_inode(sb);
>>>        if (!inode)
>>> @@ -476,7 +477,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>>>        head->count++;
>>>        spin_unlock(&sysctl_lock);
>>>
>>> -     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>>> +     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>>>        inode->i_mode = table->mode;
>>>        if (!S_ISDIR(table->mode)) {
>>>                inode->i_mode |= S_IFREG;
>>> diff --git a/fs/proc/self.c b/fs/proc/self.c
>>> index 72cd69bcaf4a..b9e572fdc27c 100644
>>> --- a/fs/proc/self.c
>>> +++ b/fs/proc/self.c
>>> @@ -44,9 +44,10 @@ int proc_setup_self(struct super_block *s)
>>>        self = d_alloc_name(s->s_root, "self");
>>>        if (self) {
>>>                struct inode *inode = new_inode(s);
>>> +             struct timespec64 ts_zero = {0, 0};
>>>                if (inode) {
>>>                        inode->i_ino = self_inum;
>>> -                     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>>> +                     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>>>                        inode->i_mode = S_IFLNK | S_IRWXUGO;
>>>                        inode->i_uid = GLOBAL_ROOT_UID;
>>>                        inode->i_gid = GLOBAL_ROOT_GID;
>>> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
>>> index a553273fbd41..964966387da2 100644
>>> --- a/fs/proc/thread_self.c
>>> +++ b/fs/proc/thread_self.c
>>> @@ -44,9 +44,10 @@ int proc_setup_thread_self(struct super_block *s)
>>>        thread_self = d_alloc_name(s->s_root, "thread-self");
>>>        if (thread_self) {
>>>                struct inode *inode = new_inode(s);
>>> +             struct timespec64 ts_zero = {0, 0};
>>>                if (inode) {
>>>                        inode->i_ino = thread_self_inum;
>>> -                     inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
>>> +                     inode->i_mtime = inode->i_atime = inode->i_ctime = ts_zero;
>>>                        inode->i_mode = S_IFLNK | S_IRWXUGO;
>>>                        inode->i_uid = GLOBAL_ROOT_UID;
>>>                        inode->i_gid = GLOBAL_ROOT_GID;
>>> --
>>> 2.30.2
>>>
