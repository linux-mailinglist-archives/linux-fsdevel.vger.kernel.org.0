Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDA263033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIIPHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgIIL7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:59:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A499C06179E;
        Wed,  9 Sep 2020 04:58:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so2082580wmi.0;
        Wed, 09 Sep 2020 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2MjbEB7ZY2uJBr8LETR57xA5qxS8KO0vG8+bEIyBh6o=;
        b=BMZskFVQHIxW+hpXeAE3v9XPaAP/BQdHBxrGpVzKx/T1GRfhdPUGUkG7gq1uq9loJw
         M0x/+i4ieezcA5TS8TcUUkZD59yjrNBCPkSOL4tACCrboaPOqxEkti1HELdwVGaQcPw8
         IBEDL6Ck9u7nSBEmK47Mm6QozbJuqSgkORCCfgWaX1ZBD7Pyc8FcPH8k2Oc//N1aIxz0
         NjjJ5Hzhp5zWxTnKnh0+wrvC0yoRSyk7OssE+U0NXzurJdNJirAH9xm529tkqEJMqmB8
         GAjlJUztJxp1NXN6KtFYbV3Ru97oTKW3N1A60YZZLJikd3BrhHIPDUZa1ScbaawUeAT1
         ePmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MjbEB7ZY2uJBr8LETR57xA5qxS8KO0vG8+bEIyBh6o=;
        b=WOynl3kn9+yEKjOTI1FcC2b0E9SCOGGQjmwxgf7ObJu1oKlIpB3+gd0fqJg0xUgkTq
         xP4qXLPWhrQaGNVEAdcnKwwwkDhhMi8OIcCJYHOk47xf0/omNXZ3Xr1vC5BZN5E4nm6x
         wuRrSlBbUJf8Y0udTXF0Zn6IlMB9arg5A3hfyDCrkiL7EpJXmO1yaZWCe/DEPlX9HoqB
         CZTRBL6xDgxlwY5skmmtUTedelukpQtD/2DVEFMoi9Qc4I19Fv/x3hrurikSxHbkT85Y
         44pFH8KFUhPVns/jTOoQzvWg3qLg/5Zc5Sd19RFKgOn8yaIT6Qy9TkCYlrga/9qIuSs0
         j6wg==
X-Gm-Message-State: AOAM5315mePOuCAlmegM56TIKUxIASjJlybT+x0F1w0wLC7N1VEO3v72
        4P9Qm5JxGUJ+ybqCMdi03IAox5Nfoxo=
X-Google-Smtp-Source: ABdhPJxeyMAg/oSJ1/Cuk8qhdTZYljBX/3D60/Sw0CPPcu8wFHUaahnNGrrMsadVL1xxBKXHmclzjA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr2824557wmi.21.1599652733697;
        Wed, 09 Sep 2020 04:58:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id t188sm3750551wmf.41.2020.09.09.04.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 04:58:53 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, milan.opensource@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
To:     Jan Kara <jack@suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <7be61144-0e77-3c31-d720-f2cbe56bc81e@gmail.com>
 <20200909112110.GA29150@quack2.suse.cz>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0f473a75-fd5a-82f7-1d0e-e9c168414498@gmail.com>
Date:   Wed, 9 Sep 2020 13:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909112110.GA29150@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC += Neil, since he wrote the text we're talking about]

Hello Jan,

On 9/9/20 1:21 PM, Jan Kara wrote:
> On Wed 09-09-20 12:52:48, Michael Kerrisk (man-pages) wrote:
>>> So the error state isn't really stored "on pages in the file mapping".
>>> Current implementation (since 4.14) is that error state is stored in struct
>>> file (I think this tends to be called "file description" in manpages) and
>>
>> (Yes, "open file description" is the POSIX terminology for the thing that
>> sits between the FD and the inode--struct file in kernel parlance--and I
>> try to follow POSIX terminology in the manual pages where possible.
>>
>>> so EIO / ENOSPC is reported once for each file description of the file that
>>> was open before the error happened. Not sure if we want to be so precise in
>>> the manpages or if it just confuses people. 
>>
>> Well, people are confused now, so I think more detail would be good.
>>
>>> Anyway your takeway that no
>>> error on subsequent fsync() does not mean data was written is correct.
>>
>> Thanks. (See also my rply to Jeff.)
>>
>> By the way, a question related to your comments above. In the 
>> errors section, there is this:
>>
>>        EIO    An  error  occurred during synchronization.  This error may
>>               relate to data written to some other file descriptor on the
>> *             same  file.   Since Linux 4.13, errors from write-back will
>>               be reported to all file descriptors that might have written
>>               the  data  which  triggered  the  error.   Some filesystems
>>               (e.g., NFS) keep close track of  which  data  came  through
>>               which  file  descriptor,  and  give more precise reporting.
>>               Other  filesystems  (e.g.,  most  local  filesystems)  will
>>               report errors to all file descriptors that were open on the
>> *             file when the error was recorded.
>>
>> In the marked (*) lines, we have the word "file". Is this accurate? I mean, I
>> would normally take "file" in this context to mean the inode ('struct inode').
>> But I wonder if really what is meant here is "open file description"
>> ('struct file'). In other words, is the EIO being generated for all FDs 
>> connected to the same open file description, or for all FDs for all of the
>> open file descriptions connected to the inode? Your thoughts?
> 
> The error gets reported once for each "open file description" of the file
> (inode) where the error happened. If there are multiple file descriptors
> pointing to the same open file description, then only one of those file
> descriptors will see the error. This is inevitable consequence of kernel
> storing the error state in struct file and clearing it once it is
> reported...

So, the text in wrong two respects, I believe:

* It should be phrased in terms of "open file description", not "file",
in the lines that I marked.

* Where it says "to all file descriptors" (twice), it should rather say
"to any of the file descriptors [that refer to the open file description]"

Do you agree?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
