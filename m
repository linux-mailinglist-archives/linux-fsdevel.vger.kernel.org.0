Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518BD3D9317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhG1QXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhG1QXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:23:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D9C061757;
        Wed, 28 Jul 2021 09:23:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qk33so5458982ejc.12;
        Wed, 28 Jul 2021 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:reply-to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=og7+V4BOs6plr/YGVQnX+404P8F5uFz/ISDuajxswv0=;
        b=SC0VdSX/F/sOPmI3Q7YmCzFCdl4xqt7oa+7hod2kYnKT61yxCqweHv52cjGPgqMYEG
         RcPLe47wvzr7VYoKT0BGePbN79leHnWxbtRqQ7SKjcaTKl9BuAZx6RsKhqc99DIh3vuI
         l2/CRbRa3VMSZkHa2tgDqgSMSbMkjIt57ZAJuHIgeQwo9HNbQ3S6fqblouQ4te9ygmjJ
         3scrhJkQFszM3oHw43uBp3Qye3qkEYtDqX7rGW5YbiSXNMVz7Flq1mNtL79NkljqGdwb
         8VAeU8fx0K61LtprexwTE1B2wj7TdRm905zA3cETTZR2GVdr1VcfcQYr81iI2gk3bdqW
         X11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:reply-to:from:subject:cc:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=og7+V4BOs6plr/YGVQnX+404P8F5uFz/ISDuajxswv0=;
        b=ZwH2PsLj68jstp5rg5TWhSzGZ5fUNnzC7ukg/WuFUlGwtLd1+Mfu0F4gGhzJrEt+wM
         ipjXPQtneVCQeNqhJFpS0HRSx1N4DuNXr82wic7fBEBN6hx1ljR8Guibmkqvr6/HfVxP
         D/e+CngkVXW2M8+BZbN4r1CgmsmWuZUsR/3pRtDlFSGbOydPmihQhsYMS2IK0/Cmbg1c
         vN9AuEv+u6Rf72VEb6mZXATOit8PpLb9TWwCem1mt0nxH4PDPN7thPW33xquG/Ohm7eN
         oh9Pz9Fwz9HT6x/c40q/lhI7ipT4M+kBQvg8AQbPE6qukSTtqMG029JJqlNfZ5EB8nEl
         duWQ==
X-Gm-Message-State: AOAM5338Ef1iB1NeqCjE3iyNYdZlNROKpATLz4hGwnJ/cbuDMVvWj1nc
        In+wDv2rgO9KWavcKUADW9o=
X-Google-Smtp-Source: ABdhPJwN0gRL2jyJMYaqSosjMJgABzLSD6PtiDIEUqOq98x3mvzvPq+nXwfkMdfkmV81p3SfW/Xj7g==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr280384ejn.57.1627489420927;
        Wed, 28 Jul 2021 09:23:40 -0700 (PDT)
Received: from [192.168.0.114] ([37.239.218.3])
        by smtp.gmail.com with ESMTPSA id n13sm69223ejk.97.2021.07.28.09.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:23:40 -0700 (PDT)
To:     yanp.bugz@gmail.com
Reply-To: cc64ac69-f4e5-3fc4-1362-ced7cf68119a@gmail.com
From:   Mohammad Rasim <mohammad.rasim96@gmail.com>
Subject: Re: [PATCH v26 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Cc:     aaptel@suse.com, almaz.alexandrovich@paragon-software.com,
        andy.lavr@gmail.com, anton@tuxera.com, dan.carpenter@oracle.com,
        dsterba@suse.cz, ebiggers@kernel.org, hch@lst.de, joe@perches.com,
        kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        mark@harmstone.com, nborisov@suse.com, oleksandr@natalenko.name,
        pali@kernel.org, rdunlap@infradead.org, viro@zeniv.linux.org.uk,
        willy@infradead.org
Message-ID: <2f310e28-49fe-3206-40d9-0c8a729f9227@gmail.com>
Date:   Wed, 28 Jul 2021 19:23:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been using your ntfs driver for sometime now and it's great to 
finally have a good driver for this FS, however i have problem where if 
the power cuts off from my system while writing to the volume the 
partition gets corrupted, this is expected of course but the problem is 
that `ntfsfix` tool can't fix the partition and no matter how many times 
i run it the system will always spits this in the kernel log when trying 
to mount the partition:

     ntfs3: sdb1: volume is dirty and "force" flag is not set!

if i boot to a windows 10 OS then the system is able to mount the volume 
with no problem(even before running chkdsk on it), windows `chkdsk` 
utility can find the errors and fix them, and i can reboot to linux to 
use my partition again with no problem.

it would be nice to have your filesystem utilites published on github so 
we can use them with the current out of the tree driver


Regards

