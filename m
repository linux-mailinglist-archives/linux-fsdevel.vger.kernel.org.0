Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04DC1E6171
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbgE1Mvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 08:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389873AbgE1Mvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 08:51:53 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C90C05BD1E;
        Thu, 28 May 2020 05:51:53 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so15652160vsl.9;
        Thu, 28 May 2020 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lt0aJ/HKY3louy8TYKyi0MkEQNaEc9fCj6oIXB48VFQ=;
        b=TJ92fK8qL246A8nOM5+5qXGRx3BB4SkxAQKInO/7psKXNC/ZHMNacF6wXsnsy2jdyV
         OzEGZYo1pcBk1/JltGEHWzI6PKDE6muiYbB2IRohny0bEkbiB7iQM/bj80YXNht5GpFD
         BDfrrZqiaU3Uup/yaVIbeWMfjx6kM366fMA5D4rfLlsSeZB4/JHn2/Lzj7OurLNyzjmZ
         sHD1vfxWk6omsxb15Vr7vIjzi6py73u8e88VJYn3gAanuwaFj20EOuq2Y3HqPDr1YU9J
         1AMoeD4EC5LHEPWq5jQ9Ynea22LBVceNdk5TTd/P9kEv0FcQbBBRLYBriaxxEzZnKEqf
         JbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lt0aJ/HKY3louy8TYKyi0MkEQNaEc9fCj6oIXB48VFQ=;
        b=mn+9gQ2EEA/K7ioYA5L0jlbDcr3K+KpL+SmjG7GbVsY5nRrAR6JwMExkkMD6as8GKs
         gRxCD0yK773hP4vaEgJc5WzpIURt49tpGl8OSY+njrsW57htcrYHOZihApU5GsskuFe/
         Vvox9IqBHJwbRW+EwaWF20OGRywQpLEtCzeSgXccwG4Kmcf/I5E8W/1x0+wkjel2S0Kd
         efb2A5N9YkqqgW7uwfnYbg8r0HQtsSYxlE+GZYDEeiKCpa7+fiCJ1PMLb1mkkic8/Dfa
         nq5t5biJH3zeJTK/shvYH9Fp/tVnDyWkAFcx/6koykkf9oOYXLWaXVOXJk7e1C+TK6do
         9MGA==
X-Gm-Message-State: AOAM532e8rl/hicf23lebAb6Az4LwEiasXLZzJQFf6HpySNS6GgbQtbW
        du9p78hnwJRc0qDtxzd1czG+NG+o1QJjs2pAZ0E=
X-Google-Smtp-Source: ABdhPJyiA4HP9FtEREIW9ZmZ9toaJsyV9aglFdMu/vg2mezc8Vcr3ocA/07CzY15XP7SRq6hvc6uXL/R+3504/iKxVY=
X-Received: by 2002:a67:e012:: with SMTP id c18mr1712875vsl.12.1590670312908;
 Thu, 28 May 2020 05:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <e218bc34-b8cf-cf0d-aaf1-e1f259d29f7c@web.de>
In-Reply-To: <e218bc34-b8cf-cf0d-aaf1-e1f259d29f7c@web.de>
From:   Tao pilgrim <pilgrimtao@gmail.com>
Date:   Thu, 28 May 2020 20:51:41 +0800
Message-ID: <CAAWJmAYox7VNCzj7FnRdiX450wd=DtZAcZv3_2JiPmBuLvUMeQ@mail.gmail.com>
Subject: Re: [PATCH] proc/fd: Remove the initialization of variables in seq_show()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > The variables{files, file} will definitely be assigned,
>
> I find an other specification nicer for these identifiers.
>
>
> > so we don't need to initialize them.
>
> I suggest to recheck programming concerns around the handling
> of the null pointer for the variable =E2=80=9Cfile=E2=80=9D.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/proc/fd.c?id=3Dcaffb99b6929f41a69edbb5aef3a359bf45f3315#n20
> https://elixir.bootlin.com/linux/v5.7-rc6/source/fs/proc/fd.c#L20

We don't need to initialize the variable =E2=80=9Cfile=E2=80=9D.
On line 34, if (files) is true,
{file =3D fcheck_files(files, fd)} will be executed on line 38.
On line 34, if (files) is flse,
{return ret;} will be executed on line 54, and seq_show() will exit directl=
y.
I don't find the programming concerns around the handling of the null
pointer for the variable =E2=80=9Cfile=E2=80=9D.

If you have other suggestions, please elaborate on the details.

--
Yours,
Kaitao Cheng
