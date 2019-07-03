Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1005DDDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfGCGAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 02:00:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:53781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfGCGAi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562133598;
        bh=S/DY2NTWdLYKO31PXPrp7YFpwyl+FDIxqIxLbaqbSR0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aanwjmWRAxHxx9WnAb9FVTY9ZyprnbMtIqZvw8g5dgQ6iuseMOmy0OW8hyl2ifKnV
         bBbvH6ZLgsj5flXNgNC7HZE8HE1RwyUGpltqg+CnE9n0G2CgADAtkzgZGfDHae+3Ny
         8Q+z7vY5Muv3qROEw7xlZmbt+OrGyejU2I9LE81I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from t460-skr.localnet ([194.94.224.254]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBmvH-1hr6td36D1-00ApIX; Wed, 03
 Jul 2019 07:59:58 +0200
From:   Stefan K <shadow_7@gmx.net>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong " <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
Date:   Wed, 03 Jul 2019 07:59:55 +0200
Message-ID: <1728507.XaAQIF6Bjd@t460-skr>
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:/gfEe+LZYgoqhk9YZ5m0893Kp2AyaRuZAI87SN9HVLgLmzlIOfL
 612WiSLxeeX/VjMW7cqE9kmrGPAbbKqmQRM9ayTjosrSKLDNrC1ALPO94jZzp8738vFYp2k
 jGR/hP2xpOcw3jFCPQzdLOjcxsGbjm56J0hxUQKsq8kou/6xcADDNK6dug3GBSKFK/SQk57
 SikMXSCQ9qitwSLLgZUyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cu8rqFBtn8Y=:6/+ByFTuR2gkkd9oqZx2ai
 HZfhRFZNI8BDn7S/kp6+sHSwM5/cSWY9BSVMZV21oivcoRWnFGD9YFmc673Lvt9oMiMyo1y1R
 yP8UcOSCLnDmPGLfg1VgsB5D8tQfyxN94DtojVGLnKCxHxlv8l4lmdPz6S3S7UMBu56Gpwqk0
 dF5Maowi3G2swaLD3WS7/ZLi/vBi/hC1ORKc1Nx99+1CO7DjIgeEdJocHoyjZ0ZnbkgmvKFtN
 4fIIfu7MrMTC8Q9N0xGIhPTy7mZBEsGpYrtsmeQqnyow3lu5e4y6xxAlpLG8ER4A+6+Gj7nZ9
 ydjuOCosZnabC6J05ECQ9c6nSnhF71E6Wejv8CKHqxAGqvkssJ2OAJoBCB6aQGxu/CTcYBAP9
 mSjUVVyHq/hDKiDg3zoXBiHvEr2i67n0i3LYY1Uk5igq36JnVJDADxQ+VrYIgR28rpQ3sDVrn
 LFs5QeNLVZtVbZN0zBgS+dYhsx+S+2R2VZLrfLiH5aAkXT7H06/uvmVlTIHqtMyr97yHjpdUQ
 21M2EdHoXdVvZstn8EfYpjIja2G/TmIpenof9jKZ2nkOh5ARHs/BdNzJ4DMTq12EZyewTmgGU
 ncvY/ewo/uUbXIXiVbp3dvwVBIbd7PGFLa0R9GU91vHCIw/Qm4LohLygwtmhm+vkkBG101fZ0
 4Ir4yMF88YUjfw07NzyGp8Jxf0Fg82fPg7GMxE4EQcPmXLA/GNI4yknnFf2AEvcQHfhsCNT7I
 r206trlfqWZ6jRNhAcTHZKCt4iwNKU7g0ml9F3A3JYX1es4+cEPKGM2jvE6yrqyav91kvX0IF
 Fvmm2TZAf5UVUHK/TimL1Z4ayfot0tnVzYcIa4GLDI/qpWjSg3TX05xyDlUY58iEOl6vnLZLb
 HyV1vFEVHagQ6Azj97uSQPc7wyN39EiFgAvzrfxpkaL8t0j4QNzEN2rYgvsss731GdBlht2Zv
 zQeEBBYV7lz5rsFmjM3aLIVE2bAtDkNT1PMynjvngyYGoJeqy+okMnWiIHyIA4oc7oBxD0O6Y
 oRDIomn75mx0LruxBBLf/JaDGhBw+v+U4wYhvjJo1Pf0Go05vBfZ2E3RUfM+SW3yRJc6zCEsv
 dNPDXlJMLxUrBs=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

is there a chance to get this in Kernel 5.3?
And thanks for this fs!


On Monday, June 10, 2019 9:14:08 PM CEST Kent Overstreet wrote:
> Last status update: https://lkml.org/lkml/2018/12/2/46
>
> Current status - I'm pretty much running out of things to polish and exc=
uses to
> keep tinkering. The core featureset is _done_ and the list of known outs=
tanding
> bugs is getting to be short and unexciting. The next big things on my to=
do list
> are finishing erasure coding and reflink, but there's no reason for merg=
ing to
> wait on those.
>
> So. Here's my bcachefs-for-review branch - this has the minimal set of p=
atches
> outside of fs/bcachefs/. My master branch has some performance optimizat=
ions for
> the core buffered IO paths, but those are fairly tricky and invasive so =
I want
> to hold off on those for now - this branch is intended to be more or les=
s
> suitable for merging as is.
>
> https://evilpiepirate.org/git/bcachefs.git/log/?h=3Dbcachefs-for-review
>
> The list of non bcachefs patches is:
>
> closures: fix a race on wakeup from closure_sync
> closures: closure_wait_event()
> bcache: move closures to lib/
> bcache: optimize continue_at_nobarrier()
> block: Add some exports for bcachefs
> Propagate gfp_t when allocating pte entries from __vmalloc
> fs: factor out d_mark_tmpfile()
> fs: insert_inode_locked2()
> mm: export find_get_pages()
> mm: pagecache add lock
> locking: SIX locks (shared/intent/exclusive)
> Compiler Attributes: add __flatten
>
> Most of the patches are pretty small, of the ones that aren't:
>
>  - SIX locks have already been discussed, and seem to be pretty uncontro=
versial.
>
>  - pagecache add lock: it's kind of ugly, but necessary to rigorously pr=
event
>    page cache inconsistencies with dio and other operations, in particul=
ar
>    racing vs. page faults - honestly, it's criminal that we still don't =
have a
>    mechanism in the kernel to address this, other filesystems are suscep=
tible to
>    these kinds of bugs too.
>
>    My patch is intentionally ugly in the hopes that someone else will co=
me up
>    with a magical elegant solution, but in the meantime it's an "it's ug=
ly but
>    it works" sort of thing, and I suspect in real world scenarios it's g=
oing to
>    beat any kind of range locking performance wise, which is the only
>    alternative I've heard discussed.
>
>  - Propaget gfp_t from __vmalloc() - bcachefs needs __vmalloc() to respe=
ct
>    GFP_NOFS, that's all that is.
>
>  - and, moving closures out of drivers/md/bcache to lib/.
>
> The rest of the tree is 62k lines of code in fs/bcachefs. So, I obviousl=
y won't
> be mailing out all of that as patches, but if any code reviewers have
> suggestions on what would make that go easier go ahead and speak up. The=
 last
> time I was mailing things out for review the main thing that came up was=
 ioctls,
> but the ioctl interface hasn't really changed since then. I'm pretty con=
fident
> in the on disk format stuff, which was the other thing that was mentione=
d.
>
> ----------
>
> This has been a monumental effort over a lot of years, and I'm _really_ =
happy
> with how it's turned out. I'm excited to finally unleash this upon the w=
orld.
>



