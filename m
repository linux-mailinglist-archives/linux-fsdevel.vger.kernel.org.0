Return-Path: <linux-fsdevel+bounces-31942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170599E1F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EF6B22109
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883421CFEB5;
	Tue, 15 Oct 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsPCbhHS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xbsdZbpG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4351417DFEC;
	Tue, 15 Oct 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982932; cv=fail; b=I+fBpah5JCUbLGC3dA7wC/NK2OaCUMN3C5jeJ+kH6hZlT8rpfIf9srQs8ELNm1X5KgW/7LAUPzhbd+xCkoAj1GkS1FCB5S/v3+c8Q51N4+GIhWqUZqJmLPHj5FsLjU001LOkEbm1f1DnH/Cz7JPs/Vh1SabGNVdnbtIeEp9B5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982932; c=relaxed/simple;
	bh=YdHjYbr5rOhFiPn/Yi7owSfDglnzUAm+bDHGhk7KvR8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=O+ZxqF+hgWuDhqI94YGYJ00LzOI/1GMBZ7I5iOW/uD9McpBhGar8r7yi6gRxKibE7ox/o25D93vUyljgK6eHgRJsQS4yHxAr3Zyo4iwGU+9ax6QuJ3MPg6Z4JjBdNjVF9kcCmHr7m/Sp0z5J2JV/ATCnsayey4kLlLsKEfK/vD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GsPCbhHS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xbsdZbpG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F2qm022523;
	Tue, 15 Oct 2024 09:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=2uCDlvCwjkhy8yy2
	Y03azKQg97PK9fmVhWfo5PsqZGY=; b=GsPCbhHSQEBit5g3mborxqquk6N4ZMWp
	dl8MihIpN2uy0BYEakM2Po5EAtPm+vWI1wgvHBqi31CjKNFw+nmOKtEsrn8JrwTO
	gsPYMSzXE1HhxoOaZv7rwJhP2k3WqceLQOTN4IDqaVn4TY/bvPfB/+KnOsDWGANs
	wLOltlKd6RRIv7TxLXfy6vNfK0Rjza/yEoB+Mv17GlXM+Grb6D8HMEDkLXRKengq
	qzqnpJsrkSC4kplEAw0rWD1o1QNvERPTKpEje0yMxmshJWJBU8GzNANX18yMP6Kr
	StBmaNHveqA+ejWdUFQv2f7RnnJiUYDOn3gEeXP+aZseKNbRd/gxSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2g8x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:01:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F90aRo010968;
	Tue, 15 Oct 2024 09:01:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdehqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 09:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOKRzkBOA4pZTyH/qNqotJJdwM8oSmLzNh0tkMSdc8PG5PH3TIrxP2xcyyiv/li2GTkQVwC377B8tRyxqFfx4WsRgLu/fOc6wjX3UN3W7Rd5ZD7HFRuoBjOfaf1RolqYRdqVVoLSmKMRwSdzgiYoy7SXQX777k2buC/rr64/8bFRHDO5vbdMc49Q4dUeSaxIZD6qD+FSuwdpgxxNcOYA26YyqA76oFDSKE1uTj8YHJdu6QEocVRliCdNhZjwdoZdLYdVhQTkzC03bE5K6wj9RrqK7j7heV90a8T84jjdd+qAQZ+KJFMs/TtXO0Os3hgZE7MCQOTtT6SltMl3ahUKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uCDlvCwjkhy8yy2Y03azKQg97PK9fmVhWfo5PsqZGY=;
 b=PqUQwG3TjXQ7tYwgrCXFdYKV9AKLU2030/+oY0iYNM5whlpgBgiyPcvmvPoojCrkPNgG4882D1a+zv8YqYPH6U0ab9/Cw1ScDpgdP0Y8+z1HCvDTqV/RKTVnEk2uUZ2TyiQSZYeTabtPCb1zc9tGK3v3G83CxQsynOAIW9Lv13t9JiP5e3MYK3JMjauaFDlGFznaRx1fJookeOoQVBcQJJt6JxPS4ydO3m4mhW02CEfzcEEpjTnjDtM6HEBccCmcqTPke2ahGv7INsLYig/gANmwF+ru7ZPuaWuKiyUl8F8sSxCCp0y8bNM9jB3rE4tZXU9zN0rRBlWl7h31W8J4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uCDlvCwjkhy8yy2Y03azKQg97PK9fmVhWfo5PsqZGY=;
 b=xbsdZbpGGML1PRnjNgd2wRFqE2tIWyQ/eGMGdXJng1zizneCaP9VRTuYxS3Ebl349oR1b02uisUuZAQetRC2wIBwPtzTSbZ6x4JO1zmwbv9BGff2cyLoccTRxUCdVAksYbysKC5SJZVSF9tHOt6lT7E/5VwkSrQIZ7cTpc/Wohk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:01:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 09:01:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 0/7] block atomic writes for xfs
Date: Tue, 15 Oct 2024 09:01:35 +0000
Message-Id: <20241015090142.3189518-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: d68635bc-74a9-4c46-7676-08dcecf802c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kgc+EX7NTn/bL4NwBo+jWlJnoh4K4sEpQGwTNxmPm5BeCPcGGetGQGzUUYpK?=
 =?us-ascii?Q?aGHCQ2jNX+GJlaCz9mZRqufJ/O+LxPakUJKjjnMMw0XPK3ILhrEcTghlhGII?=
 =?us-ascii?Q?2i1j8W+U46yzG8askRq64wTzbNqFP9DjrQXdTF9vgE1Gj43ov0qb2Jyq7v1/?=
 =?us-ascii?Q?z/lFjnmxCQDxSPzbTJ1pp+iuRoGid72VYcFef4MWzB4JOHsvwjlOjrAdNfCs?=
 =?us-ascii?Q?LZLBmBNxqgzBE8SLFbcp8cNMk+jaad6RnGfiYvfK46LW4sitDVPRGCGX6+qa?=
 =?us-ascii?Q?H52/liLEtWkneDDxTl/+3HPjDM4Pfg3rWOk+9ZrA4aODkfyXQpEoZ7NayfbB?=
 =?us-ascii?Q?Hh+biLPl8ewIi7UA/rpu2gt6uU33X2VOeOilcAA7+XxSZpX7qvxx3Hq8pkcY?=
 =?us-ascii?Q?9orMWD4UDL6DfkmLquge1l3F1amvVfcM70hVw/81OnW8obSk0rZaEwWb6YWB?=
 =?us-ascii?Q?EGYWpptLCsJwoP8Kq/QChFve415XF2MbMSKtOFFsHwf7n+KuVlHS0irgboEL?=
 =?us-ascii?Q?9lqNgsUQ0/usBodUNlARXdBRDwreMLuzlXDr4knGTz2dAUk/E9kQjNOpC4kl?=
 =?us-ascii?Q?bmJ5rUL5npwHknaRKkfuJTUrVyUx3NXxcY67vf7lA4R/qYB8wlX/IW8Cah+U?=
 =?us-ascii?Q?uZqFJJYpZviUW8LF32AkEPfphZvPTiy2LExNluEjQOqZnXgcbmhyI5+arpTZ?=
 =?us-ascii?Q?wFGAx/AmimwJOKMqlkZ9VvQLp0dPzbYMqOaS9fyknlctRD6IOUNsx1qLx/4u?=
 =?us-ascii?Q?NTummH441O7v56h7EkYyZIHmKGyPyOv42nvc5JCmVSqNV3DEVZwoAXJfSIZk?=
 =?us-ascii?Q?JPhGA413okcV+Ce9TdyrWaFaCcnEyUlu75tDerIJfl7zOt9eJZumYaigu0cp?=
 =?us-ascii?Q?WrfwhxDAFaL5i7Go+qwxlfxokpioHVIeNXcT3Y9vXYo6CHkJkzXv8ifb/J8H?=
 =?us-ascii?Q?jj6kq4Q8QdzGYQWcPj13K52M2AZ7DrGGfFDZ6Ll7CB2zJ0S630wZCQFU5+bg?=
 =?us-ascii?Q?iE1WayOxue/8kwKcNd4MPjHlBR3QDILUjjngYUdKJboDH+e5EfC/hzimK+v1?=
 =?us-ascii?Q?VEFGTKf566Tqg2sUawtTN61Mzh/nw1a25lwPhfbV07Qs/fplONVqsDIf0N5v?=
 =?us-ascii?Q?/LL/huNWiuK0s3GOXd4n1x1kHS+dRDljaB16BItnjDm4+ZPqkf6jR4l8PxX1?=
 =?us-ascii?Q?NYNGhUPxaapvz4SHGEcg0wViceoxdtJFDl+WtxC1DpkEBYfLpUvNsQE0gvYw?=
 =?us-ascii?Q?tUlW3uNj/rGOHc4vtwlknKNBykSStgwTPu0HK7qehw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rGpqnAQ7CCNDJtzXSAk1gLFjc2WqMRlhfbRlGESWAz9NtYsiFG8pW9Q3yoEZ?=
 =?us-ascii?Q?Y848lNpa0RJrlswMk/a2MO3pA3LS5YB3ZptIX6afg3O1hztRWVQu88J2SH14?=
 =?us-ascii?Q?CkGPiM77lAVQBJZKiex8bzWikOgpmgCJ4P399MUXni+TgBrVNNhcew0xRQTe?=
 =?us-ascii?Q?WRnZLMARhWh0R7NeQ76K68uBh+4ik8ZFc+Le7AOfSnPP5n4ny150TLFkorTX?=
 =?us-ascii?Q?FhOLBiBXWRzj/Pbfx5KOsHNbVdXL9Ry5cZQXbEahDpUK7SCEBj91uZVpWYeu?=
 =?us-ascii?Q?fWOjzmtmM1GkOh1lIrO4oYKnGDQSvqT/Sobh1SXo5yTstBUTn6sT9DnF0nvp?=
 =?us-ascii?Q?/rHXldqSvD0e2kNgTdRwY810WHVz0XDpUcP0DIrVlf9+h5bgLi3mXZLfnK8o?=
 =?us-ascii?Q?yFfCt5QZ0DNqvnFry7hJc+IfB5lC9K6MsHFoBKkRXrrZhgC8FNYGXxVzvb23?=
 =?us-ascii?Q?GX9iOqYB475Gga5a1EB6dCgPFuOzf0MUmIcv1Qk8GEIltUw/Jl5Xr5z2Mwjf?=
 =?us-ascii?Q?DiXtYVVD0UhsiKZKxan9iP3bQXDcB81ihhcNeXDsfE5Z8QH2OcnyiygWfHRl?=
 =?us-ascii?Q?OTZ+Wc9FlVNAZJ8oD9Q/8snkGtCTKlG9ypdOaOrGiGsA1vEmUetYnuHnDKR0?=
 =?us-ascii?Q?VBEuHJkLcGPLhaCoIJom3IUTsgc52d/0NJnPdCGcb0PzUUXdEnfWtC2PqQ9w?=
 =?us-ascii?Q?7GoQvcOcYlHfFY6x/jYzQyoEg/upES90OzFcdgmMlJNKYaeUtVB+63aSIqHi?=
 =?us-ascii?Q?pRdLOVmVe5JM2Dz942u/t9c4mmbZJ/FneRk6+YPt2oW7TB/yQd1cmSksa5H3?=
 =?us-ascii?Q?YT5Mxi6d4OMnZvu2QRcJ4L46L2dIZs+0PJra1G1Fqh1itum1pAb3vC2+t+rJ?=
 =?us-ascii?Q?kvb52uEKpaQzJGJuz6xDXAYROhDs/8Pmq1QjeDN2q4SuUNhA2hL1Al76GDGW?=
 =?us-ascii?Q?nQlC/HDWUaoePNcVZ0mVc42ISKAgQaxjZ4TyegoRHENpCRC87T7Y1AQNshih?=
 =?us-ascii?Q?ay6aBv4j7q2OGSfDvqYFRuRn7dZZWpRUC0kdArv1Nosf/SnVv/l5Z3+O96aP?=
 =?us-ascii?Q?+Ilv2i3QOhXSo/oilXvl4hKbiqLNqcJ7eYsHsocNT1s00SYRqMW9z5Yt7fx/?=
 =?us-ascii?Q?++Txszvb+PMNiK8sAgZKK1z7S8XhSBS5O0lNsIFb9efzMU0Zy9Z332SXdu/X?=
 =?us-ascii?Q?VuvMeVE3S/iyoYV6wNQo9dwq2L5YtL9TDKfUH+deUMskHz6A+I8deSEmzL4K?=
 =?us-ascii?Q?617AMUKiIqRSSp7on2Rft8kfidnQITqCBrYQLwdsKb7+9ufOG8abWq9jD088?=
 =?us-ascii?Q?zGHx8PwbWh7qj8FIhz9oDQ/b+9XECxTeOxRPS5KOoQl/ZjEyq9ynmDWLEwFs?=
 =?us-ascii?Q?OlvvN55t61OS6rZAtjAW8NwfTK61gYt5XBvmvAqkIZIcgpOGsCWf3QhoCA5b?=
 =?us-ascii?Q?YmFtYreaOiiK9Cd27ugjmwCBQyRrow1q0CqLhd4WjEyIyVVMsNBEytXlUIfC?=
 =?us-ascii?Q?e7nji3PoCHTqBiEDD3Ux2IGzn4++7rTLjAWRdB4YtjsaXHGvGeTCU24QRaOl?=
 =?us-ascii?Q?E+XSxbbHVCqLhzOoo5DRbuVOFKU3CwjQrjgIlWptj2AU3Nb8qJ23bgOYAmuG?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QhOh7RxHtmDQi/IAszHtB24UVyn5e1F/G9M/vN4nm3ES/STJOwSFq2MCrLfK1dcn9XodxWDPTxe7D5grVOiUuNwPthRxvnwnq8oqoUOm5bFO7wavRZnWLU5IG+wGR15Ul6XW6G/ozWvRK10vNL6FrkC1sSum44re46JzKNz6F010Y0PGKJY5LwltudQhWPMtT/Gs+/8vjvtoTnyWG6uXv1IXjz+pXpaZ+Jf+urwjQn+2cmumSNooyhvVSLs8fKZaVtliUD5AikyGu4GijdinvPtnb9SPSJv1InBEH6eWXRKX+ott4FgFPOa/umZ6VU1OLJKPIU0V9wr+VHS6BTe42Rjddioj2G3HjU2FgMwFdKgZCU9L8AWQgDx0UCeupVWpY2em0ir6lV/4MHhWWlBo3vyxL1CqhZAwcwmuBJ/ur48s9W7SBaj9k57o3KO1W4XrSvR317WWyh44CSI3n5u9QOvnBm+d4DVFHhoAFOTsSdzRjkyEy8S+r5VH3fmb929bYKmQ1hmbfoRWcUz5+sZTw0qwyZzj6tjA9jwyaywrKz6BN4kMkiEv9LqBTjB7PvoVtUGYHOfWoWfGNbLBHLK6vYk4X/zzS4k5LLM1yfVPef8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68635bc-74a9-4c46-7676-08dcecf802c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:01:52.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M75rPv3a2jCVs7X2fLvEicqlOnxBIo2EIkHylDlRS4JiqmIK5OvF3UaUvvZ2WUr3yPQ/W08VfHZDDZNSDPAsQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150060
X-Proofpoint-GUID: FZT-Wu6XdcuKWIrsiBy_7PIocjkS8i8k
X-Proofpoint-ORIG-GUID: FZT-Wu6XdcuKWIrsiBy_7PIocjkS8i8k

This series expands atomic write support to filesystems, specifically
XFS.

Initially we will only support writing exactly 1x FS block atomically.

Since we can now have FS block size > PAGE_SIZE for XFS, we can write
atomically write 4K+ blocks on x86.

No special per-inode flag is required for enabling writing 1x F block.
In future, to support writing more than one FS block atomically, a new FS
XFLAG flag may then introduced - like FS_XFLAG_BIG_ATOMICWRITES. This
would depend on a feature like forcealign.

So if we format the FS for 16K FS block size:
mkfs.xfs -b size=16384 /dev/sda

The statx reports atomic write unit min/max = FS block size:
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 16384
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Baseline is 77bfe1b11ea0 (tag: xfs-6.12-fixes-3, xfs/xfs-6.12-fixesC,
xfs/for-next) xfs: fix a typo

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v8

Changes since v7:
- Drop FS_XFLAG_ATOMICWRITES
- Reorder block/fs patches and add fixes tags (Christoph)
- Add RB tag from Christoph (Thanks!)
- Rebase

Changes since v6:
- Add iomap documentation update (Darrick)
- Drop reflink restriction (Darrick, Christoph)
- Catch XFS buffered IO fallback (Darrick)
- Check IOCB_DIRECT in generic_atomic_write_valid()
- Tweaks to coding style (Darrick)
- Add RB tags from Darrick and Christoph (thanks!)

John Garry (7):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
  fs: Export generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 .../filesystems/iomap/operations.rst          | 11 ++++++
 block/fops.c                                  | 22 ++++++-----
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 fs/read_write.c                               | 16 +++++---
 fs/xfs/xfs_buf.c                              |  7 ++++
 fs/xfs/xfs_buf.h                              |  3 ++
 fs/xfs/xfs_file.c                             | 10 +++++
 fs/xfs/xfs_inode.h                            | 15 ++++++++
 fs/xfs/xfs_iops.c                             | 25 ++++++++++++
 include/linux/fs.h                            |  2 +-
 include/linux/iomap.h                         |  1 +
 12 files changed, 131 insertions(+), 22 deletions(-)

-- 
2.31.1


