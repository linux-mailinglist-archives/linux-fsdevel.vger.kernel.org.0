Return-Path: <linux-fsdevel+bounces-48190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8296AABE4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8427152086E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293CD2701CD;
	Tue,  6 May 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jvLqVJsI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O+Q8RajU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D6267B8D;
	Tue,  6 May 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522333; cv=fail; b=HzLhzs1/gOdc8XfXhEI9cGpRyuZFOPjiPR2apC03QyOsX+9x0oO2Er9RHC/q5RoVaf4dMCXa/VX/EelEuarJMSu4iInGr5qngFSWq9SK9DMt8lubWV0L6QJSx9RwFGw7LOtTez4Pqe0u0SHljIR2s9D/xGSwHv6yTs1tG4uiHdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522333; c=relaxed/simple;
	bh=PyW45OKwGanOYCvSS1Yvelr9Zeim9V4wvt+xM8YWKWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNc6yuBuScn2NpRBT2o0HMNdzCTvubLJbx2FyzXOuBOcy+7HKpSLwsuNeoGP7UVns3D1mXlK0Cf/BTyW7zyLBy670D15bGsjto0VJS8cKXwr8yEStFV5ECouW46OPqrfKD8hY5EdLh1bdTQMx+00pjJ9eGd4YneO97lzT5WScF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jvLqVJsI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O+Q8RajU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546923vR010822;
	Tue, 6 May 2025 09:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3U2mAt5O3v4f8lJ5WkKfRKX7RqXASpX2c5OnaGLU1zc=; b=
	jvLqVJsINUpthTY397tT+zEmoAmxpHgidVw9czHJ4OyyCz825NViFhr/hSOk8aB6
	KfFUZRlVrLQyaSg5V29nI8J/Bwld67eKYm9+dRNr/yurGnmohBxnGriIl5Zhba+6
	/kwRz5wxOibOdS9T1wQPzdZzt/sEef2s1SlOrfVo+VDfOVX3pEwaECSOKDXFABW6
	6KTKVsfH4DR1v0zpEPi63II1Zs+dHxaWm9xrxYL9GrxXgE5+01WTdcPkoqSJAjx0
	zzp2AeQ4yRBVkq6rjCn4n2AZTYWGlP0Jmmmu+JzHaPy9tPIVHM0XcSC/IWx+TfB4
	e7XFbW0S7yUUWLHHXOcjkw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffefg06d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5468CAR6035353;
	Tue, 6 May 2025 09:05:18 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rmqc-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3kqpHBoAkALy5ueEgmNiU39rsVJh8ZIZNqqln1F2ii4gVc3cQNMfDXXW4NKwV4gMFoJz5bSznzMBja8vJZvxgYO0wPi5b+S6KSgSfuND5QDX+cySqxj3/7bop1sQIyWy/5MiP32fPnB9eUy0qGd1hcY4wWs+jJNzu0V4ueuzq35/IBH5kpFGc/2pftLQc6K/G4VhX+pkfMvBuGyYGnkH+MK3J/Lx6PpHmmM3xrqPfEdBnFnl/hGAgih7ds7Y2+c5sNSPRPEc1DRkw+bZI2Uyi0SGAIgUO3cIaIgbdgnR6r3W1qwIlQJ6OXHT/H4sjbhjwGrIO/3UKQcGDchdH4ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U2mAt5O3v4f8lJ5WkKfRKX7RqXASpX2c5OnaGLU1zc=;
 b=mdXVwQlsH8ngIRsVR79HXhxy5ZeYNHxQk47YITn0jutmqxkWjqXwk+ntrX5/WNpDpKOm7vCTLdOMRPzpExb8zGAdtzS/woZYSmKXZNaGgtOqp6NxIe/GrpbBJnhWVbPMNY6zF8uhyQGSBAhB8at7m/hpCOlswdARvmC3VmsjNLEy6NLJQqizQgwJjXQKOoeAH6hEvBZOOwnkVnvP21aF9EwJeEWJ7jjnRKE27g36B2UJq6KfhiVjKkHIlWy22wpQWVfndmRUccqUI2jI4+8ydpjCuqD+pc79egFF2nkxg1ZH6KFrv61QsEeTqmp2T55BFlm9lR4hqEyX0IcSG0pqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U2mAt5O3v4f8lJ5WkKfRKX7RqXASpX2c5OnaGLU1zc=;
 b=O+Q8RajU5ZxvtvFfwM30EHemn6sgT2dxN9pC/wkypv21MjB+RsSJWgDDnNqzJpaEVMnvAAUbyQAdOZ/fp5tOydhlfzkLBBGiFXamPDNZ7DxQbaGkcxPmLMqMUGMthOSBNuEvrmrgp4JTcS+UyZWmbES6fCbjpYdOEggNubk1jDA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 04/17] xfs: separate out setting buftarg atomic writes limits
Date: Tue,  6 May 2025 09:04:14 +0000
Message-Id: <20250506090427.2549456-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d57f51-ba53-4186-4439-08dd8c7d1aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ZK5g61/x4fn5sMmVtPdmEIBT6QNjen2Mu912mXWZumaPki5moB2kCoxuroS?=
 =?us-ascii?Q?5hzxAnEtCCT8uoNgNHWqF8yg15mEDzoCUlQDsRRb3gtUhQSTOk/WI5XgiyiY?=
 =?us-ascii?Q?ouPcSLwdbFmWBYqLwqfRAMwd2AnD4gO+3b/WZoZyYMdVsHUkyhVY8P1FON7l?=
 =?us-ascii?Q?scqHVq8GA4fAp/rtc9WfzV0rkDXhg0NG3Hfb3T8Q3G3I3sSsNWV+7bCsOv0c?=
 =?us-ascii?Q?adHu5TLeSxKl8aXJwQLoJiF+doFstr5ZqAMSFYpQXSmObUqTDvnJ/YIQc/37?=
 =?us-ascii?Q?vMfHgJt9tWMqIHa/b5DxW+jqne5F0zPbiIN0TVSNeOART3F5ftzh0F1XbYUi?=
 =?us-ascii?Q?3shQ94iA963hX0uADaPUXLvZlvY6cSe6aaMQDYzCvCSg7A7UmgOWpIdy94sV?=
 =?us-ascii?Q?CATi9zPA+LA+ilzISD8pwug1JB4YF1/gVyWyYIiLB3M4yNDUAIGpe1pLpb9w?=
 =?us-ascii?Q?cMB7tW0XRuahlay+ZzrG7LyTw/fCHsK/PnwTsjEy515GrlD97UvNAFzOS9KG?=
 =?us-ascii?Q?tuqCFw3T8BQoB6LX59heacWUyfOyylUVj6CF2vk5LlTMorkxVe9limOyaBrq?=
 =?us-ascii?Q?U/9l2/QekoLAUO22TjUrMBqamZ9HgDY2oFgr/mBPHZ8LUuxzQoWVRErgfQ/u?=
 =?us-ascii?Q?VbEaV8Lq4WCBZ/d1lkFQdixbyJFHciQ+iFaaXLNs2IxTLdaG3RscsDD4Tr/o?=
 =?us-ascii?Q?WgdB7aD4aVw1HbZmWoWwsarVcdwVGDbzzBJQHr7llPX8Fw0PKtQbHLP7u5gC?=
 =?us-ascii?Q?8LwRLarxB/JmcTFaWcz3jk0Zn1ah+aoWPn7WZcE4AfyYVJxv2iks568/GBNL?=
 =?us-ascii?Q?H3dOx1GoXSHLz8TyhXbAplSxDV+ojWvpeluW4BQH2/C6yF2pwZI8dNmAhwZH?=
 =?us-ascii?Q?3lee5NDRZzpHD7xE/CqqPz15NQqjcdf+iKM9HahaPzGCk3zswsPhCliCsRwp?=
 =?us-ascii?Q?IE6p6Cf+N3AsRUediRagWZ0JTZfJ6JN2RySobDifcsrRC2cYHYZijirEz4VP?=
 =?us-ascii?Q?17HrrRy7DnBZ7auj9GyingTvL06S310Olla7/1V5bmY/Z3g/GBExuEv2b4jQ?=
 =?us-ascii?Q?r/Mp90cPTaisilxqD2gCmM16OpZDBRaT/6SRuzw71CeGS1wFRIFBH7DWS76M?=
 =?us-ascii?Q?i/tiUjzXb+cOFMwvcoKz30e3OtrFQokwJt6NW0njg594wRrl8oSrkVFknYft?=
 =?us-ascii?Q?74rjB9S5LN+ejec7pRTYx7rZ5q5hLCmVNYDPEdaHILhPZuKMlw9XzLc46oOX?=
 =?us-ascii?Q?vx4UQzNrcfBlMcDGsvxjXB2LsYCE1TthzwqIww8dy18S2yHTP11of1kYQire?=
 =?us-ascii?Q?0PnZkrgC8X8O2vLHGTkY4jGiv3+ZRry7pRbIcg7dtcRh1h2XU0rQ96bfvnyw?=
 =?us-ascii?Q?JcLBGwUQnO3ZDhsRfQQ79jkTZWcApniIU3X7gp63C9XwnLkPTiEvq6K11jkN?=
 =?us-ascii?Q?hdfbV584Tbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gt5BgpwuxWa6aW5mP7qFSyAFN5qepLugL1aGyt9QM7B4kV9j7B4udYnvnJx1?=
 =?us-ascii?Q?ZmfW3QhNUAgtWypHJzASeAM/dpEpbKCTRBKi2quLl3uOEbSo8cArmy2TvjvO?=
 =?us-ascii?Q?cTJzkjdQue5b0m7XeC2CB4aem3cQVJcX254hXwEqxWrCZROkp/SXUQqz35Gl?=
 =?us-ascii?Q?aD4jNcIXeEbRuqZbqaW8HaU40MGIm5YbwMcA3ivVWVVW3KTlupcmt7L+hF4U?=
 =?us-ascii?Q?tsepQJFXPgEbmDDfp0DFRPe7GuuTUPW3VYxnT+EEZJcNEf5JTf2urlrqWR8/?=
 =?us-ascii?Q?LXSO5P7Z8nfR1AfVqatiEkN2kJ1hYQBh4wOmO8l0KIe40jJ8e2NheAq8MCCC?=
 =?us-ascii?Q?CgWrGixrqBqaQgk8ULm29nk0PyIotmbiDx8y+j5a2mfy326bcyT30hTwtykP?=
 =?us-ascii?Q?kNm/pNBdaHM5EgCdgyBiX96/+VEx+HRlnBmAGLEAfpsa2PtdHCaNuQWpDB75?=
 =?us-ascii?Q?CW9Zk33R14nVa+YGgfD1q2DK1z6Eboh8ggEpG+IIacG3nDjcPwfH++Uso2Z+?=
 =?us-ascii?Q?tAUDj8c6hxtQhX8hHz2svQ7+xoP5wl3CXxsdtfBcyp9J8P/74CpRGFXdlIgw?=
 =?us-ascii?Q?fTuf9KA5casQb8SIZFdOvgzP4tllIhTfPsyr/8c3j5Sq1egDub4F84x+wZ3A?=
 =?us-ascii?Q?hlmPbJzWY67MvxtupccDIYJ2Y7cfO0EPBTpOohh83T0aMzBweoj1XHotRJgZ?=
 =?us-ascii?Q?obrJpBziOHPhFyEzycExfW6kjRImsDi7s7ZaDyKNQC9zx22zGtjdMFrdqWmH?=
 =?us-ascii?Q?HmBB0r0qLObgXfcqVAgDSuwAEqXchgj9TncH6Jxa7Ypv8sFMnPIElnB4ZwmH?=
 =?us-ascii?Q?NahT62lco/Tkk6Q8CTbcSUSMZUCjUMvHicFvyhabEGejEDELEdxhHIL7e28A?=
 =?us-ascii?Q?QlRaoyuxS5dBTzNi/vlyX4oeY0ldT/b/+VHzN2wOltOWjoS6UdzWMEeWZTvF?=
 =?us-ascii?Q?+okQ02fe6yg86epqdOW5pq1lHRM5va+f6q6BwtZB8MrZKgLB83bEYPx5PdKu?=
 =?us-ascii?Q?EY9LP1O1BMMDENLvmkebjys8JwS5KubZK9ASgfVLfBpTTV3+zytx0EBBIdDs?=
 =?us-ascii?Q?yNaC4beTPnGGpsGU2IBIo3Kw6FJ/ZvajeeXe+yMP3MGO3vQ1zJ1l8srMvAze?=
 =?us-ascii?Q?eTwN61gQgmFQ8Mu6iW0xEbj9bTxpDwHp9NIjST4Sr4Qju8BnrpHra1kMgsCt?=
 =?us-ascii?Q?GdAAmC5Wt7TnR29Lx84sHlGK91dmG8eODc/Hx8wToS9vZxKhUfU/E41IzIJ6?=
 =?us-ascii?Q?kKYNfo1xDbJOp5GzOSQqwr8v1WE7iPd3SXL3NRrZFYHzvbMjVmLWUP7440K7?=
 =?us-ascii?Q?aQfSxhaJjfDtibNqYPBzrAIY1VAc+9UOGapMmaYpjtQnu9XYwi5QzpZVzllg?=
 =?us-ascii?Q?4H07PF9MQRery5SnEdkrv3DmRNp0gS1HtCzsNb3JRvN9we0E1rT03ZOm0xZL?=
 =?us-ascii?Q?i10YFXYk0srURmIZwHMYus85WU9RSyP8C7FKmeGWnp4/41PBkRnRJZ5pPZ7e?=
 =?us-ascii?Q?RS9+AJ+g78k7B+xx3AzqNebk0sj0uMM+KXA3dLGZtdR87J74G8sOiMnlozEE?=
 =?us-ascii?Q?z/TNXaaWK9Cf4+YLpx1iPUmS1Aa2ydtWSesuvDaDCERNgiAa6YbPD4ZHPhNX?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VNn3cimoV4BXDoiiA9rYsDkKxOL9SQKnztsUyK5aX4HuzyuNshdgjFWNtK2625T4mu5F/esd1EB6snmjDrK91UrSFDrqgI9GabKbrnPBoY5+goxthSMkHNCWSXHkQjW42FrZeTAsjoIRXQXDoTVcjFYiTDW6AtXn/nTEsJw3bAIVfTz3I/T3klpeMkjPTchhMqEDSK+anCmDcW0ZALFZuHl3VbBRTI66Wv0T24g7A8tn8b8b1Q3zx1OS7X1yzheuJtcFWG6e72Vl4j2ATGhm9UrEZoi4o/3w/vYfRh/V5Ycpz5nqWpFc1PwdLEghLpMguZRuEa2gWoDvaMaXxsdRExFAJIdRelzquD4HVZnQIri5OpDvzkRo9E6lMVTRjbzQ9Lxt4Bo+H7pp7RO1/Q27/5YwLYyvsJQ/KM1ZZUrmBxLbES1KySLwV8C0lmNj36G88XMtpcunFjL528Vll54dOfhgSoE+2qMmV+kp32QXIhGNu05Br0jvVxfJ1LI8dlstDB7cZ5jliyjaOD5CR7ehJhj/YMn5LxU10TcprkyPdbVQX+AJL+uTMpBY39RTFnJYX+6+g8kh5Y8RLlm2he/4c33MGypZfToe5x9LGs5ByPE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d57f51-ba53-4186-4439-08dd8c7d1aa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:10.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zqP72X1sLZHyLJtlzNlcvwdbV5Ven45G8fJkWrhBqXwTwajxP72AEYrpR6QIdsSopClGAN8ev7qNNSki39OHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfXxWU3pkND18RQ HuXZfv9WqbIz855ogZkVXE8Qd/ABg/3w6t/0VRY1djboLF4NrXyPzfWlumyP4NMYYEhnoC1UedB jpIW/3au6oMklEC92ypdNNz5N2Tl78Qs10F7QjTDXmuqlMM/CVBBpPte6F6P4dqbCtmQiHG4FdD
 V5n/V8bOdfTnaNxvELhoWJLA+8cfrfBxbsGjFBzI+XTGfXmx6H2CnS7kgtq6DO6H70zPnBV7yiA q9xJTxfC0yg8wSF87OMG5eae04sddPh5WFbkH5KgqlOUb1jpi6UIAJ20av7gvCS0HQVYzPV+XKB I8f3XSPDj95J90xZLAVpDG34w1asO5iS/fcsYauLLY166Hbkjvd4qO5MGwvgJ7j0U4llMqj4hh4
 uGJ451uSYxLFKMEn8mCoalyvwnrguASuwXh506W9KoeyzCcryMfntFS/HDG6swANjF4ZOPF4
X-Authority-Analysis: v=2.4 cv=V+t90fni c=1 sm=1 tr=0 ts=6819d0cf b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=dqqy4keaaASm8ESglB4A:9
X-Proofpoint-ORIG-GUID: YlaOwQ5Feq5kUbaQM0rP3AlQV-Dg7MBq
X-Proofpoint-GUID: YlaOwQ5Feq5kUbaQM0rP3AlQV-Dg7MBq

From: "Darrick J. Wong" <djwong@kernel.org>

Separate out setting buftarg atomic writes limits into a dedicated
function, xfs_configure_buftarg_atomic_writes(), to keep the specific
functionality self-contained.

For naming consistency, rename xfs_setsize_buftarg() ->
xfs_configure_buftarg().

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
[jpg: separate out from patch "xfs: ignore HW which ..."]
Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_buf.c   | 32 ++++++++++++++++++++++++--------
 fs/xfs/xfs_buf.h   |  2 +-
 fs/xfs/xfs_super.c |  6 +++---
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index d8f90bdd2a33..e2374c503e79 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1714,13 +1714,33 @@ xfs_free_buftarg(
 	kfree(btp);
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+static inline void
+xfs_configure_buftarg_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	unsigned int		min_bytes, max_bytes;
+
+	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
+	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
+
+	btp->bt_bdev_awu_min = min_bytes;
+	btp->bt_bdev_awu_max = max_bytes;
+}
+
+/* Configure a buffer target that abstracts a block device. */
 int
-xfs_setsize_buftarg(
+xfs_configure_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
 	int			error;
 
+	ASSERT(btp->bt_bdev != NULL);
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
@@ -1733,6 +1753,9 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
+	if (bdev_can_atomic_write(btp->bt_bdev))
+		xfs_configure_buftarg_atomic_writes(btp);
+
 	return 0;
 }
 
@@ -1797,13 +1820,6 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
-	if (bdev_can_atomic_write(btp->bt_bdev)) {
-		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
-						btp->bt_bdev);
-		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
-						btp->bt_bdev);
-	}
-
 	/*
 	 * Flush and invalidate all devices' pagecaches before reading any
 	 * metadata because XFS doesn't use the bdev pagecache.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0..a7026fb255c4 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -374,7 +374,7 @@ struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
 extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
-extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+int xfs_configure_buftarg(struct xfs_buftarg *btp, unsigned int sectorsize);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 6eba90eb7297..77a3c003fc4f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -537,7 +537,7 @@ xfs_setup_devices(
 {
 	int			error;
 
-	error = xfs_setsize_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
+	error = xfs_configure_buftarg(mp->m_ddev_targp, mp->m_sb.sb_sectsize);
 	if (error)
 		return error;
 
@@ -546,7 +546,7 @@ xfs_setup_devices(
 
 		if (xfs_has_sector(mp))
 			log_sector_size = mp->m_sb.sb_logsectsize;
-		error = xfs_setsize_buftarg(mp->m_logdev_targp,
+		error = xfs_configure_buftarg(mp->m_logdev_targp,
 					    log_sector_size);
 		if (error)
 			return error;
@@ -560,7 +560,7 @@ xfs_setup_devices(
 		}
 		mp->m_rtdev_targp = mp->m_ddev_targp;
 	} else if (mp->m_rtname) {
-		error = xfs_setsize_buftarg(mp->m_rtdev_targp,
+		error = xfs_configure_buftarg(mp->m_rtdev_targp,
 					    mp->m_sb.sb_sectsize);
 		if (error)
 			return error;
-- 
2.31.1


