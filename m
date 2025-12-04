Return-Path: <linux-fsdevel+bounces-70686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF62CA424A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 615FE30216B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C352D238C;
	Thu,  4 Dec 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="l0UeOohG";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="S6DoG3St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeka30.fraunhofer.de (mail-edgeka30.fraunhofer.de [153.96.1.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCC2C21C5;
	Thu,  4 Dec 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=153.96.1.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860597; cv=fail; b=idwAsjaieC1XaQIGcO+qTsSshWaYgJgWjP0ovzzB3Gj3r/zUeb40vb5pUr2B0DPmOGfj8VS4BsI2DHjFiWePFNRYf72XW/ZyKDkHIhehyWNYfSSRTkajjwFxYo8qQpt7GgMiTOc1XgEvYUGB2i/R6OgaEQvbe987P3QGJTfF0vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860597; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7ygWYUHs7DTvCB9YZvp8l63pL5mZ2PzbPxmCfrkIsMK1sizkrGhEeqy1gJ4ccQNHVSY66HO/D/xqRoHCYDkgmm41BdgTamYqfAfG/i6Nb410M/ToG8oDktJkXniFhw+JqFFcOKo1WvHyyYAHNmJVH93LKSgYCRPBET0A7VIbhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=l0UeOohG; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=S6DoG3St; arc=fail smtp.client-ip=153.96.1.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764860594; x=1796396594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=l0UeOohGtv6q7+k5nEjonm9Mq5M0FzPwmi2TPDBb1z32FVIX7wpjG+Fc
   6dNbDpQvcjKW+me5T0wwmeLojt/EpY8+KVfa7oX5Jx+ZczKW10qD73TgG
   qQtr+T/98icYVZhOn49U9zAK+nYINpz9T/qjSrNEVKsI+6Y1kQQG+lRwT
   c/GWDaPPRWLL6zD2HQ7GGCYnAq0pAdhTFqdbq2DTuJTsVVqCccKR6SOgH
   Y+3cpToo9abbZNurLGxqV+m4w/bIdshO/T0DJufXMDA3ayXeBJb02AApM
   IYeRLD1CKMCqv2X1BKMYQJSleWOun+TRCJEcSZ1xfIFwvENSQsLxTtJPa
   w==;
X-CSE-ConnectionGUID: 1Vhx4CDASRuro4M+OATRtA==
X-CSE-MsgGUID: 0sWuyvUyR9umX3+3FMUemA==
Authentication-Results: mail-edgeka30.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F8BAA4Va1o/x0BYJlaglyCQEABgiWzOIJQA1cPAQEBA?=
 =?us-ascii?q?QEBAQEBCAFRBAEBAwSFAAKMJyc3Bg4BAQEBAwEBAQEBAgUBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQYBAgEBAQQIAQKBHYYJRg2CW4EsgSYBAQEBAQEBAQEBAQEdAjVWBjIBD?=
 =?us-ascii?q?QEBNwEPC0YxJQYOBYMCgiUEEgM1u1aBAYIMAQEG2ykYY4FkCQkBgT+DfIFwg?=
 =?us-ascii?q?mQBhHxwhHc2gVVEgUqCdT6EWDiFd4M8ml1ICngcA1ksAVUTDQoLBwWBIEMDN?=
 =?us-ascii?q?QwLLhUjDzwFLR2BJ3mEFYQfK0+CG3KBdUEZP4NTHgZrDwaBFRlJAgICBQJDP?=
 =?us-ascii?q?oFxBh4GHxICAwECAoEQEAJuQAMLGA1IESw3FBtEbgeTd512Aa9rNAeCOIFng?=
 =?us-ascii?q?V4GDJ9nGjODcQGTbpMLmQapFgIEAgQFAhAIgX6CADMaJIM2UhkPjl+DQrold?=
 =?us-ascii?q?wI6AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3AkNflwmkw0bXYGL/axOU8etf4L3bXOSTjzGeMCGO?=
 =?us-ascii?q?RMlx0UrrJbBy30Z9ej+M7zg=3D=3D?=
X-Talos-MUID: 9a23:+oxxrgbHBZ4ReuBT7yTTmSB8CdZSsrmrOBtOyrsjhsSBHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="26280172"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeka30.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 16:03:10 +0100
X-CSE-ConnectionGUID: DP1aQH0ETlGKxRPcLu+0RA==
X-CSE-MsgGUID: LSeDEG2gSq6c0yPD1d322Q==
IronPort-SDR: 6931a2ae_2joJf0c4QIQv0wWRRoeRK63/xHAxbeny5wdAOFyoUHfGzNd
 u08yKGrVB9MykhtmU3l6TaPSd2aG5ss+5J4TFRA==
X-IPAS-Result: =?us-ascii?q?A0BFBQChRJ5o/3+zYZlaHgE8DAILOoEugW5SQAGBG4EJi?=
 =?us-ascii?q?CEBAYUspWiCUANXDwEDAQEBAQEIAVEEAQGFBwKMJCc3Bg4BAgEBAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZbAgEDEiABDQEBNwEPC?=
 =?us-ascii?q?0YxJQYOBSKCYIIkBBIDMgICAqUEAYFAAoxXgQGCDAEBBgQE2yEYY4FkCQkBg?=
 =?us-ascii?q?T+DfYFwgmQBhHxwhHc2gVVEgUqCdT6FEIV3gzyaO0gKeBwDWSwBVRMNCgsHB?=
 =?us-ascii?q?YEgQwM1DAsuFSMPPAUtHYEnfYQbhCgrT4IidYF3QRk/g1MeBmsPBoEVGR4tA?=
 =?us-ascii?q?gICBQJDPoFdFwYeBiASAgICAgKBA0ADCxgNSBEsNxQbRG4HkzadcgGvazQHg?=
 =?us-ascii?q?jiBZ4FeBgyfZxozg3EBk26TC5kGqRYCBAIEBQIQAQEGgX4mgVkzGiSDNk8DG?=
 =?us-ascii?q?Q+OX4NCsyBEMwI6AgcLAQEDCZNnAQE?=
IronPort-PHdr: A9a23:fma6iBAT+elkIG/sORHYUyQUIUIY04WdBeZowoRy0uEGe/G55J2nJ
 0zWv6gz3xfCCJ/W7/tUhuaRqa3kUHwN7cXk0jgOJZJWXgIDicIYkhZmB8iACEbhK+XtYTB8F
 8NHBxd+qmq2NUVeBMHkPRjcuHSv6z4VFBjlcA1zI+X+AInJiMqrkuu1/s62AU1I0RSnZrYgA
 ByqoFfqq8MUjIB+eIM80QDArXYNWsgE7mRuOV+Vg1PA99+9rrtC1gkVhf877M9HV/fKOoEDC
 JFIBzQvNW84ofbmsxXOVyKjzXsRWWZF93gACQiQ1jXfRJbsmSL2rexfxAajDOCtbaIJCCq43
 5x1VjnD0AwcNwMg8W/1jMd8k/cIxXDprUlEnaLTT9quKONvPbH6XsojfWRIUugNSHxRG4G6Y
 ZQTNMAmG/lSkITRo3Ur8BS/HQuyON2zzhBPtybf17UY4eR+ETP31k8GFYMzn3CFr/rENoIJc
 fnunKPV7Tqca+FWxWj60YfnUhsxsPe+Qr5iNo3W80U0DxrPpWiW+a7LHhC28e8Eoze8wMp+C
 +y30G8Zsws2un+oxM4woY/HlJo48XfG2Xwog5o+B9ayaUkuMpa0VZpKsCeCMJFqB9kvWHxsp
 HMiw6Yd6vZTHQAPwZUjghvDYt+uKdnO7AjqSeCRJjl1njRpdeH3ixWz9B24w/bnHomv0VlMp
 zZYiNSEqH0X1hLS58TGAvtw90usw3COgijd8OhZJ0Azm6fBbZknx787jJ0ItkrfWCTxnS3L
IronPort-Data: A9a23:FKBlN6s5rYh4Vdk5L8/KHrjRA+fnVNlXMUV32f8akzHdYApBsoF/q
 tZmKT2FbvncZTGhe4p/aIqx80hQ7ZbSzd5lTABsrCg2FCxDgMeUXt7xwmUckM+xwm0vaGo9s
 q3yv/GZdJhcokf0/0nrav646yElhMlkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGZzdJ5xYuajhJs/La9Es21BjPkGpwUmIWNagjUGD2yiF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0spPWGh31
 aQ1FDQiTQC5v+mS3fHjcMA506zPLOGzVG8ekmpl0SmfAOYtQdbNWazX499f0joqwMxDdRrcT
 5NEMnw+M1KZPEwJYw1IYH49tL/Aan3XejtUsl+cvuw05HLZ5AVwy7XmdtTPc8GMRcJbk1zeq
 m+uE2HRXk9FaoXPkmHtHnSEotTCsQ7UAo0pDeOzru9SrASfnTZJMUhDPbe8ibzj4qKkYPpTJ
 lIS5y4q7qQ//lGkCMP8QRqjoXiP+BUbXvJTHvc85QXLzbDbiy6QQGgFSDJLb8YpnMw7Xzon0
 hmOhdyBLTVsqLi9TXOb66fRozSvPyQcMW4FY2kDVwRty9DnrZF1gRveSNF5OKGwh9zxXzr3x
 liipSwzl7oTjNIK/7+641fcgjSn4JPOS2Yd7wHWVW+//wN9TIGiYIOs5B7Q6vMoBI+dT0Kdt
 Xke3caE5eYFDIqliyCGBu4KGdmB7vCJITfaiFVHEJwo9jDr8HmmFahZ5yxWKUpiKYAOdCXqb
 UveqEVc6II7FHKwa6Nfapi3B85swaWIPd35V+vUdvJUY4Z2bw6B92dlYkv492rvl1IqypYwO
 b+Da8GwCnAfAKVjijGxQo8127gy2yZ4y27VSrj0yh2m1fyVY3v9YZMEOV7ITucm6K6YvC3S6
 d9UM8bMwBJaOMX0egHe9Y8eKwBMIXVTLZrsrMtRd+OrIQd8HmwlTfjLztsJcIxshaBUm8/S/
 2+6QU5ewxz0gnivAQ6OZ39ucpv1XIh4tnM9NmonOlPA83MkZ4G1r6sDX5g6Z78q8Kpk1/EcZ
 /ICfcKaKvdCUDLK/3Iad5aVhIdlbh6mmSqKICzjZjUjF7ZsThLEvN/teBDi8gEKDyyqpY0/p
 aGt0kXQRp9rbwhvBtvZQOiu0VSqvH4W3ul1WiPgLtRNeU7h7JJnJgTvgfItZcIBMxPOwn2dz
 Qn+KRoSpOTBrpUw2MnMhLufroCvVeB5GyJyEnfS656sNDfd5WulyslLV+PgVT/UTnLc96y4d
 OpIyLf6PeFvtFxQupd6HqxDzq8k4dbr4bhAwWxMHG3CR0a6FrR6ZHKB2KFntKRLwL9xtgyxV
 UaCvNJdPN2hOsLgVkUROSI+b+qCy/xSkT7Xhdw2IVn9oiR38byIeV5TMRiShWpWK74dGIA/0
 +RitNI+6AGljBcudNGcgUh882WKM2xFWr8strkED4LxzAkm0FdPZdrbECCeyJWObchcd0UtK
 ReKi6fYwbdR3EzPdzw0D3el9e5cg4ke/R5RwFIcKlChhNXInLk00QdX/DBxSR5apj1D0uRuK
 i1oOldzKKGm4Thlno5AUnqqFgUHAweWkmT1yl0UhCjaVESsWHDAN3EVJ+mA5gYa/nhaczwd+
 6uXoE7hUDD3bIT02wMxR0duqLrkV9MZ3gnDnt23Wt6EBJIkST7kmbO1I2sOpQHuDc44iAvAv
 +YC1OJ3c6D9JylWuLE8AoqXzpwXUhmPIGEESvZklIsNGnrHeTea2jWULU21PMRXKJTi9E6+B
 MtGPM9DVx2iki2Jq1gzBqMBOJd3keQv6d5EfankTUYBsbaTpxJqvYjW+yy4g3UkK/12mMI4J
 5n5ezuIGGGUmT1fnGqlhNFNJ27+ftAAYRb40fGd6+QHFowO9uprdCkayraosm+HGAph8Qids
 A7Ka+nR1eMK4Z5tlIvlCKkFBwiyJd7pT+OO2ASytd1UapXIK8imnxkUoVqhJ0JbMbQcUNNyn
 7mlsdjr0UeDt7EzO101gLGMB64M5dS4Rutbd8j2anBWhm2MQsbx5RsE9W2ib5BE+D9A2vSaq
 8KDQJLYXfYbQd5Awn1SZSVEVREbDqX8dKD7oi2h6f+LD3AgPcbvdrtLLFewNT8BJBwbcYbzE
 BH1sPuI79VV5tYEThwdCv0sR9cyLFb/UOF0P5f8pBuJPFmO21mig7rFkQZ/yDfpDnLfLt32z
 6iYTTfDdTOzmpry8vdnj6JIsCcqUUlN2dsLQhpF+vpdqSyLM2odHOFMbbQEEs51lwLx5rHZZ
 RbMTmsoDB/sbwtqYzH5/MroWyW2N9MKKOXGAyEb+WGUZxjrA4naMr9q93pj0UxXYRrm9vmsc
 vsFy03zPz+w45BnfvkS7fqFmtVaxuvW63YL2ELlmerwCAY6LZRT81I5BytLdyjMM/+VpXXxP
 WJvGFx1GhCqe3D+AeNLWiBzGihAmBjN0j9xTyOE4OiHirWh1OcalcHOYbDi4IYiMvYPCqUFH
 07sZm235GuT5HwflI0pt/8tgo52Efi7Jde7HoCyWTwtm7yM1Up/M/MghSYvSOQQyDxbGX7Zl
 Riu5CEaL2aBI0ZzxraX6Fso/7Rcb3EyNAzK3TXP/WL+rR8Eztbia0eLyiD/IsrOsKTNhRhTb
 woTS0ezmGeokgXYiwNwjdklg2CWINowECDEWx84T5mpnRaLTnRcJY9b0Eo79oxw9ltYyqV9a
 ZSh09c009+iVSahhgrhnMkrZ4Z2i7I7HiUClL7b0xZ5HfSg1I7AUoiYK5Trai0wkB1JSVA6/
 cmLUGPmCCXSqlN3TBF+ns/sF6xH9bWz0own5GUFDcx1vqGW1r4dkcWa5TaCVRt3V6Lbc6q+d
 2TUvOiGFCgoLWHXasR/hkgy9qLa87lM8mnjnk7VC0+F5ZOY+m1HQcp/9aF85peEFUZcAmYA5
 wD/ZdvQq9q+vVK2hBjSzmOK16kAFWG5/5AQRxjABE/XHyQwrbtxqqa+o/ik+jgwZqR6IcN11
 GxWHXrRjtXc6mtjYxuqV0xvTSrJGDqgFqKdP5gLbNS1q/jXcvl/TfI24mx0dMUb0UVhlMtfL
 gGMA4iP0uNXZr1dRJiBvwm9QQs3F4L9ECmLmsuG2UYFHI3LLLuE8J3gAfbN3Z3eNzSSkVTdq
 tcG1q1on1+c3d4x0m1e+wF1lf2liuRK5lG3ITeB9RFkiBvseLGU51/6P8R8hrndoBRyxXEu0
 6jpV0ciw7AZIM/XNnCQPZLM1SvCQUPhcCyD+2+ubyc4LFekp2Y9+qTRK7rOyfvU+ASSwppkx
 2m4YdAmBrgHNHoHTiuEYkYS9uBOxLaVD1CdG9tEi0m1yTxHmGgF3y917ZG8Afoan1kd1KJx3
 msKL06PFENChbC687Qh3GelF3bTsLMQm4E/kKnBWTR9p5J7IS95q+d/Wc1RC+h/yJ+Iqr065
 dj5DxAM4H3bcaUAJJaI/xE15gCvTeYv0pl4CuYhiEHjF0VXk8xbEt+wxMpIYoastyUQuAySI
 F/g3qGJTQU6HMF3S/7yHvBR3sMx55HgAdFRxkEclCb9ONlXx/iXQ+9liBVqpyY=
IronPort-HdrOrdr: A9a23:xbRr0a/GFglnXtJ4S9duk+CoI+orL9Y04lQ7vn2ZJiY4TiX1ra
 qTdZ0gvHeetN97Yh4dcL67VZW9fQ==
X-Talos-CUID: 9a23:ZI0OHG2cgZVml4nUDr8SO7xfNvh8e0T9lFrsJ2CbGVxRQ5mICgeq0fYx
X-Talos-MUID: 9a23:toh4ogkzZCf+bkiQUYqZdnpGD8pEzov0B3sUz55eqvGobCArYW2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,290,1747692000"; 
   d="scan'208";a="46761833"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 16:03:09 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 16:03:08 +0100
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.54) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 16:03:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR1Vh66jtw8EUGJ3wXSdKxbc+0y6iq0qENlAx9nhBs+Fmq3Djp0FmiAiusVt2PcrmHg4AyF694BfYHQNP404ojZGMsvs2Z71ly5B8EveVYo0M0kqROvZsbG/OC+j4G3jKmx+IcAoK2sB0/HZtTSQEdcuxV9NdgN70CRZ3lGID96BTXN6rTlgEDHeOnZaaM3bIzfh20LLWfVIm5V1CdfdxdifAyngQjXV1flARTbP74VZYvmaEL0Qd7Pzgiq1jjRoq/BVZsvcU5jcwsBHv4LqTTOtBHPVylAN8o6uUN97uNAvX6FZqdnjksEFowdwuK4nO945TbQNaC1yDUvQGPfLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=cAICBf3B14jhXW8J4GFaeaH2zaEW4YultmGIDHe1CLyfHuF2WI827wWg9tdVwInOVdWlOXQFfGxkwevAqZrN74CldU88N6OGY7KLi4ENrGP2V5nI6geFxpYnu+CmQYHKzxpX1dJmfH1YXK4wOjnkiF+EaVHqqjmBV7OanAZVhCsGsTpF31PEwKHKSGdK1zhUYmh49+44VXM2x6GJNDVRxlvwt86LMu5qyxw/nknsHGzspv0TbNTA8iReHtRBiiNm5zmbIqdvXheu08+25N38Eeium1Ie4rhSrhNVaya0wvO5xw1HcbOx1vmiMY1meJ/phjWY6YyLYSMdBpeznv+7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=S6DoG3Stqy+zOKqQPfadF4w8xqjnfwtSBONwbWeDlFM5gipjvTV4lGoY1AbpJZh7hZYb+Nb9UGl9kGYjMsHq38buHg7lzht7oQgGHcxynZwdz//oRdspqbCUn8JFIKKOcax7OGHv6fp3iVpb/p/ojatCnfzpESOjD19+tcJcbIo=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BEZP281MB1831.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Thu, 4 Dec 2025 15:03:02 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 15:03:02 +0000
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
Subject: Re: [PATCH v23 23/28] arch/riscv: compile vdso with landing pad and shadow stack note
Date: Thu,  4 Dec 2025 16:02:56 +0100
Message-ID: <20251204150256.14782-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-23-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-23-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BEZP281MB1831:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a78010-de74-4bbd-37f2-08de334638be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ndVcKj+vU/PwJNqxl0ED76cUbL6naaj0HrLYOK9LbAVjkTVSeBjhuVyO+4lT?=
 =?us-ascii?Q?5OPd5hDtarbaeKIz3KeIu7feYbPkDifJrcIU/KWv9VTVKPbmjqdot6tcr6c+?=
 =?us-ascii?Q?CZZYATU22NYAG7V/ITJOZ/alqmbQewbI82Ky9SW6fJkLbwuPmPlp7tmXDeFM?=
 =?us-ascii?Q?yT/Uyh2tnfC/bKoazxzFaavzY/NrwvLcB+RR1BpJNoQXHoV9KT0HicWrJtSx?=
 =?us-ascii?Q?/aur5K4C/EQevu5/6YMOevewXgjuWJWz7dg2jLKp8Hv0MPYBXaXsk2AYOOiz?=
 =?us-ascii?Q?nM+sC8l787fKWr+kdBv/urzbhSZrVJpF1TpcKMZ/lAO4mvu7fDrCNKUUF2Ow?=
 =?us-ascii?Q?dFlrHf2JUCVtVN+PUY6qxkVaFLEj1cWNtpeJsyZfUpkKpNpnJt+gI6RP5nMj?=
 =?us-ascii?Q?XOqGw2+uI55xceR4Ul63/yQiXDRfLL4t1KEQnhv//60sbIZCoUikjxty3vvU?=
 =?us-ascii?Q?2NfWP36NvQqqLoF1Eo2ND8Gx0QLry6QODGQW0sJt+hQUWGfl10P4cKrzTcX2?=
 =?us-ascii?Q?6vS1vRsSk0/VyMIzRaDX2yy59uZRuHBXCFOH6JjpnHouWRX5mIc4r+tguWR9?=
 =?us-ascii?Q?88L4R7on7BT3dvDJTW5muLHDB02KLtKIyoO6mcKL7bUjytYl1qm4Y9JzPFqQ?=
 =?us-ascii?Q?2WHUUJf43wmZoHjfL4aa9Ulxv8irJGG9Zpwj5/r/I/yo1A2J9soRQ6fXBK+g?=
 =?us-ascii?Q?k+7rNZHWj/ktCCbSH1IDkvmOzcU4TQ18m4WlId66p2a/854/RSXknBM5RvFj?=
 =?us-ascii?Q?TtvS+qK3U23wY0aW4O/DGO47r2jM7OZ/s+ZfoBLTq0QNm97Jx1J+MJPXaiAd?=
 =?us-ascii?Q?Ly0lcRgcHMOfRlbhjAWQjvWtZ1MNOOtlkgvnM+VqxkEd1VNYAjMXSZ3modyz?=
 =?us-ascii?Q?fzyD0ILHFXL7OzyaQPWOzE6ePW6BEANQikcqbfYQB0F//0Tn/K8cx/bpxEaQ?=
 =?us-ascii?Q?kaNdTaUy5S6Mm2oAb6xNa69t94VMzbSEtnUBrNTVCklP/5t5TUslwbquB+v4?=
 =?us-ascii?Q?VF1l0sEsmuPXan9ZcPPxkO0aRAywk1s7kkGWwj0cJ+1MrqP0F7KjsxyDdU2f?=
 =?us-ascii?Q?HvcBllAkTge5IY+3QCYHTCvzrYvKSnkGspURw9oVnd4tkfNHk6tucJue4Ihg?=
 =?us-ascii?Q?mztq4zrj/5iMvPDIZjVB4ZPJDoI1w5FQ6HaeV1BAmTQIOaeRMo3wcbksr0Ce?=
 =?us-ascii?Q?PXwbaVe8bu/RbmvgLiwqHALZ6zgDwyPcCQ9gqZWUrO1Jy0TEsisRC0u0zlga?=
 =?us-ascii?Q?egvaRWYO3FUewIY8K6yeHJbhCZ2L8Vbdo2Tfwer9r4uUkinuiL42uiAmUInx?=
 =?us-ascii?Q?J12dXeYSV3jLo9gd73PI3mN/q6U4A4tPbbDnW4fI8xxqQbMNm6M32Sytyxu0?=
 =?us-ascii?Q?1jNu8hUjENJJU0R3SvtQBSWyWUnn0x+LRCkZAsEzOBeulCvUOZOPbCb8hOco?=
 =?us-ascii?Q?Z1fhbb76my5YXAtbFLCEruU33nU5oVii?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r4w6EocYiEeIDlC6U5ckT10DCEKOEpas3ibTIQ9o0pJDI0R4s45zxz+LSo99?=
 =?us-ascii?Q?zV6lf5bOj60x9PoHsUsA6YsKCzDPV+T/y2lvprru+FgtIaegPPEZpW2mwunE?=
 =?us-ascii?Q?3ruwvMncFVm6xaOkN4obIYXHoRGd2XTl46Kslw/trNj31bQNR7QqOCeLR9AW?=
 =?us-ascii?Q?SZYRopLj5PqxmhO5TfuYK454Wdgju4BF6BtrpwwF1IAN8diiWNCKxt0dqahe?=
 =?us-ascii?Q?MMePBgSZUoUC1GCk9skK3EhO627dgMFUrGIaQnggBaByEm28VgyDz5RIp/O/?=
 =?us-ascii?Q?F1QwLILIHmlKCo0d7t+YZUUj25O5sBiFfyp+TxnC5Usnjwq/TtrkicKLm/lo?=
 =?us-ascii?Q?muKrq472fU1ZAbLJ1rNGCRlH8M6EQwiQ98g9WZYEFMREqXN9GdBw4eDUzykO?=
 =?us-ascii?Q?jimKVWMQQs/hpfkejO0v76GIQfQmAEhhdrtDQDs75nr/8vW/vkuwYAuuAkWL?=
 =?us-ascii?Q?GaERzxU0t/ILxOYQibb0dyVu7EYtQtVkoeH2pIixGrLpjPNKnoSBrPyVwEyF?=
 =?us-ascii?Q?gjla2KrP8NMigWF3buF9vLioREmKVAkKgTcZBYx82TRByYJTAvlkEebp5NGq?=
 =?us-ascii?Q?6OffoSli/cU5hw+QpVs8Eq5pkUVlKt6gF22m1T/RikPDUobT2DrLMR346eqy?=
 =?us-ascii?Q?7npd7BcLstLyl+G3kr0lSZMIrKrTwlGlBsXYRJyr2n0Tr5k6mDogOPg+TWGv?=
 =?us-ascii?Q?jo/mPP0pIgGGPfYa+D7WUIdbOnKls+zN3qxdRUPcns4jC7SIjwU1qW0FZhU8?=
 =?us-ascii?Q?FUHfga/LH8iJRAGOiRPyelxGHrkFFAGcSEQFA0nmHz5FKNRz+Oj8n+ASdYK7?=
 =?us-ascii?Q?jS8BfiuvhDAY+CqbQD7N14ZpsEsFwip2fmbx2BfW+Iew8LqSz+qGJW0Qx1sQ?=
 =?us-ascii?Q?2OklEPTil8YOru7JIS3+4LEXyoY35P3+lcFu8m9lffw+M2Q5wGSL9fsMb1GY?=
 =?us-ascii?Q?LFKI42TzMDC8qlrpZIUUvv+nma8hr/mDifX8a23uC5Xw9LNyM+su2A/tM39D?=
 =?us-ascii?Q?Fv8s7q6hNPu/gQxz0GbDNjhLj987yCPExwjeIhm8ImIAuoA3enE6KXAfOk5g?=
 =?us-ascii?Q?5HxDQ7LpbJpz5GMD4sDOvQi40nkPGTzHNbvg1aIPs8sBpAQpEaTxuhguH5a3?=
 =?us-ascii?Q?U7SaL4w0hCfS5FpIl/NInvNYlF94DIjQHB5DHRUKVXUltbIJ1PrW5o6iD79k?=
 =?us-ascii?Q?S4vRxFw3M7xE51tT1zvGuWHj5BieHVVMqvM2rV7polYM650a0tBs2/1rrnsN?=
 =?us-ascii?Q?IL5J3wZguZdh+dJLBqimVlIa6yHQQVgWWrMRKUudAy0ekCMFG7j5FMAxOukc?=
 =?us-ascii?Q?41Wnz4R5ygsAAz8axmMLJejJ5vjUUYVolhc+svzTSsxTZ0pkML3hoEqYfb59?=
 =?us-ascii?Q?Y5MYlMh2UyXaArhEi4Cj7lX22cAMSAU5cHe+SR68UWMxgMiDsnmub4W8/k7U?=
 =?us-ascii?Q?YA1so//PSeh1xnyYTL/g9+2hjmsunpfBaKQbAeg6KcQz/ls19Jrx6f8perPu?=
 =?us-ascii?Q?KUGD/4bqxnu+4gVnQVsp7UHEgp45A1g42ftIMmYkUxSBliyVrjlo/Md0Jwyf?=
 =?us-ascii?Q?/N6PnT5Pv/nsVGStWpm8nJpp6uDjy7eXOhpJV15FJvOf1tlHfZYUSfAg3caH?=
 =?us-ascii?Q?KxnK7H8wykZrjCslK5ZTs8A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a78010-de74-4bbd-37f2-08de334638be
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:03:02.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPuiNWn6Zo3mJcVeRyYyXZjbOmOg9yVg1z2BpVV0PYvuZh2FPbpiHu80eSpJ1ZuDraj1uAVR1NSiTTrhxpdNWbQ6ZSim0zaw0VlZVtfpxoF363lxmC7qnj9j1RWmEbAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1831
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

