Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF41C2819
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 21:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgEBTx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 May 2020 15:53:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59039 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbgEBTx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 May 2020 15:53:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 87D9D5C00DC;
        Sat,  2 May 2020 15:53:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 02 May 2020 15:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        lYgPYSTKqKlbJsJXd6x3mSi0LavzszkoPykHiqKzO5A=; b=piaCx1woYGD2hJNn
        sSgJwq4H8uFwIjxTTfUcZD7J3mg1ahOIyUC1PDhUYg2+ukAhH1y/VFIe3T5ckvPG
        hol+R8qnmYujtNM5GPbh+Deyxm25ojVQ/tpXfyxphNmWVQ77a7d7Lwb0RBN6ibe8
        VFuL95zJ78UeHeF8b7CxDmHgQ0eTsgdvsxnIRUXrJRgW9GZVeY471CUnkCyhhY8X
        Ig7q0/WRTURquNG5YqKvAlEwCSrXAzKbeDvWGYH6aDAqIFVtARk0BE9o18lUwday
        Ujt7Zrb3GYp/cE+Y58pqxjP0Pz3hsaCIpza6KVs78LmUYIoIm4kv1HI8d5tI5W7Z
        Q3d2Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=lYgPYSTKqKlbJsJXd6x3mSi0LavzszkoPykHiqKzO
        5A=; b=0chHIyhR9sucFREMe0xMA5JxGGrtyMjXIGtX2u6VDdOJ95/wkZ+Zgz9+9
        p2aCk9XXD1L5XYlDdBHIWZ+Bt3mOrCMfC1yHcPkTypCDhQ1eJetQbQyfQ+RY27nf
        vIBUWoOk6sRYuLoNYXHZDktUlbQJwX1IE9gADW3Z29gMxKoltGQFf/g6nRE21Yub
        otMxHJp5ntFTOxqNDHPKGOh4IG6RQZIkXoqa5VwEytZh8fmVZ4R932wrFEM1iaKk
        ngsa/pdIWXq1EBp5dwXZeREzwkXPReSDAW1SVsoiGmacR6Ab/NnEDk0pcAhMBMip
        jOOnauYGrnFAIs/l33rqGuVlIlf3w==
X-ME-Sender: <xms:0s-tXrI5J7LLajREsL2u0DhwVkfcbtSHsf1dDePWLqP37TPQcJ13kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieelgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedutdegfefgteetgfegfefhudeuueetveeghfekveejheeuudeuvdeikefg
    fffggfenucffohhmrghinhepmhgrrhgtrdhinhhfohenucfkphepudekhedrfedrleegrd
    duleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    pfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:0s-tXjkhl-wT3PJBIlNeC85oNuOGZlQ3CcTlLRq-RbkEOcHfdJKQ-g>
    <xmx:0s-tXgeToFjh9gQAQhToUFJz63CdAfFPDUBB2U5ZHbX_-A00a8PzOQ>
    <xmx:0s-tXmW3riz9fMepyD0-64w4qZ-7VJPeAIOS87Y4qP3aQovze2BAOA>
    <xmx:0s-tXpHubOgk9rz1CCZQzeC9euLZQ43fBLFwFHfHRA-camq44ajjOA>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04A1E3065DDD;
        Sat,  2 May 2020 15:53:54 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 556A523;
        Sat,  2 May 2020 19:53:53 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 2E36EE29E2; Sat,  2 May 2020 20:52:48 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: fuse: trying to steal weird page
References: <87a72qtaqk.fsf@vostro.rath.org>
Mail-Copies-To: never
Mail-Followup-To: linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
        miklos <mszeredi@redhat.com>, Gabriel Krisman Bertazi
        <krisman@collabora.com>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@collabora.com>
Date:   Sat, 02 May 2020 20:52:48 +0100
In-Reply-To: <87a72qtaqk.fsf@vostro.rath.org> (Nikolaus Rath's message of
        "Sat, 02 May 2020 20:09:23 +0100")
Message-ID: <877dxut8q7.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 02 2020, Nikolaus Rath <Nikolaus@rath.org> wrote:
> Hello,
>
> I have recently noticed that a FUSE filesystem regularly produces many
> kernel messages like this:
>
> [ 2333.009931] fuse: trying to steal weird page
> [ 2333.009937] fuse: page=3D00000000dd1750e3 index=3D2022240 flags=3D17ff=
ffc0000097, count=3D1,
> mapcount=3D0, mapping=3D00000000125079ad
> [ 2334.595835] fuse: trying to steal weird page
> [ 2334.595841] fuse: page=3D000000009e8626ac index=3D2052288 flags=3D17ff=
ffc0000097, count=3D1,
> mapcount=3D0, mapping=3D00000000125079ad
> [ 2334.983568] fuse: trying to steal weird page
> [ 2334.983572] fuse: page=3D0000000013fdd9e4 index=3D2059392 flags=3D17ff=
ffc0000097, count=3D1,
> mapcount=3D0, mapping=3D00000000125079ad
> [ 2335.979905] fuse: trying to steal weird page
> [ 2335.979911] fuse: page=3D00000000a7057848 index=3D2078588 flags=3D17ff=
ffc0000097, count=3D1,
> mapcount=3D0, mapping=3D00000000125079ad
>
> They do not seem to correlate with userspace errors, but I noticed that
> there is no significant performance difference between libfuse using
> splice, splice with SPLICE_MOVE, and not using splice. This is somewhat
> unexpected, so maybe it is related to the kernel messages?
>
> What are the implications of the above kernel message? Is there a way to
> provide more debugging information?
>
> (I have reported a similar issue before
> (https://marc.info/?l=3Dlinux-mm&m=3D155290847909996&w=3D2) and the patch=
 may
> not be present in the kernel that I'm using. However, the previous time
> the warning had a different set of flags and a null mapping, so I think
> this one is different).
>
> $ uname -a
> Linux valve 5.3.0-46-generic #38-Ubuntu SMP Fri Mar 27 17:37:05 UTC 2020 =
x86_64 x86_64 x86_64 GNU/Linux


I have now reproduced this with a vanilla 5.6 kernel.

I also found that the "mapping" and "flags" parameters always have the
same values - even across different workloads and when re-mounting the
filesystem. The "page" parameter varies.


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
