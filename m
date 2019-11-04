Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8BEE6C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfKDR7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 12:59:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37771 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDR7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:59:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id v2so18678514lji.4;
        Mon, 04 Nov 2019 09:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Hb0vhG4XzifRsCm/AwQzk1v4P4RCPqbW8YY2naw+uGI=;
        b=akptdPyre/H4THZPklMLGraeHXYqofVqBfHeS4RBQ6GKMVCww98KrVf2Q1zCDyFCza
         /Mn1W7BW4k+dYBBooPbP1YSZd+MKdEvwwKCx90QqmwcpqOs6MUwkEWqMmfGNs4HSCLq3
         aeqSlvfcRcoY7cnOaRQ8/CFyu9p62iDq43Zqe25d7HRy5Bo28ZbCCHbKmKzCuWb9Lt9+
         TH1LmJDizsGcRslsR3A2wWz1NbRvOMm2U13ImSMs/4y5YSEZLDG1HaM9oePwa78b14sj
         FrV4mQOHZK/QBcBKHdKbHgkgcJrsSbX2Zb/KmOma11tASgUcEJnPvprBQRZ4wNAfyBLr
         t3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Hb0vhG4XzifRsCm/AwQzk1v4P4RCPqbW8YY2naw+uGI=;
        b=jmmGfnb6sqd3JerajE95bxWwBvcPrwu+OxZ6+aE6rvXBpfYwP5AUpn2+HJ/C5Uv9pU
         OzkK+N/xcMrmF+DSQryUc7qjXjsaxNUwmDmFT6Nllq5rIDJSOVeVEPVk8fcyn90J473p
         8Qw09cq9lxpnMfhcfLsFZj1qxMJCqzuLCTDwpMqHwyU8hp+qVIHhVYAFeACvG+PMf15N
         Xt6cZ7diztlaCCZZAmmIA3eanuqxweCRY8+CI0uT+879HfGpUHsWB3V51DDGdbwoSzkC
         wdMTVOBQBXxnoR5MaeMqXSbNB/1bc+N0lnXJtJZPEodZ1rCnaTn8cyp2QYRDhOeFCg2Q
         lc8A==
X-Gm-Message-State: APjAAAVPZC7ZfzNh8q0WGtUlhsn12rME150kpNvrtECUWMal5FjPCB/p
        2PkEDuV6LE+TSFLBnLtBL01awbNq
X-Google-Smtp-Source: APXvYqz2pGcMJfX9TtZAMtNXyj1xeoTSNo9CkQjxQlYlmzmhtCV6C94dR5JFqZHza7hGs7HpVldK4Q==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr20047363lja.48.1572890337917;
        Mon, 04 Nov 2019 09:58:57 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z14sm7246566lfh.30.2019.11.04.09.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 09:58:57 -0800 (PST)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <87d0e8g5f4.fsf@x220.int.ebiederm.org>
 <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
 <87h83jejei.fsf@x220.int.ebiederm.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
Date:   Mon, 4 Nov 2019 19:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87h83jejei.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4.11.2019 17.44, Eric W. Biederman wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> On 3.11.2019 20.50, Eric W. Biederman wrote:
>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>
>>>> Several items in /proc/sys need not be accessible to unprivileged
>>>> tasks. Let the system administrator change the permissions, but only
>>>> to more restrictive modes than what the sysctl tables allow.
>>>
>>> This looks quite buggy.  You neither update table->mode nor
>>> do you ever read from table->mode to initialize the inode.
>>> I am missing something in my quick reading of your patch?
>>
>> inode->i_mode gets initialized in proc_sys_make_inode().
>>
>> I didn't want to touch the table, so that the original permissions can
>> be used to restrict the changes made. In case the restrictions are
>> removed as suggested by Theodore Ts'o, table->mode could be
>> changed. Otherwise I'd rather add a new field to store the current
>> mode and the mode field can remain for reference. As the original
>> author of the code from 2007, would you let the administrator to
>> chmod/chown the items in /proc/sys without restrictions (e.g. 0400 ->
>> 0777)?
> 
> At an architectural level I think we need to do this carefully and have
> a compelling reason.  The code has survived nearly the entire life of
> linux without this capability.

I'd be happy with only allowing restrictions to access for now. Perhaps 
later with more analysis, also relaxing changes and maybe UID/GID 
changes can be allowed.

> I think right now the common solution is to mount another file over the
> file you are trying to hide/limit.  Changing the permissions might be
> better but that is not at all clear.
> 
> Do you have specific examples of the cases where you would like to
> change the permissions?

Unprivileged applications typically do not need to access most items in 
/proc/sys, so I'd like to gradually find out which are needed. So far 
I've seen no problems with 0500 mode for directories abi, crypto, debug, 
dev, fs, user or vm.

I'm also using systemd's InaccessiblePaths to limit access (which mounts 
an inaccessible directory over the path), but that's a bit too big 
hammer. For example there are over 100 files in /proc/sys/kernel, 
perhaps there will be issues when creating a mount for each, and that 
multiplied by a number of services.

>>> The not updating table->mode almost certainly means that as soon as the
>>> cached inode is invalidated the mode changes will disappear.  Not to
>>> mention they will fail to propogate between  different instances of
>>> proc.
>>>
>>> Loosing all of your changes at cache invalidation seems to make this a
>>> useless feature.
>>
>> At least different proc instances seem to work just fine here (they
>> show the same changes), but I suppose you are right about cache
>> invalidation.
> 
> It is going to take the creation of a pid namespace to see different
> proc instances.  All mounts of the proc within the same pid_namespace
> return the same instance.

I see no problems by using Firejail (which uses PID namespacing) with 
v2, the permissions in /proc/sys are the same as outside the namespace.

-Topi
