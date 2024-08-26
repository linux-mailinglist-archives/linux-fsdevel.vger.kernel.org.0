Return-Path: <linux-fsdevel+bounces-27180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1195F35A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E8AB20AAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BD18890F;
	Mon, 26 Aug 2024 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nvgrh7RX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B508188588;
	Mon, 26 Aug 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680582; cv=none; b=jAtGZ2tdgWSRHEVQjjNJ1ctrecCGeoCTBLuXrVQjGZ/bbGK2PoA/M4D6yD7rWjJCb9xaLvrQ1mYkNs198EkriPNMoieJbQKSE4zr/b7M2X7ZRmqkD2LoTucb9UQoe2MfWxOO4c/ULMwfzyFib37ESVe7m1qr7VlLWTC5qTHz6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680582; c=relaxed/simple;
	bh=yUh/PbjdVDRxVpF/67lzvzXYxBudQEH3r7sO0dX3+oo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Gt9JhKu14hq74OJMnq386SD7cRCfymbO/RUZe6TrBtp7DYsZBrNMzVeMl1vVEL5gef5I0XpQ71s8RjSU2iXy4akRHJ3dOIJg7QKwUPfwb4JgNGkqD0pNKpmmAr50AfRWlS2Ze2QjRdi0d8jqLKNAJ7DGYG2LbTek9TnfwaC9Uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nvgrh7RX; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724680549; x=1725285349; i=markus.elfring@web.de;
	bh=ljutM5Y53a9lGEfXooTYa7wadR0GIhj1IYjFGa40WFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nvgrh7RX15Ac31PPghZGdKOtpIxEnMvv7UtmkCjPDo3tDIehXJ38ynLuZNMIqSTT
	 gc3O4cK0jg/p7FCovMLQEX2/9DEcqWD54h1hOAnax2bH56eZ3L+wT8MIBZQ7BGlcQ
	 lHgDWkKAuPpX++rRzsa5lEA8+79Sf/wr+A843Uqlz/HsCL77pSnRzuja/MiNhbIZj
	 Q0wg6cLaBBSLjbnLsxfgxWMQBd3OMuEzRXQPbd2HuJtSEHkPU82clAqWQE9t9corM
	 PGhKxZCHs3UGd2uA5RakNaQE/X/9lK8o8N1MohoEjNz9y8/4PivscpAzoG7OpyCZH
	 Wm0R+pfCwDY286V2yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1siaCD2eYq-0014VI; Mon, 26
 Aug 2024 15:55:49 +0200
Message-ID: <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
Date: Mon, 26 Aug 2024 15:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Baokun Li <libaokun1@huawei.com>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Hou Tao <houtao1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>, Zizhi Wo <wozizhi@huawei.com>
References: <20240826040018.2990763-1-libaokun@huaweicloud.com>
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240826040018.2990763-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PSLR65nK0lrzwvj7aCO9Q5QQ575PH5NO4WNx1CzaS5+UEojxG7C
 buOAAyDAT148MNNGAPB7xBJ8yvQGIgFXKtemIZahq3sIoRu9TpbjYfhDWiq+2ktNs987Keo
 1+2gCpSu6fysH172XTpXZ4C+6SZnII/EcJ5sqwSd4/lyi7+m1fnLlcngJGrqkqv6gNvD60N
 jihrE3BDCtu4jgWe+UA1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kWz6dCq+QCA=;Oev0cpJj8SFp3IYWlRmTfc+vk6x
 ULO5y1OqDNMz9dgmRY7vwVAyRoJCQMdbPS7xd+Z/zqQas36onHhj0yAYtqwRjLMiBvnDBUngC
 u12pYqjEnR6DEx7t5hnYHonHFZZ9PVmjmxoWLX3NxdzlHcqm6kx5LjWH0TUh5rJ4V+CFsin6v
 AxSrBF0WEYYxLYczmL++hgyl5rZaoMMtcYYaVJhIJ+pYYiOZQm8DbjlqHli06u0QPL2ivd9h0
 pWpSC0233evlVhZ7JSvTZJbtkOdIzDduw08vp7iXOivwFoLHsGXEkYn7iUl8zSo8xjOuT6oGi
 QmszX8Qv86Nv4s4DCxhp47gAPo4cbf4/29IkLWy6WRnbjtRV5dDmNFbp/0jwxKbAoE8wa+kpv
 jAkS4P4zGS50IWFq3KYlArx4RA2Cz6T2d5gaghQqo+K8ya5i6JLPipZQwYVj64ihz2AE+dAMC
 CYuB1A8eaCiQfDNczZbLUgmGHoWQS3gHCJg4stYda0QadFGU2LCcO1Y4DPUsS5CJ7GQW4Rxu7
 oZwNL16rJvuyYDOay7dzNtmeMOzqZmwGzZGPAOWA5wdxZPeuTw1bbvTMM79zEa1oOw6IUAR1r
 R9jQmn3D1jrtcEKcpIDB/PyAEgsg+plOhNJK5FLxZRKcq5YUxN3FRtlhrX2gC1bOoqEjOtXbY
 81mCG86t3onqhoS3fJXwUUOk9uqHtdDf3iHOOrx7UE+7JWV3lgcLoTf7YZLHbz7v4fTpI89zf
 m+dgLrBNv3CNRAt6ByUM/qZobRtQl3HO+/YcFw9pJB7ST7nPeO8iI/eaSfh7579pnWIR+ycob
 TG3aXi4nrhj76LWaJuy1v+zw==

=E2=80=A6
> Add the missing dput() to cachefiles_open_file() for a quick fix.

I suggest to use a goto chain accordingly.


=E2=80=A6
> +++ b/fs/cachefiles/namei.c
> @@ -554,6 +554,7 @@ static bool cachefiles_open_file(struct cachefiles_o=
bject *object,
>  	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
>  		pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx)\n",
>  			  dentry, d_inode(dentry)->i_ino);
> +		dput(dentry);
>  		return false;

Please replace two statements by the statement =E2=80=9Cgoto put_dentry;=
=E2=80=9D.


=E2=80=A6
> error:
> 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
+put_dentry:
> 	dput(dentry);
> 	return false;
> }

Regards,
Markus

