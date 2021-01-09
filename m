Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143232F040D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 23:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAIWPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 17:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbhAIWPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 17:15:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540BC0617A6;
        Sat,  9 Jan 2021 14:14:44 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k10so10599408wmi.3;
        Sat, 09 Jan 2021 14:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/zpkGW7a69S0VR+5/8Yu5vdOpGByElepmhCfoBPQ2mo=;
        b=RbX1ODHS6VJgKgMdJ/A+dGqejXS+I+CImG1L3kE79XKaGsSicTgCTlAeBsDO7dVxMR
         3XSJGauaufUHGlgQUl7rd/AccI2BM9q/QYxxfbwSKFkBHDHvmgLSBMEUN1Y6RXGCSg8S
         224Td1cQWsQFsHAlY0TGl7Oqs+x0np42oisCti8kfKEjwkw5mN5Bo1uAw8WkyASg6f2s
         i9ieWQmJezYRTGbkyWtUNcTAC1b7thHmycQMBL3FQnH+GrxN+qNPEtqQ6GvJAVupy3Wv
         FLODb469l9c/E3rAHM3m/i1GVtVYS+XchWqsHTc4jT5VjaOzzIWI6qsrubpsyfnE160e
         g7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/zpkGW7a69S0VR+5/8Yu5vdOpGByElepmhCfoBPQ2mo=;
        b=LY+0KEodsQg1d1ghi3NQV2shyJmms667TheTZuc1xppuSYiDTVqe5nqvKrkelGs88J
         uQM5RmVEQ047nOmnaLzD2VMjCwQp5ZmIGLkdlz+94lITbZiLx8e6dvdR15tV3PhIej6E
         L/vjHHuCfc1OgVC+kCrhlIY2MzRAB1Kw0P60WGA4/aJIMqIxpKOoqU4H4SnW7Srdk29Y
         dDBSPJB1fvy7WtjZAQrZ2v22GEohLi6kndBAFu8v/yQKBz5WQUJvk1SWMYQBNAfI1zB2
         Bypq09M2pI4wydAjGn3zAvvgRmpW2bUagncr0MD+3Xi0z+Xezhx3T1lzjK4ZX7lRwH2C
         HgDA==
X-Gm-Message-State: AOAM531AxrFCmf+n2WgcYoHVNvsoRB2GcKrP82ir97v2yVPLQrOGEOme
        zKbqcjoEhTej0hJbez9W2Ea1hsQS8Ulno0Vn
X-Google-Smtp-Source: ABdhPJxyJfEUSonqzw1c6n3WPezLUWDa1stAEj4mBkVnICTMpGQoYzYe3N5zVGR68I8wVp2ESVTIwA==
X-Received: by 2002:a1c:804a:: with SMTP id b71mr8719812wmd.21.1610230482735;
        Sat, 09 Jan 2021 14:14:42 -0800 (PST)
Received: from [192.168.8.114] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id f77sm16297617wmf.42.2021.01.09.14.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 14:14:42 -0800 (PST)
To:     David Laight <David.Laight@ACULAB.COM>,
        'Al Viro' <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
Date:   Sat, 9 Jan 2021 22:11:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/01/2021 21:49, David Laight wrote:
> From: Al Viro
>> Sent: 09 January 2021 17:04
>>
>> On Sat, Jan 09, 2021 at 04:09:08PM +0000, Pavel Begunkov wrote:
>>> On 06/12/2020 16:01, Pavel Begunkov wrote:
>>>> On 21/11/2020 14:37, Pavel Begunkov wrote:
>>>>> The problem here is that iov_iter_is_*() helpers check types for
>>>>> equality, but all iterate_* helpers do bitwise ands. This confuses
>>>>> compilers, so even if some cases were handled separately with
>>>>> iov_iter_is_*(), corresponding ifs in iterate*() right after are not
>>>>> eliminated.
>>>>>
>>>>> E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
>>>>> still checks for discard iter type and generates unreachable code down
>>>>> the line.
>>>>
>>>> Ping. This one should be pretty simple
>>>
>>> Ping please. Any doubts about this patch?
>>
>> Sorry, had been buried in other crap.  I'm really not fond of the
>> bitmap use; if anything, I would rather turn iterate_and_advance() et.al.
>> into switches...
> 
> That loses any optimisations in the order of the comparisons.
> The bitmap also allows different groups to be optimised for in different code paths.

You still can have a fast path and even retoss ITER_* for convenience.
Other use cases are not important at the current state.

> 
>> How about moving the READ/WRITE part into MSB?  Checking is just as fast
>> (if not faster - check for sign vs. checking bit 0).  And turn the
>> types into straight (dense) enum.
> 
> Does any code actually look at the fields as a pair?
> Would it even be better to use separate bytes?
> Even growing the on-stack structure by a word won't really matter.

u8 type, rw;

That won't bloat the struct. I like the idea. If used together compilers
can treat it as u16.

btw there is a 4B hole just after for x64.

-- 
Pavel Begunkov
