Return-Path: <linux-fsdevel+bounces-70682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0FCA41D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37CF3311660A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991B2652B0;
	Thu,  4 Dec 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="FlTwpqsV";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="hB1dSTFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka24.fraunhofer.de (mail-edgeka24.fraunhofer.de [153.96.1.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F9266565;
	Thu,  4 Dec 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859745; cv=fail; b=cBUkC5Ff8iUm4jz0oEolbVzhcpcbPjsNSPFzdG+an7pCoTkG7abBpj24UFyMykJasfX9Fua6jBwkHX2wu/yHSjjbeHiR+1oCGsym92lW0DwgRS77XzAWxvY1HjhKkaxhckeu/t7DbPw227EvGECdlH/T1smreERUSitZb37NS7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859745; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Utln1EC2jOIGBczDvKgfBaivTXzJGO82OI6AkXBUZ2+o38/DbnWveqMU0qC4s8IBdw9pm7SUSgjaelPyxhJVOqkdIzSAXvFljfgYeWG1XSiT4/1O8NkKagkmyaChHYoKL4s+1jVXJD1nge3NloSNEak/VySR5or0lC8eQEV4IuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=FlTwpqsV; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=hB1dSTFO; arc=fail smtp.client-ip=153.96.1.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859743; x=1796395743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=FlTwpqsV5rkBeUc8ha4UQNbDVqvZIj6mux+yUvCn/2ZhuYsNbdcRLosM
   v948GZ41PRvje3+90t4WN/ocaE/cBAeu0hJocU5DGSXs34+EPZZvSM/Pu
   6UDHwWUMYPj9mFD9+dbNkDsl2/6xGiwrd+twhvq2r3PgpYN9Yp0AZfIR2
   8ofs6aPALV4s1RQ7bbEBtDE95wRMR1L9cDkaREUN8Pw7ZkB5++Q2yS+va
   icsQVLC6UTADIrtUOJ9AhL8utp7rg8llIIkvjMxkjdPZglSR/VzCvxCAw
   b9KsaBnnnyyIm9r0T7CQshosErkna31mlyId2vLq38bf00ytOGbBsILrt
   g==;
X-CSE-ConnectionGUID: AN0oiS9bQCOVIxKvd/mw4w==
X-CSE-MsgGUID: VXYcgOLJQ1abCX28M8TnbA==
Authentication-Results: mail-edgeka24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BACQnjFp/26aZsBaglmCQEABgi+zO4JQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMaCc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM2tEGBAYIMAQEG2ywYY4FkCQkBgUGDfIFyg?=
 =?us-ascii?q?mUBhH1xhHg2gVVEgUqCRDE+hFg4hXeDNJlZSAp4HANZLAFVEw0KCwcFgSBDA?=
 =?us-ascii?q?zUMCyoVIw88BS0dgSMhHRcTYD0XQINJGAZnDwaBERlJAgICBQJAOoFmBhwGH?=
 =?us-ascii?q?BICAwECAjpVDIF3AgIEghV9ggoPiAKBCAUueycDCxgNSBEsNxQbRG4HlB1Pn?=
 =?us-ascii?q?HoBr2s0B4I4gWeBXgYMn2caM4NxAZNukwuZBqkVAgQCBAUCEAiBfoIAMxokg?=
 =?us-ascii?q?zZSGQ+OX4NCvFZ3AjoCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23:cFUj6xwvHaJoUP/XCzIdzlBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xCZva0m0Q+UFcWDsrQY0LGQ6/uhEUU7or+/81k6OKRWUBEEjchE1ycBO+WiTWDdErvBQhd+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuMYbjZF+JqotxRfEonhFduRLzm9sOV6fggzw68i+8ZNt6Shcp/ws+8tdWqjmYqo0S
 qBVAzshP20p/sPgqAPNTRGI5nsSU2UWlgRHDg3Y5xzkXZn/rzX3uPNl1CeVJcP5Qqk4VCqt4
 al2UBPnhzsJODA/8GHMl8x/l7lbrw67pxx+2IHbfoeYP+djc6zHfNMaQW1BXttNVyFEH4ixY
 ZcDA/YHMO1FqYT2ulkAogakBQS0BO3h1CFFiGL406M51OouEw/G0gM8EN0Bq3nUsNb4Ob0OX
 e2v0KXE0TPOZO5W1zfn74jIdwgsrO2KXb1ta8re11MgFxjYhVuVrozlJSia3fkKvmeB6epvS
 PivhHA9pAFquDSvxcAsipPSiY8O0F/E9D55z5gpKtGiRk57e8SrEIZWtyGaMIt2TN0tQ3tyt
 Ckn1LILoJi2dzUFx5o73RDQceCHc5SW7RL5UuacOSt0iXJhdb+jmxq+70euxO3hWsSozltHr
 ylIn9rCuH0MyxHf98eJRPt880mv3TuB2Q/d5v9ALEwplafXN4Asz6M2m5EOskrDBjf7lFjyg
 aOIbEko5/Sk5/r9brn7ppKROJV4hhzjPqgygsCzH+U1PhQAUmWe5OiwyKfs8Ez8TbpRk/E6j
 qzUvZ/UKMkeo6O0AwlY2Zs55RmlFTepytEYkGECLFJCZR2IkZDkO0rLIPDkFfe/hEmskCtzy
 /DGILLhBpLNI2DGkLj7fLZ971dQyA8vzd9F4JxbBK8MLO/uVkPtrtDYAAU5PBapw+bhCNV90
 Y0eVnyVAqODLazdr0eE5uMpI+aSeI8YoCvxJvw76/L0kHM1hUERcbO00ZYXZ320BOlqL1iFb
 Xb0h9cOC2YKvg4wTOzwj12CVCZeaGy0X60h/DE0FpipDZzZSoCuh7yBxjy0E4ZMaWBHEVCDD
 2vne5+KW/cWci2SP8lhkjwDVbivVYAhzwuiuxLkxLZ/NOrb5jUYtY7/1Nhy/+DcjxUy+iJ7D
 siH3GGCVWF1nmUPRz8sx61/rkl9xU2C0ah8mfBXCdtT5/ZRXgcgKZHc1/B6C8z1Wg/ZZNiJT
 kupQ9W9DjE3VN0+38QDY0l4G9q4jxDD2zCmDKMSl7yOHJA06L7T32DtJ8ZhzHbLzLIuj14/Q
 stSM22qnKB/+BbVB47GiEiZmKOqer4d3C7J7muM0W2OvERAXA5qTarFRWwfZlfRrdnh/UzCV
 6SjBq4jMgtA18GCLKhHZsf0glpYXPvjIsjRY3qtm2esAhaF3rOMbJLwdGgG3STcCFQEkwcJ/
 XqcKQc+ASKhr3rEDDNyDVLvf1/s8e5mpXyhSk870Q6Lb0Jh17q05h4VhOeRS+kS3rIavychs
 DR0HFCh0N7MF9WAoA9hcL1GYdwh+FdHyX7ZtwtlM5O6M6Bih0UecwRvv071zRV3C5tAkc8xr
 HMrygp9NbiU309GdzOdxZzwIKHYKnHu/BCzbK7bwk3R0NaM9acV7PQ4qkvssRqzFkoj7XVn1
 MJV03qa5prWFgYdTZXxUkNkvyR98uXWbzc7+ofQlnFhO7S79CXDxdUyBe0ujB2nev9cPbmCG
 Qu0FNcVUZuAMusvznGvYggJNfsa16kuNYvyfv2KwqOiJ6BjmyispW1G+412lEyW/jd6SunG0
 oxDz/zOjVjPbCv1kFr06pO/ootDfzxHRgJXtAD6UdcCLqQnZ50CTHyuKpfqmIY2jMv3VnpR5
 FOvQEkL3Ma5dBbBCj610Vhez00Kp3yglyaiiTtyljAitK2E2yLShe/lcUlPITtQSW1vhkvrO
 9LxgcoTQU6oaAYkjl6i40P7zLJcv6NxMyzYRkIbGkq+LzRMSKy15JaLf8Md044isyhcTLaZb
 EuBQ7Hw5jo2gQjkGXdTwix+SyCyt8fcvjlXzVyQNm1yq3yLSYRV/lLy9NfcTPhe0389SS90h
 CP+KnO8MtKqrrD2353D59qacnigS7ZafTLt75+vjRqWvk14PEyhhcCIhMPBOlARyi/Gzthkd
 yPDoAmpMeyJn67vMcg+cnJUKnj28+UnFYpAz4Uf1JsxyX8ct7Ku5kQtrXjJDdFbg5DbTEUfa
 WEE4NTxpwzliRFfDnenwrqkdmiMweJOR+T5Xkc2wxoB3ex2VY3T8vsfsQt5g1SHlTqSc9dQk
 i4f0uZw41dFvr8LngAWkQOYA7ESB2B5JBO1pSWvt5fkjfpFXnqee4OB13RXrMGCVZKJgVl1V
 3Prd6oDEXFJvv95P1+UiCTQyqrFLYqYfZcSrBqSixDak61PJYkskuZfnSN8IjGVVRwNzuc6i
 Vlj0Z63v4HddyNj5qukBB5fODDvIc8eqXnhjqdby96fxJvnXo5gFTMCQIbyQLq2HSgTu/XqO
 0fGEDA1pnqBX7uKNQGF4Vpgr3XBHortMHeSJXIDys5lSgXbL0ta6D0=
X-Talos-CUID: 9a23:KjLVjm+C/v0D8VgpSkiVv2cyQsckSSzX9Vz3HW6oKnhlD7iKFUDFrQ==
X-Talos-MUID: 9a23:9cyZfwVhyTwEW3fq/AHctTptE+NK2v2nAms9y8Uj6/WCPwUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="35871884"
Received: from mail-mtamuc110.fraunhofer.de ([192.102.154.110])
  by mail-edgeka24.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:48:58 +0100
X-CSE-ConnectionGUID: R2ey6dyKTG6r5WO8t5qLvQ==
X-CSE-MsgGUID: N7rred/aQQGpEMFPjRjtbg==
IronPort-SDR: 69319f57_RvHhPWIKeXjDMJ9SPWJ2DmC3z4A6GdwOaWmMVtG0e+cCZC2
 0cgXZJ52i76GHhFffTbS4TNPD5W0xJNIt4u/ekw==
X-IPAS-Result: =?us-ascii?q?A0DYBQBT7aZo/3+zYZlaHgEBCxIMZYMcUkABgRyBCYghA?=
 =?us-ascii?q?QGFLKVoglADVw8BAwEBAQEBCAFRBAEBhQcCjCUnOBMBAgEBAgEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBNwEPC0YxJ?=
 =?us-ascii?q?QYOBSKCYIIlBBIDNQICAqcoAYFAAoxXgQGCDAEBBgQE2yEYY4FkCQkBgT+Df?=
 =?us-ascii?q?IFwgmQBhHxwhHc2gVVEgUqCRDE+hRCFd4M8mlBICngcA1ksAVUTDQoLBwWBI?=
 =?us-ascii?q?EMDNQwLLhUjDzwFLR2BJ32EGYQmK0+CInWBd0EZP4NTHgZrDwaBFRkdLgICA?=
 =?us-ascii?q?gUCQz6BXBcGHgYfEgIDAQICgRwaQAMLGA1IESw3FBtEbgeTVZ1zAa9rNAeCO?=
 =?us-ascii?q?IFngV4GDJ9nGjODcQGTbpMLmQapFgIEAgQFAhABAQaBfyWBWTMaJIM2TwMZD?=
 =?us-ascii?q?44hPoNCtztEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:GlvtVRQ8jDuhEmGKkGBg30+fndpsouyeAWYlg6HP9ppQJ/3wt523J
 lfWoO5thQWUA9aT4Kdehu7fo63sHnYN5Z+RvXxRFf4EW0oLk8wLmQwnDsOfT0r9Kf/hdSshG
 8peElRi+iLzKh1OFcLzbEHVuCf34yQbBxP/MgR4PKHyHIvThN6wzOe859jYZAAb4Vj1YeZcN
 hKz/ynYqsREupZoKKs61knsr2BTcutbgEJEd3mUmQrx4Nv1wI97/nZ1mtcMsvBNS777eKJqf
 fl9N3ELI2s17cvkuFz4QA2D62E1fk4WnxFLUG2npBv6C63VlzH7q8F01DKcH9HZdIEZAhSw0
 vZ1Ui/TljkhHGYS62Hqk81+rqRQrA309Hkdi4SBYKvMOMFCUITXZfxHSmF/A8h+ByZgEoS6X
 qw0FNQrAflik439/WkrjSSsKVajJ+nLjTtI1yPK/agU1tx8MRzX3yUPP+9NjFD0te3JBosuD
 Mry0u6T4RXPTv1p4Q+++qflfgkjuuzSVpsvTJTT70MUSCXAj1SQs6XEJgzM5NUq6y/BzrVyb
 /6egVUWqD9YkymMn+QnqdHgiYcHx23l+XtAkLwzKtDgEBdYQfWFRcgYp2SbLYxwWsQ4XyRyt
 T0nzqFToZegZ3tiIPUPwhfeb7mCb4Gt3zm6Db7XLy1xmXRlf7yynVC+/Bvoxu79U5ys2U1R5
 mpek9bKv2wQzRGb9MWdS/V880vgkTaC3gze8KdFdGg6j6PGLZ4mzLMq0J0VtEXIBCjtn0vqy
 qSRcy0Z
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vN52uqjrIAk2tJX0SjrM0Ucqp3BQX1d13DAbv31ZSRFFG/FwyP
 rAoB1L73PJYWgqNU3IwerwQpVoMkmsiKKdgLNhdotKOTOJhILGFvAF0WKP+UyCJ8S6zJ8n6U
 4CSdk1NDSTNykCsS+S2mDReLxAoOVvsprY/ds2p00dCT2CAJsQijuRfzzrdXGeMzM2YabReq
 DshPZvln6FQzA6f867Dn4KU6zovNvQjq/rZhYAGloO9BSOpSnA0s+2LzGomjMlFx9fy7Yr9m
 bI1ybj4L+4jv29whjAk0fO8pVtnsf7wNcrPr3BtiFVEESitu+bXvUhZ1SwhkF0nAhp0idorD
 D4mWZvAy200QKSQoj6m2qp5+Cq6kdT15ar8y7mvZKkm72/eNtyMbs+uatJNhTe8EYup9d6ze
 ZC2H+YrYNeCVfakD36/MWgbWAdqqOYmwtXrQcotQ0pbaIOLLtK6YAP9kJcF5kNWCr89YA8Ce
 FrSMXR/uxff1+WZ23Q+jAH+q3lYl0jWhOdBkQSsM2c1DZb2Hh/0ksD3cQa2nMN7og0RZVI7/
 nNdq5oiLZNRMkLar8VPpZJfeKnTmjWBR7cOmObJlrqUKkBJnLWspbypK444em7EaZ4uafaWK
 6xIm+wmVRCCH4GU/f+raGj2iq9MFmAYQ==
X-Talos-CUID: =?us-ascii?q?9a23=3Ae8kg2mmxMziwJ9sF1YbXrsYNHkjXOUeHwWaOL16?=
 =?us-ascii?q?bNUk3UuCqbg+MpbpAjfM7zg=3D=3D?=
X-Talos-MUID: 9a23:tCdIxAtpTvLsTx4S6c2nom54LspkpK2XMW8VvLAog8u+NzB6NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; 
   d="scan'208";a="35797768"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaMUC110.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:48:54 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:48:54 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.1) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:48:54 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKSRFKwoE9t4KrStB2qoaiWu3oFbJmfZ2m6R5JwH8fARGKXoL+rYj2LF24mEMxpw3Ph8fHzQCOeqjN94xzL4OqgGqGKRmdAL4sOFKH2ugez8lQpUbmMgj6PtmTpdyMQf2waNS2x3OmYUPgR1vqsM3SlqLZSrehp4p2MFvzhgTc/jTW2Q9dPubJcABLxqZW3kHu0HawsK+gunsOVkr4IWUQ0p8RV0L9hijzyS8TVC58lZR8sRe7JdG0oauUBiI1C5y+0gzoPuxk7YvpWXdUw13iZ05ybpExUbYO6M5CV6G72qcPXSJAy9/JkMGmIOokmR9dlZofnvSyPnlutWhQBRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=oLZoV3K+AVXHwbGAnaldKGA0LbJWZ1IDIZkUaXd0lKF/RxnSJVCubVv3LmanTWqfIqOwmuMhHm58ZqAdMfrFPzmnT/ny1VwwYigHexYrpd0rg1+71evqY8g1awrN5KBUK32xhRAisoYFuaN8Rtmkkf47bPgnQ667Zlc9jJqLaI5QmStUzx3U0zNfziaQcuaRO3xywX/yZwkDAyuzQ1Jv4RBcBsp/16/1MUNI8rFn2fm7Pb+TS+bTK7Ihgacg+Y3k0m8dhKe7ErmCD0DPnIIKOHz0G56JofwbJ3DOthgNVi0yeQQ549qb+l3iG1TN4ZH033UatLFe65UG/epy2jjefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=hB1dSTFObpG5gcV5fG8bIxonYOSsVBTwRTlh2ZMHWzD7gKbL/lh94THmFmP5HuykAGHU+TLHqPTZDT5B/v/3DHdIfWPP+zGEdqjsu6cA7U6jNbS7NmiihrAIqW1ZYO0/2I7zRtYbSYkVAYyK1KcK0AgmzeUId6Q8Rnge001KHCI=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR2P281MB0026.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Thu, 4 Dec 2025 14:48:53 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:48:53 +0000
From: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
To: <devnull+debug.rivosinc.com@kernel.org>
CC: <Liam.Howlett@oracle.com>, <a.hindborg@kernel.org>,
	<akpm@linux-foundation.org>, <alex.gaynor@gmail.com>,
	<alexghiti@rivosinc.com>, <aliceryhl@google.com>, <alistair.francis@wdc.com>,
	<andybnac@gmail.com>, <aou@eecs.berkeley.edu>, <arnd@arndb.de>,
	<atishp@rivosinc.com>, <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
	<bp@alien8.de>, <brauner@kernel.org>, <broonie@kernel.org>,
	<charlie@rivosinc.com>, <cleger@rivosinc.com>, <conor+dt@kernel.org>,
	<conor@kernel.org>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<debug@rivosinc.com>, <devicetree@vger.kernel.org>, <ebiederm@xmission.com>,
	<evan@rivosinc.com>, <gary@garyguo.net>, <hpa@zytor.com>, <jannh@google.com>,
	<jim.shu@sifive.com>, <kees@kernel.org>, <kito.cheng@sifive.com>,
	<krzk+dt@kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<lorenzo.stoakes@oracle.com>, <lossin@kernel.org>, <mingo@redhat.com>,
	<ojeda@kernel.org>, <oleg@redhat.com>, <palmer@dabbelt.com>,
	<paul.walmsley@sifive.com>, <peterz@infradead.org>,
	<richard.henderson@linaro.org>, <rick.p.edgecombe@intel.com>,
	<robh@kernel.org>, <rust-for-linux@vger.kernel.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <tglx@linutronix.de>,
	<tmgross@umich.edu>, <vbabka@suse.cz>, <x86@kernel.org>,
	<zong.li@sifive.com>, Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Subject: Re: [PATCH v23 14/28] riscv: Implements arch agnostic indirect branch tracking prctls
Date: Thu,  4 Dec 2025 15:48:45 +0100
Message-ID: <20251204144845.11873-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-14-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-14-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|FR2P281MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5e79e3-dd44-4b3d-d303-08de33443e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RAGfmZ84w7S4dImqEA+xQEqYkjteOGmWqWH+OdpAKCEnJUBz+fEivQTHqPRB?=
 =?us-ascii?Q?c1qF1JLzn8zkWF4eMHksh1gPgk/pz4NFRQ60/CaR2lFnGA3jPlHpKklVVfqY?=
 =?us-ascii?Q?9yUKQlGsjVZ4Nr70t3dQcTwU6CFuAoXnmyvMdw2rrmjnuPi6mq8l6u5fcpTj?=
 =?us-ascii?Q?eUp8AiH3i0nSVq6CcBMPX/IQOsASZ6klt93D6sALl3EaGU/hyv62UCkzueBg?=
 =?us-ascii?Q?YaE9jyawQ17VZdtDIMdniAFLkOlt4o345sgPCJrtcs0jA+pGjFRUTEPYTCoC?=
 =?us-ascii?Q?4VMCIU94leWlqzYaYFamYF6wNfDOOXJmsnpiFTM1z/UAH/oKmSae8SoNus+D?=
 =?us-ascii?Q?nZU7OQcgesjjZmIWG3D5T/Ek+3HjtVrGwoT5ar/CnIQ/nwiiIBGpG153yVZl?=
 =?us-ascii?Q?hwSB3ms000k61trLfh9/he9uEnGZBQkAQe0OZpk3fe6CkEMbURK7DotILvh3?=
 =?us-ascii?Q?RyY7aqTge3ZSk1Dnn1FA8WydZ2alyAiRXXpUyw+5OzZWHqPiwDVeYqD0ko5d?=
 =?us-ascii?Q?Yvv7E4tjKWaj6rO9s4yW63/m/lXmTgRDpHhbpfytb4BUgSf8d8lDOoYBNgxj?=
 =?us-ascii?Q?+NccjAWADr/tBD3IGbcjatkkpoCDAu4zrs9X0qbiG98JS2zpbQfrSTz4PfyT?=
 =?us-ascii?Q?Aytc+BVnqxIP0AYHi94s5GW2Y67OEG+2OQuLHwAx2qJYH8L/+A84dm7IPope?=
 =?us-ascii?Q?gVpUiAdZNnkjQu7eBEVjYqdXHu0Mu7cns47nWq13D+Snvr5BZpewCmB2QZfR?=
 =?us-ascii?Q?EigofS3n6y+b35Zp2pF68/CSShPHgJbnebWVqWLuHBiKjRsJyxKrDM5308en?=
 =?us-ascii?Q?0lg/d7E0ju/t2fLryWCTl/t76a8wVAryoKbqEjldATtI9enxAM5l/gIZ5FqM?=
 =?us-ascii?Q?CvkSV67yB9AiCyvCuoBm2rZVw3a99V4fc4D0M4jH18W5K8iJevJF1wb0bYZP?=
 =?us-ascii?Q?rPQaOdtrqnKaLpj8rw1SD8DsXsTOY2EktP2fdiF/xLGCZOgSwbKm9azGf/Cz?=
 =?us-ascii?Q?r7gahCbaXyRi3CupTlw6s6bUgZloeNMswhFejMAz+GXZ6gsTGxnFqqDvxWnu?=
 =?us-ascii?Q?/f3rfCrlmGXTL2Slf4ujWIk/V3VZgjGS586xSx7tV0u5SgJroX9upS5kCK+s?=
 =?us-ascii?Q?DQO/V7ZmZvgESrQUpTk8ZUw2hIewoc0FgapEGhpAo+Z+sZmGyfozAVVJoecy?=
 =?us-ascii?Q?0rKHGmxThaBZL2lqG5eLbI3hnCnONtPg+qUIU0Dunw7MpvJxsO13oqtXH8+y?=
 =?us-ascii?Q?CdsY6cy1OqyYZxhFaYdMO+c+8BJnyhBS2Vv8JfR7Z/XvUyPqzigZh8CQQGEB?=
 =?us-ascii?Q?SWp6Qr0CNK0mMvC20iE1ys2wXOf13Z7fDE5LBa+w41z/tVBnTF4uvkSNKDep?=
 =?us-ascii?Q?a4HNXswhzkBxmgAxUfPJuAryVivCUdMSOQzF3WTFFl/IVpZZAtF5Ef1zwKvC?=
 =?us-ascii?Q?PtQ3RmI58kKkFFGuKaM55xYXp39WXgON?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvGbRR5wwrG/SNsuJAZJEQuzPDB0SEeKaoPZ3iycNuOe3Z740O7bqyx2CWbO?=
 =?us-ascii?Q?t8rf9hE8k6PPq6jX/myFgyXghyeJ+Q7kmz91nNBqQzE+zICGSD4ZzL5oJRay?=
 =?us-ascii?Q?yt5juAVwTGXDgCvg4LQN3KuEyIRT9tuozl1ve1Rjs/6gXr1T1DxGNk4+gQQG?=
 =?us-ascii?Q?1eCSPEZz9USc3WCBXFBrc1wQWHs4gEUeCn8sZYMwcg5pyk5K/IFTdnpf+xGQ?=
 =?us-ascii?Q?gdTmTpu8gWML4+bJ67eNWqnJ78tOoX7+1hWnlvdb3aGMC2L1BkadmPb++/HN?=
 =?us-ascii?Q?0YXYV+JmopyaZMnKaYs8X+b7eZ21ILrggaCS3TfRY4ws2GOlo+CckFTa/WbC?=
 =?us-ascii?Q?psdBbSAYsvtoiKS8FOnDasNGna2AmODgvpSDISshtM5soLYd94cpjC1LbHR6?=
 =?us-ascii?Q?6Aq4V5qukncJfx9FHeYzs5Qo6zjDAvBJPZA6+6Z2AqMJfSc7NVhmHmb/y7Rd?=
 =?us-ascii?Q?Vr7PyTkWWlZyBGvfP7eTsp0sk05uAscABHCBkk5hJ1kriZZUlu5N1+oQpYho?=
 =?us-ascii?Q?HJ87iuiuRi45bfngPCxACG6n253qNvRABEHNV7muaMYAYoWs6Ms/P40clMnu?=
 =?us-ascii?Q?X6LC19DeXdLiRayPQPrKGAmjDx+t2j925+NqO95q8+56/owHOzQlVOX/8hKU?=
 =?us-ascii?Q?AbMmKoL2HcV5tcyQf7kr5QhunlxEqUESowWNQAhXbFgrAJssyUk5LN9FU22Q?=
 =?us-ascii?Q?wpfHbvh6djTzHWpA15lUCrEu6Js1aOWPmHmXvx0qDyVN2KD0+MHBfmLeyF3t?=
 =?us-ascii?Q?Xl5bVP8ux5RyQipAk+BIvWu8GSuOPIELAyUW13UOOU8mv0nxBFotihJf8WGl?=
 =?us-ascii?Q?Pawsg2wDiIWcj9fT23UJj8nOu8at156jgkqquxGoTNn8nu4rqdV6/6mCkBPU?=
 =?us-ascii?Q?37pqIVMHXFcL2XZd4yPiaBBQ39VilCIvW/686Q6Bpz0PT10xsxxUf/ew4pX2?=
 =?us-ascii?Q?3s72k1L8o05WG3kZ1iFA5hK22twn3t+/yDZqP3Bh5KAKu/WJwNuod5ctUyLy?=
 =?us-ascii?Q?+poJv3cXbnCBnj8KxysR3kcs9YaJg1iIJueFsbKo4SoRjTms5zb+rd6Iv8RZ?=
 =?us-ascii?Q?RCgjKmpYI8NWNCtkUeJi6xhh0WMi2UVxJSxUPkBBaSv9Cd6AxIF8ZbqxZ1X9?=
 =?us-ascii?Q?WTxfKIg5q0sA+KPSyzlCJj16MXN3RwTImAde1bjrpNE+6dNvpm7I/LeiZJJy?=
 =?us-ascii?Q?69drso/tYy5THiulTdUbhfgQSHkLgY31BWJBas7d7stcSlpw8mOSapQviilz?=
 =?us-ascii?Q?i0a7HIZElKvirYzTneAM5FcwVjh6ZvzdMTnVpA88ktSwKup3QlVoe/Xsd3Wl?=
 =?us-ascii?Q?x9Fhn9QgXdI2i1mwrhLqUAGNyz8CCQ2FWWD0UuZ912cR9rbc7Er74oV/uPEX?=
 =?us-ascii?Q?+JIrczc4qb/nLDotAVK0eh2B5MmP1soz7MIpIYxV7boyuwtLUXJzmC4cILBG?=
 =?us-ascii?Q?cWGhTDhl/kMaH/CQBxU26XXno0dabnelyPFgW5bpYtOyrgJ56XINe0OVCyYN?=
 =?us-ascii?Q?Wic4z1x9fGo6ujtaAp0I1nHIVZbVkT8tCv1nJrfdpjstLO031FyDc43tC09K?=
 =?us-ascii?Q?1mYPD1O7dtfWp5L04tn6VOfL+zlpPe0aP/UIZf4AjsoDw3VJkAUIs6ZLd4cl?=
 =?us-ascii?Q?AYnSCZQMb+0+Poh2+uqlJQs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5e79e3-dd44-4b3d-d303-08de33443e42
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:48:52.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNBQUOmNyryDAJYAhU7xIoupGti77M9bBUXtHoBO8x5v0j83hOQ4WZDwyzoh/S8VoSvGcEqIr6C6Xv5b9DhENZB+Buzmy3q+dSO/4gT4jjNh705wgvKEWucBkcE4Ehzv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0026
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

