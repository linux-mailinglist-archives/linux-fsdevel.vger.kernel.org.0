Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B409C35A33F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhDIQ1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDIQ1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:27:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B88C061760;
        Fri,  9 Apr 2021 09:26:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so5045461wmy.5;
        Fri, 09 Apr 2021 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Phuwohh2HbCcjFvp4UIIQp3Pa48Fgzncr9mTT74dDuc=;
        b=OrDC9KNIV2KoycO1UJbjgt3dS7Zq2KuRnckwcv/US0NFH4y5p75lCVm23WaG0rVojv
         HeCavVxA+Ac3nwNniNDRjJlmFDlnmdgTPgutRu8juSbyZercO77k+ZH4K/xP8mSbGVW1
         G++R4TWtflixrhcsAfXommXjVB6yQiFu5TxHopFnit0aQNYVGcJrLop+n3PsSErczidr
         y/BmGlelv/wJ2dwQIZ2BoB9crvw7/JOCylrmSKctjliDydy1Zqwnxq9epeI68cv8qBo7
         aVl4QC/KAnohy1n6qqYkh6J0d4Hco/WOB13ML9dE/SxBO3Wsvj7W0s+HSYU6g8xU0NgX
         fkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Phuwohh2HbCcjFvp4UIIQp3Pa48Fgzncr9mTT74dDuc=;
        b=fL1l5XONfIzbAb70Vh+472VsFdLwObfk0tfGwWG4JXtZzxVqrc1JORfM/zGCe375JT
         i/5YdfiW/S/niWnd8EPH/BY7BeateYeHwWjspqebt60JMiFEoyiFbpbT5jFWOJTN+T4m
         KxItQo/DZ51NgupBlb9UZOYLw5feItjEKR6xgdVso3+PRZMA0QWLjst9jBZxhulTqP3V
         9Z1YyixImJtO8z6h30iJQgAxIQjZX246e8mRthzjccjt+Ct/+LUgbwO+xP70Q+O40Fnb
         ulZFTluPU6uz6c1BFnOMb+sClueWpOoo3qQ4j8QqJZdf7ouNmn6AbBudNTQpHc0s+LGD
         yr7Q==
X-Gm-Message-State: AOAM532CuHT204bIpRl8FESUb09gdCo6s1h7AX9k4XCo5MBrMb20DRVk
        6tYS8p8soOjRvSqGjQQaLu0=
X-Google-Smtp-Source: ABdhPJwEELsjjLV+hBsfJiej4imi1ND7VZLuZxQpk+R/tkx/cwIMM3GphnH/4bn5zw34pvgfQlwTVg==
X-Received: by 2002:a1c:9853:: with SMTP id a80mr14414819wme.44.1617985611974;
        Fri, 09 Apr 2021 09:26:51 -0700 (PDT)
Received: from ?IPv6:2001:a61:3552:9e01:f394:4bd9:fa87:7527? ([2001:a61:3552:9e01:f394:4bd9:fa87:7527])
        by smtp.gmail.com with ESMTPSA id a7sm5648045wrn.50.2021.04.09.09.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 09:26:51 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     mic@digikod.net
Cc:     akpm@linux-foundation.org, arnd@arndb.de, casey@schaufler-ca.com,
        christian.brauner@ubuntu.com, christian@python.org, corbet@lwn.net,
        cyphar@cyphar.com, deven.desai@linux.microsoft.com,
        dvyukov@google.com, ebiggers@kernel.org, ericchiang@google.com,
        fweimer@redhat.com, geert@linux-m68k.org, jack@suse.cz,
        jannh@google.com, jmorris@namei.org, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@kernel.org,
        madvenka@linux.microsoft.com, mjg59@google.com,
        mszeredi@redhat.com, mtk.manpages@gmail.com,
        nramas@linux.microsoft.com, philippe.trebuchet@ssi.gouv.fr,
        scottsh@microsoft.com, sean.j.christopherson@intel.com,
        sgrubb@redhat.com, shuah@kernel.org, steve.dower@python.org,
        thibaut.sautereau@clip-os.org, vincent.strubel@ssi.gouv.fr,
        viro@zeniv.linux.org.uk, willy@infradead.org, zohar@linux.ibm.com
References: <20201203173118.379271-1-mic@digikod.net>
Subject: Re: [PATCH v12 0/3] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <d3b0da18-d0f6-3f72-d3ab-6cf19acae6eb@gmail.com>
Date:   Fri, 9 Apr 2021 18:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20201203173118.379271-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

As a user of SELinux I'm quite interested in the trusted_for / O_MAYEXEC changes in the kernel and userspace.
However the last activity on this patch seems to be this email from 2020-12-03 with no replies, so what is the status of this patchset or is there something that I'm missing ?

https://patchwork.kernel.org/project/linux-security-module/list/?series=395617

https://lore.kernel.org/linux-security-module/20201203173118.379271-1-mic@digikod.net/


