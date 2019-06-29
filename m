Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6235ADAA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 00:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF2W4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 18:56:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35573 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfF2W4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 18:56:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so2150359wrb.2;
        Sat, 29 Jun 2019 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=qUedtJ5SZ+27TWH7owaYfng0Kwqx/x4UxotqXgxYYyY=;
        b=L00cjy6P7ujKCFjPNiNUGSRTGzeTEpmRlQAkL5c+pmAQuToj52Im9ZWCPjDRVg9YWG
         eOTnEzHGAh5++1ir0mm9PdcDQ+0iyG1cOcRp6urb5o8ZfNEKf9lIu9ghw57KuyYJsgr2
         r9X/L6O3Nno5cBn88+e4QU8K/QD8feAt1VimhSqX3j4MMEKlr2gMXt6ypo3rP5jjjZSl
         tv88ADELXHdhLz805ltRQ9iq28vzXhi0J72tF11c6mbFIuOSG0IFyqkXWqGmOjPVADej
         whiZ0/50MZZxCG9XtV2I5fy5WAANi7XlMCBoB5sZGU5nhtr7Iy+3qeQ6qmqiaOcOG8dp
         V99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=qUedtJ5SZ+27TWH7owaYfng0Kwqx/x4UxotqXgxYYyY=;
        b=UmD6u3CflRbYtXw4eVCOQgcQyp9OnrXlbjUeSMZIfBfgR7dps76nOEExYWsPf6+lLj
         dgYIY/+dLTvQ560aEgk5DEEYPmuq4vGTvKT2drZ18qOK+bx5oG3rKSofOj1dH2DmPmfT
         BkoYqNbVeGm6St+oZ5ZlIKx0IcHrhdzbsrXJ32JZeL9WyZaHk4tJt+FpottCwadGOzDH
         oArXmOcuNQ7csi9IXhq3/HI2gYzpQcUszxNKNgSLNkNelk1YYAZAIO3/jNoufVf6AlZ9
         67y3qqkK4Gs0D4uxeTFA1Tnw5/P21cMoZ9XKba3589b3KcnYvP+Fex9bVexcvdi/l/xB
         yiVA==
X-Gm-Message-State: APjAAAVKCdwJPwoQ4nQTMCWR82e7AkTYYI0n08ESoBsSy6KLGNlmIFk8
        TiE7kk/I98Ttd6K+A8ryUf7pKBSN3gz3Tg==
X-Google-Smtp-Source: APXvYqxXpMAW5tu4Tn2Rpguv0WNFs51NTjwwp62AAM5gbkEs5x4X11FXcrgM5oVrvXdCPNfJ20j9AQ==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr13432778wrs.97.1561849007278;
        Sat, 29 Jun 2019 15:56:47 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id z6sm5531618wrw.2.2019.06.29.15.56.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 15:56:46 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Will Deacon <will@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <marc.zyngier@arm.com>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Sun, 30 Jun 2019 00:56:44 +0200
MIME-Version: 1.0
Message-ID: <914ad7ec-36ca-4ac0-87d0-e7016515baa3@gmail.com>
In-Reply-To: <c53a0fb8-d640-4d58-b339-0a7ea10aa621@gmail.com>
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
 <c53a0fb8-d640-4d58-b339-0a7ea10aa621@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, June 25, 2019 12:48:17 PM CEST, Vicente Bergas wrote:
> On Tuesday, June 25, 2019 11:46:02 AM CEST, Will Deacon wrote:
>> [+Marc]
>>=20
>> Hi again, Vicente,
>>=20
>> On Mon, Jun 24, 2019 at 12:47:41PM +0100, Will Deacon wrote: ...
>
> Hi Will,
> the memtest test is still pending...

Hi Will,
i've just ran that memtest and no issues have been found. See below.
I've also noticed that this is running very early, hence the 'earlycon'.
Because of this i wondered if it was run with interrupts disabled, and
indeed this is the case, am i wrong?
If the kernel before kexec is corrupting memory for the currently
running kernel, which entry point does it have, besides interrupts?
Or can the corruption come through DMA from a peripheral?

> Has kexec ever worked reliably on this board?

Yes, more or less. I have experienced some issues that could be
caused because of this, like sometimes on-screen flickering or
failing to boot once every 20 or 30 tries. But recently this
d_lookup issue appeared and it is a show-stopper.

This way of booting is used on both the sapphire board and on kevin.
The bootloader is https://gitlab.com/vicencb/kevinboot (not up to
date) and a similar one for the sapphire board.

Regards,
  Vicen=C3=A7.

Booting Linux on physical CPU 0x0000000000 [0x410fd034]
Linux version 5.2.0-rc6 (local@host) (gcc version 8.3.0 (GCC)) #1 SMP @0
Machine model: Sapphire-RK3399 Board
earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options '1500000n8')
printk: bootconsole [uart0] enabled
early_memtest: # of tests: 17
  0x0000000000200000 - 0x0000000000280000 pattern 4c494e5558726c7a
  0x0000000000b62000 - 0x0000000000b65000 pattern 4c494e5558726c7a
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 4c494e5558726c7a
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 4c494e5558726c7a
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 4c494e5558726c7a
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 4c494e5558726c7a
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 4c494e5558726c7a
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 4c494e5558726c7a
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 4c494e5558726c7a
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 4c494e5558726c7a
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 4c494e5558726c7a
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 4c494e5558726c7a
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 4c494e5558726c7a
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 4c494e5558726c7a
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 4c494e5558726c7a
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 4c494e5558726c7a
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 4c494e5558726c7a
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 4c494e5558726c7a
  0x0000000000200000 - 0x0000000000280000 pattern eeeeeeeeeeeeeeee
  0x0000000000b62000 - 0x0000000000b65000 pattern eeeeeeeeeeeeeeee
  0x0000000000b7665f - 0x00000000f77e8a58 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern eeeeeeeeeeeeeeee
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern eeeeeeeeeeeeeeee
  0x0000000000200000 - 0x0000000000280000 pattern dddddddddddddddd
  0x0000000000b62000 - 0x0000000000b65000 pattern dddddddddddddddd
  0x0000000000b7665f - 0x00000000f77e8a58 pattern dddddddddddddddd
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern dddddddddddddddd
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern dddddddddddddddd
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern dddddddddddddddd
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern dddddddddddddddd
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern dddddddddddddddd
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern dddddddddddddddd
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern dddddddddddddddd
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern dddddddddddddddd
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern dddddddddddddddd
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern dddddddddddddddd
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern dddddddddddddddd
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern dddddddddddddddd
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern dddddddddddddddd
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern dddddddddddddddd
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern dddddddddddddddd
  0x0000000000200000 - 0x0000000000280000 pattern bbbbbbbbbbbbbbbb
  0x0000000000b62000 - 0x0000000000b65000 pattern bbbbbbbbbbbbbbbb
  0x0000000000b7665f - 0x00000000f77e8a58 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern bbbbbbbbbbbbbbbb
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern bbbbbbbbbbbbbbbb
  0x0000000000200000 - 0x0000000000280000 pattern 7777777777777777
  0x0000000000b62000 - 0x0000000000b65000 pattern 7777777777777777
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 7777777777777777
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 7777777777777777
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 7777777777777777
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 7777777777777777
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 7777777777777777
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 7777777777777777
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 7777777777777777
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 7777777777777777
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 7777777777777777
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 7777777777777777
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 7777777777777777
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 7777777777777777
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 7777777777777777
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 7777777777777777
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 7777777777777777
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 7777777777777777
  0x0000000000200000 - 0x0000000000280000 pattern cccccccccccccccc
  0x0000000000b62000 - 0x0000000000b65000 pattern cccccccccccccccc
  0x0000000000b7665f - 0x00000000f77e8a58 pattern cccccccccccccccc
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern cccccccccccccccc
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern cccccccccccccccc
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern cccccccccccccccc
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern cccccccccccccccc
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern cccccccccccccccc
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern cccccccccccccccc
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern cccccccccccccccc
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern cccccccccccccccc
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern cccccccccccccccc
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern cccccccccccccccc
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern cccccccccccccccc
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern cccccccccccccccc
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern cccccccccccccccc
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern cccccccccccccccc
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern cccccccccccccccc
  0x0000000000200000 - 0x0000000000280000 pattern 9999999999999999
  0x0000000000b62000 - 0x0000000000b65000 pattern 9999999999999999
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 9999999999999999
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 9999999999999999
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 9999999999999999
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 9999999999999999
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 9999999999999999
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 9999999999999999
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 9999999999999999
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 9999999999999999
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 9999999999999999
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 9999999999999999
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 9999999999999999
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 9999999999999999
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 9999999999999999
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 9999999999999999
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 9999999999999999
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 9999999999999999
  0x0000000000200000 - 0x0000000000280000 pattern 6666666666666666
  0x0000000000b62000 - 0x0000000000b65000 pattern 6666666666666666
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 6666666666666666
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 6666666666666666
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 6666666666666666
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 6666666666666666
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 6666666666666666
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 6666666666666666
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 6666666666666666
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 6666666666666666
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 6666666666666666
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 6666666666666666
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 6666666666666666
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 6666666666666666
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 6666666666666666
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 6666666666666666
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 6666666666666666
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 6666666666666666
  0x0000000000200000 - 0x0000000000280000 pattern 3333333333333333
  0x0000000000b62000 - 0x0000000000b65000 pattern 3333333333333333
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 3333333333333333
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 3333333333333333
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 3333333333333333
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 3333333333333333
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 3333333333333333
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 3333333333333333
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 3333333333333333
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 3333333333333333
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 3333333333333333
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 3333333333333333
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 3333333333333333
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 3333333333333333
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 3333333333333333
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 3333333333333333
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 3333333333333333
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 3333333333333333
  0x0000000000200000 - 0x0000000000280000 pattern 8888888888888888
  0x0000000000b62000 - 0x0000000000b65000 pattern 8888888888888888
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 8888888888888888
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 8888888888888888
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 8888888888888888
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 8888888888888888
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 8888888888888888
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 8888888888888888
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 8888888888888888
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 8888888888888888
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 8888888888888888
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 8888888888888888
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 8888888888888888
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 8888888888888888
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 8888888888888888
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 8888888888888888
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 8888888888888888
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 8888888888888888
  0x0000000000200000 - 0x0000000000280000 pattern 4444444444444444
  0x0000000000b62000 - 0x0000000000b65000 pattern 4444444444444444
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 4444444444444444
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 4444444444444444
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 4444444444444444
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 4444444444444444
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 4444444444444444
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 4444444444444444
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 4444444444444444
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 4444444444444444
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 4444444444444444
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 4444444444444444
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 4444444444444444
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 4444444444444444
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 4444444444444444
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 4444444444444444
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 4444444444444444
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 4444444444444444
  0x0000000000200000 - 0x0000000000280000 pattern 2222222222222222
  0x0000000000b62000 - 0x0000000000b65000 pattern 2222222222222222
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 2222222222222222
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 2222222222222222
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 2222222222222222
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 2222222222222222
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 2222222222222222
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 2222222222222222
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 2222222222222222
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 2222222222222222
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 2222222222222222
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 2222222222222222
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 2222222222222222
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 2222222222222222
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 2222222222222222
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 2222222222222222
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 2222222222222222
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 2222222222222222
  0x0000000000200000 - 0x0000000000280000 pattern 1111111111111111
  0x0000000000b62000 - 0x0000000000b65000 pattern 1111111111111111
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 1111111111111111
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 1111111111111111
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 1111111111111111
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 1111111111111111
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 1111111111111111
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 1111111111111111
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 1111111111111111
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 1111111111111111
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 1111111111111111
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 1111111111111111
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 1111111111111111
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 1111111111111111
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 1111111111111111
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 1111111111111111
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 1111111111111111
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 1111111111111111
  0x0000000000200000 - 0x0000000000280000 pattern aaaaaaaaaaaaaaaa
  0x0000000000b62000 - 0x0000000000b65000 pattern aaaaaaaaaaaaaaaa
  0x0000000000b7665f - 0x00000000f77e8a58 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern aaaaaaaaaaaaaaaa
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern aaaaaaaaaaaaaaaa
  0x0000000000200000 - 0x0000000000280000 pattern 5555555555555555
  0x0000000000b62000 - 0x0000000000b65000 pattern 5555555555555555
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 5555555555555555
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 5555555555555555
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 5555555555555555
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 5555555555555555
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 5555555555555555
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 5555555555555555
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 5555555555555555
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 5555555555555555
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 5555555555555555
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 5555555555555555
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 5555555555555555
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 5555555555555555
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 5555555555555555
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 5555555555555555
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 5555555555555555
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 5555555555555555
  0x0000000000200000 - 0x0000000000280000 pattern ffffffffffffffff
  0x0000000000b62000 - 0x0000000000b65000 pattern ffffffffffffffff
  0x0000000000b7665f - 0x00000000f77e8a58 pattern ffffffffffffffff
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern ffffffffffffffff
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern ffffffffffffffff
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern ffffffffffffffff
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern ffffffffffffffff
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern ffffffffffffffff
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern ffffffffffffffff
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern ffffffffffffffff
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern ffffffffffffffff
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern ffffffffffffffff
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern ffffffffffffffff
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern ffffffffffffffff
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern ffffffffffffffff
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern ffffffffffffffff
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern ffffffffffffffff
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern ffffffffffffffff
  0x0000000000200000 - 0x0000000000280000 pattern 0000000000000000
  0x0000000000b62000 - 0x0000000000b65000 pattern 0000000000000000
  0x0000000000b7665f - 0x00000000f77e8a58 pattern 0000000000000000
  0x00000000f77e8a87 - 0x00000000f77e8a88 pattern 0000000000000000
  0x00000000f77e8ab7 - 0x00000000f77e8ab8 pattern 0000000000000000
  0x00000000f77e8ae7 - 0x00000000f77e8ae8 pattern 0000000000000000
  0x00000000f77e8b17 - 0x00000000f77e8b18 pattern 0000000000000000
  0x00000000f77e8b47 - 0x00000000f77e8b48 pattern 0000000000000000
  0x00000000f77e8b74 - 0x00000000f77e8b78 pattern 0000000000000000
  0x00000000f77e8ba4 - 0x00000000f77e8ba8 pattern 0000000000000000
  0x00000000f77e8bd4 - 0x00000000f77e8bd8 pattern 0000000000000000
  0x00000000f77e8c04 - 0x00000000f77e8c08 pattern 0000000000000000
  0x00000000f77e8c34 - 0x00000000f77e8c38 pattern 0000000000000000
  0x00000000f77e8c64 - 0x00000000f77e8c68 pattern 0000000000000000
  0x00000000f77e8c94 - 0x00000000f77e8c98 pattern 0000000000000000
  0x00000000f77e8cc4 - 0x00000000f77e8cc8 pattern 0000000000000000
  0x00000000f77e8cf4 - 0x00000000f77e8cf8 pattern 0000000000000000
  0x00000000f77e8d29 - 0x00000000f77e8d30 pattern 0000000000000000
On node 0 totalpages: 1015296
  DMA32 zone: 15864 pages used for memmap
  DMA32 zone: 0 pages reserved
  DMA32 zone: 1015296 pages, LIFO batch:63
psci: probing for conduit method from DT.
psci: PSCIv1.1 detected in firmware.
psci: Using standard PSCI v0.2 function IDs
psci: MIGRATE_INFO_TYPE not supported.
psci: SMC Calling Convention v1.1
percpu: Embedded 20 pages/cpu s50200 r0 d31720 u81920
pcpu-alloc: s50200 r0 d31720 u81920 alloc=3D20*4096
pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5=20
Detected VIPT I-cache on CPU0
CPU features: detected: GIC system register CPU interface
Speculative Store Bypass Disable mitigation not required
Built 1 zonelists, mobility grouping on.  Total pages: 999432
Kernel command line:  rw root=3D/dev/sda2 rootwait console=3Dtty0=20
console=3DttyS2,1500000n8 earlycon memtest=3D17
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3971436K/4061184K available (6078K kernel code, 430K rwdata, 1460K=20=

rodata, 640K init, 407K bss, 89748K reserved, 0K cma-reserved)
random: get_random_u64 called from cache_random_seq_create+0x50/0x118 with=20=

crng_init=3D0
SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D6, Nodes=3D1
rcu: Hierarchical RCU implementation.
rcu: =09RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=3D6.
rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D6
NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
GICv3: GIC: Using split EOI/Deactivate mode
GICv3: Distributor has no Range Selector support
GICv3: no VLPI support, no direct LPI support
GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
ITS [mem 0xfee20000-0xfee3ffff]
ITS@0x00000000fee20000: allocated 65536 Devices @f2400000 (flat, esz 8, psz=20=

64K, shr 0)
ITS: using cache flushing for cmd queue
GICv3: using LPI property table @0x0000000000240000
GIC: using cache flushing for LPI property table
GICv3: CPU0: using allocated LPI pending table @0x0000000000250000
GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus/cpu@0[0]=20
/cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus/cpu@100[4]=20
/cpus/cpu@101[5] }
rockchip_mmc_get_phase: invalid clk rate
rockchip_mmc_get_phase: invalid clk rate
rockchip_mmc_get_phase: invalid clk rate
rockchip_mmc_get_phase: invalid clk rate
arch_timer: cp15 timer(s) running at 24.00MHz (phys).
clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:=20
0x588fe9dc0, max_idle_ns: 440795202592 ns
sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
Console: colour dummy device 240x67
printk: console [tty0] enabled
Calibrating delay loop (skipped), value calculated using timer frequency..=20=

48.00 BogoMIPS (lpj=3D96000)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
*** VALIDATE proc ***
*** VALIDATE cgroup1 ***
*** VALIDATE cgroup2 ***
ASID allocator initialised with 32768 entries
rcu: Hierarchical SRCU implementation.
Platform MSI: interrupt-controller@fee20000 domain created
smp: Bringing up secondary CPUs ...
Detected VIPT I-cache on CPU1
GICv3: CPU1: found redistributor 1 region 0:0x00000000fef20000
GICv3: CPU1: using allocated LPI pending table @0x0000000000260000
CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
Detected VIPT I-cache on CPU2
GICv3: CPU2: found redistributor 2 region 0:0x00000000fef40000
GICv3: CPU2: using allocated LPI pending table @0x0000000000270000
CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
Detected VIPT I-cache on CPU3
GICv3: CPU3: found redistributor 3 region 0:0x00000000fef60000
GICv3: CPU3: using allocated LPI pending table @0x00000000f2480000
CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
CPU features: detected: EL2 vector hardening
Detected PIPT I-cache on CPU4
GICv3: CPU4: found redistributor 100 region 0:0x00000000fef80000
GICv3: CPU4: using allocated LPI pending table @0x00000000f2490000
CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
Detected PIPT I-cache on CPU5
GICv3: CPU5: found redistributor 101 region 0:0x00000000fefa0000
GICv3: CPU5: using allocated LPI pending table @0x00000000f24a0000
CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
smp: Brought up 1 node, 6 CPUs
SMP: Total of 6 processors activated.
CPU features: detected: 32-bit EL0 Support
CPU features: detected: CRC32 instructions
CPU: All CPU(s) started at EL2
alternatives: patching kernel code
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns:=20=

7645041785100000 ns
futex hash table entries: 2048 (order: 5, 131072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
DMA: preallocated 256 KiB pool for atomic allocations

> Regarding interrupts, the kernel before kexec has this parameter:
> irqchip.gicv3_nolpi=3D1
> Thanks to Marc:
> https://freenode.irclog.whitequark.org/linux-rockchip/2018-11-20#23524255
>
> The kernel messages are here:
> https://paste.debian.net/1089170/
> https://paste.debian.net/1089171/
>
> Regards,
>  Vicen=C3=A7.

