Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A66C53A981
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353634AbiFAPCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiFAPCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:02:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBF2E0A1;
        Wed,  1 Jun 2022 08:02:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso3202654wma.4;
        Wed, 01 Jun 2022 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rbEDheK6UQKyC7vwWgTGjxwmqOZjkVmFEiePYqxVgok=;
        b=NDDDd3dRmzfvucFAW3CzsYje+65nfJlxj9SixfgvDjDuWxVETyCtBN2G4hhiSRCd3m
         9M/n0/CbiMWF6W8RDWwwmhExDd3klo/sRke7NiqT6HeG6NDbRgtIVQJW5XMIZd3nfw88
         1UosYrIkVpF9dywBnSaoI3m3d84pakcuTjLThrx1IVCaF6CJdoBmMlwUsb3eM0lM8U0v
         P1wZwhKTqBm6GgdxwnrrsfgBflY0aO4Sr21WH+Cd8XgiHedxCeC8V6/r98xKsosY3myq
         RN9K0Hha1QnV8BGqeVFzUeUT+6oEVA8kYGpmJW3dtp6HD6/BC9NAARvXj8PbiiJ7QCbL
         zLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbEDheK6UQKyC7vwWgTGjxwmqOZjkVmFEiePYqxVgok=;
        b=JzQ0vbdMCTY0NBReLj6/dqZiThgRIKubBRFmhwrNIEtrWRV6Io2oLI0+29uOqKKSt+
         JJX8D4XWiqJfe7Gczb4fWuTbYE0B1N8Pxp1sEyT6ACo9edMvUuS8Cvtfmdf5BtoBBeh1
         o3tP0xwiz+Ka1za0e8bDtLvqN6B7bJQsGSWaBzeMKmcE0Ap37QfdBFQpQSYSESTJ/4oZ
         yiJuHmylI3QlH6f6+xzZA2eukdkRGW1Q9aScMV6sqUPtyeyWz709gE30X/rIGUkQBwbA
         3rs/v49m2dk54nH1jL4OyD91xCG6StNKMLnYYYgo3P8qUZEWLznZz60XFUKzACkk3tmy
         0vKA==
X-Gm-Message-State: AOAM5335AQGkJAZojAFSZ+KeF4VP8NO/yICLCS7Ui/PtzZJ2Rx5ec23O
        k3ZIfZ3WlSp51w6K5R4PsF4=
X-Google-Smtp-Source: ABdhPJzQu7LhhTR3bRvCCtmCXaKNkaqLAguVHXuLq1EWU7TKwK0uVOTAIkWkj5UleoR7DNTlwIGYuQ==
X-Received: by 2002:a05:600c:3ac5:b0:397:774d:3890 with SMTP id d5-20020a05600c3ac500b00397774d3890mr225379wms.92.1654095733913;
        Wed, 01 Jun 2022 08:02:13 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f? ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
        by smtp.gmail.com with ESMTPSA id p68-20020a1c2947000000b003976525c38bsm5595812wmp.3.2022.06.01.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 08:02:13 -0700 (PDT)
Message-ID: <4b79c2ea-dd1a-623d-e5b4-faa732c1a42d@gmail.com>
Date:   Wed, 1 Jun 2022 17:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Linaro-mm-sig] Re: [PATCH 2/2] procfs: Add 'path' to
 /proc/<pid>/fdinfo/
Content-Language: en-US
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kalesh Singh <kaleshsingh@google.com>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
References: <20220531212521.1231133-1-kaleshsingh@google.com>
 <20220531212521.1231133-3-kaleshsingh@google.com>
 <14f85d24-a9de-9706-32f0-30be4999c71c@oracle.com>
 <CAC_TJveDzDaYQKmuLSkGWpnuCW+gvrqdVJqq=wbzoTRjw4OoFw@mail.gmail.com>
 <875yll1fp1.fsf@stepbren-lnx.us.oracle.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <875yll1fp1.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 01.06.22 um 00:48 schrieb Stephen Brennan:
> Kalesh Singh <kaleshsingh@google.com> writes:
>> On Tue, May 31, 2022 at 3:07 PM Stephen Brennan
>> <stephen.s.brennan@oracle.com> wrote:
>>> On 5/31/22 14:25, Kalesh Singh wrote:
>>>> In order to identify the type of memory a process has pinned through
>>>> its open fds, add the file path to fdinfo output. This allows
>>>> identifying memory types based on common prefixes. e.g. "/memfd...",
>>>> "/dmabuf...", "/dev/ashmem...".
>>>>
>>>> Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
>>>> the same as /proc/<pid>/maps which also exposes the file path of
>>>> mappings; so the security permissions for accessing path is consistent
>>>> with that of /proc/<pid>/maps.
>>> Hi Kalesh,
>> Hi Stephen,
>>
>> Thanks for taking a look.
>>
>>> I think I see the value in the size field, but I'm curious about path,
>>> which is available via readlink /proc/<pid>/fd/<n>, since those are
>>> symlinks to the file themselves.
>> This could work if we are root, but the file permissions wouldn't
>> allow us to do the readlink on other processes otherwise. We want to
>> be able to capture the system state in production environments from
>> some trusted process with ptrace read capability.
> Interesting, thanks for explaining. It seems weird to have a duplicate
> interface for the same information but such is life.

Yeah, the size change is really straight forward but for this one I'm 
not 100% sure either.

Probably best to ping some core fs developer before going further with it.

BTW: Any preferred branch to push this upstream? If not I can take it 
through drm-misc-next.

Regards,
Christian.

>
>>> File paths can contain fun characters like newlines or colons, which
>>> could make parsing out filenames in this text file... fun. How would your
>>> userspace parsing logic handle "/home/stephen/filename\nsize:\t4096"? The
>>> readlink(2) API makes that easy already.
>> I think since we have escaped the "\n" (seq_file_path(m, file, "\n")),
> I really should have read through that function before commenting,
> thanks for teaching me something new :)
>
> Stephen
>
>> then user space might parse this line like:
>>
>> if (strncmp(line, "path:\t", 6) == 0)
>>          char* path = line + 6;
>>
>>
>> Thanks,
>> Kalesh
>>
>>> Is the goal avoiding races (e.g. file descriptor 3 is closed and reopened
>>> to a different path between reading fdinfo and stating the fd)?
>>>
>>> Stephen
>>>
>>>> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>>>> ---
>>>>
>>>> Changes from rfc:
>>>>    - Split adding 'size' and 'path' into a separate patches, per Christian
>>>>    - Fix indentation (use tabs) in documentaion, per Randy
>>>>
>>>>   Documentation/filesystems/proc.rst | 14 ++++++++++++--
>>>>   fs/proc/fd.c                       |  4 ++++
>>>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
>>>> index 779c05528e87..591f12d30d97 100644
>>>> --- a/Documentation/filesystems/proc.rst
>>>> +++ b/Documentation/filesystems/proc.rst
>>>> @@ -1886,14 +1886,16 @@ if precise results are needed.
>>>>   3.8  /proc/<pid>/fdinfo/<fd> - Information about opened file
>>>>   ---------------------------------------------------------------
>>>>   This file provides information associated with an opened file. The regular
>>>> -files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
>>>> +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
>>>> +and 'path'.
>>>>
>>>>   The 'pos' represents the current offset of the opened file in decimal
>>>>   form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
>>>>   file has been created with [see open(2) for details] and 'mnt_id' represents
>>>>   mount ID of the file system containing the opened file [see 3.5
>>>>   /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
>>>> -the file, and 'size' represents the size of the file in bytes.
>>>> +the file, 'size' represents the size of the file in bytes, and 'path'
>>>> +represents the file path.
>>>>
>>>>   A typical output is::
>>>>
>>>> @@ -1902,6 +1904,7 @@ A typical output is::
>>>>        mnt_id: 19
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   /dev/null
>>>>
>>>>   All locks associated with a file descriptor are shown in its fdinfo too::
>>>>
>>>> @@ -1920,6 +1923,7 @@ Eventfd files
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:[eventfd]
>>>>        eventfd-count:  5a
>>>>
>>>>   where 'eventfd-count' is hex value of a counter.
>>>> @@ -1934,6 +1938,7 @@ Signalfd files
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:[signalfd]
>>>>        sigmask:        0000000000000200
>>>>
>>>>   where 'sigmask' is hex value of the signal mask associated
>>>> @@ -1949,6 +1954,7 @@ Epoll files
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:[eventpoll]
>>>>        tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
>>>>
>>>>   where 'tfd' is a target file descriptor number in decimal form,
>>>> @@ -1968,6 +1974,7 @@ For inotify files the format is the following::
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:inotify
>>>>        inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
>>>>
>>>>   where 'wd' is a watch descriptor in decimal form, i.e. a target file
>>>> @@ -1992,6 +1999,7 @@ For fanotify files the format is::
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:[fanotify]
>>>>        fanotify flags:10 event-flags:0
>>>>        fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
>>>>        fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
>>>> @@ -2018,6 +2026,7 @@ Timerfd files
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   0
>>>> +     path:   anon_inode:[timerfd]
>>>>        clockid: 0
>>>>        ticks: 0
>>>>        settime flags: 01
>>>> @@ -2042,6 +2051,7 @@ DMA Buffer files
>>>>        mnt_id: 9
>>>>        ino:    63107
>>>>        size:   32768
>>>> +     path:   /dmabuf:
>>>>        count:  2
>>>>        exp_name:  system-heap
>>>>
>>>> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
>>>> index 464bc3f55759..8889a8ba09d4 100644
>>>> --- a/fs/proc/fd.c
>>>> +++ b/fs/proc/fd.c
>>>> @@ -60,6 +60,10 @@ static int seq_show(struct seq_file *m, void *v)
>>>>        seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
>>>>        seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
>>>>
>>>> +     seq_puts(m, "path:\t");
>>>> +     seq_file_path(m, file, "\n");
>>>> +     seq_putc(m, '\n');
>>>> +
>>>>        /* show_fd_locks() never deferences files so a stale value is safe */
>>>>        show_fd_locks(m, file, files);
>>>>        if (seq_has_overflowed(m))
>>> --
>>> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>>>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

