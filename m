Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC940429885
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 22:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhJKU63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbhJKU60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:58:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB95FC061570;
        Mon, 11 Oct 2021 13:56:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ec8so22832456edb.6;
        Mon, 11 Oct 2021 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ou+xUmJ66fQiXPaSvBFHMERJHyRQrKzeVENEuBhsFMw=;
        b=owW+fhG7GjuwP1vy5pweOXYMtVFuNOKqE9mr2LzmYD4pTxTYggUcNvNs6W/f9y13ep
         TUYNkj1dOWPbHbdVzOFqUuhKpi4c3SbGhqyy3lqk0HNSmtCmfePBAEwlTbjweruk0CB/
         My+jLK+fAhlao8lNRgqVtHqldCwin7KnF0nYQYvZcR8Dr1OSl8HVaex9m/+VkQS8C6V+
         mpnNQ+CG3fOUqMOWrOx3uf79IowRQJheFfAQCbsmhw/yn+3Xc4HoU3dnnd9n+FvaCOMk
         vtiaipsQZxce2wfvh0I+UiXp//NSxEd1ree+UKYvuTWL+4IdG2mxqUT/OACB3Au+IWZ7
         Wwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ou+xUmJ66fQiXPaSvBFHMERJHyRQrKzeVENEuBhsFMw=;
        b=omUXD3lPtq9r33Iikrpehm+ANEVti2c2wR9nvi2ukQvcDWI80NFpllW/0AgkvKRhcK
         lrM89Qpahuj5VkVtbaE+JigL6uhjmt6G3ArB/G0PgDzUINDiNaJI7zOeUZ0fIF+mv9CP
         eTIScR/EQ30XaklplphaikbvYyKy4IL18INIFv0jzO4rGAPE5R4NEkoCVyNvHLC+jMSA
         uH1qNhWIpCk2Pew26EjnQPzyGkVN2rW7O2v8khdUQe+hbIJT0B50cIasmiUT3Lz2xU7+
         z+Jp5Tquj3yxKZw/erwGsW22kpOFEhRqa5hzUV9Rw83d4gz+BXz/hfxbQISSDX75LjiK
         QL1w==
X-Gm-Message-State: AOAM533cMf4t5Im4blgrJNDJ+gN7yr17Vzc6jSIltJL21P//Tv6SgLK1
        diF/80KHJZO2+DFWeuY+oSo=
X-Google-Smtp-Source: ABdhPJwSODPcwmzd88n3/Iui5Rdwmxb8aTTUKUAVsLOv+cz4qEqxxTdTPz0CbDqbLD5vNGYWb7JmUQ==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr19506883edd.94.1633985784310;
        Mon, 11 Oct 2021 13:56:24 -0700 (PDT)
Received: from [192.168.0.163] ([37.239.218.34])
        by smtp.gmail.com with ESMTPSA id n6sm4772657eds.10.2021.10.11.13.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 13:56:24 -0700 (PDT)
Message-ID: <0021ec0c-737a-398f-53ca-8daa284744b6@gmail.com>
Date:   Mon, 11 Oct 2021 23:56:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kari Argillander <kari.argillander@gmail.com>
References: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
 <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
 <c892016c-3e50-739b-38d2-010f02d52019@gmail.com>
 <bcbb8ddc-3ddf-4a91-6e92-d5cee2722bad@paragon-software.com>
 <2998a9b9-8ea0-6a44-7093-66c7a08dcab2@gmail.com>
 <7e5b8dc9-9989-0e8a-9e8d-ae26b6e74df4@paragon-software.com>
Content-Language: en-US
In-Reply-To: <7e5b8dc9-9989-0e8a-9e8d-ae26b6e74df4@paragon-software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/11/21 19:55, Konstantin Komarov wrote:
> Hello.
>
> Presumably we found the code, that panics.
> But it panics in place, where pointer must be always not NULL.
> Please try patch provided below.
> If it helps (there is no panic), then check dmesg for
> message "Looks like internal error".
> And please compare copied folders.
> This way it will be clear what file / folder cause this logic error.
>
> Thanks for all your help so far.

Ok,

This helped, unfortunately the error is sporadic and i can't easily 
track down which file caused the crash .

In one test it seemd it was caused by files in three directories 
"package", "system" , "support" (all these directories are from the 
"buildroot" tree, most of the files that failed to copy were symlinks, 
don't know if that makes a difference)  but after rebooting and loading 
the unpatched ntfs3.ko i was able to copy these files without a crash!

It seems that the crash happens when copying large number of files so 
even a failed file can be copied if it was copied alone (I might be very 
wrong in my conclusion here)

anyways, i did multiple tests. in the first a few it copied without a 
crash and skipped a few files( the dmesg didn't contain the "Looks like 
internal error" message).

on subsequent tests i did get that message like so:

[  186.295722] ntfs3: sdb1: ino=1a, Looks like internal error
[  186.296219] ntfs3: sdb1: ntfs3_write_inode r=1a failed, -22

That "ino=1a" looks wrong to me !

  I will try to do more tests if i can but it's a bit annoying because 
each crash causes the file system to be corrupted and "ntfsfix" can't 
fix these errors so i have to reboot to windows os to be able to use 
"chkdsk" to fix the filesystem before doing the next test.

It would be nice if Paragon  releases "fsck.ntfs" that works well in 
these situations so we don't need to boot to windows to fix them


Regards


>
> [PATCH] fs/ntfs3: Check for NULL pointers in ni_try_remove_attr_list
>
> All these checks must be redundant.
> If this commit helps, then there is bug in code.
>
> Signed-off-by: Konstantin 
> Komarov<almaz.alexandrovich@paragon-software.com>
> ---
> fs/ntfs3/frecord.c | 23 ++++++++++++++++++++++-
> 1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index ecb965e4afd0..37e19fe7d496 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -705,18 +705,35 @@ static int ni_try_remove_attr_list(struct 
> ntfs_inode *ni)
> continue;
> mi = ni_find_mi(ni, ino_get(&le->ref));
> + if (!mi) {
> + /* Should never happened, 'cause already checked. */
> + goto bad;
> + }
> attr = mi_find_attr(mi, NULL, le->type, le_name(le),
> le->name_len, &le->id);
> + if (!attr) {
> + /* Should never happened, 'cause already checked. */
> + goto bad;
> + }
> asize = le32_to_cpu(attr->size);
> /* Insert into primary record. */
> attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
> le->name_len, asize,
> le16_to_cpu(attr->name_off));
> - id = attr_ins->id;
> + if (!attr_ins) {
> + /*
> + * Internal error.
> + * Either no space in primary record (already checked).
> + * Either tried to insert another
> + * non indexed attribute (logic error).
> + */
> + goto bad;
> + }
> /* Copy all except id. */
> + id = attr_ins->id;
> memcpy(attr_ins, attr, asize);
> attr_ins->id = id;
> @@ -732,6 +749,10 @@ static int ni_try_remove_attr_list(struct 
> ntfs_inode *ni)
> ni->attr_list.dirty = false;
> return 0;
> +bad:
> + ntfs_inode_err(&ni->vfs_inode, "Looks like internal error");
> + make_bad_inode(&ni->vfs_inode);
> + return -EINVAL;
> }
> /*
