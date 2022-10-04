Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8F5F3B28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 04:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJDCLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 22:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDCLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:11:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E552357CF;
        Mon,  3 Oct 2022 19:11:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso5538065pjf.2;
        Mon, 03 Oct 2022 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAROThNcWLnchnrLH4CyMrTplboQNIWUIFT7LC3TKeE=;
        b=AsRFD6xCjFySWU4q02CskBZMpcifUhFdcO/FIDmtO5EDM+UQfnMGtnfiYcnENKDW+j
         8DElltF0i1zc3fOYg4Q7qPy0QkbFFYilxolECrC+ogRaqov69dYMjqfIXqojlMUz9uCm
         BBuVjbonsyz9mwkXSnfEJm18ZqfsJlgUJPsYiH6+ORJV06+3Q3/0SuxYwNQ86n5UrcpO
         TRwI6pFV4Gf7OP5vdkNA6cIPSe03j7iTgdqHIxk7aCeBzIIRO7LQOcSBn/ISc4hxQrg3
         poyFbBomOX506L3UX4hc2vSi1azQwf3QWtkWXQaRn7R5axYPa00OVBckjGdLkvGlZRWx
         7mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAROThNcWLnchnrLH4CyMrTplboQNIWUIFT7LC3TKeE=;
        b=EzrIEyMg115EZQIANbdEE0zWE2Ebqg1yqmbWAEKRrRlbbfBPmBGbBZZaX6r6kWb3FF
         eG1KSDrQ8cEAFFzwJN+HdZul4+XdU2EuMbymL+MYAxTOHSaMY0qe1jjiR6FPuIdLdK98
         IUrLzUOGLs6zJ6dddX9wqM8cGspecEgIkVNXxDefx8ZBiRtoRTuBjE7tfaZU8lzZk9eI
         Z3CZAdQ6SLvNRxdjKEJypIkI4TW8PBjkwc/Gi8JJevb4COaVEDE/btKzz22UOyedzTz7
         5po1L9prhQ0YhCNkwkZcvlDHZFcbFtd4cifspZIlWpZS5lJXDedCghwIZDbg3KmPfg6U
         gV3w==
X-Gm-Message-State: ACrzQf1d6pLcmzekrStAqYsHLe7wjA2y2ctIIPNoFFBqXfDZwZfsnP3q
        wsMvLkL9llMd3Eb9m6f0SHY=
X-Google-Smtp-Source: AMsMyM7/5G4+4c4GiEU4VK2eK11jIaW9VALQv2+qZIEVPvm6ICVAVbvVZZfcu6D37uM2WVkMhh9Byg==
X-Received: by 2002:a17:902:d506:b0:178:3599:5e12 with SMTP id b6-20020a170902d50600b0017835995e12mr24668471plg.70.1664849475473;
        Mon, 03 Oct 2022 19:11:15 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b00176b0dec886sm7963088plf.58.2022.10.03.19.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 19:11:14 -0700 (PDT)
Message-ID: <d2089a89-21a9-1e05-5d58-91b8411f7141@gmail.com>
Date:   Tue, 4 Oct 2022 09:11:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC UKL 10/10] Kconfig: Add config option for enabling and
 sample for testing UKL
Content-Language: en-US
To:     Ali Raza <aliraza@bu.edu>, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-11-aliraza@bu.edu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221003222133.20948-11-aliraza@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 05:21, Ali Raza wrote:
> Add the KConfig file that will enable building UKL. Documentation
> introduces the technical details for how UKL works and the motivations
> behind why it is useful. Sample provides a simple program that still uses
> the standard system call interface, but does not require a modified C
> library.
> 
<snipped>
>  Documentation/index.rst   |   1 +
>  Documentation/ukl/ukl.rst | 104 ++++++++++++++++++++++++++++++++++++++
>  Kconfig                   |   2 +
>  kernel/Kconfig.ukl        |  41 +++++++++++++++
>  samples/ukl/Makefile      |  16 ++++++
>  samples/ukl/README        |  17 +++++++
>  samples/ukl/syscall.S     |  28 ++++++++++
>  samples/ukl/tcp_server.c  |  99 ++++++++++++++++++++++++++++++++++++
>  8 files changed, 308 insertions(+)
>  create mode 100644 Documentation/ukl/ukl.rst
>  create mode 100644 kernel/Kconfig.ukl
>  create mode 100644 samples/ukl/Makefile
>  create mode 100644 samples/ukl/README
>  create mode 100644 samples/ukl/syscall.S
>  create mode 100644 samples/ukl/tcp_server.c

Shouldn't the documentation be split into its own patch?

-- 
An old man doll... just what I always wanted! - Clara
