Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCA3B7CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 06:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhF3Ew7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 00:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhF3Ew6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:52:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C17C061760;
        Tue, 29 Jun 2021 21:50:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x16so1263003pfa.13;
        Tue, 29 Jun 2021 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ih/5Nva+sERVyI3phX+JlQ0UWPIAUb3maiYKveHsY0=;
        b=SYnsfHQRrT67MAawYTDoxV4OfYq4NxRX1wHSRq8Y1MXxzoZLjn+lZqyCAIEACFpGiU
         nkDMUwSfVrUU9TfSMthVoE1VDTTYYx5WGS1Sxi2BUs7oVa8lDXdSg/33qNX84cLwBC/W
         x//NYFLrwc0zCDIj18pqlvLHnpsW3LnUnlpzEwE3sQFk/WVUa9TjwAOWhBjyRnoO+W9S
         ty0CrFntOKdV71FycnGqIlfcY2DmnKMoVbKMdtEEkgTuIvNB6jL8QY2V0PM+jh+6I45R
         MWj0X8K4wnXmeI4CHb2r6d4ZdhllU9PLSK85d0AdTKHGX+Y9ALum7sljYrN/P4KQLlxM
         /pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ih/5Nva+sERVyI3phX+JlQ0UWPIAUb3maiYKveHsY0=;
        b=Y/Z5XvqN5gOVwe3vrmmtRYcp8RJ/JFLctabj0VtJQsNpXJSUrE3aYltlOgpbPiUtkt
         9QRwC0faj8ptSj/WUXKNeeHHkhfUPzG1YTi8Q+IJ7BRLvCyw9O7qnOK6lTsf934FMaBN
         rJGG06n38AnvmtGR99e7LzXgmTG3YMMFWTlWgvnFA/+9mckFZchQDNN7h+GqP7/IAoUE
         8NfovJcOpX5J6jBGgAOSFeIFqN8HtykgwsQMFXdYN9TGArHvpgZDmd4FW6iJE4UzXzIk
         pyZV6oYwPZu05Rq3F7l+OYPMn2R9By3c6V/NzFYgkmifzgV38xJvUSDkrirBRowntYe1
         8lxg==
X-Gm-Message-State: AOAM532p6gxd07hjWeA7oNWao4wsC+kJ3hny5QbI2iVhmmSrDo6d2YbQ
        70M5PMEkFqLfh0JsQ4XGidw=
X-Google-Smtp-Source: ABdhPJx7T2SMm+OqTpb9jbIAzW8c2VrANN3PTAAOIqJ/nHc3hecyU3ySD4YhBLRYmHxFsM1outAvUg==
X-Received: by 2002:a63:348f:: with SMTP id b137mr7669225pga.164.1625028628815;
        Tue, 29 Jun 2021 21:50:28 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id e4sm19331263pfa.29.2021.06.29.21.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 21:50:28 -0700 (PDT)
Subject: Re: [PATCH 1/3] hfs: add missing clean-up in hfs_fill_super
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-2-desmondcheongzx@gmail.com>
 <28CCF4E3-51D1-43BE-A2BA-4708175A59C0@dubeyko.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <6c6d6cd8-b8b3-54a9-f0bd-b36220caba26@gmail.com>
Date:   Wed, 30 Jun 2021 12:50:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <28CCF4E3-51D1-43BE-A2BA-4708175A59C0@dubeyko.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/6/21 3:13 am, Viacheslav Dubeyko wrote:
> 
> 
>> On Jun 29, 2021, at 7:48 AM, Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com> wrote:
>>
>> On exiting hfs_fill_super, the file descriptor used in hfs_find_init
>> should be passed to hfs_find_exit to be cleaned up, and to release the
>> lock held on the btree.
>>
>> The call to hfs_find_exit is missing from this error path, so we add
>> it in to release resources.
>>
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>> fs/hfs/super.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>> index 44d07c9e3a7f..48340b77eb36 100644
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -419,6 +419,7 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
>> 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
>> 	if (!res) {
>> 		if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
>> +			hfs_find_exit(&fd);
> 
> I see that there are several places of hfs_find_exit() calls in hfs_fill_super(). Maybe, it makes sense to move the hfs_find_exit() call to the end of the hfs_fill_super()? In this case we could process this activity of resources freeing into one place. I mean line 449 in the source code (failure case).
> 
> Thanks,
> Slava.
> 
>> 			res =  -EIO;
>> 			goto bail;
>> 		}
>> -- 
>> 2.25.1
>>
> 

Thanks for the suggestion. Since the bail and bail_no_root error paths 
are used before hfs_find_init and after hfs_find_exit are called in the 
normal execution case, moving hfs_find_exit under the bail label 
wouldn't work.

Perhaps this can be done by introducing another goto label. Any thoughts 
on the following?

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 44d07c9e3a7f..12d9bae39363 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -420,14 +420,12 @@ static int hfs_fill_super(struct super_block *sb, 
void *data, int silent)
         if (!res) {
                 if (fd.entrylength > sizeof(rec) || fd.entrylength < 0) {
                         res =  -EIO;
-                       goto bail;
+                       goto bail_hfs_find;
                 }
                 hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, 
fd.entrylength);
         }
-       if (res) {
-               hfs_find_exit(&fd);
-               goto bail_no_root;
-       }
+       if (res)
+               goto bail_hfs_find;
         res = -EINVAL;
         root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
         hfs_find_exit(&fd);
@@ -443,6 +441,8 @@ static int hfs_fill_super(struct super_block *sb, 
void *data, int silent)
         /* everything's okay */
         return 0;

+bail_hfs_find:
+       hfs_find_exit(&fd);
  bail_no_root:
         pr_err("get root inode failed\n");
  bail:
