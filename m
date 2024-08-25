Return-Path: <linux-fsdevel+bounces-27065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E895E424
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592871C20973
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA43158DD1;
	Sun, 25 Aug 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J33hSC3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ALiTAxfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609813D25E;
	Sun, 25 Aug 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724599137; cv=fail; b=uw4LDWFAtMUUtWr/k0qLEIO/rNX8YGhfFtrHAAF6eQ84DOiO5nU0bcSZS+pargbnn3jAn6sERzg1iTy3LjAnZdlOsA9GBG/pXAF0RsQ460SVv4DoD/cXNoWlevoCZDjfywdENw/IapLA9G1u1hBeDNmyTi8Xi/X6cJr3LGEszwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724599137; c=relaxed/simple;
	bh=KSjD8g6QCddLJJV7pgTtyvonMjWIhqMvrNGWqnotQvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=livuLZPXuRJgzxZqxRBtKPiaWmkU8VbwKg1+L5BfNx8Bbo/kRmjHlofOxVx//8XsV8miTOROTw7gr6dfZOr1/T7h2d+NC58g5RhIkCYOfrJiUG+X/CZKvpP6aUPiDoe21BzDOoJ0vWPd9kJZTtq8+gDUWVOK5GbcSsAt5vdZHYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J33hSC3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ALiTAxfR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P6oGiJ025076;
	Sun, 25 Aug 2024 15:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=g0jiR0gBb0rxZ4D
	zSRuWIzAlL4dQHtaITfh+2BBQQXQ=; b=J33hSC3AJ/p/PZGtFJt8ogVUcVs3FK1
	iUJt5kZtN09cdeKH2gOKZq94Rv5wTXzM/T032EaPfoOHs+EhP9fF+1HllkQkokHO
	PhN3v7xHj2F8KVsOvu9Goy54+VXzoanfKFMETlSi0SLd7iMeuv8Casvm615KYQ6x
	a0v9UMXRQu041MZgrnRi5NHbEYb9WIGa0obTNXGrHWcEaRL8uKEPg8Okvd8K0rp4
	Q28w5tciRIfwGArK4mvclHLNsbU/eE9fg55R3Z2c7m35NNYtnzmJ+NXqhYsXznNV
	4gBAb0mCvo1nUSOOqkrehdRJvCWO9wZhxpriPz1qefyEBJqxEM/EDEw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6hkty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:18:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PEHmBS019475;
	Sun, 25 Aug 2024 15:18:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41868h8wge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKvXEPo+ctjmgpxrIzUXQLobcse66qfDH/cPqwXyodl2PkMMxo6lJ+C++k0dOlnMhyWGhEkAysL6V0oBg3k5IBFH9jO7My2Zxffll+dEkvTEe7V+rErtVl/SrKZb78Oafqw9XK1vHLTH0A66TthQMLfRFJkMTQd3Ht5fRyVMo23ioA43dN1Rmgb0dCkETUwgQ2W7Z8Ue48yJ3PJ/ROV2mRWZSzJ5J903BMt3tM6XhJmJSX/VD/IBHViI3DxwKxvIcqGu3SK83HF7KUgX0d4aSr6cgvOwRG/X54AY9w82RDIs5Pn1CHwvrTkSb4ZQdzqjc6NcFICcFgykC4aCOHwdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0jiR0gBb0rxZ4DzSRuWIzAlL4dQHtaITfh+2BBQQXQ=;
 b=b6mc4x6z6mg4oGuDKGUCU1+N0K0/6T5R9s2giIZOxn2lxxvPQXhyLFKg0Q5BH5+e4yM669EASO2JqDXtxjLmfDzdabOs4Su8UcyhGEYK68jRF2ezGL5QqrIypJNZw5xNcfIWGjJK51z9AaD8pv14PG1DFvrk63ztZKN7Wyqxh23s+V8/CKsvpSHX/A/MOISntmTL0OQry6Y+u2houbB5lyysfCNI+d1ILu3TIldhSxU2ki6hWmK6826D7AYob2kPs8+I2eDbkRhOBpcIlQ4fG9ipn/9VNtF1W36lMGZaH1vsRoclIQGCsUy/+AcIaWMbSz8TysQzOZI2BEeScbVo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0jiR0gBb0rxZ4DzSRuWIzAlL4dQHtaITfh+2BBQQXQ=;
 b=ALiTAxfRO2mM+G7V8pe7fGhX4yF2XTTDa1nXLUu2gHN9m6L3EcqDAZ+mJNCVrKiEe5hPoDBuGFw5EFPJ+uFdnn0ckEUnNOKWcOJY6DlbS6CI0734v4/8zw7JMfNTcA0PA26UeQdTOWE0MlaKYdmYMPe4tqJJy/a7jakl2j63nsA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5646.namprd10.prod.outlook.com (2603:10b6:a03:3d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 15:18:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:18:40 +0000
Date: Sun, 25 Aug 2024 11:18:37 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 05/19] nfsd: add nfsd_file_acquire_local()
Message-ID: <ZstLTWVcMjnn+LQz@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-6-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181423.20458-6-snitzer@kernel.org>
X-ClientProxiedBy: CH5P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 547a1383-b2b1-4a93-76d1-08dcc519332f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YjOoDd/hj82+pvfAmSVv00k7fkChd6fy2sF/tIyzD3cgE7HS5nMtetitkNqc?=
 =?us-ascii?Q?SYErTiMeK43WfG20deY7ssq2OaXU47ebyITptS5ay3TRZqvLRVAQmlfbD2tT?=
 =?us-ascii?Q?fYAcfXsvh5m26rVZmXaPtZxF4H7yKRsHd2o+9/ALcBKngxhAiGVlXz2lsFG9?=
 =?us-ascii?Q?eHcYa4hTdZom63GL5Qv8I0MxLhN3L8j7BICmA495dyo1pMHoTaJgtd8gHXAQ?=
 =?us-ascii?Q?rDHHmeJGmW4V/zUuOQBsGbVm9BACN5O8E3383ege6Z7NyqdpS/yhiQ5hqmNe?=
 =?us-ascii?Q?Dq7/RxlW7sE1OW9PophkmKNxY+c2+e68vnI3ak8olCrvp+VHFmWI+oGTvVq2?=
 =?us-ascii?Q?lw9wA9o7yLqTPO5Umf4itCi4zkOwOsTRaYYJoMXjP4jTw4MVtrttZ/6dGjQc?=
 =?us-ascii?Q?jDadFtt+vkyezH8ZQVlz7EMnRt9WTU0ScY/OG+w3fYDmH8h/gFt26A5nR/U4?=
 =?us-ascii?Q?5G0tmi/X4kJfqOQpnSxwco2+PvpIM6KIMSV4A8Ggj122Zv7dB9v+MC+NEkOj?=
 =?us-ascii?Q?PVqbe/3rjI2H78Jgg3QPjPLWRl9+FCyNH2YDkHeSqXtl3xVVeZo5XoQ28gSq?=
 =?us-ascii?Q?ou0nCO1pwE55zC1KQTmISW0QknMzibrES+wugjegJ7fYiA8SCW4tbEdNEe9M?=
 =?us-ascii?Q?PfUxBd4tLHMdO+qrBFXtkATrmN7pxp9G6+T6wKrMuI0uQ8C5YxO1xV339qaJ?=
 =?us-ascii?Q?ZhnI/C2wkreaGA2T5sS4UwdDDevJocCJU7U1wtNNGEtdhkgFtYFcxCLLElnO?=
 =?us-ascii?Q?f1fmaOKbJMvr6yVexja4v38brpIgbtvsuAgVFe8AH9SJJlvp33LYEsyhxjju?=
 =?us-ascii?Q?h0uudCXM+Xc8DhA7snVlqXerJK7PeBPd+KLDilX6Aomblr6/G1mW5PqYBLax?=
 =?us-ascii?Q?Fz8yru4FRCQyTF76cSzRyw1kyELdME4eQxp/ZFgnCoD5Sn7kVSoyirvU/JMc?=
 =?us-ascii?Q?JJyS64SyVCcNWpzh0PTY5B+BvkahpWFNc5lAqscSAKUOtF7F3Lxl7a8vBSny?=
 =?us-ascii?Q?SRXtY4I2Ki+KfVK6mu2/YpUeKfl3fzNCasGE38+vvZ1XYQlYcjEhYSCMg3TC?=
 =?us-ascii?Q?tUjXDq+/+Ia5M+18rFVUZBW3yjkKDED/2QuS4lx7DHeXm2pQl5L0rlKyWcqz?=
 =?us-ascii?Q?JBPQeLtN7vpH6pvSHabaVt/j69Y3pHQDFZO0sgeMit6OprI9i0U8k6d/d81q?=
 =?us-ascii?Q?G89jP9mLkDXtazvPO7Jx93cMPnNhpXxnQepaikKKIhFfZT5TcLvL29/p5ml5?=
 =?us-ascii?Q?Bv7RJdOELfWi36v3e3+VuuzSPl59wub0CsLxqQiLyT10CpqrtasoOtanHWrO?=
 =?us-ascii?Q?qzk7HjQoksDuj5EG0oLhn70eYZ2Omihbblp+bqjycjgkYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QN0MWZ5gt3G4ctjwiD3gYSFFsusPVIGfju1H7bY4ReoQxtyQLlY0xitLrGez?=
 =?us-ascii?Q?UjxeO+BCilc0qOOGtzhfPjuxXtN8sb/gqfvCMV302dj7ptvfFlBXPBDAW0xN?=
 =?us-ascii?Q?cWWDe0c3oe6qFUUVk1Jzv0XLG9G0IHmjq7be8LGSbJSlNa46eTyqXAgEz68t?=
 =?us-ascii?Q?6KdOIbPTKdBHAm5v6YtPL04siaETXl08pIHVEepaRoDRPYuoSD4Vg9OfgeGe?=
 =?us-ascii?Q?oOydfMAhLiSpZx7tt78idKv8cAYqHpOKYHg74pVHSLzJ2J5wPCk5fWvVF+Kx?=
 =?us-ascii?Q?fH/uLLvt7Qdlw+qMzguZ6o82rATu6xufTFw9efHf/8XSjglu7Z0MteF2IWQK?=
 =?us-ascii?Q?W7ZLmAupyIwZKwiD4tiuUegjqd85xohQgN72bv8xPVgdzhsIEIp0gvKyXIL0?=
 =?us-ascii?Q?YalBLa+nNZPQ9BUYg80PvxlAdak1wG1ytAW+q6Bd3hPJJ7nQvofIGLiHaizJ?=
 =?us-ascii?Q?bPy8+B/CrhsW5TwhYxFj8DuN5hmkXPJ+KbKTjeD0KvBe967orCHpTNChjZme?=
 =?us-ascii?Q?Hpxc4oFg2XtRDYCTwUSsW1rGSkG+96QAb5bwvazZE5wB1TQmavTpOO+sFYnM?=
 =?us-ascii?Q?Qgshs/L4DBcB2PpksCLIxqDQ/KV+wkovGCqKCgpI0c15GkWrTGxVmVI91fTh?=
 =?us-ascii?Q?vJtMci+6wXfe1gmrmnlee6AIwa1BecBWtb6/qelbtkYg1pbNVNAC/G7ShJQ3?=
 =?us-ascii?Q?63pCIgUd520C3tfHlBEmqyOH89UKtqM3NRnNhQNtUoroFdSXxZpOnU7nU4We?=
 =?us-ascii?Q?iqK6IeKpeFMHioPeBeAm73Gy1pjsUv5KIfczIUueWO38ALg3HYXB89G8vdrN?=
 =?us-ascii?Q?jEE5vCw+Y2ozrqUirub5sVM6R6mf1x2qNO9X7vslvkTAd2ehCNmRzpocaBQo?=
 =?us-ascii?Q?D3/mzTwAVCwF2HH4N+l2cGI7b+9SyN/Gagipov+TBzoFalXJrsqZ/ZIKujco?=
 =?us-ascii?Q?y+KI1V9w6GaTQSoUI4Yihu0ioTJKUHErQkf/l8evcrPQpN4VHhPk2BNpZbir?=
 =?us-ascii?Q?euFbLbYCrcOuupjynCOrODq/Zl5KkFRNFkMEBzFmldnyZUIL3nW+0in7kxlt?=
 =?us-ascii?Q?hPjNnpjGy1OYEIXqACSJ8zNg3gX332HLXBUWUcixAJnB5KgcTU+IWGPmx5Be?=
 =?us-ascii?Q?a4QKQbSNno+jXASc32NgZtnabNbmmYMvc5G1TOf818QcaRKfiaYPMJuNwP4f?=
 =?us-ascii?Q?Oc5mRu6ZNxq11hB94S9acboQd7mSRPvhbOOO6DT/BzT8josaonMukhQnDOzZ?=
 =?us-ascii?Q?c7nO0wSowjX/2D/yZC6zubtwQomXNsjR9OChJ/ikyxOYUx3GOC1ibmkZgqOf?=
 =?us-ascii?Q?FkLz/a2RVcKuGWIrxE2JLnHuDAxeWtelZoxnzwl6HsTCJNn+eHTvZ3vRyN47?=
 =?us-ascii?Q?GD4WxC1i0YbEv1cvBUyP9ggLFnKEFQcbQb4gfOQPFYV2hPsn7hKjdlpxV2Vo?=
 =?us-ascii?Q?k43NjfLNQPTCn+fXXPd2YHtWXZFR+wqzNBIADMMkQ7zBVJ6Ut+6SJt2uijib?=
 =?us-ascii?Q?0XnZu+hLephbwlKdTyk20ZvJVjyx72VUp0g8Ex+BozeYgF+wmdJqyVAGeRfY?=
 =?us-ascii?Q?h5eVXuNHeO5dwTW3YrRiLfnHl6gf9RXv8kLnZXPWKFeDcOAALsnAJRVinaLl?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WqNinz65e1+GrTU7x+7BmMfBrf+Jqfaj0ogJo+lm86PJ0SWi/XywG19qEEIYoCd6lb3BTZHibWTbH/tefV9sSQwZlDXJ89EtUOYoCuhbUdUNUmG8UxXHcYDL48a3OB6JwGC0twYNdaDNV5LL9pnCG1BwoFtpwrN8U9dwWXC+K5oHJK3D4ZVJzJgbF3fIabVDXhA47qGJGN+uOsUb5JLOK4FxEOTrTyMnk+zOvdC36aqBiKu+qdMZ35OmxCfPOuIQ5Q4UdP0GX1O1mUeeLnIrsmIRQqjrFbVEmeBZSlIZYvNfEcDDma+BcfqdkCk0pAc/XV20oZ/OLeJH+8PFsz0OdFY68LlikjZeVuStbIZ36NkQnSkPxlWOg+V8XrfsmnkPnqJ5bsjsePTDPW+/pubNNllDbqX1vI7NTW4+r5isxlAUOm/CBaSA9WYDWtc1fUT5X0yettYnN7Q560QnNp6+cWa3qkVuylZz23RkkRiFjq8aybDMN5w/Xt+BXCwU58ibHjwOooFp+/8bwzjxgfje/vY5Zl4/eGqGq38wGCEgJm7JsYGaZUYKdwiZY9fmAnJ6lcSh78WAdB4O4Rc1vjSvXDOB7YkOMO9peceAX2/9+Z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547a1383-b2b1-4a93-76d1-08dcc519332f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:18:40.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BT1TjBgPIOVqWcNfY8GQOT1Nq2st7TgIqHUyGnVmRKWNPzGJ3luR+wK4l6/zW4nFz4oPWcrlMf+vWkdt3g14Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5646
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250122
X-Proofpoint-ORIG-GUID: GM047NH-46Gbd76616gkdgasrTBBFM8D
X-Proofpoint-GUID: GM047NH-46Gbd76616gkdgasrTBBFM8D

On Fri, Aug 23, 2024 at 02:14:03PM -0400, Mike Snitzer wrote:
> From: NeilBrown <neilb@suse.de>
> 
> nfsd_file_acquire_local() can be used to look up a file by filehandle
> without having a struct svc_rqst.  This can be used by NFS LOCALIO to
> allow the NFS client to bypass the NFS protocol to directly access a
> file provided by the NFS server which is running in the same kernel.
> 
> In nfsd_file_do_acquire() care is taken to always use fh_verify() if
> rqstp is not NULL (as is the case for non-LOCALIO callers).  Otherwise
> the non-LOCALIO callers will not supply the correct and required
> arguments to __fh_verify (e.g. nfs_vers is 0, gssclient isn't passed).
> 
> Also, use GC for nfsd_file returned by nfsd_file_acquire_local.  GC
> offers performance improvements if/when a file is reopened before
> launderette cleans it from the filecache's LRU.
> 
> Suggested-by: Jeff Layton <jlayton@kernel.org> # use filecache's GC
> Signed-off-by: NeilBrown <neilb@suse.de>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfsd/filecache.c | 63 ++++++++++++++++++++++++++++++++++++++++-----
>  fs/nfsd/filecache.h |  4 +++
>  fs/nfsd/nfsfh.c     |  2 +-
>  fs/nfsd/nfsfh.h     |  5 ++++
>  4 files changed, 66 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 9e9d246f993c..94ecb9ed0ed1 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -982,12 +982,14 @@ nfsd_file_is_cached(struct inode *inode)
>  }
>  
>  static __be32
> -nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> +		     struct svc_cred *cred, int nfs_vers,
> +		     struct auth_domain *client,
> +		     struct svc_fh *fhp,
>  		     unsigned int may_flags, struct file *file,
>  		     struct nfsd_file **pnf, bool want_gc)
>  {
>  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
> -	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_file *new, *nf;
>  	bool stale_retry = true;
>  	bool open_retry = true;
> @@ -996,8 +998,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	int ret;
>  
>  retry:
> -	status = fh_verify(rqstp, fhp, S_IFREG,
> -				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	if (rqstp) {
> +		status = fh_verify(rqstp, fhp, S_IFREG,
> +				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	} else {
> +		status = __fh_verify(NULL, net, cred, nfs_vers, client, NULL, fhp,
> +				     S_IFREG, may_flags|NFSD_MAY_OWNER_OVERRIDE);
> +	}
>  	if (status != nfs_ok)
>  		return status;
>  	inode = d_inode(fhp->fh_dentry);
> @@ -1143,7 +1150,8 @@ __be32
>  nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
> +				    fhp, may_flags, NULL, pnf, true);
>  }
>  
>  /**
> @@ -1167,7 +1175,47 @@ __be32
>  nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
> +				    fhp, may_flags, NULL, pnf, false);
> +}
> +
> +/**
> + * nfsd_file_acquire_local - Get a struct nfsd_file with an open file for localio
> + * @net: The network namespace in which to perform a lookup
> + * @cred: the user credential with which to validate access
> + * @nfs_vers: NFS version number to assume for request
> + * @client: the auth_domain for LOCALIO lookup
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * This file lookup interface provide access to a file given the
> + * filehandle and credential.  No connection-based authorisation
> + * is performed and in that way it is quite different to other
> + * file access mediated by nfsd.  It allows a kernel module such as the NFS
> + * client to reach across network and filesystem namespaces to access
> + * a file.  The security implications of this should be carefully
> + * considered before use.
> + *
> + * The nfsd_file object returned by this API is reference-counted
> + * and garbage-collected. The object is retained for a few
> + * seconds after the final nfsd_file_put() in case the caller
> + * wants to re-use it.
> + *
> + * Return values:
> + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> + *   count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			int nfs_vers, struct auth_domain *client,
> +			struct svc_fh *fhp,
> +			unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	return nfsd_file_do_acquire(NULL, net, cred, nfs_vers, client,
> +				    fhp, may_flags, NULL, pnf, true);
>  }
>  
>  /**
> @@ -1193,7 +1241,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			 unsigned int may_flags, struct file *file,
>  			 struct nfsd_file **pnf)
>  {
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, 0, NULL,
> +				    fhp, may_flags, file, pnf, false);
>  }
>  
>  /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index 3fbec24eea6c..6dab41f8541e 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -66,5 +66,9 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct file *file,
>  		  struct nfsd_file **nfp);
> +__be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
> +			       int nfs_vers, struct auth_domain *client,
> +			       struct svc_fh *fhp,
> +			       unsigned int may_flags, struct nfsd_file **pnf);
>  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>  #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 19e173187ab9..3635c0390cab 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -300,7 +300,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
>  	return error;
>  }
>  

__fh_verify() becomes a public API here, so it now needs the kdoc
comment (removed in 4/N) restored. Consider not removing that
comment in 4/N.


> -static __be32
> +__be32
>  __fh_verify(struct svc_rqst *rqstp,
>  	    struct net *net, struct svc_cred *cred,
>  	    int nfs_vers, struct auth_domain *client,
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 8d46e203d139..1429bee0ac1c 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -217,6 +217,11 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
>   * Function prototypes
>   */
>  __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
> +__be32	__fh_verify(struct svc_rqst *rqstp,
> +		    struct net *net, struct svc_cred *cred,
> +		    int nfs_vers, struct auth_domain *client,
> +		    struct auth_domain *gssclient,
> +		    struct svc_fh *fhp, umode_t type, int access);
>  __be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
>  __be32	fh_update(struct svc_fh *);
>  void	fh_put(struct svc_fh *);
> -- 
> 2.44.0
> 
> 

-- 
Chuck Lever

