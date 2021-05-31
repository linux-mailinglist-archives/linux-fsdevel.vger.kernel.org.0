Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B599395417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 04:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEaC4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 22:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaC4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 22:56:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80FC061574;
        Sun, 30 May 2021 19:55:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j10so11724956edw.8;
        Sun, 30 May 2021 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qi4JwnuStjKrl13hwRZNjYRqAXVvLVe47KpI8ZOLhcA=;
        b=uElWrWzvBAHrc44Imdhjdq0EX+o1vZtfPPFcY84AGmkmIZjj/6YT6uIGdn3c457aYq
         Dj7xt/j+bqZIEqb8XWQTCtMpiIpZhGX+hf5rB1zPzxQT9owtNsctHaUPlajlEe+EoH/d
         72ByMG7lQXgnvlkXVLd6tyqUdHvL+uVNbcB4MWGeRyjutC+aleeSuLqTLBYQ2r47t/Bd
         zAfvRJ/4WxNFaQkfOVIb6V19u15onpv6Fi/ZtU/wCuUFSnwD3tYaq1xUg5yemY2C8rf/
         s9Xr9hYmMs8kGTbN97B0KVaW6kdCPvOX1dM7zR1QLtrfqwT/NHt6wBZ3qmcbajMJAbvz
         tSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qi4JwnuStjKrl13hwRZNjYRqAXVvLVe47KpI8ZOLhcA=;
        b=fHTu7cTraO4D/hFWICjMJlUrypY449EwdfkNUCJwa8tkUhfsLAIjvSJVWC3m/XG5fl
         xL7YlUyxVr6LOCAH2m18vK6Kpjb6IkqUsWZTnDDV/ZUd+kAuwr8giLsQBSE6nwhAqvhc
         yI4GONm/KsJzC4dYSQ9EA4l0kNDhUuc5WNI8834H10lDxlwyauwtRapCVSQYLMP9fGJG
         dii/Baj0AUvR4oOF8lrJWnyj8hFvBioh9zoXz8FQqQ6mL34uhq3EA37J1vB8rVOaOqci
         DFyOd8tEFmgDR3ibaQD6WbBbQ4WJCAuNjqibxR/RYQWGRIGS6RRDqKsulToSlXNHY5F/
         6Vyw==
X-Gm-Message-State: AOAM533kHhbjzhRwYyfAhJze+oYx8IjHGb3tI33gAk3tRKdqU7KvPbXU
        krcYFwk+18L0TL6Yo6zNkuEzi/15UFCJM2+/2XQmCWxd
X-Google-Smtp-Source: ABdhPJw7Y0d92GylmlMCy9GMNyn7kQnkHuYBMaViMJry1bY7neGEi5I54S2HU379J78rHAbRggiff+zo5ufy89Pi0Wo=
X-Received: by 2002:a05:6402:2713:: with SMTP id y19mr22499149edd.59.1622429700519;
 Sun, 30 May 2021 19:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjgpkBh9dnfNTdDcfk5HiL=HjjiB9o_=fjrm+0vP7Re2Q@mail.gmail.com>
 <CAOuPNLh_0Q9w96GKT-ogC0BBcEHgo=Hv3+c=JBcas2VgqDiyaw@mail.gmail.com>
 <CAOuPNLjmJ0YufFktJzjkyvdxwFTOpxVj5AW5gANAGSG=_yT=mQ@mail.gmail.com>
 <1762403920.6716767.1621029029246@webmail.123-reg.co.uk> <CAOuPNLhn90z9i6jt0-Vv4e9hjsxwYUT2Su-7SQrxy+N=HDe_xA@mail.gmail.com>
 <486335206.6969995.1621485014357@webmail.123-reg.co.uk> <CAOuPNLjBsm9YLtcb4SnqLYYaHPnscYq4captvCmsR7DthiWGsQ@mail.gmail.com>
 <1339b24a-b5a5-5c73-7de0-9541455b66af@geanix.com> <CAOuPNLiMnHJJNFBbOrMOLmnxU86ROMBaLaeFxviPENCkuKfUVg@mail.gmail.com>
 <4304c082-6fc5-7389-f883-d0adfc95ee86@geanix.com>
In-Reply-To: <4304c082-6fc5-7389-f883-d0adfc95ee86@geanix.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 31 May 2021 08:24:49 +0530
Message-ID: <CAOuPNLigHdbu_OTpsFr7gq+nFK2Pv+4MUSrC6A6PfKfF1H1X3Q@mail.gmail.com>
Subject: Re: [RESEND]: Kernel 4.14: UBIFS+SQUASHFS: Device fails to boot after
 flashing rootfs volume
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 May 2021 at 11:07, Sean Nyekjaer <sean@geanix.com> wrote:
> We are writing our rootfs with this command:
> ubiupdatevol /dev/ubi0_4 rootfs.squashfs
>
> Please understand the differences between the UBI and UBIFS. UBI(unsorted block image) and UBIFS(UBI File System).
> I think you want to write the squashfs to the UBI(unsorted block image).
>
> Can you try to boot with a initramfs, and then use ubiupdatevol to write the rootfs.squshfs.
>
Dear Sean, thank you so much for this suggestion.
Just a final help I need here.

For future experiment purposes, I am trying to setup my qemu-arm
environment using ubifs/squashfs and "nandsim" module.
I already have a working setup for qemu-arm with busybox/initramfs.
Now I wanted to prepare ubifs/squashfs based busybox rootfs which I
can use for booting the mainline kernel.
Is it possible ?
Are there already some pre-built ubifs images available which I can
use for my qemu-arm ?
Or, please guide me how to do it ?

I think it is more convenient to do all experiments with "nandsim"
instead of corrupting the actual NAND hardware.
If you have any other suggestions please let me know.


Thanks,
Pintu
