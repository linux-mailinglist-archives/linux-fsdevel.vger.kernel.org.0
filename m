Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C870BF0D20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfKFDiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 22:38:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33524 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfKFDiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:38:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id y9so747988lfy.0;
        Tue, 05 Nov 2019 19:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQNvjkqU67idBz4OClsv+GBdG1CkudkHJ4L8UJX4w/w=;
        b=sw6iNRzNVysag3UPMEbh+Kn8on6rXPfvM9tKGSmC3XEjYBt44boYgzZl4C3FM3NJ0U
         FaQiqVvJvWYX7LDrTPBV9mXzd5M29led45NN1+CftEh5QTL7rsc6pXruuvymoVu6RJ98
         U6EdiJTElql9KXjcAm8BPjiVlUROKm22bl3GEjV56ji7BcvW+lqDHqe18k4OlZAi50WC
         tVrNdQwzOQYBdRdYa25twOy6CV6cdMgEMB28ysF8ySX6+5Scz9o8NDw57H2u2vM3g9yS
         lzvGCZkyQOqcl2VvHSvAwKRmzL4l2lPXO+sTQevXbHU1J7nudI0SZKkxkrIVkdzqpEAV
         LmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQNvjkqU67idBz4OClsv+GBdG1CkudkHJ4L8UJX4w/w=;
        b=nl89sMjVdyynv3Srux80NKBteSlY/NxRIxbx84C78nLRqHw/ndB3Z3w9FsrKxh95at
         VKp7jf3rOLRmQVpCsUYiwb6/jxJXgaAFN84lEgtRin9fA5i1T8lTfKCdfPUJkhsEcvgP
         60KYlHlmXTXp1t8JmbchXSuF0JN6s0O70N6wEhAA+hW+qmgtZhLHJvGLENBNYHxELDTL
         v2E9NpuAUFKH6gyR8VvOMV1LFAAbZatn/VK/Fh/BaJcAM7cwfMf66y1H7Oob/rDeG1S0
         ZDH2CfXTGE45kUKGtRYhtURHVxcYVWeuHMahq6O2eODprBI4lSgFt/xIrNH6iSmO0gOl
         EvPA==
X-Gm-Message-State: APjAAAUgDJK+loYuWTsDCp0ThD8vvSB7A+jF3+fuNxYG39+RjsrOkkbl
        yTrGODGSzDNysXszwFEO3vOa4+lqoGs+CWDxMZM=
X-Google-Smtp-Source: APXvYqwsChCPnzWywORig0kW/0YNBnseFKqWqgZ9Fh/5TQNFafS9PAOY1lUanc9n2WfrvRNPjoeKt/V48muf9nJQN0c=
X-Received: by 2002:a19:f610:: with SMTP id x16mr10831876lfe.141.1573011501515;
 Tue, 05 Nov 2019 19:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
 <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
 <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
 <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
 <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
 <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de>
 <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
 <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com>
 <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
 <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com>
 <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de>
 <CACAVd4grhGVVSYpwjof5YiS1duZ2_SFjvXtctP+cmR5Actkjyg@mail.gmail.com> <alpine.DEB.2.21.1911051100471.17054@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1911051100471.17054@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Wed, 6 Nov 2019 09:08:10 +0530
Message-ID: <CACAVd4geU0aFqvFhNQ4YGHDtLPwcqhubh8hcu4CT7CN+G2zpdA@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Tglx,

Thank you for the update. We have few customers who are waiting for
this patch. Please prioritize it.

Regards,
Arul

On Tue, Nov 5, 2019 at 3:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arul,
>
> On Tue, 5 Nov 2019, Arul Jeniston wrote:
> > >  So I'm going to send a patch to document that in the manpage.
> >
> > Did you get a chance to make the manpage patch? if yes, please help us
> > by sharing the link where we can find the patch.
>
> No. I would have Cc'ed you when posting. It's somewhere on my todo list.
>
> Thanks,
>
>         tglx
