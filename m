Return-Path: <linux-fsdevel+bounces-77025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJELF2HojWkm8gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:49:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A6E12E84B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C1E8304AE64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B7935D614;
	Thu, 12 Feb 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gapSrQNC";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O0FA7yBS";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O0FA7yBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta41.messagelabs.com (mail1.bemta41.messagelabs.com [195.245.230.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD135CBA8;
	Thu, 12 Feb 2026 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.245.230.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907475; cv=none; b=pHcEVEEK7rbfjkU9B6T2SjSPos+m+lvUoS5OHq0Wrj7NNw3NSPwQDeGt8veYlLOJx4pmcl2tdaC0jGBbmA4ty5xSZXZtMLrjEI1C8pO1eiW2jPB+F9HKcCRtsxnTMFt2b1S/mIkxuj6Km7dw07IQ1qniGZbGlDnU4qWvLjLEzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907475; c=relaxed/simple;
	bh=0qI2wDlRiVDjHJSxny5kDsk2/uU/zB905Nc28yYvU60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGjgT4QRGQPJPrElNuV8b3WXK6nHXlDOgDfPw84prx9vu8gkfqojiGrjG2MTt9PN3U8K/UwHw9Zhylue2gf1NXcrapw7S76nmQtcPgdwem9RshBkFYXcMKxvdG/pk166++o/tEHVh49zjtn0a/NLqkt3FJGlEug7wijExO99Jjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gapSrQNC; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O0FA7yBS; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O0FA7yBS; arc=none smtp.client-ip=195.245.230.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1770907472; i=@fujitsu.com;
	bh=0qI2wDlRiVDjHJSxny5kDsk2/uU/zB905Nc28yYvU60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	b=gapSrQNCYUSJp3fqFiQCE86ujRDUD+6ty1OGTYVW33ERCA30BA8E3AcT2XN+21dW2
	 Pgw7grWZMs9OVS/hxSPCxJBICgkvGjx5OROZDb5zyltAjdfCiGWRvtIjnt8rBD1oqG
	 GRfNq3l9ehcyIfQZX8FPrJpaXIf95fkUEDfG5ojpuDsfCS4BtdpB1vobaucQYksBkz
	 h7YkciNjSmx+ub99jchz0zT8tYuMSK/2Hg7IWa70CWvBNbuYDeeMGmwreUgROzsx92
	 0XmsZ8QMtzh+sHvhrn5D4cx7bMgmqVlt551X8sD3kvmM9rLARcKJv5weVkAElkuGLv
	 JaWAethgQnJgQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0wTZxjHee+u14O05CggJypzVUkkoYCL7s3
  CHNmW5eI0gEZgRrcVuNFm/bVe2crGYlltBGYHY1ZCocDGhlDYmGWIMJSCjYMGgaHoQFCDdmoJ
  Q0JXIYhbC8O5ZP89yefz/T7PHw+BCi7ikQSj1TBqhVgmxIOw3YmEOHbvPaM0vmcwHk7eGcbho
  mcWwC+rvQic//EJDstNwwD2jRXgsGmsGUB9XQsOh1of47DbdQ+DleV6BJadG0Wh9etrODSfPI
  /AIbMTg13n+zF4pbMKh/NGB4CG6hkAC10mBDYuPObAwlkdCn8x2hFo8ZhQOHGqHsBmzxwKb/Q
  NceB46SUELi34shcct7CkKPqR4QuMNows43SHeZJLH3PMcOjWhhi6rusBQtusRTjdbWnm0vdb
  KwBtdy8D2lR5lB6odXDpeVsUvVR5CaQEH+JIFZlK7bscybHOE1yVjqPt9NzCdaAIKwZBhID8C
  VBnRu+DYhBIYGQyVTzSjPsBRp7FqJLTVzl+ICCPI5RhOmhNWvpjEPyPZAGUe+xl/4yTcdRvX1
  WttIaRUdT1ls85/gBK1uKUa+Ih1w9Cybcpx+kC7mrrNupReRnun/nkbqrNMLYSpsjnqBpT/8q
  CQHIHtWSZ+WdZAjXuPMtZ9UOo/oq7mH9Gfb6+rRJdzUZTo4M2tBSEmp/RzM9otQCxAsgy6g8Z
  dWyCKFMtzZFo5GKpTCT+ODZLxOSqlSom9iOG1SSIcrJUIoZlRWyePEuWLVIwGhvwfVLQw+cTz
  4HZZUNcL1hPIMJw/pVSo1QQnKnMzpOIWck76lwZw/aCjQQhpPh/3vWxEDWTw2jfk8p8/7iGKY
  InDOPHu3yYz6rEclaas4qc4AWiqLvYjhJzD0w9qABTKBVMZAT/rymfSvpVSa7iadHab4+ATZG
  hfBAQECDgqRi1XKr5L3eDCAIIQ/lJv/taeFKF5uk+t+8UxHfKDf3KKRrxvyhShxyKOxz3Zkth
  Rpvx03WLaXvn57ae2vnSZuHt7dqFbciRxtDjWebwkxHXgwWaAxElgQGaqhJr9WdJNdMZU1PD9
  gGloD91IX3/Yurt6e6fX6tP59zMy5an7ch835F/rfhyyoXDPWmD31pq+sJ3cS39Hm8u74eB9m
  SMF5NSvjlleN9Fwrvu1dj2phcLwuwfyAOebJFtuik50pA/1BXSqJtJfqtFW3EgcahOMrlrZ8N
  3Tds7dNY3+M6Bb7JfAQdTpftESu/rd9wJZ1zmObelnrIdvRzdfrWsabahI2ND2Ce/IlEbvg/U
  Ne4HiVbRxEba4Dyxhxhn0reY9uSvj/bq3XUjRQ62lyfEWIk4IQZVs+K/AS4+BA9WBAAA
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-5.tower-859.messagelabs.com!1770907468!228754!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.121.0; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29395 invoked from network); 12 Feb 2026 14:44:28 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-5.tower-859.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Feb 2026 14:44:28 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 177F5100351;
	Thu, 12 Feb 2026 14:44:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr01.n03.fujitsu.local 177F5100351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1770907468;
	bh=0qI2wDlRiVDjHJSxny5kDsk2/uU/zB905Nc28yYvU60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0FA7yBSbJnF/0bttTalPSo7FkQmYeyYXpsypiDQ8dpNYAx3BiPML7oFM4TAhXY42
	 xnoGWcayNAp2rDsU0Kljoz/tax5vOML7hSw8GNlkWHdc70MUUGT4gZpEerqEia4mnB
	 N9LGD6B6tLXbgUXFtlVY/KOp1qXtDmTO4myN+NLh5QkOShRQhTYm6M+kITs9zaN0J0
	 GrdDiNpaMn8E8U6GN5htZwjbzcHZjuGG/b++Btj/PZFmNrNQiQYah2+pjh9NNMfS6F
	 AWFWM65KN/AmdmYXc04oEriVWJIddzd721JtfkqzpVRWETITjT2SpHhl3Fgpup1kNS
	 3jc9uJPoKVNbQ==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E89BC10034D;
	Thu, 12 Feb 2026 14:44:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr01.n03.fujitsu.local E89BC10034D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1770907468;
	bh=0qI2wDlRiVDjHJSxny5kDsk2/uU/zB905Nc28yYvU60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0FA7yBSbJnF/0bttTalPSo7FkQmYeyYXpsypiDQ8dpNYAx3BiPML7oFM4TAhXY42
	 xnoGWcayNAp2rDsU0Kljoz/tax5vOML7hSw8GNlkWHdc70MUUGT4gZpEerqEia4mnB
	 N9LGD6B6tLXbgUXFtlVY/KOp1qXtDmTO4myN+NLh5QkOShRQhTYm6M+kITs9zaN0J0
	 GrdDiNpaMn8E8U6GN5htZwjbzcHZjuGG/b++Btj/PZFmNrNQiQYah2+pjh9NNMfS6F
	 AWFWM65KN/AmdmYXc04oEriVWJIddzd721JtfkqzpVRWETITjT2SpHhl3Fgpup1kNS
	 3jc9uJPoKVNbQ==
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by ubuntudhcp (Postfix) with ESMTP id 8338C2204EA;
	Thu, 12 Feb 2026 14:44:27 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: alison.schofield@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	gregkh@linuxfoundation.org,
	huang.ying.caritas@gmail.com,
	ira.weiny@intel.com,
	jack@suse.cz,
	jeff.johnson@oss.qualcomm.com,
	jonathan.cameron@huawei.com,
	len.brown@intel.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lizhijian@fujitsu.com,
	ming.li@zohomail.com,
	nathan.fontenot@amd.com,
	nvdimm@lists.linux.dev,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	tomasz.wolski@fujitsu.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling with CXL and HMEM
Date: Thu, 12 Feb 2026 15:44:15 +0100
Message-Id: <20260212144415.10418-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
References: <aYuEIRabA954iSfR@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=170520fj,fujitsu.com:s=dspueurope];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,alien8.de,intel.com,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77025-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_NEQ_ENVFROM(0.00)[tomasz.wolski@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 62A6E12E84B
X-Rspamd-Action: no action

>
>FYI - I am able to confirm the dax regions are back for no-soft-reserved
>case, and my basic hotplug flow works with v6.
>
>-- Alison

Hello Alison,

I wanted to ask about this scenario.
Is my understanding correct that this fix is needed for cases without Soft Reserve and:
1) CXL memory is installed in the server (no hotplug) and OS is started
2) CXL memory is hot-plugged after the OS starts
3) Tests with cxl-test driver

In such case either the admin fails to manually create region via cxl cli (if there
was no auto-regions) or regions fails to be created automatically during driver probe

Is this correct?

Best regards,
Tomasz

