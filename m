Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52114340FC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 22:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCRV2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhCRV1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:27:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF62C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 14:27:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso3782062pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbJ4tu0h2vfoq5iEJyv9eBMmHHIseIpXprgJl8iJhoU=;
        b=hrxzCDgYaqrTpyC7RhpNufMokxP+WsITJYO5fQlSQA5Jp5rA4ymV6vYAHVpLuz1ZFK
         cyEaJxDUeU3I0W9Mly7jHqjk9uOizXul73LUJLaPDx2FbvSVs8qA0KWKFVMv7N0kklfn
         GoAXJtReybfqlKwh5myjGv+CNEq7s2he7RIszIY83DkPi9wkKG6gBAmXWEQbk6cDOYZK
         TMUiiZZeKoK1qmSYuUxT2dGBLTbuFTEbQDzOf8U8PSoor7WBQT31WfitypyWeSGKjclA
         VSLnyLpOQuH9MkI0zPMc6z3jRNGlHJzG7XIXITFtj8I4wLz2Bl79M0CVXVGqqXf33ISB
         CoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbJ4tu0h2vfoq5iEJyv9eBMmHHIseIpXprgJl8iJhoU=;
        b=KfJxlvo61hQpYCOH2APgGMsR/sK1xwGzzo8RMzy92eN6lhA/S03UEICBPy57DCBnBt
         Q/UHSJAakrQ0Y1CXt3Z3op+bXYfDcLEViHaAkAsW+119sFwmaBAs24khLSwvPcvESJuT
         TbNgMr53sbL+CbXnUqoN3XKazzmYSPOgDAvfhvC5srlvqlveue6HFcm3EFxwaVS22x2t
         GFCrEWesbJbvlF5LoNZxvpMPuhpnKtWYYuhH1fWyTZ4OVWBQR3SGRiLVxRo5Rex7IPM/
         06a6VogrPEUGIAEwJGAby+FqBBcRhk7yFHF7GD0RJVpULfTen5u1f1QfzkzHewNtArWR
         iTgg==
X-Gm-Message-State: AOAM5332elkTDpgiM218AS9lDauhkbZjfShhVcoSjaL60NakWqa655wR
        xnudbBJNlnQpEWBSKkxx/U4QoYbFwjd1ECS9BFQkSQ==
X-Google-Smtp-Source: ABdhPJy9j3X2ul9CXpfJuYjxYK4sS2lUaXNeTmcRcxjq10tEczdsEry9ruv+vRp/MwEQwcravOMjxZqh5cKYnjOe0oE=
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr6141115pjb.80.1616102854950;
 Thu, 18 Mar 2021 14:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210312095526.197739-1-johannes@sipsolutions.net> <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
In-Reply-To: <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Mar 2021 14:27:24 -0700
Message-ID: <CAFd5g47uR=HxjVET3uygeND8tFsZtfkgsS-PjMagbcagPMTBEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] um: split up CONFIG_GCOV
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 1:56 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> It's not always desirable to collect coverage data for the
> entire kernel, so split off CONFIG_GCOV_BASE. This option
> only enables linking with coverage options, and compiles a
> single file (reboot.c) with them as well to force gcov to
> be linked into the kernel binary. That way, modules also
> work.
>
> To use this new option properly, one needs to manually add
> '-fprofile-arcs -ftest-coverage' to the compiler options
> of some object(s) or subdir(s) to collect coverage data at
> the desired places.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Hey, thanks for doing this! I was looking into this a few weeks ago
and root caused part of the issue in GCC and in the kernel, but I did
not have a fix put together.

Anyway, most of the patches make sense to me, but I am not able to
apply this patch on torvalds/master. Do you mind sending a rebase so I
can test it?

Thanks!
