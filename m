Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5753A2495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJGjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 02:39:31 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:46781 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJGja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:39:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso3174652pjb.5;
        Wed, 09 Jun 2021 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z96H5wC0kNJ/kft8S+uNeMa48EWE9xHJtYV30xc9WPI=;
        b=e9J1BfY5syEbre1p7xgfzIdkF4QF66rDYPYrhQRLN0FTGVSOcOs3xnOCYHmtAx9Lpa
         ty2OlM8PEIgMxGhBckd7vjhrA2dun6WdlmR5n4IcfSVugg7ZAladRp5FdyE0oYxia68x
         Fybi0XRSauhkp5LG6MEtDYuFrsh0v6nKebQUV8oc0g7zKTvDV6zivZWWl57DLuxTBCRk
         wL5ePDwPDSR/KAzzw/wRPV6+9pM1A7bMSt7QLR0gfFpdxWAuTsD+9MbcV1wvKRbYWWJk
         5W7vdnLdo/sAAW9B0O9lBPsf4B0DrrSrZtikTwSWpkkBX0UOwcPCogGBk2QnL458EyFl
         PpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z96H5wC0kNJ/kft8S+uNeMa48EWE9xHJtYV30xc9WPI=;
        b=gelrpsSY+06GGvZKIr7gtCMUgLRky6EwNd8ULpBFaixmMltlys7oYKG+NNoPnYQ550
         sELGhge2rwbREscT+3Bg8hHFRNycRPOba/7clBsiGSbLS/rjJllN+N3Wn9Pv4A6maPCr
         wAqfzf4F++4J/dOtOHA1gozh5YnB3aqvDxvqi/+IVPfVszR8jnBEayRllVFpfXfC5raI
         HQoX7MABHALrF9LDHpBrYWZUHWm9tocGFafNbepJXX27T3OY6Ab4QtTT4jQ7vaDxzYd1
         vCtEziEOh0vHIlf8MoxS608uGr8XUJAxSpTB6vIiZDLSlxwxksNJ96qLID+W8wLei/c5
         Pckw==
X-Gm-Message-State: AOAM533y+sBTAcSnN4t5VT7umcflDSqOy4Q3ANcERmV6eq8yagSGfIfz
        zYJmBrAYR6gabo5IA78CKEA=
X-Google-Smtp-Source: ABdhPJynS4JYYCRm7+68gefxhx1c3BbgTQHXaxy0u0Y+D8R6G+ouzPkH6k2R0qXUxOPKchccSjvDHA==
X-Received: by 2002:a17:90b:901:: with SMTP id bo1mr1805221pjb.0.1623306994254;
        Wed, 09 Jun 2021 23:36:34 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id k25sm1335478pfk.33.2021.06.09.23.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:36:33 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:36:21 -0700
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, dong.menglong@zte.com.cn, jack@suse.cz,
        hare@suse.de, axboe@kernel.dk, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        brho@google.com, f.fainelli@gmail.com, palmerdabbelt@google.com,
        wangkefeng.wang@huawei.com, rostedt@goodmis.org, vbabka@suse.cz,
        glider@google.com, pmladek@suse.com, johannes.berg@intel.com,
        ebiederm@xmission.com, jojing64@gmail.com, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, mingo@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: Re: [PATCH v6 0/2] init/initramfs.c: make initramfs support
 pivot_root
Message-ID: <20210610063621.GA83644@www>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210609230312.54f3f0ba9bb2ce93b9f5c4a3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609230312.54f3f0ba9bb2ce93b9f5c4a3@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:03:12PM +0900, Masami Hiramatsu wrote:
> On Sat,  5 Jun 2021 11:44:45 +0800
> menglong8.dong@gmail.com wrote:
> 
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> > 
> > As Luis Chamberlain suggested, I split the patch:
> > [init/initramfs.c: make initramfs support pivot_root]
> > (https://lore.kernel.org/linux-fsdevel/20210520154244.20209-1-dong.menglong@zte.com.cn/)
> > into three.
> > 
> > The goal of the series patches is to make pivot_root() support initramfs.
> > 
> > In the first patch, I introduce the function ramdisk_exec_exist(), which
> > is used to check the exist of 'ramdisk_execute_command' in LOOKUP_DOWN
> > lookup mode.
> > 
> > In the second patch, I create a second mount, which is called
> > 'user root', and make it become the root. Therefore, the root has a
> > parent mount, and it can be umounted or pivot_root.
> > 
> > In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
> > directly any more, and it make no sense to switch it between ramfs and
> > tmpfs, just fix it with ramfs to simplify the code.
> 
> Hi,
> 
> I have tested this series on qemu with shell script container on initramfs.
> It works for me!
> 
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you,
> 

Ok, thank you :/

Menglong Dong
