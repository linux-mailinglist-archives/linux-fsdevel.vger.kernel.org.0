Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497778B5A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjH1Qxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjH1Qw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:52:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6AE13E;
        Mon, 28 Aug 2023 09:52:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so2500743b3a.2;
        Mon, 28 Aug 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693241573; x=1693846373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LZIVj4rUAeGJ7xui07ULb5M7AQu4gvcO6R5a7/WUD8=;
        b=fv6CcC+jDOSDUm/VQO7Qa+aKpCgqesssmlz8xpNRVp2auAsq52rLUTPfM9qIuBjg3g
         1oMEevASI9cjIJqFjczV8BtFLZf/jsXGONbGk5KhWJKaLzhTDfNWgtxXXm4nm4iYKbiV
         cQv1oPeTLF/QFX55MKEqZpi3PSrtsMDl6UB+jqTBm21JAi0xSAaXO+TA0XZnIfrk6oM4
         MUNF7fjKxVqrqilR6mq+t4jLwD5n3TxiiVQGrZB/LWaFNzioDgh5PCDI30+zmxew9Lh5
         RMVVeT24xuym6hW4BDR+FPzGVYwV61iF87D7iy0dmLtoCmALFYsD64D9MDmkFTK+pMY+
         o9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693241573; x=1693846373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LZIVj4rUAeGJ7xui07ULb5M7AQu4gvcO6R5a7/WUD8=;
        b=QggB9dIIev9oXUcLkxxFzGs3S+e40H9cvogHCPodoFBDfVJQ0kispvGlGiG/M7u8Bh
         JFuisMQjBM6FV6mVr471fJT8GFqBgAT3y6BGJ+j8YzZKHsJmKE/CQkPYCkgpf1S3HIdv
         wdLBIocAHLpObcYPU8r7/pD0FVqM9uyFBRh3zDifkd/5zMt7HQCngAzfBN6XBP+BFryQ
         uX2QXn5sJKNWE1Io8hkVXpvtEFliB8GSwjGA74qP73DigQv2TKf7OFk1kFRiziiQ1fFH
         q5mJXwFQhVIUjFJQR8tzVWJPlVapZf1Awg2+Lm/iK84in0NKsnRGzpV/JZrjCINdqNS2
         uQiA==
X-Gm-Message-State: AOJu0YwHA2r6cMyGKICNAjZQzbREQJWt3DEXW7HlY9/9YhsnkzFbEY1J
        19QJj2uVmf2j1AuDcH0CNn4=
X-Google-Smtp-Source: AGHT+IGfJ8QxT/w3CIw7NTnwVugoja1tzYfAy1ChGXPlHyrgXaReZKXt9GXsKlrl9rVH64OCwy7IZQ==
X-Received: by 2002:a05:6a20:dd82:b0:147:fd40:2485 with SMTP id kw2-20020a056a20dd8200b00147fd402485mr24846816pzb.35.1693241572861;
        Mon, 28 Aug 2023 09:52:52 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id s17-20020a62e711000000b00682b299b6besm6881273pfh.70.2023.08.28.09.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 09:52:52 -0700 (PDT)
Message-ID: <3216b72e-76d9-368b-a903-cd3acee96438@gmail.com>
Date:   Mon, 28 Aug 2023 22:22:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
References: <20230813055948.12513-1-ghandatmanas@gmail.com>
 <2023081621-mosaic-untwist-a786@gregkh>
 <54a8ae10-71f4-9e91-d2b7-bd4a30a8ac2a@gmail.com>
 <CAKYAXd9-NjSjt-TrJ6fYcPDHcaUm-L=-h5OU98DTw97J2qwmXA@mail.gmail.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <CAKYAXd9-NjSjt-TrJ6fYcPDHcaUm-L=-h5OU98DTw97J2qwmXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I was looking at this issue for some time now. As suggested by Anton, 
that the vol->sparse_compression_unit is set at the mount. I cannot seem 
to find the code for that part. It seems that the ntfs_inode struct does 
not have any sparse_compression_unit. So I am stuck at that part of the 
problem.

On 28/08/23 08:30, Namjae Jeon wrote:
> 2023-08-18 15:34 GMT+09:00, Manas Ghandat <ghandatmanas@gmail.com>:
>> Sorry for the last reply Greg. The last tag specifies the commit id.
>> Also, I have sent the v5 of the patch in which I have made some critical
>> changes. Please take a look at that.
> Have you checked build error report from kernel test robot ?
