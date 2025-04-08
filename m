Return-Path: <linux-fsdevel+bounces-45958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64BA7FCA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A82816772C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9426A1D4;
	Tue,  8 Apr 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AgeSSqP0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pzIm5F7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF226A0DD;
	Tue,  8 Apr 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108988; cv=fail; b=Qn0BO7TV0hdGJVwkbmhknKVUd2jMNW189okkelGkLuAErQq2fwO+AnhutwI7prgiuPvRLQJJ2a06JBW/mjq/ej4xkdddRNcu4U0zC0ZXdVumUjhCtxbf1GBMOrlu8ypgKwp5+Nla69v7S6dyHU+kvd48SMZR+rHytnK/2YPTT2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108988; c=relaxed/simple;
	bh=Ma2jTPnf3reRU8K4xdK3InXuGQGQ3bi+l9Jc38Nl9Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/P/+TJD59cI0326B/hjctOL+Q/Z6BVUKJ5n/ceXJUyzJ53vZNz5/9VgNs8AAz8CNX4ehvCguYfrC/1h7tZ1VdDipmcKsjVg7rZYhKd6r1QZELlwsAQ9o1VSbAbgo5LRmB9/ZKB3bFpO1+wxPHStGOvD2UqXknXk9Wbv90KX7fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AgeSSqP0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pzIm5F7c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381uUas008022;
	Tue, 8 Apr 2025 10:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WopXgF8hk2pX3KSABAZDI8azfuEquV/UZ7Q8QMjPJjI=; b=
	AgeSSqP0aUKg14VdKYmeyduuHSzIHEBzll15QsKecLcuEr7E6OfBssa5ftLNmcPH
	EunF0g+QQSoAKTF2Rh1EZF8+etFAEglyLQl/BS4Joy6z8SzRBdOXbZe6/yLhWn5r
	GWvv8ekPU2rOuoKvUDKzN5AgnejSzRNW6OAInJBMljjXrGQ038rcDJATAx+EG0FH
	gPcKaL33bzPXJlZ4GF5u4D9amHqH5rBNgGAgpXR7aQbbnk9GK7I5pjMriCODzRGA
	gQlFzDHk6w3PHqZFOg1O69FXkBz35OYtG4BMKmY9QonK9EexFQ22dis9oBpfPixQ
	Az1ouNasWtJ9YKbdhwL8ww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4svfxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389UL2d023953;
	Tue, 8 Apr 2025 10:42:53 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013062.outbound.protection.outlook.com [40.93.20.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfc30y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj6u2QecTeNh9MPvvuxdVo5Cw8jVTMliXxe0ny6eQZFM8S+q9Q5+7XOJxjRKLOXccZNqk0pY8Ev3ECDxZYgsw4MPHjyPtQ2QkttDi8Z1RYhH4jYt4b62SR83o7y4XoDSjTPNwQLHI1h67A013bMQ00+mKvij8VufIh1pvNXTkFprTn55BzCmsfmUtlQTKjd9NJoe1l5ptmyEklYAcMxo8r1/iCTNQ49Cl2oEe1ihlMclGBIGsvWH7NeEbWhaoITrMebCJbpk5zGCMFbdZNMiBILS2JpMKCl7m79FJDr/oXpv0Hdb7gzvswDwuRpOjtxvra4uGZZcMmJ7qQpVB3iSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WopXgF8hk2pX3KSABAZDI8azfuEquV/UZ7Q8QMjPJjI=;
 b=wuPSDDe63dhzr3RH44LcEO+3NLZMq0+8eTmlmAe/jy8addOouXn3hRsoN9HRQQFx6bYL1O08xCU0Mg8zkmlt13rMyssUyrmGNSbEVOL9lE3RymZtChjeOE0bLbut4NtFt10lC6hYVrjoET0cN5OjtKkZiE71pBzg5xdjk3+Rywd+t8BvTIlO/Mm/kkCFy685d/qMY6Av+g2SbJPsCnbde5tmrenYhqfl6JMx/9TsbNo9EmhnoY77oitjyxw5PYROdaVTwShC0qK/ulophGdacODORc1OWEgZ7sLBYEFwE+DSPz9UMjDSMeuwANIvtQCpRsNGjtgcV1uGL4FvCsJ4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WopXgF8hk2pX3KSABAZDI8azfuEquV/UZ7Q8QMjPJjI=;
 b=pzIm5F7chc+TwED4J7pRSEzX0yDsM9B8AxfuIeleVU0VcbTlqQOAEJy3ZHsXbz1hYrs6VMuUg/F7eiLLcJAiyQw/GwK7MdYqlKLXuq0hw+w/fISBoXywbd89bKxJOzqbhErkgNC78iAVJf6W9RlBuLelMiQzoRd71QsiUHPyyEk=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:42:51 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 10/12] xfs: add xfs_file_dio_write_atomic()
Date: Tue,  8 Apr 2025 10:42:07 +0000
Message-Id: <20250408104209.1852036-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250408104209.1852036-1-john.g.garry@oracle.com>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:207:3d::44) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: c475be29-d97e-4d20-7a85-08dd768a1c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NoasFb6UCmmi8yYbAds87cnoGxr3Ee/XQ9iI190LED4MlGddQC3BsJiA2fD?=
 =?us-ascii?Q?peqAeq5ayQghEcELWJYdBc9WltUw9pckTiBt8sd4iqvmysf6AiM/RZ2N+c7h?=
 =?us-ascii?Q?Ck1LfXwMqboFmcIsGmvtLO0kkRBXt6WfnzjQJMEQn8tJOKZZyxzORdziV/Wh?=
 =?us-ascii?Q?gvtyVW7NCF/H9jPKkv+aBhp7CKZWGnvImtTQY8YpaaCaBJHxR5RjeDhH41u4?=
 =?us-ascii?Q?MW6U/1k6Sxy/A9xz8VB3nUdh6DfXlxlzNKthaP1/1zEOqqHMgJN2dGOPdhBG?=
 =?us-ascii?Q?rj05yQa1X8L12wvjLaGYag1a/yokslHfQ9eILUmiyMfNXSPcUD6kDfAsmQko?=
 =?us-ascii?Q?4EK0Au+xBuRQW1j/6ghk4AcbaC4QZxpC04YrPGVeJfDdY9mox7BUewEubolN?=
 =?us-ascii?Q?gvHvW34nlUZhsWCmJzrEqrwxxLIYJ89XX2gAlT4LEkHeEqzXzzhkGZRzvXvw?=
 =?us-ascii?Q?WtlYYsGzOgfxjz6stEFVkWDHPFA24p8g70NymXrJqUeGTZYRmT4rd1sSPZBp?=
 =?us-ascii?Q?xKLLOfCddYvQQFNsq92FAqzHGXENrRh0OxDSsDimkvlfyq1F+dvHcwy25j36?=
 =?us-ascii?Q?vp/BeFrVaZoMPQcUArPJoQSG+wgf+lJvBBbzH3cjeNtd/yHTSonNOH9HKfAO?=
 =?us-ascii?Q?wPSloJ+VPMSsXNyTL9SY5ibfUBDSMIteiua3yIpvvPdg30lpNISZzqPz6mF/?=
 =?us-ascii?Q?aLZCte9vqGyfY8aXtlWGr0UO4Ibn33QB5HZgP6DKp0mEB3VP2T8KhzbdQ1ga?=
 =?us-ascii?Q?0zWhpNnLfKWeqlBFomHiYou4DLYjr7RYPBg4jYCkJVqWFLApHimUCGuQMv1J?=
 =?us-ascii?Q?h4jCA2v+GHh+0jJeTHfRDtZ+v0iH8e0EzErTsFnqayDwdMBZwTNFLr3c7frb?=
 =?us-ascii?Q?yGpHSOCmdgneIj5kbmxdi7+v6aHuHIyqnnkSS0T8B96mOkeSS11FA5fEM/Uv?=
 =?us-ascii?Q?kTiFZ60nDllVzdh4KBgfT4qG4jLhCzyxlI6AW7TuFzGHXiJJLC9ojVrx48WQ?=
 =?us-ascii?Q?1a66yYvJkfoqZNpSDwnXlDCTHN6lx1G3t+5KKfcnPuCU3cyAkSLG7onqgFCM?=
 =?us-ascii?Q?6Tg7kEKW7zXd9PEOg1TFFl5/TVMT79XjDZcFndBz9sckRQWhsB1POf5nV6MG?=
 =?us-ascii?Q?7YhUwz56ygMzQcNvCOCw0IjfztcaQWdVhUYzdPvhVcwuE6j05nHxLjiVDxrR?=
 =?us-ascii?Q?U1gO11aQVBSGqL5QWbOxKvRvrr7QEslIMv0rUaLqJ+qZqKBgFNJnCCVMNRaY?=
 =?us-ascii?Q?59ASb3i3Nfk2XkzSIJ3b956ir7ufkRKH/RB2phLynTs9a94Razawa5qbKGJm?=
 =?us-ascii?Q?+t2xJZjlkbbgiyRQiYkXeSCphMxN9sX22AA/8XaXya6rSE7DaRyyw+YeDlzW?=
 =?us-ascii?Q?4gCPU/CxNvXSvKL701lcTBQsucbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/BkEtaH6TN3TipkHduwT44mjdizIMZJoo2BmsRKhRmPGx73lxFOhTnt0gUSA?=
 =?us-ascii?Q?67oJzMlIhkCAlyeyY5B/mm0BuBBz1m0TmIY1PpSX+gCsZIsuqp2NjwJhX9Nm?=
 =?us-ascii?Q?n0+TvFINkyqKS2ONr8T7nKjORSj56WJ4gMN+L1VndoCPoFk8KfSNWq0QMoo0?=
 =?us-ascii?Q?5fCuAB1u8860ICUkwAlNpOWuQqkN5BCN6PFqh9dBKmL2AKZ2jy08yxqpl0O1?=
 =?us-ascii?Q?fWAbq/oQIFAyjeoDLvYksQ6zF+floP7zaErQDz8YtrnMt/UblmLd6aKLHHC4?=
 =?us-ascii?Q?eVjndDcuAuiFiglLzPMKXUuqofmHci+VuLd/r/dyVqVJ4x8iR2S1MzlH0DWz?=
 =?us-ascii?Q?RiAI94S9aoL++Q3iUBPpAvGrmvzyI1gdpm1A8XRqPE/gyE4FbfnqPJRUR9xr?=
 =?us-ascii?Q?Qk6VrcxC5j3y/AlQDLt/R7vEcEaXmNyEhbNjo2dtVZv43xqi21/YatILD4Z2?=
 =?us-ascii?Q?brNp50TozR7pdbI9aKYsr7LWKTrTBQmBzxDTyR9tgD9PtuWFkgsokY4Qv7xh?=
 =?us-ascii?Q?6ohH+734pS5LDpQUsT+On07R4oYg01lFAKmja/6iPhdw76cbP3WHc1WcVY9t?=
 =?us-ascii?Q?tu5sxtUo+Hyh/R7k0DlhV7sgWSmDKs+o7hfEczT03bCoXBktUJd5ZQoeGYvs?=
 =?us-ascii?Q?XuYJM/TBGtMByTlYbxWns+R8Rx0Cnmij5mxu4usJn1P+1SNFQKRpM8hGc3Yk?=
 =?us-ascii?Q?k5TCzaaGgCN29Zf3lIZuwEWCyLQZ4AuUgj0uKmAmbq7S0azOdT2nv8ErRTfn?=
 =?us-ascii?Q?YPhSMlQjUZJuQhubk+t9gpci5Qku3v9A2j9DCiw2Xe4cxIQP+AJnOiiZYDSw?=
 =?us-ascii?Q?auoP8EjEjTPxkP6ldRVS7uyXa5M7tPq9UoFZqGDVumIyAASjpfACwvq47iEN?=
 =?us-ascii?Q?lyFICGzW+QcLurp+jvOeH20RnpvmyH4Ht5j8xBI0Zk1vA12tnI5eyEQiltqK?=
 =?us-ascii?Q?k9hY073sQLooiSFxW/0pY3LGtB4Ay8unsBjnl56oDmIk+zZeGjVxEnRV7Z5j?=
 =?us-ascii?Q?0VwvWyCSqG2oPoS+M7kJaljUyjDt1ZDDyQ0x+4Ux7QKo8sTjVgyQxoYug75K?=
 =?us-ascii?Q?I5E6cvHZTrqSyriSwbCzOCqVD5IPVpyDFS9ILR85ejdH1bD4bnNDJFcezcNq?=
 =?us-ascii?Q?xvWK1iLAj2E910x27J8HuOcyazQ8WnAtb5aUPB9bUHC4pIdrMsTzG8Ri8nlj?=
 =?us-ascii?Q?fxqWide7VfJkpG0lPAJa6x6tjs0pTdjVqnQkdQlO4Epy6B5+sHwH+PRefom1?=
 =?us-ascii?Q?jNQNTiKyZAUQ9t28FuM/mTMvJxnoHaqFylzzN3HJwbXc+3H8VooXmVMqs9tc?=
 =?us-ascii?Q?dmu484/AB47fAvGXYT5pJh32w0BV4PazFPNe7NV0Gr+YKGqky/96vZ/U5CWc?=
 =?us-ascii?Q?TOTtU6DR2evSXmzGGfBhgNzIPKXdMLQRE692s6v7cPdgbVzTOhBy2J+BZBUN?=
 =?us-ascii?Q?5uQB5rj/dQddUHpPrRVVYIXbRiJAIw+BDOfCdrG6DVi9zVyzqS5Q9HK3uNc3?=
 =?us-ascii?Q?yq3QRm78axMW8xc2tqeYlV4CiZeI+1YeEmrcLfiZWiTaySlExoRXCElHGFvE?=
 =?us-ascii?Q?hT4FVRgu39dNwpFid7zTKDD3qybiBZSSRkqKrkq4NSo4ssHmHWz3dNrxbVRS?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MCqO2TkOak8os9UTJptg5NJJ9Xpfk3pQVJ33vwEGw5vb81P3otASq+vJultJrOkDBc+48ZxTIUd1ElXsHPJLNZG3SD3IqloTPRnEh9+xZFAQz649DGcu3Z/d2UAB7lso8Uy/3p2mjd6+zkf+U0tHT77N3OTAs3aWwmlhSWg68Sg81h0QIDZRFBPfGOQzf5oHG14ibNMq75P4GuCNvuFxcFwnoQw6P6XXeQ/RxRTeZWQjIV23E7sEWnbCmfYWr/rq7TgQenNJIyy6xUiYtA6xv68u2Wiehi0ZlalP+a033wx3yEZlNB5zwFY5Jjflzni2P+KX+TM9iSU4ymNuF4MmMwTLq5sL+Jked2cJV9LOpLkksuBq8noI7ams5rw6WdYiER2UqyQtX2M14nmCnJamO082N5vWceI02tABLAQRWvhMLAmsQzCLG3NsCzOgHpg2ymtrD1hP+afuVYxD5Gryg4MlEw2dTdclE2qLad7gv1oHiFRsi5mtRgV5ZAlyBr/d1iiz+HqnR4hw4V2lqb4uiMtcN0Zj9bTBXoNpoNOIJwc+FkEkQ9FXkYiWJigqILvyxw/UkJ+Foy3yVlRKHYq1owX7LdwyWEoRorBfT4pgChM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c475be29-d97e-4d20-7a85-08dd768a1c73
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:51.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAM888bRvIsGRAVgewHp5nCQjnvmEU5uH3fh877XvabJ1d1/7PkUr1pVOEyxYdZpYaH2Orw+wEu0ZS4Cbg+kkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504080076
X-Proofpoint-ORIG-GUID: SQKtiZiEbWzh2JaZ5geZzMPeDVa4OXBm
X-Proofpoint-GUID: SQKtiZiEbWzh2JaZ5geZzMPeDVa4OXBm

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

The function works based on two operating modes:
- HW offload, i.e. REQ_ATOMIC-based
- CoW based with out-of-places write and atomic extent remapping

The preferred method is HW offload as it will be faster. If HW offload is
not possible, then we fallback to the CoW-based method.

HW offload would not be possible for the write length exceeding the HW
offload limit, the write spanning multiple extents, unaligned disk blocks,
etc.

Apart from the write exceeding the HW offload limit, other conditions for
HW offload can only be detected in the iomap handling for the write. As
such, we use a fallback method to issue the write if we detect in the
->iomap_begin() handler that HW offload is not possible. Special code
-ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload
not possible.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ba4b02abc6e4..81a377f65aa3 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -728,6 +728,72 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+/*
+ * Handle block atomic writes
+ *
+ * Two methods of atomic writes are supported:
+ * - REQ_ATOMIC-based, which would typically use some form of HW offload in the
+ *   disk
+ * - COW-based, which uses a COW fork as a staging extent for data updates
+ *   before atomically updating extent mappings for the range being written
+ *
+ */
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	ssize_t			ret, ocount = iov_iter_count(from);
+	const struct iomap_ops	*dops;
+
+	/*
+	 * HW offload should be faster, so try that first if it is already
+	 * known that the write length is not too large.
+	 */
+	if (ocount > xfs_inode_buftarg(ip)->bt_bdev_awu_max)
+		dops = &xfs_atomic_write_cow_iomap_ops;
+	else
+		dops = &xfs_direct_write_iomap_ops;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	/* Demote similar to xfs_file_dio_write_aligned() */
+	if (iolock == XFS_IOLOCK_EXCL) {
+		xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
+		iolock = XFS_IOLOCK_SHARED;
+	}
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
+			0, NULL, 0);
+
+	/*
+	 * The retry mechanism is based on the ->iomap_begin method returning
+	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
+	 * possible. The REQ_ATOMIC-based method typically not be possible if
+	 * the write spans multiple extents or the disk blocks are misaligned.
+	 */
+	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
+		xfs_iunlock(ip, iolock);
+		dops = &xfs_atomic_write_cow_iomap_ops;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -843,6 +909,8 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


