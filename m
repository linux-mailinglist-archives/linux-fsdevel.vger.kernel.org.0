Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B43269DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 23:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBZWTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 17:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBZWTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:19:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61927C061574;
        Fri, 26 Feb 2021 14:19:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u187so6592155wmg.4;
        Fri, 26 Feb 2021 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3OfUCMwhYcIPNp07X2mLpamMw5K+IHYf1caArQvkXw4=;
        b=AOqyW6wUFFU5ZMtaEWmAwFUPKtcp4GR66W+rHHQJTFWTVF2JxcRGGRzgJ7TvPAyr95
         hOkK3PcYAoWZsOlBFwYfNli8XlZ02vg7nj+WtnwUzJmPMMSbcZJhpv4b5Zh+SHy3L0J1
         s5PLjFqLPClop5S2H9DcD3fBw24gIGNFI9AUJya5rXguBMhcocicrwlehEfbpm/ETyze
         BOwMSxUuMxgdrTb1kgGCV0K2n7c+2PzX1ENlMoTx78hryZpTF1oVITv+gOp5ItJzQRyh
         jy38vKyhzHBbu9eY97LHtYqg7vIS1MvxRHJzdgXPAxzlu7bo0KR5jJ6Gghlh1aDSw+w5
         pT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3OfUCMwhYcIPNp07X2mLpamMw5K+IHYf1caArQvkXw4=;
        b=Ts5jecbOi+v8lyXIaID8RiM5kQsKQW3/j0azmRXHV+ZLomO4CJsJ/cv4vb2qW5oxRd
         IwsIfCsDy2GoJSd1GfUdHZC/9JteX4wwTBzE3PqXUirv44IE+iUholsTZ5Omo7ut1Oc5
         chS/vQz9vf0m3ONIHUFLVKITtsH41M/c4Qn+5o2eghuUYKst4mT2swGSzJr+qr8x5bvO
         vTJthIlUGsJzTCdKgRoHOpEPYQq0b4wi3g/UufhfTWLOv2vBvRhNnqQ7vcjcIlrrFXhM
         rtWo6nfSbiKy//l8qG+UnvrCIU+QY3QRJ2L6hpGYtzGkkH+3+orF6bOjt7FQuKX5+atx
         SSLw==
X-Gm-Message-State: AOAM5329kzS1GP1dPjafV0H7wuZAO28gOB9iYph8HrKiW/pY1uEP/CqU
        EH5jOaC1io13qRQySEpvhy2JD5+Rro4b5w==
X-Google-Smtp-Source: ABdhPJwQ3TaeHkW+geoEhfRuLxAL0944dmgQLIgQTCFaXrW8dF3+m0gKdu27FG3JtQE8DotLU9FXCg==
X-Received: by 2002:a1c:f309:: with SMTP id q9mr4697907wmq.156.1614377940063;
        Fri, 26 Feb 2021 14:19:00 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id d13sm6874807wro.23.2021.02.26.14.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 14:18:59 -0800 (PST)
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Amir Goldstein <amir73il@gmail.com>,
        Luis Henriques <lhenriques@suse.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20210222102456.6692-1-lhenriques@suse.de>
 <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <6b896b29-6fc1-0586-ef31-f2f3298b56b0@gmail.com>
Date:   Fri, 26 Feb 2021 23:18:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir, Luis,

On 2/24/21 5:10 PM, Amir Goldstein wrote:
> On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
>>
>> Update man-page with recent changes to this syscall.
>>
>> Signed-off-by: Luis Henriques <lhenriques@suse.de>
>> ---
>> Hi!
>>
>> Here's a suggestion for fixing the manpage for copy_file_range().  Note that
>> I've assumed the fix will hit 5.12.
>>
>>   man2/copy_file_range.2 | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
>> index 611a39b8026b..b0fd85e2631e 100644
>> --- a/man2/copy_file_range.2
>> +++ b/man2/copy_file_range.2
>> @@ -169,6 +169,9 @@ Out of memory.
>>   .B ENOSPC
>>   There is not enough space on the target filesystem to complete the copy.
>>   .TP
>> +.B EOPNOTSUPP

I'll add the kernel version here:

.BR EOPNOTSUPP " (since Linux 5.12)"

>> +The filesystem does not support this operation >> +.TP
>>   .B EOVERFLOW
>>   The requested source or destination range is too large to represent in the
>>   specified data types.
>> @@ -187,7 +190,7 @@ refers to an active swap file.
>>   .B EXDEV
>>   The files referred to by
>>   .IR fd_in " and " fd_out
>> -are not on the same mounted filesystem (pre Linux 5.3).
>> +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).

I'm not sure that 'mounted' adds any value here.  Would you remove the 
word here?

It reads as if two separate devices with the same filesystem type would 
still give this error.

Per the LWN.net article Amir shared, this is permitted ("When called 
from user space, copy_file_range() will only try to copy a file across 
filesystems if the two are of the same type").

This behavior was slightly different before 5.3 AFAICR (was it?) ("until 
then, copy_file_range() refused to copy between files that were not 
located on the same filesystem.").  If that's the case, I'd specify the 
difference, or more probably split the error into two, one before 5.3, 
and one since 5.12.

> 
> I think you need to drop the (Linux range) altogether.

I'll keep the range.  Users of 5.3..5.11 might be surprised if the 
filesystems are different and they don't get an error, I think.

I reworded it to follow other pages conventions:

.BR EXDEV " (before Linux 5.3; or since Linux 5.12)"

which renders as:

        EXDEV (before Linux 5.3; or since Linux 5.12)
               The files referred to by fd_in and fd_out are not on
               the same mounted filesystem.


> What's missing here is the NFS cross server copy use case.
> Maybe:
> 
> ...are not on the same mounted filesystem and the source and target filesystems
> do not support cross-filesystem copy.

Yes.

Again, this wasn't true before 5.3, right?

> 
> You may refer the reader to VERSIONS section where it will say which
> filesystems support cross-fs copy as of kernel version XXX (i.e. cifs and nfs).
> 
>>   .SH VERSIONS
>>   The
>>   .BR copy_file_range ()
>> @@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
>>   .PP
>>   First support for cross-filesystem copies was introduced in Linux 5.3.
>>   Older kernels will return -EXDEV when cross-filesystem copies are attempted.
>> +.PP
>> +After Linux 5.12, support for copies between different filesystems was dropped.
>> +However, individual filesystems may still provide
>> +.BR copy_file_range ()
>> +implementations that allow copies across different devices.
> 
> Again, this is not likely to stay uptodate for very long.
> The stable kernels are expected to apply your patch (because it fixes
> a regression)
> so this should be phrased differently.
> If it were me, I would provide all the details of the situation to
> Michael and ask him
> to write the best description for this section.

I'll look into more detail at this part in a later review.


On 2/26/21 11:34 AM, Amir Goldstein wrote:
 > Is this detailed enough? ;-)
 >
 > https://lwn.net/Articles/846403/

Yes, it is!



Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
