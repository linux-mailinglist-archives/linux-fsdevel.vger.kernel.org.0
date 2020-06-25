Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9077F209C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390510AbgFYJpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389894AbgFYJpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:45:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E41C061573;
        Thu, 25 Jun 2020 02:45:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so5259100ejb.11;
        Thu, 25 Jun 2020 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eA4poZMceWsvM3rmLRHsnsl9hHeBKdemY+Td0g9vsCY=;
        b=MoquPqgmXaMx4FO+yYuSA5R4x2a6ByAy0NDuobOBA4N4K0vH1Ksh6mOGG1Fg3yZ2UH
         HeKiDEIe7YFElXGm7k6DvGKi0C+Q1TxktA/5l0K5Lac1tfo/FDG+dM6GNq061GAfBQDx
         ywpdXloR9U0lZQlACIc8wBZLrVmQFYX11JzE7II/60DgWgQ0qu8bkX9hv/jVDt7aY+xy
         k7LgQHsVM3DUtWa7IzTl3ZX/UfEOAxCHCI5bjAKeSrJ1g3KMcrBP/6epo4bPlYAjGBWp
         qExZAbRZA0TNWHhgEM0AtPQKbvEWGAe94QF5mhpZUVCAjGfpKxKUEerWOUYyAEW+U2FF
         EHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eA4poZMceWsvM3rmLRHsnsl9hHeBKdemY+Td0g9vsCY=;
        b=qJT+XkxqyuFcaRtl1ZbHSLcGb8M+3VLK3pUuXgSmOdb3c6ApVxilA0lpIaasCX/dqU
         JyIX8IkPr+2FSjS5NgCSMGDap+wr2GzmCBA0zNHYBr9k2iHdWxz8wIaiinuNN8Nn9znR
         aSpySGaVJL7ys+1urjeifvnIrQYjZOn2bT22aOSMVssqWpzMmXznd6hBs5D+ppdkthB6
         4pQJve8maNHUkxryomFwrLGqlegvuUngYvNTRpj+ZJwPPdukj7ybX82rbeqL1hx1eWY6
         OJ8AbJs4jg+9bLTkRJ2dU9adgQIw6Ojqd5FL1Z/hPx/U4tJ8EnUsK6mUxkTsSK6a3fme
         QxuA==
X-Gm-Message-State: AOAM532JW49VuGZcPBvMSFqLKErBk0bWkgqWuyy7Ilm9IyZ9t6cBo1xC
        Z1oCbs4dcryStzq48UqOnOetPoCl
X-Google-Smtp-Source: ABdhPJysHjz5q+amJzSiiMjvVXbq84/gQkRWKZE8gpY6jEIxxwHmNxb5AG57BN23oiRylEQFw0pWyA==
X-Received: by 2002:a17:906:830b:: with SMTP id j11mr30510617ejx.42.1593078305827;
        Thu, 25 Jun 2020 02:45:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id c26sm4508654edr.88.2020.06.25.02.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 02:45:05 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][man-pages] sync.2: syncfs() now returns errors if
 writeback fails
To:     Jeff Layton <jlayton@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20200610103347.14395-1-jlayton@kernel.org>
 <20200610155013.GA1339@sol.localdomain>
 <fe141babe698296f96fde39a8da85005506fd0f0.camel@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <54c5ef29-0f12-5f55-8f54-73b20f56925e@gmail.com>
Date:   Thu, 25 Jun 2020 11:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <fe141babe698296f96fde39a8da85005506fd0f0.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

Any progress with v2 of this patch?

Thanks,

Michael


On 6/10/20 11:19 PM, Jeff Layton wrote:
> On Wed, 2020-06-10 at 08:50 -0700, Eric Biggers wrote:
>> On Wed, Jun 10, 2020 at 06:33:47AM -0400, Jeff Layton wrote:
>>> A patch has been merged for v5.8 that changes how syncfs() reports
>>> errors. Change the sync() manpage accordingly.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  man2/sync.2 | 24 +++++++++++++++++++++++-
>>>  1 file changed, 23 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/man2/sync.2 b/man2/sync.2
>>> index 7198f3311b05..27e04cff5845 100644
>>> --- a/man2/sync.2
>>> +++ b/man2/sync.2
>>> @@ -86,11 +86,26 @@ to indicate the error.
>>>  is always successful.
>>>  .PP
>>>  .BR syncfs ()
>>> -can fail for at least the following reason:
>>> +can fail for at least the following reasons:
>>>  .TP
>>>  .B EBADF
>>>  .I fd
>>>  is not a valid file descriptor.
>>> +.TP
>>> +.B EIO
>>> +An error occurred during synchronization.
>>> +This error may relate to data written to any file on the filesystem, or on
>>> +metadata related to the filesytem itself.
>>> +.TP
>>> +.B ENOSPC
>>> +Disk space was exhausted while synchronizing.
>>> +.TP
>>> +.BR ENOSPC ", " EDQUOT
>>> +Data was written to a files on NFS or another filesystem which does not
>>> +allocate space at the time of a
>>> +.BR write (2)
>>> +system call, and some previous write failed due to insufficient
>>> +storage space.
>>>  .SH VERSIONS
>>>  .BR syncfs ()
>>>  first appeared in Linux 2.6.39;
>>> @@ -121,6 +136,13 @@ or
>>>  .BR syncfs ()
>>>  provide the same guarantees as fsync called on every file in
>>>  the system or filesystem respectively.
>>> +.PP
>>> +In mainline kernel versions prior to 5.8,
>>> +.\" commit 735e4ae5ba28c886d249ad04d3c8cc097dad6336
>>> +.BR syncfs ()
>>> +will only fail with EBADF when passed a bad file descriptor. In 5.8
>>> +and later kernels, it will also report an error if one or more inodes failed
>>> +to be written back since the last syncfs call.
>>
>> The sentence "In mainline kernel versions prior to 5.8, syncfs() will only fail
>> with EBADF when passed a bad file descriptor" is ambiguous.  It could mean that
>> EBADF can now mean other things too.
>>
>> Maybe write: "In mainline kernel versions prior to 5.8, syncfs() will only fail
>> when passed a bad file descriptor (EBADF)."
>>
>> - Eric
> 
> Good point. Fixed in my tree using your verbiage. I'll send out a v2
> patch once I give others a chance to comment.
> 
> Thanks!
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
