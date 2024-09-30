Return-Path: <linux-fsdevel+bounces-30359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8937998A3BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D11280D63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4419259F;
	Mon, 30 Sep 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hvYoy90U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y/5dO0Vi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B434191F74;
	Mon, 30 Sep 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700929; cv=fail; b=XXneZxMDocl5fIa4fwlYKyVkLgQJni73LWZTw9kwIA3Nfe5OGDP4peggdvYMO47MbVnMRB8pm44kITToek6V9ni/XkXGrWGwMk+YdGntL5jUqkeR6it0XX7Pj3t299aW8EJTfc6GmBikJA3Qt5OPzyqs6ABeXlBke1w9Kw3E9xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700929; c=relaxed/simple;
	bh=bH3davgQljoxEbWBABMjEiQXVDU3ArRAoaIcitLV5NI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vzo1BnSR6eDHCwrLI+NYcMRK32+kdf+wrrv4R3jaoYmu0PxgIYRFUFZDF8voBa1N040hF7fxqQrcXLFVrD/L+BgsCGLrd5G9nHspdrbTB42gkGoJZK/3X45JI+ArSNHnBZLvnbS/SqF/Vn5H6oPBm3vBXrmBh2+lOKfHHUL3N4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hvYoy90U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y/5dO0Vi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCmVXE024828;
	Mon, 30 Sep 2024 12:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=N3pcIWB0SQX0AlI7OjorfM8qc5BRjjeY8iOnvs0mrTw=; b=
	hvYoy90UaS663gTuF0qJ2LZWjbxYEq5UB5GfqZMmrtWNr4K4/HAZmqNkEjd7iewL
	pr7nTKXGiazGx1RBxlUK7vizADuuU8TYAJCtY+CeaGNmjMlqZDonlfsVDslMNZvk
	HoGrZmc4CMNJjU/qL16aKuVFqouIsCWt0sFmc05QD7l1uqWrDhkPSPSP0yA3rFbi
	Q9+8jRJGXItoYTMfdgQ4yX0xeS9H9/dZhX1RlCq1NuLRUEgGBbOkA5GId/re54lH
	q0FOZUoEFQ3PNwk2qBI+KjtPe3SkNUvdmVO86cgGe2ST9hwvpyhuT3Sn00OqryG7
	bTq4ND4EdBWMmJq7V3EJiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d37uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC8NnS040759;
	Mon, 30 Sep 2024 12:55:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8860b8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA8WWH+uBAMUfzcd6Hg2Wp/cNTVBcnVh94lEv6Lm6ISfwMSmGCD5Fd5UxCr1f4VtmvRmBKkkZjgzkPBaNE5cWjsIQ4E/TrlVHSTL3ZaGCuGQxZ28i69pK1G+BzaWBmpCt28g95VHScbMbOpfqPdunKsSWrHDF/pOCu4dF3NAiG4oCX/JLxyvSjvPScE94VqPKzWcVNUtn35vGoHtB7xox8htyXlG/l5uFFsOH4Y44BKlgRla2IehM5Y1sB3UUzLoZV0pja+kPlOyMmOb23T6Otb9ZRIxL+EpXINJf6xCkAblzsMmxFcBr9gW5YDlNMCyR3T7PAJZosDGYnsIf9rDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3pcIWB0SQX0AlI7OjorfM8qc5BRjjeY8iOnvs0mrTw=;
 b=P6HcBHOh9A43R4j7EtNlcZN4iqrG38kEwUkBK3TMgG5230XIGGwQ/k7Qh/mVZcksluJQR3kc2AKvk+Bc7Nq3eoFhBd3a35O5M0IKRHDqp86azNaNR9f4QDmWLmzVzKq/GIfnj5ClN7AOwcZiaRcLgkdi9UnyelqgZSwygjnzkaM4QSYKtzsdsg3EGpuwnjvG7TIbyAJEXXgcMw0ZbyeoQM6g58e/4GXLXirJCOTNNeUcPs4xD79/7XfhwQIoCo8yqbmsSFcYj9oczJ95ZrEwXg4SNmmCv8HEJYacT+PWkmZmeEnHr1Q7T59pIHqfSXp6UOXGAdfav0Q2Fiag/cDddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3pcIWB0SQX0AlI7OjorfM8qc5BRjjeY8iOnvs0mrTw=;
 b=y/5dO0Vis7EtCHi9jg+DlgTvXwJjSz0/4Cb8qCOIIWnkLVQjNbUnVH89UZsXj9xWxKCm2zsxcenuip49TKd9NBIxuRFVDJFXwI3huNDlthmDNH6qYoQ/9ada2vI/xlWxsK1VfLusIuK5Fquhdg2+sBwVrWhHain2rW8PRBJ2rrU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:55:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:55:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Date: Mon, 30 Sep 2024 12:54:38 +0000
Message-Id: <20240930125438.2501050-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d442589-ecde-476c-40d1-08dce14f1b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYzK+Lcgh+CMPQni5sN1N5i2P4T0Su2LtcnSiuCZkWCB+SRJ0t8PV65vcfvp?=
 =?us-ascii?Q?piexPbzwo2pIlZnE5CCRMe9ZXH7b73zZ8/iBTShOHFeoDCgX2+iwyEAKdLTa?=
 =?us-ascii?Q?2YN9eTDt3eCmCk5oeDa9D/MPgO7CCZNnZtleTp/DwEsJ/xOVjG5is0z/D64/?=
 =?us-ascii?Q?/KjjdZmxpjkXRC1pUHqaLg0KBLOUntUCssqqW5ewFI+4NAcTKgGOGxTCNS07?=
 =?us-ascii?Q?h7dMN9LY5MW5NBOsm4Jpkv8w+hdpjuxYarKMHIF43SP+QJJnl4PbEkaFMLLt?=
 =?us-ascii?Q?ezoxSQeDFnmRMBsT26i+cax6rw13pHEB36um0aEppVzb5XxETEruZSVsJdbd?=
 =?us-ascii?Q?fMIZt6somqXzfit/zFzsgLFJD5RVvJ31A+Sr4uooK3sjU/pR9RiCzG3vA9q/?=
 =?us-ascii?Q?luvnwLIRH+CqW1NhkQEK3FcDTdnGmF5sCStxdeu0fDHHET3gshTrxLcH7nMx?=
 =?us-ascii?Q?xaJJHAwEaizZ9G+wHPy3AuNfwcm1wD843y+YMqKWG4Ctx717PR16QlJuKBHI?=
 =?us-ascii?Q?WZYQTjzVC/Q18aN9qnPhbM5ShiXFPfHAgBrQUZytxiWS2v4eGGHBrhGtkOj1?=
 =?us-ascii?Q?G+VV675Bu9pesz5qOdl+ZJRxgxzTbFZxfaXvwt1bFfJq0leyzAoLOJPDGOM5?=
 =?us-ascii?Q?Fy8y6k2aFHivbRVv4bzgMCjZ3WEkVl2dQSht4/GMIIVMKh1BQpX6GHBBgs2e?=
 =?us-ascii?Q?o2RTZGOEcXsVpvHDw94ZMUXr/7l/UMnfLxMH5KoZMVLFqDsO6+oPMfKAIqiN?=
 =?us-ascii?Q?aoesZ2T+09Lwve+LkGatPdqlC47I+GSonoRy8vh+eQKO9nFWJOSbds9y68XJ?=
 =?us-ascii?Q?xVnQNKctUUGq2gqMBvqVfj4ekS+QHExKqNq80KgL8ngFycCvPNA+xSMzb90w?=
 =?us-ascii?Q?Mz0b3S8dM/Qt5cRyUGnsxULkjMtyb6iqlmAYmn85m8904ObYr7qC9waiNHrl?=
 =?us-ascii?Q?ISvd41OBLQE7REAF3fMCVsm6BOtmdqzugIuS4mMfGTPHP0uMtenHgTXOxAgn?=
 =?us-ascii?Q?M0u5wCHp7qg29bECaH7C9MQShCjhO56Mgl/IDzaubr9mc9PY7UiKev13whV6?=
 =?us-ascii?Q?F1Vcd64S9zkLpWqiGQ928MK2+xG3339DxIZpp6AyBjVQ6FQfNpb0NNQZvB2B?=
 =?us-ascii?Q?PuiONdRueo8CyAIhdfKkC+8AGUta64cY/jIezzlXJab09i+Dx3llPgJuEZrK?=
 =?us-ascii?Q?3OyI6WOSVBRE5ormvzf2R7lPneEmL09SHrXpw4z8zDWIQemJFsjPn0jOmpEX?=
 =?us-ascii?Q?Pnsoo4FCfEZCjK9RsxUmfYoO03WFKcCPG0yyzRpJkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2cMAB9Xelmv+6Wt4kaxhneQySWEoUUlsJBRFshRCB5BmlKI7pOxmxLXnnkv?=
 =?us-ascii?Q?W01jjp44ghlKOAarz5VF8EiqQy1pktFUGpjrjNorDE/kCo+LNOBsiCFOIlDJ?=
 =?us-ascii?Q?DRoUsZSnOcKbl2aAtiUSeMrN7QfBt/rfID+ePuh2mFzOaT+vLgf7430Z/Smk?=
 =?us-ascii?Q?SvhhN7WXN9LQpsYMrZRG9/Im6O9wjQA/Kxt0CmkxUW+TqUkRT296RnDt/XVU?=
 =?us-ascii?Q?/2E2092WoeCE1u3KKlppNcrgV2K4wocBQ2M9E8dXt4zRe/glXZ4G/6AMTXoC?=
 =?us-ascii?Q?hAyNRZH68Sg1TWv9Zmd84lnlyL1b8M7o6hwJw4eRIo0O73+K27QSqrPkamF8?=
 =?us-ascii?Q?Wknm4qZt8esj+6tKtFHwiFH74THO+uckung18OncJSfK34YWOXV3hcmvYa/7?=
 =?us-ascii?Q?rOH/KP8MT+oQG+aWb6SO+w8bI2s5mKjAKMK/ddEkYQ8JZhAZcmPt/43v+pal?=
 =?us-ascii?Q?Jce9znllniGaEtPA5+gQ9dBtbxE7SAgR/YmCDfiqN2ZeWyBX5S77w9bW72pD?=
 =?us-ascii?Q?/+xj5jycR7do+xY5urAAIUvRTLFsEPsw1hqT56PjOsAVqIQ7xkm8ZeR5N68e?=
 =?us-ascii?Q?0zJFNWQDDhlC3JqFHyMBeViYC7Q66hatntabXr3Z6n+wz95I5BH+0bFYizUM?=
 =?us-ascii?Q?7hMHEifIpOqZDedpAKIOnZ4d0Wc2L0BeXe9r9JFLTWIyPNSL2lQDyYk9nlOM?=
 =?us-ascii?Q?W92EfmyoRentpfGlVTXtOOm1crLDfv9pQ9O71gfm5rFUrofQ+6bbFD7FluAH?=
 =?us-ascii?Q?rs2C5KjtyDBb4wiclCShtLioMTBxWnNd2kHXZt3CW0tPJNwuqn8R3LXesdTD?=
 =?us-ascii?Q?hbJ7ikgjGMbc+cld9WryZjxUB0rYHhgGJe2nTDn7Cpq2no4Xxe/Oq8rQTMVg?=
 =?us-ascii?Q?F4/zbieV9IDy+EKsbeGI1f0eKnzRT6/d8AXzmIRMzYSlVpQ/R9tz3vUlcnVK?=
 =?us-ascii?Q?knaC3jlzKaRTaoE/NsQ/sEJQImef6vEnu0g4gLa4vwkswrkKlrvOXxTgJZD0?=
 =?us-ascii?Q?bpkIZFgEO+wqb4cF5Tag9Sa+imlZXks2BFTgp8U2go3zFlnH5+SE1jEksSkR?=
 =?us-ascii?Q?d985QgjH6yevFA2rg6x/OYfaFfV0V1GVovz8YsTZaH5GNv2O3cHqTH04IYqv?=
 =?us-ascii?Q?S6Ex3hNAZzSuFF8KdszUnDtigolTCwklHCZrGps0TJnxDtFNgGipmclzng63?=
 =?us-ascii?Q?oHUkXVra6NzCXdMkk8cwQ0lZaOxbdJOtI+YJSQmHiotiJs+XbmnNKVNK2ap5?=
 =?us-ascii?Q?jsWHXKvuKrePulL+I/QcnltpoNiwoqhTqIq5FfcEmZ4jGHKIfSSeMF9S7B2j?=
 =?us-ascii?Q?whNkoQ6kdL97/oxbOAQyYd7OH05m0nRXAHpfoqEJ9/RUhLX7XOhgp8X3ollJ?=
 =?us-ascii?Q?So5MyiBTsPFpDWsxUGfQcpMtN9djO+FD0rS0ClSizZS8x0WwMdzdzu3MzvnL?=
 =?us-ascii?Q?jluwodITwD4cWVUh5xz7tv0wt0AI1TFe8egm73c7MOK7gfw6o3tz+9ALbmQc?=
 =?us-ascii?Q?gG9W7Xs3md0hXBqRdlD0mnIKPktxEbDSDU8WdIOAlfMs6fXpko4W0WpMJwYC?=
 =?us-ascii?Q?X5UzK+kS4QP7q9CHd3pEd1lWDlwEsQrZjKV6WWYE9d+EE6cm9oVgTGNMW4hl?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WAhbBxKuIchopP0DU04O4WXBY68w8sHO1TkNMiRL1eue8fk66RnRoMEU7QNQ9OM7zMcZTEmcJNWuN46BeBZBAnteeIKolkkSlFNc5wp/PuIYO4nrXWk/nlapNKsi1aGkxP5pz0yfV5Znawu+rvXzZfYCjGc7bylU04IC9czCLWJ7K8pHYPeNIYJS7Q5ibO2TGo0ECVPTjstaHnwixgvb3D4PlUhSFJnqB7BRyaGcOP1S66QKyjmE1hI68U8vyYh3gBIx39sXkEeXCnYCszF8yMCedIDOWgjuI7sE/HdgUV9NgVYxJvRq0UuwRFVLmg8p9EXNaJwYCVCbGZVojUPKn1KNIbQ2ggz4PIzIEBWRSKHkJHmgJc0JdBpkuKR91sber3bnH7KpzfWinWtYjDhcV3DM2R8sTwe13JZQp+bcLTsNKW0R1div7uvuvcpEP6YQC+glhEqfOB4/wV4oI0RFVAYXtm8Nf0sQpYkUAy3aUJ7h6G4lqNnQGeBXZFGWpKJyiC1vhUVsNHZJCD7Ew04ahzO2LWMvn4swdIRraCipVU6JjbBX9iiiQNgeRxMgyAEaIKVlLhtJ/j0NbIRBLbIUCGNcl9WNjV54bim1GN7P6GA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d442589-ecde-476c-40d1-08dce14f1b4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:55:05.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjIxRtG4LODblz5S/7XT02E0AsMPXFPNk+Px+cgw84Oke/WAGpfeXN0R1qDOFBPmRjLcwrqUSger4M/nqOovCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300093
X-Proofpoint-GUID: h0s6dLNQyqBQht0Z4A-eTv5oRawPH8sM
X-Proofpoint-ORIG-GUID: h0s6dLNQyqBQht0Z4A-eTv5oRawPH8sM

For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
flag. Only direct IO is currently supported, so check for that also.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fa6a44b88ecc..a358657a1ae6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1208,6 +1208,16 @@ xfs_file_remap_range(
 	return remapped > 0 ? remapped : ret;
 }
 
+static bool
+xfs_file_open_can_atomicwrite(
+	struct inode		*inode,
+	struct file		*file)
+{
+	if (!(file->f_flags & O_DIRECT))
+		return false;
+	return xfs_inode_can_atomicwrite(XFS_I(inode));
+}
+
 STATIC int
 xfs_file_open(
 	struct inode	*inode,
@@ -1216,6 +1226,8 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
+	if (xfs_file_open_can_atomicwrite(inode, file))
+		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
 
-- 
2.31.1


