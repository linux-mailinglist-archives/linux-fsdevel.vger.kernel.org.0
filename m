Return-Path: <linux-fsdevel+bounces-57783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E3B253B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DE42A1F69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82897309DB2;
	Wed, 13 Aug 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="m7LudP5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DbyPZntX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2F2F291A;
	Wed, 13 Aug 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112176; cv=none; b=DPG2+baC4Fx7GSHuw2xcObs88Oc9DnBVf/jDChqXEBERdyUxUFRvVRdai0QOeaCJS5MTc4WynNqwVvLAbioY0T5MyzI62thhjdkL//9DogeyFIbMWYs8QbSYmdfajElQ8clILrjFih4hi1D8BRZjqkOSkzlder+g7FdssUFm1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112176; c=relaxed/simple;
	bh=//ic2nFiBCRf1x2UoLS8nXpje0IuO0EMaCXFBNgNjOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTXOsML6Ql7cPHw0/p9lPh9JxiOIYXIs5p+uVEvas99eWcyT7949Ocyb8yBtsKW91+v8WbImlhXHliIQhXCzI78lY7YS2xo6DoN78HtL0loq7tToI7aQ88G0kQGsLFwsxrLSl7yrZQOJFw5x5+uFKolgrZEekiHSbp3QVbwPRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=m7LudP5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DbyPZntX; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 826B71D000DA;
	Wed, 13 Aug 2025 15:09:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 15:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755112172; x=1755198572; bh=jr9Ko8fT5I
	KARAdUzZexlb2pEFmEvxipKU3jq7TmXVA=; b=m7LudP5S1oszdsPDpeXYQ3mcad
	1gIF1nBiEMz2G+1iBg2+uPEOt3o3r0/sB5522nS4n3BBbTArc/p/peMsMKKAMY1o
	j/7KUCljeKqkWUGQt2972YRFAEKofuAhetz1KKmUDgW0Wi17Ty/Tj7b32rw+gHS9
	OgrpSVrnlYs2E5X6/mhv7b+psQOHqYaX1GQJr+rUYHQqLAkquSxtUGOrJ9UxQt5t
	Oxhe6qsD08Ilvg/TnRtnyrRMrp7f6KS2yBjN9QuMulsKXARD70922/N5v83ugft+
	Z2/nFEI5GnCe48DHKy6tQNvkPJw97grpDg6W5bOcIgqggYlzrll9W+yx5nGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755112172; x=1755198572; bh=jr9Ko8fT5IKARAdUzZexlb2pEFmEvxipKU3
	jq7TmXVA=; b=DbyPZntXLCYS++FHWhAdvVZZJq/6mlFYKWHRw5I6xoR1RINC1en
	MXf3OHePPm6mTJcM6WbwUBv8cnZRQwqOtJHAGeF7XmgAQ7PzVF5YZ9HzXmGHEcAH
	S6NVD3EZmieQFCyQrIaRqizkJtLXTQPdwp7z1+1g6aknXR5/C/WIDZwEfeSX685K
	PPzv+SRPH9fzwK6XH7s4yS2is41Wtl9/Oz78loHif0Rt8ouadHu40vH3FLkLQW8T
	7UYJUkS4voI15mc9zZuhrqNGMRs3Wd54Tp8SxZPnzA2/Vsosr3b8xTGXMiHjviJv
	RxoyROgOSoeJA+3d5I+yCKhCfbT9bm4iBdA==
X-ME-Sender: <xms:6-KcaIsTs_cYWX3LK3Me1sDaZZKPqCdirO41D8_qegU-kZ90dGzTsw>
    <xme:6-KcaFL2bHJxQ5KjcEE7V2MLEGKydsYAbznrZmpquqqrSI8j6wbPk46ukrCPH8S21
    b6LK24JiQPDe7M5Gn4>
X-ME-Received: <xmr:6-KcaPYSwy8IzjOXLkJUSRXOjvR-E73TSa6HEECLXHLakp5sjJ4IsswpQd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghhohcu
    tehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrfgrth
    htvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeelhfel
    leetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
    ihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrd
    hukhdprhgtphhtthhopegrvhgrghhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghvrghgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrhhiuheslhhishhtshdrlhhinhhugidr
    uggvvhdprhgtphhtthhopehlihhnuhigqdgrphhisehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6-KcaHBaLl9llYBhKTQPLcxX4fxVMMSVrVEsX3ix97Btn26mhDl8Vw>
    <xmx:6-KcaJb0IaJIpgnZE0BRJQnvZb1PejleE-oXI3hTCMgI6MVGjLp_vA>
    <xmx:6-KcaPkCR-iZBrEUQXrQTuW_F__ezMfN6rD4hxAEIok8_UBBJ0T8Cw>
    <xmx:6-KcaOpkpRsORVbp2PPfc7LqV5ucz6kENKEed79vwCVC6-5flIoF3A>
    <xmx:7OKcaCwHBX5Vr6ORxSUqOOQZtCRppE-fykdWEFpX1y7MR6AtC-0p4Lr5>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 15:09:30 -0400 (EDT)
Date: Wed, 13 Aug 2025 13:09:27 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrei Vagin <avagin@google.com>, Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, criu@lists.linux.dev,
	Linux API <linux-api@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
Message-ID: <aJzi506tGJb8CzA3@tycho.pizza>
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV>
 <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV>
 <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813185601.GJ222315@ZenIV>

On Wed, Aug 13, 2025 at 07:56:01PM +0100, Al Viro wrote:
> @@ -3347,18 +3360,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
>  
>  	namespace_lock();
>  
> -	err = -EINVAL;
> -	/* To and From must be mounted */
> -	if (!is_mounted(&from->mnt))
> -		goto out;
> -	if (!is_mounted(&to->mnt))
> -		goto out;
> -
> -	err = -EPERM;
> -	/* We should be allowed to modify mount namespaces of both mounts */
> -	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +	err = may_change_propagation(from);
> +	if (err)
>  		goto out;
> -	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +	err = may_change_propagation(from);

Just driving by, but I guess you mean "to" here.

Tycho

