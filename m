Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC38979B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 09:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfHLHNy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 03:13:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61302 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfHLHNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:13:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17964774-1500050 
        for multiple; Mon, 12 Aug 2019 08:13:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190812071148.GA696@tigerII.localdomain>
Cc:     intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
 <20190812071148.GA696@tigerII.localdomain>
Message-ID: <156559400671.2301.14424611837808765850@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
Date:   Mon, 12 Aug 2019 08:13:26 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-12 08:11:48)
> On (08/08/19 18:22), Chris Wilson wrote:
> [..]
> > @@ -20,31 +20,18 @@ int i915_gemfs_init(struct drm_i915_private *i915)
> >       if (!type)
> >               return -ENODEV;
> [..]
> > +     gemfs = kern_mount(type);
> > +     if (IS_ERR(gemfs))
> > +             return PTR_ERR(gemfs);
> >  
> >       i915->mm.gemfs = gemfs;
> 
> We still have to put_filesystem(). Right?

Yes. We still your patches for EXPORT_SYMBOL.
-Chris
