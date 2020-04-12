Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE721A60D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 00:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgDLW2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Apr 2020 18:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgDLW2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Apr 2020 18:28:51 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF0C0A88B5
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 15:28:51 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t11so7071750ils.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2020 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ANGfUKyG+6xWky2jJ2nWMKG+M8IIxgEacG/h0ycqR20=;
        b=tAqXHlP8pnC0Fae5HqLveAPHChvu5fDrBR9aCpdJ/+VGWLe239sL5EQQWbqaz3R9zk
         EAQUa5NP5nmgrY74n41PftFvtCCNCkmDthGZgO1ECVJSvQ4IMF53VSupjwSpg+7RuiI2
         v8IH811tUAia95Hhy4SCvG+4vNYPYkm/oQwKOCJSYOIjRu3W/kSiUZHWJk1lZ+sCtpCN
         sz3mK9n7qAcYjYqEBtPNGS5pNjUaJMtI1sYKypSgAKOTUQlwM5XiVkmGcy1PN8/Nb7x4
         5Dp2zxa0TXQ+m0aDA5A0d4GXIcPgOuuLePU4s7tZZkslKAfNetsNFpjzQdzBZpgG9Dy/
         XODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANGfUKyG+6xWky2jJ2nWMKG+M8IIxgEacG/h0ycqR20=;
        b=dg9MqwYA22Pa9SWmXbhvt05gbYAfv4750tec7z06D/tvRU3fXrzw/d21cierXRJ14N
         zN2scsYS/RPdD1Sy3uEKuALDgrcOVZB9yQkL86j9uql5m15tQV8yHt1pBAjIly68tYB7
         k4lyP16zgvCQMiw3lRSJlof20IFocUGqbFLn3Uj/UsFyfICqbamOwldoPRuNqrxHNV8W
         ua9+l0+1rkxVTiOiVJ+NQJvnvq9x3yXf6P6FK8lJ5XHXIYNaG4rGtGYLxglyHZWxbAnP
         Wrm9+oJp/nDo8KN2XNyKe3ciPOUtptcYCGVryjbFfj1067JmIyr+EMnoq5+VfReP8tTo
         xFaQ==
X-Gm-Message-State: AGi0PuaNla3t60XywpbN7NNPexKd9kwuW7BDPSX/1ezllKdE4qwnnpWd
        JXijMZ9QpFQRZm2sdIT/7MuOHMQoV0NLrb27NS+Ycg==
X-Google-Smtp-Source: APiQypJO2Sswe5+NMVXMBxFMyLnpwoxty/zztpPW7J2prcZwXcKcdiwPWUFR1BvBQmKAE2/hAJpBzCD4M7x9p/ukihc=
X-Received: by 2002:a92:250e:: with SMTP id l14mr14538847ill.201.1586730530779;
 Sun, 12 Apr 2020 15:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRw_jGxPqWc68Bj-uP_hSrKO0MmShOmtuzGQA2W3WHyCrg@mail.gmail.com>
 <CAOQ4uxhPKR34cXvWfF49z8mTGJm+oP2ibfohsXNdY7tXaOi4RA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhPKR34cXvWfF49z8mTGJm+oP2ibfohsXNdY7tXaOi4RA@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 12 Apr 2020 18:28:13 -0400
Message-ID: <CABV8kRxVA0j2qLkyWx+vULh2DxK2Ef4nPk-zXCikN8XmdBOFgQ@mail.gmail.com>
Subject: Re: Same mountpoint restriction in FICLONE ioctls
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> You did not specify your use case.

My use case is recording (https://rr-project.org/) executions
of containers (which often make heavy use of bind mounts on
the same file system, thus me running into this restriction).
In essence, at relevant read or mmap operations,
rr needs to checkpoint the file that was opened,
in case it later gets deleted or modified.
It always tries to FICLONE the file first,
before deciding heuristically whether to
instead create a copy (if it decides there is a low
likelihood the file will get changed - e.g. because
it's a system file - it may decide to take the chance and
not copy it at the risk of creating a broken recording).
That's often a decent trade-off, but of course it's not
100% perfect.

> The question is: do you *really* need cross mount clone?
> Can you use copy_file_range() instead?

Good question. copy_file_range doesn't quite work
for that initial clone, because we do want it to fail if
cloning doesn't work (so that we can apply the
heuristics). However, you make a good point that
the copy fallback should probably use copy_file_range.
At least that way, if it does decide to copy, the
performance will be better.

It would still be nice for FICLONE to ease this restriction,
since it reduces the chance of the heuristics getting
it wrong and preventing the copy, even if such
a copy would have been cheap.

> Across which filesystems mounts are you trying to clone?

This functionality was written with btrfs in mind, so that's
what I was testing with. The mounts themselves are just
different bindmounts into the same filesystem.

Keno
