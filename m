Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39440696832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 16:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjBNPge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 10:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjBNPgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:36:33 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC810242
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 07:36:31 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y69so2674553iof.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676388991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0T2UJE2bMCBLwJStDfFX+eI9IUgxEljeFPQRg6MREQ=;
        b=3CwmEVnFjLIj2M7AESv5Ufvhjj5LMYX0FPahCxQHOYCUcX921x3nAR9l6A+ke3073r
         nG3fPdc1R8o3Uzw4l1+NFLMJqtExZc+iH1FlLz7xemEFHu7HWQTwCuQs2HPN/1z7IpU6
         1n6sjsIVDnb/L66aSmmOWhu3Z19HhWzhE/5DGgDdcJU+I6EbqxE4YZaAhqIibCpUW1Tl
         PrrrQrpJhKuO29MrCUVjLaw6taogwwofsySJfqFxUzeSc5uvn8FQY8O8waMf3pPGdejB
         8vqb8X+ZX5YJd7rOhi2ZDMZVUClmIZ36jvehoVgGCM1U5Xh8KLi/W1yhsy16HSty/iJF
         0FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676388991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0T2UJE2bMCBLwJStDfFX+eI9IUgxEljeFPQRg6MREQ=;
        b=YFiMcaGI4oHqocMUfDxAtNBkrj+q8JkjNJ86xLwvt4BObHmC/BCKbXmBwinVlwOWhh
         uzQOR21ig9lxsFP7MAZUWWJqN72Q6Na4cFlFgAhW9dAewqstRpfZpgRrGHV1kla/WBnK
         iK0nRk5aaH/bLP6uScpo2cKy11aS8+fZWaDAWqJzXrhdFwrICKY9YMGV4+MT/Gbrw4An
         DvRib3OJWcUzn5SJAvTMRsHX365miBiSDJnyYwVmB9C4NlX3CuQOyzL6pPp5XpDZ/wAC
         lVtKAEVp6Da18rZyBidWR+U6yr74cyKanb8IcxLA2sYZdkoLAHXQ6g0tIMqBLdFeH0kH
         sZ7w==
X-Gm-Message-State: AO0yUKWtPRdXJU6uMMOOtAHroCfv2Fzbobfs2vlK6h+WdA2tZH2uYu6H
        Qz17Q1lY7B/UTQQmmMfsLYCDfQ==
X-Google-Smtp-Source: AK7set+bvRjsHoUhyxFQhAxs5vunmvxeTg9ZtRFdfIR8WeD4EnyOp3kOo3s2n6ZojHpUHdTM2CUNOA==
X-Received: by 2002:a5d:8183:0:b0:719:6a2:99d8 with SMTP id u3-20020a5d8183000000b0071906a299d8mr1741407ion.0.1676388991145;
        Tue, 14 Feb 2023 07:36:31 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y74-20020a6bc84d000000b0073fd8ca79c6sm1515790iof.9.2023.02.14.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 07:36:30 -0800 (PST)
Message-ID: <9dd98aed-0d9a-eb3e-790c-0dd744be8ccb@kernel.dk>
Date:   Tue, 14 Feb 2023 08:36:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 0/5] iov_iter: Adjust styling/location of new splice
 functions
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230214083710.2547248-1-dhowells@redhat.com>
 <75d74adc-7f18-d0df-e092-10bca4f05f2a@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <75d74adc-7f18-d0df-e092-10bca4f05f2a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/23 2:07?AM, David Hildenbrand wrote:
> On 14.02.23 09:37, David Howells wrote:
>> Hi Jens, Al, Christoph,
>>
>> Here are patches to make some changes that Christoph requested[1] to the
>> new generic file splice functions that I implemented[2].  Apart from one
>> functional change, they just altering the styling and move one of the
>> functions to a different file:
>>
>>   (1) Rename the main functions:
>>
>>     generic_file_buffered_splice_read() -> filemap_splice_read()
>>     generic_file_direct_splice_read()   -> direct_splice_read()
>>
>>   (2) Abstract out the calculation of the location of the head pipe buffer
>>       into a helper function in linux/pipe_fs_i.h.
>>
>>   (3) Use init_sync_kiocb() in filemap_splice_read().
>>
>>       This is where the functional change is.  Some kiocb fields are then
>>       filled in where they were set to 0 before, including setting ki_flags
>>       from f_iocb_flags.
>>
>>   (4) Move filemap_splice_read() to mm/filemap.c.  filemap_get_pages() can
>>       then be made static again.
>>
>>   (5) Fix splice-read for a number of filesystems that don't provide a
>>       ->read_folio() op and for which filemap_get_pages() cannot be used.
>>
>> I've pushed the patches here also:
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract-3
>>
>> I've also updated worked the changes into the commits on my iov-extract
>> branch if that would be preferable, though that means Jens would need to
>> update his for-6.3/iov-extract again.
>>
>> David
>>
>> Link: https://lore.kernel.org/r/Y+n0n2UE8BQa/OwW@infradead.org/ [1]
>> Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.com/ [2]
>>
>> Changes
>> =======
>> ver #3)
>>   - Fix filesystems/drivers that don't have ->read_folio().
>>
>> ver #2)
>>   - Don't attempt to filter IOCB_* flags in filemap_splice_read().
>>
>> Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
>>
> 
> You ignored my RB's :(
> 
> .. but unrelated, what's the plan with this now? As Jens mentioned, it
> might be better to wait for 6.4 for the full series, in which case
> folding this series into the other series would be better.

That is indeed the question, and unanswered so far... Let's turn it into
one clean series, and get it stuffed into for-next and most likely
target 6.4 for inclusion at this point.

-- 
Jens Axboe

