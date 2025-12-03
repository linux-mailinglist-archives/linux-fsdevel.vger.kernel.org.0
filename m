Return-Path: <linux-fsdevel+bounces-70525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73416C9D742
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13F55349BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40C1E51E1;
	Wed,  3 Dec 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FS+mSbFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC5200C2;
	Wed,  3 Dec 2025 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764722983; cv=none; b=RFXkrn15ED3TMs6Xfgm7toXCz4d2OODPQqJZ7NI0Y4y3C1hA4yyTDzyMoFKBGl9WChp52wLC2EYQAua68lOIYuOiU/PkiY4QNuOdP2+XtHM9GdQHl89E/Hydw06NOR9XfzGKwg3EALAxz5Q3VwL59iGkKMj32etUJGlN4wibqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764722983; c=relaxed/simple;
	bh=PKcr/FCeKCrG0DcpOV2iGiVMYNfZOwF3WU97HMd+E2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExsxPbuYXVpZtCYS2QQEHbTIlUjPTuwPvca5zZhEnE/oFl8rqKKjKGKR8iscnD84qdu69je7hV6wR0kJZ8v1m3IOqscUPSrVBE4Dk1Abpd+d1eMGkS1+pWepFvrUXqWExIV9XVqNuAU4j4GESvrvY8m1F4eNsW19EPei1/XDG1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FS+mSbFY; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764722966;
	bh=id6RGvXR9Nz+pCvTGXSuBy9/0uv7CZkzHloib6Ptl5o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=FS+mSbFY0RRQTZHV+TENe9Vp5XrRXkMmTROwsiDWOXzMHWNd3OmH2+viHhmXzMxwJ
	 PzkzDd4osxWDoG0O6PKdKUP4qYBO6l1B+CPu6oFGHTJvvY3LYNBb3wq2kTm8yNRP4s
	 g8Wk4q+H6cXs/qulgCz+NIF4ykCwJWli7sqIXhXs=
X-QQ-mid: zesmtpip3t1764722958t4c536c10
X-QQ-Originating-IP: rkQVO7w1pp32zIpzhOpRFt3KYfDdz2OuJYg1ZjRYOb0=
Received: from winn-pc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Dec 2025 08:49:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17333739068303485682
Date: Wed, 3 Dec 2025 08:49:16 +0800
From: Winston Wen <wentao@uniontech.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
 hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
 djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
 rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
 ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
 gunho.lee@lge.com
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <77A07B9EA2BF906B+20251203084916.509fb15f@winn-pc>
In-Reply-To: <CAKYAXd8sFP_sDGpg-ajsuCYw_GjH-AgKZoqoQL0wweg7OduVbg@mail.gmail.com>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
	<85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
	<CAKYAXd8sFP_sDGpg-ajsuCYw_GjH-AgKZoqoQL0wweg7OduVbg@mail.gmail.com>
Organization: Uniontech
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MUl8SfxFsONGsnfjqV2XV0hoN7//OHLdDynNa1VPPpWqFywkR85GLmZD
	n7XGwQ6XwRY07nz2HOEDEW1xaAJ4boAxeOvp4lB/XIzcMHKe4CpDgjqK5pRjm8IvgXUKDKZ
	qc+8Bs0gyf4ZaM8EY5Qy74NHPNBRgcy7FQx0CojY9jYuSiMhhZLvH4US7O9Ptr/xKTCsXRg
	dTqkBaXqCKrJpAdDvE/WITZ+PUEkk+oPfV8c3bDDNWFgRcqDCBYqgMq8tzQ+K8RiqqjD9Cw
	A/zL5idXEpprR7cVuz6XlqvHwufbnvOmz0rpAasMLXHTJFVUsGnZcKrv/rmqEhjOnilvwX3
	khfhA2kAnZQD8/aR5ZmgfL7Jrt46EVVvRWDSEeuNU+7WLF/eKblNedcn5liXu1WlZFoEq1d
	nyUsqJIzxaOcQ8ewKLFgnU8WsM29gEtqV+zL9gfWg2Y00Ol9XJ2o2K/YyLl650NMkAx9w0S
	XjGOuIMzDaw2gUcaoEElM3G81fVU4Q3NuGoNyGC76s2SH6xdsEaB5fniqlhwXglFde+/0uc
	jT93AxcTt3uwgB3I9GZc3IXjQlFk8a+u3xRhI1THGRT0oZLsmGNjvu/14oTMw2Ey5dAh/v2
	DzckH1lgTvegCh37xC4YNo5sWc7g3zh69Ua7Bu+pdilqP3Sj6xyVsga2RwoVg0VMhgFWCzW
	lDZdieeW0nmIeJbLqJY9kWCJFJQFHvPKUE/CJlO/90xvF0GzqavDEX9d+6yLAus80RSSgdA
	XAJpZjaKScVEqdfDoOsDbW3YmrGFzestAkEskkncbCBXLpLtm/2iN89fbq8YNCtsnFj+dez
	+QQPvUhPfQkH0Gp5vvzb1CTWHTf7pIgN08C4yhyQLLh3Vx3316AvUi5zRzTZoZGWLpypX8F
	sFzye/0qUkrF9Va88JvJ2cJ0H8xVEDcGkrjtJoEG2al7L0Qstfxx2ZzYkxCcMLJImDGRyCB
	6B3tcmUtlxls9giYROhg8yvzbgix+Wi1G8KfQgTc9//lcDg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, 28 Nov 2025 16:02:29 +0900
Namjae Jeon <linkinjeon@kernel.org> wrote:

Hi Namjae,

Thank you for the detailed and encouraging reply.

> fsck.ntfs is supported through ntfsprogs-plus, and we plan to continue
> updating it. I believe that fsck.ntfs will partially cover the issues
> caused by the lack of journaling. I don't know your usecase but I

That's good to know. I will definitely look into and test fsck.ntfs
from ntfsprogs-plus.

> don't have any major difficulties supporting NTFS on our products
> using ntfsplus yet, even without journaling. And I plan to begin
> implementing journaling support for ntfsplus early next year, and
> welcome any feedback or collaboration from you. I'll make sure to CC
> you when sending the journaling patches to the list.
> 

Regarding our use case, our primary scenario involves USB flash drives
and external HDDs/SSDs for data exchange between Linux and Windows
systems. In fact, we are already users and beneficiaries of your work
on the exFAT driver in many of these scenarios. Therefore, our main
concerns are:

- File copy performance for typical user operations.
- Filesystem consistency in the face of unexpected actions, such as
  users unplugging the drive without safe ejection. This is where we
  believe journaling support would be crucial.

We are currently preparing to test the ntfsplus driver ourselves. Once
it's merged into the mainline kernel, it's highly likely that we will
provide support for it in Deepin as one of the early adopters.

Please feel free to let us know if there's any way we can help, be it
testing specific features, providing feedback on real-world usage
patterns, or otherwise. We would be happy to participate.

Thanks again for your work on this and for keeping us in the loop.


-- 
Thanks,
Winston


