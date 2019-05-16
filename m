Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B04920D0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfEPQb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 12:31:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42145 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfEPQbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 12:31:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so6092452eda.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqJptEE9UZAQB57XWQVEM7jKvQBAFnzvaSb4s/mzn1A=;
        b=CJ0l6l2Mpk+PKRxV6CC3ospkNQL2odmgD/lDcxZ8Ypb4+nGaeq9AZr/uM46GoXb6lq
         7BBRq+kJs+zgScHkY2rvjTkKeeyp8fh/t+AkjcCB4GZJuSfyL/s78vEQTiXXDGPCyEaY
         JYHAmmPZRE66Ly/g5c+HyJluBcBMQK+MGawapqW6L56uRvBwQ5338afFoM4Lkbx4B7Py
         jqgMVoH/dMGK1buK2nvKcUKOpcnjuw36NM3DzNPC0ToKkzMVEZLGddSYdO0LBWydeGyh
         cpfT3sYt+Wm6BvWnOQfFobv+LSfoX9aFLPSgpBIh47MlcvdMoz1ZMlLtgHxOKzm2Yn+1
         7SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqJptEE9UZAQB57XWQVEM7jKvQBAFnzvaSb4s/mzn1A=;
        b=tiL4CoWVMzc3Z5Ca00llOivMqN2QXTMMMJemhQ4I2zP4ButMfqumll7vc/ESir2DZJ
         hpxAU8+aqjYJTpenUocYfWo9iV0xt+x5lv+NMAxWoQLQCz8FxqaD7ZEe+T2A4YkRQn9A
         ZCP3TEiC/Pfo9U4MmPajuOAMDiyaLJ2NVX5Ztoen14Z3WcizMbePId2hpRnLwNLjWDz3
         s36SpQxhbqL9WCCH5306JObNcwat4P7PWTU/NxA6ypE1mmu6LeMUldzI7oBFCkklV7Sk
         hcbKhli3WOjbLX5jW1p2xLeM5/MA52ZbZK3qsVyvyuJ2P/C4VnfUUCR9HYFAVi633LlK
         3e7w==
X-Gm-Message-State: APjAAAVWNFeJZkqBG7mwKtlr8xHV8vJX/egwd0yAq2Bh435kS3WghGaY
        WB+M0NuigcIz7Quo2xbEHC/62w==
X-Google-Smtp-Source: APXvYqzeTBYoUFYZ1O11TQ3R8+6lmBlsFm9sWwzA+jrLepI59sox5KlO8CBEDHOuAsVjIhkRs9x8PQ==
X-Received: by 2002:a50:e40f:: with SMTP id d15mr52428648edm.0.1558024313833;
        Thu, 16 May 2019 09:31:53 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id r20sm1141196ejj.4.2019.05.16.09.31.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 09:31:53 -0700 (PDT)
Date:   Thu, 16 May 2019 18:31:52 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
Message-ID: <20190516163151.urrmrueugockxtdy@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516162259.GB17978@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
> On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
> > 
> > Hi Linus, Al,
> > 
> > Here are some patches that make changes to the mount API UAPI and two of
> > them really need applying, before -rc1 - if they're going to be applied at
> > all.
> 
> I'm fine with 2--4, but I'm not convinced that cloexec-by-default crusade
> makes any sense.  Could somebody give coherent arguments in favour of
> abandoning the existing conventions?

So as I said in the commit message. From a userspace perspective it's
more of an issue if one accidently leaks an fd to a task during exec.

Also, most of the time one does not want to inherit an fd during an
exec. It is a hazzle to always have to specify an extra flag.

As Al pointed out to me open() semantics are not going anywhere. Sure,
no argument there at all.
But the idea of making fds cloexec by default is only targeted at fds
that come from separate syscalls. fsopen(), open_tree_clone(), etc. they
all return fds independent of open() so it's really easy to have them
cloexec by default without regressing anyone and we also remove the need
for a bunch of separate flags for each syscall to turn them into
cloexec-fds. I mean, those for syscalls came with 4 separate flags to be
able to specify that the returned fd should be made cloexec. The other
way around, cloexec by default, fcntl() to remove the cloexec bit is way
saner imho.

Christian
