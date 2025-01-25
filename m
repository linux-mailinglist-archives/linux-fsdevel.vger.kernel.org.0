Return-Path: <linux-fsdevel+bounces-40103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D31A1C0C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 04:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 582CD7A3663
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE262066CC;
	Sat, 25 Jan 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="LdqboXDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C92066C1;
	Sat, 25 Jan 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737777163; cv=none; b=G08axNwVOg3pEF+YPmUoDl9JeiAztS/YEHiRGWiQ2i5tG6fr7nNIzWMHhWBbwcwylqzLyaVEUiZWxtMMSItpcpNrhBakvRemnctfZKbf/kvhShpc9oFXoAPnJdsQ6/ZuWI66io/AIfpUOLfXeq2Hi6VsJL49h8rSjKeCwnLRnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737777163; c=relaxed/simple;
	bh=xpNQLvnCdSZyumgDckkK3e6pQATU0xoyg/yGpXzwgLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QjVmHhkGUvJqcHxjGaahuy3p9ppR4czYJIWmYFL8uZd1d7DBPbNCtUAO/aZyX4NPZFrNUmoCneUPYyyPYNA0hJiYT7z7/qOOAzbV39NHiFJfIb9RIOwmnuyaRC1MUQ3Rzr5qCrkD6ZL/vUkEA0UtaelIgq+EQAgioPyrO3HbTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=LdqboXDA; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1737777043;
	bh=xpNQLvnCdSZyumgDckkK3e6pQATU0xoyg/yGpXzwgLg=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=LdqboXDAmMztVY5JMYAvxXwyQsKSQE7bCC2huFsCbsyDDMKEeOzD+e8o3WFMHc4is
	 Ohw9nTFpU3D/T/thIG1i/tLQc5VdTqpG9lVHmLySJQq1ezIQ1igOYpUaCVYOsbNhsy
	 NP/UUIT7Upovwkx0YwGOo/O4CaSJJ81ahbxaYt+k=
X-QQ-mid: bizesmtp91t1737777041tjiexn1p
X-QQ-Originating-IP: Al3Hw5ojLyTfSOGRYUBKyMZJfKa1WF8GQy9lDgEWqeI=
Received: from smtpclient.apple ( [117.188.120.194])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 25 Jan 2025 11:50:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1481731289417788372
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
Date: Sat, 25 Jan 2025 11:50:29 +0800
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
 "Yuezhang.Mo" <yuezhang.mo@sony.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 syzkaller@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E64ECC05-7973-4449-B376-5626D4B2A016@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
 <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
 <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OKKHiI6c9SH3aQW2nzdnxBWRbDpTkj418Ou5MxX209OBYTYa/KqrcZNh
	k/izwcKM4IIROJSYsihA50r8D/GMrYKYOhcIoV/TR3cSg/2LHb0k/cwX4awgvSDdGvBTpHm
	93b/SKzbIwC4z+lUtXzMbLvwoG7L6AHuaO2PwaqDectkyd9X4uM9BPQpA7vjpI0Uiie5Ffe
	lEBuyA5qk+Q8yzTOnVGezxxD89Gy30CUQlEYPlybbXf3knuoS98fMinf+co1gvA8zqrZhxh
	IY07VkSwTf2xAP7x7kbzpUdccroHZNyrKYllGfdZdw6KnPQXW8J8zZAbyuoWhpCDFG8UpXf
	blF6LL7OAYT9BVaZ+e7y2WlG1W3sRPYfwj/jtUz+aN7boHM+J+yqPneJPXOaH0YqTq+uz0i
	i+yZeGd62VVZPt5cHSa/L22yjx5G5thTzfKSrW+KBy7ajeJTbzcnEtVByspGyLrO0S28dPU
	IC5QTj/6bhScg8DSlzbFad3rs7gxjXyQkV7ktIn6LoLLbrqW/lyidawghpa00OV5NdbyAyS
	hqAuJZGDGRX4f0q8yw4LT5SnueTx6Y6CyRp8S69Ha3JWoQmfFoKeUIuO6TNw6eWbrojzM/2
	FYWc8+4l0tmBlaEx6FIducFL1JWV5loLw7SRT+/dnc/knJFRL/Es4jfJ4wIl4UzVehgDIs9
	D0rBv8z6ylG9rgCohWM7Ni2GhP+Swj9n+1mQ7IiXYA1D65yelTcMcE7NNCRWGzqPxf1LS+U
	C4pE8nNE38G997FuyIJln3mjsOJzc5YpWqdofE+/p1gHqBKOZs4PsJ36Wy8mafApHegqn7J
	XbewQk7G2okKPFnk9RAMEnXT2Azyhcd9w1QzSQeZuXmzFoLRQ3MXGJhmk6sd8rMF96NeQvo
	oFklCYYcTvgB4wNsoE3EP+Nml2s1nbu73aBTjI8rPe8/Fn5aLpn9DmpHIjCynXLUtAwqYAJ
	ONqWO+PNs1FgAkQxJxzrZyVoYqUR7rqdJW6DWL/dO2B+u14efPNkTCMQWcJkT9AfZLQSgEi
	1tQ3ZsQKBGypFvNdFwy6mXerSVPa0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0


> Can you check an attached patch ?

Hello Namjae,

We have tested the attached patch and the reproducer did not trigger any =
issue.

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun=

