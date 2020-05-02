Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93C01C27F4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEBTKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 15:10:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40359 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728459AbgEBTKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 15:10:31 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B3D35C027A;
        Sat,  2 May 2020 15:10:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 02 May 2020 15:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=S0goA1eqwRzWhNOOHVOOqFB+ib
        n4wvrL6EVxcOJJnt8=; b=3oDE/a5nq4HCN3GEwVB8vslH8B0LqS2X79d6qA08kF
        w88sjTjMnNMFs3xk6444d8QmZeopeyAmBU5Bk/xVJDCVSjM5eSn/DQBRctJW6hrc
        yR3MmccyEr0CQGFLkLg8/iu/TxJU1Gl2Sa8ZCRBugZ+J/KHoYlMNf8bq34aoW2Hi
        iLcndcimAV526A2+ox74Fs8sfwFa50RyOt2amPgnOWB+HlX0L9AebaSUBLPoNq2w
        SwVnZidRYuW0MfbAKwYJEBz8ko2TqSotAHuO7/dJWJWYzKOtk/LGCFLH2tJOUqMg
        ZBLkFc3iixIucxKRBvzZUpI4pmjuUm7pOatIChbzE9pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S0goA1
        eqwRzWhNOOHVOOqFB+ibn4wvrL6EVxcOJJnt8=; b=zP9A86bgzq1km3tLjWZFKf
        jfdyf2qCUlfYAN/Srgr/DIGCDnmJGrILXuvPJ9UcSBOu+AA+GyEzdmaiwU78Lemy
        conbz4FV/S1L7zRtIgsF5qtFwx7VIaI4kuhkpoVO7xvvyEEXg0sS7OzzeWSlqGAC
        +CuHU6wzLJHS4LZFIoVE5A5RHGhtKEggT4+X3k4+51zXOIHjcNcOt1JEdzaSn2ts
        aFHdDd/I5/mUU50Tr4aELc05Xmk/hW+WJ4Kwb/z5fI4etTSdGhm57pAmmYQBf0jp
        C+F0278dRJH9sWZDKmHEemXlGm8UNeoQ+eS5U7sU4wU01M5a3cis9drPFqhmQLWQ
        ==
X-ME-Sender: <xms:pcWtXvFr_jq5Sxwn6oNfuxKQWm_DkSFL7exPr0hZlD8izSUxEM_7ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieelgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeiheevteettdehtddvledtgfeuiefgtdekgfegheelveetteefgffguddvkeek
    ieenucffohhmrghinhepmhgrrhgtrdhinhhfohenucfkphepudekhedrfedrleegrddule
    egnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhi
    khholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:pcWtXglxn9SzPWtdKb82EQMzgEH5dA6lvIXHnBIJhqjokSOtdGuQqQ>
    <xmx:pcWtXsIjaIuksJX4dzA14ckYzXoVi9eidaN5CRF5IdSK3m8NeJdaxA>
    <xmx:pcWtXhaPTi06o3EZR7bFHFMFV-5uLnSnUCdgvKRo7CjNcWRAYu6yVg>
    <xmx:psWtXldy_PcXyRfRt8Pg1O_E4ow7m0aeagYZSjaBXZo4JQfMLVssYQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 786363065F98;
        Sat,  2 May 2020 15:10:29 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 878BF23;
        Sat,  2 May 2020 19:10:28 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 4BE8CE29E2; Sat,  2 May 2020 20:09:23 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: fuse: trying to steal weird page
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
        miklos <mszeredi@redhat.com>, Gabriel Krisman Bertazi
        <krisman@collabora.com>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@collabora.com>
Date:   Sat, 02 May 2020 20:09:23 +0100
Message-ID: <87a72qtaqk.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I have recently noticed that a FUSE filesystem regularly produces many
kernel messages like this:

[ 2333.009931] fuse: trying to steal weird page
[ 2333.009937] fuse:   page=3D00000000dd1750e3 index=3D2022240 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D00000000125079ad
[ 2334.595835] fuse: trying to steal weird page
[ 2334.595841] fuse:   page=3D000000009e8626ac index=3D2052288 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D00000000125079ad
[ 2334.983568] fuse: trying to steal weird page
[ 2334.983572] fuse:   page=3D0000000013fdd9e4 index=3D2059392 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D00000000125079ad
[ 2335.979905] fuse: trying to steal weird page
[ 2335.979911] fuse:   page=3D00000000a7057848 index=3D2078588 flags=3D17ff=
ffc0000097, count=3D1, mapcount=3D0, mapping=3D00000000125079ad

They do not seem to correlate with userspace errors, but I noticed that
there is no significant performance difference between libfuse using
splice, splice with SPLICE_MOVE, and not using splice. This is somewhat
unexpected, so maybe it is related to the kernel messages?

What are the implications of the above kernel message? Is there a way to
provide more debugging information?

(I have reported a similar issue before
(https://marc.info/?l=3Dlinux-mm&m=3D155290847909996&w=3D2) and the patch m=
ay
not be present in the kernel that I'm using. However, the previous time
the warning had a different set of flags and a null mapping, so I think
this one is different).

$ uname -a
Linux valve 5.3.0-46-generic #38-Ubuntu SMP Fri Mar 27 17:37:05 UTC 2020 x8=
6_64 x86_64 x86_64 GNU/Linux


Best,
-Nikolaus


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
