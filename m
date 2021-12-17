Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2D147900E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 16:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhLQPfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhLQPfJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:35:09 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF813C06173E;
        Fri, 17 Dec 2021 07:35:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so4779750wrn.6;
        Fri, 17 Dec 2021 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=a61dwGg5kNck2h9UyOHXeB38uPudu+Kv2w4sF0fimo8=;
        b=n1vCtjdvnP2vWrdzO12WfvWtGsNEsSgeUNmKS/GsYvR/7jE0VM2v8v+rJ7Dnd1lHAZ
         AAsQ6OcCEfMTh74TwUl8W3IJ4yeyIcvdoEIFMgUNngnzeGmhfsDNUSY2u/XwJcxXpqrH
         Zh01LOwEaCPD8u0Pn3Hao1HL+71hVXr8WtLipq3JxkRmaGm2ksior7HWsI1Zz3/3MOq2
         YkkeFaIIYGXN5tsZgpjG+rLhWYxuhqmW7UUfmwtYo3vIqGhCPGf0k/JUv1RsYX8jfheK
         GGzLHA+OxxbzhROIttk5YLY0eDUoEYRnKdTUnNydAdt0+YzaOvLJTZRtuO8zQ/iMvJbE
         RwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=a61dwGg5kNck2h9UyOHXeB38uPudu+Kv2w4sF0fimo8=;
        b=hU0lquFOsUJIK2IFKswMrHWkvsuthzYgjVlgHEb+3nglzxIgq510ScHoUrrus2zzQo
         LlDt36w1VFJxSmfzxP1MJba7QGE0cVHUkpWNm1tYvO55/V/mJsoghJ485hbFKEiv0hef
         10A2uGf6pCoc8GOv7a+1kWThHnQOeFbKVziW5ctVuEo4g8hj1oT08BH9BhJbYxEUeIR/
         tATcB59CANeDuAB6YbD1/ZwRzoTM0m8Oh3L0uVO98MAj1HEuocCLhA6w7aGiFcA0ohZ0
         +fSHE78FGWmL3VFNViizBkTJbwAN+jco8DDrV9+CesP4gnUoBvI9+/yXnh0Lp4xOqO5t
         nSYg==
X-Gm-Message-State: AOAM5329hBStuKL8+xwzq5byGka2+Jlg3aouQ5mAnrGZ+MGIB53E5r6k
        +TQCg6M4yOTa8rvNWJsrPwc=
X-Google-Smtp-Source: ABdhPJzWqOuMF8uv9eeQBx0fJPw+2ederWM9Jv4EQM34YPBVqMM4mwwtEhI+i/7ISvTG5TJtjvlBlg==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr1866345wrs.554.1639755307361;
        Fri, 17 Dec 2021 07:35:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:d0f6:769:a23b:b01? (p200300ea8f24fd00d0f60769a23b0b01.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:d0f6:769:a23b:b01])
        by smtp.googlemail.com with ESMTPSA id z11sm8109532wmf.9.2021.12.17.07.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:35:07 -0800 (PST)
Message-ID: <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
Date:   Fri, 17 Dec 2021 16:34:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
In-Reply-To: <20211217152456.l7b2mbefdkk64fkj@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.2021 16:24, Lukas Czerner wrote:
> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
>> On linux-next systemd-remount-fs complains about an invalid mount option
>> here, resulting in a r/o root fs. After playing with the mount options
>> it turned out that data=ordered causes the problem. linux-next from Dec
>> 1st was ok, so it seems to be related to the new mount API patches.
>>
>> At a first glance I saw no obvious problem, the following looks good.
>> Maybe you have an idea where to look ..
>>
>> static const struct constant_table ext4_param_data[] = {
>> 	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
>> 	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
>> 	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
>> 	{}
>> };
>>
>> 	fsparam_enum	("data",		Opt_data, ext4_param_data),
>>
> 
> Thank you for the report!
> 
> The ext4 mount has been reworked to use the new mount api and the work
> has been applied to linux-next couple of days ago so I definitelly
> assume there is a bug in there that I've missed. I will be looking into
> it.
> 
> Can you be a little bit more specific about how to reproduce the problem
> as well as the error it generates in the logs ? Any other mount options
> used simultaneously, non-default file system features, or mount options
> stored within the superblock ?
> 
> Can you reproduce it outside of the systemd unit, say a script ?
> 
Yes:

[root@zotac ~]# mount -o remount,data=ordered /
mount: /: mount point not mounted or bad option.
[root@zotac ~]# mount -o remount,discard /
[root@zotac ~]#

"systemctl status systemd-remount-fs" shows the same error.

Following options I had in my fstab (ext4 fs):
rw,relatime,data=ordered,discard

No non-default system features.

> Thanks!
> -Lukas
> 
Heiner
