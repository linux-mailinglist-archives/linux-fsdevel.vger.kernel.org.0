Return-Path: <linux-fsdevel+bounces-47838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FCCAA61BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA144A24CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C521A428;
	Thu,  1 May 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YG83xLL8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VCS4qTTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFA211276;
	Thu,  1 May 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118724; cv=fail; b=rn2SCDHIryFhfyt1aw8v/z/TO2Tq83/EanE4k4lnurs3Vk0FFFWnD/eO9Mnb0yy/lK9cXPrZEJTwTfAtUdO5Q7RA3vV0k7YSy9YUK3oHyGbyqOKbgQlDxygV1zMcrHVPjAVip/DauvIlhNLcH9zXFt40HeTdkMBde933B4TMFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118724; c=relaxed/simple;
	bh=PogvYHawQBfcq1w0PK2woXDNT47UrFI/QCVV0ugEp20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmxkorqwHKwJEiL4skVX98pnCbno3xs9wc0nDI0uPAOtKMYPhK2CLdmsKfdU6W1E5JgHB5FUpGtM3iJshT4bj1caKpKeZUdg/towidLJWHVy/YpunxrxJzHQpXAcI+Kv0MEGDe1bxBWM0C9ZaQAuZ/Cnx7b2hVS/TmEZCHF6uTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YG83xLL8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VCS4qTTj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk2i4024245;
	Thu, 1 May 2025 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=; b=
	YG83xLL8c4nZeqdSG3zHu6IYyN5uCxtEO7lxCj+4ckGrwQHzs5i0oaWrQSGpXPbV
	XyjcIMab2+W+di6G72nIulJI6awRtrKbdxEebcUcLZ8lfIj50ogUdFZe7PtfhLjp
	aSmFsSYVOwFjDSoHmMK51p6Eyws7JvbfxKHiucsoHp0RuR8hDSypbYi0aY/tWT0p
	GDJtbJa8mzEDffmo9bhehFqZmaNPaZ13yQb4/DcS0kMg6/HoYc9ow7NkASChH5ip
	5dJhcZ0xNiBW5U/vk257F6fbRyEm7UKXGjvs6Qjye3ZahL4kEmBVLnqgL0a+WrFv
	x220by4TJI5AxkFxMKuldQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utbfb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541G2vGm011320;
	Thu, 1 May 2025 16:58:28 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxd9akw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr/+5U0HHWg2F/OCeQ4l1e/k9Y+z9jnK3D6yENl2ZI8VExKAuCIgxaBAqoJ/dJFCUxWtgM4/d3XxHyUGLz/HPQAP+TGIfRxgdEX862qHcNRPqySqnMU+F65TBd82P9s+UY4+XwzhQEgY3pEP9j3sEhmuHEf+7emDXMvYjN+WmBhJ77ad6J2NU85t8xrMc4XybLUTS8WJ7vhpWAEpRR1YenNrBVgavon6v+znqVO2XZ/wHWYPICkg/yi8ccyxz/Wixu2AZz+TuVgMj3QVBF3GMoBJClttBV9AeDGFSra6AmF3jlJzRXXBot2nwKxsRIAWlghhRSgHbgflF01AZvixOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=;
 b=LFcqFO1aDReqAjybVdz2DlYel+LO6lZlbOFczCAbOY5u9m4QNx/pN+ndyfxSJZMVbdOcONCSVZVz9fqh6a9PIhNJ7xo9JRU0shBEERFl4IPYJ184v7BRbnzmjHMdSOTjAR88mmmuilYPKw9U7LHtQYxDeG0pZGuY7wnHb09vuTY0ZDrwzqgqooUuCPc5rHK3fs+ckS8XRj7YPJGCdmTIleXX4V9GPhD1nyDJ8PwHxrwAg9Gsnp9Gx8KDCWdaavab9FPNvTvsuo4KoFL6+pc1olKI4ZUZOBwpeaG00HxWHmriD/QismgNCxcFVO6oUI9JOEbyeWIShA7JFPsI4rEUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=;
 b=VCS4qTTji0OSZ+BUClcRuOzc7gX4oSkO9+HHGAkGlypQv0yDH8IjW5tMqX3Nw/UF1Gn46t25lMi8uGyMyisMN1YVnAtkNjCz49LNhDq2WITWLMNELuuTockrFD+wM0GmXoKqwg1MuwvjeaCnqBjZw+U3lgBKBzv1XpcxlPv7J2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:53 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 04/15] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomic_write()
Date: Thu,  1 May 2025 16:57:22 +0000
Message-Id: <20250501165733.1025207-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f66911e-9228-4496-ea20-08dd88d1507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LqN0rd12B1rvZGNGVDMeqzdt6duwLsZR7c35bmZZpdXOKPRJzsd2Of69AVZP?=
 =?us-ascii?Q?7+zJ58a0BBaTNQLyqo/g2NB/YX1QAakei3NIRYsa3+9m3DvIXyEF+5Q0xRPP?=
 =?us-ascii?Q?uwmQLF3JOIhY+he6tv/zrXrhUJ3zaIUfOJQuTWxuj1WYuiKvD/JK1CGMRu/c?=
 =?us-ascii?Q?ptBDzPbzR0Ly23dqFxMsDykbVOMod3iTP7eZLK37yuZihkZ7xds3y/HtP1S5?=
 =?us-ascii?Q?IHf+yVhPymMN02beqG37mDdxcByjJKAIuij9Xmm2/t6akzeL1KH7y4QenRva?=
 =?us-ascii?Q?PkjmEYG71RYRQEVNAWjl9ouKsk4u4xMjkYjpk1fMSfHNOSVMPARer1Hg8KiW?=
 =?us-ascii?Q?BV+deNAJ1m9zwAUwF00/nZ5JDR8qfeA/aRw0M0UwxlZ8tBtfwhzIQ8IlHGua?=
 =?us-ascii?Q?AO7+ff1wcRhHVNPPxgGvXCEQRIkdoVSPVzJzmsmn1X5sVhDiWW4zeH8w6z5U?=
 =?us-ascii?Q?zr3dP+Ud6TDxNzGStRFyqyPwvsSub+bXPpHID9jwme4H3IHmkb/bwxFM3Put?=
 =?us-ascii?Q?ApcZUPq+3yApDaDsCqCLQTznqAOcTHIS9LOPPDTbgHror1SLhLJqtLHrFxP9?=
 =?us-ascii?Q?vm6k9zIdBi0+YjozWGJUYa+z38VqBLd9L9rtIG5HO0KDjSP3wiaoJsUZn1NO?=
 =?us-ascii?Q?T1jRTbhUZWY1lk5xk1vZKhZEzpBUmYxu8l9KAhoOg+HjeUcisD73Ej1+UWU+?=
 =?us-ascii?Q?6djbToIx8omZJPtRFo98NP+nGi3SE/x9Qo8jqBd5jcFY9ZeLecOxVCaZSgwH?=
 =?us-ascii?Q?duMYpIp+9Bs/yuwPzf+gJWcl5eyyFcyg9DZVwWofpmjPGswZAaQnfjEnRoeZ?=
 =?us-ascii?Q?7QwdLPMyA8KaBIgRHSvsoYkSUpacsEOqedyLGa44C92Pddj/T29vnBVEfuJl?=
 =?us-ascii?Q?WhAm9bfNq9BT40aKlRqlOfZSMM6KkgrHbQeBa3kLyQIvOFcYjPTAESMQNIEU?=
 =?us-ascii?Q?99DlmO1HM+abOEzsHoU0i3iWP+qcwfFy4JRWL2MsU96c9V1iz/U8PzeOUuU3?=
 =?us-ascii?Q?8lsnShVkAw9y2Xp/eAudCCcyM+9IwIjQS7URGWYZalzBonwN7srQ0LmPQlhO?=
 =?us-ascii?Q?vdJNW4jyuSmTAWvV0hZp+y3JOD5HBCaAOjD1gjt/lewKUgHmdlOzuqQzxAfb?=
 =?us-ascii?Q?E04DO3qP1o3urYlKpeBl7m+f6m2HhndgcWHESgICx5+a4RWfa7iEyQmltLdb?=
 =?us-ascii?Q?+d2YDiCYKXGJ9E03f5CKiTu/mPtnaS0haGr5Dy9zbOKVPM914g7/0ZRPzZbf?=
 =?us-ascii?Q?EgAu9n/2ZQ80StXmXdk+WvYDm1uLD9m8nTwEpneZzRx/C2w+2lJ00oL4HKY6?=
 =?us-ascii?Q?FtS/Z3j5SFL8ScRxXjJEKmYx5iutLLXbEYPX0iZJWZeKw7mFw1kHz/77Q/Mp?=
 =?us-ascii?Q?N9qtrorrzU1n/oadxNIJvrwYl0JfArWRYI+MBr28aZg3+LnIow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uH4H2uQzSkIau518Lc1EAqK8kfSbBkiHyBk9zczQB72ib1azFnF/pcMU47zL?=
 =?us-ascii?Q?P8CExaO50wg9BGuMJNnud5R/8YYXXzfNSZRSGKL3yqYpl+EsqSchiSqxWygN?=
 =?us-ascii?Q?/0ZBynKVhgUs9Np1Xfp88huFYCrXSBCpS9pflDPrVIsdIduIXiyC3tk7CYYL?=
 =?us-ascii?Q?QJQ1EWMryWt+nt1w1Q+OJ5oGeyIdCo/K4kzxzFuP/zX9fZDAPt4WTehha+39?=
 =?us-ascii?Q?+zuFD9OuOUleriExjsWtCobxWGIKJ1eXS8jLtXkTEAonSg7lEOnky8nqAuxw?=
 =?us-ascii?Q?JKcIEFtJMGpOJxYaLlhz4ZUhkQlH/DfI2wg+IciRx4E4EktppcNWW7waBqxo?=
 =?us-ascii?Q?yUs3SxLoJnwsQ6Ha4gNpZQPwPOsTXeMLxqnY0c11ocin05kSGR/MuBCeqJll?=
 =?us-ascii?Q?vVIs8mqLgIkG8Xotf097EUPsBv/LXpgKVjaL7BL3w7C1ontF8tXTUDMc0CI/?=
 =?us-ascii?Q?KVwHi92f8/cIp1eD2HZwL1vUM70FHxuzRtETHXJWfZH3to3Xqk0mRMUD2V2G?=
 =?us-ascii?Q?+jFY6cm4nzighdbEO4T0jB6cH3JUTRkyilzPAm1jpMaEqxxSM9/dcY5+boBO?=
 =?us-ascii?Q?53azzl71oyk8QGGgKgEqoluCpTqnav3VBGwX2PqZUHouYaFeCorWJCfve6Wp?=
 =?us-ascii?Q?aR9NgGp0JAymjNsetDV13lQPHd6oh7aHjnV1EPv/LlQPaGj6I9KnOYudPptr?=
 =?us-ascii?Q?bR2CwZ41x7ghmu+xRaT4UwT3jJW7Jpzv/YHOH65nj8mw3biGs0vjMt50WeeK?=
 =?us-ascii?Q?KzLbjJI/nn3ol3PnDwJXkJrUpjih8SnGUKKqRF3B6WGgorvfA7H6p8ncaHeI?=
 =?us-ascii?Q?O0XFT9ad2AXWUWqHY+NiPZPivL1vBhWgIsLRHSph45UgBlRQfYl3aNRodqt/?=
 =?us-ascii?Q?qJdB4W4Taj6LHKgFI+IgNtluOqL2KLwmbqdB/i3rYA9CZ6IyVIHYwqixVu5T?=
 =?us-ascii?Q?6PtmQFm3ygx21yY/bZORqg8zaKb2o2IvD4jL1d4pIw+vWP6PnADj6msVsb1b?=
 =?us-ascii?Q?ht04AKvEc2zlapYIjwBgQ/4f8cdpI3feAL9ax/2NorHS6VYoY2DMVrcOwHaC?=
 =?us-ascii?Q?zEuST1qxi3QYrV8N3W5f0dANfQLwvP20uWmCyBt38/ZcC7qGtOESeFRttLtQ?=
 =?us-ascii?Q?yzGkJS6RgPrhcljyXFWjt1jXA/IB7kzHysapeWVrCFKhIh2QQdoRzSjOcQAS?=
 =?us-ascii?Q?S1Vd0uPPrxWWkj9jA0RT8/KQzi3KrZcNT7p9ZCE72xQYTYJhXuOs0AtUs5fs?=
 =?us-ascii?Q?hfcDoPP2x5lfA6sYPjsGsjF+Ut4jkBQx6y1w/6BxH4R7SgxMd4pej5mlOHIs?=
 =?us-ascii?Q?rvLkuWGrZy54wsy6L5vgHr+p4B+DN7K7fhuJJB/CMUD9xQyxKRkTtnCUwDPf?=
 =?us-ascii?Q?7meEtqvPmHfSLLTbtA+DoqQDwtvRTvn9GjBQxupSwWNWmqGkqpxwcMoqao+6?=
 =?us-ascii?Q?ICkAWuoMdclRQz3lmwk77aMn8rjKUYSZV0QsM/G5PHw+evA2SMeDhBNXdXKV?=
 =?us-ascii?Q?GQKLqQhbAJ1mRD9atkUqcE1KHj4md6tbmmBU34T6og0rZCYFtgEDSkxk5oYM?=
 =?us-ascii?Q?+2UMwnJpg6JhxxEUlLJ8Josr/Tb3Y/ATnepUXfXy1bc8L1jEn/MrcekLShs2?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NqzZ4vNjXdOFKrDAnF0IwHtdy6GBgTW393jEg0Cxt5KGhj14uWUwVw+tyQ4Y+c3e1ShMJMXtS0DQ9Jx6qohKNBeJAXDJvxZHndKff8LKxgY+z0hueNMfUFLWBG9TDqlClamz/B7r+B6k1DcJK+bhJ+7FDldg785e8ECBMzKPMfWODL2xJ0qG26GKGDoR4tiuWOtwleo3T/ldFDj7vJaaj6Dl9aTHNH9VHcEMvjOhEX/7W8thRIKhLseK2Y9XM2NAc1wsYjZx+R7S0T/zZx8hRUW6etyHpSOAryOUUKmBtHHqoxL1kXqmQIhJ2DOKL+IGTSz4ryhY0pnaLje2otV5dN+UPHeDcxbpk5Rf8p0j89XqcqnNtq2/kgYCbzuCvmByMed+ON95oK0pLpq0GQXCigAEOAvMAX6TY9QvONg+hHGl+zfqJE5p/5JMsgbrYE5Cb1upWng7G1RMgmip6FMzm0itoJ0GAXRMux/pp+OnLhUhG9M9dkHeUscSLTtMbUVLfrvynlNhS0sznS55/D8NO87lCO4pBm9E3nRD0hrTrs073cfs7Vz09j66ijIBuLfBPKIljoVpGnu5CHsAyQPnsn4f1359XF7JuXk6RdE95lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66911e-9228-4496-ea20-08dd88d1507d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:53.7960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzZdghbxpA2/W1A9EqSstt+Xs9Vbk/qVytpaCD+9tS6DSgenEWIZmWJ9aU+Lw8zAOGoXwFAPrvyYpdf1l0hlVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Proofpoint-GUID: mdM5ZVTdsq4M1xCzjfkvPqssreylNCOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX0cooOlX0kKWU kImUJXgmU3Ht0ly69qjHLoGcMFi6XeVdOqxl/vWwdvMT9Ea3eRf1UUicsqtHH3hJ46+LSLQKVFV R+djOLWDZy6Vd1gUrpP/89aRwgB+lewxIGjM+cCYw5y2xKlUY1PspFxs+wcHgZycRTfygLL5vGz
 K9Itxk0ROT2Z3eErsdC1wjpojXHGpk+XGlRrnBbHlrSHsHQMVqCFIrkx5lwaPzpAclnqZbFMfXU 1AAMDMRNNM4DzKLZR4JxIgrx58hlePiPQma3AsM0ALZThLMNUoMOYhOyJ6wPOm+Jgij7LrZr5H9 QSaYoWnfYRTxkN+LGCwG+n+8LG0za78cZePW+cp6VxA962iGpll/zJRu1hMOT7YUTbyFk43LFZ5
 Qym7v0ZSp3I+/E1+F0orwCmpS3BnXkfqMMJmYgkoyUWq6+aUwxiAkzj+1J194ZgjVbqvUMQU
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6813a835 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zTysb3kGxGKvEiGebP0A:9
X-Proofpoint-ORIG-GUID: mdM5ZVTdsq4M1xCzjfkvPqssreylNCOd

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[djwong: add an underscore to be consistent with everything else]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..55bdae44e42a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..bdbbff0d8d99 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomic_write(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..22432c300fd7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomic_write(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


