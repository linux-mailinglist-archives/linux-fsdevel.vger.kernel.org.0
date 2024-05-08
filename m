Return-Path: <linux-fsdevel+bounces-19104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9848C00EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D91B2834D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA90C128809;
	Wed,  8 May 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t2MskHKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B0127E34;
	Wed,  8 May 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182039; cv=none; b=bGfm6l7+PnkZsd1UsB4Zw1d8CK1mmCuTJvPz3FlgPM91SyqZVKgLrRXAjQlMcjc3Fd6bpq0bqDJoQ1bi0aIiWcuKf5DNxHBU6SQ8qAHXSm8UpIyBPLcSA+fUHcSJTSiCsyJcEFwIyxeghu1GN6Wbiy6do+iNmc4Vvt9n1xgX1Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182039; c=relaxed/simple;
	bh=30BMWygZRqiSShvHoklYKTsN7TVm6Icorw++XGsDjSw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=M1sUIjb7CsFupPu+QozdSvKceVwrdQzlMNJgXkXUISf9o+RtIZmQa8ceJ69C9DlH5dDZBivz0qulemEYCEVHXp8PLKUayhwMM+GEGGa7Fd6UarCKxqNVxUh00bZzAaAJygaJN0BC5DhqPUTg/iae/nYudTTLD7hnCU67tnEmVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t2MskHKb; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715181703; x=1715786503; i=markus.elfring@web.de;
	bh=9rQabrK2Raf2SKcIgPyBDRJ5iG3PxOpR0Xkwy/TzJWw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t2MskHKb0Of5NFjqxonR9ZlRIWobuI7UGKCQ4vyDnYjCRz8FaMQtE2DIxXo7vTw+
	 mqoLz5OZJi/orOU16D1urUHwC8+HvY3uujB7wRUuRlD51jlMZ2E1C+6HfNnkHcG/h
	 bkeb5lOmn2vJhOo7CX7jPCXezwGRvgy9rT37ElLXfKhFtqKr9NWkMfdaR773AEmOW
	 RELXYDh7VaffpMWzCk+MXpunHUlRc/AFLTHHv2IVnJ7/u09jzNzJ7pvvSgNJU4QpR
	 9refhvsNFHXvnSXeqf7u57ynhySKrAawiYBJpn+Z2+qlkr5BWhdi1C0o0RwNeVxQ0
	 XMZ1c8eQCo/6hCrGLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0Tg-1sAJiE1nFM-00W8cY; Wed, 08
 May 2024 17:21:42 +0200
Message-ID: <124a0129-cdc5-41aa-ae75-24bc634a3599@web.de>
Date: Wed, 8 May 2024 17:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Yu Kuai <yukuai3@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
References: <20240508061220.967970-5-yi.zhang@huaweicloud.com>
Subject: Re: [PATCH v3 04/10] ext4: trim delalloc extent
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508061220.967970-5-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TdTi1GocL5R+/LolUyJ5iuqhI57idnIbgj7SktAWk4Lh+yWylg3
 Hnr7Xs0nL1G0D6C/jX6HZP5SXNPGQh+esDhQuGUME/9D6asHRf0Ft3JXfAp2FFayyGe3EKu
 e/6X+fA1ijBwO9/BN77rWCArDmyAd6LdSqn4CA0jeYO2RAEzGonHTERnR1fYO/MU0jabeGX
 F4KWsQKulxhTO/PD05XzA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HPgSntqVZXk=;EmEpiuaI6KrG/wLL9do8kWxAFIh
 5N54JUXpNjkPMbyiehcb84o3zJRX1XzFHJDgtLOQcj4WjHfHOVTJr5jvzsO4/sQUg0mu2rPbv
 9p5sl31Mj3F6Ind2nLjdsmi3oNkoI5Im9I6HibfWWlb8pK5R7OsHYMUlB4y/JC5PhQNW3lUfR
 baC4ZSoniTtlyCrhTG9fn/YMftvePlhp7Jt+JDw+k1mhkgXaFbnjsAdBkBwppq15q3bFD3JY2
 n0+R4ANj0HE4SgjOJpwrxPWVtcAMG9GV1/clVippz7uvE/A2TnEeOynCCPNaKuqhLhMedCAfy
 WrCmWtDdt/hBAoJU6Zu7aOelJjY8PUEi/is80SLRynGCw1SoEPutSnBOJmieq/RX95FJB+SI1
 X+e3jJkbK39tb1rRkx9RpHHekyXikJ9w+cEoBlpDGjtKAEsaraTb49UiGZ4TOD0Q5811MvNbK
 iq50W15LKbo6ybAoe8iR4eGf6jI7dxFFnWw/bCEj0eHcH0No+vXsHDrPd+QGdUfL5h4jNZ/NN
 IMo7idRAZnfkCnNweAQdMwT36i6zbpbMenM+1AqtAR80RTg4UyUu1+8RuMOVUYA/lSOnP7Mh3
 ZrqOHpZDLHQpPzJiRPjjFYHlmr3qr358iWOPF6wIPyP/VEmCC/vgMS80mI3NrvIfY0qw3pYrR
 UT3XkEZv++GL4akwWa/42OjK9cwzdXs+QMla8P+GTA75Fdm/MD7fHcDPHCrDPtb0QSBE9mGLB
 +bexAH6dowQyA9R3zHAO3Vhqu8X18ii+mNm76BA2Iedebg6yo5avNaKRKzVKRFi/daVHUDqer
 90e7q5j9DgDOKxeM+KRYt/EshQVt4cGHol8JuBrjfobig=

> In ext4_da_map_blocks(), we could found four kind of extents =E2=80=A6

                                    find?

Regards,
Markus

