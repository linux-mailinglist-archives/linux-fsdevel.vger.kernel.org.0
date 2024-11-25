Return-Path: <linux-fsdevel+bounces-35846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5B9D8DAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB521627A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 21:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66771C07C1;
	Mon, 25 Nov 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YhwAETQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBA17557C;
	Mon, 25 Nov 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568681; cv=none; b=kYEJpCX0rbTUf33eOVXcDsOAztGaqD0+df/V25hPB/x14nhAGC5aD2TsrMQcULR/BrLeFb7iE3KYJcFf7pKnfA4C9luk6rI4lijLbKYD3VoE7DwE619cLZtp+KUO6xEDBK+fGb8CfB1jb/9rjrA6bxyZRDeNhm9+XpEhLStIn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568681; c=relaxed/simple;
	bh=X/sAH1gvGBO5cJbUmKoelplAjOvfj+hleCFSjBiMvBw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=W3C50oI+TZuOYYuos/OA3yBEsQokXWcxeJMVUatdGVlLPaGK05nATCHprhptozW6jrT81ThkpwvrJkjXGLj3aX1vx2+AlB3VLAW7ffQjofyfU9XWdEwkErDSqF1CX33gGlACi7OiAGqHUB1dNNCWwG/Nzm9s4BD1iU3AJCvMrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YhwAETQr; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732568655; x=1733173455; i=markus.elfring@web.de;
	bh=u0vETTB5T1hx/wbZtMoorZhHTLPe25PZBNpijxuojDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YhwAETQrwyeWGuJK78rxLQGOy2BvbF/XeGU5xzP/3l6vACki3euZbSXYQDZJKb9X
	 TzizoMqTHHaIxS+lIt6nP8cZ9zzJMGpkcNmrmShm4FfrCFwsc6lqYgNPuOoE6MGqV
	 ROQkR9C2npOK10n7j7SRftklfZYvjQwTx+ovQzplqVWezdbSnm/gyX0weegvEbOGc
	 GW6IIXyozKFvMEbrk5EVeJAe/sfUfaXjZ4K/4+jyo12xVyBJY0sfJqX2/iRuSd2Qt
	 NnOjs+GdVfy0DEgU7y7UGoJwPyJQ/uEk2D9FYGdvpbHp2kM2FwyNmguTT31slVfM1
	 mN3Ot9c2jL8YlGibDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1t7skF25QS-00UAsM; Mon, 25
 Nov 2024 22:04:15 +0100
Message-ID: <e9fc95c2-1891-45c3-bdf7-ec67426c0ddf@web.de>
Date: Mon, 25 Nov 2024 22:04:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Kunbo <zhangkunbo@huawei.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Liao Chang <liaochang1@huawei.com>,
 Zhang Jianhua <chris.zjh@huawei.com>
References: <20241125123055.3306313-1-zhangkunbo@huawei.com>
Subject: Re: [PATCH] x86: fix missing declartion of init_fs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241125123055.3306313-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8TCPHq7GQfcGQuJ3K7cFYdTm4SPrbLaTRSc3elRZ2VFnH5/6Cet
 vAuPtSZd7Sc3jpyzAB/hB6jaELwuDyLkMy3dcmSVG5XtpNJXL+DVFWv4OWCjMT9kvUVn12d
 AtQ/s1c2AZ+OYwLC+DUZa1hksmNECFVF43UFjvTpC1tzFLxG1/dnfMbIaAqYb0p8lOCI2Ac
 O+g9cEJK5I5JK1R8UZ4Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+w4bEmmUlIE=;NRu6obdZE9jmQqkMj45l72f5Wv8
 eJtEsANUiKqu4zbbQEnAkwOgOUM5WOiwLgzGJoeGYVa5wD+ngLbEyyv/gv8eJKEydLFzo3LPf
 17wTd4WuP7HXKmV/ubi4aBbnCSdYfKMts8575d8t/FLOItP8s6OfKaLGpQ41ZCRids53wPIVV
 pHoJF5US9aXNVFAAnJJ3b5lb184sjnEMt16BCq6lR8gCTmyJm4xMnMJ8OQb00eb1O8kRYMiW/
 7Pj2jonFvjO4yUfxKTK5dZKsTuHOVwZ5H0Xw8NdC3SY9tTxFHxhBaywEw5uZzQOec9VHeVCoc
 tEmLJluqkHXBtoBsREAq9yBOuiD3InrJlis0dNFCWbr4XAZDC0+o9LEQZfo0PVUoQt7S/7TKY
 mK3OsJe2kmdR+6BapIoWTjRe1RMfwrHxIlh5/sQb0z99V+QXdlvxN4WTqbi+7bXHMdBVtXCBR
 lbkksSLYFLW718ex7jsdD0N1e7hhz78+/+R8GatGWmz9U7gZ2df8e505woVKz6uWeRTgn8s54
 77Y9Y3jQnF1ByXxudAxR/hn2Lt31cjTx2IjMgzq7CxEHITU/+QAqDtAc3jk2b+i6ClL55Vsnn
 HdZrDrKY4wHVi06LXSKk6lfdln3sm6x4JIdDzSRYYCLUdlOF9N7RVRGtnwAPH/VP2DYaABYhq
 w4JqUlUOii3sRxR870zVl7YlFpj7x0G1YjuUOVqbAEvMO1jqVaM+jcn3FtQmhAxXB1WcI9SyJ
 3Aqpoy8B5kBknzfXVs6OUC2ockz0EA29Nydgw9udvehzWHb5nKM0aTHtbv8z3fCCPty0B98f0
 hdeDQdjKiTaoap6Amsi8fgS+f9L2H5PHOZk6NdEvy2I9PeWzkByMfw4k5sM5041SfmSAj7wEO
 HiNmdgmb4lDfHJdGY2+w4EuqFoC3B45KODapxVSY8qZ0DZgl6d69w9vst

> fs/fs_struct.c should include include/linux/init_task.h
>  for declaration of init_fs. This fix the sparse warning:
=E2=80=A6

Please avoid a typo in the summary phrase accordingly.


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n94

Regards,
Markus

