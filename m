Return-Path: <linux-fsdevel+bounces-32142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552259A131C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3861F21FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7DF2170BA;
	Wed, 16 Oct 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASdb4gVT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p0OAdhVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CB1C2324;
	Wed, 16 Oct 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108833; cv=fail; b=Bg/5duycgn1Lyo7Kf3b717nNQQ2q1brg8GaNjLRfX8A+zoAi4IHIF5o1DQmzK3CZHGvxte4YpNK+W2Anbp91AHeyG7kGwR8N/xWp7szhnIaSYjJAhc/1BFjN9nXSqEG9noJBF4AkaBlyFy7pnveGQkN+kSxn/Zbur+t12GREZHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108833; c=relaxed/simple;
	bh=IRC/XOeIUNVapc/mbAS4OR/YiraRBN7zwqXlrCKaG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mfh/rQWtPJoW17kImcsb5quIe+C5U44UO53wU4qyMz6RdY8It2gtkzcEnmK2HBtyPYNM4vzSjQVpmDLBGW6zqRxsoHq0LrqsTSBj/a70c9Bifg4zrvQsuVFixz6ilSQL7aUVZd48fE6Jh44sTaVX7E7CVkuXyynTVYa017a5AGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASdb4gVT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p0OAdhVB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHte6C004874;
	Wed, 16 Oct 2024 20:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ChEUAvslQT82XQhpA6
	VkV3t+NAdEM5VW0BhjpuzoClU=; b=ASdb4gVTen/Pl/LuiDrvNYy6Ta60xSPDn0
	R8VF+xV96AYEOlJbUM6GrxUvXf64lMX61mRN9dmelwB5sarjv28gfDSR5JRM0YBh
	oUyW8CsVI/t3PXa3Eg8S0j1sqAhcLmYYn24L73a4E67Jqy1fOTRTkpolnq3Fa+uA
	v+9ocG5SM7z3dnQrfGvbFZKNyiWTWKWNrLVk30pfemU03GYWtKF70exXyuwfRfcg
	uXRSGtNyskdsCmI54iU8ypwOF6pO6WIzXdbMwWP0XmqXTxlVBH7dMNJcbDrGAiaR
	A1LybB66vxsuIj0xFsMjHfNyUcPx3hAEqbKI+z1N4WZUlXrod1LA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2mvte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:00:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GJ3tZm019983;
	Wed, 16 Oct 2024 20:00:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9arja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 20:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQEpFLV5puoj1TIFKWcCIZZBySBwFax/Y7KbDFutbWTek0ZIj+r318uPLBFqAMq0Crmpg7nDgqOjCDNy1efNN39QR0Ghy0UJoYrfPKivUQ6fagS+0AtGbEEt8trOUpCx2TZKUUMFMzwAgs9p0KCviKsbZP6s9pRDUoP4sxAbs9JXaM8zJEd/Hj4yJqckq/N99fAWnj8529YuBTegPBsvSrvY6odjAFHJdrgc8xVqAF2HdxAG3DGOgw+cZSLIGS0XhLWMMyi+g/8zAyAxEjIy/PZGlBrqYkPI8lxVx31my987/nwdx2pVJUCPiLm8YZZJL2wPGJ5P1NS5YJoiv2YiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChEUAvslQT82XQhpA6VkV3t+NAdEM5VW0BhjpuzoClU=;
 b=EVjPAqYNUcl3LiVlypeULwAJ/HSV1gE/2F/2WpSVp17fneOLs9dMPWJYHEm9Cy7uJGs7bi7hjwme9Qhe+2hY1ENqZZt4x8+NZsbo/ezVGJPxCPCrnC5PeqkSrP6OtxNfHqJ5u8QMWCnRFY4TGQEwx6gzI7Wf4QOO/5ZqtrEqr0IgtiZGYMhKTS3kzYnHZHfaV2d6fH3+1TEMQN9SyxlcggQ2MtZRFRZuQXjc/2nLT0ORfW68L4+wTasyXiG8prIXP9X4SLti9boOwWT+c41GFahhngUAb44v8JaxydOb1IG3BxVv/UJwbxW8hF7DCsOYhCbHgq76JjCGH3VwtBmFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChEUAvslQT82XQhpA6VkV3t+NAdEM5VW0BhjpuzoClU=;
 b=p0OAdhVByw36B+NQd19wN5UdJYlTGdc25mmuH0D+PZVtoh1xJhlTejCYRaseUAH2fxEGWV1jAmzV5lFVDkGF7kNdPtLTg3Tpui/8kCUlRpiEeEm+UNx5lyZt1HxHcCLF6o/MuWz7gm41yu1GBwlgBF/AjmWVnytap+P8OWLI5Fo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB4986.namprd10.prod.outlook.com (2603:10b6:610:c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 20:00:07 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 20:00:07 +0000
Date: Wed, 16 Oct 2024 21:00:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate
 pid lookup
Message-ID: <9294a556-345e-4766-9b54-1a429bfb917e@lucifer.local>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
 <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
 <20241016-beinbruch-zeltplatz-4bfdedca1ee8@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-beinbruch-zeltplatz-4bfdedca1ee8@brauner>
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff2ea36-f579-45f4-4c79-08dcee1d2216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YQiWXbl+k24QIAXLLY3O83Gcq9zH7/lLHH7i0RtOC91EksJ8o1NfaVmAP/UW?=
 =?us-ascii?Q?ftKVAKnVy3JoqjDx8PgaIMDhevadnz4VxkKZj/5dah0Y33rfmpvjEGUa0nV1?=
 =?us-ascii?Q?D5kWu7aT5GvbY3+++u9qIBgUTWNTdtuDuVdVwGjvoMIwj8Gr0Sj8zxkrGY0c?=
 =?us-ascii?Q?bYWu4tTkDx0NnOoWmowwA7VpCVXkfIqVe7AHbKPEgvL1q417ClY3cpNtxuo3?=
 =?us-ascii?Q?bapYDvhnTNH3iFQRRnHaMmTSHBmIOAJ772jFhjz1fv1MQ//P9JuHd1qeCB67?=
 =?us-ascii?Q?MKPls1eeMHySIKdIWMS1upIQ2krjX7wzrs02R/UE+IWogepyRvneYTF+Z8/f?=
 =?us-ascii?Q?qp2XpsmYweTks0DHHvMF1PH70OvlDhbFaHEQhIi/Aq/GWTGVhX5CZHymSdxX?=
 =?us-ascii?Q?mS2LyePNnJrAHmEXzyRbeEcbqcQHShVR/egrXOLOxHwbOFQSlqRwktRd2arO?=
 =?us-ascii?Q?0XEu0EY2XulTr6QMlQyBRntT4MBPEH9xzFMvU5BIWdClaDXUarsvC1EICLh9?=
 =?us-ascii?Q?OHaaYYrwcZ5qkhETgRQ7mDRSB/xEVWcnvBb5IPeEzJ6lfQysEpwPEHaBl3Yl?=
 =?us-ascii?Q?zXiE1DpxiLdpNeMYvDBP0110gw3rJr+98EID4eRbz8t6JCDV9xkNE1C7D3xD?=
 =?us-ascii?Q?xV4awI+XKh+IIXkxQ/WqHgge+F2at0i7Hjdhk8g9n3822NfpENIccFlU0Unx?=
 =?us-ascii?Q?hieZE1Z2Hqkew2+nlS15+58W5UZ9EwymtX95p500NjuS2ybjlg50Myou4DqS?=
 =?us-ascii?Q?0FqKcZZrhKxx/fnBwnOkb250bHr2eBrQVxKL39HA8vFDXFRViv6hrWr8HGGe?=
 =?us-ascii?Q?Bsj3Ti+8gninOXu5yxIFVH59eIJVVhY/TKLAxX80ylT6q9iyC7LrbBKGfexR?=
 =?us-ascii?Q?WFOsXF3i/iFhsTImpRB7sb9N5tvVHEVSdawJOYvy9LDVw3uRGtBckDyGIkeF?=
 =?us-ascii?Q?KQS4hjPLnHKw+gGk9NOsCakvp6Dn3y+8kzXcMr96tIJdNdyZMsJt+qnJGYGP?=
 =?us-ascii?Q?DlE94t3AxjW6z63Py8R3CmwEWFoE/A3KbcpBsMTCzaq6MzA4cb7yqwwDUW0A?=
 =?us-ascii?Q?tuaXENVl0xsLPBLTrhglHWxsQyPug/XyzI0YDdrwOKJh9CbzZqsMXTBtS62+?=
 =?us-ascii?Q?e0cmiFRYGutT1hEhTDK+VKGXlTUreOWWy0Tj5732q6gzR7M/x74dCwk0YV1c?=
 =?us-ascii?Q?dRaCf0pniK55JafzRMjYgRxXtfMuiXX7JpRDS1cMlw0IyHYxaHy4TjYzSr1U?=
 =?us-ascii?Q?oPbrO3/iH3gseHxLSAfxK/4DmM0/Dj4zR8kWiXrkaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V60CyV7VsT0dP3tojy+Rjb+yDxY8AlIwvvKn27SKcXxKs7M35AOl26V7BMPP?=
 =?us-ascii?Q?G1ElXT577+r+LIa8W19v2TLVqAJxikiSbbIPyoRIjQoeq7nrCAVRzouqrwDm?=
 =?us-ascii?Q?JBKf0xClAk2M+UaHVlA3deizE/HhWu+/C2rCJDhdzmSsjpHW5LUI2NYJzcJD?=
 =?us-ascii?Q?H8DnPoDj5rPHOY1OpnJJ0xzbcAYxHhnLuKBnLbFXR1/sWqype9QrsvokAck2?=
 =?us-ascii?Q?jYAEsGqgoAqxTaTssDO/QcFhvOi483GPd+8KurX0Hf9Sx+OxzIQPrukIvfP5?=
 =?us-ascii?Q?2lWXidnZaP0pvRUaI/uWijBKM7IO2krA41nst4ZdXODgLtiqPjIaLvp8btKf?=
 =?us-ascii?Q?on4yMD3GXqyuh8rc3BF76LYqZS+38LX/ea2//MrHk26A8mFlZFaI6QGfWuV7?=
 =?us-ascii?Q?fgEMAn5Mf9hbGpuP3sk4Z/icFWOOghFh/Ki5EF4MGH1Ldmvp490NNVZiQ/sE?=
 =?us-ascii?Q?rmm4wc4jbzHPpGDJuZQhT1Wcr5RVgsycGYxrh1pXiikZWdXJRpfAhWa6a/jX?=
 =?us-ascii?Q?t9van4Hd4z0Q37CkXFFU683iDi9n/g8A4FX8TqRn5tUB0xH8QygL3XgtWO16?=
 =?us-ascii?Q?Dbo/HYw4aoN4bhr495whPu1NUn3G7IY/HBZORuIiOrzyGLLU8yNG5FUa0FYz?=
 =?us-ascii?Q?3L4Uv4+iIp+TqFDwUcrvnL9ia5xFDPj4OV/URL8r+tIoqyBxqjwQe5V/2ifJ?=
 =?us-ascii?Q?qa6U4gins0H4X7l6uvoA7pHFQvtIht/yUqheNIr98GvZLhF6esE/Z8wUMpBz?=
 =?us-ascii?Q?r+84mG8Sn9goancOjAXeg9lK1bBr3uk0YTkNT6LcWrmPD/rHNwFDMA5YzbpX?=
 =?us-ascii?Q?evitFpabDenKivSgpf50aZrrhJsbo1p8ZSO0bMPzgWnw0xkCr3Znl0noiZCK?=
 =?us-ascii?Q?kAj7R/GwkMZxKDD7z/9vIR3pJny/gOZtxSAv9Qp7Dk5OJ48dZjRPzEvU03mk?=
 =?us-ascii?Q?aXhCsUCBO2n2qOyosbzVihqmia3Xh3x0A8jFbJvo76JXTh17uGPj4F8lI7HY?=
 =?us-ascii?Q?5R1PSmUpcF+C6MV+Ag1bAu8rlxAwHmC2Ha0pS5/dXD6ug2Fasvdl9muhNHZS?=
 =?us-ascii?Q?pl15ZuFugro0V5PXE1/fDGvXC7RrnBFXz/l30QLUz0h0P5bXBqdm8xmsjhPx?=
 =?us-ascii?Q?taCbHNirPqrUhFMg4puUbcg6xK6NaIBFiF2vUCsagDr9CB5FaAN7ulpQWBh5?=
 =?us-ascii?Q?HkHLfA3Nc/ol2Y7D84NvfbYc8a/f/kVb8IhXit5RCucR2P4SY5UQBuBg8a/M?=
 =?us-ascii?Q?WlTHJt9V0JjSzKrDQ3azBoQStUXgt5ik8+i7wwy7m6urhTWqD4Uhechc1+uz?=
 =?us-ascii?Q?gkjHGHUxHmHBSm8ySC1ddbRDX4+iiUWhxjjJsPjmt+UJcwXnDSdZ4cy+wPmT?=
 =?us-ascii?Q?PQ5B3Zdkt1hzI0uM4wAKPyA29Xmmia7g016mQjSGw/5MqKarLtWvMCf2fb4Q?=
 =?us-ascii?Q?cXHAWsZfFErN1icv19dC7+xEnTpURrr5Ae4BbKUH/dZZnIlikQsvaw46/9yP?=
 =?us-ascii?Q?AbqJw4aUCInj8zKxhJsscIxeaxKohXIK5L5D6S/xvMCAaXRippyZEKjTM6AH?=
 =?us-ascii?Q?N+z4P2Da/PO7z9gSZQsleCzioUQ8+ByrgLrkLPo6k1mpzYDtX5im2dVS1eMh?=
 =?us-ascii?Q?MwHRqyrkZEjxu7RH2Cy3P950/YTwgZ2kUx2+JJIfSs1q/qzIZqHD/sM4bbfc?=
 =?us-ascii?Q?bsiMvQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0yzLvoef5SiBEM9p8c9LgANlaBvp3TCXqLXw64EKoQDesnAQrSToLkpuj7Vi4/MBdcbqvs5g2XnGiAoSgzRgkSQcltD/mH9yUaON0NeRxe5wwUAZY2UqasLZjkwsvktPfXRtRZUlQwJx3YHbUp+SEG+cfSgnRrsvB4AAUXMIuub7GyE3o4WXxjoV6HIqu482dgnpvLkixBtLAHDczF7AnAD9tupNnRcz5gfxWe06moGNqXoObz3peRC2zdL0U+JVnpsmN0WTRMSzqFYse2/2DY6k+5V77fONruKCSTrrKKeEPj+xHjaGPDbjr91OGduXcPi2vg+RofpYdEyhRP7TSIHPHqtvtO+XI6rhk6XEnhSFJZ0vSfwfTt3IARHtv82+yrzYtICgfic2GpuhD8XXbVwdFKdRTd2XJ9M8RT45NRZZhCKChfRLsAyGWLdh4UXSl/tum9dsFqd2O3wlIp5m+s+9OrOteXUNKwg1coV6EJ8ubqqaDMkosNIM6RqpHHmh+sISVut4fdfP/M4xeVJwNiQK81tT4NgtqUv+ozUI0hiyRPaWPly3VoDj/lzLXS59o/jF/SRMU6s0h3MRibn05AeznrttfLzGbwyylfTHU1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff2ea36-f579-45f4-4c79-08dcee1d2216
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:00:07.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxDk8aIeIS1mDSpK4GimX+tvfxEdy4ajcutpzmNtp1V+FJZVpEg1qgXSMtuhZFwXPhob92xUMd1N/ookQDM8j6xLy0tAHInL2U6DHtzBJ5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_16,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160126
X-Proofpoint-GUID: Rkh604OcEQphwIlsT625AIyDvYrjdCFv
X-Proofpoint-ORIG-GUID: Rkh604OcEQphwIlsT625AIyDvYrjdCFv

On Wed, Oct 16, 2024 at 03:00:55PM +0200, Christian Brauner wrote:
> On Fri, Oct 11, 2024 at 12:05:55PM +0100, Lorenzo Stoakes wrote:
> > The means by which a pid is determined from a pidfd is duplicated, with
> > some callers holding a reference to the (pid)fd, and others explicitly
> > pinning the pid.
> >
> > Introduce __pidfd_get_pid() which abstracts both approaches and provide
> > optional output parameters for file->f_flags and the fd (the latter of
> > which, if provided, prevents the function from decrementing the fd's
> > refernce count).
> >
> > Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
> > directory, utilised by the pidfd_send_signal() system call, providing a
> > pidfd_get_pid_proc() helper function to do so.
> >
> > Doing this allows us to eliminate open-coded pidfd pid lookup and to
> > consistently handle this in one place.
> >
> > This lays the groundwork for a subsequent patch which adds a new sentinel
> > pidfd to explicitly reference the current process (i.e. thread group
> > leader) without the need for a pidfd.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
> >  kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
> >  kernel/signal.c     | 22 ++++-------------
> >  3 files changed, 84 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index a3aad9b4074c..68b02eab7509 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _LINUX_PID_H
> >  #define _LINUX_PID_H
> >
> > +#include <linux/file.h>
> >  #include <linux/pid_types.h>
> >  #include <linux/rculist.h>
> >  #include <linux/rcupdate.h>
> > @@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
> >
> >  struct file;
> >
> > +
> > +/**
> > + * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
> > + *
> > + * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
> > + *              @alloc_proc is also set.
> > + * @pin_pid:    If set, then the reference counter of the returned pid is
> > + *              incremented. If not set, then @fd should be provided to pin the
> > + *              pidfd.
> > + * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
> > + *              of a pidfd, and this will be used to determine the pid.
> > + * @flags:      Output variable, if non-NULL, then the file->f_flags of the
> > + *              pidfd will be set here.
> > + * @fd:         Output variable, if non-NULL, then the pidfd reference will
> > + *              remain elevated and the caller will need to decrement it
> > + *              themselves.
> > + *
> > + * Returns: If successful, the pid associated with the pidfd, otherwise an
> > + *          error.
> > + */
> > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > +			    bool allow_proc, unsigned int *flags,
> > +			    struct fd *fd);
> > +
> > +static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int *flags)
> > +{
> > +	return __pidfd_get_pid(pidfd, /* pin_pid = */ true,
> > +			       /* allow_proc = */ false,
> > +			       flags, /* fd = */ NULL);
> > +}
> > +
> > +static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
> > +					    unsigned int *flags,
> > +					    struct fd *fd)
> > +{
> > +	return __pidfd_get_pid(pidfd, /* pin_pid = */ false,
> > +			       /* allow_proc = */ true,
> > +			       flags, fd);
> > +}
> > +
> >  struct pid *pidfd_pid(const struct file *file);
> > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
> >  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
> >  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
> >  void do_notify_pidfd(struct task_struct *task);
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 2715afb77eab..25cc1c36a1b1 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/pid_namespace.h>
> >  #include <linux/init_task.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/proc_fs.h>
> >  #include <linux/proc_ns.h>
> >  #include <linux/refcount.h>
> >  #include <linux/anon_inodes.h>
> > @@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >  }
> >  EXPORT_SYMBOL_GPL(find_ge_pid);
> >
> > -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> > +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> > +			    bool allow_proc, unsigned int *flags,
> > +			    struct fd *fd)
>
> Hm, we should never return a struct fd. A struct fd is an inherently
> scoped-bound concept - or at least aims to be. Simply put, we always
> want to have the fdget() and the fdput() in the same scope as the file
> pointer you can access via fd_file() is only valid as long as we're in
> the syscall.
>
> Ideally we mostly use CLASS(fd/fd_raw) and nearly never fdget(). The
> point is that this is the wrong api to expose.
>
> It would probably be wiser if you added a pidfd based fdget() inspired
> primitive.

I think we can actually probably just avoid passing it back and pin the pid
instead of the fd, which keeps the scope as before and simplifies things
generally.

Let me experiment with that!

