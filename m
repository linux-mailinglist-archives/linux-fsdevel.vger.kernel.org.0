Return-Path: <linux-fsdevel+bounces-36932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E99EB163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 13:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DD516B0CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCBB1AA1C2;
	Tue, 10 Dec 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="blrfxKBi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpybqxiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E51A3AB8;
	Tue, 10 Dec 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835510; cv=fail; b=qoSQjNElyXQQNbO0tkXIuyITRCEMVlYNFVWm117RzIkObbF7zoh0MeREieZvABSzZE69Py7FtlZoMpb4y9xtDzqUGqGZxkyP4F0kMks3N9tQBGR9ilI4o2vloAiz41upacfN+2cnMe3bEPcvzJMzhCYUNfhTccPe9kOxCkq4FRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835510; c=relaxed/simple;
	bh=kWgiwjQoCWVCg4ulv6EuuV+2onieZIrHz2ifgwcsd9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lzbhy0WAuRDok+Gko7tlcqwtvj/MU1z/r5xRAE2GX3iMoUO+JQFM89IGWKcxXELqPEgd97CNMsnCq0IZlqgyIdaKoStgHVKZMVq25iihE9QGlYh5LEsGP81tTRr3zwvHQye7JNsfQSm/zxPohWXcR/7wvMvet0cGZ9vYXVXA37Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=blrfxKBi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpybqxiN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAA8nJF025158;
	Tue, 10 Dec 2024 12:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=; b=
	blrfxKBiYC1KjcjLlnp0uM4n0S45uMA6KfTOjvfwF/zcTuwHdEqYbeEJefUwX9Zb
	XXw8zkv62cmHy8qyjx+n/CieiOYJkBhMOfJJJ3CqB9iGlEPF8v7a0NITdHHKVv1U
	PasAmfTrOVTy1qKAq2tWblEo6/OXpD0CbJ682tDhjNkfk3NBExOLk1R9ytF0qKLl
	m4iwGvPQwd61vflcWmY2GNKg1uCgzdltpCQr8TpEkAm1qb4F6zUl29gdGvIySHv6
	XCUAUcbL7VvLDaOgUYWBq0xznym4fEJXOoWBC7AAz3hiZpJ+XGNxCQ6Pw6qpOIDv
	N60nVfW7VYocTpkKB6P22w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt5qhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BACXpPL037949;
	Tue, 10 Dec 2024 12:58:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccteumy1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBJuAPMrRd/aiv/lQSTkgg5L24z0JpQePFSw8pVJRUQOJPNtv8oty6kkiteqlmA3NI/1tArmBdFuw0pWXQzA+n+fvmYg3vAASKqP3Ro7VbubxA4EBuyUgfvY2D9HT9NkfWNJDpAQTFE0WtNDLAjlB42H7TiK9OoyJzZP3uuNfWstF1w7zcZ0gfrJtWdQ42HNEgjIh+nxUPyqbFXxGJufusEEUCgBa7VcTLAcO1YYzUUxLGs9QWSmWmaGG3fgbXgMRz/dIsnulM6+StHFG0RNc7QJ57bZR/thMqFgpgVQRzb/JqqwS8GfhSCV05K8OvpRN3d0KvW15aVsmNlgnrG+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=;
 b=fuC2Ulg3zAbIJ7ON2obreOgavejU2TNF2YaJdn11cIyaqv84j9x51XSnm96AiI7XxLCwQVxxM9nKvc+/NNa5nd8mxATVddCmt3cRuB5x1XmmbjW0HY+whyKityDLU5igHdpgi7CMa61oQpeLrWcpCWEltoiM2ZO+C/O030pULxDdnkgX0+EliuBTQkk0VoWaiCucC9BYhg4fGdruSFN+RzDU/7VWGDU+wkh8WUYpV6AeUEjAUur205BGR9HPPmYTsMZ/7MEtu/V4outyzWORW5UK1hVJzNZjiWBan8YLa3Jfz8cVav9s8y1RygK9el/2J0oXBOfET62GkzthGru9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi6nNeWKVWfsgMMYNfG6r2SBEVk0r2mrnQLm9/GjiPI=;
 b=rpybqxiNJOly3kgJ7x9/g0vKQBszEXRG/G4b+0+9OsWf2V44x8Cyp9e0nouMIpC3fiTE8Eo359Yik/bu4oQipIpfCkEGlYjKYxnOIo5GWHaSXSh8MZCBW/fousjJJ/PkIl5vvXEnN6ApTyOG33AYtOlFXWEF4Up/7TBDVlEiFTo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4669.namprd10.prod.outlook.com (2603:10b6:a03:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:57:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:57:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 3/7] iomap: Lift blocksize restriction on atomic writes
Date: Tue, 10 Dec 2024 12:57:33 +0000
Message-Id: <20241210125737.786928-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f2a55b-17e4-4001-e69b-08dd191a45ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xIJ+TvnVEAm/+ckg+2VexsD4N1og9kw9LO+sGaiwBtk60G/iHE/Cz8A52XZE?=
 =?us-ascii?Q?K2CMkZTcBP6H5q9PM5boRQFbWZNHnsZfFZ7qiYPAS33T4I8UeUXDTJK3rjSH?=
 =?us-ascii?Q?S8JPbI4eS35LKx8iQJr44GO0ZNapIIPERA+pBlZRr7SOchWS76VvOuSQQmI5?=
 =?us-ascii?Q?VLWlTBpgaCGhbpqEERkihQ3PpUZdnWF05TYjJsCkWtRMUR/9DnGGa0Rlluuf?=
 =?us-ascii?Q?FGXVk3aAWkR2u5KrDmokLizyelwlqqd/6VXz6WQ56PAauSzZfn9deZK/tJXi?=
 =?us-ascii?Q?V5l0RjdVg3MSPwVXoAfY37nl1Qrfq6K4RAQsRvWIRikm1S7YPXljXPmlB8u3?=
 =?us-ascii?Q?FkwXRAXZZmfUg9+UhI8r9FpkwSkxY3dBpFYY0Hk68JklBkOPRV3xRWT9ZKB2?=
 =?us-ascii?Q?CggfRXxg6Kz8GPeP/AC+nSbycShlGUU+4pz5iH0sC3iWoeSbdeKM1q31KFN2?=
 =?us-ascii?Q?ezTUv0Nk9VI66kFwp8v7NeQAeUyLmyVpSRI62IY+J81TfIAArHmYIcGvt711?=
 =?us-ascii?Q?zxiBsWel0g8mRA+3p+i9XRQ6t09q7JzPT5dq0GMuhbrzqesR6xDjLeBQt4CJ?=
 =?us-ascii?Q?VB0+F0sOdJlwdFijB+dOJld5EAAbNFg+hY5fMlh+O5YfaaktIJnZwH2Vhssw?=
 =?us-ascii?Q?JJZvj0YSsWSyUHUta0D8MVY+aayJquQ467Y+iS4ZS7YSvz3ci5azRUgLq90H?=
 =?us-ascii?Q?47xu5VrdBaUH57yyGJDAE9ro3fiX/tOH+gr/9DAZKaQ2EkQ+DtWwWEXxSa5T?=
 =?us-ascii?Q?U99OZ5D1xQUCwguWH30qFeab9WJS4Ibywdzr4Xm2YjKc37RploePS3QSodct?=
 =?us-ascii?Q?FtWE/hrZrHtcKGduUpW6Y5sujyaEXITHArXqef0gyN7MTY0Wy0l/ytG1ceox?=
 =?us-ascii?Q?WJpWfFioc4JmMDWdJcsRcpsFT3DpaHd+ZV/34YRyS6Eq6eIzVUVCNf73aysR?=
 =?us-ascii?Q?/+PiKH1fDjUFraCpQu1D1MYPfrSWWeqXHeC9zgchoyalvhUcLMsRi1KRzxwy?=
 =?us-ascii?Q?A4wp4YYFONCs940/iDQMI2BEK39V6PiBb7QnIz4O17KIjIz9aQDf786Z535J?=
 =?us-ascii?Q?2E7z3skE4EzDpd4aoiLcLu4Ty4OGjZqEmWN9fPnegwjNBNMzml1ZfmpnNDv3?=
 =?us-ascii?Q?Im0JSG7OAE6ix98ZMjHsVM930YbitKahu7u7eMZ1tJfszpfe4t+x3gJpK/iD?=
 =?us-ascii?Q?PO2CHhLE7ynh4xSwFp8n8h/oPdExjxvvAUZAbC0Lfz2uFQ1z8f3VijrEUrbp?=
 =?us-ascii?Q?R8afOpgGDeBTOXKL91PSWUMxxlRRJRjzALAWs6gqBK4GqMA4p2kE62MFpPu5?=
 =?us-ascii?Q?CeP8jcuov+nVHvbES9hbmGeS9YsKigQGm2wUXEYXG/0cgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkMUskjeE0DycB04I4TdGJiLzbDBTAxpSwoiBXu+O8vPtnN3aVUO7yBpGOqw?=
 =?us-ascii?Q?B2ifceZPsUMOetkYf/WvxyBqySFySvvSpTT31r1nsIH1TaJEuufq/VTo1DIQ?=
 =?us-ascii?Q?CJeA9vI+VXU49ausHKBfszgK2DZEVBMjhiSKaEMKRyqSn96ck4Fj1ongwhfw?=
 =?us-ascii?Q?FGn5fEuLixuNVbs5Gan+veNWAyxriyJRoBbhfIbs/IEYzDoImf0/HKOePbgm?=
 =?us-ascii?Q?xvdtlb/YwjRYtYqrQs9Pqd0OG60t//7jHvrSh5dXX+Q3KBEUdvHipQVD9SBr?=
 =?us-ascii?Q?9AMiYn6YZ7ZKINr9ctAJ0bFkT2tsZKAOu64Lq9dx1iML+guijtJjuRKGOF2i?=
 =?us-ascii?Q?wNxOincymuV+IXW6EoMZQDkUcFH4TYTJDETd/npyhw4HVIaBpliYBItofjn/?=
 =?us-ascii?Q?nDOzcnCOcWJ8Y9c8bFtgeJRF1zArjQZNosuqFQYLEY9YxhSuJEDsQNDoc/IS?=
 =?us-ascii?Q?Tk6en1Qfv/lPVG2v5g5Wr1cJXA/m/FXjulz1bng2yCZwNA8lzFywekZv0AQX?=
 =?us-ascii?Q?MebxpAKjB7tnhltj1vB2vtuIcjTHWoPY8mEA5PEl09ql3YURLDyVLU/zl9x/?=
 =?us-ascii?Q?UagIFzwQsfyU4rMmDgX9ifL0TmWvw1aoGMmM20TVgyKHRft91auJdgSdKswz?=
 =?us-ascii?Q?s4zqDXIH0Okg6kf+ekShUdyl0mNnwTv5sX0xpwXaFr+LjmG9PU49HJP28+gC?=
 =?us-ascii?Q?5Gb8o7BRgjdh4PSQ0bZLC5vXBEXl/ODXatV8WrQ4ThqahN0LN3syr9fxQY1t?=
 =?us-ascii?Q?bSo+nW1Fc2Yc30gsQcIcUNAAbbUkdRCWTwnwaaTzKC5FphJ0L64HrTjYKsWB?=
 =?us-ascii?Q?D65aXMEFvnd8mUpstlbj/R34gjMShuF2HqOqnJwrFZrAfteMgRUwnbZCQ3Iv?=
 =?us-ascii?Q?euFwEnIL8ea3bo2eniLZqB0f+XYbYLQXafzoZqhAPaobp5q+dOWxNAV7Wihv?=
 =?us-ascii?Q?+UVUIELJ+KjSylotgyuHfWE0SBbKGWvifdPlb5qRjzOljNbi/qRr91giaA+h?=
 =?us-ascii?Q?NXE4J1mVP74JXQ9F7jeo0RheBdJi07l2PytlqxXxXRetVm5juWbGcuhgL6Up?=
 =?us-ascii?Q?imEVrK3Axq2PP+GEXiX0Q3ZUtlAiAKKPz1um2GudXWeZrFrbcX3Euwh+4nZ1?=
 =?us-ascii?Q?zcyDceE/bwg2vWAvbQxUXvHROQEI7ogJ/ojCKNgCpyh8wu/W3X09djqH6IeV?=
 =?us-ascii?Q?qqL6rN++AIys0vR2syACQPRylZD3OcpaBCC4k4kjdXKXA/qRy++ex4eLSav8?=
 =?us-ascii?Q?kdtv6cwMpb5zeCNMhLVX5WwSvODWCsfM/zbQLjqUB6Os15poI6vYEx644DJ3?=
 =?us-ascii?Q?QQpKwjN9PaIx5HxGEhCs6RU+MvfTyqp33KTkWys/n7fJIO34YX+OPClh61Ol?=
 =?us-ascii?Q?yP9K5yWxc/hIcJIWRmmTT+eCv+otvo9LLbtnygg84MHsgfIsd+eej3XSAQpK?=
 =?us-ascii?Q?Vo824irvVUkR/StAqjt5hE+IivEr4tqnh9mePjkLu1ElEY2lXDWIawlE2cUo?=
 =?us-ascii?Q?fbfU/OiJ4irLi8gms/bWUtatVoAHmPl5ERInGinWeubzmxIlMDEQgGMR7LeR?=
 =?us-ascii?Q?jUJJ/LPsS3gm0W86GNcKCFP7djrOjuTnIPjMfwOV/8GxB4ZRx7nWlmQt9YjT?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tWLK9E/rrQ/rQdrqFj2wAZIbnYrXrDzKwSjotk4t/eRCBM1sG3+jhCdvD3ex+yTb0T0lNwGfMSmO61KcvraxLfo7n4xUevMSUQRe6rNzB6i0hLvuWNU6sqZ3q8NYX27w7aDRqNJPEpYl83YlJw6HFN/aJslUeIZGGe7whcnrJDq6BUBgYOQhdY3pRRcY+C6jzYPkP8rCFx/t2pSKv2G+gvbl19KGIwqL3Mv4qWizMRExN4l7Ow/fxpRoF5Uc1UgkrnKat9PaF7bVm0eR2zZO9o8KQgLnGcklYFddtFT1+s07cKYMoyQb9a5jTMlwtsIJoCrkXaN+6RVtJLcYu1ctvzfZjOt3ALdIDMXliVBxht64PEkBesSrq6717k5bKR8p5wy3rc0OWcxNP6nJOg1fd5V9kaayufJzohTxi/BoIeWCSmEuoN3AaUPLUiangdNo9fb0165UxZEJGkMGYlV2rhAzG4sV+MIzTFGSsQHtWtp5HHt1lPB5s+6TOlU9SVOamTvcg8XE4QA99D18sAvLWVB7ynAGzPcQrh631Vp1y+vt1vU76qjVKuY4lLrxRh+Yi7Tio2nHy4xZmrBl/sH/mIvZfgOFkDLPrRoPcuxLe8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f2a55b-17e4-4001-e69b-08dd191a45ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:57:58.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr6gCgIH/ul50IvmBnvfPuRgbL5ix6Tm4KrYCANcasta6mJh+R8392Nfnrh7rnNLFDFWPKhpCcNDhHR32u5I0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100097
X-Proofpoint-ORIG-GUID: ppYPQsMi_wkQLZDMRL2Qi_9pOSCQ0J3q
X-Proofpoint-GUID: ppYPQsMi_wkQLZDMRL2Qi_9pOSCQ0J3q

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

It is the role of the FS to ensure that a single mapping may be created
for an atomic write. The FS will also continue to check size and alignment
legality.

Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
jpg: Tweak commit message
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 18c888f0c11f..6510bb5d5a6f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -314,7 +314,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != fs_block_size)
+	if (atomic && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1


