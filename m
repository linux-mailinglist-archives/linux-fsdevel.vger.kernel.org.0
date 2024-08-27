Return-Path: <linux-fsdevel+bounces-27328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838196048A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC201F2347D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9D197556;
	Tue, 27 Aug 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aKMwwYxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692D14A90;
	Tue, 27 Aug 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747723; cv=none; b=nVE+pR4po+Zitz5UAgyzfVxvJl/BtpXtnrs6HJdi/JJLrUCZ/Q76QxboniG4rX4WUR5Y95GfM8HqUzfzVTjDlGhln5uwTZmyIMf2+uqhpCT/1tJlRCV6hetSvQ33pIGOMJCSiAE6WtohQ3luPJ5jXwRvG5A1br6LmnX69NhXrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747723; c=relaxed/simple;
	bh=WwIc/9QF1+FJ1vpb4mzF7JnThLd7UPgJ/cLygGdEb8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lME1NugAr9oeIdw6Q8Z14fmM4BJJB/bc3rMLA2RczcanbRR46r0Szy2WtJhz3XB5lrVbTnYxnvM2hQXDbdT3HI3ALDrm581oQr+GZc4U4jkYsgPuXUQMLZITUKCngLAXldL3N0iLvwKTCXljTYrxEaj1Hb0NDq1o4ogw0xcb/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aKMwwYxx; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724747683; x=1725352483; i=markus.elfring@web.de;
	bh=WwIc/9QF1+FJ1vpb4mzF7JnThLd7UPgJ/cLygGdEb8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aKMwwYxxzqIVYjh58fGS7rI9Ej75R2Jrf3rA/dbn02nLSeOxu/X5XqxqMwRhxIOQ
	 hYBWyvyh14bR9AH+dd8s/OnqUFfK7+HNcnOxt03njIm2VWB9tk85V/cJikmK6iDlE
	 gGlRu3HCPQo1l/rSn3zae8uLpBrNsiOxvR+gnIQ696cgUyqAwkLT6tbbt83O14BNg
	 hG+eY/T6iSYtQkhg8nj3HypRSHOkQW73UTSoFdYztKi76zX66cj5OevpNzt5FYXmD
	 zv1Q8y1jTpAqlavSrMMe6PJQmbuy0DQNDmby2iJAM2i038sr7My0ZSjsNRLjrxmuv
	 2g/TzfDZ/14DbQkzIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1rtNJF3x4J-00yYYq; Tue, 27
 Aug 2024 10:34:43 +0200
Message-ID: <73e33aaa-dfde-4afd-b6f5-650f89e6aa84@web.de>
Date: Tue, 27 Aug 2024 10:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cachefiles: fix dentry leak in cachefiles_open_file()
To: Baokun Li <libaokun@huaweicloud.com>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Hou Tao <houtao1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun1@huawei.com>
References: <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
 <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p6satjnTMk2pZSXzyh/98GqZzjBL2INK7YROiso8dFIdL4FOviR
 Mfsa9Olja5G3ffv9XPbnb+0HwjpnLotDu4xkd4+Y/gaooG1NmZhm6ZPyGgCXBweQp6hMhvE
 VrfmpHOJ82hvckRStkl8rF4XtxH6rvnVqQg3kmqiD9CksuTXOdNkqjCirwUC7EnD4H0JRYR
 EcoYwfb8xLPEvDfVQ1hIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M/iFpElMZ1c=;JKgNCnS64IdZhvdbg8r2YhnsMS+
 GFrQUFmKuDUXdTG6p7j1dce2WSV6KxA+dv88UdWJyF4A+SqZytpKH87s7G20WrC4onPdDYdu5
 sCQ1uNObtXcJ7N0igg6T8ei00cbJxmFSbH2n7ptmnvsK9ZwGSbVhwwWSrdjb73ft/RfIbfMoo
 hR46O1y9WUX6IhAEysPWRiQHRAcUdYvw8s/O3U+jCwcjpFBQPkZ4HMilr7bVcrrSWR/L2AFg4
 HlOKsfNERVQh3t4nth+IuDzZBar8Es5pUlwacS47sby2eIZlejODyDYc+4fp6MK80h7M6n9wK
 9a8Dw28OrPwBpo7mBbjQ3BCGue1SXimGRLK0vNugvrURv2thmJSjuC7NzHP14l6Tfy0y7d2s5
 D48av0B1nFLwaqZNeBnNnYscoDPGkFh/yQsSUt2RqBIpkLmJjm57EEHxsRamDZTcPKx+MICkO
 zYMqd1iVmbqfuGZB0GeMAbGqvNKUELOYuCEgLfqlLJxv2MquZUdvZhP6b2Z/9e11tLCwhWIBj
 srgPtLI82HVG3OPcnH/X9zErmw+iZYenRxbnpXBgXJJWqejY15YSh3I3AApng6bNnifDNmgmm
 41FZwzNbVhBMFybb9WEdjDjczWll0gm7qS/DswLLkFlEL+XcBOhYxjrRdTjMjgZQaLRIpHNAc
 d6cxt3GpBhnhP1T+fnOPQwRvfINJQFAu92L3N/FU1Lvyx60xBcg+cHKe/tD8uDb0rN2crN/rH
 H1vT5MuFuIiZ3R1X4MQEjM2Am2CYeyBDGWoiH0LATTU0JIdmSrLsCfChpal2jo2RXWBNxbcfN
 EWTh087WdCf3Y1h3Bm5NQOOA==

>> =E2=80=A6
>>> Add the missing dput() to cachefiles_open_file() for a quick fix.
>> I suggest to use a goto chain accordingly.
=E2=80=A6
> Thanks for the suggestion, but I think the current solution is simple en=
ough

Yes, of course (in principle).


> that we don't need to add a label to it.

I came along other software design expectations.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.11-rc5#n526

Regards,
Markus

