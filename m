Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D151C2ABF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgECIov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 04:44:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35021 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgECIov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 04:44:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 376065C0288;
        Sun,  3 May 2020 04:44:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 May 2020 04:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        rWer2zch0gAXDVghugI736C9y6GAGlQEvBqzSynKBrs=; b=wr3hJABdg15h6Wm4
        nL3wpR23XC9XRPH9rP1YiA49ckUwqNd4GNxwUb0NS0SWS7qau84KswR6ir+yiYjV
        19Hf9/ORsBDowNdf4jxAn83TTbYg8Ennk6ELjURL5bpV/lfk9Qk17YN4seLbY95w
        GjtZrQGbPknd4pfFLATT+7ulna8aczUsguec7enY9pFbUVvFByeBuQTeyQGV32QP
        IdjMxyD6vJ8dgZqnd1XZ/3k8dpnDaan3hdvDiJKCnbIWU2/e1IPXnOgjDbuJYL1I
        a6/LCIAtA4gTcCA+CLlCMIYHBiFX9l/+St/+VRsU2Bi1gpv8r4aFXn9riwtLd8wQ
        Ta5fhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=rWer2zch0gAXDVghugI736C9y6GAGlQEvBqzSynKB
        rs=; b=kgLd/Y4xGOWtVhTVFzrWo7AVoy9rWgchykFCodjfyiX4k8HDEL7aUCtYT
        uP3qm+pT0o27CSQHrEXVTB1hwTxjABJI4sMGsAUngEQbc0hVpxY+mqSecT/4AhS0
        aB2ft+8qOPBZiDxutNWtOisJB702K9uZ9amxvs2DY8onWQ9PCGGwsfm8iHPfA+qy
        hvRGO+8/vUziXjkfFeCpvngUzGy/QDbPjlmBLblVlThQBol1K0QdqbXZ/s1NBN14
        WDIuCpiyNyz0FqlJMXTF+7m8Tz4MkWLaUh0scSkcNT5en2ZFjEssjsBJmWqIRFrE
        2AB29lgljYOvIiJmOg4Ji50VDIfAg==
X-ME-Sender: <xms:gYSuXiK09QQI7RwbAJsX8J_pU37yZMmFjtZUsTURaLpXNrQ0BrB_bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedvgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhephfetueeghedutdefteegudfgjefhfedthfehgeegkeejueevieeljedtfeef
    ffehnecukfhppedukeehrdefrdelgedrudelgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:gYSuXsxelANP0-ALuGsGzefY5xSPUP02hpiBUPFZ5q48ze8IhIlboA>
    <xmx:gYSuXnpqvFiyBfOeLaZ__uD9OfF3G3aFNdI9hH_1-qIM7j6-8n6zQA>
    <xmx:gYSuXqU_ynZ1d0p2ZPWR33fLCMAdD-f5brsAkA_xz2wVYlKOvwwUQw>
    <xmx:goSuXpGb6y9RdADjbhGPXlU3z5cCbtCG1zHOHH4kV198aEbV8Ww6-Q>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B5E0328005D;
        Sun,  3 May 2020 04:44:49 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 2AF56B4;
        Sun,  3 May 2020 08:44:48 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id A0922E012A; Sun,  3 May 2020 09:43:41 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
        <20200503032613.GE29705@bombadil.infradead.org>
Mail-Copies-To: never
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
        miklos <mszeredi@redhat.com>, Gabriel Krisman Bertazi
        <krisman@collabora.com>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@collabora.com>
Date:   Sun, 03 May 2020 09:43:41 +0100
In-Reply-To: <20200503032613.GE29705@bombadil.infradead.org> (Matthew Wilcox's
        message of "Sat, 2 May 2020 20:26:13 -0700")
Message-ID: <87368hz9vm.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 02 2020, Matthew Wilcox <willy@infradead.org> wrote:
> On Sat, May 02, 2020 at 08:52:48PM +0100, Nikolaus Rath wrote:
>> On May 02 2020, Nikolaus Rath <Nikolaus@rath.org> wrote:
>> > I have recently noticed that a FUSE filesystem regularly produces many
>> > kernel messages like this:
>> >
>> > [ 2333.009931] fuse: trying to steal weird page
>> > [ 2333.009937] fuse: page=3D00000000dd1750e3 index=3D2022240 flags=3D1=
7ffffc0000097, count=3D1,
>> > mapcount=3D0, mapping=3D00000000125079ad
> ...
>> > What are the implications of the above kernel message? Is there a way =
to
>> > provide more debugging information?
>
> It'd be helpful to use the common debugging infrastructure which prints
> more useful information:
>
> +++ b/fs/fuse/dev.c
> @@ -772,8 +772,7 @@ static int fuse_check_page(struct page *page)
>                1 << PG_lru |
>                1 << PG_active |
>                1 << PG_reclaim))) {
> -               pr_warn("trying to steal weird page\n");
> -               pr_warn("  page=3D%p index=3D%li flags=3D%08lx, count=3D%=
i, mapcount=3D%i, mapping=3D%p\n", page, page->index, page->flags, page_cou=
nt(page), page_mapcount(page), page->mapping);
> +               dump_page(page, "fuse: trying to steal weird page");
>                 return 1;
>         }
>         return 0;
>
> (whitespace damaged; if you can't make the equivalent change, let me
> know and I'll send you a real patch)

Here's what I got:

[  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0xd9
[  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 0000=
000000000000
[  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff ffff=
9aec11beb000
[  221.277272] page dumped because: fuse: trying to steal weird page
[  221.277273] page->mem_cgroup:ffff9aec11beb000
[  221.601910] page:ffffec4bbd4b2dc0 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x1273
[  221.601915] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  221.601919] raw: 0017ffffc0000097 ffffec4bbd51f488 ffffec4bbd4b2d48 0000=
000000000000
[  221.601921] raw: 0000000000001273 0000000000000000 00000001ffffffff ffff=
9aec11beb000
[  221.601922] page dumped because: fuse: trying to steal weird page
[  221.601923] page->mem_cgroup:ffff9aec11beb000
[  221.958699] page:ffffec4bbd424d80 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x38be
[  221.958703] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  221.958707] raw: 0017ffffc0000097 ffffec4bbd424048 ffffec4bbd424d48 0000=
000000000000
[  221.958709] raw: 00000000000038be 0000000000000000 00000001ffffffff ffff=
9aec11beb000
[  221.958710] page dumped because: fuse: trying to steal weird page
[  221.958711] page->mem_cgroup:ffff9aec11beb000



Best,
-Nikolaus
--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
