Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E803631AA6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhBMIDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Feb 2021 03:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBMIDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:03:35 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD745C061574;
        Sat, 13 Feb 2021 00:02:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o24so1949967wmh.5;
        Sat, 13 Feb 2021 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yyp+y9Geh6y7VihBORGFLHg6VK+WxHg8pG5vAEZAaOY=;
        b=VmAKJ186zM6R5riMCgIz0iKIKcC2Fz4rEX6Ubx4T5r2KP4Ng4xX22FOJWIBMYIufNJ
         9jNQ4hWgGr79dsIJym4QsWWS6BegAtU4Z1/astLZNG1dUsz+cyXboYHA/QAkOyPQvkr5
         UaeBktlu1lEEuV6Bi4bLWCatYNbIWAN6JCrU2w+adfH03B+REnhtLyntYjisdrnkJbQ2
         5GPiko9ePnmLTDcx2AVPkJoOoSpEZ9fkSQ42Yyx9JAknbaONqvZjL2HD7nxhAk/gPisT
         DXueLSM86Pv9BkfD06ciBURHmSDrI+DY4KuazF0UWvGdcYTkmevruLX9GNToTr/O9lus
         EUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yyp+y9Geh6y7VihBORGFLHg6VK+WxHg8pG5vAEZAaOY=;
        b=KcH6Sn3P2EOGX1jFObjHAwm2UKMxUnSh8nB/mnlyRQoJ3cmtcfe1l9VI/QMPDwVwiS
         12pCwtOKzc0cpLimPZvm6X2pjPV0biI9aK8ve/8awSff5ha0ngxZorP0+MnMSU4cNOtK
         5osZJCwOutnewo9gG+Z75PC2QK1js7+6DJW+OVgXxGsZ4GxB8N05IC1hQtNOk1zqeTuk
         jNCRp+zpImfPDxobn6IOUVeEeyAxOARbgLzxHqJU9BEOzt2eQ7ZNr6HQhpzZf3zm6O/G
         FCxPimKWiE4AVzKL9gJkt+nJRNAHmjRKjO52c+CsLzrcKR0Nl4bEspTLA4NGtIhtmKVp
         a4jA==
X-Gm-Message-State: AOAM533qeBBwamwKujnaHxyzeHksGXmwJYXrNnDx9CSg3k7KrV8L+Mq5
        20umiJBfJiAVMe5CxtEiqg==
X-Google-Smtp-Source: ABdhPJxesJU/HalNUHisRA291nahkmqp3k8dhup5ZXv1r6v4bJQZ1Q8YTD+6hvcLDOLHDHBgV7+DhQ==
X-Received: by 2002:a1c:48c4:: with SMTP id v187mr5513347wma.145.1613203372145;
        Sat, 13 Feb 2021 00:02:52 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.168])
        by smtp.gmail.com with ESMTPSA id w2sm19327138wmg.27.2021.02.13.00.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 00:02:51 -0800 (PST)
Date:   Sat, 13 Feb 2021 11:02:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
Message-ID: <YCeHqqQIBrdJd/2C@localhost.localdomain>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
 <m1im6x0wtv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m1im6x0wtv.fsf@fess.ebiederm.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:01:48PM -0600, Eric W. Biederman wrote:
> Joe Perches <joe@perches.com> writes:
> 
> > Convert S_<FOO> permissions to the more readable octal.

> Something like that should be able to address the readability while
> still using symbolic constants.

Macros are easy. I've sent a patch long time ago which does essentially

	#define rwxrwxrwx 0777
		...

But then kernel will start using something nobode else does.

This whole issue is like sizeof(*ptr) vs sizeof(sizeof(struct S)).
No preferred way overall with ever vigilant checkpatch.pl guarding
kernel 24/7. :-)
