Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301AF7805E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357396AbjHRGec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 02:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356584AbjHRGeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:34:23 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3B3A94;
        Thu, 17 Aug 2023 23:34:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a81437be28so386864b6e.0;
        Thu, 17 Aug 2023 23:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692340462; x=1692945262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38rkmW3TQIcTdI5/jSxJ3xKQMGKCkoLsED1vztdBOnM=;
        b=AnTsUWWukNzb3xYXmf+gmyJyLu4ZZCalKfIyBogLJU/Isx8TCUcZmW0wFyiIJwQogi
         jgfzh2RYWzqQLUbS5Ucuy5s368DaAisJnt2foUlpHNP5DTAu9eN9hvsXt1urqaHSd01i
         gOwGt/UJDE7sMqXMp58OyZJ5WyX3dLwZsEViq1pJnr8dhzXeT9+zxKs167mmnEJLkLH3
         Z0dJus+rSAcZFhzyJ4GLICH4qbFsLrOlGluMcBcMn5n/qiwHCEn/X2F9puytwVJFvjS6
         RcGz9kCAD5dh/3JEj7YWvsfJ1zNlsHmRJbI2Y0HmiFezXxOmKiSYuY0pg/m3AwB0OQFg
         /hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692340462; x=1692945262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38rkmW3TQIcTdI5/jSxJ3xKQMGKCkoLsED1vztdBOnM=;
        b=ar0OgySNPM2I3xJa4PAVq8E78ykUpx0gLLnbRMJV7ll3LGJyM2CI+uIijWuKC+w0Mc
         jHC68Wtn7PYTEzoqA3054XDMyg4aGfjeTR8MvvCaNgl9MKLLXPpOq27EVScbx4lT5a9L
         U8YNwn041Bx147Qj2nan+SRD3PBfEGYez/5RnMXrKjNvFe4Yg8yn2Uhn86uIGPQEqG1a
         qbCpE75RiZcJGC+25sz4cux8SNML86GhMfdNcd0TlM2iRfAHIyDQ3xEe7rxLVOj2JpQT
         uvy/Bp7XB/AqGUfhfDeGdZ4Yg6PZibAD38py34/d+TDfnS76ALPB+8WKDdmBhE12ZlbV
         hxLw==
X-Gm-Message-State: AOJu0Yz/kpacEkAnMHmTI+bdRULz5NnqGOehAMsjxp9YBvW2+v+e1Mj3
        2ND1ffDhNX/f+x082HwM2Fw=
X-Google-Smtp-Source: AGHT+IFOx3J6HEKmKWHIbx8sxYyeFqTa65nccBi7EkFrszyIBIdZY5gBZ+nNiTyHNkQtpZj9LQlHkg==
X-Received: by 2002:a05:6808:1887:b0:3a7:30ad:df28 with SMTP id bi7-20020a056808188700b003a730addf28mr2214541oib.37.1692340462085;
        Thu, 17 Aug 2023 23:34:22 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id k125-20020a636f83000000b005641bbe783bsm726348pgc.11.2023.08.17.23.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 23:34:21 -0700 (PDT)
Message-ID: <54a8ae10-71f4-9e91-d2b7-bd4a30a8ac2a@gmail.com>
Date:   Fri, 18 Aug 2023 12:04:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
References: <20230813055948.12513-1-ghandatmanas@gmail.com>
 <2023081621-mosaic-untwist-a786@gregkh>
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <2023081621-mosaic-untwist-a786@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the last reply Greg. The last tag specifies the commit id. 
Also, I have sent the v5 of the patch in which I have made some critical 
changes. Please take a look at that.

On 17/08/23 00:45, Greg KH wrote:
> On Sun, Aug 13, 2023 at 11:29:49AM +0530, Manas Ghandat wrote:
>> Currently there is not check for ni->itype.compressed.block_size when
>> a->data.non_resident.compression_unit is present and NInoSparse(ni) is
>> true. Added the required check to calculation of block size.
>>
>> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
>> Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
>> Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b
> What is this last tag for?  That's a kernel release version, what can be
> done with that?
>
> confused,
>
> greg k-h
