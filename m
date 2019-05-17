Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14DA21427
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 09:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfEQHZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 03:25:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35564 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfEQHZe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 03:25:34 -0400
Received: by mail-io1-f67.google.com with SMTP id p2so4736550iol.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ye8jut5rxl+0GMAFKnOCRncXMpbDpjVXA4oZoWpQTz4=;
        b=cmGbh+cPPNLCmAlgZhq/+G+m3XSej85ipZrbMM2pPPU+o0yz9wqWOJi7eTugqWc6wa
         sgoENPX5qH8QvfdTnflHyrnJvufBJsRP7ONNs/KcO5CdIP2SMuRL2Qn2H4ZGf50wOzry
         ATRX+rPNcBtuRzhbc6X69QL6pcTkVMNEt8wYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ye8jut5rxl+0GMAFKnOCRncXMpbDpjVXA4oZoWpQTz4=;
        b=UIMnDA8/Vrkml25hNLjA72tMcHhUxGO016nJKnBTIhZNytF/JqL1Ey9jTL+Yhs1M0O
         q80aWHCo0A8vXyVSIKMAEDMGFktRjg1o+G3ujMervkSBCYGLd1WRctedSJlooXDqPd2X
         5B1JpTLgBmJe/rth9TpkAta8WMeeNK0u/JG7CBinVMa9clUr7JGjAyNth7JkmCe2y4xn
         vQXbRyxhmaorTRmfgonCfOGpravdd2C4LcE8dkmHeHOhUerkgp71buz/KLcvSHN/fq0p
         2Gh7Jc9hzvypRcsAHSOzZrsKtxnaShxfE/R/HntIqxzeDIWALxmS48jjnTKtuUQtAiG/
         KoDQ==
X-Gm-Message-State: APjAAAW0c/l+4ckky6xmwcGpEytGxj4iJYjvuYWl4OtzRgtU3kBmWlg6
        8cXKNvWO10v7wxKB2c2YXNFFkoPBDWC+XvFAdlr2d4Md
X-Google-Smtp-Source: APXvYqxbPOP1gx8Ygd75lZfjIpUpVr7rERQI1OIKXqdBNgYpv1NoZlovKiQv3HkEZyevwO1u9eqOylMgDR79rsTBWa8=
X-Received: by 2002:a5d:9f11:: with SMTP id q17mr7323652iot.212.1558077933370;
 Fri, 17 May 2019 00:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io>
 <20190516165021.GD17978@ZenIV.linux.org.uk> <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io>
 <11455.1558077206@warthog.procyon.org.uk>
In-Reply-To: <11455.1558077206@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 May 2019 09:25:21 +0200
Message-ID: <CAJfpegu0Ckc9tvuPKGtf1mrfj3mLmgw_gcJER9yyRLre4iwZiw@mail.gmail.com>
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 9:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Christian Brauner <christian@brauner.io> wrote:
>
> > If you still prefer to have cloexec flags
> > for the 4 new syscalls then yes,
> > if they could at least all have the same name
> > (FSMOUNT_CLOEXEC?) that would be good.
>
> They don't all have the same value (see OPEN_TREE_CLOEXEC).
>
> Note that I also don't want to blindly #define them to O_CLOEXEC because it's
> not necessarily the same value on all arches.  Currently it can be 02000000,
> 010000000 or 0x400000 for instance, which means that if it's sharing a mask
> with other flags, at least three bits have to be reserved for it or we have to
> have arch-dependent bit juggling.
>
> One thing I like about your approach of just making them O_CLOEXEC by default
> and removing the constants is that it avoids this mess entirely.

+1.

Confusion caused by inconsistency of naming is going to hurt more than
inconsistency of semantics wrt. open(2).

Thanks,
Miklos
