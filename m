Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB0BDD92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405184AbfIYMAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 08:00:00 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39419 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389932AbfIYL77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:59:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id n11so1900153ywn.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gB/Mpmzw04vdh4Grpk8wkJgP2t28rwM7GudBbJELUO4=;
        b=QQq5D1Goxsu3vgmj5zuiTnU6b9nBrdhfXSG1M9UG1kU1qRQstFSTQGd/PDO0wtFuW5
         0m6vpRQGoLBYn2GfampXyA82E3gzW0gAnkXsfqIGpXGpNp933gVyZ2GjOUEm6441OVyy
         Ym5zkg+Q8TpUqMxSVJIQyAgEpjXZ24qHQC6a8o55ulLkESO7yNRcOsEo2iSi7fcOsILR
         Bd4ccPVPRwpn+gFS7QkPYQ/fI2TV5W0x2K0Qsp+28LTADMN2XgDK5GmcTOu+gmLFHreu
         uhMOwDDbNls6Sq5r/WfIa+H8x1htdXdjHya+kPc9IoziABxjY0YXWwSUGnDuKrilE0H8
         iygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gB/Mpmzw04vdh4Grpk8wkJgP2t28rwM7GudBbJELUO4=;
        b=QHEuloS5CLhmxp6caTLkd669t13cOuf0bg1X2fvOsgYv2lHauMdjadhkL4jhu4tIT0
         a5JGixHXtqw6U8Kep6CycXxb1joX/B7LHYTzYl2B04a0ORj8MU9V06lriXaQ3RWyhDZH
         Vi6yFRA9TJ0gTB+wapFDCD4wwKA8/4DjfMfTyoK+B0GNRjitsVxhWlf7lWsn44sANDjR
         6ZNxG26uLl3PHtcQ/SvQyzABIP3gCg0+Lek3WB88lYou+Q9NoQER6nCGpE6acUpmt7uH
         xjl2A6NdVeIkY+5p6y1IqKXnHhVBkM1rkRc32867GOai1EaUGb3noN/9J2KncdZe07Yd
         31gg==
X-Gm-Message-State: APjAAAWuT8+/JYYII0tlLjtR5F+RoOg0yT8Run+2arZxi8VwHFDxhjsj
        RHVYXdrcZagaeIRSbnYgyjhAomIlGQs4GskHkxs=
X-Google-Smtp-Source: APXvYqxfrYLeiPVRtlrCvaLScgRPVGNgbqqQB157v0Ezuz7mHSpk2dgL3A7IOMGYmUYm4Dhllc65MMMzw8Tp1K4cieY=
X-Received: by 2002:a81:ef09:: with SMTP id o9mr5545566ywm.31.1569412798684;
 Wed, 25 Sep 2019 04:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190914161622.GS1131@ZenIV.linux.org.uk> <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk> <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk> <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
In-Reply-To: <20190921140731.GQ1131@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Sep 2019 14:59:47 +0300
Message-ID: <CAOQ4uxh-FH7JZP9fVqHXYJkbLA+NK6fX7HQex-XwY0Sha-R_kw@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 5:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, #next.dcache has the straight conversion to hlist.

Note that this:
@@ -108,8 +108,8 @@ struct dentry {
                struct list_head d_lru;         /* LRU list */
                wait_queue_head_t *d_wait;      /* in-lookup ones only */
        };
-       struct list_head d_child;       /* child of parent list */
-       struct list_head d_subdirs;     /* our children */
+       struct hlist_node d_sibling;    /* child of parent list */
+       struct hlist_head d_children;   /* our children */

Changes the 'standard' struct dentry size from 192 to 184.

Does that matter for cache line alignment?

Should struct dentry be ____cacheline_aligned?

Thanks,
Amir.
