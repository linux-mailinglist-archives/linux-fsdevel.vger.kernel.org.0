Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6412FF19
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 00:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgACX2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 18:28:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44606 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgACX2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:28:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so60470489otj.11;
        Fri, 03 Jan 2020 15:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HgqJfy4S3bqmD5nD3+IHTYjooC/9GfV6lr9+njhwvjQ=;
        b=THcf7ergVWWJb9dKDvoXaGic/JCwtojym5nwlQy4LZPARdKPvDCzgfds8VNuLbeoiZ
         BpHax/8af57wHU86mp/Rqz5hPaZLsZ/saykUWBxe4l2PNfmbaGJAMUwRzS6oo+J6FVGD
         EB2sUVQfu5wyOxjNeQVAOjIslBwqlZ11MM1W2hJMFZCGXOIz8bIg9VKjtof3ymUboqQx
         r7dDz1mOKPU7l8/EYJW3kbIaIC0AyQUIq7/4eAhNVehapxvlmuqWgzMRe4tq3MBBza0/
         A1K8mjYQ7zJ0pmYYRekRK3vsNv9Herh+4EE9zszgc9UBDXehBJnwA9WDTSHPS6d6IHig
         OmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HgqJfy4S3bqmD5nD3+IHTYjooC/9GfV6lr9+njhwvjQ=;
        b=Q8qVGTNKGvdFu2gd+CBEbMn4bGlKDtLTKq52Z1uL5zJINJJUSGywJLVDBQGwPcuOul
         GtMJLYaBo1k3Qt8zcrxdBVLg7TRcc/H12T+32/FNpvr3BRKGruFGHqBZFwo5D4DfSVuU
         VNTTX4jDzAzSOAskTS9WpHF2aHZj/enekSA54l4f1RZiDUrk771gIHstwhPVg6qPb6To
         bzA5z97VdzXjGLoEuEQDnM00ddpwJQW9ENX9IqxkcxwJW6bpI4FGTe9X8mJBLgELKMNn
         szR2Q/PXnMHcnmX0nJO30XSzp5mpDUXBQvdc2Wd7C5sBQ0Y59H0qlqKMIoa+C1hh9+Qb
         PuJg==
X-Gm-Message-State: APjAAAW6+vd9hAq/zFgNQDV2/PRdqyP6EWf0QOOxzFVWuObMGmaxpKKx
        7WWLqfMRewiebgp+6SO/UVkZVoDyk/Uhema7/MEx1w==
X-Google-Smtp-Source: APXvYqzW3zOUbakHy9OZfTK4ocheF0qElAUZ78tednBzyqAMb9keW/IknW1qV3au7WvOdOPOf8q8jlFPpfmIWBbHlIk=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr27466841otq.120.1578094110254;
 Fri, 03 Jan 2020 15:28:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Fri, 3 Jan 2020 15:28:29 -0800 (PST)
In-Reply-To: <20200103183604.xzfvnu2qivqnqkkx@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082406epcas1p268f260d90213bdaabee25a7518f86625@epcas1p2.samsung.com>
 <20200102082036.29643-10-namjae.jeon@samsung.com> <20200102091902.tk374bxohvj33prz@pali>
 <CAKYAXd_9XOWtcLYk-+gg636rFCYjLgHzrP5orR3XjXGMpTKWLA@mail.gmail.com>
 <20200102114034.bjezqs45xecz4atd@pali> <20200103183604.xzfvnu2qivqnqkkx@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Sat, 4 Jan 2020 08:28:29 +0900
Message-ID: <CAKYAXd8PBdTv-no7sp13L25dB=rhE+sKff-b92Yg9fZmocyoMQ@mail.gmail.com>
Subject: Re: [PATCH v9 09/13] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Also I think that you should apply this Arnd's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D44f6b40c225eb8e82eba8fd96d8f3fb843bc5a09
Okay:)
>
> And maybe it is a good idea to look at applied staging patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/staging/exfat
I will check them.

Thanks a lot!
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
>
