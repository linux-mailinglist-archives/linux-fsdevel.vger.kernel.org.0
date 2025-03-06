Return-Path: <linux-fsdevel+bounces-43389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376B4A55C25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7099F16FBCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A639ACC;
	Fri,  7 Mar 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b="fdszT5lU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing42.cpt4.host-h.net (outgoing42.cpt4.host-h.net [196.40.103.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC61E868
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 00:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=196.40.103.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308338; cv=none; b=NSvEA9bSAu4DffllajzCw8hsBAICU9lWAI763e4JUfAbB/yTCb6uqb47PK5tR/bqj9fgMfeUMLTplbPePgKu0NCs4KwtHIy5j0lu8V6ljyqk8enE6qs819gK3rKNqo1NANa5Wd7eKUjd7+DzoczAAq3be9Lezn7vLD1lzvbIQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308338; c=relaxed/simple;
	bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TyZ3OGkJSI91LGzJZ2BqamnST2YQ0KDElNdEwa4pCMcAGVTD8API8Im4hJNH09YrYu56kbzHWF0U1ktLRziBT8AnuE/flWt8MgHmJTVV4kxBIkcg7x8GqJzKrDLTNO5DWZZ4P60IBU4cLYJpiU5BxUjeIvav7DkDzkGln8XusBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za; spf=pass smtp.mailfrom=delugo.co.za; dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b=fdszT5lU; arc=none smtp.client-ip=196.40.103.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delugo.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=fd
	szT5lUJSy7DxtACUwRmO8H23azA77vhHtGA6WHrXfUgGWdnXSTUKUkd39vfxQeZtNG8j8/vpxI1Tt
	95QSmT24qm7gXtuE/ut6nJn6cAqfHERn86oEdGZqyhq0kLXRmKPyDCHQOB4izuP6o62Ma5/26dpQj
	zjX0c/H+eIu8mMub0TvZxjQKv7F15pjV/RiI5SkACMcCU3tRnQXCwx4lkXv8V5TTQwL+JnAEBg4el
	lNe5u66MQFGmc1Na34UBc7auUStArax+SgcQTbmx6Z3n3PeIx9vK9SEAcbEncdhcCPwHObuEVfKuN
	z8nM8zdbbPN3i6y0maBhWAeWAyWFOlbw==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam7-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5n-003lTM-08
	for linux-fsdevel@vger.kernel.org; Fri, 07 Mar 2025 00:53:28 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5m-0000000DoEu-1M5b
	for linux-fsdevel@vger.kernel.org;
	Fri, 07 Mar 2025 00:53:26 +0200
Reply-To: barry@investorstrustco.net
From: Barry <orders@delugo.co.za>
To: linux-fsdevel@vger.kernel.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:53:25 +0000
Message-ID: <20250306223012.7D27E715C4A0FABD@delugo.co.za>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zyE0bo4oPct+bDQVYek+zXGWfva1JMizjpICfXk17zgio/
 xMM0hxORRmMMI7DUTwhVA9SPcL/W0vcwYrsq7FSl5g+sHZmT3CLVmxntdIVybTJYNmSEo5h4A8mB
 EQGQFHTOfdaDOdBDzkNFcw6wiPPKjdSdKcvSgkth/gRtMjdr8nTrWHnISf4pBNVoEYOHEuhQjgNL
 hnE6LCVa09fPSMLwzYS69kWBtyjohdIfAyfx0Iq36YELusVp6zmtkp3fm8ndx5QS1wGtE3dw5kR1
 xA9P5kbV9R37OxW/QKNPRzlK0m7EdPKvbRAIxZtm8n/jc7R4UKCObeQdNllr+FgloJnxjjF8n6wp
 WHihaGjoqMVQpDEi7ZakWkzmXGSGRv47yoeuqr0aikOvJA+DuzeF4b+ym3AhG426mliYkCHBZpOg
 oqc4uCQ1hIibn+MrIDYy2WBZvd1k7AMVUvw4r/dmrv4vMEE6KEyh19rc7LZU5nlp0w2QEetkvH00
 /xmn6oF5z8skuB4fLNdsm49znGEOwW1RyaT+fhnmPmZ+OUuV5BM6eyy5Vo6xOiF9lxkCbdmQZuQe
 XtwnM4mcbWysr2YMYYoYDEzAcTQ+ZJgH1Z1+3b83AfWsQEEhDkKSc2GS9e4VPWvxpEs8sWmhpCJq
 IKaaP6UNsV+DkDiP1EOo5xXzAYM8DnoUCRtiibNtRcSkfQsV9kzYkCTxc1wWpG5TMsRZ+NKh3yVA
 kqJMXGMZ5q3RC4mcsR9BkbZwFIR9qzhTBqH6CZcLPO/oW5PPS0V7f+hYV6Kp7bMVBkO4mg45odS6
 9JVpMf4DRJlNLZJ8G17BPcd8PXxtALl6tE9e8KCaN2ryngAy/NgUZ8j9YaZpO3ZlH0zrBe37qhsk
 voQoNmsEmMLwFvJD+mcRIVLlniKBCxlkw4KsNsj0ZNx9ROADUXTdQZTyOc+Zhifch8RvCUcoN2t+
 NpJ8Q8WvagIl5rtD2DDRik+5
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker

