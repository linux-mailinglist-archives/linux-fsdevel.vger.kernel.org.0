Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3671C2F37
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgECU0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 16:26:31 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38315 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729081AbgECU0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 16:26:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 224915C01A6;
        Sun,  3 May 2020 16:26:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 03 May 2020 16:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        d+DB4v39hyIt+FyuonR/deUrTlvZniSX5AH4k80+piw=; b=ge4XmSkRoJHYn9+y
        3/rB4n9JIK9YwwIhlRkgZUSPkchPaqMdNOalcgrSFHcheva5h8GmhaE8S1kb8Obv
        M0fkzcvPxI2UVjvokONhXOGxz7OcYM8/a4ozzTz+96w6ETFIjuwLy68WUWuHaDVu
        t/9QqEo1ug3iuO0dnvQ1zRUYXzkoLfVU+u9rfwdaWPPuZQXxS8eTfo1XDl4+XSqg
        N8j0Oa7o6/R8al8DKAj6Anmbnbb/aWSEgV+vt7sLf3bU6c7qtvV0CYdb+dHMVocZ
        Oru8oQSEz/zsNpk3niu9BZESgunQSIe8S3yb9HeXleOlAep0GAbE6Z/fPs0oYK7O
        r6b2pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=d+DB4v39hyIt+FyuonR/deUrTlvZniSX5AH4k80+p
        iw=; b=rQUCwxelWwjiRw0UgdS3TzQmiItFWWufR5bhE/cp9VrXa4We2xteGx/V6
        ZsY2YjMDc3PT/UICakfnt0TCd0zQhvf/813KnqPQSjVyoI7C+MZHG4ZC4gaxMSwm
        2KJstffImHUDsaU5h8dfQCqcg7RXZ4w2d/uao+erpOVMJqbipP8tBhN3iZwNSlHn
        KuZzBnj5rOS7VM2nLoyXATEUKVoiHMeue24g1VfkOdZ6DJKXYIgHUysX/A1DY9x1
        Co0E+kvAFIi5wnrCwz4ARm9Znwpr3BguqyOatb4el82OiPnAheeFXBpEgYxjjq1F
        GQrCBx3d6Wo+CVx3PXDroIBpL3I0w==
X-ME-Sender: <xms:7yivXtcAl4SEYEYdxTI9EtT9OpaB5iHYJOWTm4aw29SuswAqHZMjXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjedvgddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpefhteeugeehuddtfeetgedugfejhfeftdfhheeggeekjeeuveeileejtdef
    feffheenucfkphepudekhedrfedrleegrdduleegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:7yivXm28YVRE3dSvAkMfuzRFGJQL0X2T4cf_Qj6cO54ekc10-C1uSQ>
    <xmx:7yivXg-fRZJCmhSrC5jYE2vKR4HBw3S_pVJRs-bKVFNf4B7IwDOSxg>
    <xmx:7yivXk1Mz9srFiQP-kLeNTxUM6Q72-1Doul_Sxd48ayt_GYD_SG4Hg>
    <xmx:9SivXmyobrooMKg-ubjL44tVFLzV80Ac0Hj8xWqAEMpciSnCJsBj6g>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9A8C328005D;
        Sun,  3 May 2020 16:26:23 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id C3F4411;
        Sun,  3 May 2020 20:26:22 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 90463E012A; Sun,  3 May 2020 21:25:16 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        =?utf-8?Q?Andr?= =?utf-8?Q?=C3=A9?= Almeida 
        <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
        <20200503032613.GE29705@bombadil.infradead.org>
        <87368hz9vm.fsf@vostro.rath.org>
        <20200503102742.GF29705@bombadil.infradead.org>
        <85d07kkh4d.fsf@collabora.com>
Mail-Copies-To: never
Mail-Followup-To: Gabriel Krisman Bertazi <krisman@collabora.com>, Matthew
        Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>, linux-mm
        <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>, =?utf-8?Q?Andr=C3=A9?=
 Almeida
        <andrealmeid@collabora.com>
Date:   Sun, 03 May 2020 21:25:16 +0100
In-Reply-To: <85d07kkh4d.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Sun, 03 May 2020 14:28:34 -0400")
Message-ID: <87zhaoydeb.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 03 2020, Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Sun, May 03, 2020 at 09:43:41AM +0100, Nikolaus Rath wrote:
>>> Here's what I got:
>>>=20
>>> [  221.277260] page:ffffec4bbd639880 refcount:1 mapcount:0 mapping:0000=
000000000000 index:0xd9
>>> [  221.277265] flags: 0x17ffffc0000097(locked|waiters|referenced|uptoda=
te|lru)
>>> [  221.277269] raw: 0017ffffc0000097 ffffec4bbd62f048 ffffec4bbd619308 =
0000000000000000
>>> [  221.277271] raw: 00000000000000d9 0000000000000000 00000001ffffffff =
ffff9aec11beb000
>>> [  221.277272] page dumped because: fuse: trying to steal weird page
>>> [  221.277273] page->mem_cgroup:ffff9aec11beb000
>>
>> Great!  Here's the condition:
>>
>>         if (page_mapcount(page) ||
>>             page->mapping !=3D NULL ||
>>             page_count(page) !=3D 1 ||
>>             (page->flags & PAGE_FLAGS_CHECK_AT_PREP &
>>              ~(1 << PG_locked |
>>                1 << PG_referenced |
>>                1 << PG_uptodate |
>>                1 << PG_lru |
>>                1 << PG_active |
>>                1 << PG_reclaim))) {
>>
>> mapcount is 0, mapping is NULL, refcount is 1, so that's all fine.
>> flags has 'waiters' set, which is not in the allowed list.  I don't
>> know the internals of FUSE, so I don't know why that is.
>>
>
> On the first message, Nikolaus sent the following line:
>
>>> [ 2333.009937] fuse: page=3D00000000dd1750e3 index=3D2022240 flags=3D17=
ffffc0000097, count=3D1,
>>> mapcount=3D0, mapping=3D00000000125079ad
>
> It should be noted that on the second run, where we got the dump_page
> log, it indeed had a null mapping, which is similar to what Nikolaus
> asked on the previous thread he linked to, but looks like this wasn't
> the case on at least some of the reproductions of the issue.  On the
> line above, the condition that triggered the warning was page->mapping
> !=3D NULL.  I don't know what to do with this information, though.

Indeed, that's curious. I've modified the patch slightly to print both
the old and the new message to confirm. And indeed:

[  260.882873] fuse: trying to steal weird page
[  260.882879] fuse:   page=3D00000000813e7570 index=3D2010048 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D0000000094844a11
[  260.882882] page:ffffe13431bcc000 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x1eabc0
[  260.882885] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  260.882889] raw: 0017ffffc0000097 ffffe13431ca7c48 ffffe13431bcbfc8 0000=
000000000000
[  260.882891] raw: 00000000001eabc0 0000000000000000 00000001ffffffff ffff=
91fe31318000
[  260.882892] page dumped because: fuse: trying to steal weird page
[  260.882893] page->mem_cgroup:ffff91fe31318000
[  262.608438] fuse: trying to steal weird page
[  262.608444] fuse:   page=3D000000000c21d0c7 index=3D2040704 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D0000000094844a11
[  262.608447] page:ffffe134319ebf80 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x1f2380
[  262.608450] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  262.608455] raw: 0017ffffc0000097 ffffe134319e9fc8 ffffe134319ebf48 0000=
000000000000
[  262.608457] raw: 00000000001f2380 0000000000000000 00000001ffffffff ffff=
91fe31318000
[  262.608458] page dumped because: fuse: trying to steal weird page
[  262.608459] page->mem_cgroup:ffff91fe31318000
[  262.770209] fuse: trying to steal weird page
[  262.770215] fuse:   page=3D0000000018a813ac index=3D2045120 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D0000000094844a11
[  262.770218] page:ffffe134319953c0 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x1f34c0
[  262.770221] flags: 0x17ffffc0000097(locked|waiters|referenced|uptodate|l=
ru)
[  262.770225] raw: 0017ffffc0000097 ffffe134319ae788 ffffe13431995388 0000=
000000000000
[  262.770228] raw: 00000000001f34c0 0000000000000000 00000001ffffffff ffff=
91fe31318000
[  262.770229] page dumped because: fuse: trying to steal weird page
[  262.770230] page->mem_cgroup:ffff91fe31318000



Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
