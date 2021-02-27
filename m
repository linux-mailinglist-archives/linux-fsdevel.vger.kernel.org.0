Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0750326CFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhB0MVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 07:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhB0MVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 07:21:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A152C06174A;
        Sat, 27 Feb 2021 04:20:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id u125so9975267wmg.4;
        Sat, 27 Feb 2021 04:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z9fh2XxJwbj4olpGc0pBQQEl8VldJ+2OIcCXvhcoVAk=;
        b=B+9qt7q9U8KpbqSftwdlDWjeezXgFmUrPOuTAN7s6FAESz2k6e0aJlUiVCL+l+W8eS
         iNKO5QLZuRym2RwCJWppyTAZlCbTqO5+wLZbWUtJj7mDbh+Dc3Fx8sMPn2iUWUC2osuX
         z8ediTFSoqrkUwp+uH35QkTOI0S8Eby9w6SXzuc6644rTPzTxAll1zOG71VVjAfZRXXI
         qkiP8ya12Isf3vVowvpS4+8iCCFw26uScalg506BpZh+D3WaN5haC7tKwZsMNTNGba4q
         Csw4nVfEmnP3kpu9kl1izmoaP/E2vbraen9PatesAB/brPtmYPwhbXxGA3UzWrZXQDus
         W/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z9fh2XxJwbj4olpGc0pBQQEl8VldJ+2OIcCXvhcoVAk=;
        b=N0YuxBg8TFxpj/mTvsNYgX08vCYVsVaOGUrd2HTUbAURA1ZENNipGGPnXLLkUkthkn
         RuIExiPb/9kTj24DQOjXpDcl5FJEv/zGulnNZTdCSVSELgL7yFlDA5PvVVOsMQBSaSJJ
         eZxDJRn5r8xDHMhX7voS4CKmUB5ZnMGoe3E69j+2tAU3g08M7hjtGCNYmakSBqpXu9tc
         /Nm9w8cyC1dQwqPuGG43pSGk2rPKtFRtk26V3XZVuFmUyifuYGJ0dTUm7ZxWyUC3Pnsv
         cx0j1z3ONZABQ3xwFdShiZpGWS7kXx8zTtLc3CXMI2VGySzp5XyCP473/eTKJFAApWfI
         joXg==
X-Gm-Message-State: AOAM533UTzZWOgAONs27UTq1NxqeKUnzdX49EuWBx8sSIymi5uEPV19u
        ATghnXls973TDhHHGzBg1ZoLDStECb2/xQ==
X-Google-Smtp-Source: ABdhPJyqetsnoRgwbI/XtL3hN98oDRpNApfcdg9lJ2AR/kVPjKKZow4NkITbScfRadj3cH8JQumI9A==
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr7118521wmk.101.1614428434033;
        Sat, 27 Feb 2021 04:20:34 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id p16sm2958516wrt.54.2021.02.27.04.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Feb 2021 04:20:33 -0800 (PST)
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
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
 <6b896b29-6fc1-0586-ef31-f2f3298b56b0@gmail.com>
 <CAOQ4uxgFCBNwRD7e1srwaVrZMGfOE_JXENL4Q2En52srdj2AYA@mail.gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <ffd92bb4-8f72-cbec-045f-a2ad7869ab3b@gmail.com>
Date:   Sat, 27 Feb 2021 13:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgFCBNwRD7e1srwaVrZMGfOE_JXENL4Q2En52srdj2AYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On 2/27/21 6:41 AM, Amir Goldstein wrote:
> On Sat, Feb 27, 2021 at 12:19 AM Alejandro Colomar (man-pages)
>> On 2/24/21 5:10 PM, Amir Goldstein wrote:
>>> On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
>>>>    .TP
>>>> +.B EOPNOTSUPP
>>
>> I'll add the kernel version here:
>>
>> .BR EOPNOTSUPP " (since Linux 5.12)"
> 
> Error could be returned prior to 5.3 and would be probably returned
> by future stable kernels 5.3..5.12 too

OK, I think I'll state <5.3 and >=5.12 for the moment, and if Greg adds 
that to stable 5.3..5.11 kernels, please update me.

>>>>    .B EXDEV
>>>>    The files referred to by
>>>>    .IR fd_in " and " fd_out
>>>> -are not on the same mounted filesystem (pre Linux 5.3).
>>>> +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).
>>
>> I'm not sure that 'mounted' adds any value here.  Would you remove the
>> word here?
> 
> See rename(2). 'mounted' in this context is explained there.
> HOWEVER, it does not fit here.
> copy_file_range() IS allowed between two mounts of the same filesystem instance.

Also allowed for <5.3 ?

> 
> To make things more complicated, it appears that cross mount clone is not
> allowed via FICLONE/FICLONERANGE ioctl, so ioctl_ficlonerange(2) man page
> also uses the 'mounted filesystem' terminology for EXDEV
> 
> As things stand now, because of the fallback to clone logic,
> copy_file_range() provides a way for users to clone across different mounts
> of the same filesystem instance, which they cannot do with the FICLONE ioctl.
> 
> Fun :)
> 
> BTW, I don't know if preventing cross mount clone was done intentionally,
> but as I wrote in a comment in the code once:
> 
>          /*
>           * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
>           * the same mount. Practically, they only need to be on the same file
>           * system.
>           */

:)

> 
>>
>> It reads as if two separate devices with the same filesystem type would
>> still give this error.
>>
>> Per the LWN.net article Amir shared, this is permitted ("When called
>> from user space, copy_file_range() will only try to copy a file across
>> filesystems if the two are of the same type").
>>
>> This behavior was slightly different before 5.3 AFAICR (was it?) ("until
>> then, copy_file_range() refused to copy between files that were not
>> located on the same filesystem.").  If that's the case, I'd specify the
>> difference, or more probably split the error into two, one before 5.3,
>> and one since 5.12.
>>
> 
> True.
> 
>>>
>>> I think you need to drop the (Linux range) altogether.
>>
>> I'll keep the range.  Users of 5.3..5.11 might be surprised if the
>> filesystems are different and they don't get an error, I think.
>>
>> I reworded it to follow other pages conventions:
>>
>> .BR EXDEV " (before Linux 5.3; or since Linux 5.12)"
>>
>> which renders as:
>>
>>          EXDEV (before Linux 5.3; or since Linux 5.12)
>>                 The files referred to by fd_in and fd_out are not on
>>                 the same mounted filesystem.
>>
> 
> drop 'mounted'

Yes

> 
>>
>>> What's missing here is the NFS cross server copy use case.
>>> Maybe:
>>>
>>> ...are not on the same mounted filesystem and the source and target filesystems
>>> do not support cross-filesystem copy.
>>
>> Yes.
>>
>> Again, this wasn't true before 5.3, right?
>>
> 
> Right.
> Actually, v5.3 provides the vfs capabilities for filesystems to support
> cross fs copy. I am not sure if NFS already implements cross fs copy in
> v5.3 and not sure about cifs. Need to get input from nfs/cis developers
> or dig in the release notes for server-side copy.

Okay
> Thanks to LWN :)

:)

Thanks,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
