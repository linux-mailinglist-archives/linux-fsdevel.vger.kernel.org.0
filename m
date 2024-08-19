Return-Path: <linux-fsdevel+bounces-26268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A0956C24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C549284C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC816C86C;
	Mon, 19 Aug 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKiPVU8m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cge4X9v1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B01DFE1;
	Mon, 19 Aug 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074311; cv=fail; b=mPht8DkADn6yY2l3QMW09ei4ZDh+KNsJAOJ137JEbXIECLwbx/nM0xoO2O6r3/Dz6a4jkEg+vPH9lnisPOo0TxqJekF7hLuwLxLoFFNy2w6kfxapdHpQ27VMNLbelYFhtvh+TVumoVnRM4qtdnXX3IhETPKAMhECCTOmIntEefU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074311; c=relaxed/simple;
	bh=ESxvUKBefmu1rCe3aeBUvTrcZEGWO47YaawxoYe42Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLIoTsa/3gi+N4DCxSN+LfbLzbTZoiVneENo0jqYSuHNf5nX0UMDminXLBIzfqF38sWe2DTBux4Z/pg2lFvnwqaDNcvA9afTZpTVYn+YYNEQMZ65NtXQlD4ffdetf3a/JIt3T7NLPaGeFgnmjcOj0yO8WXzKMrIemuuw0ZKayH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKiPVU8m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cge4X9v1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JD6s4J018615;
	Mon, 19 Aug 2024 13:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fqsB+O2rY3LpHzS
	lyzJQQOn02jdv7b7Qqgssmiotrd8=; b=ZKiPVU8mYa74ToNYx3pgX3shRgSAhc/
	d143tSr+jDLTjfgPCk8lMW+U1eP3KGzdhNEHc49dh3468bHIrrrwtwfq1h+sZepv
	czMfCDhdpThFDVWdokaFAzPPj0lp5uGXXaX40YEvyLAVnzoAq8mnYrPKJ0onPhYO
	MlFZeHnUw/s7H1CRrOwWfDi8A4ACwKJutZ0OU+0zqeUppjv3ZPKSiyKkpAkFrR9t
	c1/JR2uPcEZfLygZonTkuvWxuIo6OsyQ0AcxL1xCykr+lSMK3gSxsIWOOPuYZlTE
	ghsJwzJUtZ2zqD+Fbcoua/PAEirVYSk/OVJg0qQF2FYqPXArn1Uo2ww==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3hjjs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:31:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.17.1.19) with ESMTP id 47JDMUIo029847;
	Mon, 19 Aug 2024 13:31:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 413h3p56hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 13:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA+ld0VCnSPbP6ahEPIi9viC30eyjkQpCO0GC2hz2xTz3ix8PJiUZcMV1T4sLpmZJEcz4JAQy8d9sQ3yxzxWAVO48sJEXQTV5w/WRv1usxA46LDtFpOwylzhmqumgN4n6omEjHt7Ny+za4kD/p7TdpTbdIRfAO1AbWQuZ1aUItWb3UIo3rn49bsaqhVh6gYfaaPhib9NhjFZqNv3NnWBCZKaLWy5iTxEUwXSIt7TFRLw25NtglAN7oaQbGTteAy6NomEz9K6c42CV+l8j2g5ONKev2znSTq8YJgceJafg2xl0zHp4uruXFFFLzyCX5rMZ2RiT6hD8erVHFM/1rvPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqsB+O2rY3LpHzSlyzJQQOn02jdv7b7Qqgssmiotrd8=;
 b=itOeiQIu75UiSkyJBECUFL9WtG3KVjaAisNnxS/6jOWlGF1nJsXs4b9dWlcnj94c18Ti7nTaNHiUwhyzRtrGiCSag815eatYhdh/sb+0v1M9VQQzF6obKZZE9fzYUcSW20+AK4sum6OcYEJsjLvYXPDqZHUgd1yBK3Qd9nx5hk1CXpvkd5nQH+mzIzcMgmE52hoQrccqgKrcRXeVLJR/06pRamBn62k/LVt9q2nC7ngV2erOyepaUHqGMfm9UcIkwJ3Rcs3v4HFmi1+PEAJquis+jEmJ89cr+8lzh7F/SsRzWdBC78lY/yPnPgcEtZJcvdAFjiTE0gvqurBxycWM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqsB+O2rY3LpHzSlyzJQQOn02jdv7b7Qqgssmiotrd8=;
 b=cge4X9v1XQxQdvUsx7xttW/LPvLmj91qv/xBQi1+72FkN7BwzVmm5PflOQ6UHuP9y4JGJQevmlG5RwnbkrAj++jvtlighlYYGzwUIdei2W3hrcTADlNWgRpILipvgHMhTkch304XKeE7N/6wJBD4uPTLboAPrvSmFqT23Qm9KXI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6979.namprd10.prod.outlook.com (2603:10b6:806:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Mon, 19 Aug
 2024 13:31:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 13:31:35 +0000
Date: Mon, 19 Aug 2024 09:31:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: andrii.polianytsia@globallogic.com
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, zach.malinowski@garmin.com,
        artem.dombrovskyi@globallogic.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/exfat: add NFS export support
Message-ID: <ZsNJNJE/bIWqsXl1@tissot.1015granger.net>
References: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819121528.70149-1-andrii.polianytsia@globallogic.com>
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a611f9-3875-4348-9114-08dcc0533ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCk6+L8fgG8r7ac9bV+og2JdN7SiL1e6xGryyCLyO484YVP7WJLS3DzXgQNC?=
 =?us-ascii?Q?l7g6nSphLtyXP5WtJ73A7+/56FYWYNWKFL/KcrBmMSCJkmmbWug9SFWzVASD?=
 =?us-ascii?Q?26AdBt0LafYDbCGP4Z5tYb0dg+sYTckpTG3otfWvI9qyVjdFlEIsxFdZcDh7?=
 =?us-ascii?Q?ZJV92Tx8azmk/yLD1O3ZAGqD4Dw5MLSEIiHGCp50Dk0zOvJQfLiy/Mn6D2Tq?=
 =?us-ascii?Q?vUxhorYUEqPSLIYHiSyqK5LatfI3mgXG7QG/JsWadI437Ke5jKOK3d66ta81?=
 =?us-ascii?Q?mwEcsTyysXCw4j9QItoVupuEJslWxCwFT9u0f8SXITfMyjT+bHsCz5rtBvWq?=
 =?us-ascii?Q?k66nI+K+HWju0NulTfjBN19NO2GTsdgSj2L74V2h52yALv5OUQkVZIN+s0fv?=
 =?us-ascii?Q?FPm4/jB1IogE6gBfCASlOSnzenrah62NE8W1jYf1F0sXgYYvfyJbqTp/wKXY?=
 =?us-ascii?Q?N3s41TQgsuHPDtEzTo3RDSfLedyVIJ//YAww6jGDPNNJIPZXpxhFXJ4tNXE6?=
 =?us-ascii?Q?pjoMgi6Ggu9DCjJTjh8sSL8ZLCbzHx9IMI2eqXHLVzzUKfqHDCYPRsV/V9Gx?=
 =?us-ascii?Q?56Flpw6UeoHWr6UKdL53Tjhkga9LAaa7st0gDnKxREaoC+DD1R781YkRXoXZ?=
 =?us-ascii?Q?NjyNzh8DnY+ge6jzrbFgLtcInsM7+LTIY76pZ2RfoBceERvMJQlZseXaw5Q/?=
 =?us-ascii?Q?soXzdV1W4EaE+9E0uAJx8OaGKsYlXX9qNnfhGB1uaXTaBQwIGnjTkT9H9Jed?=
 =?us-ascii?Q?vMY1S/z9DVUpGty6R0b9Ob9wILcNoYjMQolweYeABFRY2lFmrU/FjTpg/Um3?=
 =?us-ascii?Q?eVhn44L12eNR/XsaVZmv+2RSDl76pKYGImN1ljP7KfNAbKPgyi8d9USH5tEw?=
 =?us-ascii?Q?OeOD8fKplMpDdVyHjSS+qMKJNMhnbKkL8gvH5ESb41Osy8Bqgqx49KZz1lXR?=
 =?us-ascii?Q?iplGlp1ySAH3hk6i1fQLTkPoCEypezh9rr876ileM0/XDX83CAEPVLbBcJrO?=
 =?us-ascii?Q?zaLD8P8CoeIgv/kUbuCTvS0KSpPD/Eb5sva1XZj31eLnQH+gTsTxT/oZZJoK?=
 =?us-ascii?Q?5seawqgeZrfp3Z2ML4SqhzR7pNE9nhzLRGhZlv2oNGd2yJzdx9oi8KbRFhcC?=
 =?us-ascii?Q?jONecqA//7HXgarV1ov19whJN7oyfPTjY+bAaMGzw+gRw9OjtX7IYoeHiCSx?=
 =?us-ascii?Q?fXL7BgpREbTv/EoD6fyjVu2R+Kzoeu4Lous8DKjn7ka5NmJuxMCERB6MvaZl?=
 =?us-ascii?Q?NaflpNmhSycAKyHrM/7aCc++qde/4omNp3YEqLrLfqStbOSUxIyCRgQjyRSA?=
 =?us-ascii?Q?tdE7qfD4Qq1TlZKk+8N5DhJSosGoOyEGQ10lyhh60CdW8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNPV8NpPL9WhWwAGRtesJRVxg66+HZIXQTKH8bZZHyD/PsNR7bZ8xTyfi4HI?=
 =?us-ascii?Q?oOPmUBqWnt9YyKnMKYgKLPaNIDGmYIfrM+5kvmkW9rXDbGbLI2dMC85DFQAz?=
 =?us-ascii?Q?RQAXKRj550Bpsf6/dXfCBkb/+MJlqsqmLaqZyDK37jsaaEefu6LzSsGiOxou?=
 =?us-ascii?Q?CIP/WLz0MGNF244aRDy8ncaM/UdwaZv23AGZ+rC3kD8QWm9V42UaP8JlN/WC?=
 =?us-ascii?Q?+libOkMvZBqAPEbkjyJK0GHVdgXPv0Cz85+6Ihpo9g1WFexnAVOu0Yr/jXH5?=
 =?us-ascii?Q?I1vhLNG2TVpUfZRY1LQhrpNjf6DoYUwJXEgWyNhwqgdHsdZu6qzyMTBzt/gx?=
 =?us-ascii?Q?CywexFJLK3Pi+LvDELoMfUGmmr7VZ/EV/EkoP1Rx2qKTTOhtPaQ7/hkVcz4p?=
 =?us-ascii?Q?XJeF64ust7SX27r95C0RiVX12jnH98h0qKwj/87b+7+dPVQ1/Zh9XEIJseFh?=
 =?us-ascii?Q?gAGNWQ5JPuU9bsJnv3XS9hFWnNeH5C6uvwJGxbuiKNLTtYbA0PHnwZu+39Np?=
 =?us-ascii?Q?gFD82gpOCj5Tn2to4odI/sc/ebSo+a/MHXIamMg1Ej1ts/BjsGRdIgHxqlHf?=
 =?us-ascii?Q?EvgpmpYtJoxLQEmKVBI3nNR+p5ox15senIz7mxSMGBkK0KlUMzpMIc3IvKAf?=
 =?us-ascii?Q?nX2A0l19AANAczZqrH9JD+sDcoamHNAfavZfgDHpWUHV+uRTewQR/bo1271S?=
 =?us-ascii?Q?HHWeP5GQYSPhvj5taXbr1Tlk/q0fodA2ZWmYA5hsUIAKW9EN79vhwRFSIbcb?=
 =?us-ascii?Q?fivrmjFQhJeqURW55HglDUkqq+nE1i0DvCJEXDX4fhRjuSJ5MvMAZxn8k0CI?=
 =?us-ascii?Q?7Y8e3QnMrIoFpcipTjP48Wfpdcr13Gil1SW/WVc2lZE9UqY+kBaaMiM46QOz?=
 =?us-ascii?Q?FXRYalCZ0T0d25Ap8ob5tVrLaohRLlbNkB+KWPaW868b0vOylmybCO7rbVwT?=
 =?us-ascii?Q?Ag9fRWFgDMc6alCjKRqu1Y3WBt6pGnvTusIAJMF38or2H+/szXTq+DcsCSnY?=
 =?us-ascii?Q?jxIFf76LtGQA+0pJfl6bg2R0npXbbTbBCWVyVlNqLpv3CnCgMEXsfBWzA0tO?=
 =?us-ascii?Q?O7xSTy2iqv1cwxWWZBx9eOjNs9a4fiR3DXzk0w9BaLkKqTEt+dSnJlJIQw1Q?=
 =?us-ascii?Q?j0aXD79CjV70QruqPGjBHB11ujUQFXyhgeJMyixPQkNM9V44alFX8j+EL57h?=
 =?us-ascii?Q?0p+homAYbDQ/QwCElQw4RywAb9w8olj4LfhOkxuqOePMEIUuhG6UMJLupHAI?=
 =?us-ascii?Q?3/RnNpKNkhtcBTvDO48HRdkh6ujMikGPJPOxC97R8MJEC1bfG8NzIeO/TTX8?=
 =?us-ascii?Q?1hEZLRTjaO0LPEpvhdE1BGbAZYiAmV3oJZ7iNYo7/nSojeqYcGj31/fH9gBl?=
 =?us-ascii?Q?8JLxBQDy25jK74fv8i8n6WpXBkyDSW0MJ3OAm6StXSyZJhnQEiIFUuluJgUE?=
 =?us-ascii?Q?G5b4gtEjH95bzfRTz06gVK8qPKWXFA0eKtgks4dHbzykbTWxTQE8aWZvDz6N?=
 =?us-ascii?Q?UWq5Qrbj5zIqSpN80FZaWfoaZEHFo5E6JueuI7nMtaJwLHuizKdPFWooH+Me?=
 =?us-ascii?Q?SRVsodayj1+P+Pslfo2qBQvSxZGdV4XrWQZz3OJoZBHcP9pGNVySqs2z9wW7?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vTJyb9HYZxzfwCV6Km6Gs/gCHisvF4iDGlj58Bq3lnBwNIrvqjVPqSOlvARU75sF1H8FHIHPzWqtDnic2g+WisbjdVWNiVcZx0zQI0l544V5U7l1n1Vg0Xof6TmNB44VN+GtpiY7OWIKo9K8SLObgKOirqCvEUx+KierV81t6dT5n1Tm4UQGXoQ0gS6rH3g1uspmrrKGG9wgkII5pFy1/D6kt+nue4w2zAhHdQZ59Ova+hlm8oKzEhsoG1urkGxJmhfZPRDoH/B0k/8NhtDnubBXknJ9pFQd4IegjlHqTcnqd/CZUBB4sejsoLQXJjEtH2hjVfMpCxhdwePj178FJ9wBYHPp67StcSSqOKLkx+heQ9A4VygfO9d7QWQ4CqlCCTJj7TQO21AjPYWDGWXtgQaeVcbBaFxa8R0Kb1CwG+MslknbRGlbGgEBTBy6d3WKctLGC3fYJ7Pj8DERWPlGDZdZxtjhQoo5l1zOu1FD3n/o2sEFtxyj4CHO0099+6cqcesKWHbiZEc1QzBRwWHy7YylnXE6GQRobp27YXMc5mF89j1jVnvrFdZYo4QXJlyk+1mlJFdUdnBRdjgo5HvkDPmt2Wu19wm83wmC704QbvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a611f9-3875-4348-9114-08dcc0533ed8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 13:31:35.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeD1An4ImQoapLD9Llxqb4qtLCdHzYaIbDYCFW74xjxK/DSscuBD/3G6jEoDTsMftpHLY4P/CX+b2gu1zz6dPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408190089
X-Proofpoint-ORIG-GUID: uxVewzDf2vKByrxoS5gb7DOrPjOgHXaB
X-Proofpoint-GUID: uxVewzDf2vKByrxoS5gb7DOrPjOgHXaB

[ ... adding linux-nfs@vger.kernel.org ]

On Mon, Aug 19, 2024 at 03:15:28PM +0300, andrii.polianytsia@globallogic.com wrote:
> Add NFS export support to the exFAT filesystem by implementing
> the necessary export operations in fs/exfat/super.c. Enable
> exFAT filesystems to be exported and accessed over NFS, enhancing
> their utility in networked environments.
> 
> Introduce the exfat_export_ops structure, which includes
> functions to handle file handles and inode lookups necessary for NFS
> operations.

My memory is dim, but I think the reason that exporting exfat isn't
supported already is because it's file handles aren't persistent.

NFS requires that file handles remain the same across server
restarts or umount/mount cycles of the exported file system.


> Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
> Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
> ---
>  fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 323ecebe6f0e..cb6dcafc3007 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -18,6 +18,7 @@
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
>  #include <linux/magic.h>
> +#include <linux/exportfs.h>
>  
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
>  	.show_options	= exfat_show_options,
>  };
>  
> +/**
> + * exfat_export_get_inode - Get inode for export operations
> + * @sb: Superblock pointer
> + * @ino: Inode number
> + * @generation: Generation number
> + *
> + * Returns pointer to inode or error pointer in case of an error.
> + */
> +static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
> +	u32 generation)
> +{
> +	struct inode *inode = NULL;
> +
> +	if (ino == 0)
> +		return ERR_PTR(-ESTALE);
> +
> +	inode = ilookup(sb, ino);
> +	if (inode && generation && inode->i_generation != generation) {
> +		iput(inode);
> +		return ERR_PTR(-ESTALE);
> +	}
> +
> +	return inode;
> +}
> +
> +/**
> + * exfat_fh_to_dentry - Convert file handle to dentry
> + * @sb: Superblock pointer
> + * @fid: File identifier
> + * @fh_len: Length of the file handle
> + * @fh_type: Type of the file handle
> + *
> + * Returns dentry corresponding to the file handle.
> + */
> +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
> +	struct fid *fid, int fh_len, int fh_type)
> +{
> +	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> +		exfat_export_get_inode);
> +}
> +
> +/**
> + * exfat_fh_to_parent - Convert file handle to parent dentry
> + * @sb: Superblock pointer
> + * @fid: File identifier
> + * @fh_len: Length of the file handle
> + * @fh_type: Type of the file handle
> + *
> + * Returns parent dentry corresponding to the file handle.
> + */
> +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
> +	struct fid *fid, int fh_len, int fh_type)
> +{
> +	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> +		exfat_export_get_inode);
> +}
> +
> +static const struct export_operations exfat_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
> +	.fh_to_dentry = exfat_fh_to_dentry,
> +	.fh_to_parent = exfat_fh_to_parent,
> +};
> +
>  enum {
>  	Opt_uid,
>  	Opt_gid,
> @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NODIRATIME;
>  	sb->s_magic = EXFAT_SUPER_MAGIC;
>  	sb->s_op = &exfat_sops;
> +	sb->s_export_op = &exfat_export_ops;
>  
>  	sb->s_time_gran = 10 * NSEC_PER_MSEC;
>  	sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
> -- 
> 2.25.1
> 
> 

-- 
Chuck Lever

