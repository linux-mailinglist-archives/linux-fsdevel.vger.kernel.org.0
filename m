Return-Path: <linux-fsdevel+bounces-38326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381469FFA21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC761883BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902051B3934;
	Thu,  2 Jan 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OfcV3ql+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fTn/S4Ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9D1AF0DC;
	Thu,  2 Jan 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826707; cv=fail; b=N2WHagnmYfnSAkjK9q2A1ZZ5bFfkNciGrMnIJAf9aMiHE9++txxzTPhRyY5bofezDy2BPG9UBwzRYhhwkw2QyEGvLDrFFjj12FrDV2EeLX6sWLnq7b3HtlogwxhHn2L3Vi+/H/XZPFoym09FOeagnHTk7GjEmtWfoA0tOBHiPx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826707; c=relaxed/simple;
	bh=/gTgsd8C2wDSUJdPQ874dr7U+M5a6DFpeTG24/YSL8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L72E9MLFo3IXs3ZWZTan1V4DOEBdffL0CPRcgzCNY9TBMwgZ7FS8l03LLN3DDe59cGqKzeble5YTR+0Hv0wLC8UA25XT+0p02e7KJhU2XHOgEcJvgiINS3yOGOffuymsz+dHzLF4DIceVH1Z4HTk+VJ2aOaX8Sjw7Nqt7e/d99s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OfcV3ql+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fTn/S4Ed; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502DtnuB002758;
	Thu, 2 Jan 2025 14:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gJQxMszfY7yZq4B+/BFIpVNyIDT1uwjImi+sP+UqPPE=; b=
	OfcV3ql+Vy06Rfb7VWf/sYMafqCtputJfzIO9Q5LBvopkAsytnGkkZAljbjRMclc
	C/u/GyMvqxwo3dDiBu86VG3Oiuwybx7vONRaReoQkj9Z4uzVmQs7FrqoCrPw7p0d
	oXeLGrh+sg2phDm3GdkzZbG/JvWIdZxhf5Wk9mWOQM4Oq5E5jhbwPRYrE5HIKcm8
	I7Uajp320mEMy+4R3oYybG80hnfMT8PXvWvJlEfSYaAwq8gKzfZ+L/E2/S5BeRix
	4MztcECxUvQvZXg4YxN6tN21xw4Bv9CDVnPYGsZ6ud/Pmwn4P9WIccV0mv2yvLYw
	62RuxM38CHo7zxO7r3gEdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs5cy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502CubXO009245;
	Thu, 2 Jan 2025 14:04:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8tscw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:04:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHL0Dvzn6NIV1jDTTVsB22sHO46Kp9cfnNuYZQ+lVHPRA1yRP5cQFq4KIO0PYuFRR4YsoC/WoodmRQjb0D0iTpnsWfanEsNpmtif9cX4oLJ5kRx+e1b4Ix56oWc9nhYgfQJV1MDazgtPXoZ3ozAnWPr5dADc0UWDoIJl1IHWTpNV3e8SyWKryNqay1ef1hio0in5ii/B8f8k5XEmKGMnBsXus5lzVjAHl7z+vfPN0QCBIo0EUqQwoPkpCtjQ/JCzWw9/Z1xgz4vmlwvudUmEV95btjZGtkvv+OmKk65lWkFzo4DFQdJsxdymhto34PGDP3xDfTc3hlSB8IwFdTy0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJQxMszfY7yZq4B+/BFIpVNyIDT1uwjImi+sP+UqPPE=;
 b=Ach7jJVWOUtH9+4Hi5ABeclnS/sadzIKMmQ/euaOZwsWhPNMhT8zkSMvv8J3X4WUyIyO98Ah58ie1RiPNKPUUmlFYRcscwiSZIsHNVqJpk6GXSWFclADN1ePFdsp8wZMXGc4CflfYz3S7w4Nk3rfRmvAZWnNQpXu+Q9vWTnWtZNY9VW7EtQCDVtyTAmU2XnnLvo9dYR/T3mTShiEOsZPLMOmXNdHt4P0tBRY7pUzfU3GAlOJ8Z3n/63+s841kbnH9wOXLMkosHJ9c3ZBOH68/HoF8gnXL3yPIC4mouEpQJcCdvF3Ol7Y6LViT/F6LraSc9lWEJEoCjTHK87h6UrA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJQxMszfY7yZq4B+/BFIpVNyIDT1uwjImi+sP+UqPPE=;
 b=fTn/S4EdZsu9CbiioWXpvzXscFk+RkWtXLM/TLqDztFBkesC/waV3BSX0zEGHX/3aCnwaOF/VRZZ2G7f3Lsz1wNbHx/x//iapybMjjD1zjukcv0A12g6+J7xlzsyAoGKeS8acN1XmiC6+4Ijg+Q4liKKBnTTUixU4u+QHxqta0w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Thu, 2 Jan
 2025 14:04:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:04:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 7/7] xfs: Update xfs_get_atomic_write_attr() for large atomic writes
Date: Thu,  2 Jan 2025 14:04:11 +0000
Message-Id: <20250102140411.14617-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250102140411.14617-1-john.g.garry@oracle.com>
References: <20250102140411.14617-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bdaa33-7ad4-4c90-b70b-08dd2b3668a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xoY6PMefVXfsWEPlN7RRD2kndijiGrmUc/E+x6ZcXvXgk1HRjyFmL3IVY4mN?=
 =?us-ascii?Q?siA7N2mY/vtXGio/0O4M2HLG89SSKzDSzL/kRcLyimpyEsB0c66jICCpr38f?=
 =?us-ascii?Q?gd+fTIAtWAA9yhs317R5DT6ypt2QqxV8REMnX4fllhl/OC5mQzkcpcsq2hy8?=
 =?us-ascii?Q?gdie2Xjcs5RjEfKxskakCnAHWov91LwKgu8seOE2dqYgJnAu2wYZAR7GS9D6?=
 =?us-ascii?Q?aTPH/z0QepJE1qGGa7YUsbPuTNCee/rcuZoAr6KfY9OqY3PjcTXuGRt4AnRf?=
 =?us-ascii?Q?QOHzUGk9g6V8qFPPL10H8eimwYydSvXpwAoywi8/Usx2jF+J4PS6wE/Bnm4E?=
 =?us-ascii?Q?XHC0rUYly8ejyMOFt3wj8gYDfhzqqICegQbt0kWmVn869a9E6/mvQ+c6Gdt9?=
 =?us-ascii?Q?uBM6iviDC9osmvOwCSPXgmF1wL9eok1IbU/PLSBQsn9pG6iYRxtXf4t0SwNI?=
 =?us-ascii?Q?WeuhCofEacio3h/ptOY3OQ3rGskk6FIrkg1KUrlpNJzTFalk5M/6EKJvKMyN?=
 =?us-ascii?Q?nrCcOnwCUPIZWq6qDf0xkR9PgLf8rPiJuW6n42vI4eRJLXXn+TyRWq7UJDR8?=
 =?us-ascii?Q?MT0TAQwf8gcCqvfmjdHPwNuS9n3gFg86TyEupBg2TglYAft4Gu1/B+6Ja3eR?=
 =?us-ascii?Q?zaJV9VUiapShQoiIHV9cHSf79N8b3AyvY7oavAIwalEjajoKaaK6pfTVX2WC?=
 =?us-ascii?Q?jv6SOITrC1m43DOGx6DnINGBJxZAFQAk3JLpcAF7P6Fct6Ma3zGndef8VRRg?=
 =?us-ascii?Q?Iy+ahusik2GAb8ryjp71rKfe2e/j4dS5IWTwNOSDsr5vQbNJzprxDUNg6yAK?=
 =?us-ascii?Q?ILRsiC9UOszlpeBiTbifef2rOXpWiIw2Lbn8mYAabeiWmCrW7fNh0DoajaYc?=
 =?us-ascii?Q?ORvP2PtpXpGbWwsKLnOS9fO5gNT2V1T3aiwZxzRurN0ERhDegWLAI4oVlSDl?=
 =?us-ascii?Q?l6Ew3Ao01eDYDcVITBnVQufw8BJ4o/tlkK1kRiIwQa25kBTxu+A9JRHAo5t0?=
 =?us-ascii?Q?9Fh+vMbQnA00QwZmpyG7FYPQin8QDrKmjR9ORLkg8ExnXwU6PmkU6SYiYZTz?=
 =?us-ascii?Q?yNORvJwThnZgmNT+qBWKIUtakDD/JKpP6l9v7FsEgtZcdrXcblU1nBsa1xSd?=
 =?us-ascii?Q?NxYFDWRwtKjnGmQKSdjL1ugn0uhHYdnwhIA0GMHGLhPwFBYDDaTPKDpRfsSd?=
 =?us-ascii?Q?mcodz5TPUFL7oOjwuj/lHS54iIivJyM5ue1hyui1tPJgJ8E6951BsvWT7wu2?=
 =?us-ascii?Q?ZYR/WSgPZyvaql9aacibAgYBgvjT6GjtmQnJ86j+IguxNJNDL7vL7ZffsW5x?=
 =?us-ascii?Q?5Au7K5VK5+tvv2fNwqpaAabnWSzNwwpZqNFuGSVomuWdSGq7cU8chVkksA+C?=
 =?us-ascii?Q?yYVKnvshjSnEeceV0/CWAVhwVwOL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVlMjVeP/cks1VrIl1PeMWLw6yMRC5wtwHLmx463XogPy5Ti4jlfwv2A+T8+?=
 =?us-ascii?Q?Ctx8A0GL15KJGMXU41goDwT4Q+mrU/j8JBaKzhKi1UIf4B6YbauSSwwhgKCk?=
 =?us-ascii?Q?ukIBMRb24g+18oUz1CV3MC7IAp/3H7kLjhvx0ZOxV2ctClC75FeGWhyioJtm?=
 =?us-ascii?Q?dxT58rQzvf7UQH04WgHH/LQ7BOEXVoc9o4PY/1XAAznehrTotvnps8JeNe+R?=
 =?us-ascii?Q?51lt9To5L0SDQcG6tJbYwNhxMFaFXu0sYi6TpZYS9y96fNGunWemzOOtKHzv?=
 =?us-ascii?Q?4tnYTIEXBoXkm4NN05EzVPqwNXxeNda6y3k9s2iRCqKlJpxD38slgzJX3/gm?=
 =?us-ascii?Q?CnxUwS4BkKGAQ8co/15Msvc40fPIKAzB1A3v+7fMU/tgMTx2/umZrrJ8v9Yo?=
 =?us-ascii?Q?KNKHHhfec+mi+xvHNoVN194L1wN1cAcdUoB4u0IwNH4UwCuNGCjcRMOkwUbG?=
 =?us-ascii?Q?whrTXFOCoJd8HqYxurwus2OtIfgdQPsJvDRGk8WrHdFhgIj+n58yQT3RNSeM?=
 =?us-ascii?Q?Aly2CSbU4oLOG8ZYLMOH1FprPfWfN+HsAmQZpG9qDkSUv7Fqz8KzQLhvUDv9?=
 =?us-ascii?Q?GTIXYgCJMapT6NO9vnBCuCmAP0gWnXzUHlTs1qEh1Q6ryCFXFAud9YtSItZs?=
 =?us-ascii?Q?Vgqo9YXPnnVcH2T7K36vRr/4wzUKr9ilJ8roRY3cWw3y+kx8egDEyTlUl1Bi?=
 =?us-ascii?Q?4LSrBAaxEncYxaE3R5CJR3MsE2ULagM+WaQfc3MIBkkKN/6C3FH61dLREfQi?=
 =?us-ascii?Q?E4yFYSNETu00jnVZyNnySPyREbtRdePymr1t5w3sgafjYAQcZ9Vpp/Rruynt?=
 =?us-ascii?Q?8Ee/+T+s55rSiUrU6RX3J21w+5U7cnESU6J8ks39szP3NY+YLmJl8gG3eoT3?=
 =?us-ascii?Q?9eDxIDGcmpCM20teE4NBFmWa83kbFp/KfHIR8904fFkfOlKCvXOmhTb7X8ou?=
 =?us-ascii?Q?A7WOGzTgCpVp/Yc6hBFt/2yEdNhZRMP/+MHjBZu6vngrjoEcetVg8tyQAkN5?=
 =?us-ascii?Q?bUu7psMveA6ZZ+q8A0J8SdZE78zGuAbm1JhGMolM4qGEJxGfrIyA2TdFIxkZ?=
 =?us-ascii?Q?jSOZMXbDJIdHihrojja04EnMQj8p7UvrKj0TDu5DlWoDaSL5HoqA5u82UtL9?=
 =?us-ascii?Q?dvSGdbEQorVZNMGtInhgEjTAoGXiB75eWbzfUIZYN3PSU9dj4EWTVVpMgZ71?=
 =?us-ascii?Q?2BuBlsZG6uotoNKokK4367j8/AeBGpPR5UQZtzt4DpZuxW9z10Jb0kbk4sUp?=
 =?us-ascii?Q?9xF5oFKWm2GyndVnqyq9URXqqM6VJj6YB66bNr256AiuPbvt7FvW+ZuuGjwO?=
 =?us-ascii?Q?daxS8rp1WJvOt07S3p8h9CDOni0up6LZRXzyWUzaAO/zqoyitjHaP2wd4ti/?=
 =?us-ascii?Q?ETHd5UKU9QKr1n7y7UOOD47u/CNrSpyfMAEWDmx75Uxv6Eqrdl4cJpRgVOvK?=
 =?us-ascii?Q?WOtO9GNg+BZeek/uFqOK0KX4pqaYgEP/mN4HqUr1JzRApUoigC91uLhl2Qb1?=
 =?us-ascii?Q?Qd9AToLqWdXwUW7zDYN58QRb7mjfyxFrgtFVFbR7yjVg9k+KmIV+RCodhZ9F?=
 =?us-ascii?Q?42r0si4HXVpPLhe3WFl9q8PxKk4FPLtbMn7zBYjqpcxVLbIUK5ex5lKBNj64?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gZf155MumrdwYOvfN7kyFylTttI6Wv9HBh3Y76PiVAEWjVSJwOClW/q8CORZXeznL57DEAaALr5uDD9DcuRzTqRDB2+/C3TNsl+ZV+4XOMoCBftITDl0gUDeaD7dTePDmOa2GadZ6cxwWRwfdbfKxXEnuuX0dPaGeipPWFz0x6KrqWf9ARerVbgXnvmMtrBAEGegkGd1oe54E+8lgsfZTFP2JGJEgcDjslqvC7+MPt6pisAnQ3KCWurG3Fu30foouixhCw8soB1GALdCivEU2V6XjnFEK7S5tZ29xvgnBxxfzU5qPqgGxsSifHoX0D1e4aACmpQOguQMPcYvT04xY+ZANhMJcBhfTOFLVuNYGuBUqVvVk0kjat12AXPi8BjQ1x6rUNHT9uacSNr1P4dtTO7SUL+QSDb8fFmpvQ8w9G1w4hINgOHV+Y56mL61y17FvDW7ATNbpXCW/ZqWZyoyDrUBGanvDIaL/AALEf7VitA+8JcBPrANmC6q51rCp2DYlyok1OASpZiZs0LBDzgawQDIkHesYqBkKvdonI+Z/zndeTSZ79vsoZ0ly2LjFcPrQH9I98lpcQEeCFzsdOf/+eyj44W5Zzs3RBWyCabE46g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bdaa33-7ad4-4c90-b70b-08dd2b3668a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:04:44.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFPkCl+70OJbrEoXti4arEOwNjHdKX7A75PYnNNC5TwWr9P1Ru79PqM0dc0O0+hVVwS+dxLxvVWMO9FlvcZ8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: CX9e7hLgBrbt3SGncPIo2OaE51XUvlr3
X-Proofpoint-ORIG-GUID: CX9e7hLgBrbt3SGncPIo2OaE51XUvlr3

Update xfs_get_atomic_write_attr() to take into account that rtvol can
support atomic writes spanning multiple FS blocks.

For non-rtvol, we are still limited in min and max by the blocksize.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 883ec45ae708..02b3f697936b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,18 +572,35 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
+/* Returns max atomic write unit for a file, in bytes. */
+static unsigned int
+xfs_inode_atomicwrite_max(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_rt_awu_max);
+
+	return mp->m_sb.sb_blocksize;
+}
+
 void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	unsigned int		awu_max = xfs_inode_atomicwrite_max(ip);
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+	*unit_max =  min(target->bt_bdev_awu_max, awu_max);
 }
 
 STATIC int
-- 
2.31.1


