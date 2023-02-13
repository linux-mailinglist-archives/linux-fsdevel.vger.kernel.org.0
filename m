Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A66954B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBMXZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 18:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMXZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:25:10 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE329D;
        Mon, 13 Feb 2023 15:25:09 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so1361345oom.9;
        Mon, 13 Feb 2023 15:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG4M2FiCWZdfBc3bqex6t22oymKlU4aiV0BoUciV/7M=;
        b=qfyyNtPm5aX7849RxnBVXfrh86MGk3uGh71xTAWWzX0BQDeHD4dtKDsFxHFd3sd19B
         jzR00FFEPFNhBVZPg9OQHDn/HovTBm0SKeSl24J2xMrFbp+l45XQsRMgiBjAcL5dvozG
         T2tbzV9KndhVMWvHizmqwZPgZjK+6OkQfWDWOW9TNu1iSE/cG8qiXJa6OTkzwMPHVcHl
         YUZleisxw8iJie3JU5I9PSs9AJ3Ld0iVyv9O4Ttokp1VirSkhS+QQYPxFAtQT3GfE6m7
         G8CEBsjdeHz4esXS6haAu9twfGKui5r0wfsDKjTSODzG/QRN3ztpyZjeiraPww70Hsek
         jquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG4M2FiCWZdfBc3bqex6t22oymKlU4aiV0BoUciV/7M=;
        b=2lm1LA71mOxxAklUjn2rjCGz8jwFFVSfVxZHwqFZPaBno1fFPsoa0LVHtK/X3Vlx7L
         qtmWgVzQ4JU0sY/s26M7MQ2VKUoMy025xYj7kcaisqLvT3wyAr12Fb43qkT6nB3Lzp3B
         RHtqk6VDXdU1xdBy5U5NDLDbIAm4mSIQA27msNniWORSatt8Vtyjy9tMJo/LHI9EnA6v
         e81uxrRX0rYj1poXByzJf+3yitCeecwJEifK9KBoO+/MxPlEkm5y+0aeMI9LpbAPaZiE
         TNqYVK/9lOXM4qayIUe6lLfKer+4gPVN80M0i98jG+0KMIFxM2xGxUtvjZsZopSqnJ56
         hRGQ==
X-Gm-Message-State: AO0yUKXu0nnUSrUAtU/FtkvF0clWPsugQUh5DP8KTK1VeRwGQsRS+Xqe
        pqQJ/4C96CFK+e9y9bABtI7B36S4qnk=
X-Google-Smtp-Source: AK7set/qALlndimeA9x3BBcoDg5VbwZLy8QzB7Xmc0UELSi3M7hFIniw3as3t//wHc5jLfC1GLOCbQ==
X-Received: by 2002:a4a:8c6e:0:b0:517:8369:23e4 with SMTP id v43-20020a4a8c6e000000b00517836923e4mr10405ooj.0.1676330708821;
        Mon, 13 Feb 2023 15:25:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a4a88ce000000b005177c244f31sm5331482ooh.41.2023.02.13.15.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 15:25:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9d2baf8-4a70-313d-eebe-f0e4d1646971@roeck-us.net>
Date:   Mon, 13 Feb 2023 15:25:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <55e2bef1-e8b5-3475-21df-487bddb47f5b@roeck-us.net>
 <20230213180632.GA368628@roeck-us.net>
 <20230209102954.528942-1-dhowells@redhat.com>
 <20230209102954.528942-4-dhowells@redhat.com>
 <2416073.1676328192@warthog.procyon.org.uk>
 <2451113.1676329970@warthog.procyon.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v13 03/12] splice: Do splice read from a buffered file
 without using ITER_PIPE
In-Reply-To: <2451113.1676329970@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/13/23 15:12, David Howells wrote:
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Both are initrd.
> 
> Do you mean rootfs?  And, if so, is that tmpfs-based or ramfs-based?
> 

Both are provided to the kernel using the -initrd qemu option,
which usually means that the address/location is passed to the kernel
through either a register or a data structure. I have not really paid
much attention to what the kernel is doing with that information.
It is in cpio format, so it must be decompressed, but I don't know how
it is actually handled (nor why this doesn't fail on other boots
from initrd).

Guenter

