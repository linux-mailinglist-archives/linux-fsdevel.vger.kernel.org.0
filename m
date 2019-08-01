Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC83E7E5DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbfHAWmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 18:42:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45592 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHAWmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:42:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so70885384lje.12;
        Thu, 01 Aug 2019 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPpilKaOTYv54wofyHkUAny9IhEVO2TjoF1NDfPLYk0=;
        b=Npgpo0bdPcFZIGjdsXC/vYnwEsKfPPSfMELVuVTdQl7HeY/ZR476KkeZ8ahZ2ktIM8
         Ui92g4x3wutC3tenXz/G7fi8+7WV37/D+hEX3tphd403LFbfZdAJvG27U2bBFvSyN9xm
         EKX8XjsjMgkracuCgRW7wMQ2Vk3475voIx+OVGoGtQoCARcQyrOyQJssYFXPNS77etU+
         3jXgSqaFdyKftJdPDigfXjtHRZyzfrQvJrs2CBOgMLAgsQRSiuORGANs8xu0mQvqWZ8H
         sMLu2vMHoxsFNNSHuCSwlHEPLx2gDPnuZEQ40rLHil2fqqP9DM7/Q9wnhNBmCjaaM8mt
         bP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPpilKaOTYv54wofyHkUAny9IhEVO2TjoF1NDfPLYk0=;
        b=UepKap9A4N0chi3w2o95X7P7+N4rwmGD49TexTji4sZDleVNs+EhVItVj5UE08MoXu
         6VZwKkVgkEp3TkW5wbKcxeKraxWqv5tOZk7jfIKZYC2aWmltUj83QMSp5WTRsKxMrx+9
         OKyha3PQEPUseUSrvQ3Q7OYrn+EaubG07tGKeg6Jn0TBZjCAny4Ysx9ZwUV/BF/B17CE
         3Rl03LIW/4552QEnRuh/DZRSUj/fkyWrzC5ECdPwEYwxRxe55hTuOOaYUmBoIEHEcyBN
         iah52ssdjftQw1taTnpYNjPBEmn/eXOW6W3n9lgeJ+fKxYZ93OzDElnP9UPMxTSHy4WR
         9KwQ==
X-Gm-Message-State: APjAAAVgXewCEPmkR6M7N5AopuCzbf+VMTz47XS/X4B/SlsHJ+8qhnFL
        Q2N4LY3MRnYcc39phuoguMmgk+SKFR27S4PMWZ0=
X-Google-Smtp-Source: APXvYqz82X0PIUyuArp5WFv8gOIid4HhOloID2Z2ADtMivkkZA3/z71oIuBOAgX4A+sMBJe652cfGr8/p0vbCLvROi8=
X-Received: by 2002:a2e:b048:: with SMTP id d8mr28071195ljl.118.1564699323493;
 Thu, 01 Aug 2019 15:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
 <20190801222613.iugdsswxbn2pawgd@qor.donarmstrong.com>
In-Reply-To: <20190801222613.iugdsswxbn2pawgd@qor.donarmstrong.com>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Thu, 1 Aug 2019 23:41:51 +0100
Message-ID: <CAB3wodcKj4uqm7sSiwpZmPpWv4-AgYHOMtM71Cq2SnMBjC=vdw@mail.gmail.com>
Subject: Re: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does
 not make use all CPU cores
To:     Don Armstrong <don@debian.org>
Cc:     owner@bugs.debian.org, listmaster@lists.debian.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 11:26 PM Don Armstrong <don@debian.org> wrote:
>
> On Thu, 01 Aug 2019, Phillip Lougher wrote:
> > That patch is a laughable piece of rubbish.  I believe both you
> > people (the Debian maintainer and author) are in total denial
> > about your incompetence in this matter.  This is obviously just my
> > opinion I've formed over the last couple of months, in case you want to
> > claim that it is libellous.
>
> This isn't an appropriate tone for Debian mailing lists or the our bug
> tracking system.
>
> It's fine to disagree on technical matters, but it's not appropriate to
> claim that people are incompetent or that they are making rubbish.
>

I am only defending myself from the slurs and false information being
spread by your maintainer.

I would not be doing this otherwise.

Cheers

Phillip

> Please stop.
>
> --
> Don Armstrong                      https://www.donarmstrong.com
>
> To punish me for my contempt of authority, Fate has made me an
> authority myself
>  -- Albert Einstein
