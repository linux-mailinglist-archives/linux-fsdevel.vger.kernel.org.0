Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5341E31B147
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNQil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhBNQil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:38:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4DC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 08:38:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o63so2883480pgo.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oB+tMpw4x77NgA2ctVBN/Wjk2d+yYxSUbgYL7s45NCI=;
        b=XT5Bajisn16+Q0yFr6OF9nVXd+kg3udN6GZrdU6n8HAAJX4Jh3Bqa2v6yC2hyTA4Ci
         kBMQWosC+o9/SpSJ/ngkOpc5VcWtoFZQI5IRoVsf2RfKEHXMRdxpfKsLhy7t6dnAp5EK
         hASkMrBS+5UiixlM1ALVe/jNu+R90KDvAzyIaR4PW1kE8uvxNn13VFd7NqxSPuI/ZGz7
         p44Hx4gX6YyS71wL/B/cGRir4NdLcI4WBfYoUnebftyd80sL/59PyzPpV2jE17ODviuz
         bxk3ybauNjomsdybTY3p4zOAUhiPqtzEJUE9MwmuEmv0ny415RqkSf5qI86C6rgyY2Cv
         D9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oB+tMpw4x77NgA2ctVBN/Wjk2d+yYxSUbgYL7s45NCI=;
        b=ehKWk1m1LeAUeWp+NnTIO14Bn3m2n628oUwWBYK1KLmrHuQR7INiJPUHSMl56iWOOr
         TunclO59MsdgIYYvYpRxXL0XzR/+8ahY0gv6MIdfPdMhPyzxSq//QK2Lmgz1aZ2N8jLk
         dufoNZzNZJKDGItQAU7rfGTWq3fcowJHlSduNFoKH/lCKhM3ZBzwz3mSJtE/bNLCZABm
         aqahmzrouLMn174jMOkyIGKxJWwy4F1Q6LxmfWzow+WUz2UQnne+Le5xyPtGSfdp6tgg
         y1JQHWDIgyCdFy8GCAvDPdbDKEq/rwbaQTkIdQegWuAf6jTLq1Yy4PSvGK8FURf+0t53
         1PEA==
X-Gm-Message-State: AOAM532y5DviVypUcrgSnGccKj4467V77Jc+036/wb+uWR3dZGioB0nL
        0NBadHbSXUB8J9Ul0ZLmkG3npw==
X-Google-Smtp-Source: ABdhPJx7A9NYZy3Ov0UIdnavRzAmXuR1CgizydqXHAcjzAQaCYUaLkhZhapyPBhFLS+Zt/oF1JHpww==
X-Received: by 2002:a62:7bc2:0:b029:1dc:9a1d:f787 with SMTP id w185-20020a627bc20000b02901dc9a1df787mr11853320pfc.43.1613320679626;
        Sun, 14 Feb 2021 08:37:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b62sm14308750pga.8.2021.02.14.08.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 08:37:58 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK (Insufficiently faking current?)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201214191323.173773-1-axboe@kernel.dk>
 <m1lfbrwrgq.fsf@fess.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
Date:   Sun, 14 Feb 2021 09:38:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <m1lfbrwrgq.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/21 3:08 PM, Eric W. Biederman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Hi,
>>
>> Wanted to throw out what the current state of this is, as we keep
>> getting closer to something palatable.
>>
>> This time I've included the io_uring change too. I've tested this through
>> both openat2, and through io_uring as well.
>>
>> I'm pretty happy with this at this point. The core change is very simple,
>> and the users end up being trivial too.
>>
>> Also available here:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=nonblock-path-lookup
>>
>> Changes since v2:
>>
>> - Simplify the LOOKUP_NONBLOCK to _just_ cover LOOKUP_RCU and
>>   lookup_fast(), as per Linus's suggestion. I verified fast path
>>   operations are indeed just that, and it avoids having to mess with
>>   the inode lock and mnt_want_write() completely.
>>
>> - Make O_TMPFILE return -EAGAIN for LOOKUP_NONBLOCK.
>>
>> - Improve/add a few comments.
>>
>> - Folded what was left of the open part of LOOKUP_NONBLOCK into the
>>   main patch.
> 
> I have to ask.  Are you doing work to verify that performing
> path traversals and opening of files yields the same results
> when passed to io_uring as it does when performed by the caller?
> 
> Looking at v5.11-rc7 it appears I can arbitrarily access the
> io-wq thread in proc by traversing "/proc/thread-self/".

Yes that looks like a bug, it needs similar treatment to /proc/self:

diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index a553273fbd41..e8ca19371a36 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -17,6 +17,13 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
 	pid_t pid = task_pid_nr_ns(current, ns);
 	char *name;
 
+	/*
+	 * Not currently supported. Once we can inherit all of struct pid,
+	 * we can allow this.
+	 */
+	if (current->flags & PF_KTHREAD)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!pid)
 		return ERR_PTR(-ENOENT);
 	name = kmalloc(10 + 6 + 10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);

as was done in this commit:

commit 8d4c3e76e3be11a64df95ddee52e99092d42fc19
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 13 16:47:52 2020 -0700

    proc: don't allow async path resolution of /proc/self components

> Similarly it looks like opening of "/dev/tty" fails to
> return the tty of the caller but instead fails because
> io-wq threads don't have a tty.
> 
> 
> There are a non-trivial number of places where current is used in the
> kernel both in path traversal and in opening files, and I may be blind
> but I have not see any work to find all of those places and make certain
> they are safe when called from io_uring.  That worries me as that using
> a kernel thread instead of a user thread could potential lead to
> privilege escalation.

I've got a patch queued up for 5.12 that clears ->fs and ->files for the
thread if not explicitly inherited, and I'm working on similarly
proactively catching these cases that could potentially be problematic.

-- 
Jens Axboe

