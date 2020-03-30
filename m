Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236311977EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 11:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgC3Jgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 05:36:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43855 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgC3Jgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:36:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id m11so14838322wrx.10;
        Mon, 30 Mar 2020 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dMOMguEdlIuN75EQIiDQDpZW482UQX8EDI3gaRnFB1I=;
        b=RtVLmQ62zN+mfcKFr3smxzWvHfS1g/EnH1qPSkUpslKgzT3RA4Fr/+C2GSVGxiik+X
         P42T4NoS97zWfhZwDNPCfI7y8ghQ1KduifFn03sqQTkqqKybtFmUdEzH9SH5z/CtKu7t
         i6kWeba5nmUvUaqHRqqWD/6IAeEWLj09Augt6c/6bg1o7jXcOrIyARTkE7hpA4+Lq2hu
         8Zm71Qaer+r5xzJmVxtUE3qyfdXFDeSQ5GpQcG74ki+9QNJnwVJjYnZ+Sw4yAwwNMPS1
         2S8KEoGdFAbuKl09M47nIdlCB6pnNGetCa4Fmwz6oclaTY/kXRl51eMV/Of3qwqb2QCQ
         2Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dMOMguEdlIuN75EQIiDQDpZW482UQX8EDI3gaRnFB1I=;
        b=dIFRzhs5q2COil1ReNsvtGg7qDYWxYMVxYjLYpsVznKMoVa3AeBR52QDNVBcMebfmI
         0PWglm1eLuO+z1TC/ZjfwdnkKSZo9YcYOEyjV+5ko6TaJiS47TJt5x7qMxlkYTrueaEK
         g+G/266sQ5Cl8RnqzcSbR2uu97rpM++c1CJj2Bjj8W+mFdv2+WKeclW5skQtMGRfO5Fq
         EVt8fT1OcWHj0suegzBCYm3Qjk+V2fRVvsRFzFt6/MeugwGrleoR2jTIdYNsBBIDbMcB
         f0lNzamr+6fY8gLkTQ6hX6f+4DTZMf/edrtlEXGcoLPD2cwgc0BUo5EgNfuycsQ8xKpn
         iBoQ==
X-Gm-Message-State: ANhLgQ0bKPVyr4oc4W1HTW3pWHYCU22h676z/GWyUFKqAVVUSeWeb+V7
        d2To+JR0g4pkOxV7HEdfwrHxd+xa
X-Google-Smtp-Source: ADFU+vupMQ8V2Z4tt1xvq5UVmxORz5LVakrDOtxhLtznVUhByukAKKQNTI3UOov2TyUTQ9c5kYkV0Q==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr14939339wru.371.1585561003902;
        Mon, 30 Mar 2020 02:36:43 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id h2sm12940346wmb.16.2020.03.30.02.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 02:36:43 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <4dcea613-60b8-a8af-9688-be93858ab652@gmail.com>
 <20200330092051.umcu2mjnwqazml7a@yavin.dot.cyphar.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <ae275f67-9277-547c-e78c-bca4f388f694@gmail.com>
Date:   Mon, 30 Mar 2020 11:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330092051.umcu2mjnwqazml7a@yavin.dot.cyphar.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/20 11:20 AM, Aleksa Sarai wrote:
> On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
>> Hello Aleksa,
>>
>> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
>>> Rather than trying to merge the new syscall documentation into open.2
>>> (which would probably result in the man-page being incomprehensible),
>>> instead the new syscall gets its own dedicated page with links between
>>> open(2) and openat2(2) to avoid duplicating information such as the list
>>> of O_* flags or common errors.
>>>
>>> In addition to describing all of the key flags, information about the
>>> extensibility design is provided so that users can better understand why
>>> they need to pass sizeof(struct open_how) and how their programs will
>>> work across kernels. After some discussions with David Laight, I also
>>> included explicit instructions to zero the structure to avoid issues
>>> when recompiling with new headers.>
>>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>>
>> I'm just editing this page, and have a question on one piece.
>>
>>> +Unlike
>>> +.BR openat (2),
>>> +it is an error to provide
>>> +.BR openat2 ()
>>> +with a
>>> +.I mode
>>> +which contains bits other than
>>> +.IR 0777 ,
>>
>> This piece appears not to be true, both from my reading of the
>> source code, and from testing (i.e., I wrote a a small program that
>> successfully called openat2() and created a file that had the
>> set-UID, set-GID, and sticky bits set).
>>
>> Is this a bug in the implementation or a bug in the manual page text?
> 
> My bad -- it's a bug in the manual. The actual check (which does work,
> there are selftests for this) is:
> 
> 	if (how->mode & ~S_IALLUGO)
> 		return -EINVAL;
> 
> But when writing the man page I forgot that S_IALLUGO also includes
> those bits. Do you want me to send an updated version or would you
> prefer to clean it up?

I'll clean it up.

So, it should say, "bits other than 07777", right?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
