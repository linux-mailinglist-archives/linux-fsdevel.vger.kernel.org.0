Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5AE32CE87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 09:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhCDIb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 03:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhCDIbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:31:41 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D2C061574;
        Thu,  4 Mar 2021 00:31:01 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d9so27648506ybq.1;
        Thu, 04 Mar 2021 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBUtXor9JHig51XwOk2hKqYVPwMBdbUM5CT6K0S4ndc=;
        b=Podv25yUm88aY+8mEUWBOnr7ph6i86M9YgHhCbaqEq1+ciSnQ4CGjjNmHjNc2RzeTr
         aaQS6ot9VEQZ/i6l7rnzI6+Mtu3I0p9XyLD6Q6yA0mZLQ+quxvFQ5ScOyVXW3FMHmZiC
         drSHvhQraY61uCEBdDRm/72oRpjmqT1+MhWT5i2Zxgf2P4okcqdk7Pj+JTGw6ALqqVYP
         L9395H+E6IRqthsuZM8dmObEB3z3PzHnFDMeae5IHm50h3QfloLbDqjCNeIqZ7c7nMcN
         2IS6BZuB0IPOAWXYLlVCUQL92jtKYdioEWJdYzG0xvcdRQ9nfysMd9+AS7lsmUfkPvu7
         u8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBUtXor9JHig51XwOk2hKqYVPwMBdbUM5CT6K0S4ndc=;
        b=N2yySH4DMegZu8X+GfBE+Mz6ZR2xQzQl7Bx/liiuQAsVAI9rTOF1MBCg8qfdL9i5vA
         9SjKd6LbofjusPU4jTeXEK7AZ6cbnXnJB4RXxgH+x42ToF7GwgXLlB/vwoGk+waZ3Ah0
         kV+mzzjcPHANo3Uwrx1u1QKQCtbYJujxMMy7gbRbpkvQU/YOrd1YxUljLBCTfG2BAwLx
         YMkBMbHp66Ndrp1OqHvfModmR+9ponYaKcQ5VfRYFotjuyqV9gDIsYtPdnnAZTZrqQzI
         GsaO5PIooX7zXseDy5B0GZZzDWkXaamBCiJtLkE64jgNSmo7Cx+zFVg1wtOauXNWZoq2
         n0bg==
X-Gm-Message-State: AOAM533aciS9nSw/6IpQi4/Y6HIfc/9fMHg0HKCUbMPCqydNu7stvpbg
        oUyGhFs9GZi2CByHT6SlHZNBX/7DYGxBMiCPwG4=
X-Google-Smtp-Source: ABdhPJwueHAY695LaUUFe5cSJfYyxtyB+83dn4Q/EVZ6w477nyX3CpA7IBDWq8xAbPTmbwv9XmtGCbOEOKV5EiUYbiI=
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr5066850ybf.26.1614846660505;
 Thu, 04 Mar 2021 00:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20210301160102.2884774-1-almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210301160102.2884774-1-almaz.alexandrovich@paragon-software.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 4 Mar 2021 09:30:49 +0100
Message-ID: <CANiq72nRpxe5M5rsBdWe_2tEpGju7Oe0bBhOdwMBa6MHkHi_Qg@mail.gmail.com>
Subject: Re: [PATCH v22 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>, pali@kernel.org,
        dsterba@suse.cz, aaptel@suse.com,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com, Dan <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@lst.de>, ebiggers@kernel.org,
        andy.lavr@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 1:09 AM Konstantin Komarov
<almaz.alexandrovich@paragon-software.com> wrote:
>
> - use clang-format 11.0 instead of 10.0 to format code

Out of curiosity: was this due to some specific reason? i.e. have you
found it provides better output? (it is useful to know this to justify
later an increase of the minimum version etc.)

Thanks!

Cheers,
Miguel
