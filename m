Return-Path: <linux-fsdevel+bounces-23807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24983933A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495031C22671
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65D3BBF7;
	Wed, 17 Jul 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EoJsTxDE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RCLkv/sH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875B3032A;
	Wed, 17 Jul 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209016; cv=fail; b=tQxQ6WVgfBBgkAqiLpB/05Fwz1LAmNJv6hUH2U7MFyER6+XsYqZtxzHa9Ok5hzGBM7797KLKcUVeVkbOj6cjiYsvvRNY3CCCi7P5CbC3kJk8IpyGNjO0iUZuangYf1B8tEnaUeDAc/NOyYiC3JTuaCjgcew2MaxEN0m81TKadSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209016; c=relaxed/simple;
	bh=Ffh07XlMOrEoWorR3nckhRcgx8KDwuu1kXECHnQZcJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpoB050IWE2cdxwC4U1K4oyBXDRnGk3+W3p+dGmTY1X24pJCfypkC8b8AQRlRiNmckbjFD9zP1kQfl8Rk0syydU+quh5/XFXS/oSq1Gnxa+obsCuG2y0RPfVpNg3vY89hl0/ZE8REZ9oMTp5sX+uQL5NXzFRyl8eI3CudF3M+lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EoJsTxDE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RCLkv/sH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9PSsh031726;
	Wed, 17 Jul 2024 09:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ZP/jnaR9RJke92+mnE0sz3S1D1wf+VKmXFnToPSnUCg=; b=
	EoJsTxDE0uMI+cB/bv/rsH1UtyGIG1yuOzXmTB4ladR/EX3nzLm0BlFNgImg+Dqh
	GBYZX5js16zpbPGpaiLiU5D4k6pDT1mFmBTNUOWH2Qp91gjfTxVjG0j5+q9yDJwR
	oIynlUUmQg4/RkaV1vX1IwcgH84JTbJzKlaCbql8fstP/iGsys9fZoI5Uc8Prf1x
	rMRuExF6lGA4eoHp9iii6TNWi/xsR3WhmBBI6v4f0IX7CmUavjLt2vAlmqGcUy3K
	C6WYpeCebx1uQAC1wsFRgjfJCb3KlrAmhs1m2tX0HA7ymNJ4Mp7+zgM6bThc7XBT
	7lnBXK20QjO+0WEDi2iCsg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebad0135-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46H8AnjO019491;
	Wed, 17 Jul 2024 09:36:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwexu060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 09:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvMnuYCANoXKISSleAZqO25uMhk8kSOyg66dPO88wW8wloPq/IUrYKB0FiopfMVlw7I/0QivZA/Dwe0DKS7giZqWhqoLpnt4Hgy/wSEYyqcvfIeZNoJnt0GVCaKd+Zq4VM4CU2YfkUX6SNq0r5v8nuc6Cf2HtF81gjeQexlFdxDzxUQPBlPewrc48TDmq/xWwA8SxvkAWqGFLVToZPefHGV8msmVCM8e26YMatU7nM7l/fFyEFsy37wWi8uJaUpz0FjXFhIsQPv9gK6ZC/ogGeoJeFyicKeB9G/SKbt59pAflaWSSq6SUhVCDuASLpKSrx2WZYsmOjvzX7AWAf3JIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP/jnaR9RJke92+mnE0sz3S1D1wf+VKmXFnToPSnUCg=;
 b=M1omP/phbesliCoFmajPfK5STHbouBpEYG+ccJasL9I+3qcYsntAh8RdINSJXW2M+lAHVpALZDGO/c8WHU/E0AyOLcdnqOxpxYK7zbCiUb8HhuxTTEooR/rkGQtR/8tUubkF/n0NuZ2Ikgiog+T3EMSv3l4qvARCkm2heUhO3qLskTiOFAI/Kvz1XmA6DS9IsgICU6oXCyxAvhTWyBPh8UKkb8fEYYbpHtdDyz+rnaGPrKmH7Qc8Qx7DUJiPdstjxVvTIO5bgBDZkdofv9ydKooJ+2cJoI9JWtF5KeCyN5/F2qg9dznEf9l9YQhFcjT8+pOar7xz3yQHclMqCTriYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP/jnaR9RJke92+mnE0sz3S1D1wf+VKmXFnToPSnUCg=;
 b=RCLkv/sH2EuJwhQs7cvU6psyzR4Gi2uzStQO6hnk+2GX4FelS1tpQAIzsvrvwXDclbshy7WItpR11nIMfK6O6xGM1bEwzSm0fBmdlgpgBc5voviij5FqF/O+ywOR2aQeq/9dmjAUK3nXg/O09MacEbNQ8qQUQK7iZvo8awessCY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 09:36:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 09:36:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 1/3] statx.2: Document STATX_WRITE_ATOMIC
Date: Wed, 17 Jul 2024 09:36:17 +0000
Message-Id: <20240717093619.3148729-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240717093619.3148729-1-john.g.garry@oracle.com>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0412.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ef6e57-5851-4a30-fabf-08dca643f5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9kJgwM0V1Y6R18F1TTiaCcM0BgnW9+CXrEj3xeEHLshmmH+nPbh+OTqK1R09?=
 =?us-ascii?Q?18dbV/t8N4PSrpY/gSVr6fnYnwWDQiR3Z5/aKSgpxSDlvtUVDNrZ2kEvaN0l?=
 =?us-ascii?Q?Fl4I2gayRnNOCdecqdpN82diNxsV7XS0ls1PJ1yd43n3YmHxR9VFKX9Xw7YD?=
 =?us-ascii?Q?/XyeJxavcNLohBQY2HJK9acEYQKn9xQd9irdhPunPRi7kSHF0bVmmWID3Bwz?=
 =?us-ascii?Q?al76AD6xjQr++UA+rLWL9ZdIfOG06C03MjmONwHYQMLwc25IInBLIAX76mBx?=
 =?us-ascii?Q?V1Y+l8WeqSyvRPcsp9fXuuyLErzlh9mQttioQlxvQ32TD0q2P867Npp6gDXq?=
 =?us-ascii?Q?g72h7RnM8h0wowQB3BZAx/ST5i5+R4jtzIsvZUXe0ad2IJREy6F/2Vav4Gwb?=
 =?us-ascii?Q?0D8morI6oXe9+VpyZE2QFnZOFSlxOKc2DGXJvHoa16dHwP15SLKFlpsZcSlM?=
 =?us-ascii?Q?JK4mqOjRZhY9SMJts5djC+EJ92iS0AwCwu5eMWdb3hHTilXrCrmlQNNa6Gip?=
 =?us-ascii?Q?lAMJk+PTRtxQXNmaY6oSgVGIIVgbZsZ2PnAveLqoTDzpwb/X5yl7O0wgu3Aw?=
 =?us-ascii?Q?HvQqJPOmXvSwsB92w7q9GGWhWiGRPIOiTrnr+ZPvRn2YYSVIs8HsMetzZa1A?=
 =?us-ascii?Q?hZsS3hV5FAICm/11UIZ4+kCRIYYXo+l7swowg0wjA6hIpwsYWaponeJnTa52?=
 =?us-ascii?Q?ynA+HulqwdQ5vcPecjpBpLraHhubVbXo8pQxDwAXAVTBMD2gf/BLo7PhU9Kr?=
 =?us-ascii?Q?Mj+iuhHLZCRFveTTYkfhwjg7JDchMPaq3yAZiVJ4gZSsDL3qmrCX9Cm3gxYo?=
 =?us-ascii?Q?rNwppfENta6hKGPy1cVBkRRxGIzM8HvJ1rD4QrpUE0ZWGA+WBrEVuc/ODs7X?=
 =?us-ascii?Q?ArmzjTXaq9CKUHgDmRmxdlv7MerhZB7Y5AahEfihTO4a1er+xfgE1r4iuWbR?=
 =?us-ascii?Q?+Px1rXa1vupQU75pxfckDO6M0GIGP2ZGox/aUGd7t6nIp6OnwfosZs33iO1f?=
 =?us-ascii?Q?fgQvxNepEaary1xHBZgjPr19CZ9lSQh/uq36Ofp6WRb5biU5+XKxSHQ979wb?=
 =?us-ascii?Q?9KnQ3KgfO3lPlnz5MksRLTJg9wuRdzBo7kbcO00G3PoyVHnr26Wui+/xTktT?=
 =?us-ascii?Q?ZwfkH9GGbG5krafBSBdfD/vEjybDj4CYnvqYLBXhpTE6/cv4dV7GbqDcG23W?=
 =?us-ascii?Q?XPoWRkca/Z2RL02I+I2xObXUeSsEGQ4ixjXzw8i/Q0OUieZSnrkrlpTBM+Pb?=
 =?us-ascii?Q?RbPPKqVHw1dw6R5OUboKgGHB6WBtEK7ZgHFzo165XdYP2QgL2zzUGB4lv988?=
 =?us-ascii?Q?BWn0agafWibP0cyq4SzWqY4pmDggWso9Z5bHdNLQsAGF6w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?olgHjEAkOMiAqKtHaHowS2RpMv48qb/w0R0VAp46+u9miF1Dc8zVQCPTE68n?=
 =?us-ascii?Q?veWomSeNfshx1IOqjw66n8HiRNxNZoCCfEkyH+V5o3gniBHR9OCXJ0nsLK/4?=
 =?us-ascii?Q?e2/AeV/mSoot2cpTFTl87IWoM1PQX/NseI2Q7glInfaKlVbJHpagIL/bR9Rg?=
 =?us-ascii?Q?6VTIXy24UimBiBYbl0MQTenqazqSyiRVCioWN4EaoxKmkD/7JYLHAtZe9trx?=
 =?us-ascii?Q?7CEnCNG4hg6NDfC5FEF8XCtBX0wPQpVFarFwJQ0yjEKyrasRbZyP9Y7ANBcF?=
 =?us-ascii?Q?bq5q4QE0ExRIjr05VRH2lQQUAQvhBzegKWxUnpIcbq+DqIARDhsI1BeGMmmB?=
 =?us-ascii?Q?sTX88ETa45MjGnOnNWTFMCFa3SM4BrVbepMHqnuBknnG4xRX8FOgW8KKfsP7?=
 =?us-ascii?Q?TtStnWkt8a7HL0XqdkeMJWgQjahSweKh5TrHdcha36TVmxv7OMpQx53gNauA?=
 =?us-ascii?Q?+r/wec90qFhv8evIe/lucEtJ0XeYA78Bwuq8NEpYO+5epYeZp02Ubcr+nN7k?=
 =?us-ascii?Q?SGIDgyBxPDJ75jLxySvPiDobp0q8NXrh9fymDoOtQgloP3d0cF5C2/cb6kRl?=
 =?us-ascii?Q?VACKqmNGZs9bXWf59wcM3cP969bsvNbHl8amVjnRPkQLVg3AmD+2zJhDXl/l?=
 =?us-ascii?Q?KcKD7z0HyrYZoJIBggfvh2hL+7E3oFhr1gTt+rLqA65xBqBXetMrxZfjw8n4?=
 =?us-ascii?Q?s6JtLeDU6l8hXJVQMwQzdvq+x9WIk3oD9Vi4EAVbUNW8Fx27cgEb72T4Q/5f?=
 =?us-ascii?Q?3f0218YZfjXiJLnZzoeNhs7ztPxU5aLeMaGQ0BIFuUwn5hpu4RWNBnizgca9?=
 =?us-ascii?Q?ktFhE0E/+T2Y99Tq254uCz/MOvTZT2fcow47LBiIf3N2pwDK/MgtrCmWkl5x?=
 =?us-ascii?Q?g+ogwI9mXDHrGflSjY2nB3grFjEzlb9spYw4XdVYlmGasXJiLMRy4B//tq4q?=
 =?us-ascii?Q?IC9W4jCNMK6CZNy5NsNx9D6Dgs2uZ6y5nNSec4ozNqyhjnDeYpQwtcJWvZV4?=
 =?us-ascii?Q?J2EyiXI1Pj/0K4zHjxwFdZ6dZaP4AWGBmU6e75XFxhmjx+1WF4d0sq25pX2E?=
 =?us-ascii?Q?vj4K6wrL7jCvqKZV29lM9XfuTRiZ64BJUjDkTA04kAsVbIAbtRCmZL1YNiEi?=
 =?us-ascii?Q?uQ0kisYpA3p58WI8e+SN73yqxIhybLp8norw60kBKQ6O0oWoYFHHU856sXwq?=
 =?us-ascii?Q?jnfxi5D0+AX94JEcIEvym08sp/Sv/XlwMA2V7Sjd+8cMPvoX/z6BLZwTR0t/?=
 =?us-ascii?Q?ZIpYB8snL059N+fTF33/xIfNOP93/+PrcWP3lsJ2prCS9vv8XGjGrubSpAb/?=
 =?us-ascii?Q?YQKuwzzGVl4px8gP8MOIDBwcLtSc/CwrJvU+GHOdpdFQuDH1fkYdjKLpBh77?=
 =?us-ascii?Q?AEoQvLY/561tPeKbUO43NS90UPJzVK9bK62eeh5z6pFrX2CTgtcGyCma8uP9?=
 =?us-ascii?Q?A6p220G8JU5MEE/vC3MKj2dTtfxQUAON/E8PlADVCNo/IqSqUREl57d38H/+?=
 =?us-ascii?Q?hRoxarTU7EimYm80X4PDHq0nEKa3iIKLfNlpYXoLq7h0F8xTgziM/bwGcofd?=
 =?us-ascii?Q?As1Q1W64L9IzebDb0lAnLzfwlKsRs8mfGCZYfH26FaFiDmS7Ss9dZmYMTGjh?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c0abE5N8FnO61X2CNNJxkbIyv+00v/km4cvnoqj9TvjcqXeHU6+k1i5AxAV4RptTqTLT5dEyrlKYlI/AzUnExLPu62lpF418YHLNMBbecoenDjD9K6F701PdZFQy1i05eltbXXZo5VGiAhU40v3rMunplLIh0Kk9yYfcCH/wBbOVMx2HHTrQ97A975CMXuJzt3WLIcvC1PnT0dQVyK2TLGDbJ9AQ3Ur6meNr4EFri03KXLonTqLSgvFg2b9zId3RqX3ur2xQhoEA2lymDPCTax8IxI8bLeKEdExgDJ/7pzyU2Xa68BBoYCdT+9ujNecKUHhW+auKW2toV2Hyewcsa51bjykdTQqdl0kN8Xh2M/JNbr7s4ylXf5rK1H0YaV8CxSiaWdzXep7+ce7pQTm1q2NV6GS2D7tipJ9e4SdRxqh/9on4GOOH1AG1C+GDoicCAu2gXSeAot/BOhZvQ1YM/+x81UuT+I2CkZw0lnoJw+FdrLRhiQ56upcdxphNZHdQCR4KY2wotyQRGSozyiYJlt0b/8+ez48d1UP4UhMTNrZCi54GoI2KCP2+QW7eooDFJWEOXkEqwh9Umutns7UTDzV1xiP4lvTe9IB7RiEnTQw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ef6e57-5851-4a30-fabf-08dca643f5a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:36:39.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4vJKcmdqoHyXm9KPfH0N2zKf3GJ5gyldeisEPX0VJILzFAvQmgBWKK6vwyzUB8z0C9qECEfs8fdba6trRyQqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170073
X-Proofpoint-GUID: fPqYORRnqMAdCSY393v3jNwIvh5M3LbQ
X-Proofpoint-ORIG-GUID: fPqYORRnqMAdCSY393v3jNwIvh5M3LbQ

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the text to the statx man page.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/statx.2 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/man/man2/statx.2 b/man/man2/statx.2
index 3d47319c6..a7cdc0097 100644
--- a/man/man2/statx.2
+++ b/man/man2/statx.2
@@ -70,6 +70,11 @@ struct statx {
     __u32 stx_dio_offset_align;
 \&
     __u64 stx_subvol;      /* Subvolume identifier */
+\&
+    /* Direct I/O atomic write limits */
+    __u32 stx_atomic_write_unit_min;
+    __u32 stx_atomic_write_unit_max;
+    __u32 stx_atomic_write_segments_max;
 };
 .EE
 .in
@@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
 STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
 STATX_SUBVOL	Want stx_subvol
 	(since Linux 6.10; support varies by filesystem)
+STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
+	and stx_atomic_write_segments_max.
+	(since Linux 6.11; support varies by filesystem)
 .TE
 .in
 .P
@@ -463,6 +471,22 @@ Subvolumes are fancy directories,
 i.e. they form a tree structure that may be walked recursively.
 Support varies by filesystem;
 it is supported by bcachefs and btrfs since Linux 6.10.
+.TP
+.I stx_atomic_write_unit_min
+.TQ
+.I stx_atomic_write_unit_max
+The minimum and maximum sizes (in bytes) supported for direct I/O
+.RB ( O_DIRECT )
+on the file to be written with torn-write protection.
+These values are each guaranteed to be a power-of-2.
+.TP
+.I stx_atomic_write_segments_max
+The maximum number of elements in an array of vectors for a write with
+torn-write protection enabled.
+See
+.BR RWF_ATOMIC
+flag for
+.BR pwritev2 (2).
 .P
 For further information on the above fields, see
 .BR inode (7).
@@ -516,6 +540,9 @@ It cannot be written to, and all reads from it will be verified
 against a cryptographic hash that covers the
 entire file (e.g., via a Merkle tree).
 .TP
+.BR STATX_ATTR_WRITE_ATOMIC " (since Linux 6.11)"
+The file supports torn-write protection.
+.TP
 .BR STATX_ATTR_DAX " (since Linux 5.8)"
 The file is in the DAX (cpu direct access) state.
 DAX state attempts to
-- 
2.31.1


