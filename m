Return-Path: <linux-fsdevel+bounces-70679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C9CA419B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B743072C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA8521CFE0;
	Thu,  4 Dec 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="RG2OnwNY";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="qv/9bpfB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-edgeMUC220.fraunhofer.de (mail-edgemuc220.fraunhofer.de [192.102.154.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B7243367;
	Thu,  4 Dec 2025 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859586; cv=fail; b=Boz9cKCrab5h2lHpdkvcIyx8ZB74ELQCFjDhvgWrGeSeHO7Qm574r91gpL+jKLFGBkJR0YRwnNRUri6wW/sJ2COq9zDDchBsHr5NOsbNPf6VIbUCYYU5H5qfqEC9uaKU8ggliBQJD+omQkVd8fK+2VtaeCLjuo6VTVhUWt+WPUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859586; c=relaxed/simple;
	bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a92ahVJ4tnZt9tIm4rVstGX0IZY9Wg6Bm2t3x7EpcSGJf/gsO4Yy8ogJsDwkS7hXTOuvhRHSf51oCVNUlK1H5/FvOwpsRlygtgCElyso0EA2XP/jB919hBYRo5+5Ghcy6AZJOa62Zb3MkxHd7FrgMl1sVHUgT4GawVAalaCJXXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=RG2OnwNY; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=qv/9bpfB; arc=fail smtp.client-ip=192.102.154.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1764859584; x=1796395584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
  b=RG2OnwNYArD/bGQjIp+xYap42uNM7Z0Jbcm7EVIAzJ200fXMuGsCkOQh
   j6onBhFqCKI+o5e5Hd4KW3dDVqNnBQV+oTlc3ZWkkm3p6S84fscFXJoT3
   AkWik4VUa3ZMmlRM2wd0UJqfzW5KZ/LjmKbbGzOa6fA90n1f3bmD3XJLb
   khmsi0VwK6Jqh3erLu5r1BM4lfnFW/QediofMLFPhotesqfaDxZNlcj4Z
   xWSrVU37kc1py9IxuEy0GDHJvzccwqbmcLkBm6uYgjKoI9y5YJRMJnbzV
   fTffZBekjHf33GPjOSq3K0ZMafRFpcb5GGkDFtXpx528eRzH0wsSjuAsC
   Q==;
X-CSE-ConnectionGUID: L8idJuGhQKuEcL7kYk8gDA==
X-CSE-MsgGUID: gtKU4VY2SyqinZe1sSx/eA==
Authentication-Results: mail-edgeMUC220.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2F7AACbnTFp/xoBYJlaHQEBAQEJARIBBQUBgX4GAQsBg?=
 =?us-ascii?q?j9AAYIvrwiEM4ErgSUDVw8BAQEBAQEBAQEIAVEEAQEDBIUAAoxoJzYHDgEBA?=
 =?us-ascii?q?QEDAQEBAQECBQEBAQEBAQEBAQEBCwEBBgECAQEBBAgBAoEdhglGDYJbgSyBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CNVYGMgENAQE3AQ8LRjElBg4FgwKCJQQSAza0RIEBg?=
 =?us-ascii?q?gwBAQbbLBhjgWQJCQGBQQGDe4FygmUBhH1xhHg2gVVEgUqCdT6EWDiFd4M0m?=
 =?us-ascii?q?VlICngcA1ksAVUTDQoLBwWBIEMDNQwLKhUjSwUtHYEjIR0XE2A9F0CDSRgGZ?=
 =?us-ascii?q?w8GgREZSQICAgUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIVfYIKD4gCgQgFL?=
 =?us-ascii?q?nsnAwsYDUgRLDcUG0RuB5QdT5x6Aa9rNAeCOIFngV4GDJ9nGjODcQGTbpMLL?=
 =?us-ascii?q?odlkHOpFQIEAgQFAhAIgW8LggQzGiSDNlIZD44hhAC8XncCOgIHCwEBAwmSH?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 wiUGSA6qnCVFKCZGgma6Ux8qGnIHYztPHaSTEQ=
X-Talos-CUID: 9a23:klg3hmwfLElpuheaunvXBgUwSsEpUGDyzE7zPmKzLTlqeb7FRnO5rfY=
X-Talos-MUID: 9a23:uDUBkQtVIFzOBRmM682niy1BCZtW0v6VGVkMl6cL4tK/JWt9EmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="14644122"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeMUC220.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Dec 2025 15:46:16 +0100
X-CSE-ConnectionGUID: HEl9NASnS0CC6O2CoeCciQ==
X-CSE-MsgGUID: 5DnjUWAqQMKrAsg+tqrD1g==
IronPort-SDR: 69319eb6_pUIjbOU0idwbP9Nng1MZIBUpodxsnKHAuL+3qGMmKB4MSIl
 9I0pcMHfXFN10lQFHAPMNvevq6NU/aCWZ8jLEfA==
X-IPAS-Result: =?us-ascii?q?A0CDBQAWnjFp/3+zYZlaHgEBCxIMZYEgC4FuUkABgSYuW?=
 =?us-ascii?q?4ghAQGFLKE4hDOBK4ElA1cPAQMBAQEBAQgBUQQBAYUHAoxnJzYHDgECAQECA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBAQYFgQ4Thk8NhlsCAQMSIAENA?=
 =?us-ascii?q?QE3AQ8LRjElBg4FIoJggiUEEgM2AgICpicBgUACjFeBAYIMAQEGBATbJBhjg?=
 =?us-ascii?q?WQJCQGBQYN8gXKCZQGEfXGEeDaBVUSBSoJ1PoUQhXeDNJlZSAp4HANZLAFVE?=
 =?us-ascii?q?w0KCwcFgSBDAzUMCyoVI0sFLR2BIyEdFxNgPRdAg0kYBmcPBoERGUkCAgIFA?=
 =?us-ascii?q?kA6gWYGHAYcEgIDAQICOlUMgXcCAgSCFX2CCg+IAoEIBS57JwMLGA1IESw3F?=
 =?us-ascii?q?BtEbgeUHU+cegGvazQHgjiBZ4FeBgyfZxozg3EBk26TCy6HZZBzqRUCBAIEB?=
 =?us-ascii?q?QIQAQEGgW8LKoFZMxokgzZPAxkPjiGEALxeRDMCOgIHCwEBAwmTZwEB?=
IronPort-PHdr: A9a23:HtrECBUIA6CSuv2c6usVPvfZdSPV8KyzVDF92vMcY89mbPH6rNzra
 VbE7LB2jFaTANuIo/kRkefSurDtVSsa7JKIoH0OI/kuHxNQh98fggogB8CIEwv8KvvrZDY9B
 8NMSBlu+HToeVMAA8v6albOpWfoqDAIEwj5NQ17K/6wHYjXjs+t0Pu19YGWaAJN11/fKbMnA
 g+xqFf9v9Ub07B/IKQ8wQebh3ZTYO1ZyCZJCQC4mBDg68GsuaJy6ykCntME2ot+XL/hfqM+H
 4wdKQ9jHnA+5MTtuhSGdgaJ6nYGe0k9khdDAFugjlnwXsLLlg7gt/dW0SWBO+/qYokFdG+C/
 Zo6VgXYszkZERVh23rXt9VxgoBdqx6+8k8aocbeNZiLc6t0Zq33f40hd0R/VMpPfi9rUpu9c
 IcQA/shNOJfhtXYq1kTkjKcADitC8//9BttrXz7wvwq6eAKDV7/2isbOtwQqG7r8YXnb7kMS
 vmol4nZ9yTYP85vxS34q5iLbyhik6+UZexXVOX67UolGhL3vFqViM/ZLj2L++0Gv1KU17VSb
 fiRjT4riDoqpB6PzM0yoJXQgrkV1lDN3yRU2MEIIe+3ZmhgeN2jF84D/zHfNpFxRNslWX0to
 ish17ka7IayZzNZoHxG7xvWavjCdpSBwTu5CqCfOz5lgnJidr+lwRq/ogCsyez5A9G9y00C7
 jFEnd/Fqm0X2lTN59KGRPpw8gbp2TuG2w3JrOARCU4unLfdK5kvz6R2kZwWsE/ZGTTxllmwh
 6iTHng=
IronPort-Data: A9a23:ShGB4KOonQJDiuDvrR0qnsFynXyQoLVcMsEvi/4bfWQNrUpw12EBy
 jRMUDjSPanbMTOnctggaIvgp0JXsJ7XmNcxQHM5pCpnJ55oRWUpJjg5wmPYZX76whjrFRo/h
 ykmQoCeaphyFzmE/0bF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZg6mJTqYb/WVvlV
 e/a+ZWFZQb/g2IsaAr41orawP9RlKSq0N8nlgFmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3Kd/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1OIUVnG6Qj/N0vKkoQ0
 qYzLz0mZRG60rfeLLKTEoGAh+w4KdXzeo4PsXEmwyvQEPAmRp7OWePG6Le03h9p25sITKmYP
 pVIL2M1M3wsYDUXUrsTIJs4kP2lj2K5cDpConqcpLE66C7d1gVs1rjqPtfPPNCHLSlQth3E+
 zyZpDyoav0cHIGzzzi4zVu1v8rshwrgV8EODaeUr/E/1TV/wURWUnX6T2CTrfSnjFO6X5FTJ
 kYJ9Ww0rLY1702tRZ/2WBiQo3OeuBMYHd1KHIUS4UeNy6zY6QGDCUAHQyRHZdhgs9U5LRQj1
 UeMt9foAyF/9bOSVHSR/6uVqjX0PjIaRUcLYSIUCwQM8t/kuqk8ixvOSpBoF6vdptTxFCH/w
 zGWrQAkhqsUls8N3OOw+lWvqzuop5PEVB814i3YWWWq6g4/b4mgD6Sh7VnA8f9BNsCXVFCHt
 3kfs9eS56YFCpTlvCWLTPQHGriiz/mAOTzYx1VoGvEJ/jOw03OudpsW6jxkJ0ptP9dCdDP0C
 GfaowVdzJZJOnegK6N6C6q4F8UxzbDID9X7UevVaNEIaZ90HCeN/iZ0YxWn0GDFiFIrjaY5P
 J6adYCnCnNyIa5g1SewAekQ17ADySU3xGeVTpf+pzyD0LObIl6SVrMILEemafow56eJ5g7S9
 r53PdOiwhFeXeuuJCXamaYZN1cNK3k2LZP7scpacqiEOAUOMGohAuXVwL4JYY17mL9UkOyO9
 Xa4MmdTzFfwiGfvMwSUbWtibripVpF6xVowOiorJxWkx1AgbJyp4aNZcIE4FZEs8+pk19Z3Q
 uMDdsHGBe5AIhzM/C4XYIXVqJNkMhKmmWqmMyO7bX4/dph7Sgrh/t7iYxup9S8SAy7xvsw7y
 5Ws2wnGTrIZRhplF8fQY7SkyFbZlXQQhuN5UlfSL9R7Zkrh6s5pJjb3g/txJNsDQT3OzDqX2
 wuMBD8IoOjWuI4y9p/CgqXsh4q3Gu1WBEtEGHLa673wPi7flkKsyJVReOmBZyHSSWSy/qi+D
 c1f1fjhNvAdtFVHqYxxF/Bs161Wz9v3rpdI3xhjBjPAaFHDIrFpJH+G9cZIsaJJy/lSvg7ec
 kCO/59BOaihI8LrEUAcYgEia4yr1vAInX/Z7fkzL23h5SF24rfBWkJXVzGPkj5eb7dpGIAo2
 +EsvIgR8QPXoh4rNMuWyylO/GSkMHMNSeMku4scDYutjRAkonlGYJrBGmr655qnddpBKA8pL
 yWSia6EgK5TrmLGcnwuBT3DxuZQm5kKkA5FwUVEJFmTnNfBwPgt03V59TUxUxQQzRhd1e93E
 nZkOlczJqiU+Tpsws9ZUAiEHwBHGQ3c+Vf8z1UVmXbFZ1enW3aLL2AnP+uJukcD/Ap0ejld4
 aHdzWPNUijjd8K32TE9MWZhqvr+XZlr9xbJhuijHt+ZBN87ZzT/i6OjbGZOrAHoaes1g1fKo
 /ttuv1sbqT4ODU4pLcyAI2Xk78XTXisIGtZWvBn1KAEB2fRfHe1wzfmA0WwfMxKD+bH/U+xF
 4plIccnfxez2T2mrT0BA6MIZbhuk5YB49gPdrrDJmMctbab6D1zv/r47iH6gWIxa9lnm8wwL
 p+XfDWHekSIjGZQ3XDEqMxfPmepScIFagzi0aa+9+BhP4oOrOx2Y2kz1LWutnmYOQch+Aib1
 CvZZqTWxvZuj4RhmYfhCL5EAS2wKNX6TuPO9xq82/xUbNjMd9+Iug8ap1LgOg5bFboXR9lz0
 7+KtbbKMFjtsaYxFmDIkYOAG+xD5IO7UPERPNj+MX9amiWPQong7nPv5lyFFHCAq/sEjuGPS
 RGxdc2wctAYQZFawnhUYDJZCBETF+L8aaKImM93h6nk5sE1iFSZdoGU5jXyYHtFdyQFHZT7B
 0Wm87yt/91U5sAEThMNG/gsUdcyLU7BSJkWUYT7lQCZKW203XKEmL/pziQ75R/xV3KrLcfd4
 LD+fCbYSiicgq/z4e98j51TpTwSVXZ0vvkxdBkS+vlwkDGLM1QFJuU8b7QALI1YsgXv5qH4Z
 jjmMW4pDAukVzFEbyf53sXHWz2bJ+0RO+XWIi4i0FOUZhyXWqKBIupF3QVx70hmfgDMyLmcF
 ugf3XnrZD6j74pMR9tP1sekgOxi+OzW9kgI9W/5jcb2JRQUWpcO61BMAytPUnbhP/zWtUCWO
 1Uwe39IcHu7RWH1D8xkXXxfQzMdnTH3ygQXfTW9+8net6qb3d9/5qXGYc+r6YI6beMOOLIqb
 lH0TTHU42mph1oiiZFwsNct2aJJGfaHG/ahF5DaRCoQorqR71o2NMZTjAsNS8AfoDRkKW3/r
 QX1wXYCBxWiEntziZm20gQC/qxjXk0cVw/piBHNnh6YsBgb4eWART2U4lPVFZXCpZLnnX1ke
 xYJTUPIo1SppDru/jZ/kfIAp224O8IaFFiacyUGU6HSsBOdeEpAHeowwnA5/dJYwFtA95QJc
 a2U/Yw3/YK5bCaxziThptM4Y6dmnZgFCA8sm7/kxzM1N9qShafQUce1Faa+dSkW2SpJYFUm1
 taJTU7yEifUjFVhZSNksMjvVJBM0LS0+LYm4lEZD8oBmLuj/rUAupy/uy+CRR93UPifaIO9c
 0nh2/a3PhIpK1XLaMILoFIZ8JzdyN1+5HramUroG1+G5Zepo1gyb4N29bYl+Mm2QVlIGWQtu
 UXzSM+vjuHU3gu0vkGs8m6giq4ALyKP/bkVbB/DBFXtGDQcqtd7qqGHs875kRIrWoFAIMJt4
 WprbmbX7NWD8kgpRSqUSw9HUiGQLR+aG5yZDp4USPKEpJrICeZVPv0xlXBfcO9oyEN0l95EL
 3q0Noy+yMgJMLxzfZOBhG2IQycwLd3tKj2Vo+qFg1YwF43wVsiR8K7vHPanqojeJUOXk2HV9
 +wSi7ZRn0/U894LyH5a2hFjv8OzoMpF526jBHur2S95twDvIqGn7E3zRbdphoja/gsDtnET7
 Zq8SEMEiocZCcrLHW+SIL/YzynEZ0X3WR6Z1WitLBszCVajjVw8/JDNKby67+Hh0A+P6cNBm
 XC4cdQmAeJDL1MESgaxBVgj3NpPwoKJDVbpPcFvjXey8lh1jns82CtI/YG/Af4rxmxo+ut43
 nxTMRC9QFxWnrKXrfEt8XPaMk250+oSodhBrKTrBDN9ndFNIwZ8gOB8WddrDPhTz/OCqroD9
 e6kZDoX3FjhcKQYEZC1jA0zhADwQdUmoOkHYP0UtQKtVA4S5dhOBI7rg41oepqm5jFD/grdO
 FH/n6GfWlg7EdlrFt7yHvBR3sM9yKmT8A+hBufViRV5Du2wFhmC
IronPort-HdrOrdr: A9a23:/RCO0qCiTY3U5B3lHelT55DYdb4zR+YMi2TDj3oBLSC9Afbo6f
 xG/c5rqiMc5wxwZJhNo7290ey7MBbhHP1OkPEs1NWZLWrbUQKTRekIh7cKgQeQeREWndQz6U
 4USclD4arLY2SS4/yX3CCIV/kn293vytHUuc7ui1h3SwVGbaVp7wARMHfmLmRGACdsP94BL7
 y3xextzgDQAkj/Jf7LYUXtF9KzweEiwvndEGQ77jAcmXCzsQ8=
X-Talos-CUID: 9a23:4wNdXm/Z4Dx+mBjkE6GVv245HpEDW0bb9y/7CBGfU01uRZaeSGbFrQ==
X-Talos-MUID: 9a23:1FQAmQuU2mv3Vwe77s2n2R1kNvpXyr2XLWMXuI4J+NWdLwApNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,249,1758578400"; 
   d="scan'208";a="34567309"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 15:46:13 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 15:46:10 +0100
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.0) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 15:46:10 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2erQv6Kp1P/SeRnXoKKNu+fSbOC5ZmXyhKkltW+UYjSI73IPkF81O70YCr3KTlWuhYH/DLk5VE2IbyY0FzApCUO0m7Avt171PvLXGU5Ka7c14COPB8f3SYdpmf+j5aoHPBjD26xV8IRbEMVUqxZD4nmNSogAsR6l5qZJoVuwXd1whRpQEzGzLp+0gXGOzIru6QykuTwk+smRDkUjTc5Ep8RepNQHSG4KK186t1R4OhJ+yXY43a2HxbdDxDEHGNj1fhgRb7aqntL7LNK3QG0wKXl0zko8KLz8MgWoSVQuAFK1KVVWJzYkVvokMxGHVhjYsRUIJPipl80GlcLRoMnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=O72U39DkeKSdszJn48ciKfuf6msosspVInZb1BZZoPqMcKAw+QgQyvl+uFpM2PUV8CTE8u4isPzzAbHfQGFxfz4d3hGUF7SnDzTGDU3fCOkxg3dTfF0rtnG0pfOJRuVAtSFyY419O0ZbRPolElXo+tJUcCvfQ1wzngJDfdVLlRM68UajWhzEysBdtEuLCKMcUb+S9W7hplwIrWgYB7SYTmXdA2oozDy5209rxNBiPIgu9LUfgMDs6xU++XZ6YwKaVZkSHzbKtAxKzWTmmwjDPiXAQmrDwtSYqRUyrkYU50XWFyWfnmEnlXCLC8I/pFPRcz/0Nubz+6ERXUIcxILCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLMriuCadsnJtGQYE3HzU9vrXSvvNC0CshUqifJncdw=;
 b=qv/9bpfBj6SZFVbdvAkB8piwdwdyHaloA4MdjuWAJmYigDxVLMCkew9xRlCt7QnOSMfvprW58z3vvsqu3HyRys8UQtrm+x+uP+Z6pP6OMGCLkbeyZZgmI+TyfvEacdRgP7ZPrVn8dKS3nNHbbvBtqlShthaBiEp/UlZgFNsqkoo=
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 BE0P281MB0177.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Thu, 4 Dec 2025 14:46:08 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 14:46:08 +0000
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
Subject: Re: [PATCH v23 10/28] riscv/mm: Implement map_shadow_stack() syscall
Date: Thu,  4 Dec 2025 15:46:01 +0100
Message-ID: <20251204144601.11154-1-andreas.korb@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112-v5_user_cfi_series-v23-10-b55691eacf4f@rivosinc.com>
References: <20251112-v5_user_cfi_series-v23-10-b55691eacf4f@rivosinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:43::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2435:EE_|BE0P281MB0177:EE_
X-MS-Office365-Filtering-Correlation-Id: c0731c85-3bb0-4b48-c0de-08de3343dbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?80tjcPiQFl/5vY9bd1l/FbLStR2le/GwvLNDL8inZd03LUGu6tRTaEwrkt0f?=
 =?us-ascii?Q?+3aRj/T2pKB4rPKUVtbcm3CZzH2Mm+KbFGZx8M879IMqMWW7t/8WgJ+MmRWj?=
 =?us-ascii?Q?9S+EgVLEfzUCSFW1qa2wAfKJcLSkwTwN5B116Mc1047/x8aorM/77YGhp60v?=
 =?us-ascii?Q?VVg5oL3h35ptarvJ5bX0THoIQ/W2fMBuYlDUSHn6gud+wcaydwGMTBZ2QBGa?=
 =?us-ascii?Q?wGUUovJgIxMB4CMK9pUC/sxsn/lbQsTJ8k2EfinfQiMLv0E9wGsthkP6Vs35?=
 =?us-ascii?Q?nevkxbPNpYbuPOh743n7VjQDryKp/QKG1oUzjz/dttU/bnc3vJFqjXmHaBkx?=
 =?us-ascii?Q?P4DEhg6X0ueXCIBHWKoORM/j7dbabWrLxwTXIWHVy2aXzjfOKrVG/Hhphy19?=
 =?us-ascii?Q?HYJPPzHPxuNfWVLg8UizREs1qyM8kloMgiKmThxWF+o2G5+QBU1t2og7/jz8?=
 =?us-ascii?Q?GV29JefMH2jb8hQVz7j4wEH38VtS4s/u1icdrJXKQSZfvxB/h82yqak6M31e?=
 =?us-ascii?Q?3w/8Q+3nVK5j6HdVqQBZtRElnqLXXDhStDK49q5THbsmKtisAVpMk9Wl+bID?=
 =?us-ascii?Q?GuGTDc50DGCxRmjU0k7CqYvgpkeKIO+j67qd0MMqJxw2aydAEuPDcZBhJ8+2?=
 =?us-ascii?Q?DPGlDYbf/2uNanHbyc1fIg5Xd7f2gNGSfShlDp7qKP7fFeulaph3pTLm5KF9?=
 =?us-ascii?Q?d22rrFDZTR25lrnaAb81lvcDlMiljE5Wsj8X5/atX5cfMtSfUNvroZPxZ/EP?=
 =?us-ascii?Q?4NUeLKUgJKqvNTwKv5FEMwwhMNeA72tp2DfarNQuMpeCONU5LfV+ZkNNA5TW?=
 =?us-ascii?Q?5yXNabqcNWRDhVQtpSkk1kJ5eKgZCoaOVWzQRdD7zERQzv0rKDnWdgzgAJCH?=
 =?us-ascii?Q?j7sTRGiA3jSpf63o/Q2E4iUzIaPa4/dFVJWVs8qfu9dosBU1QE0n9KqdHyT5?=
 =?us-ascii?Q?oliABm+ygBGkN8CnOXwkP0f72jRqm+lBBFb3VppwcGYHAuPmkbiT0pomjdR7?=
 =?us-ascii?Q?jhT7rrMIHPfm0qMiROVzt1Pln1Ho85NPSBD5fN17EwDiVkJn0lrUJxRmyolS?=
 =?us-ascii?Q?7ueMFonaO6NWfC6uY9FHQwUq8y4bPwT4yO/8fIbD9y7vYXDaXgIvpHcIt/Y1?=
 =?us-ascii?Q?wwdBn3HZ8lHwMTICPVbDS69AX6YlLDlc/OFchGWvV5BrMpJQthOOlYY0iq4+?=
 =?us-ascii?Q?idGumjop8KDOMw5I6bAQ+iXsbU4EUw5bOtDuIk2NDeYHip/inDvmF47QCfaz?=
 =?us-ascii?Q?ZKKPWsZh/DBh6GEVfYshKMn51t43LC+hTtlfW4Q50jJ6TjjYmaTh7L9i0xmu?=
 =?us-ascii?Q?8GvdSL8Kj5dV1s+e4/spqKXeAi4V31FgqJxed7ZsugD22d0tXZjo3VDIjwoO?=
 =?us-ascii?Q?VFu1QKVu6VTltrdwtLuJFWcxNehmP0o9ae1KM2rflThYMIaA1tnpcnwzKf1Q?=
 =?us-ascii?Q?ZYQZEwDijpSs5xyPKmbIr0LNswyWYoOp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaessyMVpzKfFhp/bbF+1AQCdvirr/XC/B8sGYbzHvL498J2wZO0wYKLn1UV?=
 =?us-ascii?Q?QRed80/7yHmkHLLnFBKFLGNaw1KffZLXnWZoQfOizI/+yUX56nikvbNqw44I?=
 =?us-ascii?Q?n6xq1GS/a33hKMMmnMSIEihBPtQV6EVPiftv1jpB+xAo3euzFCDiFubKCwXW?=
 =?us-ascii?Q?ABy6dOvJ3nAkSIJfAR1u29w/PzpmpZTBeNxEI3EmqE/qQsFwjruuJ4iSoJ8F?=
 =?us-ascii?Q?3nkWG9j0xKEP1pBNCRcSONY3ilK1nTR3KLarsTcgxvyhXxi7lD33ogkq/MAW?=
 =?us-ascii?Q?6XsmItNpXMOSXR2ZJ9o1Ldytp4m/qBxQxFG8Z4tUzadaQyAv5kSth5DYsfA+?=
 =?us-ascii?Q?RtzFHh9lkzpXPevCYPtY6mMUX+jTfzlVijdc0IveYd2vijUdjYYtIZegXD6O?=
 =?us-ascii?Q?U6R0jzIHmfTuo65NW1WpVlhApaHU6/q4VWov59jak3x2V1rmhY7Hx55DD2tB?=
 =?us-ascii?Q?q+pA9XX2fE5nn4wUKEdl57yYRyh0E5KrSPT3V/xvqEtkDs3mfm2mIFlGt+fd?=
 =?us-ascii?Q?e1GY+4LVrYDjwD1Qci00tmcXNUpga4pTjT5zmZbhHOcKvqbQpTQ4b4knA1k1?=
 =?us-ascii?Q?dMx/lAO0TG4XRMGdexs5HajJ75PqLLsQ3fNmduKmkXNNU1+CKgXHXxuNQmwo?=
 =?us-ascii?Q?FrTw7s2xewpRXDx2A96dFt8fJwnTLq01XtuF3UoaRBxeSpNqZGeiuM/Hs8np?=
 =?us-ascii?Q?MvdYe1m6KG4JBW9eWOTrID0x8DGIzZzqsapBjZHDUkyE3tKkSPlK7QSd8VgU?=
 =?us-ascii?Q?T6XYl7yLSi6ypKUWfXoVVII3wZTqgnA3Plo+NnjcikhicdENFmIOVhjj+2rG?=
 =?us-ascii?Q?NLoOvtIbGyjGYQBfGKK5/w86OlmGPFqoO1nrc50/esXFzxAC8EklmPncqaBv?=
 =?us-ascii?Q?2UrCgfCU/Ze6jtcHIHEnP77GHYD0QgWiPiR72UaL2iYbXNtRlMMk3CYuHEuc?=
 =?us-ascii?Q?ccbdq0IyKLHxKt1T8ruRdcW7c+Dji3R7gAceObJeJbvqb/YmJTnpR3/s8303?=
 =?us-ascii?Q?NBTpJCNaBn8VKo3US7fvxq5qwFXcXIj5Vpgzgp2+XZ3pcII60J/DmFKSRDDI?=
 =?us-ascii?Q?xIeNR1SH4pbBRfS3o22j8K0VRHGKfQgYG8NuDZALttJ9DmCVGNzoG4z65D98?=
 =?us-ascii?Q?u/cFJWhq+7ieOfXLZ/EsXznGnZj4xrxVEh3QykNSm2cBIm7UKqF291FO/QDS?=
 =?us-ascii?Q?HWK3yZQ2kgggSy4OTtP4sNt2cB7RVXSnnJ1ERDXvp4eKUaVrDEj047gMsXP+?=
 =?us-ascii?Q?RA+pwaA3UbsXzsRAvBGlKL38LPg7EmGqRrpErB1UPT0z7vUUw3BxqFgGhjVE?=
 =?us-ascii?Q?A8qf+di08+wE9b7cqIEXZCKWRN//r+AQ//3Lunod7T1PJQU4KaNTHfHxVUxW?=
 =?us-ascii?Q?fE4BYuYwgkGypJuQHfQwL4ID3eb1ad6Jn/6I9hucHEh3hUK+TKPlqwsNpeQ4?=
 =?us-ascii?Q?4JMkkFzo9NyE0sPJfbCIbiAQ7cVdyswA5/GcK1MhySP1azdgCIkycKJmke0W?=
 =?us-ascii?Q?LUMggysI1NEY7XpZyvUuEgNHO56JWUROy3iMHU/VSGMWz0b3Lso2tjWpoPC6?=
 =?us-ascii?Q?GzAXWXnZHStXsTV4oSXVIy7qbao+eHBGGgD/Nx3QKAgOD6enyCkiI5jjcpuN?=
 =?us-ascii?Q?6ju8ZAUhcfNLeZN6YQyAeYI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0731c85-3bb0-4b48-c0de-08de3343dbdd
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 14:46:07.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhyH2y4TmgCrbZcOucVC91+g8BVxZfWSLeOl9yV9Sk9j+iXXZ3FK0vsVmWyMUVnx5BwhTlnAdXeaH8yC/rjO1Q0p7TIDTz19W4pNMdslnUWXCWsfWmg+YKKVEPGs7wPB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0177
X-OriginatorOrg: aisec.fraunhofer.de

Tested on qemu and on a custom hardware implementation of zicfiss and zicfilp in the CVA6 core

Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>

