Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF0324C217
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHTPXw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgHTPXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:23:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E231C061385;
        Thu, 20 Aug 2020 08:23:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so1810383qke.11;
        Thu, 20 Aug 2020 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qL5TkkkE9pAlsRexPTWC6FTHlHmqCvp0RW0Ns7VE8aY=;
        b=d41PYKbV7PRXH0CoFSYkrhnObRoDTSH93E0MohpAsomaEQdl/fdt2dUlefB6sTpUm8
         ThfwpxbBkO88f0hyQbSr7RD0osXvSQS5IHF02IW3uqAs0+3ysMfCMQ/9jKsTQm/HCfh7
         vimxWvwk0KL9D5UEtjLYFrMSWJeglu5cN70yIVTtOGSDbxJ0p4j+8OCDo8Y6PFC/4rsP
         OTwqvWf2XAMxQUerCgGLJ57DLx255kjJxCm3UJIFo7PLF9NKSw1/Y4HJBiQEMKoJfb16
         7+e9PuyklyqbUQXEMGk6Qcf64wNMRBQ2n1pfWggyBFG6vmQ0j9NDPSRnAE3GjxIOaS1n
         uTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qL5TkkkE9pAlsRexPTWC6FTHlHmqCvp0RW0Ns7VE8aY=;
        b=Dp/65mL4tbkmhBMlRvDSQhNBLqzB9LBa5y5Pv80RM6CtJwLSmIRNxXfeOm9OpQhpPM
         o0CGpr/3/KMVFiJTU+iURVFShHBfiDIrw2+6Jc/0sGqQBW0uLJ7yOVI2s0rCGkj07vBG
         sORhUWh17I9VOA1CKzkgrCO8mCXloHyaS/Yf0TL2qW2nn/7TUJP17Jydbcco8qldcfQb
         6tKmcjwg/ZmLKh5pVz4NL7cyMMhxCHFCtZI+y1qwZGIGlsBDFNRSKzP5YpSJn8V2pXG4
         mEfvaXBIZtQiOsM4lsQGwhZPQODHkOOHK23sQ7M+0lYR7v+vTai4YgwRNT3uHTdtIEN/
         ooBQ==
X-Gm-Message-State: AOAM5331PvcRRjhEEizqeVbEJBUOwRpAhobzMl4sBfpYMo902DcnRzzl
        GG9FkBvOGP9qwgLuyvmKL6I=
X-Google-Smtp-Source: ABdhPJyXN0mo7HEU6FOR9uI6Ug+pjDqXR35Q5tSXIuNx5uebdfNOLmGbKI/4ct6meuiTVI77h9h3lA==
X-Received: by 2002:a37:9a93:: with SMTP id c141mr2943309qke.145.1597937026596;
        Thu, 20 Aug 2020 08:23:46 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id n4sm3241448qtr.73.2020.08.20.08.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 08:23:46 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] selinux: Create new booleans and class dirs out of
 tree
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
 <20200819195935.1720168-5-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <5a97749a-bc84-785a-4b06-7dc6c2597175@gmail.com>
Date:   Thu, 20 Aug 2020 11:23:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819195935.1720168-5-dburgener@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/20 3:59 PM, Daniel Burgener wrote:

> In order to avoid concurrency issues around selinuxfs resource availability
> during policy load, we first create new directories out of tree for
> reloaded resources, then swap them in, and finally delete the old versions.
>
> This fix focuses on concurrency in each of the two subtrees swapped, and
> not concurrency between the trees.  This means that it is still possible
> that subsequent reads to eg the booleans directory and the class directory
> during a policy load could see the old state for one and the new for the other.
> The problem of ensuring that policy loads are fully atomic from the perspective
> of userspace is larger than what is dealt with here.  This commit focuses on
> ensuring that the directories contents always match either the new or the old
> policy state from the perspective of userspace.
>
> In the previous implementation, on policy load /sys/fs/selinux is updated
> by deleting the previous contents of
> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
> that there is a period of time when the contents of these directories do not
> exist which can cause race conditions as userspace relies on them for
> information about the policy.  In addition, it means that error recovery in
> the event of failure is challenging.
>
> In order to demonstrate the race condition that this series fixes, you
> can use the following commands:
>
> while true; do cat /sys/fs/selinux/class/service/perms/status
>> /dev/null; done &
> while true; do load_policy; done;
>
> In the existing code, this will display errors fairly often as the class
> lookup fails.  (In normal operation from systemd, this would result in a
> permission check which would be allowed or denied based on policy settings
> around unknown object classes.) After applying this patch series you
> should expect to no longer see such error messages.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

