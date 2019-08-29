Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E11A1BA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfH2Nlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:41:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42667 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2Nlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:41:39 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so4986594iod.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ul0ttpZX8OaU+EBmALZ96xYYyCTstLYpC4GnYFarZNw=;
        b=BdfA7qONrUsx4A59nrxQQRxyjZMRkrGbqIPEVHms5IqmXTPPwE1mOuiPUmLjh3idfb
         qaC5Ifvf8wMelanxFTmnu/IIA21Q8dVP2kH44Urk3sHVXB1taDT3p9kO0Bf0wtJn8NPb
         33QKwni3K68F/+upvxd3jimKoGWOkSBUfSxu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ul0ttpZX8OaU+EBmALZ96xYYyCTstLYpC4GnYFarZNw=;
        b=M7/OFThtDQsffITk1z634ZPtuna5+0pKPTWE5SyF7dmBeYMsounTPT4WqW1DrXWmGx
         dULLOFKgWpprL/pwN7yMALk9y5IAIZ3Dgy0riTJXmBhLDWyquLV6t1tX0GFQNpuJPdXT
         AEytYbS2Rl7osK9wwlJpNOVqZ5SrKLRvz0dPihSOk6wAyT/JVkOBst1XF3k4ORTiZCkb
         MitHrOF+G5VDKIYn8H3b2+g89GA6zc1eVCAfufKNNHDScpDxGfraYfAwEHVCQwM1UGOG
         gc9Lh6zry1z34+HUO6wDztxNFpxtvPfcCC5bC6r8thm9d5Bz+Vjkxqlik9JXGbTsBteH
         Hymg==
X-Gm-Message-State: APjAAAVzVpTED+sx5MnH26WTWUT5oEhvaRRDZF+bg1xZj425vfO6cwXa
        3lBY7m3CHIlIxBbH1Bp3Umeqr4yjYSb4Z3kB9ama7g==
X-Google-Smtp-Source: APXvYqxfpG+jMqi5qihZJi9IHh9FiDX9js/5q0ycE73tZwZBFFnEG8Lz+l/93G/VZExz+enUcOKKN0q3BCm8e/kHvME=
X-Received: by 2002:a5e:aa03:: with SMTP id s3mr3381601ioe.212.1567086099021;
 Thu, 29 Aug 2019 06:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com> <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829132949.GA6744@redhat.com>
In-Reply-To: <20190829132949.GA6744@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 15:41:26 +0200
Message-ID: <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> #ifdef CONFIG_VIRTIO_FS
>         /** virtio-fs's physically contiguous buffer for in and out args */
>         void *argbuf;
> #endif
>
> It should have worked. Not sure why it is not working.

Needs to be changed to

#if IS_ENABLED(CONFIG_VIRTIO_FS)

Pushed out fixed version.

Thanks,
Miklos
