Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325263793F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhEJQgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEJQgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:36:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5EC061574;
        Mon, 10 May 2021 09:34:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i190so13935662pfc.12;
        Mon, 10 May 2021 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vmJAgqGo8Yb+1u88J2HmAoz7FJ9pWULe/PrQ0DmHBWY=;
        b=leOhu70JThbmOuEZKo0gHEab88Iy3wyzbq8jb1r3ODEm0NlUwn8ZsvJbU+VuY11tVR
         CpSb0GjlYbBrEjGDUzcvR+GBKrKmpkduLcirfp3ntzrxtF0U7kYZ81t2hIuy9EBHERh0
         GVWNr4zMg5QZSVhaxX5T4C8ibNjZnDFlOi6L2tcyy3LkDhkDuOiOtB377+My6eXYIfIx
         T+TZmMjLenbAKG2kMdESs7IH35HA/MiN88ieXD6IKH9osjegEp5m0t93sOoe3E3qA1qt
         vkvYatLDvB1Doi+Do1gukRWBtqTwclEvvwWlZjlL17K9VF10HTrB6bz8apkgan5GzIl5
         YSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vmJAgqGo8Yb+1u88J2HmAoz7FJ9pWULe/PrQ0DmHBWY=;
        b=YWVe4+igdk4oQiRnTbBImudjAsxBIurZlkqpXuCpzNb0x9UXQz4WxWzmO1ElYXFzBc
         5FklEonRCtn4uqnmAOgdJh7iVIbL8AJo1iA/ZWUL3eTFLsOx5oCCKFBCcttcEjkXzMqU
         7NvHKfTZ8sd4Lw2SL3I8DkAewtbzBNii0R/tUYForKWkVRvFWVmGufkUj2PuXR31R7TR
         Py9RyG013KIWLqw8Txhrcij8yE690nrKgJIvol+f95qAbg6ajFSKc1kgbOrQUz9s0O//
         37n3UFuOKae0BnElnCJJOg3UFR34uw/UWbelWWva2Sxq4luuEJ21HA/8CZ8852hA/5Fq
         go8g==
X-Gm-Message-State: AOAM533hDbAFfRrARp9NCJTpLLkck6/VejTmLzTcwfU2FzxGpje6J8Zi
        m9j0H/1iT6IATwG6OjSI/N8=
X-Google-Smtp-Source: ABdhPJwZnwusCFne+n6sE3jX8qgT+J9y+botJu+l9hBtURzANTER8uyRq8jWGZGxlJHKS+5OyN516A==
X-Received: by 2002:aa7:8503:0:b029:27d:497f:1da6 with SMTP id v3-20020aa785030000b029027d497f1da6mr26323231pfn.28.1620664499033;
        Mon, 10 May 2021 09:34:59 -0700 (PDT)
Received: from [192.168.192.21] (47-72-82-130.dsl.dyn.ihug.co.nz. [47.72.82.130])
        by smtp.gmail.com with ESMTPSA id n26sm11492820pfq.28.2021.05.10.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 09:34:58 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.de>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        Walter Harms <wharms@bfs.de>
Subject: Re: [PATCH] copy_file_range.2: Update cross-filesystem support for
 5.12
To:     Amir Goldstein <amir73il@gmail.com>
References: <20210509213930.94120-1-alx.manpages@gmail.com>
 <20210509213930.94120-12-alx.manpages@gmail.com>
 <a95d7a31-2345-8e1e-78d7-a1a8f7161565@gmail.com>
 <CAOQ4uxgB+sZ08jB+mFXuPJfTSJUV+Re5XKQ=hN7A4xfYo0dj6A@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e293694f-7dd9-0212-6b6b-b42096cc1928@gmail.com>
Date:   Tue, 11 May 2021 04:34:47 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgB+sZ08jB+mFXuPJfTSJUV+Re5XKQ=hN7A4xfYo0dj6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On 5/10/21 4:26 PM, Amir Goldstein wrote:
> On Mon, May 10, 2021 at 3:01 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>
>> Hi Alex,
>>
>> On 5/10/21 9:39 AM, Alejandro Colomar wrote:
>>> Linux 5.12 fixes a regression.
> 
> Nope.
> That never happened:
> https://lore.kernel.org/linux-fsdevel/8735v4tcye.fsf@suse.de/
> 
>>>
>>> Cross-filesystem (introduced in 5.3) copies were buggy.
>>>
>>> Move the statements documenting cross-fs to BUGS.
>>> Kernels 5.3..5.11 should be patched soon.
>>>
>>> State version information for some errors related to this.
>>
>> Thanks. Patch applied.
> 
> I guess that would need to be reverted...

Thanks for catching that. I had not pushed the patch, so 
I'll just drop it.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
