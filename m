Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A921D14D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgGMIDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMIDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:03:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D402C061755;
        Mon, 13 Jul 2020 01:03:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so12490791iob.4;
        Mon, 13 Jul 2020 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zRjev5B0s/kQB06JI/MmqEzfNuy+J8HtvJQAaUTG/FM=;
        b=KHMOL46pzOKFig+MOfJXK5wP9ygRfob4uDjEf0d6BtS2YVFCwq8XvTmiYssa8h78Ff
         MtYtMMkEEFKd6Qsr6lOGbUYkNyZTaiB02fGGIh70GXpoy3agI0yX/Sn1R08Mk/MceguG
         afjnEJjiBAqf5GI0WryKrlwTtbMJxIu12Muz4fnA70CVqv9oIs4l/5nVMDU8SIIsf+CQ
         eEUM/pGxH39ju9FsOGYio11g/H6c8H44ethNt7MicsrbzoiXJScCHRlKMlqbmM8iNGei
         5WOGAOakoGdNcBik6xagC8g+uQ3SWUdjQv1BoqBd0kMM6CaZrjJGH3bGPS3FXYontwbp
         YCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zRjev5B0s/kQB06JI/MmqEzfNuy+J8HtvJQAaUTG/FM=;
        b=hkMon1ZKG2VvmPDQ3W/KjftUTnfAZOpfiW06RHuE2PfdJlH/GYBEQGppRd6HTCjRlP
         FootF/OhsjZ24bQPvdP18tAWVMsDlHG4qWdd/sSOn48LgwJQua80168Ja0hbr3FP+AVN
         YcCaTOrndTEcjXSPKnpiNLVz4giT6zh48Mtcw8siHxMwOTCmORLkYeNoa39zipKx7mJh
         xd/jTuM44seqKuQa78YErf7pOtnIEmZveoRIkJzGJ1iG4F9Z5/lElLADtEtQwuOK3DoE
         KTmsnra3B8TdAMJj9yLKhVhru+heI3KKw0LennAf4EK7BKmm0yjo9Wh1LutRtDlwRPrW
         gkIA==
X-Gm-Message-State: AOAM531F/52sE4GDdJSCfCbFNYPfWSq5kbf91+jX41k6esigPZi+llcz
        bwzrT/y+a+/PpkEmxHHTrLe4lVRQSIQ0oMEDkO1fd92cB8A=
X-Google-Smtp-Source: ABdhPJyCV1fdVu2qyQUtD5Mxo/hhCT72STqBfvmiWi45G4O1dfC+DNAeRZi02J/biBQso0TvasefE7a25n5QCk2fxaI=
X-Received: by 2002:a05:6602:1610:: with SMTP id x16mr11426357iow.68.1594627379312;
 Mon, 13 Jul 2020 01:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPPoeja2WxWQ7yhX+3EF1gtCHfjdFjx1CwuAyJcSVzz1g@mail.gmail.com>
 <CABXGCsP3ytiGTt4bepZp2A=rzZzOKbMv62dXpe26f57OCYPnvQ@mail.gmail.com>
In-Reply-To: <CABXGCsP3ytiGTt4bepZp2A=rzZzOKbMv62dXpe26f57OCYPnvQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 13 Jul 2020 13:02:48 +0500
Message-ID: <CABXGCsO+YH62cjT_pF1RMqKD86Zug4CiWzv6QATe_zhEp3eaeQ@mail.gmail.com>
Subject: Re: [5.8RC4][bugreport]WARNING: CPU: 28 PID: 211236 at
 fs/fuse/file.c:1684 tree_insert+0xaf/0xc0 [fuse]
To:     linux-fsdevel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com, vvs@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 13 Jul 2020 at 12:11, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Mon, 13 Jul 2020 at 03:28, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi folks.
> > While testing 5.8 RCs I founded that kernel log flooded by the message
> > "WARNING: CPU: 28 PID: 211236 at fs/fuse/file.c:1684 tree
> > insert+0xaf/0xc0 [fuse]" when I start podman container.
> > In kernel 5.7 not has such a problem.
>
> Maxim, I suppose you leave `WARN_ON(!wpa->ia.ap.num_pages);` for debug purpose?
> Now this line is often called when I start the container.
>

That odd, but I can't send an email to the author of the commit.
mpatlasov wasn't found at virtuozzo.com.

--
Best Regards,
Mike Gavrilov.
