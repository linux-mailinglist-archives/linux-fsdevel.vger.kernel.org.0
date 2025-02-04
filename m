Return-Path: <linux-fsdevel+bounces-40732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6207A270C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D58F3A59CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57420D4F8;
	Tue,  4 Feb 2025 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBZWMWSL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zsw931V4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BC1DC745;
	Tue,  4 Feb 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670531; cv=fail; b=PVw5v7IeqwmjW1D//LPMFS4VP6q0dtAc5RHi0TfaNmGd9UruMSAuaiDq4kmU1ADCTCmGWvCHKvwyX4S8fQccA5xG2Cqpxtax00OJZSOwHZunMcFaOSM+EuU5mvesuaWs6idQj6o/iIu6mL59e99hpp8yhBqPi3E7biS7exT2dk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670531; c=relaxed/simple;
	bh=k7azrg+bY/0+zVnoFEGWjHb5qsDCuWOnKBuFlX4fao8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gyijaKaK490rAhdybeWiYnACDBvCklVaDsym7xre6wGPmIENudjoijobMt73w8f2vcZb0atTlHwTHLjMwFPTELLFxxyvmxEoYnbkTU0GaFo4q4/ZPrrD/FDg1BpQstbq3vzbwLMLVabl6yfoUg0OdTKi/WmGG2Qjv984BHVLCPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lBZWMWSL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zsw931V4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfZIb010983;
	Tue, 4 Feb 2025 12:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=mU+Ut5BISppy9kjb
	a+XlednYfkkfJZkyKJht9+lImII=; b=lBZWMWSLIXUXRIwAGNOXr9ixPU5jVju1
	+66gq4ipgvZzLxXscOn7gs37iTkufhGSjf260lInwaIIyR+zCBsPW8XnyGsnzUET
	Vcl4QKs97v0vf55FlH2+H1dlWn4fAcDW4n/K79bj6ZsWgTWlj2QCMocLo15BfgmQ
	o9Wnf18hHOVI8GIMGv61Ibx2euOApn6GLIWxWzvYpUER6lT9E9Stp8xjT3f8k4DD
	OCcY6AnrU9igxX61XF3A6ZJvWxSbJ0YtlA6A9TQedIL88umV1Ck0LhaR+bp+XG0J
	cGPK95v4xdhr1PJQhlfZaM2M+fPykXPI30vMRGEXVXVqyjlrcTBXHQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgvruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514B5OLq029398;
	Tue, 4 Feb 2025 12:01:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dm5drp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKOwsiXbECs3LFSbyJHzxrenkL63NvFyxoJ+yCsVAR1R0RJ9SsquabMXwdkhqA0uzJuU1RP7CuxqK5LxiCUVsdf9/IcSIDXQ29L50pn9CY7klSENyoXQy7actkFjAJqVDvvPfM5JaA53aOrIrEmOUpntutk4pKTw48xhvvI8XoDqloaqYPO9lwVeFpJ+irKuhVg5RebignLZU9flhlwgKnf+NL1nZnAG0Qx33BiVP3cznn64Hst8pXsIH8zbIvOZrbXnWVnd2Zi8n8MO0N0F4gMFqiJ1VgaMg0zTahMgnwfTYkXwPaTkuGnyMX5TQhWuPeawB6h4suop8Pf0TArCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU+Ut5BISppy9kjba+XlednYfkkfJZkyKJht9+lImII=;
 b=pvgYWTlJR9ZXr3FuaRwQ99GHs3hcpQn6WYsxI8iXjqtxdzO+gc6HuZByau5pC01vsU0uFgVTqqfExY0ERQgDnEkeoDSSpDGF4qwzLcSyiHFGIUa2FAz2BYaGMeOtiDb2XuZI6rb1URAP4fdniE3g7HV+PZb6ZxylPPGFFmPc2ll/gr1ufTnMchxzDFi6AygGZ6kex7NwJClIBwXWCKrzKaBV8siQOWgxQTHZVOnJ6QuQFreRCFN39a4XUCaxZ7L6ZA0pbjoBWVmHknwfwOEnPdcCBpwIjAMYK6wr/nmZfYWAwC0rzx7TtiqbChZSLHmaZ0yoDzCDix4ztSOPZ9uxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU+Ut5BISppy9kjba+XlednYfkkfJZkyKJht9+lImII=;
 b=zsw931V4FBLgaWrmg/q5sMrUZraH0wLwrwuT9psDpmjIuf1uTimHymgtxaD4gWl1W+tSBr4sdsEgCHBnfTpoXflzvryyV2CcCe95iHNaGjQjcKLbW0p1EjMSnlVc/QKNrpMed79xBh5xqCzCMg2v7VUdBqez/nGg9pQxt4ltTeA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 00/10] large atomic writes for xfs with CoW
Date: Tue,  4 Feb 2025 12:01:17 +0000
Message-Id: <20250204120127.2396727-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:408:e5::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb460d1-daac-41e6-56fb-08dd4513b054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9wpFM8PiFYvwx9OcIjXjauKM6nS1eDXvVsLx6tyMcRlJIbwdIDleY9sKMim?=
 =?us-ascii?Q?7kJmXU+68L0UQS9g+R2VKeYQ6ts0sQw2uh7uF1AMTUjVStPY6EfI1kq7rk7P?=
 =?us-ascii?Q?MhYZeXqHaC4XuZCGvJp/c/iEzqdkx7/lrISN5HRpUzndgDMJ7MIDDdgE6e0A?=
 =?us-ascii?Q?1cRbGPEbszStZWrUX/5ZNUa9xCbmLdnUYRt4xTnG37iz8ffqAjtj1JLp6kuu?=
 =?us-ascii?Q?7OIXGmGLFXsvjqg+lYLRTTYrzG98pp++Bo//FCksFdFQ5ORfV39bJ6HAX6Nl?=
 =?us-ascii?Q?XJuLhoSaa5zT8GAgKk3XMVECnfWjeMeRS73nmOyN1I9PVY9tSulqLDNOuoSJ?=
 =?us-ascii?Q?tvqFCc+aXQzjfiTl0LTYk0Sdzg6qweFDkTYRer3abrCTE0h0/KrUYmBsMKor?=
 =?us-ascii?Q?KzyY+83CIxKpsbQOifzXBbkdOPTc7T3hrXKyLLIxunskn8YktE1lVFRqWqiz?=
 =?us-ascii?Q?u2x12vxJCvpIBZcLVVQP2Ldcm/aDAYx4SX3z7G28GdX9RnnVgKEKcjgR+RMZ?=
 =?us-ascii?Q?+MQBNV1hYZr4MSxaTVubGILG7dq+aEWpduZJCrz6AM5rwaFaSgwEZQkWB27x?=
 =?us-ascii?Q?8NINyq/jHLYeywbjsMUIXMEFp3HtFDTIYuJWH94ihyzgPaBjw+9iyWahtEcg?=
 =?us-ascii?Q?0th02EFTwGL1LAoDaOUwTkr6zB2rwGMWa7+9vl4Psv5FMY0WMBc06rhwVow+?=
 =?us-ascii?Q?1PuBIlZJWCITMeHPsLB+wZBwo7UlvwZZAxEGQTOsPui+Nv1hphdhMkqDS3GQ?=
 =?us-ascii?Q?JJo2xI679BPaJv8G0Gq1VJ8C3jv+bdEbciPo7AYWiU8BxeVFy0RCK7RtVVXk?=
 =?us-ascii?Q?sbhxFGOdxFelkf7F7mSrCfV3zj2tdlSJ8odGgMyTUaJsnKrqsK+P1Ztq+uEL?=
 =?us-ascii?Q?LTZzSS2GojtbxYz4JLWaZ8GwenipiU/l/E6B2Ap2GnGzumbtpqb7UQywy17P?=
 =?us-ascii?Q?b5bMGzKBMpXFhlUdh7FPnNqtPt87+AASJgWR5KI6FrRQI2CqVtpVWPXmPlO6?=
 =?us-ascii?Q?uF/LviPpU6NlqEXuHWfrWBHPirMDjH/oVuKbBNinoQxn7yuQ8g7n/0QT2X++?=
 =?us-ascii?Q?Ztfc8ZStpjt3JHMLQjLEjUteqFfrjAVhiSWJgO5K80pn4Zzh2NyGI1OqZNtY?=
 =?us-ascii?Q?OiSlxzLG7HkiV2uCRSGTqSSB9jTijR7EkUjciBq+j3w3S+qVYP5q5rc8+6o8?=
 =?us-ascii?Q?XNfDw0y+1n3r02N7Ea8RjUE/jMTEoUTYFqc2zlbQsM9WTjtVLy7tMBqplOMJ?=
 =?us-ascii?Q?cMnjfHkNbSQv8+zwB4weLb7PUlub+i0L7l9mfBmVntF+EtSEActBA9DYqhjN?=
 =?us-ascii?Q?hexKschFQah9Z1TymPquAxH+a7dv5quvAV8uvib9VmmPFQebh+CCDAEqcg+i?=
 =?us-ascii?Q?K2uRCPyJqx84uc3h0Mc4hlh39xny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ealoHNViN4WArSzy1vgLcIswQOhkLKM7jq+Qy8JD0UlCfchgBJSIsy2J+KYr?=
 =?us-ascii?Q?0UEnaGy6hLm4R9yBz330qIOsYpXysJSegZaUbrd2dkMIl+xV3UuAMDa0PCjU?=
 =?us-ascii?Q?kkLzUcYNjhrPyM3lRvcO5S5L2JVlxtK8ZKr7f560cmvGRbbNUXdNvnYiGEIk?=
 =?us-ascii?Q?SQoG9NlG2Nrpco2MCusNL6mWWB/GlGbVV1vuttlGlWqDVsmLzsDq9yHBB08P?=
 =?us-ascii?Q?OxAYlYEO2pHTKeqbi76YjlifK12ir3UCThi6pkPBZc8+bJ/1Kz06lJdIFIQd?=
 =?us-ascii?Q?lBzC3f8lBl/onCnlYwagGP4q78X0P4BaeuWkByLldW74auohVFu/bN1LYs8q?=
 =?us-ascii?Q?XZvc6wC727Lf8TtA4cRqHvqSD18O1H6NYWJrcrltJApOF2TMNgMto3Yd2iFJ?=
 =?us-ascii?Q?gr7NXlqzWsAfoo2/4pG/lcsH++GhBithmbCsoWP2snuHFnXecgydnJtj/3Za?=
 =?us-ascii?Q?DLLQwHa7FSON+hbEkMFnnJS802N+IRTzdj0Yw9TAW5DgE2IbCuqhFaNSzUk3?=
 =?us-ascii?Q?4t9871NZFvmVUiI6TpNaYFSjSg6x2Wwj5f23L2pNZhlQSGWsYmReWRTcTtMa?=
 =?us-ascii?Q?bMfNfWxN8e1TgE1n4D7vqHjQE3vMJ87RQJq3N7xkGBOQaEh0PJFI/6DuWmOV?=
 =?us-ascii?Q?vKS7C8aDqDqh8kOQvwiueWVlPqUuZSg0C20DeWmXgzKPIN+aGexeRlcwug26?=
 =?us-ascii?Q?aAUfuK7qZ/gQSab/xpwzXGaNYWqwA+ZQfwiCmi7EJZguA+5pyeY7LyVF1eUf?=
 =?us-ascii?Q?ESQJcSNRq3b6e3gD/ykctCcMm/MZGJXGmQNFXwaF0h6oJfoZ3ncHvdnQ9FoP?=
 =?us-ascii?Q?TU4WqQfdlI7xtwNZ0y7NkM3TgoYx4GsZ1DwWsiLkVpDEDYcZLsZJSjY6sgk1?=
 =?us-ascii?Q?c/wvvvNNtrv94MDnm9mwDLy9sIBZ7qRYDvvY0NLHMg+Ciuv/mJthlU20vJ0P?=
 =?us-ascii?Q?s8UNpRgRuGXl1+jIBdnz/AQOjAIZQdIPimxjMpOco1z8st9VsFsV4VxqBDfL?=
 =?us-ascii?Q?1Krq3x83KdncwSbr8B0tBQ4ZNDQkQzH9UCk/pY6OHqOeiHZ6whOuAvBTUT4H?=
 =?us-ascii?Q?g2OMwnjr/lJveLTZG1fUFil+TTZHonAxOEaakwwy+MQlGrQ3LdOwIjlXKve0?=
 =?us-ascii?Q?auc6p4HB3rmytMKolxX9pQnx80mGOmeOfYrArFKGBSMDn10GKAt7crR0aRI4?=
 =?us-ascii?Q?tPYZEFQChbsvFHspTmw7+8a3mpI2wVBVf/XqkJHJx7N/V6VYUv+ayeNjkRro?=
 =?us-ascii?Q?5/ywo+PKSlg5ACbxOoVrzP1QeSrFrgeaoo2MfI1tQjYuYrNv4icYlgW4TpAv?=
 =?us-ascii?Q?ByozpZYjQoXCGjlwrGXs64QNhpB1zinxq+psn7IpEZLPM+6NpGo8N7eYhq1M?=
 =?us-ascii?Q?H2olQQHsJNFAAizIhLCin79geW4CtHpZlT4aBnZMSfHrx3KbOjlUOrgO4vJ5?=
 =?us-ascii?Q?8LMVT5IGM0VO06o6IF5iv5Uy07KF7bdPjDpRfVgTBrNs3e0aj0KvInU8qRPP?=
 =?us-ascii?Q?zEce/IJKUjFVf8rvBMbn3yt5tW9GtEojAbcWBo4rYy7g4CgrFfP+aEGNazJx?=
 =?us-ascii?Q?apperJm4+ygTuN9iiUONir4YW9L5pWxHsY+YLpPN5lDhZEdNK68EbK7NBCyq?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8QjX4u9DMVeAnhK6n04A9Ci+f4nSz1ZpyFre3mgpuBw0BDUscWen/dC8jFETV4PPPGf6Hilu1EatjXDV48MeIgslMJ3KmAmyXicmTuN1JJ0ptLNcVYg/scGcm92qZLeah+yFzwjPMTwGHC6GdkafI+jBcZYhCIzGdzaiUifUvgHX3ch1biTZvdwjnpgEqySE0tNwpZtcKRGcuJ8ETFctUnmuRr3qTi+oCRx6hGe9s2tANAJwkcEhHJzY4dMHZ8b2/DTNzKCnYjmViScESMpjKx6uXBY8DymVJ+GdG+TSy6dAIeqlC/lkapSGllJ1scloWQtllPa6cibNu4aT2h/0hxMkUvBQvtsR8JtGzV6QVpwXPM3jbLI18BvEW++FOm3QHVBAleEuP7BaamTxzO7RL8S1KmP3WuLw7ucKutZPtzcIJZxLSEwAHytWqkbSDDM3tBC8OUX6T5SrVKuw3HzP0mhUpIqskjYEhHDBTtD90CVczT0EqH0cccg66VfPYDqBu4gS3YzFnu233mXpNqTe1X89vNKtx3FhPbvABMM1g4nxNrWN7Q+zxRqHx3v0ZuThY6y6EI1VqtirTbWXNrXEtNDOGosMWEw0o72SBPZ1UEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb460d1-daac-41e6-56fb-08dd4513b054
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:42.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+Bx/oTVeBeMxRrtw6WPbtezXQgXB0nf20ZFNlqvsELTaVLiSN5cH5qAR7Z7pQpWoebtYL/H16MjyKqOcUiL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: q-zD6g1DeU0GmiSg12XCW3Dc0rSSjVN-
X-Proofpoint-ORIG-GUID: q-zD6g1DeU0GmiSg12XCW3Dc0rSSjVN-

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

This is an RFC as I am not confident on the reflink changes at all. In
addition, I guess that the last change to provide a hint to the allocator
will not be liked.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on v6.14-rc1.

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

John Garry (10):
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Refactor xfs_reflink_end_cow_extent()
  iomap: Support CoW-based atomic writes
  xfs: Make xfs_find_trim_cow_extent() public
  xfs: Reflink CoW-based atomic write support
  xfs: iomap CoW-based atomic write support
  xfs: Add xfs_file_dio_write_atomic()
  xfs: Commit CoW-based atomic writes atomically
  xfs: Update atomic write max size
  xfs: Allow block allocator to take an alignment hint

 fs/iomap/direct-io.c     |  23 ++++--
 fs/xfs/libxfs/xfs_bmap.c |   7 +-
 fs/xfs/libxfs/xfs_bmap.h |   6 +-
 fs/xfs/xfs_file.c        |  68 +++++++++++++++---
 fs/xfs/xfs_iomap.c       |  70 +++++++++++++++++-
 fs/xfs/xfs_iops.c        |  25 ++++++-
 fs/xfs/xfs_iops.h        |   3 +
 fs/xfs/xfs_mount.c       |  28 ++++++++
 fs/xfs/xfs_mount.h       |   1 +
 fs/xfs/xfs_reflink.c     | 149 +++++++++++++++++++++++++++++----------
 fs/xfs/xfs_reflink.h     |   7 +-
 include/linux/iomap.h    |   9 +++
 12 files changed, 333 insertions(+), 63 deletions(-)

-- 
2.31.1


