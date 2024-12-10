Return-Path: <linux-fsdevel+bounces-36935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0349EB16C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F11828111B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B531AAA2A;
	Tue, 10 Dec 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQl1qhDv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b3jh33ww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED991AA783;
	Tue, 10 Dec 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835514; cv=fail; b=taURncOTIn5X6datpwOwsBXFw7OmGqLvkIK3fGJUHJS1T91Zm97Vp5uZYpAPXcddh3FK34EanIaPpAm9xKWUm3srLgrDhVg+OlxVSklspFAf68FC+afEIXwIkk+lBiO9ayceO7zIz9KbHf73/SI36U4SswM1NTFadq4Y4bCF2S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835514; c=relaxed/simple;
	bh=e4ERBggPKMxBb+05PUo/HyQcT4nY982FvTK/u880Koo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mapphzyQYwQs/92H9mHp9S6G5fG6/UD/cFOKMagPehIZVBBAkuT/Wr+rKOrQYZhJeEnixIFsOujV4RQQ0bWb6442+DsYqeByG8CKjhDWA0flAqeBGo4lEXtvlGzzY7LVRYhVE1pjywnuVawB6CUgsn6lSjKU/pRjxqORt4BTRAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EQl1qhDv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b3jh33ww; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAAECWX005021;
	Tue, 10 Dec 2024 12:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GiDMCOs4tUlP7+rR328HAv7BPIn+wLUf9dClYafh+ZI=; b=
	EQl1qhDvaMANf7b73MZyyG9mx7f8AHajugMM83jcF+XJp6PnyWMkyBYhjJNVulIW
	x8HSTguGD44ijIIKnN+mSjsBtQb00bylXwv8/pYpL3MY7EunJjSIBY5x6tR3nQk5
	mLWoOzltGnOqcEFUGgk4vpjx6/Bzdxm2wi6Wj7Pb9oX2iITz9ZyXiBsflJ490Tjs
	p7pvcVKK4/x5UFtAN179IwfcGOg2qdnFuM/6sORZnPb1+uvyHtznhh2rfxZtHtPU
	J+RpsNXyG5CdjjexAe2UApc70+kJ92l+KE1I/2NYaHAEq285e7vPiB0QNATFi3qR
	CCph9FQLGAx+FrKU9X6/fQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdyswntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABnpXA036434;
	Tue, 10 Dec 2024 12:58:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8kuj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVgFX6Gxp6WAp9gizeci4EvxTVSAhkjQNyH6P2n/w1S+iNbOcc9EXlM8q7X9ZSxvAN0mDWkOiZVrTCFoI+10FX38prSzljQFioAGsVmVGsqRJqm4ph8uqyvznvXcUR06N4+qZHwlbd4AdioNW/bVfHh2ROj+bhO9GSUjJv+V/DLGR39XzhO3kAtObXRt2stG+WyFexSbFzPpOpyMPSZSkPSLkBN6an11//gSCIN9bOmkoQFE3QCvHdGZG9/U8OhNElbg3TyAs8zlYPhHgWJ3wZAoU6rZ6BGCSmWadVcvLM4oGeXNRmVaz/u8zCfVZvnabol2uAnWRF0b9Ph0RagduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiDMCOs4tUlP7+rR328HAv7BPIn+wLUf9dClYafh+ZI=;
 b=n/K27Ay4jQAQBr58uqC2az/WPkd8JlvgqsAYbWbXjjRFOw+lZQgGUxtuBrRfr2Ow67AIc54TMWwGumgg0LGTLas3GkYcVV/TRlye4+Aa9QUkJAvb+PsYzZcYZz0hFoRVy9Rxx2dRxbiv8h2nII2rUVV6dcTdho8T89d3SLA0MDMjwdHlUqCLDDTDKFSocV6Zk7jSvT+DmtTYYbIF1ptP3kWmTPu4gjZi+o4X8o4P6ejGJPPSm1VqQoPBdeP/JFPNVBEWrQpmTEhJ4BBxG+ClyyAjeH4sOIHJut8lBGCmt/3x2BraxrEYlZRUvvGDTN0CwaMy8pn8/nVlF+yTLWcRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiDMCOs4tUlP7+rR328HAv7BPIn+wLUf9dClYafh+ZI=;
 b=b3jh33ww00Vl9yJIBc6L/Q/MrtuTIqR2zoIgD57BOzwRoNqOmp9iY5D9U/cPSE6L33X6cNrVFrnfnWdeABZ/qxARVkHXYmhFnxrKTxb5qnmP30BPnk5FC7//tlJkreOCWzLGQifIwgUV3ig4J1ZLaqlx9Xe2lWkIGXb30dFT1zY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:58:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:58:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 5/7] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Tue, 10 Dec 2024 12:57:35 +0000
Message-Id: <20241210125737.786928-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fba004-8df4-4cae-fa82-08dd191a497c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AHpdXp+bjiuKTBd1xdADQTAyOxB11ykADaeo+OanX+ck/nEZNWDTsPF7HvWa?=
 =?us-ascii?Q?qh7BdbFrRKT2f0siJ+dstW7sAH469YoPYITwe/MDfQP1cgZ7rKm2sCcYkD0D?=
 =?us-ascii?Q?WeRa93tc3gv2rmxp3rY2vmjzZk/5s8H5wDCs3hAcvP6ifiB3o42yqRatFwpT?=
 =?us-ascii?Q?aHMpJ/s4TSX0ebKuxIfuliwxQzF/1EO5rTALIFSHknh1X8L8nisuFk/JpExp?=
 =?us-ascii?Q?wyBZ1WDP4F/kJ7wb2Oxc51dQV/V0FRiwonVsalLeXTtraTQZ9kW37khVh034?=
 =?us-ascii?Q?+UwNMtuTaTlM7uk7JxojF2QKN3Jeg10/9L1DMUpJRr/jE92ooFzwNh7FAbEj?=
 =?us-ascii?Q?UL8hhfhNrTEZRSreJmbb9f/f0tRJEN6BfLi4WkIDPiRD8tp3pAVr+6UA7efF?=
 =?us-ascii?Q?ME5SwYbBKmJHdYQ+yUQBA6O6HghaCVbLa+Ag203EXvwuH5CDIr4tCMQEkRE2?=
 =?us-ascii?Q?e9iAN9EM2iehhiSZw4ZF2NkYrSLgb1rUkHnRkKqAxtp7BME78Ss+xeBRJugc?=
 =?us-ascii?Q?mmdtYRIvVxiHoVw1QWzWx479taz+zmqR2RRtTrJv7HJOnXoiWlV4HClHjWy7?=
 =?us-ascii?Q?yosMXNpP7XZXQdGq9zFnAIhKGdZuerrjqHlYNM6rXCkYd3Vjo68t/MkR10rt?=
 =?us-ascii?Q?Sww4t2NA+xtxiofjP0sIwstNrialWRpXUoVaHLLH4W7q6zmyF5NI6AOPJDRi?=
 =?us-ascii?Q?wQw8BpUyWVUyRDzWVkz9O4DvrvVtxNgbkC+b3KQi/xE4EOahpnUtdD+d9SPS?=
 =?us-ascii?Q?UDdxTNzegF/u1FawIuB81zREqsgrspmVYn6oSOPg7t9b8Un6vF89TH5lxbAA?=
 =?us-ascii?Q?Go8a/GkzWSqqB5opeqJQvYjR7bRDa4GOAfcdSX+QYsmiRMKup2ft08K5CG5L?=
 =?us-ascii?Q?6KJ9NUGDOwhTK5TJ+IrpynMMs/7KKcQXj7UaKIFQ8L41mr+fZ2jMZnFsGkaw?=
 =?us-ascii?Q?386nbquvw1cLgOw5K3LrEbDnoDVROOVWmm1pAS0MccrQttOFCJct9MqfzvBg?=
 =?us-ascii?Q?kIz8n9As9M5FqQOICimhTw99PUphXb/p56gDuqxuAXJFd0ugtphTf7EMLizi?=
 =?us-ascii?Q?ofH1wHM+utnt0gAzb1z9WRkymeJbGJan5GwQ3YW85DaDpULpvZZG/lkif31W?=
 =?us-ascii?Q?t+D3FHaoqcb6Sy9lxP1U2Pd/dfCSLD2rGpQ9ha7JHGTJBvjxbPOvRuA74eYh?=
 =?us-ascii?Q?Shg5sGsgD8F2mokpkdJ4dS+iX3tgNh8kRR+s/2QbBmxYSkpVIW2fQmX5Pt9p?=
 =?us-ascii?Q?Ij8vg/ZM6YhJhxBETl0Jw+2g/c+4oED6/Yzux9ndofrB8cWd7iRaEW6njtiJ?=
 =?us-ascii?Q?3rIdEXBb4qPleOuber0NT7yDKMhtlD4JRjgMoySzcNWGRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uowtW78iSBKAggCH3fU97yIsUF1Q8oFDRCTHgK6Q2ERqz+iP142J/mnEDHl?=
 =?us-ascii?Q?euI1VGqadfeD83gX26myJy6SuEcbLIBx+AFpD3JEdbv6+yh7+xZAQG28wwPp?=
 =?us-ascii?Q?u5WNrvHulRPe1micPW0QRNimFrsOIFDvd80IQ0dgkOhkc25C5qbh9C/sGUcA?=
 =?us-ascii?Q?uans+Wt0zO7lP+DAy3OSmfbfE0xISGlXk09p/zo9RjQj3zJTzvDABD2Cs20t?=
 =?us-ascii?Q?J08BHZx9bmUX4PaNjE401V7/m+89MJpdoaY/pjJLtIbhfYBAult40UKtve8w?=
 =?us-ascii?Q?uWhHioemI8mlS6G0QCkusU0OZ5o1v/qwJWR2YG+e2qwJPsDDE2thyLEf8w+F?=
 =?us-ascii?Q?q74AhnjOG3r/B4VC+C4SmomDuivrSypFtEen+A4YGU2vUQqFMvI3gGRc8mr1?=
 =?us-ascii?Q?5t4P1I4qVRq6dQsW6WCpDfOmr3k6T2BBOuRA7Kuw2OVOhUZrRRhejHYUEqrm?=
 =?us-ascii?Q?rxRXXs1vbswv0op5gi8oAxwVhnN6VjpglaVcsn9gA1vohEJelpOhLJGA2XrR?=
 =?us-ascii?Q?k3ZW8Q831HVmDXNhMP5CiRR3qvXuITNt0CWKBzLrMBwrDHf6WjtMZYecSrkI?=
 =?us-ascii?Q?DWqLwBQfkhNMmbo3HgJT+xY0xN272d81NEIRZQ/fse5Lt/9gWJqlqIX3ulQJ?=
 =?us-ascii?Q?I+DDhlAXlPxFj5Avod9pmMbTdfpfIwhwY4QzJip7iBiBmtMZwY1AEUp0bW9X?=
 =?us-ascii?Q?K4B/zM+9Jzqoo6DNfYzxTGNkjzASrOMovq8QpPKonZ27dTjbPvQsP4I0W+4Q?=
 =?us-ascii?Q?2/pbfWrMDeMNDUDBoLt3htdcnE9QoUNWNFn9hP1FxL/LPbjDVQ8Dlx6T3z5B?=
 =?us-ascii?Q?cgukZ4DYO1Kn7I1NMlHCu0dmh3W3w1yvTLfRINF3rHBPg+tXRGByIRHjqSaw?=
 =?us-ascii?Q?Jf4TsIpnTkk5NuoxFyXGs0xTBZ+n1JCnAZ4Vd6GI5ZXXnx3UWaxqTH33Vs6r?=
 =?us-ascii?Q?17Z+UChyjoA46xGqAmBYe/ewBTyrJRR1C3jMp4Vq4E1RyA6AVq2Px4uOUMig?=
 =?us-ascii?Q?bTcg2DYoBBRxBrdBjueI748vSIjQp/X0RsQp96TAokQeY1UjKOgRqOs+AQbz?=
 =?us-ascii?Q?k1pbLXx59CmsbGd3DOaU/9vKYpeBKaM3fSdAMP3w0xdH4F0va2s7fR7DMs7u?=
 =?us-ascii?Q?H7gzbPuIBaumL9JeZukdYAtnJ091M1LOG4Rwl+XEZcLbL2ORkqnYnNvShG7I?=
 =?us-ascii?Q?MiJRseqjs6ap24mAOnCpptsK0kwjNyNjlAK08mSL8i4+xZXNnhKtjhJKftTL?=
 =?us-ascii?Q?hSknYiKMcVxcEMuxecI/sGkrqBG0JINpRKKHsOoymI1vDRdgDZiq+RdfCFrL?=
 =?us-ascii?Q?1HZJgV1svisg4Q+YwFCIF1hi5xmNc0a9ua8CESfBMWvWRUNlakIDWrX+sQ+U?=
 =?us-ascii?Q?Juh/LmbS/VoTRPTF+6gkrxsdX4/IbgOednpMGtMDkFJXhxrm6uby/1+bhVPx?=
 =?us-ascii?Q?99rqW8eDZ4Vyr1vK5L6IpS854cuxU+V0JKOM1tI6YZtL/9VphKxJnpS/vwGy?=
 =?us-ascii?Q?aCqCG+rfoFxAW5AhktsgZDPvQ7MIenCpmuuwUS/IDbfyL0x+lG3kZJiWxX2V?=
 =?us-ascii?Q?mz53SmvVP/iEAfTHM9jybncIPElslMqi+6tU+toly16ENxwDAznDH2pjyQwT?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wl/UQxsW41VEl64UiiwOct0KungaQKJYAwHSJWI1cFH9pKivXFjs6VWmvKYYakmggc8cxEaArrOcAoihvPyMNGpTMoaBqzmzXkLCLOL9D47D5XBRU1HLAO6YIC6peyhyQcVmfhd1LkxNk4OY5UDHZqkwrnrstSQwaFQ+u5Pln4eqHqK1ExlpjDBvdX/PPime0HzVYj980qyoZYQboWedXtp32vGnGeeFGl6AOusKrBYkLeU1mhA750OkfpYvqd+6YrBOwZYCPnOvyh3scBrXWINQLk1nJaPVOCQvWF0fNoZASSqU2aKMLhSsWCpl+V1j/7krS3uI0sfU5JwiUonynVQLkeOhPX8qTnqEtYO9t9sWzlRIa6+TDkjkKQ37S1rYSAuFRtMY5Vh1/Rtp13w+0XifO1iAdJzaXmfJkhcgV7/Sk3VgT0hQrzxPN4cR717WRCxJlOZEojkCmRK7vQEqPjNmg8H/SIOQVSnvfOUwy8pL7/5A6UaZHSP++U4/XeuXU7OlsuukTRSFeZfg2tKaWOlgyC8TDjAXy3MTrtmz/qluvzzA/kBHzRPmyNRuLS0LAfgkggNHwI+NZKxOhAkW/UMpfc1VyGBaxQPCt6Ys1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fba004-8df4-4cae-fa82-08dd191a497c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:58:05.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsDZUb/yVviLOHZpeNsq9TTCVD6Eb3QfnBg3osRuDwaactnym6B0EP4fwv70mynrw/HcshHUpjzn6n5tZCTzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-ORIG-GUID: v-YiRDPMHQ3WlE9W16E3b8ah3873htfv
X-Proofpoint-GUID: v-YiRDPMHQ3WlE9W16E3b8ah3873htfv

Currently atomic writes size permitted is fixed at the blocksize.

To start to remove this restriction, use xfs_get_atomic_write_attr() to
find the per-inode atomic write limits and check according to that.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c |  2 +-
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f2b2eb2dee94..8420c7a9f2a5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -938,14 +938,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 207e0dadffc3..883ec45ae708 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -572,7 +572,7 @@ xfs_stat_blksize(
 	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
-static void
+void
 xfs_get_atomic_write_attr(
 	struct xfs_inode	*ip,
 	unsigned int		*unit_min,
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..82d3ffbf7024 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+extern void xfs_get_atomic_write_attr(struct xfs_inode	*ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


