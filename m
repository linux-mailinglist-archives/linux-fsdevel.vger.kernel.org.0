Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8DEF67A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 08:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbfKEHfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 02:35:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47089 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfKEHfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:35:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so7285512ljp.13;
        Mon, 04 Nov 2019 23:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cay3/WnjxU6wm6NbF5bf+wImiPBa6xb0ML2uvLs1A1Q=;
        b=pXCBGTi3guJrHxMjzi4/2tE4H4AOt/1CHXZw1kW1T9jq0whADMepNtLCPc9cFCNPZ5
         Pplvm4wE4iZEljvEkhJ4dsBKgR9eo2lZl1aLQQUpX3ivB3YCh0H86jD5/5rffJaRFH6B
         2avwu2KxpwVFiCREittkp6YaLrfhYfKo6dNlpfRSWTnvlBJwMKWWbq1U/9YvFihKLsan
         E4DC25TR9GMQfLzS+Zp5X6Rqf1Mwd5p8lCflZLvQS6EIdna4IUH3JdM1PQZpa/ol6VVp
         NqxXrBk7DsrdykbhtQ3YJKcH7npe8qaxTVVBkGdej9+3d8il5Omcd5hXYln2LhLG+SxF
         6lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cay3/WnjxU6wm6NbF5bf+wImiPBa6xb0ML2uvLs1A1Q=;
        b=PCNIF/RretI8nTSNzYKZ7pfay54Wsf5nYIcqCAP0srzJptTjJKiqwKOMg9McM7iJEo
         5Lgp8OSZadi7AGpohjR2tm7TEbB7C87HKUPzbimN8Mnxmwm681gwPFT9k7Jn4/jdefMy
         uk1A8m8517F/5BDoDlIGgwpjW142HevtuVQ+1XqOZz83A3rbx/UaquL90mmi6Mah+QBP
         ncu9hAOvlC+A5xKFb2A8yAT5rSzKtyssml3vjVJh8yFhqcKFDwk+AaIZflhdV8kHeb+7
         rAsIS0fWBzs4tKT41IMZaouwyLcnmMH9CW6OJebmtYfzhE37vK6yB4y7BxHeUmIJeEbO
         hJZQ==
X-Gm-Message-State: APjAAAX1ztv2tAc5JD494qLgYwZx9Zl9z1yiNv37610L18qCxuNKCuA3
        ZPKU+b4xcKdovdi+8IyZRFOpGCxS
X-Google-Smtp-Source: APXvYqwSfnkECT6oaVzmxrR/nnJYWbkvhi5uFLMDTzWYVBBaOXVrB1FCm39zDJJXZVYkM2+OhKDELw==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr15202567lji.162.1572939349337;
        Mon, 04 Nov 2019 23:35:49 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id n5sm9711531ljh.54.2019.11.04.23.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 23:35:48 -0800 (PST)
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
 <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
 <87tv7jciq3.fsf@x220.int.ebiederm.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <1b0f94ef-ab1c-cb79-dd52-954cf0438af1@gmail.com>
Date:   Tue, 5 Nov 2019 09:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87tv7jciq3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5.11.2019 1.41, Eric W. Biederman wrote:
> Topi Miettinen <toiwoton@gmail.com> writes:
> 
>> On 4.11.2019 17.44, Eric W. Biederman wrote:
>>> Do you have specific examples of the cases where you would like to
>>> change the permissions?
>>
>> Unprivileged applications typically do not need to access most items
>> in /proc/sys, so I'd like to gradually find out which are needed. So
>> far I've seen no problems with 0500 mode for directories abi, crypto,
>> debug, dev, fs, user or vm.
> 
> But if there is no problem in letting everyone access the information
> why reduce the permissions?

Because information could be useful to an attacker. If there is no 
problem in not letting everyone access the information why not allow 
reducing the permissions? There certainly is no need to know.

>> I'm also using systemd's InaccessiblePaths to limit access (which
>> mounts an inaccessible directory over the path), but that's a bit too
>> big hammer. For example there are over 100 files in /proc/sys/kernel,
>> perhaps there will be issues when creating a mount for each, and that
>> multiplied by a number of services.
> 
> My sense is that if there is any kind of compelling reason to make
> world-readable values not world-readable, and it doesn't break anything
> (except malicious applications) than a kernel patch is probably the way
> to go.

With kernel patch, do you propose to change individual sysctls to not 
world-readable? That surely would help everybody instead of just those 
who care enough to change /proc/sys permissions. I guess it would also 
be more effort by an order of magnitude or two to convince each owner of 
a sysctl to accept the change.

> Policy knobs like this on proc tend to break in normal maintenance
> because they are not used enough so I am not a big fan of adding policy
> knobs just because we can.

But the rest of the /proc (except PID tree) allows changing permissions 
(and also UID and GID), just /proc/sys doesn't. This doesn't seem very 
logical to me.

These code paths have not changed much or at all since the initial 
version in 2007, so I suppose the maintenance burden has not been 
overwhelming.

By the way, /proc/sys still allows changing the {a,c,m}time. I think 
those are not backed anywhere, so they probably suffer from same caching 
problems as my first version of the patch.

-Topi
