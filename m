Return-Path: <linux-fsdevel+bounces-27061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8A95E415
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 17:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE38A1F215E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67660156F42;
	Sun, 25 Aug 2024 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLmbtOAO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDnlM83r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1351FA5;
	Sun, 25 Aug 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598606; cv=fail; b=Htu+X0rtnHkOY0AzE6DUWXnJBAtwmx5TnWHxlXELqIStujIjIr4FkMp9YcF2m0iMrlMHnMESt/D9X9oqCNxN6lqJXSTHT7hQmqY84XJ9npLW8ZjbT+0cCJ0dmSthVbgd7JMSAidkLUWH2AQNkhW/fthKb+hKjQmUIjFXbcD6bh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598606; c=relaxed/simple;
	bh=dN4wTR5R72tjduMOTazH1L/7eEBlAwgLHJTjsz6cPtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8HIW9WoMh+UPLmW2nIWo2WW/oYa04JWPovfKwist328KQrRfywcDjXqWciFvBxk9pau/om7UTG3NkfoFFGd+fnAA/CV3jtq7hayBOFNHKnvnMhYFPZTeGvIyLpGl5y+zyM3ZlXXDELusIRybJl8RPtB24+sJeGYOY4FCHwTV4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GLmbtOAO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDnlM83r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PDrU8B013601;
	Sun, 25 Aug 2024 15:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=TbaXINKsFowSLwm
	/EM9Xqkf9FBWDA85tN/bkjrvJSFU=; b=GLmbtOAOrBMDCxDJG6uVfD/ud22mCmG
	PClxi9vzdFEle6X8T70DG1h2dp51yMG36HjR9iQXKrJeg1FEgu89gRd33wK4sia7
	JHckXUSzeUM7DYXHUHxZ8nJDO5t1sbxywG/CjMDkdVp5pQSD3PY/Kv9sibo8HA80
	FNw+vL+lbCO1dvN5ZInRHX1GFmepR73ZB27bv8s93la/wnfuhIShs+ker4rJOOq6
	PUCMExAyZuYTGXrAsQ+bTDjLI1Oi8E8TB8yzI+1m4lzA4xllUdAezv5flqs0DXgR
	xUDUZ+RDOmP1+XuCQE+KmGzjXI3EBebFKECg7+BXmMf6ADMQ70SzLeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177kssja1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:09:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PETWsN004148;
	Sun, 25 Aug 2024 15:09:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4186dy8p6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 15:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW/FeT80OFIixr368BpckfWm+2YDmX3PwdMcbEjOMfiTQNWa1G8ntQmLPSwRnPSbfsgxf7Bp/8Opsu6WIGR9wS53Mh3LqJDolbJQnH9pshNAQ6EupZhl8JF4cFiil6tQFL988KEAU7Wf4b6RywqXxvypiZyUVwx0r64zQ6ClF90Qf2a+XvVa2HfG736SVwdFaeT4d2rhnL+zu5Zf1vIVAyhKJjMvkHcziY7gEo1gL3I5ZJoB/pIAWJQM0XlH03b5JkiH3B5cVfWBIlQV5Z4/hAVYKv1qvPOz6BSFrBD7zsXajUpST9DbOW/B1OoiXMdcsnpV/IktQ7NVVKu75ZxP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbaXINKsFowSLwm/EM9Xqkf9FBWDA85tN/bkjrvJSFU=;
 b=FxpE9flAlG6g3U6nEWBAWTeinDYRVn+2sSepKYyKb9DR11KM+1w+bjSumMcIKGE2SclHfNfdTCIo/Weq5AflTFCVqkCqMEPUI5MGzYgU1TtZp7typgk9b+flsVSyKC5FpQtaJ09OQd/8iHQejeYortVcwEBrg/qANSNTONoXnabt0o8C0lHK4qLv3eoq68EFE/S5h33fVmWPABKs/ei+vkIPzfxrGUpcVnti7bVzlIiKG2hjlY01g2urAx32m+/9hsNknrVUD3yDE05jNnIXahNrZXL5g053hm/L8R8Xkzz/4keK9gg+8t3iIhLHY9puEHzc9+sNc7gXe6r9tnVCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbaXINKsFowSLwm/EM9Xqkf9FBWDA85tN/bkjrvJSFU=;
 b=kDnlM83rM/WE5H7ODt8hN/a0t4PXfrOxF+ML+9HSvHFqjWEqFp1PV7Za+6pa3VVVNsdf85PaOUcVtxFsJqIAiM9Oyz6WzU1D2V3rCHTHsapmSSHR/jE054l85HgGoOu01U4AaErtObZo5uVHujc4UYXVLklATHRSFNedafa+ujo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 15:09:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 15:09:50 +0000
Date: Sun, 25 Aug 2024 11:09:48 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 11/19] nfsd: implement server support for
 NFS_LOCALIO_PROGRAM
Message-ID: <ZstJPI+bRW5+DVAF@tissot.1015granger.net>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-12-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823181423.20458-12-snitzer@kernel.org>
X-ClientProxiedBy: CH2PR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:610:5a::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b644ea-8d39-4087-2677-08dcc517f77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d73CmxDUkywzTENgXq4n+WVuUaSw5aJjkIA4mHE1uSk2efZPyjrayVA5oj6l?=
 =?us-ascii?Q?HpktiI1lZxmRRwCDPVmXeSRzm/3D/fy9V+4VjLHZViEWlBizbBbyHc5wIHtk?=
 =?us-ascii?Q?UMkhspAM35xH2CUxjFN/5k2qRTl77zoQ9IU7iCrUinpzns+qlkDuoNJbReCg?=
 =?us-ascii?Q?DDOdOx3EYCypcQvcdE+KbMSNCsQC7kaQbktzZ5eZ6peCfRP5qJqrZs9jFPD1?=
 =?us-ascii?Q?tmPz673HZ/cVH8vA+ZothYNnNXtZJtxC4gnxpmLAld2rTuCpNJ2VJahhRnHJ?=
 =?us-ascii?Q?187QZevl22l6kp4kquTdyjczJ9l1Li3Gz7UDu5kuuLonWAAAH2apONJTyKlH?=
 =?us-ascii?Q?tnduGXvGopGWHCT1ARwxQbDakV8rFqHXB14t5W7UgrnZdexlIEk6E35CY1+h?=
 =?us-ascii?Q?J2x4eb2mfuTO1WG4SU5M3lxVDQhBgoULz5c7Xz9p453Xemx7pHi9pFlg61cA?=
 =?us-ascii?Q?2VdpPH7XnRwFyJoFvjUUYb5ZDGxS9aOQG7VYw1tSBHL5GlYzOsy0d5oQKd2Y?=
 =?us-ascii?Q?nlnJFhA42eL7v5n3zPQi8FFlvI4+D56es3n5sZMPSQ/OdCSLikgKNNfEShWg?=
 =?us-ascii?Q?NyErtUlfi0VuvpUczapkPG4dchx/hll9eXUE89E65dSoSCu2tROONHmquuq5?=
 =?us-ascii?Q?u2I4tZ13HQf36oMRI5HhO//hrV7iVrgTeio68rKolGBrfd8U9TRNtkvOKZu3?=
 =?us-ascii?Q?5S7DS2mIEFVRPb/qfp7X2la2I97/e+22yz97t6bi53hUeO95gfkvU0ntbtEX?=
 =?us-ascii?Q?pj3UiCxoqD5QeCfNmVhMPNrlUx7bEvzwdP8SoZs2YNwA0TN6dNNUeNkDB89+?=
 =?us-ascii?Q?efMk0Mjh0mLS9cWCbcIf+oIyHqY30zecFGoHbPwYoSgKkCX3hFiwYASWTMQd?=
 =?us-ascii?Q?+ityijODcJlrO2iPCallr73BVmdt4zvbVmAUUdFTywFxnsGNJi3MKz/4I/Qa?=
 =?us-ascii?Q?+j0yQ3AejKpOpHZQhdfyFi0+WnnCFg6ZArEHdM8KzxpYQaVSEGMu/a5w1RwV?=
 =?us-ascii?Q?lcjTq/bh0/8rtzrbvHLy2qKrCmzYp/J0bOfIckWtw7sw/E40/O2lM2B1/x9e?=
 =?us-ascii?Q?pTdRlby3BPsXmlS1Y1z8v3mu2k94jKf/dUJ5kp2Yj/v9hm24JPCMQYjVmypn?=
 =?us-ascii?Q?9HO0JbQfyjC57Z4WTUiD62vom8omLimWAv23n3aS+dLoD0QjJS1yoQ8B7Nxf?=
 =?us-ascii?Q?72iE1S5wLdo3aT26hc1+sh9+LJivnKHYMwYArrRA2toJfFtOxO6x9JhRHh3t?=
 =?us-ascii?Q?gVMF6sANFyBJ5uTBoXtSWqiBPeZQzyYHtXjopG9iuyNKlh9tliaHC9e8tFGi?=
 =?us-ascii?Q?11w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ZVTSQsmK+Nd2cn1B9NhLkOSFsItWCYhtG38VVQlx2CO51H+ASahgoBokHgu?=
 =?us-ascii?Q?y2v5t1sdRU8mGTv8oCJC5iU+KdOqzSsyur7oeJHX0rfZ1RUrJpAY7Fq80OOX?=
 =?us-ascii?Q?zZHTZgs4KTO/YtEEQ/pP1Ggyt6uOyLFcwCti0wm4tJtBuQ4y4c28fQf1Sd7l?=
 =?us-ascii?Q?BU2VXd8RuDbvwQnC4JFdcU6At9lClNLQYQjiuAMuJfnO5TLmhB7y1iApW0EX?=
 =?us-ascii?Q?NeQukU7H0YMtMH6IsuFJc4Tym7pNraNVozVVFynrui8h3us93GBY6BKtDe82?=
 =?us-ascii?Q?iIGkPtO+szQrEjAhtOO9g7NrfsVbuEJ+cbYUY4OAK93LEazlhWYaNQWwWNKY?=
 =?us-ascii?Q?HFhV73wgxFBKzput5TBzZFd8LYxS/pxSlVPukSZtZSrfueuJdgJf2m/f9xWX?=
 =?us-ascii?Q?E8tu7Uw7lktlnEwe/mum1ySly7DHT5Xfr856HpAXPMbN23xEmKl+O7AU6RcG?=
 =?us-ascii?Q?S6A/rzOqRD5prc97vSxqLE2ok/YatK00MBlgwt0TJT1kudhJYDyWKMZJb1Af?=
 =?us-ascii?Q?c3S9jk138l1NxP5K0adFwGEn3uQsq3D9YVUN6IV1271gs9bdTkGtQ6MUjtLM?=
 =?us-ascii?Q?x0J8P9IehXuaHtZ9SD7jJTSBjjedK23yo2ioNl/qpLKbGjCk7LOW19JN3w8z?=
 =?us-ascii?Q?NGfOBa+lopwJGDbvlICyEMYm+LAg5qPWuVknohu818DPwsiPnuUizIZN89uF?=
 =?us-ascii?Q?SfJTJNyhDBovpWEMdLMw+gqQy04kt0wz7jMZVlhj0yo0UHnNG2hPLLcGak65?=
 =?us-ascii?Q?6pA60vj8kCzM4vzmQq6+ohVEtZIdrRC2SFCJQPh1in27R/bmIahI5gPHyt7+?=
 =?us-ascii?Q?v2GuhehCxXMssGr4OJ8y8K6H3LT8Tp7fW2TZ3w/TXrcXSJotNLLC5Nj3FjzU?=
 =?us-ascii?Q?n+AelmqQV+GR8zHAjfotwKNHTGD78PZHW42eGnsyHgfCJvHFr/6vtajpvpok?=
 =?us-ascii?Q?y3DAZWJO4y8VXrT+caIbgnE6dleSZa0J9gwKPwz0OPmHzNI47xJp0Lk0hQMQ?=
 =?us-ascii?Q?cMaHXkXcl9KDsWAQQYaPOS+sq35cTXAE7dbjn0U3WS5N3xdLCpsU6EGQo/Lc?=
 =?us-ascii?Q?pj1lJ6cwyHjXoB4SozzEIiLmH13FrWhP4Jtq7B/97Lc1tPlG5xHnD7zfJoB+?=
 =?us-ascii?Q?TmN7dZRVkmMsyN3a0hTiALWA8L02ARhWnGu8Z+mnudEZ/5Rftat3sLwpyUyi?=
 =?us-ascii?Q?75aVOQyO00AcdZtS8oLU29bh/uqduTS5afebArKaaBoOM8TW8+HT6+p8vwQ+?=
 =?us-ascii?Q?wqjtL4EwflpVpVwutkrnSKO3bHuWjMpQUbGI7AZhcmHLVp4HcekfN8hmBPMr?=
 =?us-ascii?Q?iW6cbFcLtSoQ6RJC2iizxvWaIiZe63GTUKDBPUc4v6EYTeX8qi859cTdXiUf?=
 =?us-ascii?Q?rP3TV5YAXd/QO88GCFtQ6N0EK+ywMm6myftnaXDG8kivLwfnP7Te2jS9mGd/?=
 =?us-ascii?Q?SKW5W7PnfJM1t/7pF0t2SsLvJxtAiLYZUgQoVakj3Zl2APsKa6lJBoDcqgvm?=
 =?us-ascii?Q?cH9mqj7abbKEf3i6QobQbTTxfGl7LPyKcc+sy4S0yCT+hDJksc1FYBUJqrdg?=
 =?us-ascii?Q?/DYh7czPZa90YLg0HzIKjBw6JGU1XS9CmyOlK7x5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hx/8CDRpGOYCSATZfYFHVVdd3ptqU2WA9oq33Id7ZM7SqG5DLWFEYUTCyjkbrwOa1mFY/dnUaNcujNyfIy1xFI37fOHjraoGTgVU9ZworZdsIddH9Or4H2SgXgTYMFCsCiqIRHWJ535L8LtnmoZXz4BL5kFDHrUeRntKjt/mPK/M58QL+LRDktt6ZgJhrBrfex2FqrQHfc2LH1NF2dct6GVJNo+csGRTxv9HOx6ZYAS+gcKNWslnh41CkShgR9ZNk7fGiSgyV11wfzANxJ5RqVeTyhfq3Z3xeJrY3KjQWnelaeYEXW+Tk1/KhJxb4+AVA9VCR9W/XhnJK28einVtblQCe0igXe5D7skxUOYuUnrgL++EtB88vv5RyHkMIbgYgby9sL5aiN6V1e5qzVJNZL5B8oxK0S/DP9nKla3OwTpOk/2q2TROj6CEHTjQP7VvqAVkmpXZ4Ra2BK1WGK1VfZCsNjjKEDnmE2KhJmYAFaCXaPMJsejsLXa2Q3DXXVvDN1Vn9y0bfiik/aEkEahNISjy6BQnCiN2nugZezXQwPNmCcI/M5b126KRTQDVuP4/vOLqsFXW8fPEddf/oWDehu4/uq8HVboBrBrGHVQfBzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b644ea-8d39-4087-2677-08dcc517f77e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 15:09:50.7778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA53Z2P8KMWjyy3gVDMdOxOEK7a4Wnv1bmAuQNUSzAlHwGkEc/pbYRRu1gRJSxQfSK+AymoAqspH/6C9fmMTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408250121
X-Proofpoint-ORIG-GUID: XT-80pes2iCMTcjA0XtD5xXbPnFUyP9X
X-Proofpoint-GUID: XT-80pes2iCMTcjA0XtD5xXbPnFUyP9X

On Fri, Aug 23, 2024 at 02:14:09PM -0400, Mike Snitzer wrote:
> The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
> RPC method that allows the Linux NFS client to verify the local Linux
> NFS server can see the nonce (single-use UUID) the client generated and
> made available in nfs_common.  This protocol isn't part of an IETF
> standard, nor does it need to be considering it is Linux-to-Linux
> auxiliary RPC protocol that amounts to an implementation detail.
> 
> The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
> the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
> XDR methods are used instead of the less efficient variable sized
> methods.
> 
> The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
> by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
> Linux Kernel Organization       400122  nfslocalio

Since it is a major design point for this patch, the patch
description needs to mention that the server expects LOCALIO RPCs
on the same transport as NFS and NFSACL operations.

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> [neilb: factored out and simplified single localio protocol]
> Co-developed-by: NeilBrown <neil@brown.name>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/localio.c   | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h      |  4 +++
>  fs/nfsd/nfssvc.c    | 23 +++++++++++++-
>  include/linux/nfs.h |  7 +++++
>  4 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 8e0cce835f81..2ceab49f3cb6 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -13,12 +13,15 @@
>  #include <linux/nfs.h>
>  #include <linux/nfs_common.h>
>  #include <linux/nfslocalio.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_xdr.h>
>  #include <linux/string.h>
>  
>  #include "nfsd.h"
>  #include "vfs.h"
>  #include "netns.h"
>  #include "filecache.h"
> +#include "cache.h"
>  
>  /**
>   * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
> @@ -106,3 +109,75 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
>  
>  /* Compile time type checking, not used by anything */
>  static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> +
> +/*
> + * UUID_IS_LOCAL XDR functions
> + */
> +
> +static __be32 localio_proc_null(struct svc_rqst *rqstp)
> +{
> +	return rpc_success;
> +}
> +
> +struct localio_uuidarg {
> +	uuid_t			uuid;
> +};
> +
> +static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
> +{
> +	struct localio_uuidarg *argp = rqstp->rq_argp;
> +
> +	(void) nfs_uuid_is_local(&argp->uuid, SVC_NET(rqstp),
> +				 rqstp->rq_client);
> +
> +	return rpc_success;
> +}
> +
> +static bool localio_decode_uuidarg(struct svc_rqst *rqstp,
> +				   struct xdr_stream *xdr)
> +{
> +	struct localio_uuidarg *argp = rqstp->rq_argp;
> +	u8 uuid[UUID_SIZE];
> +
> +	if (decode_opaque_fixed(xdr, uuid, UUID_SIZE))
> +		return false;
> +	import_uuid(&argp->uuid, uuid);
> +
> +	return true;
> +}
> +
> +static const struct svc_procedure localio_procedures1[] = {
> +	[LOCALIOPROC_NULL] = {
> +		.pc_func = localio_proc_null,
> +		.pc_decode = nfssvc_decode_voidarg,
> +		.pc_encode = nfssvc_encode_voidres,
> +		.pc_argsize = sizeof(struct nfsd_voidargs),
> +		.pc_ressize = sizeof(struct nfsd_voidres),
> +		.pc_cachetype = RC_NOCACHE,
> +		.pc_xdrressize = 0,
> +		.pc_name = "NULL",
> +	},
> +	[LOCALIOPROC_UUID_IS_LOCAL] = {
> +		.pc_func = localio_proc_uuid_is_local,
> +		.pc_decode = localio_decode_uuidarg,
> +		.pc_encode = nfssvc_encode_voidres,
> +		.pc_argsize = sizeof(struct localio_uuidarg),
> +		.pc_argzero = sizeof(struct localio_uuidarg),
> +		.pc_ressize = sizeof(struct nfsd_voidres),
> +		.pc_cachetype = RC_NOCACHE,
> +		.pc_name = "UUID_IS_LOCAL",
> +	},
> +};
> +
> +#define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
> +static DEFINE_PER_CPU_ALIGNED(unsigned long,
> +			      localio_count[LOCALIO_NR_PROCEDURES]);
> +const struct svc_version localio_version1 = {
> +	.vs_vers	= 1,
> +	.vs_nproc	= LOCALIO_NR_PROCEDURES,
> +	.vs_proc	= localio_procedures1,
> +	.vs_dispatch	= nfsd_dispatch,
> +	.vs_count	= localio_count,
> +	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
> +	.vs_hidden	= true,
> +};
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index b0d3e82d6dcd..232a873dc53a 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -146,6 +146,10 @@ extern const struct svc_version nfsd_acl_version3;
>  #endif
>  #endif
>  
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +extern const struct svc_version localio_version1;
> +#endif
> +
>  struct nfsd_net;
>  
>  enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c639fbe4d8c2..5f8680ab1013 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -79,6 +79,15 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
>  unsigned long	nfsd_drc_max_mem;
>  unsigned long	nfsd_drc_mem_used;
>  
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +static const struct svc_version *localio_versions[] = {
> +	[1] = &localio_version1,
> +};
> +
> +#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
> +
> +#endif /* CONFIG_NFSD_LOCALIO */
> +
>  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>  static const struct svc_version *nfsd_acl_version[] = {
>  # if defined(CONFIG_NFSD_V2_ACL)
> @@ -127,6 +136,18 @@ struct svc_program		nfsd_programs[] = {
>  	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
>  	},
>  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	{
> +	.pg_prog		= NFS_LOCALIO_PROGRAM,
> +	.pg_nvers		= NFSD_LOCALIO_NRVERS,
> +	.pg_vers		= localio_versions,
> +	.pg_name		= "nfslocalio",
> +	.pg_class		= "nfsd",
> +	.pg_authenticate	= svc_set_client,
> +	.pg_init_request	= svc_generic_init_request,
> +	.pg_rpcbind_set		= svc_generic_rpcbind_set,
> +	}
> +#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
>  };
>  
>  bool nfsd_support_version(int vers)
> @@ -944,7 +965,7 @@ nfsd(void *vrqstp)
>  }
>  
>  /**
> - * nfsd_dispatch - Process an NFS or NFSACL Request
> + * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
>   * @rqstp: incoming request
>   *
>   * This RPC dispatcher integrates the NFS server's duplicate reply cache.
> diff --git a/include/linux/nfs.h b/include/linux/nfs.h
> index ceb70a926b95..5ff1a5b3b00c 100644
> --- a/include/linux/nfs.h
> +++ b/include/linux/nfs.h
> @@ -13,6 +13,13 @@
>  #include <linux/crc32.h>
>  #include <uapi/linux/nfs.h>
>  
> +/* The localio program is entirely private to Linux and is
> + * NOT part of the uapi.
> + */
> +#define NFS_LOCALIO_PROGRAM		400122
> +#define LOCALIOPROC_NULL		0
> +#define LOCALIOPROC_UUID_IS_LOCAL	1
> +
>  /*
>   * This is the kernel NFS client file handle representation
>   */
> -- 
> 2.44.0
> 

-- 
Chuck Lever

