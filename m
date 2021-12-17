Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4380947924E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 18:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhLQRCd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 12:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhLQRCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:02:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EBC06173E;
        Fri, 17 Dec 2021 09:02:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id b73so2088600wmd.0;
        Fri, 17 Dec 2021 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to:cc
         :references:subject:in-reply-to:content-transfer-encoding;
        bh=7OY0ipbTNHppihv4uiHlmPW2EzoJ4jrhw1Jcm5vQBnk=;
        b=k2wIzoFDT6lWZ5HzKiA3Rv9ywmAQ1POSBOtJZDt1akjM8AS5OUr0Nt3NuLBPLqdeHs
         bhjU4EsFp6w5gwPLmBuowGAX+b6fkqm8cVVJ1X/yLJMd6HhVfytJKR8eddHYwqV4Wn44
         v9QtPPxA4PwonhRNeUxnDHKZ7v6hwS7BqGiFBcFJfRCsnnRl0M0srmrNzP5YoVWHEdZF
         Nc+jyTqF3kQs9mxHB86TdrSjNyhdtNzEJF8VGhqD5lWImB9yB4NoguVM8ZpABtQJBR87
         Om6fR0ouO1t6iRAtdmHc/BiNFMldo93eL0KwzjNtRZAOXDQDoiihQIbQ6Q0e+zTidzIi
         /8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:subject:in-reply-to
         :content-transfer-encoding;
        bh=7OY0ipbTNHppihv4uiHlmPW2EzoJ4jrhw1Jcm5vQBnk=;
        b=nbyQefcgsXeyST3Apw3U91awB81IuVFUiWrIWOiQ/pwmF0md+KLBjJUkGEGD/7nMk6
         GQAHBcCYDBi/scZlEx1WtrZD0kLFH8rsQpZq8j0Ec22Xulp7HJRgobFz/oeI/ipxK5ky
         YE73kGEPRxiNvhY8CAWt1MiuJKve/OYyjtpNOtaqVElNZEoag00jtF9xg8FI24SSXOck
         +VzDIWBeTPdxAAU+CE/I9NzYr8IvyNnQ9xPeYY4CHPPt0FcOKLBp+4ZPfLefonBQm5d/
         Vjs3OcP05d58j84ug7e50laGd53XccoiCUHx/xOZ+jZ7GTsAX8o+FSO/0FSYOizvwFQj
         TuMw==
X-Gm-Message-State: AOAM533C/XRVdeXvlwXGS38EinoeNCdYJwflSGvtF/BNwcE+RCVwq7vO
        B8TmyBfU/gINZQhycARs0YV6tDD17tw=
X-Google-Smtp-Source: ABdhPJxkGx9iFx8OEUHEI16ci0CrGPapwBffAE4yq9N6TUoZvW5/I+XnYFM75v56x9v+MOF0qaIEcQ==
X-Received: by 2002:a1c:a301:: with SMTP id m1mr10338866wme.118.1639760550056;
        Fri, 17 Dec 2021 09:02:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:d0f6:769:a23b:b01? (p200300ea8f24fd00d0f60769a23b0b01.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:d0f6:769:a23b:b01])
        by smtp.googlemail.com with ESMTPSA id t17sm11871162wmq.15.2021.12.17.09.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 09:02:29 -0800 (PST)
Message-ID: <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com>
Date:   Fri, 17 Dec 2021 18:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work>
 <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
In-Reply-To: <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.2021 16:34, Heiner Kallweit wrote:
> On 17.12.2021 16:24, Lukas Czerner wrote:
>> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
>>> On linux-next systemd-remount-fs complains about an invalid mount option
>>> here, resulting in a r/o root fs. After playing with the mount options
>>> it turned out that data=ordered causes the problem. linux-next from Dec
>>> 1st was ok, so it seems to be related to the new mount API patches.
>>>
>>> At a first glance I saw no obvious problem, the following looks good.
>>> Maybe you have an idea where to look ..
>>>
>>> static const struct constant_table ext4_param_data[] = {
>>> 	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
>>> 	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
>>> 	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
>>> 	{}
>>> };
>>>
>>> 	fsparam_enum	("data",		Opt_data, ext4_param_data),
>>>
>>
>> Thank you for the report!
>>
>> The ext4 mount has been reworked to use the new mount api and the work
>> has been applied to linux-next couple of days ago so I definitelly
>> assume there is a bug in there that I've missed. I will be looking into
>> it.
>>
>> Can you be a little bit more specific about how to reproduce the problem
>> as well as the error it generates in the logs ? Any other mount options
>> used simultaneously, non-default file system features, or mount options
>> stored within the superblock ?
>>
>> Can you reproduce it outside of the systemd unit, say a script ?
>>
> Yes:
> 
> [root@zotac ~]# mount -o remount,data=ordered /
> mount: /: mount point not mounted or bad option.
> [root@zotac ~]# mount -o remount,discard /
> [root@zotac ~]#
> 
> "systemctl status systemd-remount-fs" shows the same error.
> 
> Following options I had in my fstab (ext4 fs):
> rw,relatime,data=ordered,discard
> 
> No non-default system features.
> 
>> Thanks!
>> -Lukas
>>
> Heiner

Sorry, should have looked at dmesg earlier. There I see:
EXT4-fs: Cannot change data mode on remount
Message seems to be triggered from ext4_check_opt_consistency().
Not sure why this error doesn't occur with old mount API.
And actually I don't change the data mode.
