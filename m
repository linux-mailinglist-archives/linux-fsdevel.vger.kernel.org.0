Return-Path: <linux-fsdevel+bounces-48194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9372AABE65
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E75209E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AE27877B;
	Tue,  6 May 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSsI+/Uj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wv8i+1Ud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAF278759;
	Tue,  6 May 2025 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522340; cv=fail; b=QOGFiQf8eFEBMyBEI34SbmL0I/1Oluh/vR3/HgGHoNUFK7SLCFnQBALjsKAf/Q5dqkFErk1JRMH5ZlWaQAf1xwABms8GZO18Yt5jeeWpVnbWk3cZYMsGfWP64yCHuAVMNL8ATQGFcLpD9QNlY8VYz2hPJcOBD/E8VYE2wuIi6q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522340; c=relaxed/simple;
	bh=mQGPLaHvO/RXl3/hoA96NDw2S6UDOBAEPIj5EKOsZNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k1z1XMIGy3RJ1Vu+xkGrrtuRv2S35u3CTKnHHqy/a4VH6vj3Ikoazyskgipi6d7wJb6xv9VBOuLaH/+aK6J6UBh73pR3N1e+DL4qmI3FySIbgI/zyhzRJqyRegg0TA44Pd49xYODcde0SouiS/cC9k6hJr8cDz6RIxsDxqJAScc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSsI+/Uj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wv8i+1Ud; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469219j010767;
	Tue, 6 May 2025 09:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lBN8GpkzmSkBEshzWk4504x5Fdvc+UrEn74p1FTW+Bw=; b=
	YSsI+/UjqpwPE3Re88PpyEYznjRGCM8bCvIbG+eQ9urs9lqKEI9kzWgfnkYbS0Zk
	oeH/unr1CJOcH1Tq+QPWg7WU7fICLX5WFU91V41dSsBqSRgIgq4238k1jRQFmLsm
	ZWJRMUL6XAP1OnPjmLiUMqzibam946oP40ypWtarI+g/X8ljcKHIrFzmwfS21uIF
	1EgOIefwk14xHm1mPBADUXxu6odqXkfcXDxL88h/2qvtoknRgcoYRJ8/0IbdgULp
	C+PRqtXJd0XWRKLJ427uXdhGJ3j7OeJKOZVAQibjkHLFIlPSYOX5no/Ny2OrQTcf
	EmWq6TileiNUjLo+rTUG9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffefg06g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467aFIE011271;
	Tue, 6 May 2025 09:05:23 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0bnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za3cApTFGQAZwAv9vunGG1I4GTvW+gYcgF9kc+VQNNX839LxbE5SHOsp7GV++q1w4FqO+Pif+kbrurVpcyoZxVaH2h1sbr1hKLTVnp0D+iWh4hHnORewWFnEvVBhhjR22n+HhR6pIPhrdlgG2+1hbtevOF//zgKybF7I+Rsn4d5SRcNt+s0GRWwBFt50XZvymk7rX7sz/5m0CiCFJ4M4AQo1zGU0VdTUJuFK5UBzELdgV12pdJ9y7iXPOPEeZhksfcfO/qV34vHiM077qxmqip0KMP3qRtixcSU1FG6wwOXh0jx+CBWUe34wwsZlqHAfnZXvHQ9oZEPH7aurNIi7NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBN8GpkzmSkBEshzWk4504x5Fdvc+UrEn74p1FTW+Bw=;
 b=InH+wIWE6YpcqdTxW9sK2dk7G/L2MsATEpEQNeiX/NqRop5i75kwD0blflybTtl1eGQWTKXNVsV/VuF5hRlIJQ98Vr5XklPUHrdk4mHPdVMhzaum2MZHJwYAZNx11TTGH4Qf8uoKDYrn2aILNh3ZoedeWAHDmlzlYmlLOhqErE7AV+oAZk5tXvyRcbExphOpGkqwzZxCv0wBBAG305becrlSFqJoZY3oqhlEwbqbNqHnp+nnmCTTOQCer1LqiQ6xsPKxx0EZYdA0avKUmCqQpKjlnoRxryhxGnuHIZf1D9IQsj35rsjF9e/em3lKOdMBdYDXad9TdxDL09EAGlcjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBN8GpkzmSkBEshzWk4504x5Fdvc+UrEn74p1FTW+Bw=;
 b=wv8i+1UdpkGCQB3H6cxyHUNUI7iXdN5newme2cy5bWOfl4RAVGnt68n/N3o2PKCb0WeWcY4Ame+lPB8pEVZLIBfOBCQwg5FGP/SdCRIHs29Kc7HJxz5qku7KjCksVXSyOEHI/ZRHFtKUxtIO9pfXPzl29bbyS24WZrj0LDKU+Oc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 07/17] xfs: ignore HW which cannot atomic write a single block
Date: Tue,  6 May 2025 09:04:17 +0000
Message-Id: <20250506090427.2549456-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8b176f-5518-4fe6-421c-08dd8c7d1e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SFpNIx0eUm67wVD/jaIb348MvKZJsTt7OmODfVwfmCBxRS54dY40DLqYph8t?=
 =?us-ascii?Q?6siV/Db24KKcjo8ubV3b1LBB6pzEs4ReBbKQlNLxaKaWmdwc8RPiYeMHu4n2?=
 =?us-ascii?Q?zCTFLnrIqw5wPjkdfNrSO0jYdgi4XLjLtRVVEVvGX0mnTKkPLUOKqP8xBRiE?=
 =?us-ascii?Q?2WU2apKKqimL+Y6xpJ155dmfUe4DFV/sMqgb4sp/OjortZerSa/eKPVfdUfj?=
 =?us-ascii?Q?k7ymcg7jQhcFU6ocAinpP3vpPISJJMmX6WEcLzQELPbweSbZ8EdMq/srnGNh?=
 =?us-ascii?Q?WBawAUzp6CUC7+2yFEc1C7JlyMhFQuuvf1DlpF0wqIGXDVZ1+FIud48u68DZ?=
 =?us-ascii?Q?kXQm0CwDlBvttxbzWvChOH5RopRGPagC+K92kfjF8yDr/MCYG/kHm0jI4wgF?=
 =?us-ascii?Q?EFg+UxraUBt6ijJZBjrGQdoEB1mjWGsBieBhyObaVqICS9AwG/k5zRxi1lcV?=
 =?us-ascii?Q?dDwSZzKAm8gpzQUcvTwG/uN4sIAXow6uHO6O7mpHcSrtfFnykBFr+I9T1daI?=
 =?us-ascii?Q?le8MGJpyOT3Sug2VVXa/5m7t0PzEwbxGbRuVafYb0OdbpG81J5Do1GxwUbSp?=
 =?us-ascii?Q?xdnmjf8EahiWY/AdDJpYCwAFnZZdFXTt7Og8IyEvzaorMtBFIgNtDUhuo+uA?=
 =?us-ascii?Q?BQwjZ/mx4qwTV/TQ6iRd6Q+F2BOwLuJuNWdOv/lk6gTaL7GvcdJNWjkJQMxP?=
 =?us-ascii?Q?V/W5w57MvXuSl0l/wa9FgGO70nLW5y5bAmc3lunL727biU67Wnc+M9piFXWr?=
 =?us-ascii?Q?qYaaS/eMf9bqYgy2CORBJb2uPvkZ24bBnG6rm1aq6Q9w36ea9UIPdW450UYX?=
 =?us-ascii?Q?AQhKrGETQIgifFwmuy8y0/sgpa0JyECuf6LHa5mx+s5dqpyHEId3ZCa5vpDF?=
 =?us-ascii?Q?mPoZIBBzxSF0t9+E9SO97bJiQLUhELvtRrJejqhNHA7p4iX8I5O+vna5I1ag?=
 =?us-ascii?Q?8Ls0/zREh2duHPJoe2zI1TC8uNAX8uR9sbY4Bk7sOZ2xsE1v9ijPNpI1Q8jK?=
 =?us-ascii?Q?+VCEeAsdUP6+iNe/HnkMPC5diyGOiJSLLXegRnXy9wAaCSjcHRCAdWI/YlKf?=
 =?us-ascii?Q?Q2rx+EQSVL9e9PiYV63nBvqH9dklySu5GV9Lm/GMi+7dTinYFWn41QfmZVFW?=
 =?us-ascii?Q?C8A9mmsRKjl2yMuM6nEpNtLHBtrd5JZMtOC5jnz0I3VUHgx94pW7wVPP6p/1?=
 =?us-ascii?Q?nVlr1bQ8l9i73E5alZuqxa0Ix0xIKm9OhXRl23FvXwHll0oH9EiGbQqBTm4s?=
 =?us-ascii?Q?urznlkmjCNxC3aZMnio25/iLrgeTgxEc0XNsFTyM8ZcCQkBhjYWtWpMF0FiP?=
 =?us-ascii?Q?kmNAFPdABtWquqpI3BHFZfmodjV+87pg3FqV4eTwu2KEvDsXMCQUy3kXHId/?=
 =?us-ascii?Q?49Zd6SCVQtEbSd0VtiVBXZNRJiOS9GFid2mweXpnGPWrlX8nDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlOP0M0wTL42PAK2NUaZQuCSCKaRUJRSvEJ9V0sY02s3VX06tAr5BsiThh9J?=
 =?us-ascii?Q?UOUAnFfmUTzNEpmMvKmApF/nius8TJ3BhIMCNEzMOl2t+oQag+bkRwID2N7x?=
 =?us-ascii?Q?T6HNh/6KMzrlJ0z40xq30F9BozT55JGq144w3PgRvLzKf4izFIsZ5z/WDQwW?=
 =?us-ascii?Q?MZZUk1XQkV70B3wkzDmcUUynsqEuH1RY+6P20O8uVi1iLAFeM34HapW5r8rD?=
 =?us-ascii?Q?r7AsaZ9S+1/t5hRmp442/e6Y8nhiEbGD3dXfRIgVR7UhW5jFA8h97D5x6o6D?=
 =?us-ascii?Q?AliG7DStHLQN/sbt4abpDZJq575nYmqV5wwbN+m6D26dHYDbAdaEaEvqhKHz?=
 =?us-ascii?Q?Q06hQ9TZmPGOXG7eyDx9SL2X9zthSDUjy3eUpeEHTL9APGTRL09mL7oVjEbT?=
 =?us-ascii?Q?zTXyykAIIiJoz0KfPhzBgUFahz195egOkbEBQ2XnD+CIYVMAf7HrHldy+r1A?=
 =?us-ascii?Q?iaF5RV5K8tSSDOzpxGDdZi3njyBkwNECDT84IYV+CwDJyb2uczdMRUPXC5XH?=
 =?us-ascii?Q?vJnndOLc9U1+c3QYpM8+GSDYo9HoXO5/gaZoDoluwnPJ1arVTXKCpWhsxyHz?=
 =?us-ascii?Q?MhdokOO7zTYrtQCTPWxtpIl9sTaXg1zrO7vLvXgve2TuKSuG2VAFY6HA/oaM?=
 =?us-ascii?Q?0rFYGcG4HSYdjO3qAGN+C3YUP527j+c+qYtH8W7Qpf3t+kG7fIfIbWtRnXBg?=
 =?us-ascii?Q?vSwfCAkWbUAA4yqO+AJjhpZJMzHFovgHOjCOCNDL3p/nztCHWkIRMvg0rGhm?=
 =?us-ascii?Q?45YOrW0QsoUgfJq6H9S6oSmES5tHwq7NLQH/y/uQxml/A4A9Q7/IvnWRy6Ec?=
 =?us-ascii?Q?qhgUgFWJYZNzwwFCDt3I1m69llvS7QmU/o9dXkA1TVwN/8htWFZzu9QQDCrm?=
 =?us-ascii?Q?7rjYZG1SBi2d5bPa0RDOmTo6cVl3jpQFmejuJzaP3+ftG6KDIw+SEEbXvCwq?=
 =?us-ascii?Q?naaM5TaLY9BBmCg3dev8eii6WIYT7J9rgxx3tRleQ9LQtFVTN4JEa4A+RRfa?=
 =?us-ascii?Q?UXQFHpB+Kju8cxxurV0fAYgN5glPKUr8KOH6EuaVGGc9t3bdKDR767SB7Wj9?=
 =?us-ascii?Q?92mWifZdpppmKTAzRSwR8N+AIZI0dOgeioJGBl3/qSr3bzQHhfeP6apfGNWO?=
 =?us-ascii?Q?sMprP1bFC5fmXSbvj3+lxnQ/zVl5rY066qdvUek4AMmmt7NF/EA+TRuaW2r/?=
 =?us-ascii?Q?dLmNnDpyhKEqUTDuG6VZ8d3Z9ooAkCKwz0e4iy77vEEIO503+ZsC+xNI9fzw?=
 =?us-ascii?Q?55x5AXl5wtzwnXv2lkbb33YAzSRau6vFMm4vLFHSbQZw1QcLy5g02QkHzGtb?=
 =?us-ascii?Q?KoQq/GRiTeUEetLtDRar34PbJ3lWakckd1CA3MDGJQyaDHiS7lU2PVEeXozh?=
 =?us-ascii?Q?Y3DCG6j6aMI4N373N4DUKp/3VvcBaZWgg86VuBHMNEsSZCyykk/rXJE96+EV?=
 =?us-ascii?Q?9KdvB0w5AZZv00KTr7A8kNUfmrOJI2Y5wj0tUhX4M1kx9Q4XQeTDvPx1osrU?=
 =?us-ascii?Q?De0U4f1Eo7LK/+mmyMQX391knxhvXOWiP9ePbdNvGv9O/tIYbdFtoU7nHLdB?=
 =?us-ascii?Q?ZAOR33MJpcyn2F/iWQb5wE5ESSiyzPL/MhkPDI/J2aWfH9nRT6+4D8smt59d?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmIVuWNWZ0suOsUFbtALLhHS6wJ0So8NZWl2qw/yx2KI3a4LXWbPM2OpDScpK++hu+G4Hk/sbij5lIZHPQJmX5+zcbkfYX+tOBQqh9n+7ccTC5feBw/ALOq3e9PxSMJGRGoFxno39WIX/qvyfGLQG0EtnKWbG3c5u3TF+hQAftijXxI1ah7OEhxZBeUWbCQwDe2BE540Sn/oaUvQnkYIlGE+VDWoi2HkfWk2Lz20BcyntmQSgIRteHED9v89QPQJH9dwCJA4/588+00zU6o1ASB5ZdyK2shRfjq5jXcAZnSh/rm2d4HmYbtkc6NmHOdsDblq097VfmO3B/KD9KjPYzKJO/WF62K0mLDfdRtzeh2N5z3qIRhcZU2SH/xb1mS2j0greX9LMs8Drcbuwg7IAm3lItx9NOaD4/pvSl0Egc/iT/fOPB2aB7+r7PphDceZZ6BhGXQak4Fajx4EP1dwcPzF87SDgYemCf27o/fAX1D/IzsdHgnkRywz0J8590NlSjXEFJLY8TGdtfcTUzISTOroloz8GFSvsvM3atKFlOKZ9reWhC/xDFGDgYgo96ijB+531B8Lv9J2S9Fd2seEjD2WT/RrYdLIxkiYBK4kIoo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b176f-5518-4fe6-421c-08dd8c7d1e45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:16.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zhzGtLhbQJPxwAWSjBRmMkFDplYKi9IBn6Q+ABWkA+p0ohJJAJFVcUJVmeV1i3hgJr2N+yMc6pAKP9dBfEgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX3frwnsOZUYd6 5BljwMMeGIGLFff4ryKRFg93O1+4mrBYnCLkSTq8jKZuEp0e05QTbeGzUlGH1y6+8pNPJTTz4Ug zXBeA0z467+w08ABpKs4LNDkqyjEuhXxMTOkU8aGfvr7LVwlC5DZNQxaIH4mhGXjh1O+UCFjpuT
 wcHHxFmZ57V4iIlYtSOK4CD62uq8+5iSi98uL2QjIjZhmNEdp0UfZKcUP7R6OWB+gfRDohNUg0W sC1Mq4Z/h4z6VccDqkYDqJECLbPATCMdJjuUrYTgQR5ZVdJjOb4v0zv/A0IgL64bf3tyTb4W+fH EkL81h599VcNd8Jw2HFzWu9Ed+qIjNSOk6nOYV012olqfLDTFuNPGX1nuBjGOgwCnkoSZaPdpb7
 akXdsgXiJ6a63pPSWD1pyuDP9vSWyZC5hZgTzPSkPfWcm7EL38HfVIKFMsY3S7ptTluBlRXi
X-Authority-Analysis: v=2.4 cv=V+t90fni c=1 sm=1 tr=0 ts=6819d0d4 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=gtobUbgypl7YtJ56tnkA:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: glF-pAHpzx24Kz43lAAzq35QXlVyUOjU
X-Proofpoint-GUID: glF-pAHpzx24Kz43lAAzq35QXlVyUOjU

From: "Darrick J. Wong" <djwong@kernel.org>

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the
code.  Indeed, a statx field similar to unit_max_opt should also be
added for this minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird,
so let's just not support it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_buf.c   | 12 ++++++++++++
 fs/xfs/xfs_buf.h   |  2 +-
 fs/xfs/xfs_inode.h | 10 +---------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e2374c503e79..d52d9587b42c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1722,11 +1722,23 @@ static inline void
 xfs_configure_buftarg_atomic_writes(
 	struct xfs_buftarg	*btp)
 {
+	struct xfs_mount	*mp = btp->bt_mount;
 	unsigned int		min_bytes, max_bytes;
 
 	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
 	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
 
+	/*
+	 * Ignore atomic write geometry that is nonsense or doesn't even cover
+	 * a single fsblock.
+	 */
+	if (min_bytes > max_bytes ||
+	    min_bytes > mp->m_sb.sb_blocksize ||
+	    max_bytes < mp->m_sb.sb_blocksize) {
+		min_bytes = 0;
+		max_bytes = 0;
+	}
+
 	btp->bt_bdev_awu_min = min_bytes;
 	btp->bt_bdev_awu_max = max_bytes;
 }
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index a7026fb255c4..9d2ab567cf81 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index d3471a7418b9..d7e2b902ef5c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -358,15 +358,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 
 static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_buftarg(ip)->bt_bdev_awu_max > 0;
 }
 
 /*
-- 
2.31.1


