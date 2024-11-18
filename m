Return-Path: <linux-fsdevel+bounces-35145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084E9D19F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F1B21FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82B1E5718;
	Mon, 18 Nov 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSkBLy9A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R+g2sTu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF6197531
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731963521; cv=fail; b=Qlm4Yhw5R/7YN8mNZih3Q+CzMqyfi0O82dcBWd4Y4cZd0QrnVzFFzk/HNC9e1ljfp7TEnnSi7zqMij7gEjwjyxAuSFUjHPJC7ffr2pFwfk0oP0WXt3AbhS67FlVzJ8Fk+JrSHSb6cjzAWRKCXpVctD/Ddw1Tl31vyMjnzyk6jbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731963521; c=relaxed/simple;
	bh=czWS9m7ItO0GzPDhQUN+qwxicrdy4e0/7enQXVXrnvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X8eerqzFSAns4I+D37rci5jATZocwWRFkwTh9SUfjRaYh92mk4n2nlcvt1h+E13nFvASCYo9maK0szst62AJbTyNiSNrNfLEkIaTCdku1b2MO+/dw0T6zTRk1MaiyZnqx1C9fS6KpC54tM/dFyvTj97TYGmQWEWp7mMBIVat/XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSkBLy9A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R+g2sTu8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIKtfAQ009774;
	Mon, 18 Nov 2024 20:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pnZ3AP2MW9azKgBYDo
	+aZ7wT9DO82x58622qZkb45Tk=; b=kSkBLy9AFbeJG9VicYB35dfz5SvhuyDaW7
	0VbtHx/LejgCN8b2IW1IdRg8WBwDUzl6Rx04tavCoDooG2xhbptxwkPnXkJWVdqz
	R44S9jtHIaZu/RpcUBu4e72IFpZ+PIfc0mnDFlNqL6AHlZvASX1+fb5rmb6KmNI0
	m+s5oEy/NedQo11HtAHKH23+l7fBo64UQLhsi+idz1kVumkRJnZlw4zskoSYCYmU
	B4Ii0o/QCWceXpprtUvczMBsOIffn9PV5CVUJBegI2sAN+DXYiUjQSsPcB5zA/ml
	4uQ8ktqKE+254Mrks418qG+6nV2CsptFtiQVP2f0m/Ua9JxlSJ9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98kjhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:58:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIJpgUH023653;
	Mon, 18 Nov 2024 20:58:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu80hvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 20:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArOagQHKKulL6vySBsKecL3Dd9XJ+nqNEhsfVei5ChvierBNLGbIr4US/4cTjseEf3AB5mBlBFbM/RaljDvD0CQC987sbjFPn8sStsInoz7zAbHPN9+XOxQg77X4PuRshMf1Qs+JULqppsJA0UJUcRQSjJqrNTZ8EW+StXuiWo4Lr03DFC08nQbKyFxvhVp8i/6YpgzTYtdtQsb8gjO+iJyHzKACeWRdZCBipr0wFmiwGIEu6V4dwlT9xkxvhFgHZ3HUalIVbRridnbvK4Y+/4oUqZsjACFrWd553xt3+tha0ynBkaZ7whjPq8bsjS+vlROYILlu7OdfjB8QxebU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnZ3AP2MW9azKgBYDo+aZ7wT9DO82x58622qZkb45Tk=;
 b=Jl4tE3n9mbLyvv5qMC31RG+VPgpQcBwvG7vGJ6nJ/HyoEVHgpjiWKxuDnmNMlI2yppM5lrUwT1V6pIN3HPA1Np46lmEFXc7c5b6N4hSOdiq93+0SxZyUXwKfifOs5PWUo4zMtoL+Gh0sNyuuq+NSJ4VjLBgYtWQkqd9zbTRBR+YYieCqhuKswgxriDEWJJYUJGvU4tjjA7A79IT4R9SaxOOwNxg1lyEcBODcugshK8f/pWEOpagZfGXT7+GylpTCUWzY8aGzCLwTGCaP3L1cbIS/OWD6XQeG7zlOFbqH56+C+WI3Ik+9TTPgpkXJFO133aE8WbNAoINO3iA8yZtRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnZ3AP2MW9azKgBYDo+aZ7wT9DO82x58622qZkb45Tk=;
 b=R+g2sTu8zatWNPH6jnMQMhgJ/jEAds9xgUuh26BtlPxyFvqpCX2grHHL4z3McS2+QKUj1PNhXf17MrJsFAlY8Qpc+5K53OJlNCYMPTcaW7y7lVuNC1UcPSbkVXon/fCI3L9Vceu245hPOZqwb4Kg6ZeYHXY14zjqS4kHSvUIT3M=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5127.namprd10.prod.outlook.com (2603:10b6:408:124::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 20:58:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 20:58:12 +0000
Date: Mon, 18 Nov 2024 15:58:09 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Hugh Dickens <hughd@google.com>, yukuai3@huawei.com,
        yangerkun@huaweicloud.com
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Message-ID: <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
X-ClientProxiedBy: CH0PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:610:77::33) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1bfd78-1948-4bc1-50bf-08dd0813b6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GGoMbc6Ntdg2CKYb9OeCe8CkVP4yea/naRFmDHBiUUT15uAnEDVWgKwA+ifY?=
 =?us-ascii?Q?B/wk1cmE6RPXZGKqrQkSjPnFD7iEgObdsYKlONqZWMSQNBNsRValhVhBaM+w?=
 =?us-ascii?Q?gF5gqwotv3sWv6R9xgDZ0cxgOXiehUQ61fYZpSlbjJUQHPQgX9ZX9gLQ6eXv?=
 =?us-ascii?Q?nxfwQHGE0TKMHlqwaPQWFDSyaBFIJ/xJIENN66F2b1NYNklCFtagHMPq7EGl?=
 =?us-ascii?Q?PNJpoorbxoo+r0wqkoKFxggvmapOADodJimNKzBA9ncjC2oqySRmhj7Z4P+G?=
 =?us-ascii?Q?R5E3mn7HZybJR8pNgMJ2TSQ24XVMdJVVomvFJhPbL5IXLiRm66CjPexT1Ozb?=
 =?us-ascii?Q?pZWJ+YNz/RLz3scV0ri4Uc1+Mpb8QXVYaHxcxs7VZGSfq1zKG08ZsGKvRdma?=
 =?us-ascii?Q?SYW60ryRhCtb9kPYGkK9LsXn/Ck0VM1chuYD9pUchQkraiPigtgWuISGvBlc?=
 =?us-ascii?Q?EQ7qYgOkIm7xPSDVGIBJfoGbcTNBeyvCPTAN+0idB9PLHNoAWNYG+QwVVZod?=
 =?us-ascii?Q?CTAS5VqFTR3FkamqB28xHDhboEkp2UdkX8aLyEfZMRQaYehYzq9Ug58KGrv1?=
 =?us-ascii?Q?7GI3uUvhq9n1HKpOI6Cmk68mIR0wTp1BWT8nwpu+UyGdmfdWq1bzLJ2Y/NsU?=
 =?us-ascii?Q?hHy8top2b6fpNFpxZRQBAvk9GZWrKyH0GIMOGVRzwr/NsIykr26iiDKkPOMB?=
 =?us-ascii?Q?2hCC4XRCPtgzuInSFdWTDRUEGc/wwEnN45Dlm86cCupHOdvuhOYnVrWnPbwd?=
 =?us-ascii?Q?GtbkpiyqV84RWQngbEeuK5/h9sdbRZBZkBPM/WNh3J3T7c+DO8DWap6vekZn?=
 =?us-ascii?Q?xRT+4j8LFZ6SDDIGamnEuShOhMFAoys//d+R62LO878EwOOOCdFOvdtFHCEb?=
 =?us-ascii?Q?fN1nwMrJF/4Zk6xEDD3Ywvjf5TWuIKZdukMhlSNN3yoirAaAynuCSLXqMyNG?=
 =?us-ascii?Q?5APHilOs7Zo5aKN4OrJ8+EhEFcPxzc+8+YJkTRGjtHSQYm6mQ8LcNIp+CbT9?=
 =?us-ascii?Q?CxK03P/qSUCDalgTmhX0XZSzTVW/UfTA1aT1uIwz0DRMFAMKhkU+9oh8v086?=
 =?us-ascii?Q?Dpv/fVAuo4rL2QfZ9I/16kJhTsZtjF4EnP7jrUHdbNJf06p2p6SdxGhnxutm?=
 =?us-ascii?Q?IRBfIEqktnr7uEtVXc7NFMp+rsXBbJ/bn81pLYgyPQxNofnUYmYhKXd7Sqd1?=
 =?us-ascii?Q?fnOS2mZODW/INB1OymXmfiFSA8Ln+2sTXPal1FUmv0HGQdIXwXLTtAhnkpgt?=
 =?us-ascii?Q?s61IPIFbsYvRJn2Vum7YeoJ5GhPTDrGTwYDPEnwglVboF0BSmyZ2IzVX3He5?=
 =?us-ascii?Q?pcm3k01KSX661IcmgMhdWRJC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTWMMXQTc74Er2DjB+6iuk8lNfwHvomVad720Drb6vaGLCjdKzKPMXjPNw23?=
 =?us-ascii?Q?CKbRbOv4Hje8wpBAFqgMxjgRgffP7Zezu4FCpZZpxTx5AWouJwn8wGpjliOm?=
 =?us-ascii?Q?h2hXhqnMP0JLST5b3djm5NadPZGQ4kp5J2aWamAqxQqxNACHCg/+LqBcHa7F?=
 =?us-ascii?Q?a+JZ/quKSlk7IJdckkmh9HRPEj6N1DtV8AAWqXlOOhcTgfI7zNptQgwgDjIh?=
 =?us-ascii?Q?E1xxJIeIsYYH86lmPrX32scHoJusdxw4dji63vNNLHzMCTRP5KTqsNehFDsd?=
 =?us-ascii?Q?msqyRQ2tQZMAezGZzb6VOFMQuJ1DNq81KZtW5XAmNUSFSunYPdyjloy0GHj5?=
 =?us-ascii?Q?8Iy4pQ11PMgSXBbwZuX8dwQyUykzyKfWQsud1jw1mXaJ4wQb9aM3KS4fTr2R?=
 =?us-ascii?Q?yisrqwuaieDXJexbW4pw8dp6h77hDwRFaTKovVFfRJtfpFqMnZ7QG2qxBe8x?=
 =?us-ascii?Q?/5C/oJbqSWFLND3fY6Ka4vWQRJAfslVAldJU1MwG5rH/QPnmhpjcgJ/nK9ec?=
 =?us-ascii?Q?S0qzJBgk8ZvPteRkMd4sQR6qUY96qT1vg8i+v1ETVWF93Yz7RsN0Cy4mOXN9?=
 =?us-ascii?Q?Y6b/ZgAt3h8SJPlSuYwl8bL5BU2ScS1BfHfEUSPX/aA3P3i73DtpAQQmBvSf?=
 =?us-ascii?Q?os4pi7u3B3Vt275kJxSZ6R4EpTZVWl5JzDO+UYP9wFsZDSEdNS+oyoHqCUpZ?=
 =?us-ascii?Q?uke/qxeji/IcY1E+RvSz6UZSIo6I8abyxQU10FOyYu9c8rEK1rCvyiLDmCio?=
 =?us-ascii?Q?9VND+tJrG7auKtow/SJdRXYuIA+HK8L+qk7iLnrf/hUn/ZrM8zf/9BUO+m2t?=
 =?us-ascii?Q?Uo/wq82zG1Re9/bNdBMvFLNRm4aQ2KcDPUPFva4kGohm6KUfqEvlLZNPvd8d?=
 =?us-ascii?Q?wQacQ8KjbUZc5iQXk/P+XtScX94y+GixvOKZT+Y9CqGkjW1hK1xHAAbSiWiV?=
 =?us-ascii?Q?Q041D2u1ent61zA1+1SZfIXG//j53UjdEBwGCGi4EkVW8a/6vbi3vlSBZhvQ?=
 =?us-ascii?Q?6X//N00cpjyF5E7lqZgcjLQcN7214yw/4xupT6mPDThBnJYaTFkoYNZnXzJ6?=
 =?us-ascii?Q?di32AtinqlCiS9Y+/uQ+wGrC39cW+QrpmQFUyJh3rqx4DVNodhiCu9M8klk+?=
 =?us-ascii?Q?McmWB7xTaww+STs6i5E0UhHo4SbwfBoQ0klwBdw0dcilxxO8fVXEEd4ZAVZa?=
 =?us-ascii?Q?LxtGin1IYU1U2hRNiTtvDIW4ETswHL7UOiSdL1TLaEMp+fSkFx7H82vwUUhh?=
 =?us-ascii?Q?p0iaQ5bJdjXwoRTxw2oYLqHr6+6usY6KJpXhFcZEQHuTRLDH9hLIwGu7KSbx?=
 =?us-ascii?Q?1P41MVD4Al4FupVvhYPHkzK2r9iu6I0rB81dxSFtRhPgq/5jfgICRIVL8bQg?=
 =?us-ascii?Q?ermUBkANy+ycf2ikJEm61gBTRuRyUR81PeXRCP3hW+qKq3lZlSL7xP+fsLMH?=
 =?us-ascii?Q?zr5oJkF4oekTweoxE98NWVaSAF5oOfTDn7DC1rgW9Kq8ADphZPVsB6GbsAPs?=
 =?us-ascii?Q?nCU0AtGlHEwD3Ky2KFQwTytujUfJXuRknw7XPETVj9k4n9jGy/tM1MxN5gRf?=
 =?us-ascii?Q?oTAtIB+hEZMavO+K5tBDT4MD1HGFdhxI/Uk3ArDT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TG0muPz34FM6oH0hgOB2klEjzHoDUnnoF4fUN0NC+1KCAe27l0MY7E0FcpTh/UdGTNVRHonveZI0hXBhpuW/tucZoaW6PqMEMAprMIsU6Xs53IRjO+tvm4bAdufU3UAPVtsEcuosw9OkA3IBu/phH0ZPD2z7r90BOkwQBgdDIgtiLTBRLER0DqMDJt0X+cnKKJAjX5z0gY+R7vRbrQUfsReVjrqROOnY0QBBHVrNim2uZTifdWYaaySaRP9KQt2NsCFb4xKHpU1trB0fNCujRjGSvpV1q0CJHgm/gGhsaIJ3tAKgqD9s8ID+ntE7c28i1+4FliYdCBFWIPP+9oyFiddfnR5BLsXV9gqY4/+TN3wLHyJvYhRIfiX89NBApQCl9L9FL/KhwbCThrFVuUoIOz6stSkzZYzsnMlKtT/yR6KgBf8ovo8eHs0p7W0nijuarAm4vGdTNXdGYFKlEHL+WjjHvyExPoADVVc1iGZ3gRrPs4vZWaLxY21P0mHyppMwbA0TfD2our4M6DqT0/wl5bLphOqHohhhUSYKXTqNtZE7GfEOteMcgHUY4iRX0XhjUySqCO2UdxxobdMUUn9+7Sj+OjhNlNR7Z75M2auNtVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1bfd78-1948-4bc1-50bf-08dd0813b6fb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:58:12.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdPV2J/swFyjDOGDT3z6Q57jAC40jASD2QiyerFg8Foub240pf1c0rkr8eR+f9RyGE0ZVEkCCsEy78th39y0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180171
X-Proofpoint-ORIG-GUID: uh2UBnHxIjOnDkdKy9Aru_BGa-tA5f-C
X-Proofpoint-GUID: uh2UBnHxIjOnDkdKy9Aru_BGa-tA5f-C

On Mon, Nov 18, 2024 at 03:00:56PM -0500, Jeff Layton wrote:
> On Sun, 2024-11-17 at 16:32 -0500, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > The fix in commit 64a7ce76fb90 ("libfs: fix infinite directory reads
> > for offset dir") introduced a fence in offset_iterate_dir() to stop
> > the loop from returning child entries created after the directory
> > was opened. This comparison relies on the strong ordering of
> > DIR_OFFSET_MIN <= largest child offset <= next_offset to terminate
> > the directory iteration.
> > 
> > However, because simple_offset_add() uses mtree_alloc_cyclic() to
> > select each next new directory offset, ctx->next_offset is not
> > always the highest unused offset. Once mtree_alloc_cyclic() allows
> > a new offset value to wrap, ctx->next_offset will be set to a value
> > less than the actual largest child offset.
> > 
> > The result is that readdir(3) no longer shows any entries in the
> > directory because their offsets are above ctx->next_offset, which is
> > now a small value. This situation is persistent, and the directory
> > cannot be removed unless all current children are already known and
> > can be explicitly removed by name first.
> > 
> > In the current Maple tree implementation, there is no practical way
> > that 63-bit offset values can ever wrap, so this issue is cleverly
> > avoided. But the ordering dependency is not documented via comments
> > or code, making the mechanism somewhat brittle. And it makes the
> > continued use of mtree_alloc_cyclic() somewhat confusing.
> > 
> > Further, if commit 64a7ce76fb90 ("libfs: fix infinite directory
> > reads for offset dir") were to be backported to a kernel that still
> > uses xarray to manage simple directory offsets, the directory offset
> > value range is limited to 32-bits, which is small enough to allow a
> > wrap after a few weeks of constant creation of entries in one
> > directory.
> > 
> > Therefore, replace the use of ctx->next_offset for fencing new
> > children from appearing in readdir results.
> > 
> > A jiffies timestamp marks the end of each opendir epoch. Entries
> > created after this timestamp will not be visible to the file
> > descriptor. I chose jiffies so that the dentry->d_time field can be
> > re-used for storing the entry creation time.
> > 
> > The new mechanism has its own corner cases. For instance, I think
> > if jiffies wraps twice while a directory is open, some children
> > might become invisible. On 32-bit systems, the jiffies value wraps
> > every 49 days. Double-wrapping is not a risk on systems with 64-bit
> > jiffies. Unlike with the next_offset-based mechanism, re-opening the
> > directory will make invisible children re-appear.
> > 
> > Reported-by: Yu Kuai <yukuai3@huawei.com>
> > Closes: https://lore.kernel.org/stable/20241111005242.34654-1-cel@kernel.org/T/#m1c448e5bd4aae3632a09468affcfe1d1594c6a59
> > Fixes: 64a7ce76fb90 ("libfs: fix infinite directory reads for offset dir")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/libfs.c | 36 +++++++++++++++++-------------------
> >  1 file changed, 17 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index bf67954b525b..862a603fd454 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -294,6 +294,7 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
> >  		return ret;
> >  
> >  	offset_set(dentry, offset);
> > +	WRITE_ONCE(dentry->d_time, jiffies);
> >  	return 0;
> >  }
> >  
> > @@ -454,9 +455,7 @@ void simple_offset_destroy(struct offset_ctx *octx)
> >  
> >  static int offset_dir_open(struct inode *inode, struct file *file)
> >  {
> > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > -
> > -	file->private_data = (void *)ctx->next_offset;
> > +	file->private_data = (void *)jiffies;
> >  	return 0;
> >  }
> >  
> > @@ -473,9 +472,6 @@ static int offset_dir_open(struct inode *inode, struct file *file)
> >   */
> >  static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> >  {
> > -	struct inode *inode = file->f_inode;
> > -	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> > -
> >  	switch (whence) {
> >  	case SEEK_CUR:
> >  		offset += file->f_pos;
> > @@ -490,7 +486,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
> >  
> >  	/* In this case, ->private_data is protected by f_pos_lock */
> >  	if (!offset)
> > -		file->private_data = (void *)ctx->next_offset;
> > +		/* Make newer child entries visible */
> > +		file->private_data = (void *)jiffies;
> >  	return vfs_setpos(file, offset, LONG_MAX);
> >  }
> >  
> > @@ -521,7 +518,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
> >  			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
> >  }
> >  
> > -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
> > +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx,
> > +			       unsigned long fence)
> >  {
> >  	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
> >  	struct dentry *dentry;
> > @@ -531,14 +529,15 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> >  		if (!dentry)
> >  			return;
> >  
> > -		if (dentry2offset(dentry) >= last_index) {
> > -			dput(dentry);
> > -			return;
> > -		}
> > -
> > -		if (!offset_dir_emit(ctx, dentry)) {
> > -			dput(dentry);
> > -			return;
> > +		/*
> > +		 * Output only child entries created during or before
> > +		 * the current opendir epoch.
> > +		 */
> > +		if (time_before_eq(dentry->d_time, fence)) {
> > +			if (!offset_dir_emit(ctx, dentry)) {
> > +				dput(dentry);
> > +				return;
> > +			}
> >  		}
> >  
> >  		ctx->pos = dentry2offset(dentry) + 1;
> > @@ -569,15 +568,14 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, lon
> >   */
> >  static int offset_readdir(struct file *file, struct dir_context *ctx)
> >  {
> > +	unsigned long fence = (unsigned long)file->private_data;
> >  	struct dentry *dir = file->f_path.dentry;
> > -	long last_index = (long)file->private_data;
> >  
> >  	lockdep_assert_held(&d_inode(dir)->i_rwsem);
> >  
> >  	if (!dir_emit_dots(file, ctx))
> >  		return 0;
> > -
> > -	offset_iterate_dir(d_inode(dir), ctx, last_index);
> > +	offset_iterate_dir(d_inode(dir), ctx, fence);
> >  	return 0;
> >  }
> >  
> 
> Using timestamps instead of directory ordering does seem less brittle,
> and the choice to use jiffies makes sense given that d_time is also an
> unsigned long.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Precisely. The goal was to re-use as much code as possible to avoid
perturbing the current size of "struct dentry".

That said, I'm not overjoyed with using jiffies, given it has
similar wrapping issues as ctx->next_offset on 32-bit systems. The
consequences of an offset value wrap are less severe, though, since
that can no longer make children entries disappear permanently.

I've been trying to imagine a solution that does not depend on the
range of an integer value and has solidly deterministic behavior in
the face of multiple child entry creations during one timer tick.

We could partially re-use the legacy cursor/list mechanism.

* When a child entry is created, it is added at the end of the
  parent's d_children list.
* When a child entry is unlinked, it is removed from the parent's
  d_children list.

This includes creation and removal of entries due to a rename.


* When a directory is opened, mark the current end of the d_children
  list with a cursor dentry. New entries would then be added to this
  directory following this cursor dentry in the directory's
  d_children list.
* When a directory is closed, its cursor dentry is removed from the
  d_children list and freed.

Each cursor dentry would need to refer to an opendir instance
(using, say, a pointer to the "struct file" for that open) so that
multiple cursors in the same directory can reside in its d_chilren
list and won't interfere with each other. Re-use the cursor dentry's
d_fsdata field for that.


* offset_readdir gets its starting entry using the mtree/xarray to
  map ctx->pos to a dentry.
* offset_readdir continues iterating by following the .next pointer
  in the current dentry's d_child field.
* offset_readdir returns EOD when it hits the cursor dentry matching
  this opendir instance.


I think all of these operations could be O(1), but it might require
some additional locking.

-- 
Chuck Lever

