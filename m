Return-Path: <linux-fsdevel+bounces-70527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB02C9D7D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 02:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5398B4E4FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 01:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E1F22CBC0;
	Wed,  3 Dec 2025 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JkH6seBa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host10-snip4-10.eps.apple.com [57.103.79.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3C4C98
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724563; cv=none; b=idSYST6NidPzPc7T8DwCrCGqRoKqDnU33KBKKbtkr2Xbndj5oLBdZt5kpXNec86/6siB1PuXXaVB8Y5uFK+HaRXHorQW2b+Ff6O23NQEVqhKlnNAlDyK0+ErwMnP+Gd62cB59D6wC+sRO/Km0wKHIWrHT3GYZos35e5ydD4XL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724563; c=relaxed/simple;
	bh=5tWJUJG6SnYBuBZeZZq8cJ7glHx18gRawtEfzjWMsRI=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=ZCoHpZXDo2stdbKh4MjueUPe4xmOOlDuQTphemiAtN1k/zF9IJhZh61Tg7Wl/FDzWFsWIgg382/BI0DSDb+v0fpNc9hY2GSDqgO7c5hPoqmvHQpSPRXji6ziHysWP3oSwFNQDp3t+8xk2ftkwa1xIuqvjOw6MHwkhKiWfMnIKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JkH6seBa; arc=none smtp.client-ip=57.103.79.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-15 (Postfix) with ESMTPS id 3818218001BD;
	Wed,  3 Dec 2025 01:16:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=5tWJUJG6SnYBuBZeZZq8cJ7glHx18gRawtEfzjWMsRI=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=JkH6seBafZxmRVUdqc3Y+w/lZStjRgzre3CmqC5FHW7oU2xRXWeyjA7HZd6I0qd6Ewa+kwC6VjyH0rOEXwZ9HihSzTRDDCb0o0ox53/njNu3gwO1drb8Xk3WysoxUNfRzwIORbMru9cAUTAi/VuQHez/h4xji/rsLsuLC6YYzjtB7PqKCZIMcjkt2bvoHpkHhRkioVBXKgCy+Hv0kqs72RSk383rBZyckO1OOBZB6i5c9NBTaC2nf3IjxBQrO6on7dBfoV6hEmWaJrfLW9nHQZzw/5A4JVjE289m/OkoAPZEkP42w1b4Y5lm/ycr9cIew7iu8CPLRBvj4/vIR6WrPQ==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-15 (Postfix) with ESMTPSA id 742FF18002A2;
	Wed,  3 Dec 2025 01:15:59 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: Abdullah Alamri <alboodalamri13@icloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 3 Dec 2025 04:15:46 +0300
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-Id: <FE7FB0D0-6CD8-4D1A-90B5-DE5487E378B3@icloud.com>
Cc: James.Bottomley@hansenpartnership.com, cl@gentwo.de, david@redhat.com,
 greg@kroah.com, jikos@kernel.org, ksummit@lists.linux.dev,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lkml@metux.net,
 netdev@vger.kernel.org, tytso@mit.edu
To: torvalds@linux-foundation.org
X-Mailer: iPhone Mail (22G100)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAwNyBTYWx0ZWRfX0CBsIh7m/AhI
 FhNy9OzFBRQ6lTdilYWlw4niVyHgZMB7p7sqUjhg7sYgMXFbCpcuXUkxXQP7bUNVhQT5A4mVhGL
 aTDsXoMI94SJ3kbKufVDAQSNfd29YBw1+3dDV72x2UvvDWI7Ii+VvoDbwpi3/xF9TvBId2l4+Rc
 32t58DeXW9SSJ/VpkJSZ9cWKen7G0nJ/b0JoTZmImWFe+ITLPO5d3CRz/3zcAlEc2e6DJvOhwl5
 MaIfAqOUxAn65qV7sN9zyYXhUDARNcdYdedPQSS8PGC5F7HKkc9GAaXBjcYDRN2IumQS9Dvdnb4
 Enc7JD+t8mfq2shPGrT
X-Proofpoint-GUID: es_qhwUAhhCMzL-D7iYTN7TCo308goSO
X-Proofpoint-ORIG-GUID: es_qhwUAhhCMzL-D7iYTN7TCo308goSO
X-Authority-Info: v=2.4 cv=J5ynLQnS c=1 sm=1 tr=0 ts=692f8f50 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=x7bEGLp0ZPQA:10 a=-KdL-90ardkA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HyzYxv5D6p1NO4_E8OwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 mlxlogscore=666 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 clxscore=1011 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030007
X-JNJ: AAAAAAABcBUMmKYEjepPQWO9oz0fKF0xJR4oEUJJJhwb5ynuO3cAT5TqKmi5gvBxr6b+Pia+G2rXYHxNYB3vI9ZpznaL1pqVzmaGJF23x5psdUMBBcAWXvbSTGq/VJOIzbNDcy8vftXrsq5zR0BUygpb0/6VN3p871Ph1ut7tgYelUYZQbdXnFdO25/QKR20Quhjct26nmPnzwIIBPH1w/WgvRsl8hpGxnZu2szp3h9brZwli5v/9Il4K80B/3AtevYJChN/GIgKGNHAwMG1f9THHkrw2Y4+BIofgjwEtO46FHwMqkKmnmOyzHlJZIH/3WTRw5IjXHu9sGIClaXy0ViVT7lKpO2qytvQ9oRNaL4nwfFlRyS4jJOXayBnbv4WOizprxRrfZRg38cFMgKpEpdv/Vy7radCRRgdmGUcT3/tK3QDaf/H3CretHZ8k6yzLy3nhe20SzqVdzLDgSbwGeNN1JXJEJyC6uy/mQZ8xUOHGyWCnotv0w+abcoO8WMeTx8UJcl7HVhlxcqVwqpFcQqOzf66fBBzfoljzvrzMMlGk40i0bfOaU+xJgUZUvcgZ39/Bdq/rgCqzDsX+cNteNdYu8GASjdLKYaWgQ7HGzuP4BT/BwYgsyCAKh5eBgaALzV4CWUO2Fq/fu41Ha/Un+hrqWh9uETR7L5XM7++iFVl/jqr6WBvVXgbpEgzltgVgUeUxkmmb4cnFuz3BIaFNao4OoW9Fvuyu+tw9rHyb8qCGWmrNuPdEr8jmBn1wDyexpk4Lbo7ENAdhWx9phpMfvTyBpIgW4WFtso=

DQrigKvYo9mP2LHYs9mE2Kog2YXZhiDYp9mE2YAgaVBob25l4oCs

