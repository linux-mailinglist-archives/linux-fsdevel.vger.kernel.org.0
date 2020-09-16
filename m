Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0268126C096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 11:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIPJai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIPJa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:30:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC0C06174A;
        Wed, 16 Sep 2020 02:30:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l71so1068707pge.4;
        Wed, 16 Sep 2020 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SCNEyiBlJTYXRBwb8N4Xh5OTPZHbrAxllnyvvCrU834=;
        b=DpgP0VPFGiabQndlchr2GZuxIFhIbTpWJFgPCtwrGRnbEl8aSxp8gpEaPz0xJVtK6g
         eubjr3mu/98KuJ48lZH7E67467IqPDzwQsFeG2gWDusrivJaCfbe2WpD5iNbpXLE5toW
         hrh8zOdfzLPCVER+dqIpprDC8caB51rvB0/iQJwBeeSPdO1TW/Ay1HY9bRjGUQr/9K9i
         YGJilZzwzW2VYfmLVhkh3imc+m9N8TOnON15NGIvl12ChXEcJy1Z9TgW8f++c/cjg+Hy
         q6HOIbEgXdGPsLlVcQYhp5nEfvJSqf1v/7ZEx27ZQQmsKHv9IgEhpAdscR8mBBF9gHsk
         LBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCNEyiBlJTYXRBwb8N4Xh5OTPZHbrAxllnyvvCrU834=;
        b=mHOfzmOjiS39+DWNxFSg6KKpSFcyAulrXlvmSRQcz+PnYRHqxf2a/McxURojcmMx/O
         1A+xOpQLWROc0b7K2R/l8dkyKXSvh5ud6mbJl72x+C/qZKLd2Q/QWm8XudpecxpiLD1Y
         njjPW158MB/jKfYucMtmSI7dNSAGbHotiIi+rB16X1B0znHAptCIHEyzQLKivBda33In
         Fz28ln8U0Caa2z12jPv1mcXXbZAyYUf6WN3KtZxDaZPpY1yZHZgp+wxE5O0pQSskv8tH
         TXGA1m839ce01oWAwckJF2X+omZ0ZDzvLv/9fDAAexk1LxKOBhvGmHB84GBBxxJbqDI8
         fErQ==
X-Gm-Message-State: AOAM532HCB/al8+EQZzsBbXTJWa1xdNjbyKKoAK58+BKFGGryt+Kx1n6
        0hfacp83mkFWoDt6z0GIg2sHekAAHrM=
X-Google-Smtp-Source: ABdhPJy6RsWtsvBDRTjJH2DVVNgy/U4ByLFwTKrz49kE984yOxc5aum6LeJ82rmIUkTC2ujeQWPb1A==
X-Received: by 2002:a63:781:: with SMTP id 123mr11064255pgh.295.1600248628085;
        Wed, 16 Sep 2020 02:30:28 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id m24sm14309073pgn.44.2020.09.16.02.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:30:27 -0700 (PDT)
Subject: Re: [PATCH 2/3] exfat: remove useless check in exfat_move_file()
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200911044511epcas1p4d62863352e65c534cd6080dd38d54b26@epcas1p4.samsung.com>
 <20200911044506.13912-1-kohada.t2@gmail.com>
 <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <8a430d18-39ac-135f-d522-90d44276faf8@gmail.com>
Date:   Wed, 16 Sep 2020 18:30:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <015f01d68bd1$95ace4d0$c106ae70$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> --- a/fs/exfat/namei.c
>> +++ b/fs/exfat/namei.c
>> @@ -1095,11 +1095,6 @@ static int exfat_move_file(struct inode *inode,
>> struct exfat_chain *p_olddir,
>>   	if (!epmov)
>>   		return -EIO;
>>
>> -	/* check if the source and target directory is the same */
>> -	if (exfat_get_entry_type(epmov) == TYPE_DIR &&
>> -	    le32_to_cpu(epmov->dentry.stream.start_clu) == p_newdir->dir)
>> -		return -EINVAL;
>> -
> 
> It might check if the cluster numbers are same between source entry and
> target directory.

This checks if newdir is the move target itself.
Example:
   mv /mnt/dir0 /mnt/dir0/foo

However, this check is not enough.
We need to check newdir and all ancestors.
Example:
   mv /mnt/dir0 /mnt/dir0/dir1/foo
   mv /mnt/dir0 /mnt/dir0/dir1/dir2/foo
   ...

This is probably a taboo for all layered filesystems.


> Could you let me know what code you mentioned?
> Or do you mean the codes on vfs?

You can find in do_renameat2(). --- around 'fs/namei.c:4440'
If the destination ancestors are itself, our driver will not be called.


BTW
Are you busy now?
I am waiting for your reply about "integrates dir-entry getting and validation" patch.

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
