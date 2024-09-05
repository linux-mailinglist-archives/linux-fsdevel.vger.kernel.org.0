Return-Path: <linux-fsdevel+bounces-28759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C8196DEBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C102842AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE619DF77;
	Thu,  5 Sep 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0o7Q19m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F/mo7ReF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CDB101DE;
	Thu,  5 Sep 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551208; cv=fail; b=V9eDAUQBZj9/7hTKJUWbQkioVR0xhARQFY8ep5pgpw+hBERWG751dfG9equ5/WEIwgBEFMjeRnVi22+bqRVqgrXunm4nusFrigQudVzYKSc287BMiA0h+BeyB/frx19T8cjm7x0FDlmfFIc3l4rRZBtX0Mc0Zp2w7wjZSSItGsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551208; c=relaxed/simple;
	bh=aaP7Q3XRQTJ16q2h7UpcgtRzxZcr5ylu/oo0rGtyB04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ewgx1PQjAEAT4MmDpgWM6uGQSqgI5+UTB//4vLKLfeCSYjCA3gKfPUZFjKz+B0IQir7fxO+FjLtuuRZAqOvOTrieW8HT3hXBDJ0BRePUAtaMAvHv1HiqZ74P0QpqUH2I8HJhaTHyxWMCHQ/20Q+nz3/PE3GDv4CZK/2SfHL5UPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0o7Q19m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F/mo7ReF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485EtWkf027280;
	Thu, 5 Sep 2024 15:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iCgOpP6/dDjNapV
	XUiCJrrjymBkWDkd34TChSXOgfnw=; b=T0o7Q19m2BVDZd5U5fjlYN9KlH+pbTW
	FC5GtShe1ZF7iSVB55Hc6imibAIgxN9SOWgxlRLwy9se4oGR7MVb0T1Ka3jM9qL5
	62xf4b2BlMGFghY12R+pwz/0MqJOMBE61Cz8ltAj7OCEVbp1zor8yuRcGnImKaFO
	SOQ7+UrY8mCEQ6/h76chuX+W8+ZHKRC4e7qr2NIJIxTDR/pNrgOB1BBGpC9dLY3f
	BgQRKnhn166iTj/ijYWNP5XsS2QgSqqafhRoxfZFHqHcRKbw/eiO1htk63hH+Nf9
	N++n4QODVn3VuYRRyVWbvkHE2JeOdHHbjLLmQ+JfVLJ9b2Rpgxvvuhw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dw51xbr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:46:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485FJS0W023678;
	Thu, 5 Sep 2024 15:46:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmb4q4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue8MHqs32HcuBUEG1hsbgB3MYgEpTo0RgFOzhd23DLoJ01F0nC/JOrJCZlKQmYvOk55F9e0l6Htaabsa99fyUI98EVGYbKAsh1FI2FM0WPriQh1JLzBKX7h+pgxb28I1detIBwN1MZiPbA6X/P778qYFgiG0azNgiXCItbXUMApz3QRf9FxBe7li0hSTwJwS/uWLJ3TFwn7BpC/urQG+D5X4rbd9TpDmTwd1zNElbbqrQdEkeIxw3GOyILEG2Bj+48ElwMflGeWpD6EFhUvSNOS9AcY+pAGiCx+s5Tn/aSBi+ehW+8WO4Bm3GezvK3HozsvKRsz0MZILcFvK/P5FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCgOpP6/dDjNapVXUiCJrrjymBkWDkd34TChSXOgfnw=;
 b=Ovu1k/QtGkpUJ5cuL+Nm1UzY3ZSzF/IvVxT40q9U72m1EjYXT5n/Vlf7yr4wQGI7PKYoVvMSYUrBJ2oQlGXKsNcbzaaFq4K3ttA4F/eJeN8zz1nOjyOWZBoyrxd8cDfCCnbI5Oqbb3tc9xCRl+08FwdONSdMlWRVvEQol5ucSQM/pFSWDmR1XALzlVS0uElPWLc9/pKJwOKVRql24BNilfmHokDzJc0qIwYYY3sxyFh5jndDzg4dcY4UelbrkPDGNiDxTbRDmaCIB/iBms5iEg+POCR/BezGCt+0XNOCj7iMJ4jO9tYY0neBPUBxJOXfdAs3f99mqNBLh2EtTX6DNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCgOpP6/dDjNapVXUiCJrrjymBkWDkd34TChSXOgfnw=;
 b=F/mo7ReFvU+eu290l8IxhsOl0Hd9pKoOzqRAHjHytrnrXP2Tql3w5yMayDKmrSH/DScOeE30cz2JJN/kOgpFm/buKmnDj08r2HmB5HePxzQTZdeCDVw3xL/XB8lZ9310GZkXlfgRqICdHo0h9Gtk1s4IVvX3iZQv6YmKD6sbDB4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Thu, 5 Sep
 2024 15:46:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 15:46:28 +0000
Date: Thu, 5 Sep 2024 11:46:25 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
Message-ID: <ZtnSUWai8kB8gZIO@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
X-ClientProxiedBy: CH2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:610:53::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efa7337-f24f-4fbd-3039-08dccdc1e7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63Rp8xa6nrH64TbF3xvTcSyCdn4PEftHn7T4eHIebTkbgtMcY8OEDo+OjX9f?=
 =?us-ascii?Q?ZtBhYiQf5ZZzrkANgVSuuhjDZ8pA2k2rcn3TOCeTDGAwNLHxDNrLKCyuaTBd?=
 =?us-ascii?Q?C0s9g6QcbEi+XALmzg3hEr4gffFZyneUD7jlNaMHIuxshZy1gzpD5Lyp3yJg?=
 =?us-ascii?Q?JLbfR3lQaydQaECy0hG+YrARHr8yXIQXSedYRO1Nag77aORwM1Nu86+bJGa+?=
 =?us-ascii?Q?pIEGG/MJcSa69CTLZSlxeA4MN79QOprqpomYcOu24DtG8ML5hnZVDvStuVLk?=
 =?us-ascii?Q?QEPDK62BwPjKsQEgOJ9gr7EhA2hs78tSRAbe/oUJNSHP2ZjzVlKnOZvyH6Lk?=
 =?us-ascii?Q?R3uOV4ehQfQgIknibbxoslLBWwCmjAga1/zr4XSPU040mw5QAXIKEYSugKJ2?=
 =?us-ascii?Q?IxljM1rMWxQin6uvmXCih8XQgtVPDeRqHwjsIya6HYJ7lx2LfNSYVkB7w0J9?=
 =?us-ascii?Q?EOnyV+RMGh2k/wFRrGwa461+R3zZ0DEZTY/yJnN+oSOdbxK8lAFK6aHYFHwz?=
 =?us-ascii?Q?ylFNljAcrEYx4XbgJC+EC1U+IFA81PU2aNrTyJsodvdC98SQ0LOSfuIW7OYn?=
 =?us-ascii?Q?6rX7C+ZsxfdH3wNHei8B4xsr93Ft1dAoEyN3otFFeC38cNdYTzr2gWU9POB/?=
 =?us-ascii?Q?MbgWMuWrOxR6VAACIYsu5U3wnkZRDwHbUBprzLIXq7znV6Vh15NDtEjivUv/?=
 =?us-ascii?Q?cFe0uq3xSCy+s6nYkRYSyQdcXcx6uhEitthAWDOU2bjpZvP2Sh6CJ+Y2OHWH?=
 =?us-ascii?Q?Cf5CYDujrWmDXaWm0VYd4TN/M6MiOghaJvQV2D+zyDrPeM3qetoRWM+ZtaPq?=
 =?us-ascii?Q?Zj2NdNlJupfP5YsjTTuJGRknj8KcvMwMj99e35UrnueSOGYSmU91glGLDAyw?=
 =?us-ascii?Q?m28AlXxpqJA0OkKKLJz1HzK0n1ZL3nbEkagP9Q84E0Jqb4PeyYU9kNSAKMkg?=
 =?us-ascii?Q?piKFtic4MP3jiCZoUnF4uQWao/YffpO8J0I3jufQ5d9MpHCLOEJVYu5PhUlD?=
 =?us-ascii?Q?e5FjAYPchsnYCa9LaRNIo6pPwUV11W7bGlEdlhbm1CJ/eFGmo5ZcxmqQT6PR?=
 =?us-ascii?Q?oQqP8EGHH12ZniRPNLO2SqMc4lD0w9u4lhrxb12UN1s+6JIRxCvMxMHeoMGP?=
 =?us-ascii?Q?qkhHQ1+GqwJi9tig0ZM6RQ/Sbxluvb3RD0yx2tEdzZYCSW0z7NTAPR/D/dcV?=
 =?us-ascii?Q?909/6aUX6oRDhzyIa2KwZ5VCY32Zgmgs7fOGIBe4LkNYMgQWz3dy8LCurksR?=
 =?us-ascii?Q?1j3ll75DDtXE+RX7EdakyxMChS5rPT4c6Ld5aFnwBJ77W+IZsSmaR+RKAV+r?=
 =?us-ascii?Q?/3qR1MMcCy22FmIjuxiRWDTIn39FQpX9rs6/yHcftSWvNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TP9C23INqwphDbzlfVwOnhkM88bpgRMnfBN13K7Fa4vAEiXDafZM6VAeMZhK?=
 =?us-ascii?Q?vhs6EFfc9wJtF/sVSs8wkm8eqvOnSBfcP8fdPTJvsFXNNFfIIDeS/fJbq0zl?=
 =?us-ascii?Q?5m1wAcJZ7RKJPl3NPNUTFJotGSLEivePesq6SHL0tjSKrlHh0NCzDsMYs6/S?=
 =?us-ascii?Q?9tgassl8V1OySiBPfkAAy4WwiEeAKNgJlk4RRtBtkXN0VYXjxJPt5AqRy1CK?=
 =?us-ascii?Q?rT2vWv8xFx64PM/78eDEcArBh4E1VF7Hmkso1u6Q5Wy0E4Cqi8e0IguzB5UH?=
 =?us-ascii?Q?1g+Zy71wkdEKxBlijfjPQBLO1hNb39s3D8Z/rSThdw5NMUJrya+c0bZwMj7X?=
 =?us-ascii?Q?HmAH0Z6eMIOI1BDRgCOlXlFufrwHbkEtVr0bdhdMrXGN52iTblVEJc2EIliN?=
 =?us-ascii?Q?dWa8MvOd8pmi49+/fuq4vzLZDMHXjlu5W+xjhqxlakUG1LuX9bDHYi5Yl08g?=
 =?us-ascii?Q?UcxMOK5o0qyRGOgNGUbFh/iZ3cAhYWylN+dx8u27RlkAe/KjwdWb8BSHjWlB?=
 =?us-ascii?Q?zEHxFP6zuNEIio64dMPVR1llCZnNR9NEoI9X1gT9zyy4jAdshdxJ0lVtF7Mc?=
 =?us-ascii?Q?PXysAzwAV3MOR9PxKL7HDV6H6Q6wqL8JATn3/4ogXU3rIjLo5C0bP0JYd3Gy?=
 =?us-ascii?Q?k6F/yUUjrtYf7LHsyF9BkndnHwlj0ro29XUBQnpk1smRlJKG0yy5JYJvpput?=
 =?us-ascii?Q?3rr47BGVVS/6Z6qug3Jsw3QOfg5KrTxHipJDpkKZ4snsLEn2jPVx4eBnJRNl?=
 =?us-ascii?Q?sisHk6EOFZBEA8l6xNbGJnfMT6XgfRxchwaUyzS2JKjhH51GvRvTwGAuhi5Q?=
 =?us-ascii?Q?Ad2O10l7JREg8kvez9rKvUhpgwdgdSMX/hqBRlxHn9TrMUD+xUbSvxbIkGRY?=
 =?us-ascii?Q?8tTak2sHOhkXJf7vWWYvm8+3CZIwT9f8wLoGR2OQ/k+rr4GLP4qxHN0D6iM1?=
 =?us-ascii?Q?Ofgg7m6FBuVQgip8YBpUBJr1rYXaxWZM57xMozOOmxffhB3BAWxTPgVfRJvk?=
 =?us-ascii?Q?3jjJ+pj+hYgyScNFFaa3TY7dldqrrH5DivXyVD/rMJT8VdDFX0zLuiwMeD73?=
 =?us-ascii?Q?7SDZ7w0C9obQTT0yoIcyItdw/6QmLMVtJPZCWWVpGaeFBuCNELoa05DG4mji?=
 =?us-ascii?Q?KsvprDA4FHoTgEWBPk9xcC16zK4UAW7687u0+b2sTRi+tydBTq+SUKVk7/iK?=
 =?us-ascii?Q?MZOGVOb6EgL0mQLFkUJ0lgtBdUmjRjDyNKxD4l6JIw7CpLkcK6iWPDmWtkkv?=
 =?us-ascii?Q?DGRtzB/iwGxTrKsawigL9AkDBLf1vTH1iTK0hzkv6LD+7OcVSMg45x06q7nc?=
 =?us-ascii?Q?92XxsDVrGOQUDzqjktn7dnfInvRM15hBgnFu0ctPZYQMnEE9/XmNi9DYhGQl?=
 =?us-ascii?Q?yYnMmNumWEJEw4CGGjDpI+avwssSyugp0qrGpWB/8EBzH8ucCAeqW3RxHSyv?=
 =?us-ascii?Q?ixKQkrY9Ly2Sj5vzOmcM/Mtvlo5J9unPy9mECrb0gkStOzuyksoNErUHsTiz?=
 =?us-ascii?Q?qF4q6f5yGcdk+bLbgpmZ13tMfK8OUVtaIxLRz9dOsiveeDbo+RZ3Xya3fJZr?=
 =?us-ascii?Q?MpdAmCvUFarMmf+DQGSFLVIHOwDAOJTbnjToFjEq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W0b+akQNhCAyNXP4wxEuBMppkNJM1fbmtdreDb3MNXzpMZnCgf+IDqZVFRnyCt8HGfUl9QoCOezvm5FB5v4nSdK5pHKojF9mu+ayNrxkGqEzPuSBwJesIYrP3E487Wo+aQ4nzKanBk+6vPKWb/7ElVJmN82VCf36jW3e/ggyKmWpEcx3z5E0VK5mN3TTWAYSruLbSCVR0wucVN/dq4TGZ1x24kSweeigGhXW6bfR0lHn0ARAXYWPK/EQ+osCJLjPirarcapyG2hIVlmZmWO5tfwCu2xX28tPe95+MGH2Gg9mjSwYz/pPmEdRu74eOJrRybbmOo4LBF4jDY1tP50f8ejPTzJP/dQv02gLKapssS+4xJ+bBtWwvo3SviN8Q8e1ztqt4Eb2YQXJQ18E8lLqDijvP4XTwGi6WtAq+I5kHNduqk5uRbI53Y3EFFWUmrUbiEkNzOcNMwQmuBEzYJF+6aVBTbLQqeY5Q8mQFRd4X8EL9b6/w1dYOO+bHTkXvSS4hwRpTk58uhp0nV4KdmOru75Es9Djjpuu7ksr0IZMVuBARYV1E/XgvNLWh5FOWmyCIkPnAJma5Wro3pDm8fNh79BcW8c34bc5eyplOukiqJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efa7337-f24f-4fbd-3039-08dccdc1e7ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:46:28.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvgZ3uyf0zsyA5Fg+XtS2ThPzXn8P0V4mHFP/aOFSh2IOoGbSGhBJqRycHIicb/RKMcTRonJSjS78NuS9wMqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050116
X-Proofpoint-ORIG-GUID: 3_hNOn1eDtnM3ACRkqvv4_GFRL8EeKP7
X-Proofpoint-GUID: 3_hNOn1eDtnM3ACRkqvv4_GFRL8EeKP7

On Thu, Sep 05, 2024 at 08:41:45AM -0400, Jeff Layton wrote:
> At this point in compound processing, currentfh refers to the parent of
> the file, not the file itself. Get the correct dentry from the delegation
> stateid instead.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Subject says "fixes ..." so IMO a Fixes: tag is warranted.
Suggestions welcome.


> ---
>  fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index df69dc6af467..db90677fc016 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5914,6 +5914,26 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
>  	}
>  }
>  
> +static bool
> +nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
> +		     struct kstat *stat)
> +{
> +	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
> +	struct path path;
> +
> +	if (!nf)
> +		return false;
> +
> +	path.mnt = currentfh->fh_export->ex_path.mnt;
> +	path.dentry = file_dentry(nf->nf_file);
> +
> +	if (vfs_getattr(&path, stat,
> +			(STATX_INO | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> +			AT_STATX_SYNC_AS_STAT))
> +		return false;
> +	return true;
> +}
> +
>  /*
>   * The Linux NFS server does not offer write delegations to NFSv4.0
>   * clients in order to avoid conflicts between write delegations and
> @@ -5949,7 +5969,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	int cb_up;
>  	int status = 0;
>  	struct kstat stat;
> -	struct path path;
>  
>  	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>  	open->op_recall = false;
> @@ -5985,20 +6004,16 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>  
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> -		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
> -		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> -		path.mnt = currentfh->fh_export->ex_path.mnt;
> -		path.dentry = currentfh->fh_dentry;
> -		if (vfs_getattr(&path, &stat,
> -				(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> -				AT_STATX_SYNC_AS_STAT)) {
> +		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>  			nfs4_put_stid(&dp->dl_stid);
>  			destroy_delegation(dp);
>  			goto out_no_deleg;
>  		}
> +		open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
>  		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>  		dp->dl_cb_fattr.ncf_initial_cinfo =
>  			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> +		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
>  	} else {
>  		open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>  		trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

