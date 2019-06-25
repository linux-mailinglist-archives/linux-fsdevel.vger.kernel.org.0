Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E120254CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfFYKsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:48:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46603 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFYKsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:48:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so17247011wrw.13;
        Tue, 25 Jun 2019 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=/YwqeNw4UunukhbJFUnuEIhTwSVj4RrsnNageK9oqjw=;
        b=qLdIAZqpTqrUGvpCnFSi/SGB6/kU+eTummvrFzgm3zXWwKHLvS87uy8CUabOnnleH2
         8SiMXa+PsY6j+K/ZQlEr8zInKfUPhWUL5fhElA5xIyNLw8q+eTJyuGFrP+oda/wAE2o/
         eYLszT9ez+GczPcwhOaSzkg10MHG1ExpqeQG//IiLlSfb4GVtC8U/t51GkuPdQ6bJCbt
         bNdTi9/4ZeFyEe4Lbsi3osTYGAt4aTv2/6Z5bnhTCEKioWkCycrV7+sl7sDnhwVZjOi6
         qJ4woBeYEB2mCu+JgobWlefcuWvfxsifstMJeqOAUQekDknf9o59iQoTAEI60CPIn4v8
         mL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=/YwqeNw4UunukhbJFUnuEIhTwSVj4RrsnNageK9oqjw=;
        b=LbP3sUF1Ez8wkBrHhVsxO6kF77HYCny2TrGgSj4SMA5Z9FxQf0sxOKLbvt241z15ji
         jUbBGmmENt1qoO6NcLswUzPIw98sqeBAJVPU2X9zIfPEnxUPwGEZ71wTxd6bWBHp6tPm
         vnebAlXEH857eLVEQKtTzbEnXgrqd6pgenEwFakreVjHBH3KpfQvI8DHhFeSxVyNB1pD
         yq/VjRk6L+amx+XUWDVO/tffWlxw44FYYYS9sdkIBCo4e2alp1+OrGFiogUFXvqFY7Ch
         gRbnv/kJnL4IWqaaJN4Dz7PRkyv5QvkWwT9DuQoXBtTb7G1JNAxuQ3pMRhrCL4MrSVSU
         EGqQ==
X-Gm-Message-State: APjAAAU9n6th0h0SN9kncMKcY8U7RzHMNNflEm0a1BPDQm0S35rNqcbp
        TqzLAqqOJ2c81U1K+VBw6Omm6Iqf39ofyQ==
X-Google-Smtp-Source: APXvYqzbsLqTnIBSznKPDtaHGmrBKP1M7k2HnizWsTquzdXflsk0JmtZkr3goY7PAUaqcOJ22+FWeQ==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr105019303wrv.164.1561459700098;
        Tue, 25 Jun 2019 03:48:20 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id w23sm2292976wmi.45.2019.06.25.03.48.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 03:48:19 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Will Deacon <will@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <marc.zyngier@arm.com>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Tue, 25 Jun 2019 12:48:17 +0200
MIME-Version: 1.0
Message-ID: <c53a0fb8-d640-4d58-b339-0a7ea10aa621@gmail.com>
In-Reply-To: <20190625094602.GC13263@fuggles.cambridge.arm.com>
References: <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
 <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
 <20190619170940.GG17978@ZenIV.linux.org.uk>
 <cd84de0e-909e-4117-a20a-6cde42079267@gmail.com>
 <20190624114741.i542cb3wbhfbk4q4@willie-the-truck>
 <20190625094602.GC13263@fuggles.cambridge.arm.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, June 25, 2019 11:46:02 AM CEST, Will Deacon wrote:
> [+Marc]
>
> Hi again, Vicente,
>
> On Mon, Jun 24, 2019 at 12:47:41PM +0100, Will Deacon wrote:
>> On Sat, Jun 22, 2019 at 08:02:19PM +0200, Vicente Bergas wrote: ...
>
> Before you rush over to LAKML, please could you provide your full dmesg
> output from the kernel that was crashing (i.e. the dmesg you see in the
> kexec'd kernel)? We've got a theory that the issue may be related to the
> interrupt controller, and the dmesg output should help to establish whether=

> that is plausible or not.
>
> Thanks,
>
> Will

Hi Will,
the memtest test is still pending...

Regarding interrupts, the kernel before kexec has this parameter:
irqchip.gicv3_nolpi=3D1
Thanks to Marc:
https://freenode.irclog.whitequark.org/linux-rockchip/2018-11-20#23524255

The kernel messages are here:
https://paste.debian.net/1089170/
https://paste.debian.net/1089171/

Regards,
  Vicen=C3=A7.

