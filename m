Return-Path: <linux-fsdevel+bounces-21613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A21906757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6982846B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4D13DDB2;
	Thu, 13 Jun 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="lp2qj7O8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUzGjO82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF22AF1D;
	Thu, 13 Jun 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268329; cv=none; b=o2gp9C5stBnfAuJMDGann63iR2+w2M4e88Kd3awclKApYaVGejMtt9JYab7D5u998QGrckOavwSgBTojNZjAO1coty9q9+ZDVt9nZdW4HC4Mr0YMsVcCD33d3JxXSLezca/t2P9Bk4gQ78uIEfG9ezqg/G70eFpXi2WFNvv9nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268329; c=relaxed/simple;
	bh=LMdhkZ0nNad0++Iw4xjgrDk4jTiMrTUkzNpl4vhiYNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKtqZ8NYVe1wLpfczxiRBEzrbnTUKCdJRcKW05GnCNQt+XkEUI88KS97VzRvZMC4BZPn/NYnYv7BOrfkoCRKtQlZxFwWnDIPT3VvfPUfn+c3/UWbKyjfM0/hztVgxDvM5cTHGhnq+ecKgPS9Shs6Z+4l82Wtkw0UgeCfGAQVIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=lp2qj7O8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUzGjO82; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 4DC642CC01C6;
	Thu, 13 Jun 2024 04:45:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jun 2024 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718268323;
	 x=1718271923; bh=Duc4P1DZW9aX+Ejfjk47XQeC4s374o0lUU3oX+TajRo=; b=
	lp2qj7O84zuWkhldM1NCcWcsJ6g+awm7EbTvAOuAcPCn0mdcp7MeiZrcbuO/LAct
	roCd/EKE04jdiOM5G9klXQOMLz6018a/RszpXoEy2a8MnMBBp/smMcqPrvuAXi0S
	maGz6Il3BLvmqfgte5/uWnPOs2ps4XTPEdcXhgrAniqgFVr5npukQWoS86+TRLuj
	phWfxgBFuk5XJmqmDuFCsgmQgXF9mj8ArpNGXHaSxMbQdxmIzq016DpgdQOtGcyl
	84HyOo2yN6l+znGkdZgm5hh5PQ0hsnDq+1ADstCalDcZbmthlPzwaRCMAnHioAsG
	iH6S6n4xs4obPy18lqlCjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718268323; x=
	1718271923; bh=Duc4P1DZW9aX+Ejfjk47XQeC4s374o0lUU3oX+TajRo=; b=M
	UzGjO82mh/NsB26L3vRAl2u49KSI3m9vthRi9a+Et6gRkFztGnIu11FkgYADv/EH
	lJuGoxQnvov0HenSuF5QcBq5dO16TgCsWSBXtqyiEYQm8t+oGWxuAUIfe4YOSykL
	5D5oWPIdrawZwf0VJ6EF5fMVl5p3pdfXIfPXqvwNd5Gq0EYgJH5cj7WVXsYog+Ng
	0rPr8fIevJqb6TLcpV2dsncN3eEdzPq81/BDxdbOAm+Ts3xyYEJvT09nSCRdyU5a
	QWatMogGwEm6OXSGCVihQRZUjOlapB8EqNnq8Gui/PlDxCud0b4wCFKxmOLmeWdJ
	Yj5e00O7+RejRbbMY1Umw==
X-ME-Sender: <xms:o7FqZuRM-I41FTbF3TWfU59QEGZVuHk-VBMczvSDOM8gPVxdidGPRw>
    <xme:o7FqZjyx89YeqkezBaxx9kYGA6ae98Xqy5IH3NW_oGHSgrSR5nAkYqoWQ8L0a0_ML
    w24cPA4AuZMvvj8Ggg>
X-ME-Received: <xmr:o7FqZr22rtn7SAPOi4siw_iR2qQOXq9H-b0mEy17n42R-f9DmtRwRGJxF13N2MjcsNaVKHxW8J2BI4mQoHWFD6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeetgedutdfggeetleefhfeuhedtheduteekieduvdeigeegvdev
    vddtieekiedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:o7FqZqAIsUiuR-j183p4TJiST7IjY1t1Ce9mUm8DQcTCKRnHenf_OA>
    <xmx:o7FqZngw5PDa584U3Wh1jwTvQl2qeKL7_2dB0J2zsBM9sM_TByA_4A>
    <xmx:o7FqZmoPO9Qep-lobaoGhd20w8bSfXQ9DTRKleW3GdYNkJhI4Hqo_w>
    <xmx:o7FqZqhdVAG5teRZanIWKQVC8C5sAJf45nKlmpoUmtLFT-WNQdPFUQ>
    <xmx:o7FqZmSdoWwB05Nk0KdtXpg1T3Zo6usTcrge4t5X0g2XO13hsvlrej2W>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 04:45:19 -0400 (EDT)
Date: Thu, 13 Jun 2024 01:50:29 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>, brauner@kernel.org,
 	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
 	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 	KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 	Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 	Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 David Howells <dhowells@redhat.com>,
 	Jarkko Sakkinen <jarkko@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, 	containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, 	apparmor@lists.ubuntu.com,
 keyrings@vger.kernel.org, selinux@vger.kernel.org,
 	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
Message-ID: <zwh766li4dwx5be6uxnxl2lhtxb4jsiua4atilpqvoeuksgz2h@v3pna3o3ewkp>
References: <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
 <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
 <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
 <rgzhcsblub7wedm734n56cw2qf6czjb4jgck6l5miur6odhovo@n5tgrco74zce>
 <CAHC9VhRGJTND25MFk4gR-FGxoLhMmgUrMpz_YoMFOwL6kr28zQ@mail.gmail.com>
 <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba8d88c8-a251-4c1f-8653-1082b0a101dd@canonical.com>

On Wed, Jun 12, 2024 at 08:54:28PM GMT, John Johansen wrote:
> On 6/12/24 10:29, Paul Moore wrote:
> > On Wed, Jun 12, 2024 at 4:15 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > > On Tue, Jun 11, 2024 at 06:38:31PM GMT, Paul Moore wrote:
> > > > On Tue, Jun 11, 2024 at 6:15 PM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > 
> > ...
> > 
> > > > > Arguably, if we do want fine-grained userns policies, we need LSMs to
> > > > > influence the userns capset at some point.
> > > > 
> > > > One could always use, or develop, a LSM that offers additional
> > > > controls around exercising capabilities.  There are currently four
> > > > in-tree LSMs, including the capabilities LSM, which supply a
> > > > security_capable() hook that is used by the capability-based access
> > > > controls in the kernel; all of these hook implementations work
> > > > together within the LSM framework and provide an additional level of
> > > > control/granularity beyond the existing capabilities.
> > > 
> > > Right, but the idea was to have a simple and easy way to reuse/trigger
> > > as much of the commoncap one as possible from BPF. If we're saying we
> > > need to reimplement and/or use a whole new framework, then there is
> > > little value.
> > 
> > I can appreciate how allowing direct manipulation of capability bits
> > from a BPF LSM looks attractive, but my hope is that our discussion
> > here revealed that as you look deeper into making it work there are a
> > number of pitfalls which prevent this from being a safe option for
> > generalized systems.
> > 
> > > TBH, I don't feel strongly about this, which is why it is absent from
> > > v1. However, as John pointed out, we should at least be able to modify
> > > the blob if we want flexible userns caps policies down the road.
> > 
> > As discussed in this thread, there are existing ways to provide fine
> > grained control over exercising capabilities that can be safely used
> > within the LSM framework.  I don't want to speak to what John is
> > envisioning, but he should be aware of these mechanisms, and if I
> > recall he did voice a level of concern about the same worries I
> > mentioned.
> > 
> 
> sorry, I should have been more clear. I envision LSMs being able to
> update their own state in the userns hook.
> 
> Basically the portion of the patch that removes const from the
> userns hook.

Yes, pretty sure we'll need this regardless.

> An LSM updating the capset is worrysome for all the reasons you
> pointed out, and I think a few more. I haven't had a chance to really
> look at v2 yet, so I didn't want to speak directly on the bpf part of
> the patch without first giving a good once over.
> 
> > I'm happy to discuss ways in which we can adjust the LSM hooks/layer
> > to support different approaches to capability controls, but one LSM
> > directly manipulating the state of another is going to be a no vote
> > from me.
> > 
> I might not be as hard no as Paul here, I am always willing to listen
> to arguments, but it would have to be a really good argument to
> modify the capset, when there are multiple LSMs in play on a system.

The way I see it, it's more about enhancing the capability LSM with BPF
hooks and have it modify its own state dynamically, not so much
crosstalk between two distinct LSM frameworks (say one where the BPF
LSM implements a lot of things like capable()).

In this context and with enough safeguards (say we only allow dropping
caps) this could be a net positive. Sure, ordering could come into play
in very specific scenarios, but at this point I would expect the
admin/LSM author to be conscious about it.

If we think there is no way we can come up with something that's safe
enough, and that the risks outweigh the benefits, fine by me, we can
drop this patch from the series.

