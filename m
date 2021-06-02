Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658C0398F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhFBPwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFBPwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:52:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6F1C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 08:50:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so3549564wmq.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QtEpTHFvtzggN4P1k0hsNnVoWjVRPry/NFswHCPs2UM=;
        b=hFLLKLcW08wh4AyNyILNZ03SoR18vh8RNV7DCwZ0y5/0HYhJ+FppkpwaU+UmhBy8ey
         xEzUjIkxwcbRrH51MoyQLY80fK+VDJDtVi37daTcf6uWw0Q1D/voO7yEsRBt4qZL//ow
         SXRYXRA9wbzQ6mc0Q98Fj9n5KBF3+EslAVpTtJYwH64KsYXDe5FkQuqy4LxoUpbMFXRk
         Ee6oqThsFUjxUOlihtjxKQ7kx12sTx0oVIbpGxpApfHAxiUZoT2j87Crp1RdWlalqVvE
         8YAysRsBdkguTjQKW2IP3Rxnipi38DIWk24SANKTivUzFF+8VcpI36vLwe/Gv8Bj27d8
         YTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QtEpTHFvtzggN4P1k0hsNnVoWjVRPry/NFswHCPs2UM=;
        b=WaoYwAhKudOZkNPlevf+HS1j/OUH1mXL5y9c354m4CdCu9UgtBr2qib8PsoO3rM7qD
         ttPfBCkv8wyddlsWJgyRQb4F8eJhv0c/oCdzJx/lYxXwKLir5JfuQv1QK3k6Dh6jResY
         a7i3wTjh1/XH5viVzcURTP3TSD4xzRuwfiGzahW0KmTiYNOW2VCZKbRU8dAz76oLSu6a
         DsvutXAgLTTKK0tX2u9lHBPKyyEa3Hg34Sz9CzJyQ0QG021HIimnyBT1PoJ2YHRkF+yD
         RSU8P67tNyT9R1UtbQn2OcI5kCiBeV4C5tl+b1xtVGreuYI/UMiW30izYfQvrNHh4I+A
         CTuA==
X-Gm-Message-State: AOAM5338akw5hPPljJdbkAOkyhix2XsIaqDYY91VzKV41B0suAIgrNkD
        LkD9Ih8dSxT4zhcXvspbhNyc+g==
X-Google-Smtp-Source: ABdhPJyVWDPrVUxeC7SY7yjQOBdmqSY7OoOvkcyI/OlA3S06goyyAUZXvP47RlBmiBUQFTE2d8+eOQ==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id e23mr5900075wmh.186.1622649019512;
        Wed, 02 Jun 2021 08:50:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c7a8:950f:56b5:4064])
        by smtp.gmail.com with ESMTPSA id q5sm126351wmc.0.2021.06.02.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:50:19 -0700 (PDT)
Date:   Wed, 2 Jun 2021 16:50:17 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Peng Tao <tao.peng@linux.alibaba.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
Message-ID: <YLeoucLiMOSPwn4U@google.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:58:26PM +0800, Peng Tao wrote:
> Add a generic file store that userspace can save/restore any open file
> descriptor. These file descriptors can be managed by different
> applications not just the same user space application.
> 
> A possible use case is fuse fd passthrough being developed
> by Alessio Balsini [1] where underlying file system fd can be saved in
> this file store.
> 
> Another possible use case is user space application live upgrade and
> failover (upon panic etc.). Currently during userspace live upgrade and
> failover, open file descriptors usually have to be saved seprately in
> a different management process with AF_UNIX sendmsg.
> 
> But it causes chicken and egg problem and such management process needs
> to support live upgrade and failover as well. With a generic file store
> in the kernel, application live upgrade and failover no longer require such
> management process to hold reference for their open file descriptors.
> 
> This is an RFC to see if the approach makes sense to upstream and it can be
> tested with the following C programe.
> 
> Why FUSE?
> - Because we are trying to solve FUSE fd passthrough and FUSE daemon
>   live upgrade.
> 
> Why global IDR rather than per fuse connnection one?
> - Because for live upgrade new process, we don't have a valid fuse connection
>   in the first place.
> 
> Missing cleanup method in case user space messes up?
> - We can limit the number of saved FDs and hey it is RFC ;).
> 
> [1] https://lore.kernel.org/lkml/20210125153057.3623715-1-balsini@android.com/
> --------
> 
> [...]
> 


Hi Peng,

This is a cool feature indeed.

I guess we also want to ensure that restoring an FD can only be
performed by a trusted FUSE daemon, and not any other process attached
to /dev/fuse. Maybe adding some permission checks?

I also see that multiple restores can be done on the same FD, is that
intended? Shouldn't the IDR entry be removed once restored?

As far as I understand, the main use case is to be able to replace a
FUSE daemon with another, preserving the opened lower file system files.
How would user space handle the unmounting of the old FUSE file system
and mounting of the new one?
I wonder if something can be done with a pair of ioctls similar to
FUSE_DEV_IOC_CLONE to transfer the FUSE connection from the old to the
new FUSE daemon.  Maybe either the IDR or some other container to store
the files that are intended to be preserved can be put in fuse_conn
instead of keeping it global.

Does it make sense?

Thanks,
Alessio

