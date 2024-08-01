Return-Path: <linux-fsdevel+bounces-24815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E279450B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E28B28155
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7603F1BC9ED;
	Thu,  1 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jt9DlyIY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VglVvXki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B61B3F37;
	Thu,  1 Aug 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529927; cv=fail; b=OYYHP2UesPaY5vosUtTvm7MyV80xvf2tHPfpbk4/VsTlIKTutzcEV7kYiDDogguof3ucSVM23Cew4XKHRSWJdh3cAKjjE2kw1GILgBgVTPRrQ/eWDDtJOM4tbn5YxDKzIRHepg3Wr6cTlj87/bshmzBcAdZcA55VNU9SQZtp7Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529927; c=relaxed/simple;
	bh=kSm/J2GIcpkORW1LRJoOmfjleQFS3zsoEn/U5zUFaTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NR8m0bKlz2TYmuwLH1I0OanW7YhypmGvcsAN8oqb+jt0Q9m5Zz8jTEoEA6cDqPqNj3vMkVbj4HMnfpizEXgBcTPYDwZK5nluFAEGltxd4B4beJHdAmx+rOEnykOdD5pINp6Y3BqrC71LxJ+2V2iWDByPFvsdG0sQ6WhN+u8Uz4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jt9DlyIY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VglVvXki; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtV8j028570;
	Thu, 1 Aug 2024 16:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=lco7Ffv3l0/S/vyZtdQ3L34JKK2e6B3Aej8RGg51LUA=; b=
	Jt9DlyIY3RJ4XUXzKRi6hG4nZ+LvOwN0VvW/QtxHXHIAha+pvCGwo1LAhZtSgn0e
	oXlI+kjpXPo1rRtmFRI855YaYueyiLGXE3HT9PXkAsaJrFV/0xS743EtKBumBclt
	EnKZkVsX7Jn3ECPgrvJ5126BHTwa0DTEj39+aI7LutZhHRuzVJSja2juNh6Hcqv4
	/IpJvnzDzTd9UdBJRw9Z3GH7kKsTI2XvELyegG7r9giX7Ru4nDw2u9WEjdiJDVWA
	T1yy3XSWgltXirhWg9qoDgIY8PtrpGFn8n2viL0T1bHx11Fo8a/cmAwpQZcB1QrS
	ztydNz3Cy1I9ov2B9OAD2w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyj777-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471G30Kw040303;
	Thu, 1 Aug 2024 16:31:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm866rjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTIlG+YFrseOKOkZLqmook7J+6Zk9phleUEIn8AunQNwBNkWuBCzOQpJPWV9lyVuIXfyTUXqqmWNEtAkjI1Z/NSGFAozwbj4ca2fC4WbJ1dZOGHzvoY4UyyaVznbqDgwOyASd7luJxfArrcrQ+4tQEvmb9cFbv8eXxErt/4pXGNgvJyJlFFaDOxHnPxA867zUYpL6IL3p4DYAcQpGk6aet84aTk4lC3xDeyV3AAAA5rBRIXVE1WCXzvjQFdjDP1PikqxTrGW0FbwhZmX+CJUR0c02ndbSYMeRi4FAQQ8Y8xPaw6thykWxF1hGzX413gn4cZ5Pq13Gfl152gdr1DTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lco7Ffv3l0/S/vyZtdQ3L34JKK2e6B3Aej8RGg51LUA=;
 b=GifLt89req6w/WsoRQJnZOcpFZJe1z/HLDopByINmrseW4IB8A4n0/xpFO+TUewu8YeoAMdzkHowlDO+FJcloBAH0PCrcNyM2B2NHBBG7xX6U5CmcKqywC5fGh3EzR2xEubyiPAKtWh8SF75ZPVYcoWWSBwnOZHQxlA6w/911yQjZamTa6FLg7j8uTA/XimSYGJ9zlhPl/T48geLmr3/j/j4MwjRT1VOXVBCPEuSp7Bi7QtcjF2ISMD96yAiYwjMG/5txgnyx+jmGdwncTZVuw7riuxaGtX7h199tBY+Z2rEeQ8F9tZQgsJlZRjGPBswyCd9doq+/pOHL0hgFaCTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lco7Ffv3l0/S/vyZtdQ3L34JKK2e6B3Aej8RGg51LUA=;
 b=VglVvXkiAXOK76A7Myau/49a37OJQeOK5kb1CgNNXXYhqJuveTSg+fml+U8HhOq2cMIYm2jZguNxMXuiPYnzm3jrYy0UsACkFkwwLf6W0Mm/T4bSZioXlpHChPjkO3KuWEOw4qpj3335MP43MJr/DjfmKgju0q5Kkn8bx2ymlJo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:40 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 03/14] xfs: simplify extent allocation alignment
Date: Thu,  1 Aug 2024 16:30:46 +0000
Message-Id: <20240801163057.3981192-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 18581e63-ed45-4182-ffb3-08dcb2476bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qnxk5XAHjKbFGxbgb7IrB9dD7ZovTCHFl5aLixLC83K05C0FGeX+TzcRPS2c?=
 =?us-ascii?Q?m1bcon0yCL61qRuksQ2NNf1Emr/ZUwk/oLFbLZktMASUTvhjmJQVfc+Q6Fi5?=
 =?us-ascii?Q?WQUsQGw9zeUe8emaqN+Y7nB2h/d87WOxqIpuowsE49Hu4S/ok1mjnqoK6GMH?=
 =?us-ascii?Q?50gt3k8TKKHPiL1hm9oxXISTu2WojqqzkVjsvL7vcBkOx+0znNTXfTt5mvXp?=
 =?us-ascii?Q?UK3N/oRUMlvoUsRuSrtl4y+kIlgSUbPmzHjAzdeZKL7GxWBjbIYEhVM6qFSe?=
 =?us-ascii?Q?xlL/gSIAkVBj6eyK1AT/ck1NgkRHKddG/lBSm9VrVBMHnkcf3B1dTRVX6RgH?=
 =?us-ascii?Q?ajB5nuoD/SCXBp3v60VM57HrfS03NZ1RsDK9BYg7JDyfHbxUmQ7H+dFszk9E?=
 =?us-ascii?Q?Q4P6SJ/+w68G9zv6M9SROFdhHzWJ20FYImsGHRcZoOHHFbaZK96WyxDt0N2v?=
 =?us-ascii?Q?lcyjXRwqGwxmjs60zR5Toktn5lNVlhVpHZd7GlU6udRc8ekNLvNyO/60zT2/?=
 =?us-ascii?Q?CEGDWS4aAS9K+YMnEkrLDGmN/OmupbTSaxpiBJI0kJ0YVeeSvgwpbjlG2o0V?=
 =?us-ascii?Q?SA9Xvk6wxMST8tzy1eD/weuUDG4Qb3MlTRwnc+BnezcFsqEgOJvjx+CTREiP?=
 =?us-ascii?Q?ofjCcDwJ1QV6gr67F6plzWDkhu9G8pbWtbCZ3fSBhm+Nwy/fEmKUkkNnMiIl?=
 =?us-ascii?Q?FBDo3doi1CeFGAUqEkgrVwIjxZdlFH1N1tWAPj2vC3gXwzJvSAYRIicCsxw5?=
 =?us-ascii?Q?FfwnAdeNzEqrHUyEqyuzm2TvW6U3pOb+5BH9klao5LsBljQyohVHZfDjd40w?=
 =?us-ascii?Q?2cOXLOs2y6Q6KP+0j/K+wr8y3994SAowlFlhWSoSfGK4LMsInK1c7nIVXHu8?=
 =?us-ascii?Q?2xtK3NQvuPuesbd7UNbRbh/PJq8OVIYL/jks7cwIj/D4jHP+H1ajnUAYG7vh?=
 =?us-ascii?Q?hV+CrLJfJLCZusonA2ONHwSIDW2HmB1EUPyetTY/+fMQrM7z7kjRuOFodyBS?=
 =?us-ascii?Q?rXwoa4UZMsAT3WGAbbG6taIOGMWUnRfnXQdWJQsp/WreUQxi6W10B62TyDgE?=
 =?us-ascii?Q?NGvd1ddtqyIvqd7uDJJjrK+nqXJyAzumpUSk7tl8Rr2bJCLKHgaya6o9Um+D?=
 =?us-ascii?Q?Yd0+BbWuXTnhlVXjCAnobM/LbKloEh9sk2oysvqpjSOA/QPt5uSUnRJw9bRm?=
 =?us-ascii?Q?kFg1qmA2dsJC0aunY1qu6uAbkaelUT5Fhiux0aCdyLdRMrqGGTGO2JUlU32a?=
 =?us-ascii?Q?2aUdjwj/u4RIh15vN94JxOw4fkvY7adHk30LwvUFiKiAfsYCp0uSoLusIOrD?=
 =?us-ascii?Q?ENaEtzFtRuXVbQGWE+Y178hnQ+MbqPLGU22axo2Ay7dv3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mk8iANh+hHIiSiKdMDkZp8fjj0DwuAXd0SxPrKKd1zCHWX9/lyndtwg3Atv+?=
 =?us-ascii?Q?YwfS7Hq+8vpPokLonGngNTjWJ/wULWLwhXJ+7pGLbyk+N2hyhi7PzgZwPTC2?=
 =?us-ascii?Q?M7FOhP8xtYOjDbnMybdncRcqwiMgvJ8ey2eCeQnCCnYYaC+qcKMiwRGUhyEY?=
 =?us-ascii?Q?cLSk9XUiiKT1ZHab4SUyVBXdaJAQtQZXSzAhN/CZ41okFLx9v3uD6KE4s+zf?=
 =?us-ascii?Q?sXvaxrgml1RfCX795nQ5RHEodCBKY89SKOQtkrQ+1zPqpr6BTkQGDIt50zk7?=
 =?us-ascii?Q?V0bfaser5athqhsnwkNFv2XE8kyaoaMRbLKFD6OSjnW2asbwIbShHwLJJecZ?=
 =?us-ascii?Q?dXcGTZdwd8MmujZDGjdVtTZkVBx1ASjLbT2lPc/lTSE0PAGzEG2f8sQltTOt?=
 =?us-ascii?Q?mpaUykFgaDE0vnD+pYtcD3gE9cR5d8JwBpO2a/a4tl5a2xrd/wUiBKYumvfd?=
 =?us-ascii?Q?yXezN1YmsVOObxX7WQjloMrKxWlgbRKv3kI99xN+q9Dqjoz+ttomR8C7NtQs?=
 =?us-ascii?Q?xOhgF3Z6j2G81wErHntng/J75nowG7/1YanQ5JkuSOGDdDMFXTfHiWNDICdY?=
 =?us-ascii?Q?UYdvfpmQgW5MrASKgyYok0K0TlMWqrZvhTwr73Z14uds9Haq3XOxd3dYmA2A?=
 =?us-ascii?Q?RjKwZkwbDqbMUv/v65OatMLNpYZZnzS7En0D5BD9EvmlAkphTqIDEMqJS3B8?=
 =?us-ascii?Q?Mc5CT5KjoJgQrW3sG8Q6FpJFLPbFh+XohWrz6ueO/DSD7UE4CraL8h49v9OF?=
 =?us-ascii?Q?2qHoG4OS/jA6PjrYmlRjOu7fKqKwAwksYUXwpiG8aKaZCx/woY9lMBvOAH8S?=
 =?us-ascii?Q?7Rpyc2zNr9ZODxJWLQeDelzF5r2UY2XTMzuDpmF07dmUkSkRsFRqucAhJsGU?=
 =?us-ascii?Q?zJ+sUt0CDzEYAcllISYybZDD+pPsBDMpmxKTXL6PWiQgJ7oj6BJ7Jt0W+oLv?=
 =?us-ascii?Q?P8Qq4+cQVklR3JgwCwLVp3UHE3C3APajuDR7f4A6ILuE+1GyfRVxDKU6Qk4S?=
 =?us-ascii?Q?YQ6yNg71f0BH69Tmm2Ad2mPIROgHTq25ss2qCz1aTqng+3Z+E2QgsZM31ta+?=
 =?us-ascii?Q?h0iFte+Oz7/T01ahLAVWCIje/jNPDl2nJeWf0bD/YtByN2VSbULZt5sqoP2A?=
 =?us-ascii?Q?Gfp8g+PRR4DRB7+vCOf1djpJyM7FWZYlUdbpbqtF4/iRRI7zWodNOc8CIKVa?=
 =?us-ascii?Q?STJkVAZ8rOtVYKoGaaDwWO+pewLhRsUIp5NO/36n9tBeu7C5oUzm98nLWXtL?=
 =?us-ascii?Q?3o4Z4x0TzCoFufYHKlMdZx4LkBhfIruTPnXn5ttVuCh6LAldgPI6Rfjicejd?=
 =?us-ascii?Q?7CyChhQGgJjSpJ3JPK5KLnzKvzp80BSq/62Yk0inX4JK4I6sUs2yaITFsc/c?=
 =?us-ascii?Q?yjPS/yekBG/YYNuMTuENIqM37NQt3nTqCP15fyKCBk9WfD33QEObs2H4EP52?=
 =?us-ascii?Q?YKyKDGfw/0fgSobrpYcgjZDhDk+3PMnxQuh2oNiVi7KXgqFP8e/qM3kwNuGZ?=
 =?us-ascii?Q?gXIBuw6ZtAO1cH+sOjxiMX6VOT0C+eX52IzqY100k4TwPYKngHkwI+KsWiPs?=
 =?us-ascii?Q?/qeY0FMKpsO7AWShu+pjbF0bZV2iW8qECf7w/bYjJrMtLp8jy6yA5gtdy41v?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	avciFrSVzrwOepsi3uUWhl9Wy1vco54QdbAVtzE2tEK/GHAylzY6HA2wM402qalFEe8ugvr2UvozRledyxgpEVU/NUmR4OzG4FXms4lgcubzaT8ydotpsBAfs+X0F57LLMQs0gQ0gj2nrANQWayE8/VzVPuJCHFWooGPTcmTTTYIbmWSJh1nQc+xgliqNZdzRUw/7uXsmblcNVpiz/PsY0jP1Xyvi+SLqyxo+S5LIxV7lb87jA0pgRWoaTiL0ubITj8olSWPRkGG/NCjTE3jcdMH30QMI+1Hn2HH4r+07AHk6QMbwcltgBvFCBF2NOdMP6AhubKc+nYxGy5oMCwnA1F14B1ouEe9vfO4qXFV1iwOhp5F6u5mdvQkJnmjQ5SwxbJXS+Z7IKFoOyb04S99nPX2COh4oLpTju6p6VkxjGbwaY/ux1tD4dB+m8w006KyQixgqE5UKNByhI2t3Gk98IpVySEBijxhHJstZ4qyTT5hDEaUzgajq4ZqpeRXhz+n9aYc6S0JcPu5jpcViWl1uirvmemmbrAYJKRLubgRzAGH51vWEpaRIUWqJZq9VOx3b5AtDk+Xjln5iHQnTps3oyJDbbsNc1WYR7xaNzw/cCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18581e63-ed45-4182-ffb3-08dcb2476bb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:40.1862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcm1jU7Zsi8Qat4rM2ySHw0sUMqyof31rpu3zxUqU3fm3ZSBtkorK8uzHyJmTR7cf6srrE+WomGM07TLgHp3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-GUID: ATuZYtKiQci8Ufk6aZfpjxdFKBTxqWiq
X-Proofpoint-ORIG-GUID: ATuZYtKiQci8Ufk6aZfpjxdFKBTxqWiq

From: Dave Chinner <dchinner@redhat.com>

We currently align extent allocation to stripe unit or stripe width.
That is specified by an external parameter to the allocation code,
which then manipulates the xfs_alloc_args alignment configuration in
interesting ways.

The args->alignment field specifies extent start alignment, but
because we may be attempting non-aligned allocation first there are
also slop variables that allow for those allocation attempts to
account for aligned allocation if they fail.

This gets much more complex as we introduce forced allocation
alignment, where extent size hints are used to generate the extent
start alignment. extent size hints currently only affect extent
lengths (via args->prod and args->mod) and so with this change we
will have two different start alignment conditions.

Avoid this complexity by always using args->alignment to indicate
extent start alignment, and always using args->prod/mod to indicate
extent length adjustment.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
[jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c  |  4 +-
 fs/xfs/libxfs/xfs_alloc.h  |  2 +-
 fs/xfs/libxfs/xfs_bmap.c   | 95 ++++++++++++++++----------------------
 fs/xfs/libxfs/xfs_ialloc.c | 10 ++--
 fs/xfs/xfs_trace.h         |  8 ++--
 5 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index bf08b9e9d9ac..a9ab7d71c558 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2506,7 +2506,7 @@ xfs_alloc_space_available(
 	reservation = xfs_ag_resv_needed(pag, args->resv);
 
 	/* do we have enough contiguous free space for the allocation? */
-	alloc_len = args->minlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->minlen + (args->alignment - 1) + args->alignslop;
 	longest = xfs_alloc_longest_free_extent(pag, min_free, reservation);
 	if (longest < alloc_len)
 		return false;
@@ -2535,7 +2535,7 @@ xfs_alloc_space_available(
 	 * allocation as we know that will definitely succeed and match the
 	 * callers alignment constraints.
 	 */
-	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->alignslop;
 	if (longest < alloc_len) {
 		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
diff --git a/fs/xfs/libxfs/xfs_alloc.h b/fs/xfs/libxfs/xfs_alloc.h
index fae170825be0..473822a5d4e9 100644
--- a/fs/xfs/libxfs/xfs_alloc.h
+++ b/fs/xfs/libxfs/xfs_alloc.h
@@ -46,7 +46,7 @@ typedef struct xfs_alloc_arg {
 	xfs_extlen_t	minleft;	/* min blocks must be left after us */
 	xfs_extlen_t	total;		/* total blocks needed in xaction */
 	xfs_extlen_t	alignment;	/* align answer to multiple of this */
-	xfs_extlen_t	minalignslop;	/* slop for minlen+alignment calcs */
+	xfs_extlen_t	alignslop;	/* slop for alignment calcs */
 	xfs_agblock_t	min_agbno;	/* set an agbno range for NEAR allocs */
 	xfs_agblock_t	max_agbno;	/* ... */
 	xfs_extlen_t	len;		/* output: actual size of extent */
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7df74c35d9f9..25a87e1154bb 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3286,6 +3286,10 @@ xfs_bmap_select_minlen(
 	xfs_extlen_t		blen)
 {
 
+	/* Adjust best length for extent start alignment. */
+	if (blen > args->alignment)
+		blen -= args->alignment;
+
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
 	 * possible that there is enough contiguous free space for this request.
@@ -3394,35 +3398,43 @@ xfs_bmap_alloc_account(
 	xfs_trans_mod_dquot_byino(ap->tp, ap->ip, fld, ap->length);
 }
 
-static int
+/*
+ * Calculate the extent start alignment and the extent length adjustments that
+ * constrain this allocation.
+ *
+ * Extent start alignment is currently determined by stripe configuration and is
+ * carried in args->alignment, whilst extent length adjustment is determined by
+ * extent size hints and is carried by args->prod and args->mod.
+ *
+ * Low level allocation code is free to either ignore or override these values
+ * as required.
+ */
+static void
 xfs_bmap_compute_alignments(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args)
 {
 	struct xfs_mount	*mp = args->mp;
 	xfs_extlen_t		align = 0; /* minimum allocation alignment */
-	int			stripe_align = 0;
 
 	/* stripe alignment for allocation is determined by mount parameters */
 	if (mp->m_swidth && xfs_has_swalloc(mp))
-		stripe_align = mp->m_swidth;
+		args->alignment = mp->m_swidth;
 	else if (mp->m_dalign)
-		stripe_align = mp->m_dalign;
+		args->alignment = mp->m_dalign;
 
 	if (ap->flags & XFS_BMAPI_COWFORK)
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
 					&ap->length))
 			ASSERT(0);
 		ASSERT(ap->length);
-	}
 
-	/* apply extent size hints if obtained earlier */
-	if (align) {
 		args->prod = align;
 		div_u64_rem(ap->offset, args->prod, &args->mod);
 		if (args->mod)
@@ -3437,7 +3449,6 @@ xfs_bmap_compute_alignments(
 			args->mod = args->prod - args->mod;
 	}
 
-	return stripe_align;
 }
 
 static void
@@ -3509,7 +3520,7 @@ xfs_bmap_exact_minlen_extent_alloc(
 	args.total = ap->total;
 
 	args.alignment = 1;
-	args.minalignslop = 0;
+	args.alignslop = 0;
 
 	args.minleft = ap->minleft;
 	args.wasdel = ap->wasdel;
@@ -3549,7 +3560,6 @@ xfs_bmap_btalloc_at_eof(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen,
-	int			stripe_align,
 	bool			ag_only)
 {
 	struct xfs_mount	*mp = args->mp;
@@ -3563,23 +3573,15 @@ xfs_bmap_btalloc_at_eof(
 	 * allocation.
 	 */
 	if (ap->offset) {
-		xfs_extlen_t	nextminlen = 0;
+		xfs_extlen_t	alignment = args->alignment;
 
 		/*
-		 * Compute the minlen+alignment for the next case.  Set slop so
-		 * that the value of minlen+alignment+slop doesn't go up between
-		 * the calls.
+		 * Compute the alignment slop for the fallback path so we ensure
+		 * we account for the potential alignment space required by the
+		 * fallback paths before we modify the AGF and AGFL here.
 		 */
 		args->alignment = 1;
-		if (blen > stripe_align && blen <= args->maxlen)
-			nextminlen = blen - stripe_align;
-		else
-			nextminlen = args->minlen;
-		if (nextminlen + stripe_align > args->minlen + 1)
-			args->minalignslop = nextminlen + stripe_align -
-					args->minlen - 1;
-		else
-			args->minalignslop = 0;
+		args->alignslop = alignment - args->alignment;
 
 		if (!caller_pag)
 			args->pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, ap->blkno));
@@ -3597,19 +3599,8 @@ xfs_bmap_btalloc_at_eof(
 		 * Exact allocation failed. Reset to try an aligned allocation
 		 * according to the original allocation specification.
 		 */
-		args->alignment = stripe_align;
-		args->minlen = nextminlen;
-		args->minalignslop = 0;
-	} else {
-		/*
-		 * Adjust minlen to try and preserve alignment if we
-		 * can't guarantee an aligned maxlen extent.
-		 */
-		args->alignment = stripe_align;
-		if (blen > args->alignment &&
-		    blen <= args->maxlen + args->alignment)
-			args->minlen = blen - args->alignment;
-		args->minalignslop = 0;
+		args->alignment = alignment;
+		args->alignslop = 0;
 	}
 
 	if (ag_only) {
@@ -3627,9 +3618,8 @@ xfs_bmap_btalloc_at_eof(
 		return 0;
 
 	/*
-	 * Allocation failed, so turn return the allocation args to their
-	 * original non-aligned state so the caller can proceed on allocation
-	 * failure as if this function was never called.
+	 * Aligned allocation failed, so all fallback paths from here drop the
+	 * start alignment requirement as we know it will not succeed.
 	 */
 	args->alignment = 1;
 	return 0;
@@ -3637,7 +3627,9 @@ xfs_bmap_btalloc_at_eof(
 
 /*
  * We have failed multiple allocation attempts so now are in a low space
- * allocation situation. Try a locality first full filesystem minimum length
+ * allocation situation. We give up on any attempt at aligned allocation here.
+ *
+ * Try a locality first full filesystem minimum length
  * allocation whilst still maintaining necessary total block reservation
  * requirements.
  *
@@ -3654,6 +3646,7 @@ xfs_bmap_btalloc_low_space(
 {
 	int			error;
 
+	args->alignment = 1;
 	if (args->minlen > ap->minlen) {
 		args->minlen = ap->minlen;
 		error = xfs_alloc_vextent_start_ag(args, ap->blkno);
@@ -3673,13 +3666,11 @@ xfs_bmap_btalloc_low_space(
 static int
 xfs_bmap_btalloc_filestreams(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error = 0;
 
-
 	error = xfs_filestream_select_ag(ap, args, &blen);
 	if (error)
 		return error;
@@ -3698,8 +3689,7 @@ xfs_bmap_btalloc_filestreams(
 
 	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
 	if (ap->aeof)
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				true);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, true);
 
 	if (!error && args->fsbno == NULLFSBLOCK)
 		error = xfs_alloc_vextent_near_bno(args, ap->blkno);
@@ -3723,8 +3713,7 @@ xfs_bmap_btalloc_filestreams(
 static int
 xfs_bmap_btalloc_best_length(
 	struct xfs_bmalloca	*ap,
-	struct xfs_alloc_arg	*args,
-	int			stripe_align)
+	struct xfs_alloc_arg	*args)
 {
 	xfs_extlen_t		blen = 0;
 	int			error;
@@ -3748,8 +3737,7 @@ xfs_bmap_btalloc_best_length(
 	 * trying.
 	 */
 	if (ap->aeof && !(ap->tp->t_flags & XFS_TRANS_LOWMODE)) {
-		error = xfs_bmap_btalloc_at_eof(ap, args, blen, stripe_align,
-				false);
+		error = xfs_bmap_btalloc_at_eof(ap, args, blen, false);
 		if (error || args->fsbno != NULLFSBLOCK)
 			return error;
 	}
@@ -3776,27 +3764,26 @@ xfs_bmap_btalloc(
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
 		.alignment	= 1,
-		.minalignslop	= 0,
+		.alignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
 	xfs_extlen_t		orig_length;
 	int			error;
-	int			stripe_align;
 
 	ASSERT(ap->length);
 	orig_offset = ap->offset;
 	orig_length = ap->length;
 
-	stripe_align = xfs_bmap_compute_alignments(ap, &args);
+	xfs_bmap_compute_alignments(ap, &args);
 
 	/* Trim the allocation back to the maximum an AG can fit. */
 	args.maxlen = min(ap->length, mp->m_ag_max_usable);
 
 	if ((ap->datatype & XFS_ALLOC_USERDATA) &&
 	    xfs_inode_is_filestream(ap->ip))
-		error = xfs_bmap_btalloc_filestreams(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_filestreams(ap, &args);
 	else
-		error = xfs_bmap_btalloc_best_length(ap, &args, stripe_align);
+		error = xfs_bmap_btalloc_best_length(ap, &args);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 0af5b7a33d05..2fa29d2f004e 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -758,12 +758,12 @@ xfs_ialloc_ag_alloc(
 		 *
 		 * For an exact allocation, alignment must be 1,
 		 * however we need to take cluster alignment into account when
-		 * fixing up the freelist. Use the minalignslop field to
-		 * indicate that extra blocks might be required for alignment,
-		 * but not to use them in the actual exact allocation.
+		 * fixing up the freelist. Use the alignslop field to indicate
+		 * that extra blocks might be required for alignment, but not
+		 * to use them in the actual exact allocation.
 		 */
 		args.alignment = 1;
-		args.minalignslop = igeo->cluster_align - 1;
+		args.alignslop = igeo->cluster_align - 1;
 
 		/* Allow space for the inode btree to split. */
 		args.minleft = igeo->inobt_maxlevels;
@@ -783,7 +783,7 @@ xfs_ialloc_ag_alloc(
 		 * on, so reset minalignslop to ensure it is not included in
 		 * subsequent requests.
 		 */
-		args.minalignslop = 0;
+		args.alignslop = 0;
 	}
 
 	if (unlikely(args.fsbno == NULLFSBLOCK)) {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 5646d300b286..fb0c46d9a6d9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1811,7 +1811,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_extlen_t, minleft)
 		__field(xfs_extlen_t, total)
 		__field(xfs_extlen_t, alignment)
-		__field(xfs_extlen_t, minalignslop)
+		__field(xfs_extlen_t, alignslop)
 		__field(xfs_extlen_t, len)
 		__field(char, wasdel)
 		__field(char, wasfromfl)
@@ -1830,7 +1830,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->minleft = args->minleft;
 		__entry->total = args->total;
 		__entry->alignment = args->alignment;
-		__entry->minalignslop = args->minalignslop;
+		__entry->alignslop = args->alignslop;
 		__entry->len = args->len;
 		__entry->wasdel = args->wasdel;
 		__entry->wasfromfl = args->wasfromfl;
@@ -1839,7 +1839,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__entry->highest_agno = args->tp->t_highest_agno;
 	),
 	TP_printk("dev %d:%d agno 0x%x agbno 0x%x minlen %u maxlen %u mod %u "
-		  "prod %u minleft %u total %u alignment %u minalignslop %u "
+		  "prod %u minleft %u total %u alignment %u alignslop %u "
 		  "len %u wasdel %d wasfromfl %d resv %d "
 		  "datatype 0x%x highest_agno 0x%x",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -1852,7 +1852,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		  __entry->minleft,
 		  __entry->total,
 		  __entry->alignment,
-		  __entry->minalignslop,
+		  __entry->alignslop,
 		  __entry->len,
 		  __entry->wasdel,
 		  __entry->wasfromfl,
-- 
2.31.1


