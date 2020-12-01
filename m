Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A62CAD1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404452AbgLAUNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAUNb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:13:31 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8225C0613D6;
        Tue,  1 Dec 2020 12:12:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so4710202wrv.6;
        Tue, 01 Dec 2020 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IkAyTK5WrJCCDZaLD/B8JqCAe79ez+VAw2qbJysVOoU=;
        b=Xn7E1CD0Gu/wqJDs4+Fic7LqPgSuTSsZSzSijnTryRI8aoL0+17fiXhHc06fI8yDnf
         clbOsgVrmaJJsAbQ666W/KSrdivTmgO9hsj72+/4as3sZBxZI0OKVqWnLrb848h/5SUc
         1BQ1rgwEUMPi/7SaXYu1C7/D8G2UU/dXPANSD57SaS91Y13JT2lSoUMdHZXjMKz3B0KL
         uj/+BaXEWak8RZZNSkaphhVkD3g1c8kSZX8Njwj1wUCtjZ4QUzm8XjI/T4x3XFyhpa3+
         s/vQY1EOdLrkq2ajRaAo9kKJpUaBeIYIrwMcTaLP2aghDvtGThcbYuLUdIbhwFKXOOah
         VReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkAyTK5WrJCCDZaLD/B8JqCAe79ez+VAw2qbJysVOoU=;
        b=BqTNb6f1musb2+G6VHqZfvd+v3kkCHvq3zzkzvlLBWF+7LvHzWyjshxXF4y+4OwvQS
         k2MDuq+khf5Ioih4P5gibxlXf/bSBSTdzr/cT8lOht4PXe+aXxM/ewyrnctXuDpHujUt
         9t6ViFWzwhjyv67e5e+Ph1CzzmuRrtipG+jnKorchYRONDJj1LTHj6FkmZAN5/TWnrLq
         Os7UtCiTcXiJwouk02ydwQHtBp6Tb2SXB685w/6vEYEQppGJjt6SLYMaSXpjAcUj4MQu
         i4hJK02Ar6s0XXCSo3t1erMSmQPGdAw7qfP6j+Hci2YcO9lg1Xxj1ROZrK8B1sqneAwK
         pKGA==
X-Gm-Message-State: AOAM533OploUjwFT7KwZ+K8ttKAAAApSclFbrUHt1+7EHar0ZoPhsvYE
        YsY7k/SKlLxkbyydi19v3yTmHNH5I7BEaA==
X-Google-Smtp-Source: ABdhPJz7bDZ7jquh0qeBkBIHaXp0edhhs9j5QFJNI1+Pgigf5XgPDW9WMtEGnEUzfRyk5CBHanLfUg==
X-Received: by 2002:a5d:4d88:: with SMTP id b8mr6108399wru.134.1606853569160;
        Tue, 01 Dec 2020 12:12:49 -0800 (PST)
Received: from ?IPv6:2001:a61:3aad:c501:15d9:d9fb:bc21:cb92? ([2001:a61:3aad:c501:15d9:d9fb:bc21:cb92])
        by smtp.gmail.com with ESMTPSA id x5sm960822wrm.96.2020.12.01.12.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 12:12:48 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com, linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH man-pages v6] Document encoded I/O
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
References: <cover.1605723568.git.osandov@fb.com>
 <ec1588a618bd313e5a7c05a7f4954cc2b76ddac3.1605724767.git.osandov@osandov.com>
 <4d1430aa-a374-7565-4009-7ec5139bf311@gmail.com>
 <fb4a4270-eb7a-06d5-e703-9ee470b61f8b@gmail.com>
 <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <dcb0679d-3ac5-dd95-5473-3c66ae4132b6@gmail.com>
Date:   Tue, 1 Dec 2020 21:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <05e1f13c-5776-961b-edc4-0d09d02b7829@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alex,

On 11/20/20 4:03 PM, Alejandro Colomar (man-pages) wrote:
> Hi Omar,
> 
> I found a wording of mine to be a bit confusing.
> Please see below.
> 
> Thanks,
> 
> Alex
> 
> On 11/20/20 3:06 PM, Alejandro Colomar (man-pages) wrote:
>> Hi Omar and Michael,
>>
>> please, see below.
>>
>> Thanks,
>>
>> Alex
>>
>> On 11/20/20 12:29 AM, Alejandro Colomar (mailing lists; readonly) wrote:
>>> Hi Omar,
>>>
>>> Please, see some fixes below:
>>>
>>> Michael, I've also some questions for you below
>>> (you can grep for mtk to find those).
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>> On 11/18/20 8:18 PM, Omar Sandoval wrote:
>>>> From: Omar Sandoval <osandov@fb.com>
>>>>
>>>> This adds a new page, encoded_io(7), providing an overview of encoded
>>>> I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
>>>> reference it.
>>>>
>>>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>>>> Cc: linux-man <linux-man@vger.kernel.org>
>>>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>>>> ---
>>>> This feature is not yet upstream.
>>>>
>>>>  man2/fcntl.2      |  10 +-
>>>>  man2/open.2       |  23 +++
>>>>  man2/readv.2      |  70 +++++++++
>>>>  man7/encoded_io.7 | 369 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 471 insertions(+), 1 deletion(-)
>>>>  create mode 100644 man7/encoded_io.7
>>>>
>>>> diff --git a/man2/fcntl.2 b/man2/fcntl.2
>>>> index 546016617..b0d7fa2c3 100644
>>>> --- a/man2/fcntl.2
>>>> +++ b/man2/fcntl.2
>>>> @@ -221,8 +221,9 @@ On Linux, this command can change only the

[...]

>>>> +.PP
>>>> +This may be extended in the future, so
>>>> +.I iov[0].iov_len
>>>> +must be set to
>>>> +.I "sizeof(struct\ encoded_iov)"
>>>> +for forward/backward compatibility.
>>>> +The remaining buffers contain the encoded data.
>>>> +.PP
>>>> +.I compression
>>>> +and
>>>> +.I encryption
>>>> +are the encoding fields.
>>>> +.I compression
>>>> +is
>>>> +.B ENCODED_IOV_COMPRESSION_NONE
>>>> +(zero)
>>>> +or a filesystem-specific
>>>> +.B ENCODED_IOV_COMPRESSION
>>>
>>> Maybe s/ENCODED_IOV_COMPRESSION/ENCODED_IOV_COMPRESSION_*/
>>
>> Or s/ENCODED_IOV_COMPRESSION/ENCODED_IOV_COMPRESSION_/
>>
>> I'm not sure about existing practice.
>>
>> Michael (mtk), what would you do here?

I think I've tended towards the former
(ENCODED_IOV_COMPRESSION_*) in the past.

>>
>>>
>>>> +constant;
>>>> +see
>>>> +.BR Filesystem\ support .
>>>
>>> Please, write it as [.BR "Filesystem support" .]
>>>
>>> and maybe I would change it, to be more specific, to the following:
>>>
>>> [
>>> see
>>> .B Filesystem support
>>> below.
>>> ]
>>>
>>> So that the reader clearly understands it's on the same page.
>>>
>>>> +.I encryption
>>>> +is currently always
>>>> +.B ENCODED_IOV_ENCRYPTION_NONE
>>>> +(zero).
>>>> +.PP
>>>> +.I unencoded_len
>>>> +is the length of the unencoded (i.e., decrypted and decompressed) data.
>>>> +.I unencoded_offset
>>>> +is the offset into the unencoded data where the data in the file begins
>>>
>>> The above wording is a bit unclear to me.
>>>
>>> I suggest the following:
>>>
>>> [
>>> .I unencoded_offset
>>> is the offset from the begining of the file
>>> to the first byte of the unencoded data
>>> ]
> 
> Now I've read it again, and my wording was even worse than yours.
> I think yours can be understood after a few reads.
> 
> However, I'll still try to reword mine to see if I add some value:
> 
> [
> .I unencoded_offset
> is the offset from the first byte of the unencoded data
> to the first byte of logical data.
> ]
> 
> If you prefer yours, or a mix, that's fine.
> 
>>>
>>>> +(less than or equal to
>>>> +.IR unencoded_len ).
>>>> +.I len
>>>> +is the length of the data in the file
>>>> +(less than or equal to
>>>> +.I unencoded_len
>>>> +-
>>>
>>> Here's a question for Michael (mtk):
>>>
>>> I've seen (many) cases where these math operations
>>> are written without spaces,
>>> and in the same line (e.g., [.IR a + b]).
>>>
>>> I'd like to know your preferences on this,
>>> or what is actually more extended in the manual pages,
>>> to stick with only one of them.

I suspect there's a lot of inconsistency across pages. For simple
cases like this, I think writing it without spaces is fine, and
perhaps even preferable.

>>>
>>>> +.IR unencoded_offset ).
>>>> +See
>>>> +.B Extent layout
>>>> +below for some examples.
>>>> +.I
>>>
>>> Were you maybe going to add something there?
>>>
>>> If not, please remove that [.I].
>>>
>>>> +.PP
>>>> +If the unencoded data is actually longer than
>>>> +.IR unencoded_len ,
>>>> +then it is truncated;
>>>> +if it is shorter, then it is extended with zeroes.
>>>> +.PP
>>>> +
>>>
>>> Please, remove that blank line.
>>>
>>>> +.BR pwritev2 ()
>>>
>>> Should be [.BR pwritev2 (2)]
>>>
>>> Michael (mtk),
>>>
>>> Am I right in that?  Please, confirm.

Yes. References to functions documented in other pages should
include the section number in parentheses.

[...]

>>>> +.PP
>>>> +However, suppose we read 50 bytes into a file
>>>> +which contains a single compressed extent.
>>>> +The filesystem must still return the entire compressed extent
>>>> +for us to be able to decompress it,
>>>> +so
>>>> +.I unencoded_len
>>>> +would be the length of the entire decompressed extent.
>>>> +However, because the read was at offset 50,
>>>> +the first 50 bytes should be ignored.
>>>> +Therefore,
>>>> +.I unencoded_offset
>>>> +would be 50,
>>>> +and
>>>> +.I len
>>>> +would accordingly be
>>>> +.IR unencoded_len\ -\ 50 .
>>>
>>> This formats everything as I, except for the last dot.
>>> Replace by:
>>>
>>> [
>>> .I unencoded
>>> - 50.
>>> ]
>>>
>>> Michael (mtk), same as above:
>>> to space, or not to space?  That is the question :p

In this case, perhaps

.IR unencoded \-1

[...]


>>>> +.SS Security
>>>> +Encoded I/O creates the potential for some security issues:
>>>> +.IP * 3
>>>> +Encoded writes allow writing arbitrary data which the kernel will decode on
>>>> +a subsequent read. Decompression algorithms are complex and may have bugs
>>>> +which can be exploited by maliciously crafted data.
>>>> +.IP *
>>>> +Encoded reads may return data which is not logically present in the file
>>>> +(see the discussion of
>>>> +.I len
>>>> +vs.
>>>
>>> Please, s/vs./vs/
>>> See the reasons below:
>>>
>>> Michael (mtk),
>>>
>>> Here the renderer outputs a double space
>>> (as for separating two sentences).
>>>
>>> Are you okay with that?

Yes, that should probably be avoided. I'm not sure what the
correct way is to prevent that in groff though. I mean, one
could write

.RI "vs.\ " unencoded_len

but I think that simply creates a nonbreaking space,
which is not exactly what is desired.

[....]

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
