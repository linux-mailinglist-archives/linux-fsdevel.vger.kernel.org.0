Return-Path: <linux-fsdevel+bounces-15232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3940888AC70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B92A1C3E354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A57136999;
	Mon, 25 Mar 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="cQ/ZhxNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EA1369AD;
	Mon, 25 Mar 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386545; cv=none; b=l78pZ09DAe3zcaJ311m+mq0kelUtN9C+Qfr5Gne1/+Y3VdeLflqCRDy8G2Z4OkbTasWplF5jrfb3eNszYweWaHHxSu8G/wZZeGckORjcvc/Uq1hlvNbL97q/uv0pr5nW6VcNWLXqudIKr1HS8V2FBSErZxhbaua6JzGxFSVkjY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386545; c=relaxed/simple;
	bh=UYyk8goNTowWikjuMMKS6U8Bzza67VHqAbb7Yx2knn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwYt+wS7jjwBcWM7vwy7ZSwYMZgPtfxRQ81Zfo8wZ7alwG1pA0GZHRJXVM94bXMxWvg9ijBkfaev2y7w4FZmxZKJXyyz3uA6C3ZCbs+m/UyhPIDMKwLivkVLgO+f3RKkD5yiFWgO6y1IMdHpIbss8RvofmN7ifGWrSvsb74vUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=cQ/ZhxNQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/1vRIRCMcKep857REgOgnY61TxUx/MYY2ON/5+tnNIo=; t=1711386543;
	x=1711818543; b=cQ/ZhxNQxjkQTacefYhl5aMZ4TdaVIOZZ9edbbiI93wSd2bpfyqrdHNk9g+xr
	ioDfu3WLK2RBxxhHSBQutoPRtSZ3fsriDsyek1n15J/jSk/IohR1Dz+KAHDSi3WrTMc8HKiwB0wye
	xYtKba4bIPrlLkfv+zUf14gKhJNmMVof4ayaQS+Zs3IE5VquYbIIRHqCdlINxFzS5u5Clv19ww0dq
	yRSQGJxWkZytZlZmoq8RT8x5lAtqfTnA3u1JV7IEabo9H9yDAkGeDP/7b+hQl5/f3LftsO4NHtT84
	kOgnBq6ZqqffTwZUsh6ikkK/icM4gaU/VeRiY2mMo6id14d14Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ronoc-0004O2-Gt; Mon, 25 Mar 2024 18:08:54 +0100
Message-ID: <b5749b25-7f1b-4933-9e72-87c3ef178c35@leemhuis.info>
Date: Mon, 25 Mar 2024 18:08:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Content-Language: en-US, de-DE
To: Kees Cook <keescook@chromium.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jan Bujak <j@exia.io>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
 <202401221339.85DBD3931@keescook>
 <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>
 <202402041526.23118AD@keescook>
 <51f61874-0567-4b4f-ab06-ecb3b27c9e41@leemhuis.info>
 <202403250949.3ED2F977@keescook>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <202403250949.3ED2F977@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711386543;9cf8b45d;
X-HE-SMSGID: 1ronoc-0004O2-Gt

On 25.03.24 17:56, Kees Cook wrote:

> The original reporter hasn't responded to questions and no one else has
> mentioned this issue, so I think we can remove this from the tracker.
> 
> #regzbot resolve: regression is not visible without manually constructing broken ELF headers

Ahh, that's how it is sometimes, thx for the update! Ciao Thorsten

