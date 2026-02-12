Return-Path: <linux-fsdevel+bounces-76984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPhTLqskjWkRzgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 01:54:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E35128BCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 01:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA0C308A40A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9E1DF72C;
	Thu, 12 Feb 2026 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VQnzBRXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D76189F20;
	Thu, 12 Feb 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770857632; cv=fail; b=MkMcg+fL7/deGMVbHrtieVM6gj4m1pli2l+72HTz5SOMjzCUAbkAHt7qYheSHFdqmCvSL/oXsAhSFJyO3sfTN5dp+hvKmbewrzsdLURTQkL7QMPL9CyoPlDYGjnQtFecm/gA/NnEoDjRL9T40qGOwfnl3U0DVi8HHW77vUu0Hwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770857632; c=relaxed/simple;
	bh=rQrt2iIsf6z+7Tp+TsQAL8VNCS1zJ09uCWDVZ/84loY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KIbbmCznZFVSFXlfKKy4vET/actPHZRkRolxkdzZa6g4by+fQUdthxUt4eObUfpkpIZuf2QChkht0KegdEYplzKRV3wJP7cywLFLZlaoJ4CDV5tAjK2aGSTV/XdtWLnhtvrhBbIEdF/37Z7izuW9zeLfOWd94/fQeJDP8EDNMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VQnzBRXx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BFnGIH614323;
	Thu, 12 Feb 2026 00:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rQrt2iIsf6z+7Tp+TsQAL8VNCS1zJ09uCWDVZ/84loY=; b=VQnzBRXx
	1nOQGkTj+OhMM6Qg1K1eCD/Ve0jGMXySMhdBv6X0HkbKRqGCZ+6kBWSgi2FSZljF
	5lTDBY9mXrlqf1plMiq+Oc+sJKK81LFwZe9Y4meZytxQZS9qs2n4zRL1pmDcqLH5
	4LEjJ2Z2JKxhPiahT6cbt5yR/e+aULlSdEkPGkygpqD3V9MXascthhdyvYXp2dCO
	PzLbgxHCGWtrKEL3hn+7V7w1hR20TuRXAixA2jMHlxndnD0NZDbb/yHfsLBdQj8+
	8jTc2zZ9VbkX1Ckj9eccew5+UjFGvRUD2MNQ/5aWI1arYmeJ5UpqevOnPztIiqqp
	vpoPBsttRku6Ig==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wbw0r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 00:53:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGq2hVTEJJblVzkXL5aohlbMaut9p7jnwoSIPRaHLQTpLaF9w1uQell3m2IUpgD6k6VgcBci2ElpIDvoe46lnbKAWFcB5qae0JrSA+H2ixbYAecwQDZHVxOb4sWkdEcaYBsj+5bzO9tAxxxkZTN3GIiLBBBh9A7/oJGwpv80ydfrBO5X0ukJfyK422qyMibe6dbR5Fs6cPUx08IwNHLR81CfmD3a5NsboakFqKS/rcVKGvuWyoXvvFsvFfYhInN2a5QS1tGBW6QqqcBVpKRNaFXhqKGDbitYxtLDNAPzab47suYl2KFRPQu9hmQ5RHlMetDchKotOusJ8N3hKpiB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQrt2iIsf6z+7Tp+TsQAL8VNCS1zJ09uCWDVZ/84loY=;
 b=nBMTj+U+aYtN6/xOQwh8GAip82imjWg8uMzAx1OuIaQr8UvkF+7DLHo3o89AId49mMN/XrEwWKUBWWPdI305Nz9voID4JGkOHHUVchdomOmV16P/8pRIVcZtcLWyrL6t0cGQ0LnsKDb/KReMLaUq3nzJRIMEj0ykZXkkPkU1Oobn2Uce2Z9TcHV6Er3eNHWV0ULfjB0jbiXQmcEKkBcHZKczXsCq8V+5nmt3Xg/hDP73V+z9bB+pPAp2haFH7sZ9NQK75JNSUNUqHie/cQmNmPoBi6CXgL7VwBJesJR/a9y+M4vQEQekZNrAKvZIp3HiRCnSewE/q2qsOPBez4tNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4476.namprd15.prod.outlook.com (2603:10b6:303:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 12 Feb
 2026 00:53:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 00:53:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jack@suse.cz" <jack@suse.cz>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>,
        "chrisl@kernel.org" <chrisl@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clm@meta.com" <clm@meta.com>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML)
 library in Linux kernel
Thread-Index: AQHcmpPXPV+chNeGskiA4zJOQ4d3LbV8a+KAgADYFwCAAProAA==
Date: Thu, 12 Feb 2026 00:53:37 +0000
Message-ID: <224ceff96f02288f9cd660348b722335b0e9eaf3.camel@ibm.com>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
	 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
	 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
	 <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
	 <11f659fd88f887b9fe4c88a386f1a5c2157968a6.camel@ibm.com>
	 <kw4qco6aq4bq55nmb4c5ibicmj7ga77vtgzlj65jtdhzowks5m@buhefb6m4eqx>
In-Reply-To: <kw4qco6aq4bq55nmb4c5ibicmj7ga77vtgzlj65jtdhzowks5m@buhefb6m4eqx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4476:EE_
x-ms-office365-filtering-correlation-id: 8ee5ebb8-2505-48b3-eaca-08de69d12837
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEE2MDlnTTMvQUhPZnRzSFlvTG9CbTRBT1BmNkxjTTFwai80ZFlOY09EQU9H?=
 =?utf-8?B?OWVBaE5NZ05XcW9EaTAwTFdib1FiVHNwWUs4bC8vV3k3WTR4Y2ZaMmR3RG1R?=
 =?utf-8?B?WEt6TDI2ZFNKSU5McTRScDZvbSt6ZzlvejU4WGdaNitHWjNHdkV3UUZOZlcw?=
 =?utf-8?B?S1o0UXUwQWR6YVdpZWI3QWZCYUpzbDBEVFo4UE5wWTBBc1A1eG9pOWoxZUdQ?=
 =?utf-8?B?bnRvTHVmWTB1YWZKbG1NR0ZvbjZXV0EzM01RWGhUZkJqLzliWGx2UnA1UmNJ?=
 =?utf-8?B?VHlueUR6d1dMdkJSN09PRmd3S242TDlwamRQQVhhNS8zRDE2eFhLSjNTUDIw?=
 =?utf-8?B?MXpFSzlWYld0OUNFKythWitsTCtvNHhZSnZnVE9raURuNE9QQU11c3V6RzZI?=
 =?utf-8?B?c3VrZzNkSkJOc050SjBsT3RVNUZyakRBMEdmcGFWNnZyV3B2Q2hpbzN0OStu?=
 =?utf-8?B?U3JwSkxqSzhCR2lyM3BjU09WeEZmZ2xvQVY5aWNsay9CNEJEZjdEZEVRbDN6?=
 =?utf-8?B?WithQW5ZdDJ0WmtJMjRNK09hbWhRdkRNYTlkT01ybFRyOWVIQWZFZE5tZ25l?=
 =?utf-8?B?SDdiWjZJeXR1a29vL0d3dTFsN0tWaUNMcFJFdG90TlFpc0p4NzRkbGtaOERN?=
 =?utf-8?B?Tk40SkRrY3NWRDhycjVBL1hyYmtlb2RoYU9pc3hSa2x1WjN0UW5pamJ3NFJO?=
 =?utf-8?B?b0xHM0kya2pzRnVkcEpQSVpydzE4anlpRHdOT1ZPZ0dYOWdUM2RVYUNzSjVa?=
 =?utf-8?B?b2E5TUxXaXhmNFVLS3FDa2VYcHpBWU96dlNYQ01HQkgzSEw2QkJ1OUI3ZXp5?=
 =?utf-8?B?YlBiLzl0Q1kvNEZJUzVCNEhIVmFUZ3QrZDlGUktBczk0ckE0cEFPNjF2K1ox?=
 =?utf-8?B?RE5hRU1YaERsK1oxOC8zdG5sWXdvZ2ExZHQrM3NlVGR3ZldOQ2ZPMlZteEJL?=
 =?utf-8?B?SWR4MWVOZUFoTlpOTDR6cW9HeEhDQmc3Z1V2aHd2K0ZaaGgrMERiT0NsWFNY?=
 =?utf-8?B?ZWVsWC9FbERHbkc0YXJTdDJtRlQ0Y1R0bVBrYjJNcGMrdk4wWklMU05maUlF?=
 =?utf-8?B?bDlCbytpRmZmRVA5ZUhja1Q2Ti9VMno5N0JWdE4yUzBDbDZqM1FjUVNtbDl4?=
 =?utf-8?B?QiszVm9BSDNXOXhyTmZyd3BMTVJvV2txcmllV0ExRlpDOHVUaFNNUzdMM3FB?=
 =?utf-8?B?S3ZNOEo0MkphOCtGRmhwRkw3Nk5ITHdWQmp0VjNsd204UXR5ZlJtV1cvYUhP?=
 =?utf-8?B?d2xUbzBxSlB4bUlFbEF3NUNQeUdXRTYxNExPODNZbGIySzZlcVBhS2VVZjk4?=
 =?utf-8?B?M3ZLTnBHL2FSRjFnMkphM1NQRG9leEZXLzdwaDFJTmxlSGJubDZEeDdidUdO?=
 =?utf-8?B?L0RqNkwxY3p0RVVDeTJ1QTA1UmpReG50SEFYUWxmM01Ccy83d0VJRFZSaENs?=
 =?utf-8?B?dkI0TEtkclhBOERkTW91eTU1UGlBdEVhYWRPZnQvR2lCZCtWS2F1UkhtYk9W?=
 =?utf-8?B?UWh5WExNME1kTDZBNlFKZUVNbituUXUyWm5PVTFodUhLK3g5WEl5c2ZBdU1Z?=
 =?utf-8?B?c21maEU5eUlDOTBwS1N2aktKcWVMZ1VRSzZsVmYrZWFveUN3OTlPYTF1Tnpr?=
 =?utf-8?B?R2IzcFQrdEovMGJsRndudnF2bWQ0UDNMdjVxaUxDSUl0b2Nnd2V3SVlRMUZn?=
 =?utf-8?B?NVl6Sk9rTHhBVFdTQ1pGemtYazc3NWd4V1krWUM0aHgzdGJvQTlpYnk4VnZL?=
 =?utf-8?B?WUo1MWx6WXQ4UnBuLzBLbzRieW5xYjNsb01RVWM4NFNDeWgzUjZ6UU9sMHRI?=
 =?utf-8?B?RlFxTlRvd3owTmZ1U3lhbEdiazNpL0ZyVm9DVXJFZzNnalRXSlU0Y1p0QnVT?=
 =?utf-8?B?TkFEc0xHejc0YUU5NENlRWxEY2Y2WHp3ejZoK1R0MVU1N2VIY3kvRW4xTHhY?=
 =?utf-8?B?U0x4S3V1NTBJcHNvdEpLOGNXWFZFWERxSmtjb0FMaEJKU2R3RUhNbElSajIy?=
 =?utf-8?B?d1lMT0RBZXdCZ3VEZTRhenNWVWFCdno5N1N0cTdZVDUwUngrd3RlT014a2VT?=
 =?utf-8?B?SGR6bDNxRG1sYjZjOG1YNHJ4OFpjeTFPeEFDYWJua1AwNFYwNm1FNytsNUdK?=
 =?utf-8?B?b2pNUzVrTzZSOFRCcWdxRUdIYzVhVVhLUzlUTy9IYVVrRm5OZmFsSzU4OWNG?=
 =?utf-8?Q?I6+etkOFv0aJAIuzkzlhmRU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlR4THZlR010dGE2OUxUeFFiRHJ0dStyMXZNRE9rNE05WTBuREhORVpZWWNL?=
 =?utf-8?B?Q3ZadGFVTmI2QkVnN0FlUG11RE5za3pOSll4N21aY2VwVkR5VDNaZWRMSG04?=
 =?utf-8?B?ZmEwUkFDRkJ5VytGQ21MTEZxRWNLa3k0NkFWVHJ4ZGc0b0Z3VVg2aVA3K2VM?=
 =?utf-8?B?SlhtTEQ5bEZtQWYwd0dCdXB6TVdLN3dBNTFQUG8zSUV4Yi9CSndvTmJKRWFr?=
 =?utf-8?B?TEVHeUI2VXhIL2pPVEYvaktFeVEway80OXR4V3pjaUtka2dielJlTlcxTUV4?=
 =?utf-8?B?MU9ySlYxNHl6Wk5KeU12d1QwOXBCeFlXY2RzUHMxUlVLUjlBWXdieXB4cXMr?=
 =?utf-8?B?Q3hqVE1RcVpOSGVqRGFmZ05BMUpEcUlNVEFhMHEzNXh1QW14dXB6SFc1bUZq?=
 =?utf-8?B?UEw0T3o0eVdTVDcwSlJremFsTmR0aXpCOVdaTG9rNm9vZ2dNbUFhRkNYOWFW?=
 =?utf-8?B?bmh1dU9Pb3BNVUgxamR5RndvL1Q0eDF0Sm1kY0FWYnBRUUtIa0NKYzZSMGdP?=
 =?utf-8?B?VDlENzlxRytPem5QbU42OHJ1RFZnc3d4Y2Z4VGcybTNia2FSLzFnT1Z1OVhE?=
 =?utf-8?B?UUFCdzFlZzZCOWcwSmt6YThRZ0hSS2ozNWVHT3JLQ0dvQkgyU2pZRDVGZy8z?=
 =?utf-8?B?bDgreDljOWx0ZlhsYjJGODViWWswQlhNajcwbFMzR2hZWk1mZTJXcGxMcUxi?=
 =?utf-8?B?eFIzTTlXUTd3R241MStzdHdLUnR1bjlZQm9MaHA3NXR0dVVSYXNmR0xBLzVJ?=
 =?utf-8?B?OVV4Vml4Zi81bXVPbVNwZElyVVVLZFZDZmNHVmg5MmE5Yit6WUc0ZXlZNTNU?=
 =?utf-8?B?OEJxaEFTTGJJc1pWQkRUNzR6QUdwci9LeGY2WllGTmU3N0VWMXNNamFjUFlv?=
 =?utf-8?B?cmVTYVk0Y0pvY2x4YWFwODdldlpVN1hKbnZma28rY1FwRzJvbnhWalRrcTUx?=
 =?utf-8?B?aGdHSnhEdkJFdVRSdlRMVVIrZnhXQzR2RGVzbGYyaEdjSG9uMnlra3BJd3BH?=
 =?utf-8?B?cGMvdVRoajFmTEFxdW1NTUNtdEoveVJiOHpIekhrcFdVeFVxVWtHZUhkRks0?=
 =?utf-8?B?OE40QmZKbEJYTk9kTHNPc2lwSGRDRXp4VVNXUlVhcWxxYkd2cFdweE9XWGNm?=
 =?utf-8?B?SHVRMzVRZllEclo1ajM3S3l5emxRN0lYdkEzY0JCdmRha2E1UGRGYWZrdlRt?=
 =?utf-8?B?T1RQLzhkRWtxdCt5TGRQbm45ZEpwZVhpcnhIQlRPa1BMc2dtbjJTeGdicnRx?=
 =?utf-8?B?amtIN3M1a3hmTllHelU4MXplWWkySGZRSGtUbGRzbG8vVHc0dFJyeUJDZ1Ur?=
 =?utf-8?B?S3BnTWlNWkhnSGg3K3NnN3Jmd3IxOWhPNXYwbWQxdWlNS2Q5WFNraU9KeTdG?=
 =?utf-8?B?U2VBNldqYmdiTVlDYi9zZU93c3NmLzdmbmdLUEdTakxWcnhhMWhqckQzWTFi?=
 =?utf-8?B?a3FzSXE3d281cTlvSHdHbUpBQXd1dUsycmpMSEQwYVJ4WUJNeldHdEhHdVdD?=
 =?utf-8?B?b3dQdzZkeHJUNWJVeHRXMDVaQklUbjVONUYxQi9WeHV2QjBWWEptNGQzSzg3?=
 =?utf-8?B?M1p1YUM2MmJiRjhJNFp3MmJqRzdkaVQrTmRldkh5S0lUSjRTcWFneXlyR3JF?=
 =?utf-8?B?R3JmVjJSNktaR3lESFFSK1d4bi9aa3dwMUZBOGVFRFBVRmEwRnZ6Y3A5VDJT?=
 =?utf-8?B?MS9LNlpmbzRKZ3E3UlR3VlJTL2NuZlJPaVZrNXFNZnQ0ZFdTWjJCOXFYYmVr?=
 =?utf-8?B?STQwWk9HSnJySUd4TzJSREhsdkVtSkloK1ZPMWR5UCtXYUJINnZJc3Y0YmQx?=
 =?utf-8?B?S21rd2l1N0ZEZTJaR2lWM2RDQTd1VWd5RGxaanpOTXo1RkNPMXBHVis3aXVp?=
 =?utf-8?B?eExzZ0FYSE1vZDZOcytGNE1ZYkI0OFFYczBhVS9JN1dpUVNkYXA2SDg4QjIx?=
 =?utf-8?B?UG83clNOcVk3U0N0U29WSlVYSWkvNzdGNzAzOWJSckVhYzQ1ZGMyK3hFNUh0?=
 =?utf-8?B?OUhzR1ExTk9NbUN4MVdhci9ocVBGWVBvbHpraE10UnhjMW1zNG5JOWZGVWt4?=
 =?utf-8?B?bld2andMUGFKYlRRelFjSWdGdkJVNC9NL2ZublR2VWF5MUo4ZkdUdi93aGM0?=
 =?utf-8?B?dVRWNVZ4QjFHa1VoWkpiNHVScFdBRkZndUVwVWpEaUlTMEhsK01ERTh4dHVB?=
 =?utf-8?B?NHdBNG9WN0c2NHB1VDc0RWs3VmNWaFZjRTRJM05Tc0dKa2VCTUtsUU90MVZ6?=
 =?utf-8?B?R24rR25nY3Q2WlhVK245YnNQR2ZOL1BDM0JOaFBydnpjaVJjZyszZWhMdG9O?=
 =?utf-8?B?a2s5RmUvYUU3N3JZblF4Z3pTVnNjeXloVFVmd2FabEdnWDVHWGpoMWdISGY2?=
 =?utf-8?Q?fJwmQBYnDGkptxmKIlUD8F5sLXTKWUik8isGr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9E225CE7413B84CAC065218984F055E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee5ebb8-2505-48b3-eaca-08de69d12837
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 00:53:37.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2qVMTFiF1oPGTmwoL2cA4kdDyKjygShWGdlvmoOCodXut7ZWYqZDf0oulnpmESE3ZMM5RABSTGgBV+KoSxVlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4476
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698d2494 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=MR2AcgdVOd7EpztyXXIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: woqdXuy1-hwlmGcFfY2-q9MnGj44rpLb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDAwMyBTYWx0ZWRfX/EWjOACyjeOE
 h3OnBJ7qCTkdPGOImngcEckXeWB8Mf3i1AHtLD3O3W4DwZCWht9U4F/2PAgzTSBIdv+m7z9qVEx
 x1MvLa30t/18HpFGpUBOEnQXOyVYQKdD+uOhS7WyO1r6KWJzjMSS+5LI4LhfynXlg3ot5nTjedn
 H2CwFNxZGh6Frbi3n+fI6iPpvWtxoeqoYHHLdB4WTKY66GC/g0VoD1aw6oG6BcPANIB3Nc3G81V
 /94p2O5+5wALBhxbXgEphhgxkgEoGYAQs242v53/GISpCCBOmcthby6EX3/G6TqU6nVA2+8dykU
 2HuqEqjNRGUo0sUNP9tbATKRSkcjxFXo4ymakYqcTOVAGfpxy0VeAxqaYw5xniveZtxhZN+1Hpq
 2H73yxVMbt6lXH+wGBst09avPF65IpxdoS8sLqMMgI3rXnr9VR6hdQxm4edfLgNmbPwWoGufD3D
 Z+8gxy9SVZJhOLjetSg==
X-Proofpoint-ORIG-GUID: woqdXuy1-hwlmGcFfY2-q9MnGj44rpLb
Subject: RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76984-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13E35128BCE
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTExIGF0IDEwOjU1ICswMTAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
VHVlIDEwLTAyLTI2IDIxOjAyOjEyLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gT24g
VHVlLCAyMDI2LTAyLTEwIGF0IDE0OjQ3ICswMTAwLCBKYW4gS2FyYSB3cm90ZToNCj4gPiA+IE9u
IE1vbiAwOS0wMi0yNiAyMjoyODo1OSwgVmlhY2hlc2xhdiBEdWJleWtvIHZpYSBMc2YtcGMgd3Jv
dGU6DQo+ID4gPiA+IFRoZSBpZGVhIGlzIHRvIGhhdmUgTUwgbW9kZWwgcnVubmluZyBpbiB1c2Vy
LXNwYWNlIGFuZCBrZXJuZWwgc3Vic3lzdGVtIGNhbg0KPiA+ID4gPiBpbnRlcmFjdCB3aXRoIE1M
IG1vZGVsIGluIHVzZXItc3BhY2UuIEFzIHRoZSBuZXh0IHN0ZXAsIEkgYW0gY29uc2lkZXJpbmcg
dHdvDQo+ID4gPiA+IHJlYWwtbGlmZSB1c2UtY2FzZXM6ICgxKSBHQyBzdWJzeXN0ZW0gb2YgTEZT
IGZpbGUgc3lzdGVtLCAoMikgTUwtYmFzZWQgREFNT04NCj4gPiA+ID4gYXBwcm9hY2guIFNvLCBm
b3IgZXhhbXBsZSwgR0MgY2FuIGJlIHJlcHJlc2VudGVkIGJ5IE1MIG1vZGVsIGluIHVzZXItc3Bh
Y2UuIEdDDQo+ID4gPiA+IGNhbiByZXF1ZXN0IGRhdGEgKHNlZ21lbnRzIHN0YXRlKSBmcm9tIGtl
cm5lbC1zcGFjZSBhbmQgTUwgbW9kZWwgaW4gdXNlci1zcGFjZQ0KPiA+ID4gPiBjYW4gZG8gdHJh
aW5pbmcgb3IvYW5kIGluZmVyZW5jZS4gQXMgYSByZXN1bHQsIE1MIG1vZGVsIGluIHVzZXItc3Bh
Y2UgY2FuIHNlbGVjdA0KPiA+ID4gPiB2aWN0aW0gc2VnbWVudHMgYW5kIGluc3RydWN0IGtlcm5l
bC1zcGFjZSBsb2dpYyBvZiBtb3ZpbmcgdmFsaWQgZGF0YSBmcm9tIHZpY3RpbQ0KPiA+ID4gPiBz
ZWdtZW50KHMpIGludG8gY2xlYW4vY3VycmVudCBvbmUocykuIA0KPiA+ID4gDQo+ID4gPiBUbyBi
ZSBob25lc3QgSSdtIHNrZXB0aWNhbCBhYm91dCBob3cgZ2VuZXJpYyB0aGlzIGNhbiBiZS4gRXNz
ZW50aWFsbHkNCj4gPiA+IHlvdSdyZSBkZXNjcmliaW5nIGEgZ2VuZXJpYyBpbnRlcmZhY2UgdG8g
b2ZmbG9hZCBhcmJpdHJhcnkga2VybmVsIGRlY2lzaW9uDQo+ID4gPiB0byB1c2Vyc3BhY2UuIE1M
IGlzIGEgdXNlcnNwYWNlIGJ1c3NpbmVzcyBoZXJlIGFuZCBub3QgcmVhbGx5IHJlbGV2YW50IGZv
cg0KPiA+ID4gdGhlIGNvbmNlcHQgQUZBSUNULiBBbmQgd2UgYWxyZWFkeSBoYXZlIHNldmVyYWwg
d2F5cyBvZiBrZXJuZWwgYXNraW5nDQo+ID4gPiB1c2Vyc3BhY2UgdG8gZG8gc29tZXRoaW5nIGZv
ciBpdCBhbmQgdW5sZXNzIGl0IGlzIHZlcnkgcmVzdHJpY3RlZCBhbmQgd2VsbA0KPiA+ID4gZGVm
aW5lZCBpdCBpcyByYXRoZXIgcGFpbmZ1bCwgcHJvbmUgdG8gZGVhZGxvY2tzLCBzZWN1cml0eSBp
c3N1ZXMgZXRjLg0KPiA+IA0KPiA+IFNjZXB0aWNpc20gaXMgbm9ybWFsIHJlYWN0aW9uLiA6KSBT
bywgbm90aGluZyB3cm9uZyBpcyB0byBiZSBzY2VwdGljYWwuDQo+ID4gDQo+ID4gSSBiZWxpZXZl
IGl0IGNhbiBiZSBwcmV0dHkgZ2VuZXJpYyBmcm9tIHRoZSBkYXRhIGZsb3cgcG9pbnQgb2Ygdmll
dy4gUHJvYmFibHksDQo+ID4gZGlmZmVyZW50IGtlcm5lbCBzdWJzeXN0ZW1zIGNvdWxkIHJlcXVp
cmUgZGlmZmVyZW50IHdheXMgb2YgaW50ZXJhY3Rpb24gd2l0aA0KPiA+IHVzZXItc3BhY2UuIEhv
d2V2ZXIsIGlmIHdlIGFyZSB0YWxraW5nIGFib3V0IGRhdGEgZmxvdyBidXQgTk9UIGV4ZWN1dGlv
biBmbG93LA0KPiA+IHRoZW4gaXQgY291bGQgYmUgZ2VuZXJpYyBlbm91Z2guIEFuZCBpZiBpdCBj
YW4gYmUgZ2VuZXJpYywgdGhlbiB3ZSBjYW4gc3VnZ2VzdA0KPiA+IGdlbmVyaWMgd2F5IG9mIGV4
dGVuZGluZyBhbnkga2VybmVsIHN1YnN5c3RlbSBieSBNTCBzdXBwb3J0Lg0KPiA+IA0KPiA+IEkg
ZG9uJ3QgdGhpbmsgdGhhdCB3ZSBuZWVkIHRvIGNvbnNpZGVyIHRoZSBNTCBsaWJyYXJ5IGFwcHJh
b2NoIGxpa2UgImtlcm5lbA0KPiA+IGFza2luZyB1c2Vyc3BhY2UgdG8gZG8gc29tZXRoaW5nIi4g
UmF0aGVyIGl0IG5lZWRzIHRvIGNvbnNpZGVyIHRoZSBtb2RlbCBsaWtlDQo+ID4gImtlcm5lbCBz
aGFyZSBkYXRhIHdpdGggdXNlci1zcGFjZSBhbmQgdXNlci1zcGFjZSByZWNvbW1lbmRzIHNvbWV0
aGluZyB0bw0KPiA+IGtlcm5lbCIuIFNvLCB1c2VyLXNwYWNlIGFnZW50IChNTCBtb2RlbCkgY2Fu
IHJlcXVlc3QgZGF0YSBmcm9tIGtlcm5lbCBzcGFjZSBvcg0KPiA+IGtlcm5lbCBzdWJzeXN0ZW0g
Y2FuIG5vdGlmeSB0aGUgdXNlci1zcGFjZSBhZ2VudCB0aGF0IGRhdGEgaXMgYXZhaWxhYmxlLiBB
bmQNCj4gPiBpdCdzIHVwIHRvIGtlcm5lbCBzdWJzeXN0ZW0gaW1wbGVtZW50YXRpb24gd2hpY2gg
ZGF0YSBjb3VsZCBiZSBzaGFyZWQgd2l0aCB1c2VyLQ0KPiA+IHNwYWNlLiBTbywgTUwgbW9kZWwg
Y2FuIGJlIHRyYWluZWQgaW4gdXNlci1zcGFjZSBhbmQsIHRoZW4sIHNoYXJlDQo+ID4gcmVjb21t
ZW5kYXRpb25zIChvciBlQlBGIGNvZGUsIGZvciBleGFtcGxlKSB3aXRoIGtlcm5lbCBzcGFjZS4g
RmluYWxseSwgaXQncyB1cA0KPiA+IHRvIGtlcm5lbCBzdWJzeXN0ZW0gaG93IGFuZCB3aGVuIHRv
IGFwcGx5IHRoZXNlIHJlY29tbWVuZGF0aW9ucyBvbiBrZXJuZWwgc2lkZS4NCj4gDQo+IEkgZ3Vl
c3MgSSBoYXZlIHRvIHNlZSBzb21lIGV4YW1wbGVzLiBCZWNhdXNlIHNvIGZhciBpdCBzb3VuZHMg
c28gZ2VuZXJpYw0KPiB0aGF0IEknbSBmYWlsaW5nIHRvIHNlZSBhIHZhbHVlIGluIHRoaXMgOikN
Cg0KSSBjb21wbGV0ZWx5IHNlZSB5b3VyIHBvaW50LiBBbmQgSSBhbSBub3QgZ29pbmcgdG8gcHVz
aCBhbnl0aGluZyBhYnN0cmFjdCBvbmUuIEkNCmFtIGdvaW5nIHRvIGltcGxlbWVudCBNTC1iYXNl
ZCBhcHByb2FjaCBmb3Igc2V2ZXJhbCByZWFsLWxpZmUgdXNlLWNhc2VzLiBTbywgSQ0Kd2lsbCBo
YXZlIHNvbWV0aGluZyByZWFsIG9yIEkgd2lsbCBmYWlsLiA6KQ0KDQo+IA0KPiA+ID4gU28gYnkg
YWxsIG1lYW5zIGlmIHlvdSB3YW50IHRvIGRvIEdDIGRlY2lzaW9ucyBmb3IgeW91ciBmaWxlc3lz
dGVtIGluDQo+ID4gPiB1c2Vyc3BhY2UgYnkgTUwsIGJlIG15IGd1ZXN0LCBpdCBkb2VzIG1ha2Ug
c29tZSBzZW5zZSBhbHRob3VnaCBJJ2QgYmUgd2FyeQ0KPiA+ID4gb2YgaXNzdWVzIHdoZXJlIHdl
IG5lZWQgdG8gd3JpdGViYWNrIGRpcnR5IHBhZ2VzIHRvIGZyZWUgbWVtb3J5IHdoaWNoIG1heQ0K
PiA+ID4gbm93IGRlcGVuZCBvbiB5b3VyIHVzZXJzcGFjZSBoZWxwZXIgdG8gbWFrZSBhIGRlY2lz
aW9uIHdoaWNoIG1heSBuZWVkIHRoZQ0KPiA+ID4gbWVtb3J5IHRvIGRvIHRoZSBkZWNpc2lvbi4u
LiBCdXQgSSBkb24ndCBzZWUgd2h5IHlvdSBuZWVkIGFsbCB0aGUgTUwgZmx1ZmYNCj4gPiA+IGFy
b3VuZCBpdCB3aGVuIGl0IHNlZW1zIGxpa2UganVzdCBhbm90aGVyIHdheSB0byBjYWxsIHVzZXJz
cGFjZSBoZWxwZXIgYW5kDQo+ID4gPiB3aHkgc29tZSBvZiB0aGUgZXhpc3RpbmcgbWV0aG9kcyB3
b3VsZCBub3Qgc3VmZmljZS4NCj4gPiA+IA0KPiA+IA0KPiA+IE9LLiBJIHNlZS4gOikgWW91IHVu
ZGVyc3Rvb2QgR0MgbGlrZSBhIHN1YnN5c3RlbSB0aGF0IGhlbHBzIHRvIGtlcm5lbA0KPiA+IG1l
bW9yeSBzdWJzeXN0ZW0gdG8gbWFuYWdlIHRoZSB3cml0ZWJhY2sgZGlydHkgbWVtb3J5IHBhZ2Vz
LiA6KSBJdCdzDQo+ID4gcG90ZW50aWFsIGRpcmVjdGlvbiBhbmQgSSBsaWtlIHlvdXIgc3VnZ2Vz
dGlvbi4gOikgQnV0IEkgbWVhbnQgc29tZXRoaW5nDQo+ID4gZGlmZmVyZW50IGJlY2F1c2UgSSBj
b25zaWRlciBvZiBMRlMgZmlsZSBzeXN0ZW0ncyBHQyBzdWJzeXN0ZW0uIFNvLCBpZiB3ZQ0KPiA+
IGFyZSB1c2luZyBDb3B5LU9uLVdyaXRlIChDT1cpIHBvbGljeSwgdGhlbiB3ZSBoYXZlIHNlZ21l
bnRzIG9yIGVyYXNlDQo+ID4gYmxvY2tzIHdpdGggYSBtaXh0dXJlIG9mIHZhbGlkIGFuZCBpbnZh
bGlkIGxvZ2ljYWwgYmxvY2tzIGFmdGVyIHVwZGF0ZQ0KPiA+IG9wZXJhdGlvbnMuIEFuZCB3ZSBu
ZWVkIEdDIHN1YnN5c3RlbSB0byBjbGVhbiBvbGQgc2VnbWVudHMgYnkgbWVhbnMgb2YNCj4gPiBt
b3ZpbmcgdmFsaWQgbG9naWNhbCBibG9ja3MgZnJvbSBleGhhdXN0ZWQgc2VnbWVudHMgaW50byBj
bGVhbi9jdXJyZW50DQo+ID4gb25lcy4gVGhlIHByb2JsZW0gaGVyZSBpcyB0byBmaW5kIGFuIGVm
ZmljaWVudCBhbGdvcml0aG0gb2Ygc2VsZWN0aW5nDQo+ID4gdmljdGltIHNlZ21lbnRzIHdpdGgg
c21hbGxlc3QgYW1vdW50IG9mIHZhbGlkIGJsb2NrcyB3aXRoIHRoZSBnb2FsIG9mDQo+ID4gZGVj
cmVhc2luZyB3cml0ZSBhbXBsaWZpY2F0aW9uLiBTbywgZmlsZSBzeXN0ZW0gbmVlZHMgdG8gc2hh
cmUgdGhlDQo+ID4gbWV0YWRhdGEgZGV0YWlscyAoc2VnbWVudHMgc3RhdGUsIGZvciBleGFtcGxl
KSwgTUwgbW9kZWwgY2FuIHNoYXJlIHRoZQ0KPiA+IHJlY29tbWVuZGF0aW9ucywgYW5kIGtlcm5l
bCBjb2RlIG9mIGZpbGUgc3lzdGVtIGNhbiBmaW5hbGx5IG1vdmUgdmFsaWQNCj4gPiBibG9ja3Mg
aW4gdGhlIGJhY2tncm91bmQuDQo+IA0KPiBObywgSSBhY3R1YWxseSBtZWFudCB0aGUgTEZTIGZp
bGUgc3lzdGVtIEdDIGFzIHlvdSB0YWxrIGFib3V0IGl0LiBCdXQgSSB3YXMNCj4ganVzdCB0b28g
dGVyc2UgYWJvdXQgbXkgY29uY2VybnM6IEFzIHlvdSBzYWlkIGFuIExGUyB3aXRoIENPVyBuZWVk
cyB0bw0KPiBzZWxlY3QgYSBuZXcgcG9zaXRpb24gdG8gd3JpdGUgZWFjaCBibG9jay4gV2hlbiB0
aGVyZSBpcyBubyBmcmVlIGJsb2NrDQo+IGF2YWlsYWJsZSwgaXQgaGFzIHRvIHNlbGVjdCBwYXJ0
aWFsbHkgdXNlZCBlcmFzZSBibG9jayAoc29tZSBsb2dpY2FsIGJsb2Nrcw0KPiBpbiBpdCBiZWNh
bWUgaW52YWxpZCkgdG8gcmV1c2UuDQo+IA0KDQpJIGFzc3VtZSB0aGF0IHlvdSBpbXBseSBGMkZT
IGhlcmUuIEJlY2F1c2UsIEkgY2Fubm90IGltYWdpbmUgaG93IExGUyBmaWxlIHN5c3RlbQ0KKGxp
a2UgTklMRlMyKSBjYW4gZG8gc29tZXRoaW5nIGxpa2UgdGhpcy4gSWYgaXQncyBMRlMgZmlsZSBz
eXN0ZW0sIHRoZW4geW91IGFkZA0KbG9ncyBpbnRvIHRoZSBjdXJyZW50IHNlZ21lbnQocykuIEV2
ZW4gaWYgc29tZSBsb2dpY2FsIGJsb2NrcyBoYXZlIGJlZW4NCmludmFsaWRhdGVkIGludG8gdGhp
cyBzZWdtZW50LCB0aGVuIHlvdSBhZGQgYW5vdGhlciBsb2cgaW50byB0aGUgaGVhZC90YWlsIG9m
DQpjdXJyZW50IHNlZ21lbnQgdW50aWwgY29tcGxldGUgZXhoYXVzdGlvbiBvZiBpdC4gQW5kIGl0
IG5lZWRzIHRvIGFsbG9jYXRlIHRoZQ0KY29tcGxldGVseSBjbGVhbi9mcmVlIHNlZ21lbnQgdG8g
YmUgY3VycmVudCBhbmQgcmVjZWl2ZSB0aGUgbG9ncy4gU28sIHlvdSBuZWVkDQp0byB0YWtlIGNv
bXBsZXRlbHkgZXhoYXVzdGVkIHNlZ21lbnQgZm9yIGNsZWFuaW5nIGJ5IEdDLiBJZiB5b3UgaGF2
ZSBwdXJlIENPVw0KZmlsZSBzeXN0ZW0sIHRoZW4geW91IGNhbm5vdCB3cml0ZSBhbnl0aGluZyBp
biBsaWtld2lzZSBzZWdtZW50IHVudGlsIGNvbXBsZXRlDQppbnZhbGlkYXRpb24gKyAiZXJhc2Ui
L2NsZWFuLiBTbywgR0MgbW92ZXMgdmFsaWQgYmxvY2tzIGZyb20gY29tcGxldGVseQ0KZXhoYXVz
dGVkIHNlZ21lbnQgaW50byB0aGUgY3VycmVudCBvbmUocykuIEl0J3MgcmVzcG9uc2liaWxpdHkg
b2YgR0MgdG8NCmd1YXJhbnRlZSB0aGF0IGZpbGUgc3lzdGVtIGlzIG5vdCBydW5uaW5nIG91dCBv
ZiBmcmVlIHBoeXNpY2FsIHNwYWNlIGlmIGZpbGUNCnN5c3RlbSBzdGlsbCBoYXMgZnJlZSBsb2dp
Y2FsIGJsb2Nrcy4gQW5kIGlmIHdlIGFyZSBydW5uaW5nIG91dCBmcmVlIHBoeXNpY2FsDQpzcGFj
ZSwgdGhlbiBvcGVyYXRpb24gc3RvcHMgYmVjYXVzZSBvZiBHQyBmYWlsdXJlIHRvIGtlZXAgZW5v
dWdoIGNsZWFuIHNlZ21lbnRzLg0KDQo+ICBBbmQgZm9yIHRoaXMgc2VsZWN0aW9uIHlvdSB3YW50
IHRvIHVzZSBNTA0KPiBBRkFJVS4gSGVuY2Ugd2UgaGF2ZSBhIGRlcGVuZGVuY3kgZm9saW8gd3Jp
dGViYWNrIC0+IENPVyBibG9jayBhbGxvY2F0aW9uIC0+DQo+IEdDIHRvIG1ha2Ugc29tZSBibG9j
ayBmcmVlIC0+IE1MIGRlY2lzaW9uLg0KPiANCg0KVXN1YWxseSwgR0Mgd29ya3MgaW4gdGhlIGJh
Y2tncm91bmQuwqBTbywgTUwgbW9kZWwgaW4gdXNlci1zcGFjZSBnZXQgc2VnbWVudHMNCnN0YXRl
IG1ldGFkYXRhIGZyb20gZmlsZSBzeXN0ZW0uIFRoZW4sIGl0IHNlbGVjdHMgb25lIG9yIHNldmVy
YWwgc2VnbWVudHMgYW5kDQpyZWNvbW1lbmRzIHRvIGZpbGUgc3lzdGVtIG9mIG1vdmluZyB2YWxp
ZCBibG9ja3MgZm9yIHRoZSBzZWxlY3RlZCBzZWdtZW50KHMpIElEDQorIG1heGltYWwgYW1vdW50
IG9mIHZhbGlkIGJsb2NrcyBmb3Igc2luZ2xlIG9wZXJhdGlvbi4gQmFja2dyb3VuZCBwcm9jZXNz
IG9mDQpmaWxlIHN5c3RlbSBjaGVja3MgdGhhdCB0aGVzZSBsb2dpY2FsIGJsb2NrcyBvZiBleGhh
dXN0ZWQgc2VnbWVudCBhcmUgc3RpbGwNCnZhbGlkIGFuZCBpbml0aWF0ZXMgb3BlcmF0aW9uIG9m
IG1vdmluZyBpbnRvIHRoZSBjdXJyZW50IHNlZ21lbnQgYnkgYWRkaW5nDQphbm90aGVyIGxvZy4N
Cg0KRmluYWxseSwgd2UgaGF2ZSB0d28gZmxvd3M6ICgxKSByZWd1bGFyIGZpbGUgc3lzdGVtIG9w
ZXJhdGlvbnM6IGZvbGlvIHdyaXRlYmFjaw0KLT4gQ09XIGJsb2NrIGFsbG9jYXRpb24gLT4gYWRk
IGxvZyBpbnRvIGN1cnJlbnQgc2VnbWVudDsgKDIpIEdDIG9wZXJhdGlvbnM6IE1MDQpHQyBkZWNp
c2lvbiAtPiByZWNvbW1lbmRhdGlvbiBvZiBtb3ZpbmcgdmFsaWQgYmxvY2tzIGZvciBzZWdtZW50
IC0+IGNoZWNrIHRoYXQNCmxvZ2ljYWwgYmxvY2sgaXMgc3RpbGwgdmFsaWQgLT4gcmVhZCBibG9j
ayBjb250ZW50IChpZ25vcmUgbG9naWNhbCBibG9jayBpZiB3ZQ0KaGF2ZSBmb2xpbyBpbiBwYWdl
IGNhY2hlKSAtPiBhZGQgbG9nIGludG8gY3VycmVudCBzZWdtZW50IC0+IHVwZGF0ZSBtZXRhZGF0
YS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIEFuZCBub3cgeW91IGhhdmUgdG8gYmUgcmVhbGx5
DQo+IGNhcmVmdWwgc28gdGhhdCAiTUwgZGVjaXNpb24iIGRvZXNuJ3QgZXZlbiBpbmRpcmVjdGx5
IGRlcGVuZCBvbiBmb2xpbw0KPiB3cml0ZWJhY2sgdG8gY29tcGxldGUuIEFuZCBiZWFyIGluIG1p
bmQgdGhhdCBlLmcuIGlmIHRoZSBjb2RlIGRvaW5nICJNTA0KPiBkZWNpc2lvbiIgZGlydGllcyBz
b21lIG1tYXBlZCBmaWxlIHBhZ2VzIGl0ICp3aWxsKiBibG9jayB3YWl0aW5nIGZvciBwYWdlDQo+
IHdyaXRlYmFjayB0byBjb21wbGV0ZSB0byBnZXQgdGhlIHN5c3RlbSBiZWxvdyB0aGUgbGltaXQg
b2YgZGlydHkgcGFnZXMuDQo+IFRoaXMgaXMgdGhlIGtpbmQgb2YgZGVhZGxvY2sgSSdtIHRhbGtp
bmcgYWJvdXQgdGhhdCBpcyBoYXJkIHRvIGF2b2lkIHdoZW4NCj4gb2ZmbG9hZGluZyBrZXJuZWwg
ZGVjaXNpb25zIHRvIHVzZXJzcGFjZSAoYW5kIHllcywgSSd2ZSBzZWVuIHRoZXNlIGtpbmQgb2YN
Cj4gZGVhZGxvY2tzIGluIHByYWN0aWNlIGluIHZhcmlvdXMgc2hhcGVzIGFuZCBmb3JtcyB3aXRo
IHZhcmlvdXMgbWV0aG9kcyB3aGVuDQo+IGtlcm5lbCBkZXBlbmRlZCBvbiB1c2Vyc3BhY2UgdG8g
bWFrZSBmb3J3YXJkIHByb2dyZXNzKS4NCj4gDQo+IAkJCQkJCQkJSG9uemENCg==

