Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2081546B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbiFJRXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349675AbiFJRXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:23:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DBD4CD6C;
        Fri, 10 Jun 2022 10:23:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id el14so19053938qvb.7;
        Fri, 10 Jun 2022 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ACMCDBad9TbnXtFF1l9kHpG+4dWc333XEZyLbnWKY0k=;
        b=QsvngpAL+7JLouZsHYdLb8NHMutaEvweFnaVmp9QLT8eO1OyXaN2I2wdgFqoLR37en
         oKSZo6fsOfu6LnRNIm3ZaC7cOml/bRetzqrnIaoJkZGxci/hZrYK39ZGWB3PT2BsjSzq
         C3UrEfeKvGQnS0qsczft/YsBcUxcozgPRRqirIFw9gZvPBt49IhICA7v0/QUdfi74tA1
         NCItXaLokOgiMNqRsHKw0Ubqxh31cKmYW5nQh68ogksNp4zupT9hAAgbtSJFmfajs0Ib
         32UBkicfFJjnYByn0FBCSYvKMa02qoVEwsvQRVt3Zo0U8Stjaik6LwSr1D6T8ckho9le
         wlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ACMCDBad9TbnXtFF1l9kHpG+4dWc333XEZyLbnWKY0k=;
        b=n/C56fyvp5nQ63ABRbA+aAPTO1j5aDwx7nH7wW7ukV32Hb/BfUE8y0YothOChtpBt0
         ZhR3Lflv59+UmLwCJHrMndU3yfjvHNWxF8hrOVZEeTgXVkHhq8ixCVLYhg+Nf1lsfHTr
         mjiuQf+vo0eD8WkNePO6AyIfpE+7xu6+uH2QKFE+2D1pYC5OtCmcMxmvAHeEO3Y/2QQW
         59JG2rIjOVgwwDrw3iK89FHlmE/2vyxCBl6rPPOI4vUFRH3Adt0NyutUENSlJu7W1Yc9
         JjybVGw8L4/gg60qJNJWUAEWzDwDTCmHRo81APQ534dMyayInz+HgKQjh3Ox9TcLBfcN
         qfIg==
X-Gm-Message-State: AOAM531lSlc0VMNxh4Noh3EwUEM75fBfgeP+cskqnOzYeg4FKGXaxjg7
        jBlL+NdCZrsVykWomNiJ3YN12BdS8qW+g1EtXA==
X-Google-Smtp-Source: ABdhPJyoH90+gyZLKikOzlW2U25UtQU5qb0MNUzrxkww+g20/Nw85mlOMPe+d8cvA41TuPgzYzhM8g==
X-Received: by 2002:a05:6214:1c45:b0:46b:d221:de2c with SMTP id if5-20020a0562141c4500b0046bd221de2cmr10875631qvb.34.1654881803196;
        Fri, 10 Jun 2022 10:23:23 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id n79-20020a374052000000b0069fc13ce23dsm21584990qka.110.2022.06.10.10.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 10:23:22 -0700 (PDT)
Message-ID: <fdefdb26-05a1-d1d4-3bda-2d4df777b2d5@gmail.com>
Date:   Fri, 10 Jun 2022 13:23:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Yu Kuai <yukuai3@huawei.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220602082129.2805890-1-yukuai3@huawei.com>
 <YpkB1+PwIZ3AKUqg@casper.infradead.org>
 <c49af4f7-5005-7cf1-8b58-a398294472ab@huawei.com>
 <YqNWY46ZRoK6Cwbu@casper.infradead.org>
 <YqNW8cYn9gM7Txg6@casper.infradead.org>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <YqNW8cYn9gM7Txg6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 10:36, Matthew Wilcox wrote:
> On Fri, Jun 10, 2022 at 03:34:11PM +0100, Matthew Wilcox wrote:
>> On Mon, Jun 06, 2022 at 09:10:03AM +0800, Yu Kuai wrote:
>>> On 2022/06/03 2:30, Matthew Wilcox wrote:
>>>> On Thu, Jun 02, 2022 at 04:21:29PM +0800, Yu Kuai wrote:
>>>>> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
>>>>> while it should be 'iocb->ki_ops'.
>>>>
>>>> Can you walk me through your reasoning which leads you to believe that
>>>> it should be ki_pos instead of ki_pos + copied?  As I understand it,
>>>> prev_pos is the end of the previous read, not the beginning of the
>>>> previous read.
>>>
>>> Hi, Matthew
>>>
>>> The main reason is the following judgement in flemap_read():
>>>
>>> if (iocb->ki_pos >> PAGE_SHIFT !=	-> current page
>>>      ra->prev_pos >> PAGE_SHIFT)		-> previous page
>>>          folio_mark_accessed(fbatch.folios[0]);
>>>
>>> Which means if current page is the same as previous page, don't mark
>>> page accessed. However, prev_pos is set to 'ki_pos + copied' during last
>>> read, which will cause 'prev_pos >> PAGE_SHIFT' to be current page
>>> instead of previous page.
>>>
>>> I was thinking that if prev_pos is set to the begining of the previous
>>> read, 'prev_pos >> PAGE_SHIFT' will be previous page as expected. Set to
>>> the end of previous read is ok, however, I think the caculation of
>>> previous page should be '(prev_pos - 1) >> PAGE_SHIFT' instead.
>>
>> OK, I think Kent broke this in 723ef24b9b37 ("mm/filemap/c: break
>> generic_file_buffered_read up into multiple functions").  Before:
>>
>> -       prev_index = ra->prev_pos >> PAGE_SHIFT;
>> -       prev_offset = ra->prev_pos & (PAGE_SIZE-1);
>> ...
>> -               if (prev_index != index || offset != prev_offset)
>> -                       mark_page_accessed(page);
>>
>> After:
>> +       if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
>> +               mark_page_accessed(page);
>>
>> So surely this should have been:
>>
>> +       if (iocb->ki_pos != ra->prev_pos)
>> +               mark_page_accessed(page);
>>
>> Kent, do you recall why you changed it the way you did?

So the idea was that if we're reading from a different _page_ that we 
read from previously, we should be marking it accessed. But there's an 
off by one error, it should have been

if (iocb->ki_pos >> PAGE_SHIFT != (ra->prev_pos - 1) >> PAGE_SHIFT)
	folio_mark_accessed(fbatch.folios[0])

It looks like this is what Yukai was arriving at too when he was saying 
ki_pos + copied - 1, this is just a cleaner way of writing it :)
