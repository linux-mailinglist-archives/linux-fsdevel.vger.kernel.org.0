Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF273CD031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 11:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhGSIaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 04:30:23 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:33517 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbhGSIaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:30:19 -0400
Received: by mail-ej1-f47.google.com with SMTP id bu12so27603794ejb.0;
        Mon, 19 Jul 2021 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBSq6zJFuhCvZnOd2gsZfOMT0eqyDUMuVPMMsfBiF1k=;
        b=tyuwkC2PzoZWVuCqm9kCcz3M9SCCkXn/k2TPyTvNUCyrH//h97IumALBHO8pcUpWgj
         OIWRiPnAheYYrXvjryxDIP6hOU9+DElevR87h88njDFs3ujo0voRJaw5/Ll1x8qjwGgv
         zd1xKrFqSC+6ZSuU5Wyn9GEwDDm+eQGmeUJu/ZCU1tnUkp/B08O/yyMYbk60PfjNWBRs
         HtRbPlO/whptCcPo2L3HmnD6a9KfspVqDB+1IKiFAVxZtb9cttM5npNsK/uS0YEHudjQ
         v3detn/3H/nsLpPwP9PVzSAFnGO6NtzfUIcxd+tPhJ0i6uwXc9BWELDB/9jK/hpPQpXX
         GHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBSq6zJFuhCvZnOd2gsZfOMT0eqyDUMuVPMMsfBiF1k=;
        b=FgQxKc5byMJe0bSG1fnGpoawYdpDi9fTYJDOnrhCStxHvzA5k3Yh0zBr6/BGhBJaSV
         hAI/rKWJ3yLxZf9TJzJGl1s2KC3lLreXhQ/SuAXVsdHLxm91k0d1k/lHiAzdOOP3sCMt
         QQAyvuXqtR0PChino0BErbaw4Ui6rTlJ+YPNQFOMPBsA7d0XIdVOQbanVHAtEMhiLmWd
         7xfAb9VO8o1Vcm7B5vWKWr9MvOAwmIyIW91DRsVWCwrhUcRDf1qpr65X1pj8PjLeIfvs
         SYaoyPlVBMJczgpxt+CoFYZWd+C0ZEmnreBEJUmKNQ4UIVAu9Ajaj4f5gTvH4nFfsqYQ
         YiiA==
X-Gm-Message-State: AOAM530I4p1W3KBuvr9MMnUBxhZC+jy8dYaw+/ddUO/a6OpbKZZv6g0k
        qW0p4QZ+jHqUyxxKhZ2mkaOG53f6RqL7n18ZGjQ=
X-Google-Smtp-Source: ABdhPJwubtgEMes7Ng29QD5qA/jN51mjW/q7+dtbpcLGkpLbDjrv1aOLcqCXW12Mc7+LVAk5fM+b/NX/9+Yz96jFMnM=
X-Received: by 2002:a17:906:9d17:: with SMTP id fn23mr26835249ejc.191.1626685798074;
 Mon, 19 Jul 2021 02:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
In-Reply-To: <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 19 Jul 2021 14:39:46 +0530
Message-ID: <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 16 Jul 2021 at 21:56, Richard Weinberger <richard@nod.at> wrote:

> >> My requirement:
> >> To find the checksum of a real image in runtime which is flashed in an
> >> MTD partition.
> >
> > Try using the dm-verity module for ensuring that a block device really
> > is properly signed before mounting it.  That's what it was designed for
> > and is independent of the block device type.
>
> MTDs are not block devices. :-)
>
Is it possible to use dm-verity with squashfs ?
We are using squashfs for our rootfs which is an MTD block /dev/mtdblock44
