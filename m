Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29764A7179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfICRPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 13:15:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbfICRPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:15:24 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07ACC36887
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 17:15:24 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id 11so8015238qkh.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 10:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6tGfYo/dTj24n3kyKLuufR3DdwgMhB7RVSFb+mWOVs=;
        b=ZoDWXdzbybSCrmd41wEvLj+BhNSpHiFA7h7en2onI6jy2G4SucfmJ7i7a9LIIRavHY
         UTsotcrs3YG9boBm1dHMWgu8c7JZABKzOWxyAi9YiNcEyrnQWf5sbBpznz69ZuNwZ88g
         Yd4j0YpXk3D3YaLSxjKjiS6LZY2fLQDbI5/sk6R8aTs31IKSu20lj1krtJFWkyZRaNyK
         JayrNWH0SWabWNLQKVuh52p35A7xrygT6DB+HQnZoV237SlGalIooueFUhiMZqW4YPTV
         xQT7n8drQkTqXjeRoqvYtvSZxL3w3Rz35GeRtyMeC5w4+cfXeXlgDsEL6e9VT53GvLzx
         NTaA==
X-Gm-Message-State: APjAAAWObppTnuGYh9nC5WMegzznfnSUpi/A8SUEqJ8MWNTTNBlQqQN3
        5zZgkfdEZqKvX59+NA5q+4ZzkE/HUaIkLj6Kr4FWplaBGxYRHRrlXr966nnXvvPgZ0ZupFL+EHd
        g0xP7oQkOfPQtZPY6MaSucRik6A==
X-Received: by 2002:a05:620a:15cc:: with SMTP id o12mr12890165qkm.140.1567530923144;
        Tue, 03 Sep 2019 10:15:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTXnMlZHpGHJ4mdlNJD+IRREku2Hx5W9v7Fh85/S/pmi7c/BEoxrqFXUQUyWjzlWCWQwErAg==
X-Received: by 2002:a05:620a:15cc:: with SMTP id o12mr12890124qkm.140.1567530922908;
        Tue, 03 Sep 2019 10:15:22 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id t2sm8561495qkm.34.2019.09.03.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:15:21 -0700 (PDT)
Date:   Tue, 3 Sep 2019 13:15:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903111628-mutt-send-email-mst@kernel.org>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
 <20190903140752.GA10983@redhat.com>
 <20190903101001-mutt-send-email-mst@kernel.org>
 <20190903141851.GC10983@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903141851.GC10983@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:18:51AM -0400, Vivek Goyal wrote:
> On Tue, Sep 03, 2019 at 10:12:16AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 03, 2019 at 10:07:52AM -0400, Vivek Goyal wrote:
> > > On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > [..]
> > > > +	/* TODO lock */
> > > > give me pause.
> > > > 
> > > > Cleanup generally seems broken to me - what pauses the FS
> > > 
> > > I am looking into device removal aspect of it now. Thinking of adding
> > > a reference count to virtiofs device and possibly also a bit flag to
> > > indicate if device is still alive. That way, we should be able to cleanup
> > > device more gracefully.
> > 
> > Generally, the way to cleanup things is to first disconnect device from
> > linux so linux won't send new requests, wait for old ones to finish.
> 
> I was thinking of following.
> 
> - Set a flag on device to indicate device is dead and not queue new
>   requests. Device removal call can set this flag.
> 
> - Return errors when fs code tries to queue new request.
> 
> - Drop device creation reference in device removal path. If device is
>   mounted at the time of removal, that reference will still be active
>   and device state will not be cleaned up in kernel yet.
> 
> - User unmounts the fs, and that will drop last reference to device and
>   will lead to cleanup of in kernel state of the device.
> 
> Does that sound reasonable.
> 
> Vivek

Just we aware of the fact that virtio device, all vqs etc
will be gone by the time remove returns.


-- 
MST
