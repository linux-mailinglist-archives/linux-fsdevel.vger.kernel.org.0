Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EADB2D44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 01:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfINW5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 18:57:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36217 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfINW5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 18:57:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so2719361ljj.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZpQhEuh6L2pfQ8njEOskG9zeP41laARuURIBcccsIc=;
        b=hxnZlcuK9MzAjTT1c1dw0LrlkLaGHVDdpgajTr5+NdiehOxUDLWAGovMyUCmTrJNMn
         xB4MQsFduk3m0NzCqWrBtZ/PECwOgivH3oL7on0vNUFcTU8fq+wj0UCKbaJIzZp9ZzVJ
         2ru5oVZGGI7Tr8qjce3Mdq/++gZtZ3zupP114=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZpQhEuh6L2pfQ8njEOskG9zeP41laARuURIBcccsIc=;
        b=ZVZbxh59kl7S8yRCEjeYw9qnlnHdelQ5+T8lsWKpvOgZF3Xe8FkjhufGGvHodbwGjv
         G0tZtm10sJnCwQBtnXJyAziTDDl4sNm31tYSdoB8qcpQ9juBAzAUJa5QmGhErKgh8N/G
         kX8eKcSsjLf8epFM3uapJc/y84+B5rusXFIiBr6/ory4YT1YLFTNaDa6yJaucRaVxwFU
         YKu0kfqV0QZslVJLyVj6erTFN3zOo+lAN5+/GfqfyXJO7JyO2J6uOn/8aq+0Jy/zbI0u
         IVuorwu6xbYRH1wELrA8iTOoFXHDIv4c+3svLGUJB8bUqFKqgssROx/0dZ5dqczJ7dTw
         1hGQ==
X-Gm-Message-State: APjAAAV8lWAL078X28tbXPOBBfN7cMnTHat3e8b+H8STjRRPyRFBwv5+
        RxzBOW89G5EsXafMYM1Nue/Y31KRxmM=
X-Google-Smtp-Source: APXvYqzQx8GRB8EKOYBCCk1TjQ316kyOlM1GoNNAPG2ub8HIvOHx0BcBdBuFCxYTzp1V57eucFUzsw==
X-Received: by 2002:a2e:5714:: with SMTP id l20mr33689802ljb.122.1568501853319;
        Sat, 14 Sep 2019 15:57:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c4sm7850726lfm.4.2019.09.14.15.57.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 15:57:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w67so24651252lff.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 15:57:31 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr12339437lfm.170.1568501851230;
 Sat, 14 Sep 2019 15:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com> <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com> <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk> <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
In-Reply-To: <20190914200412.GU1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 15:57:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
Message-ID: <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 1:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> An obvious approach would be to have them sit in the lists hanging off
> dentries, with pointer to dentry in the cursor itself.  It's not hard
> to do, with "move" costing O(#Cursors(dentry1)) and everything else
> being O(1), but I hate adding a pointer to each struct dentry, when
> it's completely useless for most of the filesystems *and* NULL for
> most of dentries on dcache_readdir()-using one.

Yeah, no, I think we should just do the straightforward proper locking
for now, and see if anything even cares.

Last time I think it was a microbenchmark that showed a regression,
not necessarily even a real load (reaim), and there wasn't a _ton_ of
debugging on exactly what triggered the higher system time. It was
also on a fairly unusual system that would show the lock contention
much more than 99+% of anything else.

So I suspect we might have other avenues of improvement than just the
cursor thing. Yes, it would be absolutely lovely to not have the
cursor, and avoid the resulting growth of the dentry child list, which
then makes everything else much more expensive.

But it is also possible that we could avoid some of that O(n**2)
behavior by simply not adding the corsor to the end of the dentry
child list at all. Right now your patch *always* sets the cursor at a
valid point - even if it's at the end of the directory. But we could
skip the "end of the directory" case entirely and just set a flag in
the file for "at eof" instead.

That way the cursor at least wouldn't exist for the common cases when
we return to user space (at the beginning of the readdir and at the
end). Which might make the cursors simply not be quite as common, even
when you have a _lot_ of concurrent readdir() users.

There may be other similar things we could do to minimize the pressure
on the parent dentry lock. For example, maybe we could insert a cursor
only _between_ readdir() calls, but then in the readdir() loop itself,
we know we hold the inode lock shared for the directory, so during
_that_ loop we can use the existing positive dentries that we keep a
refcount to as cursors.

Because if the only reason to not use existing dentry pointers as
cursors is the concurrent rename() issue, then _that_ is certainly
something that the parent inode shared lock should protect against,
even if the child dentry list can change in other ways).

So if the main 'reaim' problem was that the dentry child list itself
grew due to the cursor pressure (and that is likely) and that in turn
then caused the O(n**2) bad locking behavior due to having to walk
much longer dentry child chains, then I suspect that we can do a few
tweaks to simply not make that happen in practice.

Yes, I realize that I'm handwaving a bit on the two above suggestions,
but don't you think that sounds doable?

            Linus
