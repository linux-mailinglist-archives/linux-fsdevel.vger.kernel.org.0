Return-Path: <linux-fsdevel+bounces-41646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53836A340F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD92A7A3B7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544042222A6;
	Thu, 13 Feb 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B79KlAZZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CGTtVJZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B070830;
	Thu, 13 Feb 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455037; cv=fail; b=ANb8dubapV8ooDaM9aotdvPHnmXY+MR5EhBGzWrvg2Mr6PTTR6vGLjtQIFUQcZwxt+QDqQZpgjRCitANK/A8fHT/NVxENyqnXtGvvJVNz+Wn6xDINFOEdkCNNXkzjTBk6ZY1xwc5K6/e5FpZFJqjROpoUEZWOgBAuM5hTuQi1yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455037; c=relaxed/simple;
	bh=cA+6cKCUa+oKyLLaeYC1SnyNejk09OF6kD+c8BXxiOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jDkAJhfSleGrwLKMkedg5VLnPXJNzg0oNeIZ+4NYVxpfVO/mSPU3PX+fq269wIIDb2n1wFRW8SBrTWduHFloVlufq1UZiRjd+afaAx2TxXaHIR97AAd5ocKFeqAEifaY9TmbN1Qr8jaWzWSCFfhM9ehCU9qFtSd2Qjo+twl5bwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B79KlAZZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CGTtVJZP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fWUF001449;
	Thu, 13 Feb 2025 13:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=PRAegJtvrRpjG4kn
	7jUWLla5Rau9qmB/jmrEsQSlozE=; b=B79KlAZZf5f9VV0r4Lsx2Wb59GdPB0Qo
	zM2zd+5Y+j3gjTi+QWw2aUyUwynaTyOT+M1RGHCZsBVuSLSMBS77LpK4XCY44yx8
	KK5Hmurb+i6M8LE7ytVARroiXLYqw5+S4mAdxSYvM0h61GXNnzsctAlUO2Cydjsr
	6K7ttgxtw0jTnlR9o4Ohz337Vu/OsxJ4Mr/wmFY0kvTiM3EU5T1uU0Hi7OwU3rPH
	ZJuTccdkIezfNGNfxFZkkocqQW4C0/v4o+1yXX7tN6NhhDaHy93ile4nkI+AdQ2e
	H9teb+Y1OyPmdZPx4CQrTr0+k1ronuDGhLjiLfy3LoIFuewSUaZaSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qahk0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCSMVY026996;
	Thu, 13 Feb 2025 13:57:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbpr75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbo3fG8Oebkqv57BeBM1e3Zx3iWUhBu0dsZgW8gOA7PNIVOWiuy+oiztq1utfmk7UmyYXQ9AevZPYa4NeTnz8B/NousEQnwT05XrU90lWGXWnlUDxr5AkR3cLc1tJmKQzM9j509cvf3x+zCrHdkdfY8DjDGNJZuRk/Hc2oC6ANCHPPEOPaFEAB7ZyIq3zIQvhkin+pnr0UbhSzZdWnKNjBFHjnixKU8ZVgzGljuxVVUz5GvzN2ZWuHyldgKR8bc8GEFY74fENQ6CMaFqLN40R4dEqhJSVC6QtSo81IL1lpaz60Qbab5fn0tBffB64W3cPOzB0T3LLRPgEpvyb/Nljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRAegJtvrRpjG4kn7jUWLla5Rau9qmB/jmrEsQSlozE=;
 b=kHzOhGhBMfTyp/fV7TVAPGNf78pOLv/fdPonphV9zauf1QHV+O/ntOLR7Fn3LH9fG+VN/SGgnpoduUhavZb1L8L0kNrH7cWAb9xu1/w8rB11iZ48b08UI54LDLgOdUVdjKRdtuOvJPd4gqKZdZ1amhmN4FOiW91H1ok4HVjMkZdCO31pbyP9BHYX+21X2uBVm39onOEncPq0ZYFaWRpFXbekam0BJWvolhTnkK8+UWne2zyLhTeqSqD1gh5HYICqtUUy3WVUcvzuLCAVPSybrsHwjTV4taG/r40yyy0JIOjed4Jjq2y1RHBHWvOwIXMpczQxBTJG3M7FeMqtAWjrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRAegJtvrRpjG4kn7jUWLla5Rau9qmB/jmrEsQSlozE=;
 b=CGTtVJZPs146WfR75qVdiRLJUYHYVImkTt/CEaxbs941/AwMnBfg2z3N1jBgjoBRhK4UqJDxooWlw3qE/VI5Ph3xiLn1NxhLm5gLe0nU5FRHx4hMIurypyFMwoIWjSHqeoNAm4/y5Yt7r63D4fzYfyjPQPTfMEtOseQ/xYmy5zM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/11] large atomic writes for xfs with CoW
Date: Thu, 13 Feb 2025 13:56:08 +0000
Message-Id: <20250213135619.1148432-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 787dc5e1-0708-481b-02f4-08dd4c364961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yibRh/b97JU3Caflu1L6ZSjXlOeN6pn4msenOXHy3sVTdn0fkNZSnErN/jWj?=
 =?us-ascii?Q?RSN+ABreN4Ccr7j6YdnxhIx86c7r6o9WkjHR5RnhaQ/VdLIwpOTQfCDPiiSY?=
 =?us-ascii?Q?MFnjBvAGONmTNf8VxBFY4bbxzFl5Z/7hh7UsQXMqh/IRM5KSAtYH1M8pmB3Y?=
 =?us-ascii?Q?t7m3qMqV7Q74Bni+1xUWY4cfKp9y4RXzlSCVZZH3eyjrkuyxAYeCBit3nfOM?=
 =?us-ascii?Q?beLfqmSclD2AmrAEqZ81K6xadOYY2oGZvHGDS4CpkSQvf83ysUZlhmonr5ZP?=
 =?us-ascii?Q?YpkrCAvQW2iot9xuphtGI+HlzK4WS32j8WtFQ4qLIjRPyuAKXgDDXkx6nhux?=
 =?us-ascii?Q?KKsaKmEf4BIfyaMVFOv6ASg4vIXjqqbk4rJxIs633ReItRap69+O3fhVbovq?=
 =?us-ascii?Q?vmZfAJCO5CxUi9TeHx5BHPrZ5nZjOsNiL9pnrm3bPMIj4a7Soama9gvG9Xpm?=
 =?us-ascii?Q?BrAAwFuvhmyDqzNE02o4aHsaYadX1CDlKKkvWl4wH0k7/nJbuA/rEZyBxksn?=
 =?us-ascii?Q?FUm5ynSBJnvOpaT1798xleRx0RlmfbbLXtF0T8OaiZmyejkbdgIDaOTA8vzQ?=
 =?us-ascii?Q?Y1+r0LzfHkZlYqO8OvWsQ8fRGjmXDLTT2AH7J7zmz8/KbFy9tRwfLT3PgEoz?=
 =?us-ascii?Q?Ig2PjUmyYbzMBtz/lwD7Y4EFbm7gZfPDS2Zi0xF91WlVrnkLycEzNrZLyDts?=
 =?us-ascii?Q?UznwPlJTcrvaALdMcDdInorNQJ/KgjWguK7kINY0vQZXj2VNqS/9B/PuVZ2q?=
 =?us-ascii?Q?pfzOGgOLtLO/XcoTc5lDxjLNXLgaI+/jq9B6DACUKAGkjSLLUj20guVkuJKc?=
 =?us-ascii?Q?6VOton+B/LtS8y3WBaJLE4iRK4J2SwlPJtHyJAN+ihoHsozCLDvYFlexnkJX?=
 =?us-ascii?Q?xoi5J9kltMSUttxAr4hzhzCXbmomz53BEuk759X1lMOHWw2UrcK3F/ZFNibI?=
 =?us-ascii?Q?4M+jJEh4xxWThD9jKQAQkpCBD8i+pLolDz/0q2d3fwipGTO4mLAIDwr4ZrY4?=
 =?us-ascii?Q?quQ/bEn4OjYDk/YYge4YQxKNFIXU3Ho9YxIAfdVKXurUOlJ4/OLKzvhMSr8a?=
 =?us-ascii?Q?ID1aVfc0PYAELtAcqjrd8PJ/1W5rBek+qZ22evS86z1Swh66GNHnmfFeD06x?=
 =?us-ascii?Q?KayuP+6k3oFdtkpKQ5kNZkog3PC68GPIvszRNWIHNNC9pjhuJ3vwwrn1iLdR?=
 =?us-ascii?Q?GW2cLvSwmoB7wO6evmEgAE0KPmskmXz+kWue2qtxYCork6EG6uU+gTR3AuKZ?=
 =?us-ascii?Q?U1u4Tob+uBcCP8IFhlcsDHRvDS2H5XyMXJSFdETW1MyxS3vyiVBs6VZ/XE/3?=
 =?us-ascii?Q?jQMCeIx9wL9xflQNM2uPqDK0hd+G1OAmQzp/1awpAZ89GEE9pmIp3pSKb9FR?=
 =?us-ascii?Q?mHIzf18iSwtz3jz/y/H1rri8w+qL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?28WJU+F8hItJb2VTvHrq6fbhTwoDKJsZa4HNgFe2larLCFNTUOEp79ICtpe3?=
 =?us-ascii?Q?W0J9kE9suxZxDleMNjpLGeSq1ze/n7BtA6J3jcJZYVeG6aX4dL14L4O+s199?=
 =?us-ascii?Q?v5n4TAmJZsNiSnHrfSDVVEFQNTb4WvQDGN84Ia5R7mbsRnAhMcuZX9/WNaov?=
 =?us-ascii?Q?rUqRhysP6vV6E0hFdvda7NTRD9Ocq97ARERDmeelb4HXktYjLUb7T2badd6q?=
 =?us-ascii?Q?AEuEt2CVL2XursB4ojedo62DLt90dc002m8FowNidWMAixg/+7DqVumHnR83?=
 =?us-ascii?Q?4k6uYRuFX5Cq0UwBmkrkbRnHrIEfJo3WCuh0Vbepe9wuAQDQz5ckUj7draeH?=
 =?us-ascii?Q?x64tL/EpygqToJCcL6G8OI47fAkyMNSJALrXI7S7OlRQ9IRqAtRJJO2NQVJw?=
 =?us-ascii?Q?nr8mlFA5pEo3JZGb2GzDdyEPzb0/4KQyBZLctr9+SHgn5wHreI7ktt6ZasT6?=
 =?us-ascii?Q?nNfJ54Iatg/VRXrGdvVL6XJ3gk2Xlq3D0LeYHQiSyoUeTwKUnb6/WP4XgGjJ?=
 =?us-ascii?Q?+0AsF2ICRVBx8xGTHIdBLfBN9r1jykwvdsE6JI3jAlO7v37wK2BCqYomwRfx?=
 =?us-ascii?Q?wy0zzg6v3n8Gbg6yerDCeLkaSTmArzfaTMJFCDp9xcvqnnBjowww6POzA2TC?=
 =?us-ascii?Q?RGZ1KXN2mZZP3qeWwc49i1oUm+zZ6AxuNEJ1785PBxAGE6w/gvcvPF7gp/CM?=
 =?us-ascii?Q?w/T/KVdjtCj90LQHlL1OPF5L9V28ZPDHA68qEwR6ftdxsQEiLhG1XC89jlD/?=
 =?us-ascii?Q?KFUnM3v0Wx3LDjUXqmxV47BPFrrhmSHzzk3kAaRuhSLu/akKU+HCQcF4AMeg?=
 =?us-ascii?Q?txvs7vq3jk3icy2CamUiTztJUSHtx8cY9WjPPydg9HEWfs6aYLHvGJ2xbWXG?=
 =?us-ascii?Q?JbxapmUcg7Qy1rJGkWvArK1yOw3HC+Fyp4l+HCh9DkLAmZU9/muKC0e5AwY2?=
 =?us-ascii?Q?1tANsK/Rt3zWSwtHux4eLefn3fg95e616jYyxIBmRYW8CqLoPGqhiY5F1biY?=
 =?us-ascii?Q?5VjGn5NyQMPLJfri09mzfFp3DxY1eP9wcoPukvf/dyz6gCD4stBuo++F5wH7?=
 =?us-ascii?Q?Po54oHxRKb9JvJNnrhfYiV1Xp2FLzSQl2d3IzJrYoFJOmowDU5+h8q6AGD06?=
 =?us-ascii?Q?Bq7glNGgcxyAeJGnUKoXec2XS3DT5YOCaM86H3wHEt0mv+U5KEjth3nuzm+w?=
 =?us-ascii?Q?l/qj+KdKS2J1KP/erJVTmCRqgou9FKYMBYvTAXMDThVQbZdeitd5Zy5gVbk3?=
 =?us-ascii?Q?fYV5FizTAPyb8FRMXwmWy0+vKeS7FertYuE38ulpJ/oEkMyNOPcMVmIr7Lx9?=
 =?us-ascii?Q?4Wznw+KnomnM8sra5xF5lTqCsLm9s/4dF6b0IWbejqrAxmyLTcP+l1HxEccu?=
 =?us-ascii?Q?u91e16zKzgqx4YAkX+DPpJvSrF9ekx194Abo2w2E+aoUC5CYma+rosnsdbG8?=
 =?us-ascii?Q?P9SfynwJmNyD5VIMM2eCkDUawN26MHEQFD3NET9Ot0olDElOZmzixq8qPfh5?=
 =?us-ascii?Q?6xDiV6LJd5JC3Lwwr9hgn19ymRqZVINozN/7zIwaoFrJmv7DW4XS1lkrvITn?=
 =?us-ascii?Q?YxDeQT4kggAoBF/R5eDX9drbHBKbxcrqG5jT/E4zaL8bh5XywOfeoqxRG88f?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XmW+GRPEuIUOKVOwTjzPzUndfu1pwQwBglGzEF2aYH17cLdUEdU7+lLot9Nn5ZdVu4Z4iXm3oKhDLNvLtYvkVdb3tojiRhg8OrrUMi1fRZIAgnfIkDGWlH4XGOUiEjjBtqlvmp6i1sQfqhSlV7KUKD7Xr5Ygg93J2i1XlOxnhmRW3amCpomK3apjgibGN3NcF9CKUA6THXlUdcDynHWY6I+4yy31onMX19if/TKqSyMwcArn7VlojveQllb0S/DTNV/hJzXY2QXXGc0GoThiBPB/ZdgMiCd+x1+zGuRGJO7D+xHR75J2/mvX7HlwRrHGQQ7fjN/HtjyFQDXPYQqmecPjDAfSCI7Zga9+86IerA/9Arynn11yLt27ZM0l5Y3hqQP5DihzyqwjJnbGSgFlSWSTTjW2IRXm2d0c2VGif/5DCeo8MYZusdc+e1yxdkKHUkpQd9AEWCCQdR8zB4BhIxpSkbEQeByzjeZ2eGDN4334vRo4b2SViVUyqz73EXylny334wOZph6Sm7eS29FCxDkyBQhijbuPfiyS1VlGqr/4i73edoYz8peO8IEkx9VLBFsSQ3KqZqEQmNrz3enl0wBTjmIR7U5muBiB0HY45pE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787dc5e1-0708-481b-02f4-08dd4c364961
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:00.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6pLgEUYTSUJZzOImYXzw1+NLMv3O0RnOQedZuD5yKU0rIvy6YSs9TvCoMtWIdLz5asoZwSnrPLwLCYJ9x0n9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: IfqrH43iy8kmbTzA_M44fy3T_XhByxtE
X-Proofpoint-ORIG-GUID: IfqrH43iy8kmbTzA_M44fy3T_XhByxtE

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on 35010cc72acc (xfs/next-rc) xfs: flush inodegc before swapon

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to RFC:
- Rework CoW alloc method
- Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
- Rework transaction commit func args
- Chaneg resblks size for transaction commit
- Rename BMAPI extszhint align flag

John Garry (10):
  iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Refactor xfs_reflink_end_cow_extent()
  iomap: Support CoW-based atomic writes
  xfs: Reflink CoW-based atomic write support
  xfs: iomap CoW-based atomic write support
  xfs: Add xfs_file_dio_write_atomic()
  xfs: Commit CoW-based atomic writes atomically
  xfs: Update atomic write max size
  xfs: Allow block allocator to take an alignment hint

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 .../filesystems/iomap/operations.rst          |  19 ++-
 fs/ext4/inode.c                               |   2 +-
 fs/iomap/direct-io.c                          |  20 +--
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/libxfs/xfs_bmap.c                      |   7 +-
 fs/xfs/libxfs/xfs_bmap.h                      |   6 +-
 fs/xfs/xfs_file.c                             |  59 +++++++-
 fs/xfs/xfs_iomap.c                            |  74 +++++++++-
 fs/xfs/xfs_iops.c                             |  31 +++-
 fs/xfs/xfs_iops.h                             |   2 +
 fs/xfs/xfs_mount.c                            |  28 ++++
 fs/xfs/xfs_mount.h                            |   1 +
 fs/xfs/xfs_reflink.c                          | 138 +++++++++++++-----
 fs/xfs/xfs_reflink.h                          |   5 +-
 include/linux/iomap.h                         |   8 +-
 15 files changed, 331 insertions(+), 71 deletions(-)

-- 
2.31.1


