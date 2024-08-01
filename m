Return-Path: <linux-fsdevel+bounces-24811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A062E9450AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D08FB27CF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7F1BB6BA;
	Thu,  1 Aug 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oOfDJpK+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gnk0Ha6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AD1BB68A;
	Thu,  1 Aug 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529925; cv=fail; b=KwG0D6y/RsxT/1rPUq/wMRGv316hZZR/d7QcmhePgY8OI9L8jyjRgf1H1GlQi+OEzpEs3dslorqn+ZQt69HIoYjPcTe95P3ChBGq4SmXFzqE+bUu8zOFhirfyfWx7GKOLy7vd55qt45IBKmYSBiHkNwun7+dD0MILSq7Mpr4Hok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529925; c=relaxed/simple;
	bh=ALPxfIOW5h5ScSGEkqs19C6Fme34Aq3Q0vQRV90Oh9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOtnT5iaj+FUSz4EScTsqw9aMltdaKDtDGEsNm/fc9TDVSpKXNE7xOSLAlpAvvIUlaiolt7CjuvAhNL6nEiUiZ4URMyizsoRLQpULI3iwmeU+N8PL96wvRCpKYbKm9/CngxHHdTT2FJFbCm5P9RvIVsiDlVSGl6HePmcpeJgggY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oOfDJpK+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gnk0Ha6p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtXu0023400;
	Thu, 1 Aug 2024 16:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=IryypLhLwt2cksvS7FNZrwLvr17cR1QbQlsUhwsl8GU=; b=
	oOfDJpK+w79T33ZkuRuuyGYy3srlF9rfGivWdEheRweXn+g3sPoQPxaW80Sv9CAW
	bd50vsAT0PtcyAreIX6XIpGgNJggyfX+xTXsFXkWO46a3R3QSzUtsL3EaxC/cYpC
	6BUAbKr78lNMHR1OnFVlWthtJCDpBgOcb5HUOSDP3LM6PTZliKo5wvFswjSbnAk/
	Y2MXWGswWoaT/ILxF+Tnk8GChhSr2eZ7Th6ASNfZD+G+2oIVSIeTKkuthX+gJVt0
	FfAYGte79UoaXwa9hZg+nct0zdpmtFh+Z3LRieXZEQD8wtjtregO+7hL3MWi/KFw
	ymPlpuV4pXiKP8zofqqXkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8t4cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471GKsKc019040;
	Thu, 1 Aug 2024 16:31:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qjmtvqgk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKN5M26kY32Ed2v0e2ZbiVMSTmGyvBTxVfsqq6bW+ifX8JBwjTlJ+qYNu3m8VZUj6CpF+7HTPGwT7WuwNQytL3BGDqTPc1ZMo6psjae2GSDJoRLoJW4VXqeD+aA/Q7l3OyN2i5m5q7W0yhCvFaaJjclk7q5zVmBrG+am5AfcadgTq77n7V0laV5rach/Sx11ZU0OieT4o/HC3UFOX3RBAwHjghDf3ZWV2wiiFDjZTV0Ft194Hz+5cMPib0Wwt4CbMBmkFBZcnVfm6i3i7JOL+nta/PHXdpMlotXG67AFQnEGcpkjgSzG+Wi3YxxwZd+MdIjNlFmaJCQlt/x7Aa6Ybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IryypLhLwt2cksvS7FNZrwLvr17cR1QbQlsUhwsl8GU=;
 b=M2UbD+ztVJ1gw0kmZCbkLDoLebiyVI+cYkIDVZnseJrk/b3F+DI237ewJfNN1ZrlPuocA7svaqFGg1waXud8Jse0FROGGTYku+Na0r3YqpI1cEVD3sea0h5bLH9f0bRvKkgZixawhxIpSFcToD4rPi9hOiY5N2u3al/m0k6yglguGc5DE3Pme8d7lg3F9IaGN2DO4kwvmLqDY4xbCTIiYDMTPvkCOiBWyErTkwuHjjAP/uDcRq4ozB0OhOxFZU2rTWQ9T2nZCztuM1SShDRDt0ZqAP2aPWOK1GoVhjdw6DFI4fl47pyGLH2l5UMtSKXbmR5R7FGGIZO3i8RoRE2hNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IryypLhLwt2cksvS7FNZrwLvr17cR1QbQlsUhwsl8GU=;
 b=Gnk0Ha6pbFDR5JoB9uBtU8yCSmfh+2HG8NAdSHIFIvpKhOLOGY9CmI7dBNgCdcNmptfiZ5vABtkGnI8qJK48FU+wSXPOX0wf5/uBnGs0Nf2f7VFsdI6w17zaglxPWkpgeib/9zuF4U2QPOfig9kqQxD4b3VRF+5yNM1QfzTr3h0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/14] xfs: Do not free EOF blocks for forcealign
Date: Thu,  1 Aug 2024 16:30:53 +0000
Message-Id: <20240801163057.3981192-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 64578665-7898-4e6f-b632-08dcb2477244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6kvxrAqyoEqaL+3XhpIVKDhbRRtFit0EfGpyixfzJbB3nu/97FGJ4aZvQHDZ?=
 =?us-ascii?Q?lhlle37nOhqAJd/u61FH+rjk+jP56ozQuD4IPtOE7D9eYGyTGlxyAmZAZU6Y?=
 =?us-ascii?Q?06TXhT4UVfdskrgg2zCOODJgEzR3A6Pyk28KzQQmfqnSdY/umyim4evuMFJL?=
 =?us-ascii?Q?202GZobHRCHfv0r19lsNAEyws0yvhxPF6SGRb92A3MYS2orjpgkuciMYa7iQ?=
 =?us-ascii?Q?8Qjg82cHBKk+i+N+qqu4AVYeu5fj0MBWNMsqSAEu8vrSu00izoSzQZfCIqKT?=
 =?us-ascii?Q?cqjxSdf5ojgQ5XTaDYGpQvm5LzGE6DYAqwrPRJmilzqnXSbs8GA6bv+SIvwe?=
 =?us-ascii?Q?ciNNzUMn39CH7b/jzkQuSnK4Q08EwoEj3j6AVHYnb+bCSNGqihYCCNLGD90p?=
 =?us-ascii?Q?tei3sorqhUcOvHERTKX12ACyvnZ3BzvMRDXF7gX94ztEFnZyeBx2g30U0gV+?=
 =?us-ascii?Q?M/ghOZHuyxcKBF2JSfpxleGkQ7KVUfcyaUNyh7zanC6hEJCCW5quwSXyMZoY?=
 =?us-ascii?Q?adpIXoLuwesDeLrp9+No73m13fK60kpOdh+PlIyfCy0TppoixqefNXW/Tvo/?=
 =?us-ascii?Q?0YFfAxiXqdVzop/2MIowcWxVNQg1yasQjNdsiYWLQpBnkaQ2RYu6PJz0nnWD?=
 =?us-ascii?Q?dDLVCJO2mvGZfdCj/mFx3YOntQMDimIzmw4KaHSaXIGnMusNew56qABLyw6/?=
 =?us-ascii?Q?Bn4SfaBJ5WZ31dXAdh5TWrnesBjdXKpMaqEu6rJbBffrGXaYq4EwWiuFPbc4?=
 =?us-ascii?Q?ft+ToTpPuvvrt7pyiM6YgT4fAbPUZtNtYp5K7JzK3K5+inpEhi4q2AEKk0LA?=
 =?us-ascii?Q?H5mmxr97QHjm9R20LbUomn5wCW8xZxLn32vFZgqf316p22aSsDPpDbg/OWa8?=
 =?us-ascii?Q?EvQe0QoQvx6OIZrE8AHUP9KHdi5MMkhQa63l3/1BvsaNUwzuL7pIZcwsmRHp?=
 =?us-ascii?Q?m7xUxcJrGACiUGXL2MgpuHdgDIA97jUvPZNabV449yhYD/ltbkQDyJH8Z/Ix?=
 =?us-ascii?Q?xqhRNfaLTIsxVzDYaxpsVzkyT/PkwJ6JhOtayOOIZWnShuY1CzCOPel0PnHJ?=
 =?us-ascii?Q?OtuUd0W0I3S88n76+drQ8pd2y9Q1B/yUzDBCAHcIu9f3/rv4iQ5OTbEwrarj?=
 =?us-ascii?Q?euaO0dXQRyeoa8aeQz/IGuUHCPjAS+DXWsjn+mpCzlXCwyWuqj7PZTM5pf1y?=
 =?us-ascii?Q?SMmQgbazTsOVJzH9bSmXzXVycl2JiqDgbcpGnDQ5E8PD42nQxUVt8F4aKzJT?=
 =?us-ascii?Q?rce9C9Jis+c+tpilw7pBRc5L4y+C+MGKjXiew0lfAnM2id831/Yc6f8waiM+?=
 =?us-ascii?Q?nJI/OurEyjvRzRSiahkmkujs0rvtDJA1gBagx1aQodvysQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ghzZ5MyMUb0hGOgpFsq0wxi6OgmKY68ExnERrvgpH4DHUSGcs85/+7Et4VWR?=
 =?us-ascii?Q?GyrrXYv2lDIVz6Lyb5LLXaUDUiB+74K67w1YHQKRNj7pYiTyfwiPvEphtxX/?=
 =?us-ascii?Q?bPWVn3l8dCNsX8XiVAGeXL9H9KgXz+qcaTt2N6nzTzoCBK9UjLxPA6cpRHni?=
 =?us-ascii?Q?pL9uxotwsH0maE2ov7v56PnryTghyNOkHEqwQmHrovh+HE4C4oj3ijm3zICd?=
 =?us-ascii?Q?/hDZ9IaN8KepvmiM/VH1Z5BWhdEmi79Qt97uly0QZByJpFH20zt042uHx95O?=
 =?us-ascii?Q?1Prlb/4U7izN5IVGScSbCkwNGhDMfLPyHtRfFExm71YuRS64bZ291Jqeb9JD?=
 =?us-ascii?Q?SIg+GSNNJG29ObSdxYiivAExMPRvfUsVPzwr+j2HpR3y064RzSjSlIQ1qwWo?=
 =?us-ascii?Q?j6agVxGaKMB7Ao4abpSa71L6loyrKEi+CMBgDszAncKCEZdlWqSixrSxBsUE?=
 =?us-ascii?Q?nh2y+M1G3iUgwjLmGMNgilIjdTxet0CF2vOS1VYRQiR5QyXtxJSmHbb8p53R?=
 =?us-ascii?Q?4LphT1VyX98QKneVnEsmy26P9IlNc33p0yKyET6Hf0Rt0DUZoyy8t89eOzGD?=
 =?us-ascii?Q?nj1EQ7/NCxIaoQbMz5M8g1ktVF7dZs7BfUYJ0RGKyX98GJU7zLYKqnSS+43n?=
 =?us-ascii?Q?wRqpy7/125wO7p0HXm6LjNXD2FFtDBtl+iPS/PfrDcJ3Tkyoryr4fkv65Jr9?=
 =?us-ascii?Q?caQPo/w5rCOR3Qm+1ICf1pxAt832oajG3HATLM/5/V4C0E2xj4EmrKiuuzKb?=
 =?us-ascii?Q?00Y6oa4h4ty01Kp5bqFKdhwTEHLIGMFFospARcQfE21Wfg7847u1aKo+Ro5S?=
 =?us-ascii?Q?UXoxQmRXNZQf4K0RXUEPlf5se/GdKJIQaZEMdF72wHXtPYGPgwmHFZfWYBts?=
 =?us-ascii?Q?C8pqTHIB6LhW+W+NGquRO4JZoRu5wze2P+2RPThK0mVFeHjrnongEfoLgkRu?=
 =?us-ascii?Q?2HuiFt0X7DAb419n3JuFeFtSPZHwMeULna3rsu6YXVVHb1VDCd2/g+9ofLja?=
 =?us-ascii?Q?P0YW9MpYiJSM3Yf82SRiFeFm1GqsnHR2AaQFk0nCLWNKc0ZfGwlzp+lSxc4p?=
 =?us-ascii?Q?5h7ZOF7VCWAiiokjaM5XqD195cznkGKDaFoGG2t+54L2ktzfGfDHCoXG8P5o?=
 =?us-ascii?Q?CXvwIBQYPZ2YVwVbajP5XeZz/gkHLD76GoKyB37EO4JP57UXoHSQLzsg2+4v?=
 =?us-ascii?Q?xHkxZASFjCSyZ+yt6BpdrbHAK+Ol+m9gj7mULrTaI9tp+OPATyiQdncwe1Zk?=
 =?us-ascii?Q?EVUgg2TyqzJvOz1qiFiv3ixmqj2wEiZHAM3oidTL025MYIbDgujJxx+RQgBy?=
 =?us-ascii?Q?Zfipnpe7XiiADWGVGmb1/Sgb6DB1of3Jxnzg4FkWEWTxPLpys4IdalteCaPd?=
 =?us-ascii?Q?fzrKbVUt0VVSr2cR7ejioD8d6UzMtMeeEbLoUWhll74vlrtiCYhKPU28E59B?=
 =?us-ascii?Q?O5FpbWx/HZbdi/dCzKTGSAhhOtpynM/J9t64qS6nkHtt05mRjtkfha6eMpiw?=
 =?us-ascii?Q?4WZtbmWFIGCDVxHqwtXK0MVKcQbLb2cf17Jo0ztWBqFmKeoPjfqZugFirPPF?=
 =?us-ascii?Q?+K63qIHxfztHoZVhRNjprdEYk7S/c+FEcW2+9oVN1wqY6F7m82eyIuCgplBL?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bRusGkrG6N8K5jY7UY+i5VEiGQLjhC3HHrYTbLSrWgu3kNANJaan6x6GWlnhThLzoqdNeeHGkEK/P2knu4HFNs1Q8IwPrz0ZOhi9/q8YaP03kcep+Y3OAheHLAnt8yGazz8EtmTTTw6scTNuxyO8aID7luejCmSL3A4JJIvMmhsvNC7wJEuYK4jtxrRrsVoB4ViPS9yS9Ma2sV7kx9OHdo4gSl2QjuK5klOKC3wY+MxyRtoVet1Yq8YMZ0abfa2ArWF2zGHEZJl08l2b2LAOh4ROuOuDW3BUQKdf0debs46ZPjMkg697Y2SCc6yAC2cEKXjZNQMyT46vIn2j2IMYGoA0+Gd8mCrOjNB9kljR8cPWP5XETvJFZx998cKrcaGsyDKq6IvWOvJ09q9NBzk13j0JA22V0Iy5NHSodQjLXiUbj8r27vBDtbR3pcoe0M6rEC4oH/FCqNAMjgMBOb+a0k613gjfegv+eAWnrIW0IVNUY3DwBY16Ws2+usgerecL6yE+PNe4f9Wc8qlAdDJA4Igyu92rLv6TWWuibkvreU7e0lUJ/2q3wY1keW7gsYNPBU592oM75TlxNG/gEvzcpxfGzgZjQnrh5VKRzdJqmuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64578665-7898-4e6f-b632-08dcb2477244
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:51.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sctp/MtCh/rgFhTIB8P0fzVLqnVZ0f7yd+LijaH0SJnMbk5y1noA+4VjXxHUMfczwodk6M7Lh5hzQw+OmuTREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: s_8WxhqaUvHJKosUaJgp5Cv4XriYZDEo
X-Proofpoint-ORIG-GUID: s_8WxhqaUvHJKosUaJgp5Cv4XriYZDEo

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  7 +++++--
 fs/xfs/xfs_inode.c     | 14 ++++++++++++++
 fs/xfs/xfs_inode.h     |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fe2e2c930975..60389ac8bd45 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -496,6 +496,7 @@ xfs_can_free_eofblocks(
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		end_fsb;
 	xfs_fileoff_t		last_fsb;
+	xfs_fileoff_t		dummy_fsb;
 	int			nimaps = 1;
 	int			error;
 
@@ -537,8 +538,10 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (xfs_inode_has_bigrtalloc(ip))
-		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
+	/* Only try to free beyond the allocation unit that crosses EOF */
+	xfs_roundout_to_alloc_fsbsize(ip, &dummy_fsb, &end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5af12f35062d..d765dedebc15 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3129,6 +3129,20 @@ xfs_inode_alloc_unitsize(
 	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
 }
 
+void
+xfs_roundout_to_alloc_fsbsize(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*start,
+	xfs_fileoff_t		*end)
+{
+	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
+
+	if (blocks == 1)
+		return;
+	*start = rounddown_64(*start, blocks);
+	*end = roundup_64(*end, blocks);
+}
+
 /* Should we always be using copy on write for file writes? */
 bool
 xfs_is_always_cow_inode(
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 158afad8c7a4..7f86c4781bd8 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -643,6 +643,8 @@ void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
 unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
+void xfs_roundout_to_alloc_fsbsize(struct xfs_inode *ip,
+		xfs_fileoff_t *start, xfs_fileoff_t *end);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
-- 
2.31.1


