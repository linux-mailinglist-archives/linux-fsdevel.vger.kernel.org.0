Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4429B33DDB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhCPTms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:42:48 -0400
Received: from p3plsmtpa06-07.prod.phx3.secureserver.net ([173.201.192.108]:49934
        "EHLO p3plsmtpa06-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240515AbhCPTmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:42:37 -0400
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id MFaFlRuNpZK7AMFaGlY8so; Tue, 16 Mar 2021 12:42:29 -0700
X-CMAE-Analysis: v=2.4 cv=INzHtijG c=1 sm=1 tr=0 ts=60510a26
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8
 a=VI-tNiX6VCgJWLn9MxMA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v4] flock.2: add CIFS details
To:     Pavel Shilovsky <piastryyy@gmail.com>,
        =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>
Cc:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com> <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com> <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com> <871rcltiw9.fsf@suse.com>
 <CAKywueREp5mib_4gmofwekrT=GhqoZo1kEmmUmNeqghG0EYYwQ@mail.gmail.com>
 <87pmzzs7lv.fsf@suse.com>
 <CAKywueQPr2H69wvju=U8aKHQw_SA4hB76BObzZVZPppKJnk++A@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <f25b6d85-0299-9557-2eb9-6c7666c8ea6e@talpey.com>
Date:   Tue, 16 Mar 2021 15:42:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAKywueQPr2H69wvju=U8aKHQw_SA4hB76BObzZVZPppKJnk++A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKCpTW3tr2oaj1dHxH6cXkEJTjrTCvoMywd3HQl9fxGJTzeXWd/yMqB9Xg7IrkTliOm6amb8aXrr/9DkSdwBcjxWtVv44Da6TeKhGfmvJzLcD2u5z0G/
 O8ftl7+20nWL5T9D6i81LV410wFbiQi+foj5F+pSdS0X7YlWJiOAk4dT0W2O6Efi2tSXSUN0yBRgecvgeEUWGjfNO1d0JL1PEEfmHkqRvrzmDaFyJFUHrlYa
 nep8V+a1AO9GeQeHnMly+2AaOMLVaOrHYIk8+i7r3+7uTN+gec1IaTdeS6mjpxDPQ1xlLDyQCJvtZLc8OgZbPJhDGtiinHtXMCqFJIjOk5fIFdV4Aq6ncIMU
 BNYNinq5DbrJbDVjCaTzrC2FGnZsh9X+1w7oDLaZoNKuSJRpBJEV+xYCcKZ3rb10/kSWmj/cN65nCLHYbyWD8dYRMZb1ng==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/2021 1:39 PM, Pavel Shilovsky wrote:
> Sure. Thanks!
> 
> I would put more details from
> https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-lockfileex
> :
> 
> """
>    Another important side-effect is that the locks are not advisory anymore:
>    any IO on an exclusively locked file will always fail with EACCES
>    when done from a separate file descriptor; write calls on
>    a file locked for shared access will fail with EACCES when done
>    from any file descriptor including the one used to lock the file.
> """
> 
> Thoughts?

I think it'll be important to define what "exclusive" and "shared"
mean from a Linux/POSIX API perspective, and that will get into dragon
territory. I don't think it's a good idea to attempt that in this
manpage. It is best to leave Windows semantics, and interop with
Windows clients, out of it.

IOW, I personally prefer Aurélien's simple version for now.

Tom.

> 
> --
> Best regards,
> Pavel Shilovsky
> 
> вт, 16 мар. 2021 г. в 03:42, Aurélien Aptel <aaptel@suse.com>:
>>
>> Pavel Shilovsky <piastryyy@gmail.com> writes:
>>> It is not only about writing to a locked file. It is also about any IO
>>> against a locked file if such a file is locked through another file
>>> handle. Right?
>>
>> Yes that was implied, the write was a simple example to illustrate. I'll
>> update to make it more generic:
>>
>>    Another important side-effect is that the locks are not advisory anymore:
>>    any IO on a locked file will always fail with EACCES,
>>    even when done from a separate file descriptor.
>>
>> If you have comments please provide direct text suggestion to save time.
>>
>> Cheers,
>> --
>> Aurélien Aptel / SUSE Labs Samba Team
>> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
>> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
>> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
>>
> 
