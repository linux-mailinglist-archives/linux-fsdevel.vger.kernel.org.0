Return-Path: <linux-fsdevel+bounces-43-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D392B7C4C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 09:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0320F1C20EDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E1199D6;
	Wed, 11 Oct 2023 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="K+QEtTpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+u2vqe0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAE18E32
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 07:38:55 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B372792;
	Wed, 11 Oct 2023 00:38:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 291A332013E6;
	Wed, 11 Oct 2023 03:38:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 03:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1697009931; x=1697096331; bh=tg
	uG2aXRGfx+BtSSdosiAuKFgDBmx4SGy972Szw14Xw=; b=K+QEtTpUgF75OMaZQu
	awOhoNWZjzQIEpgcPHus85fajdr6TqnfsBJsZ5w7/Hyhd5QxiVx3HCDAAo37Z3wp
	uo0ynzf3trRDe6iP5zwOfJB7CC7V1eJgWfm2Ojv3DEy0a+TOQYnL+JNXH7l1D9zP
	t3JDyNXQ7XjIcnHqFTBoFspVyeCbBmyZrre+s8SKaKV+xt4oyrefhoUOPFVkbycq
	knhid9ikyWWQ1XD5mmQrvvH3lf9Fm/xrBIkYTiA4aisF04SeC1P/Ir7Wnh70XRlj
	eg4iI+L6gbpK/gmv4HafNsS373CQHPBuKtwHX8Wm++/bMqf9hHQbZFOTsJcc7DYa
	dJIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1697009931; x=1697096331; bh=tguG2aXRGfx+B
	tSSdosiAuKFgDBmx4SGy972Szw14Xw=; b=c+u2vqe0zrP/tiv8UGK023yIbdcxV
	arlU0jbHPpMOjz+/tXj/1IuUt2tZ6NV3OfkE8Un59DtrdF+QXfU7J7Kfh+9jEmUv
	TeexUfps7fVBRWR8JnAezLtRb6eSRjlQk2wIYEx2KTG2dcyL+sZRCeMpASUCDLPm
	hdRsd0PGOE0Qkhz+RnhfvJvnmtHWVBJ8fSxsGQ9tvK7vKYLlK+jfeLHl5rGK04cV
	8y0S87gCyHQ4QhFx7mEF6RBDqxV8La9i8+yPeuK1tKkrPQInD9Peden9D1akrm/p
	YkBfAE/0A11vsdNpKV+AuwR9H8bdy0mpdUed0GnScvlFhDmjsy8+gBxRg==
X-ME-Sender: <xms:ClEmZXlqxfwXLwPjvCAoIkRRMUhwJgSu9jYnCKspgngy2V_ib5edKw>
    <xme:ClEmZa0nOVvBZEQ0ia4tzTQ3-UYocRs6cBAfLWPm3lPcD18Z_txA2gClRWMNsKOQ6
    mVoTziY344CnuztQQ>
X-ME-Received: <xmr:ClEmZdqq18H23WE1uen6kuzhbSXh24MfPS7hwrh8WlCmPR1lc3fpHPCSuKL6FvAcr7pZs--dG8aHxdvB0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheejgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
    ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepteehve
    dugfejgfehhfeijeduleekleejgedvkeeuuefhhfegvdevfeetveegteeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
    drihhs
X-ME-Proxy: <xmx:ClEmZfkGLx6NcTiLggUcv7l9SWZN98xd42VtbXscB1cvSxwYRrRynw>
    <xmx:ClEmZV1yGbIHL1Lw5W-Q9bfSPoHea-nAui-kY60LI7tfVpFQyEvPXg>
    <xmx:ClEmZevbN0YNSBAIGI9qQWHPrqhWjSgT_nTpvp7nWfUmTOrWPyV8ig>
    <xmx:C1EmZfpfNgOGiqfvxFacjhUpaPru0LBsOc7fI00Ri_ebpwf1VXX8AA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Oct 2023 03:38:50 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 461BBF0E; Wed, 11 Oct 2023 07:38:48 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Eric Biederman <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: allow executing block devices
In-Reply-To: <202310101535.CEDA4DB84@keescook>
References: <20231010092133.4093612-1-hi@alyssa.is>
 <202310101535.CEDA4DB84@keescook>
Date: Wed, 11 Oct 2023 07:38:39 +0000
Message-ID: <87o7h5vcao.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kees Cook <keescook@chromium.org> writes:

> On Tue, Oct 10, 2023 at 09:21:33AM +0000, Alyssa Ross wrote:
>> As far as I can tell, the S_ISREG() check is there to prevent
>> executing files where that would be nonsensical, like directories,
>> fifos, or sockets.  But the semantics for executing a block device are
>> quite obvious =E2=80=94 the block device acts just like a regular file.
>>=20
>> My use case is having a common VM image that takes a configurable
>> payload to run.  The payload will always be a single ELF file.
>>=20
>> I could share the file with virtio-fs, or I could create a disk image
>> containing a filesystem containing the payload, but both of those add
>> unnecessary layers of indirection when all I need to do is share a
>> single executable blob with the VM.  Sharing it as a block device is
>> the most natural thing to do, aside from the (arbitrary, as far as I
>> can tell) restriction on executing block devices.  (The only slight
>> complexity is that I need to ensure that my payload size is rounded up
>> to a whole number of sectors, but that's trivial and fast in
>> comparison to e.g. generating a filesystem image.)
>>=20
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Hi,
>
> Thanks for the suggestion! I would prefer to not change this rather core
> behavior in the kernel for a few reasons, but it mostly revolves around
> both user and developer expectations and the resulting fragility.
>
> For users, this hasn't been possible in the past, so if we make it
> possible, what situations are suddenly exposed on systems that are trying
> to very carefully control their execution environments?

I expect very few, considering it's still necessary to have root chmod
the block device to make it executable.

> For developers, this ends up exercising code areas that have never been
> tested, and could lead to unexpected conditions. For example,
> deny_write_access() is explicitly documented as "for regular files".
> Perhaps it accidentally works with block devices, but this would need
> much more careful examination, etc.
>
> And while looking at this from a design perspective, it looks like a
> layering violation: roughly speaking, the kernel execute files, from
> filesystems, from block devices. Bypassing layers tends to lead to
> troublesome bugs and other weird problems.
>
> I wonder, though, if you can already get what you need through other
> existing mechanisms that aren't too much more hassle? For example,
> what about having a tool that creates a memfd from a block device and
> executes that? The memfd code has been used in a lot of odd exec corner
> cases in the past...

Is it possible to have a file-backed memfd?  Strange name if so!=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmUmUP8ACgkQ+dvtSFmy
ccC7DhAAgtwwDA4fn/aXYdqL7F7R68MtABW7LyXGNCjuGEmP1kZbkg0lEyEc7UCr
+dn5F8EXSzRGK5huEn2RzhPNnzU28KWBxmXN6bFED/YaCDKYBC9MM3cGUaXEbTPG
fQyQAGo36qlB5m/hS5j8XMuM/uIcYlsEk8qkgpAkfebNAMEKTxxSTshUSFRyq5wa
KTT76URCwrxPooy25Znv4JqjsR2taMPOvXnVV6bf8DXcCNuI+eVeu7J/nZ44LyEe
0GykVN2hBeUwuSQEkyR11iKbaoxlTgYRyMMYOw+ylgaBUgfsJn88tGk1qCDlfRW+
/B1QUJephRtk0LsBLGcjeEqATCJ4ITZaDoIe1CI1pUjluR8tJrMxhmhX9dlyWvjb
b4CRpFck2sjXbDaP36sW9s7F7qgp9NspPLzSrcgVmKNPY90c/sTVvrkd8CXca2px
0z1Yxa5P1OFPSSEwBbwqNUpTjsRwQMfsq8TUbcbzJ1h++9F6HEce79WkMz6AHGPD
c/rpzHS7MqbHCj/nxHP9IuCU1XyR8rIXRynD9NFdDtp8bJMGwvGselrRHfHVz9+X
tzX4PUuz9k+3PEoHSOVrIaHItIY5Ml7i5md1wpeARpi0lz7CeUvTWMLxXPb/Xc4Y
BMlmXuKi7CZmjYS/zkw6d1KGddkMhyeZ2I76hkbyGTbfbKDNsU0=
=S7sC
-----END PGP SIGNATURE-----
--=-=-=--

