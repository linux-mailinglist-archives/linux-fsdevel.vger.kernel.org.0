Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B93479410
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhLQS0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 13:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhLQS0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:26:37 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D444DC061574;
        Fri, 17 Dec 2021 10:26:36 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so4689538wmb.0;
        Fri, 17 Dec 2021 10:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=KV+FDN9BPfOKArptCyEPtP+g5PqRElDD4grRoqnSLFw=;
        b=hjE4c28aDU2h4w5xpxVUvi76InQcTtif6oD1soUp93UbrcvX5EnkJifNFaqqMGtiyK
         I9sdC4vy5Y7M8FBoZxxoWuMfe12E3uTgJACYutgeGOxyQOjgmXz5nBYXOx9AosQn6Q4Q
         cDdB6UKn//GjLWy3cpqdL8dxTHt8qJ9Ck4NTJtp2YhE5v76vXLF62A4VFkQy05RtvQ6l
         WqDWbl9MHulhFs61gOWxZmgYaDoeGZTtE8DcMXTg4g2t9ZAkAYIUQFqvbnhtG3RhkZ1b
         FMiIpnquILoS5NOyyPDTCFn66eCiO6W5g2sYElEdvS9l32Pr6759ChzBpiByG9ucs0Ob
         bElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=KV+FDN9BPfOKArptCyEPtP+g5PqRElDD4grRoqnSLFw=;
        b=JPC4mk6kVwpnuceSepxGFnLKp2Pr4V+jJE/MCndw5w9gqrW4uqJkPw3AJPqccYiAcm
         W3brNOkX+pspaSoO4sve28/almiwI3TJKLhaLkv6xQF99k/6vuVxKHIjpnJq0oYI1EDF
         FcxKLdOCF4kGIL0NIGO5CJccdRTBIDqcqlbRMb4J2/H1Y1T6pdTJFFdi8O3oOvtARnfb
         jSaMMs2PGqOFGl6/xdZf1OmAhuoSWJDASEGkGNGJFM5rcXXp03Lm170aONrfnD5lAg+b
         SfEfZLm1ztvV1EfcZiCJJgt1blNs6Po1og7izD3XIqcgVhyzmZLp5raUO5R7cq2DvuSl
         M+UQ==
X-Gm-Message-State: AOAM530RnSopaDsHM5CKW04yoapJv4Yl3112/c7SYUV/Ps67L7GaQNHs
        /+nahUGzrtCqVG+xfX7erutkm4z0eY0=
X-Google-Smtp-Source: ABdhPJzSVMMqWobq8puIAZRwwMXLnEKwBznx2SdCfHspVYhEMOds13EyTDyCjzTx92ppGQ9j6jsUgw==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr10593108wmh.140.1639765594905;
        Fri, 17 Dec 2021 10:26:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:d0f6:769:a23b:b01? (p200300ea8f24fd00d0f60769a23b0b01.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:d0f6:769:a23b:b01])
        by smtp.googlemail.com with ESMTPSA id e1sm6023353wrc.74.2021.12.17.10.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 10:26:34 -0800 (PST)
Message-ID: <d05a95a9-0bbd-3495-2b81-18673909edd4@gmail.com>
Date:   Fri, 17 Dec 2021 19:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work>
 <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
 <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com>
In-Reply-To: <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.2021 18:02, Heiner Kallweit wrote:
> On 17.12.2021 16:34, Heiner Kallweit wrote:
>> On 17.12.2021 16:24, Lukas Czerner wrote:
>>> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
>>>> On linux-next systemd-remount-fs complains about an invalid mount option
>>>> here, resulting in a r/o root fs. After playing with the mount options
>>>> it turned out that data=ordered causes the problem. linux-next from Dec
>>>> 1st was ok, so it seems to be related to the new mount API patches.
>>>>
>>>> At a first glance I saw no obvious problem, the following looks good.
>>>> Maybe you have an idea where to look ..
>>>>
>>>> static const struct constant_table ext4_param_data[] = {
>>>> 	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
>>>> 	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
>>>> 	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
>>>> 	{}
>>>> };
>>>>
>>>> 	fsparam_enum	("data",		Opt_data, ext4_param_data),
>>>>
>>>
>>> Thank you for the report!
>>>
>>> The ext4 mount has been reworked to use the new mount api and the work
>>> has been applied to linux-next couple of days ago so I definitelly
>>> assume there is a bug in there that I've missed. I will be looking into
>>> it.
>>>
>>> Can you be a little bit more specific about how to reproduce the problem
>>> as well as the error it generates in the logs ? Any other mount options
>>> used simultaneously, non-default file system features, or mount options
>>> stored within the superblock ?
>>>
>>> Can you reproduce it outside of the systemd unit, say a script ?
>>>
>> Yes:
>>
>> [root@zotac ~]# mount -o remount,data=ordered /
>> mount: /: mount point not mounted or bad option.
>> [root@zotac ~]# mount -o remount,discard /
>> [root@zotac ~]#
>>
>> "systemctl status systemd-remount-fs" shows the same error.
>>
>> Following options I had in my fstab (ext4 fs):
>> rw,relatime,data=ordered,discard
>>
>> No non-default system features.
>>
>>> Thanks!
>>> -Lukas
>>>
>> Heiner
> 
> Sorry, should have looked at dmesg earlier. There I see:
> EXT4-fs: Cannot change data mode on remount
> Message seems to be triggered from ext4_check_opt_consistency().
> Not sure why this error doesn't occur with old mount API.
> And actually I don't change the data mode.

Based on the old API code: Maybe we need something like this?
At least it works for me.

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b7..9ec7e526c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2821,7 +2821,9 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
                                 "Remounting file system with no journal "
                                 "so ignoring journalled data option");
                        ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
-               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
+               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS &&
+                          (ctx->vals_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) !=
+                          (sbi->s_mount_opt & EXT4_MOUNT_DATA_FLAGS)) {
                        ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
                                 "on remount");
                        return -EINVAL;
