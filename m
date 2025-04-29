Return-Path: <linux-fsdevel+bounces-47551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FBA9FF98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 04:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96823B4613
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 02:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED73F258CEF;
	Tue, 29 Apr 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="mhiVYgSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115.out.titan.email (mail115.out.titan.email [3.208.11.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DA2586ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.208.11.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745892982; cv=none; b=OZaNyZ1nwcmKQtRBTQt7fLlX8VlAywdtsQvG+d7VxNIhZZCW2F+fFE+OKUIlO+S+JME+cgxH+zZhKxdMxMED5WIEOUtBbTjFBijwwJ2CoGXN6J8MX3Wh0Lolk9gzheqIyw/wxCsMw3t1kxkE/eofNAcLZ0UuJXPLQcFuTj3/ARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745892982; c=relaxed/simple;
	bh=gZAOuS44MYhz7NBYoj56A+0XayAShTo+iK6h4Wr0/zc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=axkaO7naD32Y5TIL72Mud1IGqdoCNjPnVHNM8vdLHItvoHrdP4nJsreQhXFtRX6RrykyKhgHDHzADoUmtVXCNR7C2M+29eeNpMUgUSFMfX6uJVmpIaLrNjAozd7Ii4olJ2GNjDLvsFsT764v4/FerP6jux6Wqols2sQmaQsbJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=mhiVYgSv; arc=none smtp.client-ip=3.208.11.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 3CEEE60472;
	Tue, 29 Apr 2025 02:07:11 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=gZAOuS44MYhz7NBYoj56A+0XayAShTo+iK6h4Wr0/zc=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=message-id:references:mime-version:subject:date:from:in-reply-to:cc:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1745892431; v=1;
	b=mhiVYgSvo8a4gBeShc7PpourNwPH3KKLmy1CRTfFs7pFHZtO8r4reAKeYjhFEOnOaGJ9/shg
	n+KcM5zpLmfFOqCYSdzWayLPVbbsCh7pnUwklQl0SVRGvlxRGF2ElPDf9nVEwRARBhWYlly4ok7
	azd+pMZuRheeXmbqIhItRxxI=
Received: from smtpclient.apple (tk2-118-59677.vs.sakura.ne.jp [153.121.56.181])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 6FF7E60484;
	Tue, 29 Apr 2025 02:07:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 07/17] bcache: use bio_add_virt_nofail
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <227da5a0-c5fd-432a-8227-7a5d8883ca0d@kernel.org>
Date: Tue, 29 Apr 2025 10:06:50 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org,
 dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org,
 gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6D90517-F3D2-4E32-85FE-53B20710E13D@coly.li>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-8-hch@lst.de>
 <227da5a0-c5fd-432a-8227-7a5d8883ca0d@kernel.org>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1745892431077720643.5242.6730310602892018715@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=fZxXy1QF c=1 sm=1 tr=0 ts=6810344f
	a=hXS1xhdqaCDGgKeHTjTB6g==:117 a=hXS1xhdqaCDGgKeHTjTB6g==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=9MUAQWKrSuUz9z0uTEMA:9 a=QEXdDO2ut3YA:10



> 2025=E5=B9=B44=E6=9C=8824=E6=97=A5 14:14=EF=BC=8CDamien Le Moal =
<dlemoal@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 4/22/25 23:26, Christoph Hellwig wrote:
>> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
>> bio_add_virt_nofail helper implementing it.
>>=20
>> Signed-off-by: Christoph Hellwig <hch@lst.de>

For bcache part,

Acked-by: Coly Li <colyli@kernel.org>

Thanks.

Coly Li


