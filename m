Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23924F7B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFVSCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jun 2019 14:02:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44136 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVSCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:02:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so9553398wrl.11;
        Sat, 22 Jun 2019 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=MvdVlfsCZCzoiO3dWaS7svRVtEzJywqCcVUPGHCcDEY=;
        b=sRilaimFeaePIYvUwtlO1PJMAd7GYlH/2BTb3QuVFlcXeebELLDg49wv+7OV/8s353
         2ix06k0Vj/SkuFx5HkmQ2iu4KpaVsy0yRQGztD4WrEVP5IENxBnKBn1yAQikMz/IY1gW
         rz3EM5F7XA4NuzDE6aXSWaQ1VjRY/ipjHzBI6GleCLN8LLYpmIow2dZkBY2fK9X2yoWF
         PdvH8NNebh274GufOsmCvHqDn5dU/BBti+LvvxujmK5TIX92VIDaIu3BRWtf2a0JUJx5
         cXoykUUfB7HRzYXUkArpvOEt5GZsQijFbXFNB6Nf+yl6ppbcfsgTgiFkpWF3JQXkfk2n
         402Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=MvdVlfsCZCzoiO3dWaS7svRVtEzJywqCcVUPGHCcDEY=;
        b=PzhWnwJDBfjem/oOpqjheusToiCgQ+d63onyFijfQppw5hzjbekv7jh0UpvdshVD1Q
         b/hst7HMdWqCQAcUhbdj+NaqcHSrAWm6x1i2PECzvX8RxnnT0SkVo4Fcly7gfMuLhbFx
         jzSKgc6d+11brDBc+FH5dnUE18ntOFodeCxvCTGOrriCrLHqStAhmUFpHQMMk72OPcwT
         VceD3YzUs5wZ0gMttfE3zP7afVjiRbPEgvX95HWmGgqgG6eyeqZPwgOJprJOMfozAMoI
         wRo2F5C589hv3ciiHkCEpxkFEHQy8v58twf+kpL7LKjxja9p7SmHoz/Xbrm/Ky4TU22x
         ASQA==
X-Gm-Message-State: APjAAAWaAlFlYhqn5gMqwN9jQGuW2pQDX9hNTSsv4D5DXHA5tzcKNj+u
        AqvkRA81NiCNy2ntxRTcbSESHdVPNvRMGA==
X-Google-Smtp-Source: APXvYqyndRWSOXsFEF0LcRNbc+VXO2mtyNTfcHVkaia8QxZAkUMLjqJhHL7pGbiMghjIHQMBNiYgHg==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr8603119wrc.95.1561226542020;
        Sat, 22 Jun 2019 11:02:22 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id q15sm4621055wrr.19.2019.06.22.11.02.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 11:02:20 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Sat, 22 Jun 2019 20:02:19 +0200
MIME-Version: 1.0
Message-ID: <cd84de0e-909e-4117-a20a-6cde42079267@gmail.com>
In-Reply-To: <20190619170940.GG17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
 <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
 <20190619170940.GG17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,
i think have a hint of what is going on.
With the last kernel built with your sentinels at hlist_bl_*lock
it is very easy to reproduce the issue.
In fact it is so unstable that i had to connect a serial port
in order to save the kernel trace.
Unfortunately all the traces are at different addresses and
your sentinel did not trigger.

Now i am writing this email from that same buggy kernel, which is
v5.2-rc5-224-gbed3c0d84e7e.

The difference is that I changed the bootloader.
Before was booting 5.1.12 and kexec into this one.
Now booting from u-boot into this one.
I will continue booting with u-boot for some time to be sure it is
stable and confirm this is the cause.

In case it is, who is the most probable offender?
the kernel before kexec or the kernel after?

The original report was sent to you because you appeared as the maintainer
of fs/dcache.c, which appeared on the trace. Should this be redirected
somewhere else now?

Regards,
  Vicen=C3=A7.

On Wednesday, June 19, 2019 7:09:40 PM CEST, Al Viro wrote:
> On Wed, Jun 19, 2019 at 06:51:51PM +0200, Vicente Bergas wrote:
>
>>> What's your config, BTW?  SMP and DEBUG_SPINLOCK, specifically...
>>=20
>> Hi Al,
>> here it is:
>> https://paste.debian.net/1088517
>
> Aha...  So LIST_BL_LOCKMASK is 1 there (same as on distro builds)...
>
> Hell knows - how about
> static inline void hlist_bl_lock(struct hlist_bl_head *b)
> {
> =09BUG_ON(((u32)READ_ONCE(*b)&~LIST_BL_LOCKMASK) =3D=3D 0x01000000);
>         bit_spin_lock(0, (unsigned long *)b);
> }
>
> and
>
> static inline void hlist_bl_unlock(struct hlist_bl_head *b)
> {
>         __bit_spin_unlock(0, (unsigned long *)b);
> =09BUG_ON(((u32)READ_ONCE(*b)&~LIST_BL_LOCKMASK) =3D=3D 0x01000000);
> }
>
> to see if we can narrow down where that happens?

