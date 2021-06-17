Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CC93AAE07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 09:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhFQHyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 03:54:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58597 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhFQHyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:54:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 29E985C00A1;
        Thu, 17 Jun 2021 03:52:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Jun 2021 03:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        WpXJv9HJaVjs7c3l31zTlNHRcUftcoeSO1pZ9lXZLTg=; b=INFPrLUWuFJe+v2u
        xrr6cyg5gnqAF1Cu+d9EDM0XOk6WNPSXmfn7c6fk1FOaTPtcUvzKID1MAt8zlt1S
        ahPraXcAzZm3OS4bKp4g3hc7fMKWmcFXT+Pga+yijItclja/jpOhcKOZk4BMBkY+
        M50kJvAo1LlthCb3QoD7OjDEyaLak4BHBsr1hxKk3rGKEFFnASdRkl1lh/S8uuyx
        IRrSHCqJ/U8XwzcH3N2lhM0lOxPV2CsaEmbuyjnMPX+CI/lDswHpQgyrL5btq6Qp
        DvJA1bC3n9q4Ua2aHFy6ZpxIfJK7vK5dxVp9Vh9P1t2GYWBBwx9/IUQJJRBjp10j
        q15lRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=WpXJv9HJaVjs7c3l31zTlNHRcUftcoeSO1pZ9lXZL
        Tg=; b=IBD1xmbW62Ya61ulkb+S6F9WCwI8fkPuykQilCYKuaHixhGEBjpMd28BA
        exykEGl3BY3jIvrNZszXy0zDIpULXiPQptZIbJRGFDafmga5tj/oZ8JpyYnHx2oU
        DmQoevZe9/1qI4EPIHm55uNXPYNexRsRODCVAvT3+ha9Nrl/G6oHeSkAILwnLerr
        MsKmbRfs4fzuIbRTSp1Hzi7gpuJ87pCkKt5jL067ZRVbX4qRE5GHPGdjfPYmCR6S
        thxAOL8bhiPow+WbQvLo2EKelEdizlfl00eu0c5oMItGZLO83uYI3i3nrFrl0N1K
        QQ/Wl+dcLsf8QCtG/pnqNJIkhfiTw==
X-ME-Sender: <xms:O__KYORfFutmbzxcJ1trLTkXXJEYZsmigzoYx_0XAnyU78ktnBtFeg>
    <xme:O__KYDzI05hX5uptCRweCV7ABQuHswNP39kn9-_Zt-12VuS2HzeudOzOrmRflDrBc
    dLtaQoAwZ06-UHX>
X-ME-Received: <xmr:O__KYL2Bwu5K2cyEpBjU0dj1To3Ohh7jm4SEBq0foD1_OlaQI-excUthvq1icWvZ9DEgC2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeftddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepfffffeeugedtveffuedvvddtudettdehffefgfevfefhtedthffftddu
    fedvtdefnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdho
    rhhg
X-ME-Proxy: <xmx:O__KYKB3gC6g1Wz8p-F7UJZgrdOVvOSFT6PG4WchjxuRjlurpP-snA>
    <xmx:O__KYHhz8Hsosg6Sxjqqtm7i38Vdt2VqUt7q9s1RNSgb0EUo6DzKaQ>
    <xmx:O__KYGqWpdAqFmRnIsXgxvwoFO0tPg5A9ex1WTSjKJ1S5dt_3PNoyw>
    <xmx:PP_KYCWGK3xh5Erp6GLeHu1zOnfHkl8UyP0i0gPwBzTZhncpT8PuTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jun 2021 03:52:27 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id C58F82C2;
        Thu, 17 Jun 2021 07:52:26 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id B01876B640; Thu, 17 Jun 2021 08:52:26 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
References: <20210609181158.479781-1-amir73il@gmail.com>
        <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
        <d7a38600-5b4b-487e-9362-790a7b5dde05@www.fastmail.com>
        <CAOQ4uxgzpKRWU2fFgF4OxROHZ84VZw7Ljqt5RvAi4b3ViTNfYg@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi
        <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>, Vivek Goyal
        <vgoyal@redhat.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 17 Jun 2021 08:52:26 +0100
In-Reply-To: <CAOQ4uxgzpKRWU2fFgF4OxROHZ84VZw7Ljqt5RvAi4b3ViTNfYg@mail.gmail.com>
        (Amir Goldstein's message of "Wed, 16 Jun 2021 21:25:09 +0300")
Message-ID: <87r1h13p39.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 16 2021, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Jun 16, 2021 at 8:25 PM Nikolaus Rath <nikolaus@rath.org> wrote:
>>
>> Hi Amir,
>>
>> On Wed, 16 Jun 2021, at 16:03, Amir Goldstein wrote:
>> > Per request from Nikolaus, I modified the passthrough_hp example
>> > to reuse inodes on last close+unlink, so it now hits the failure in the
>> > new test with upstream kernel and it passes the test with this kernel =
fix.
>> >
>> > Thanks,
>> > Amir.
>> >
>> > [2] https://github.com/libfuse/libfuse/pull/612
>>
>> Actually, I am no longer sure this was a good idea. Having the libfuse t=
est suite detect
>> problems that with the kernel doesn't seem to helpful.. I think the test=
suite should
>> identify problems in libfuse.  Currently, having the tests means that us=
ers might be
>> hesitant to update to the newer libfuse because of the failing test - wh=
en in fact there
>> is nothing wrong with libfuse at all.
>>
>
> I suppose you are right.
> I could take the tesy_syscalls test to xfstest, but fuse support for
> xfstests is still WIP.
>
>> I assume the test will start failing on some future kernel (which is why=
 it passed CL),
>> and then start passing again for some kernel after that?
>
> I was not aware that it passes CI.
> There are no test results available on github.

Arg. Looks like something is broken there. I mistook the absence of
results for a passing result.

> I am not aware of any specific kernel version where the test should pass,
> but the results also depend on the underlying filesystem.
>
> If your underlying filesystem is btrfs, it does not reuse inode numbers
> at all, so the test will not fail.
>
> For me the test fails on ext4 and xfs on LTS kernel 5.10.
> As I wrote in PR:
> "...Fails the modified test_syscalls in this PR on upstream kernel"
>
> If you revert the last commit the test would pass on upstream kernel:
> 80f2b8b ("passthrough_hp: excercise reusing inode numbers")
>
> We could make behavior of passthrough_hp example depend
> on some minimal kernel protocol version or new kernel capability like
> FUSE_SETXATTR_EXT if Miklos intends to merge the fix for the coming
> kernel release or we could just make that new test optional via pytest op=
tion.
>
> After all, regardless of the kernel bug, this adds test coverage that was
> missing, so it also covers a possible future regression in libfuse.
>
> Let me know if you want me to implement any of the listed options.

I don't want an old kernel to result in libfuse unit tests failing, but
I think it's a good idea to cover this case in some form.

Would you be able to make the test conditional on a recent enough kernel
version?

Or, if that's too much work, print an error message that explains that
there is a kernel bug but do fail the test?

Best,
-Nikolaus


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
