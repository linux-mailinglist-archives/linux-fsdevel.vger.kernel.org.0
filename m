Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818B97105B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2019 06:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGWEQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 00:16:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35771 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGWEQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:16:57 -0400
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hpmEP-0004Sk-3Z; Tue, 23 Jul 2019 04:16:53 +0000
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk> <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk> <87pnmkhxoy.fsf@xmission.com>
 <5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp>
 <1698ec76-f56c-1e65-2f11-318c0ed225bb@i-love.sakura.ne.jp>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <e75d4a66-cfcf-2ce8-e82a-fdc80f01723d@canonical.com>
Date:   Mon, 22 Jul 2019 21:16:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1698ec76-f56c-1e65-2f11-318c0ed225bb@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/22/19 3:12 AM, Tetsuo Handa wrote:
> I did not see AppArmor patch for this problem in 5.3-rc1. 
> John, are you OK with this patch for 5.2-stable and 5.3 ?
> 
yes, I have some larger mount rework and clean-up to do and an apparmor
patch for this is waiting on that. Looking at the thread I am wondering
where my previous reply is, probably lost in a mail client crash, I have
had a few of those lately.

Acked-by: John Johansen <john.johansen@canonical.com>


> On 2019/07/09 19:51, Tetsuo Handa wrote:
>> For now, can we apply this patch for 5.2-stable ?
>>
>>
>> >From dd62fab0592e02580fd5a34222a2d11bfc179f61 Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Tue, 9 Jul 2019 19:05:49 +0900
>> Subject: [PATCH] LSM: Disable move_mount() syscall when TOMOYO or AppArmor is enabled.
>>
>> Commit 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts
>> around") introduced security_move_mount() LSM hook, but we missed that
>> TOMOYO and AppArmor did not implement hooks for checking move_mount(2).
>> For pathname based access controls like TOMOYO and AppArmor, unchecked
>> mount manipulation is not acceptable. Therefore, until TOMOYO and AppArmor
>> implement hooks, in order to avoid unchecked mount manipulation, pretend
>> as if move_mount(2) is unavailable when either TOMOYO or AppArmor is
>> enabled.
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Fixes: 2db154b3ea8e14b0 ("vfs: syscall: Add move_mount(2) to move mounts around")
>> Cc: stable@vger.kernel.org # 5.2
>> ---
>>  include/linux/lsm_hooks.h | 6 ++++++
>>  security/apparmor/lsm.c   | 1 +
>>  security/tomoyo/tomoyo.c  | 1 +
>>  3 files changed, 8 insertions(+)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 47f58cf..cd411b7 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2142,4 +2142,10 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>>  
>>  extern int lsm_inode_alloc(struct inode *inode);
>>  
>> +static inline int no_move_mount(const struct path *from_path,
>> +				const struct path *to_path)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>>  #endif /* ! __LINUX_LSM_HOOKS_H */
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index ec3a928..5cdf63b 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1158,6 +1158,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(capable, apparmor_capable),
>>  
>>  	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
>> +	LSM_HOOK_INIT(move_mount, no_move_mount),
>>  	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
>>  	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
>>  
>> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
>> index 716c92e..be1b1a1 100644
>> --- a/security/tomoyo/tomoyo.c
>> +++ b/security/tomoyo/tomoyo.c
>> @@ -558,6 +558,7 @@ static void tomoyo_task_free(struct task_struct *task)
>>  	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
>>  	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
>>  	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
>> +	LSM_HOOK_INIT(move_mount, no_move_mount),
>>  	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
>>  	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),
>>  	LSM_HOOK_INIT(socket_bind, tomoyo_socket_bind),
>>
> 

