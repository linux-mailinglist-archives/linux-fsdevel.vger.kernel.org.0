Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A8610C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJ1I6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 04:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ1I6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:58:20 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43F19C05E;
        Fri, 28 Oct 2022 01:58:19 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id p4so4480385vsa.11;
        Fri, 28 Oct 2022 01:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x7MKpIufpLcL39tQ6/GD/80oOXBjR+2MPM2htBRFC1c=;
        b=IPRj1BpIxM5HppTptt3vyghRZ/7kjubfGTSaRZPi52dVMfGh5mhCSYbT+UrCEle1zs
         /81PaEko/bNlAQi7wqGxyMQxZI/vQtE/aypQCsNjUtqbPIg2pIu/uks2F/FfVV+A2yr/
         J6eapR1t3rIP0EQFU6gX08nfqU/KrWIUAGEOhF9A473wDRN3KQxlh1/3Qk13L/YhxsKG
         zF55QLAhfLZ1qt1cvqxnU2RRe9RBQnsJ9iQTZenceFN5DYdApBk/vmkAHVpCgZikMjWT
         XCYP1jqiPeMEJL5VIW7rlOjsikSw3s5rNbarb8RJzOR71r0Yr21yoK3SA5o3x4jSh7C4
         4stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7MKpIufpLcL39tQ6/GD/80oOXBjR+2MPM2htBRFC1c=;
        b=G+L34XOcjv8Qc+enwV/AeEiaHTH5vCHCh/2YL9Ry6hGPRPo6jk3kPgiYQrLdEQDi1i
         YYJQEXp+4lwIp27f50plM8/3Q42/jznzUHoiGYunsWGs98fhukRktN4gz3lo9GkFO70w
         wCBriuyFtM1C+KLDmZrUHQB10zr1aVVCY6dcU7LvrTdVX9Dz2s6TpDafsPLiJAFyR8TB
         IGnKpLf74rQ/NpY4vjs/DTACUjMMHQ4rkJEOCZ86gGDeFJnCY1uVfuQ79hFydhxE5wzm
         qdXcxnAfkuSil2MshAcXp6Lt5o/4qIvxlZHITZ7OIRyHOSG3ygfe8EmG2AitgbkdI7+X
         oefw==
X-Gm-Message-State: ACrzQf3A+PkZx454mMOpDP+aR43gpawLelScp52nSvCU9yAdhuQ34I2/
        KbQU4LWtZIdb7rLCSMGeWBbiewT5a9nAmbC6KJ0=
X-Google-Smtp-Source: AMsMyM5Jlod8DkZkJEONA8WSngasWeiCJF0+L27dIppZY11+fv5GDh8jdeFXNXYZvH7krUwioqOqxBCOl35IsMIFvmc=
X-Received: by 2002:a67:a24e:0:b0:3a5:38a0:b610 with SMTP id
 t14-20020a67a24e000000b003a538a0b610mr29257436vsh.2.1666947498265; Fri, 28
 Oct 2022 01:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com> <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
 <87edv44rll.fsf@oracle.com> <CAOQ4uxhwFGddgJP5xPYDysoa4GFPYu6Bj7rgHVXTEuZk+QKYQQ@mail.gmail.com>
 <87czachqfb.fsf@oracle.com>
In-Reply-To: <87czachqfb.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Oct 2022 11:58:06 +0300
Message-ID: <CAOQ4uxgiFf_zpuaj2cXy3jM7omsfW3aOfHEwnSHFLi7y-BQEJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> Well I feel stupid. The reason behind this seems to be... that
> d_find_any_alias() returns a reference to the dentry, and I promptly
> leaked that. I'll have it fixed in v3 which I'm going through testing
> now.
>

I reckon if you ran the LTP fsnotify tests you would have seen this
warning a lot more instead of just one random pseudo filesystem
that some process is probably setting a watch on...

You should run the existing LTP test to check for regressions.
The fanotify/inotify test cases in LTP are easy to run, for example:
run make in testcases/kernel/syscalls/fanotify and execute individual
./fanotify* executable.

If you point me to a branch, I can run the tests until you get
your LTP setup ready.

Thanks,
Amir.
