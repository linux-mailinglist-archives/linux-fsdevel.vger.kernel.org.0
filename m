Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB23F337AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCKRaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 12:30:09 -0500
Received: from p3plsmtpa07-07.prod.phx3.secureserver.net ([173.201.192.236]:55921
        "EHLO p3plsmtpa07-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhCKR3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:29:37 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id KP7tlQdLndxhWKP7uls8lT; Thu, 11 Mar 2021 10:29:35 -0700
X-CMAE-Analysis: v=2.4 cv=cpdeL30i c=1 sm=1 tr=0 ts=604a537f
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=pGLkceISAAAA:8 a=B3RzK8wqSUdCYLsOpbkA:9
 a=QEXdDO2ut3YA:10 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com> <87eegltxzd.fsf@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com>
Date:   Thu, 11 Mar 2021 12:29:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87eegltxzd.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEgeUJrJHZJrI1wvEDZrPU9VWzHHHJ5etqjy022aGphLjk++a8foxL3rXHHG0tRZxb9Hko2HiUskvSndihWG1Nb+JosWO3EycH8JyQr3uTcd8Ruf8d6m
 nBuih9xCePs1zsJQ9EDQBRL+ghH4bWcB7opxsgB1UA1ZQyQ2MUThzCV7VrrnBr5d+wZdP1tykAbw8DZTn96trhDod1tuzS23MxPQNUo+y2q+hGjy7lJL2Owi
 bN51XQ7ZgvH3PBt6OMq53TH94saRqu4gW3LR5qdu/91RF581L2rNlmK0BlDh4mBYUhkq+cH1Oq1HjdqUBBt4EXl1PggmVxj8z3cZ6HQe9AYeX1VhfP9kxTJQ
 ALhkBGHQq43ldwuDmW3PBvhtTcS1sK+iHpF5y3vvyF//UI3CeY8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/2021 12:13 PM, Aurélien Aptel wrote:
> Tom Talpey <tom@talpey.com> writes:
> 
>> On 3/11/2021 5:11 AM, Aurélien Aptel wrote:
>>> "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:
>>>> I agree with Tom.  It's much easier to read if you just say that 'nobrl'
>>>> torns off the non-locale behaviour, and acts as 5.4 and earlier kernels.
>>>>     Unless there's any subtlety that makes it different.  Is there any?
>>>
>>> nobrl also makes fnctl() locks local.
>>> In 5.4 and earlier kernel, flock() is local but fnctl() isn't.
>>>
>>>> BTW, you should use "semantic newlines":
>>>
>>> Ok, I'll redo once we agree on the text.
>>
>> I wonder if it's best to leave the nobrl details to the mount.cifs
>> manpage, and just make a reference from here.
>>
>> Another advantage of putting this in a cifs.ko-specific manpage
>> is that it would be significantly easier to maintain. The details
>> of a 5.4-to-5.5 transition are going to fade over time, and the
>> APIs in fcntl(2)/flock(2) really aren't driving that.
> 
> I was trying to write in the same style as the NFS details just above (see
> existing man page). Give basic overview of the issues.
> 
>> If not, it's going to be messy... Aurélien is this correct?
>>
>> cifs.ko flock()
>> - local in <= 5.4
>> - remote by default in >= 5.5
>> - local if nobrl in >= 5.5
>>
>> cifs.ko fcntl()
>> - remote by default in X.Y
>> - local if nobrl in X.Y
> 
> Correct.
> 
>> Not sure what the value(s) of X.Y actually might be.
> 
> AFAIK fcntl() was always remote by default.
> And nobrl was added in 2.6.15 (15 years ago). I wouldn't bother
> mentionning X.Y, it's already complex enough as it is.
> 
>> It seems odd that "nobrl" means "handle locking locally, and never
>> send to server". I mean, there is always byte-range locking, right?
> 
> Yes the option name can be confusing. Byte-range locking is always
> possible, but with "nobrl" it's local-only.
> 
>> Are there any other options or configurations that alter this?
> 
> I've taken another long look at the cifs.ko and samba code. There are
> many knobs that would make an accurate matrix table pretty big.

I vote for simplicity! Especially on the fcntl(2) page in question.
Totally agree on not mentioning 2.6.x in a current manpage.

> * If the mount point is done on an SMB1+UNIX Extensions
>    connection, locking becomes advisory. Unless
>    forcemandatorylock option is passed. This will eventually be
>    implemented for SMB3 posix extensions as well (I've started a
>    thread on the samba-technical mailing list).

NO SMB1 discussion! Any manpage update should not add discussion of
an obsolete nonsecure deprecated protocol, and should definitely not
passively encourage its consideration.

> * If cifs.ko can get guarantees (via oplocks or leases) that it is the
>    only user of a file, it caches read/writes but also locking
>    locally. If the lease is broke then it will send the locks.
>    The levels of caching cifs.ko can do can be changed with the cache
>    mount option.

I think this is relevant to some sort of smb(7) manpage, but is much
too detailed and subtle for a paragraph summary in fcntl(2).

To be more clear, my updated thinking is to mostly drop the details
in the closing sentence:

> The nobrl mount option (see mount.cifs(8)) turns off  fnctl(2)
>   and  flock() lock propagation to remote clients and makes flock() locks
>   advisory again.

and simply state (perhaps)

  "Remote and mandatory locking semantics may vary with SMB protocol,
   mount options and server type. See mount.cifs(8) for additional
   information."

Tom.
