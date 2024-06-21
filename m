Return-Path: <linux-fsdevel+bounces-22099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7791219A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836C01F2590C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1266B173354;
	Fri, 21 Jun 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctkGDptU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vHZ1/mKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00061172BDA;
	Fri, 21 Jun 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964389; cv=fail; b=RQk9Yotao25o34Nx4RvSTbOf5i2Ii9/J8djd2Mmujy/fMvSTVppqktzQD5P65Xdr9Zu0/CmVUO+zwy1fu+dIi+fBys23hIh2/cC63HipMsrLcnK0MDCZBtsA31chWhng0Az/WK5PD1n+iUirhmnmgu3+NNrXwYrzWayW6HQsgFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964389; c=relaxed/simple;
	bh=lI4IakodFeDyKVGgRiu0t/W+URDX20Vh631xFihAl/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1PEvKzEqjECkcZACKyANzdFbBUMr2//bl/fLs17QpdD3DHpyXP9sMlcC4upH0yay7ubemCwdn8LNDM9O/c+I0mH5Dc+rpaE6VQUTc+ZORkqnLRBABD0D4r7vFSBVOK70ICRwmAMclMwvAu7mZBYgjpNqARr5pakkqe9PhViu8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctkGDptU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vHZ1/mKi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fV31026946;
	Fri, 21 Jun 2024 10:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=; b=
	ctkGDptU2EdyE+jcd17Msu19x+UMgVqbr2QRQjNRjLLHBAwFVRB1e1j4+8W5G8nZ
	lJoCiRcyqwzUI8q5XIxmI4RIt80h+N6KnTsiSC8vyyr179mr3DlVgOXb4pIYhsKP
	XO4YA2HkKBbi3YA32XEQ+lqXBsx5CVYLjzHLRgI666tfclpE6SVmWyTJ3iBCTbBA
	i3z06MDQfuA256Fwi0YZQSXSW47sPENGbyP40O4w/qZ5E7G9GMkuw3GlcfN/Cqis
	UYkSnHKEqSu6IBzP1f9QrYygHfV5Hq3wGzCklAIzJjKz+H36B9beCBQgU9oktynK
	09FrEjyQHcPtR5t2svDRiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkjsfny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8phaS040090;
	Fri, 21 Jun 2024 10:06:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn44xv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENqRWeAXcgBl2RWH2bfaFKHShat4r91C6UaKNoOq06KfgsDRgoG0ZxXKhCSth1PxUrt4qL9wzxXZ3IAeRKoAyhuevw7VLMtxtz5NO3N763mfwTJXBafGdSVOgObPWPHzgfTuD+bc97FQm/IIuouuTWEE/5U1EAjZKp55G7KCSywQvXsGCuFSoAS3c0ROb/E+yYGvVHjPPi1RoPmKhb+kI0qHz+kTu+PBB4k7MNyxpBilLUdqKy50NKgjs+1P4mhePMz0T977Ind8e7SQa3uccm+l8UH9shZx7blJ+qfZC3PnpIygWf6l3qYdRR+e7iuJ2QW8r2nuiDnHWV43AKoAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=;
 b=kQF9kePFXwJ5e9bA8BqiLbS7IQ2U7hsUUUZKFXDF+VElPvML6WYbdudEyGd8WcRBWVdAYCuBIog3663++uMxWvpnT4xoRwKjyWowO2AmmGvwweJ6B1c+jiEtKdtMqRgngAZ3efQ7MK6JgsgwLjKxdR9pqVx9RU6zL0aRLz8XhdITSH7dTxpHHo5dWdhfAjafU2/Hgu9V+rRnVsWYWdGKHge5mVHMdAnSIL8HBIUmQqpFN/Cejtebly2zRtraVkE3cZ/C6gR7vlp2bdEz2M1/fPC0WwgemCEVuKX2PNCM0GBV7rm4gkbVzEVsS2artkGHoiPjyxLAW6l56cTxC5fPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=;
 b=vHZ1/mKiRsbrpSPr5B6dLTeYzyu/1uN+W+uy7eI0/CbqCH2JHDDKLpiL8JFn8z6yILe6ihXFMmNy7TP/nZb6mL1+J3NQcD7eu3n2JiBBcMBerW5jK24ZYN6o7MvfOBqsc1EeQjSdr3LUivJEj/jH9ngqrBpWTk7ktVwwB47UUoo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 08/13] xfs: Do not free EOF blocks for forcealign
Date: Fri, 21 Jun 2024 10:05:35 +0000
Message-Id: <20240621100540.2976618-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: e13db29f-6e7c-4916-6a2c-08dc91d9c81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y0ccG/cy/ur0F/RUPQzfj5UmpN/hDMK/dipn1zyYd/MwtLYx4U4dFDL3xJXq?=
 =?us-ascii?Q?IWl6kzjjNB7GwNn86DfF0y9hIZQ4RUZueO0btO633A9uTO1DyKHrqQ5ECPFV?=
 =?us-ascii?Q?o8Icmkweq1lT7g2w0roYFSUeFCkkd2an7AFtiKLnWUKvpduda8QaKjDBrC5/?=
 =?us-ascii?Q?1DUzQVLmUqV/H+6i5LV2ua2ea3JLehiyY7/GDKzQmOxGA8ImVVaddVpVNyjt?=
 =?us-ascii?Q?hTqxHaixPBnchWa5XN+yudbz+2TGpQZga10g7ZJySlYTINQLPZB2FRIQFQGa?=
 =?us-ascii?Q?anHxfzl0ruZ8izmqiyLIKpUteuEHpMaBQL721W0+qWOs4c/x5Td7EfxO9u4W?=
 =?us-ascii?Q?3WqaxdbVoXKij6Mwd0C2ozGVz068wVbsYmXDM5SWoJH9MNyiNGHUJe+FfkYm?=
 =?us-ascii?Q?VP1r50JGm1wCGX491HsO1atVO6An71eGg72WAgpX0wInd2hinetVHBifmkKe?=
 =?us-ascii?Q?3Smo88NJPV/h+EGVEYDk7IxOUtR+bdGO+pXBy59bevKrdTYq9ifw1KryV521?=
 =?us-ascii?Q?h9iI8yuXEZ1KCKZPblDBmWZDKC5KnU0PSWNRHOwHysNvHs7e3q/S71rzkNjI?=
 =?us-ascii?Q?ZztL8vRdhM4XdPL39DVhsnf9r9Mq/SWiA1a8IQza4AKfREXGnqRjQLdg7PiY?=
 =?us-ascii?Q?uC9eRZnPOrC9cvJl2bYC4oOdvtsoIhe2xiBiwjGKFCqFJ2dqvdn4RrNaAISz?=
 =?us-ascii?Q?pOd9MDi/OpiCGfo32rhRCHcZ0wXd2zT/RG04PoTxwB06yhydqGeqKh55N+xc?=
 =?us-ascii?Q?wHpYJonCAFgu5HS2D+ViiIptYByQCcYSh6qJ3bGQW0Uhp9KCu9u5BVhNw0j0?=
 =?us-ascii?Q?SiFsaM7B3eXIpp7qjw8gFqFcWBA6oSYTngPTrkn3xUdu226WAhX88FVl520N?=
 =?us-ascii?Q?F9z7MG5XJmQwph/qnAt6ygN98o+hiBU3zgkev8yDiGTBT68hbsEiLlZRKB0K?=
 =?us-ascii?Q?I8/9B/apYLqcVpcSyOBuVpraElpFSVkWonWOxSeft3KSR1RzJZbjUSJyQZ9l?=
 =?us-ascii?Q?7n+hGtfRMGlZakPNM3AFdQPuopF72nk5r+8qsEqSgf31g87X6ZAyL/8UyZ27?=
 =?us-ascii?Q?Ds/Ag7CoetZ+wCL4/TNMX5m92uC7+tRBpQNi607bt0QXidKbp2CcU9WO9ymY?=
 =?us-ascii?Q?7eReFvCcNh1Kr6qmyRUL8kTnKNj5zIf6p9ksYQPMk3FzAAUw87VbwRzEcYjU?=
 =?us-ascii?Q?f0oXM7YIv3Uhd8u4L0fZa1+OkM3BHlrN/ELUbDEMUcEbAihYHKxXdpzG4ZpQ?=
 =?us-ascii?Q?syzrxFqE7rb8zQZD1RWOUjm1F8kKiBqClapssrMcab/WmqMaQ4Bl2/fWbooJ?=
 =?us-ascii?Q?gM8YHdTHY6eCyDGL+2xDOQeH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9jni+e10ApTzNfy4w5d2a/RcUGhHD/hFl4d83T7J0gBYqOORNw8WGY+N4qLb?=
 =?us-ascii?Q?LJzwsIP1kCRhdfsasss9PPqsJwxG/4+t/56p5bmR/dnneSkkWnO9kp5FXyLo?=
 =?us-ascii?Q?EG9jye3AfR4h1PbiSlzRt4Myl/Fih7BT/IHq7Mr/q637U0gcOlpAPsDVTMVv?=
 =?us-ascii?Q?8L6H7J+K7XLEpSnlIeE0rSzu0Byy6LisqG3X7izcoXv8pTVJ2JcByGBE5WuD?=
 =?us-ascii?Q?6oBTVXJQHgK6UOjyF/ncshP81ASAK8stmlHcI3TAZAwwXEsJ0LC5lTuPlgrk?=
 =?us-ascii?Q?j4/0xEIQiykiBPbIxD+aWaHMnxChrvJpk3kO6XvMzTc7akIEp5qIg/oprdDO?=
 =?us-ascii?Q?1vrK+qas3JAfOSHLujVuqGlFL50mHrIn2Wxg32gnoHiS7/B11vpwUwK8gW/1?=
 =?us-ascii?Q?+FXfbllppuyeBvp1uOczRAICls1X35OZ/QoVK8J9BF6TQ+4kCA0l3U1MRo+b?=
 =?us-ascii?Q?+rFPHNf3sGfXFzSIlloxHucfp18KGAbagAKB24fHx/f1/htucw4OUouIRv7W?=
 =?us-ascii?Q?mtkaycNhoBHGaj80ctKkjkWhAHl+VUi/X/I4R1qtn7zGC9SmHG6rFP7YSWqb?=
 =?us-ascii?Q?2NBh3cx4ej8FF1mNsZJNRPzGVCoD4nPf0C95RUZhI34DA+m6Yk3gyYsKApSP?=
 =?us-ascii?Q?FQR1/eNlrRFr9k93/vaeac33JMecuJl6sRqHOksrT6dNcrcTVvdToi354Nte?=
 =?us-ascii?Q?K30LRveaG7cyNCQT9QMioaehMcwBrsPc56lM+N3YitQni/jEHhVCHYsboNHE?=
 =?us-ascii?Q?+ReRyQzuJKixV+rMhq6hVtWGshI++i1855bUZK/Mj6hiwa/g60x/VI9zRs7s?=
 =?us-ascii?Q?b+1st1o+Fi3ZtNuGHqlHpbAZj3wkeFezigqMnqZMqmUo59nqzd1x5EyKar7J?=
 =?us-ascii?Q?66wXHA+9lMbW/ENcoX0YoSIZ9/R9udR9jPF9aMHPL6z9YDXkK4GObiyfV8mt?=
 =?us-ascii?Q?12f4jZA1n20ld7h4rkCW48D60F+gmt3Ea12uvwFs5KpN1FjPQPPjmUNOw7u5?=
 =?us-ascii?Q?MMB2MCcoHdTrsRKcTpw8+NwKtRQyJzh8mqN1S2Hl8cUPAnaM76rX7o1oQrH1?=
 =?us-ascii?Q?YcA/zXeCpORxn9c/1GPUv3orm5neFx9FsPbniDHH5QaqlN1WENKri2bJQvw0?=
 =?us-ascii?Q?75zOHgHzGwk0j2euuWS7RhaZppXiH0z6KCOilxKxDq3QSzcglsuIgRaa+nOj?=
 =?us-ascii?Q?0cMLNjpskIBLPslsqD48gXtwA1mD8hrotn/NIWAU6BA0Kp4d8Nfrla6mmpHd?=
 =?us-ascii?Q?Ro9qqqGZCcFKvETRoOS4lIPBfREX1Jyb5pgiSKNLHkMKyssNC0DY0a2MPrjI?=
 =?us-ascii?Q?FiagDSIqj6BweYYVQ8ccFHM+1b6ZLNcygERQ4dIDYD/dbH/TyqJrnVruhfsV?=
 =?us-ascii?Q?lJp/xU555p7CSGKpSulNIHHfrQZ21BSKVOShJGOHZuUwX0ceZyTaho1GZmb4?=
 =?us-ascii?Q?9O4c8fbfL/GTyutLr2o/kFXV8m4EK4c6eiN1w4oAb1vk9X1xiWe/h/xq5Yyt?=
 =?us-ascii?Q?0G+bpon6jqMjUODtnPiahrNyLKuv5x3kPWClIBKD+u2+5TMtCjKQ+SmZfxR1?=
 =?us-ascii?Q?9udcQs325JA6lWJBTscR0iPRcSrUd+O9oOmm08OZg9+aPpXugQ6KJW4n8hoM?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G+t8oKt1J11dpEmAcVpNte2/k8vLeUT0/qtNa5gdcJ6QHPZNo/ox7LjWZosDWVmY0TR9nMn2GTsFrZcRWyjruduM3rXEqYtjMRPQ7ZTEuk9qZEoQAzTRVIrhbIES87KxGWTthWPV+He+mVoumjxMd45uGVDwezBgLW/5SyBbv1YLqYs2urcoqv1BdPl4DLyaTOcBec1d2Lr7udaVDJjRI5yg/MueANql40jCOFtcF4Dj3QJe/yzh7YlnAtH02NYzO8YfCAxCBl6UlC+ATSL2nhylxm8to+OjEaLlGwJ1fVE8rGoSt5bW19hz0erJYTqUoYpVUpmVo7l3hZghzFcipyl/enlIOtuo0WFqNX6RkmMpFPnBdQ+VwelsD5KjP6Q+QYQPIV/+P7L0YQjrHk95QAIqa7Tj245fHzVMMFIpj3Hp+8/1apTs4FaUy7VavCqEClGlZ6tGaSgbo/bbd0mwhkdriZq+YinSups+NfGGocJYefj/+f4rDVts3siwAz7uAXUNQ2EsUi+aV41zV1E4xd/JSAFRir0Qm9qvrsGPx9V1llW//u8PKaXa7hn8aSpjPMRWeGWsUi8CVRc3VEHFJ7ALbXsmgtGw5F9AG2x0/NU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13db29f-6e7c-4916-6a2c-08dc91d9c81c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:13.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2ytEjQLQ5O5UdKS1Iqe2mo9pvXvs+zooNfT8B4rLD9egm1zzs+QISYT+aEpzwHcAtS1xMq/U93/SeTeEBKHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: KBs_vu-SJIYhruRDsp19HihFH5eSC2Al
X-Proofpoint-ORIG-GUID: KBs_vu-SJIYhruRDsp19HihFH5eSC2Al

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index e5d893f93522..56b80a7c0992 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -539,8 +539,13 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (xfs_inode_has_bigrtalloc(ip))
+
+	/* Do not free blocks when forcing extent sizes */
+	if (xfs_inode_has_forcealign(ip))
+		end_fsb = roundup_64(end_fsb, ip->i_extsize);
+	else if (xfs_inode_has_bigrtalloc(ip))
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
-- 
2.31.1


