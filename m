Return-Path: <linux-fsdevel+bounces-33012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D09B15E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BDAB222C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B21B2185;
	Sat, 26 Oct 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PWuAKu/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MNcY7ilh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6E184551;
	Sat, 26 Oct 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729927539; cv=fail; b=PpDAtZfnhrUFl4CfzAN86B/XQT0t4YG55HXQdOrEtb7B7/7Vzd2N5s8Lvy0Fo0OPausyafaDMKdBqXQap4c+025s6W+DRKLuaErWGKQRdjHbdq3cqzzb+lO7R98mFHrnMEi0ff4322rD2cnpjc7XhGBAvydzQAbdMs5V8TnJnAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729927539; c=relaxed/simple;
	bh=URx+MB+d6wqrYB/3X5ImI7mIBPKhLFs10r0aaSX/1/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkH3cSF0lL6FxpLr1I7htPcKd3g/as2EpKlbPzIIVOfNuitfxFpTKk2/JWOlmGyyY4PICvs7l5V9+Be8JQY3kKTitP/HZeGhgQOL4qjvpHfVGwUx1fy2JLDTX6xwPYlcqoWLAgQ0+2FYCcrIwgfd4THiUQKVVGIoh2lTxkdw2sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PWuAKu/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MNcY7ilh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3G69V024667;
	Sat, 26 Oct 2024 07:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=; b=
	PWuAKu/5Lk8XFEOjSH8gp0D/U+y2LRPkZ8K2PDwW6OkApIxNxqq3Q9aQYh6nb+bM
	5k70SiOh/qSq9M24x3ERBUaR0HZEjul3qKOQCQ7eZY9PEP8ICc3MKUzKfth3ma9u
	lcs/o9BHtuMy5tTDpSZB6WQHqsAi5Ul3e4h6kWyLaAkdNn1cDTYBq9BmtDC4zttl
	Yg3pUbkjAhM4PHx9QpIKlislD/t6YSnvTvVTGog+7DcRUcq/yB3EH5ZJq7LVfRfg
	TTtKGZue8eGV0yz8majGCRe3r+B1JEPCszO+qOW288/Cch34GMAZiAwVKPBkJU4m
	aJDalVgOSezW4OfKHtCdFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8r4qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3Duxv031966;
	Sat, 26 Oct 2024 07:25:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv44tug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cY+WVuFezljjN0sms6nRYNy7HGp+P6eP6yMT5Hkr6V8A2gDddSyXBIiASTDVzz0U0OUtwZEDJEdSYLF8T4W80pJXWaGynl7PoiKY0DWx7ZlrcrpnxZYr3Q3eo3M3Pt37hD4o08cqDpSFW81UtYHjhR1WzZzfObk3/FBohxBx21faM6UhaKcnX79KGGmspUpBeHO4821PZg+Zk5eJj62NDqLr4Hida1dMW+ZviODMhB9jSpsKqeMODxkIL43OUXBN5vjVZ8fdjmkPCPevjOurWDaAbW2qCHEOQSx6Xr+lLY/mnmJe61kBGu1L1r778D6N1R/eVxxU1oVq7SPwp3lY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=;
 b=U9RtpMbmm9ps1nmKQwWlWQMjlKW5C0qTinMzSSzvMwYC6UOogSq/ujhBFkC+abEkIuWpviwzNC9bJLBBUJxdBxZLtKwq1USBXoSM5WYhUDJ1OwDGeCXfsiW6nIyCytLG4R56aIBkobbiVIICoKf5rOp0/0jjkgJyXFVifcu9dUA/zAHCceQm1EAGuVXhTepXxIV5PRBiXdHxIJ/kj5W1ZP5tg8MuOG+VfVeiPOn2pUZj+CTOHl8kQiNIedUhRsR4bKeHgKDnZvNbufyQnCO8e/ZWjNHY11MZcQ2f7mVjr9+dv4t7Q2qp1cDImhvBqblZDoyvUf4jmhE2mymXERBIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLlbDZlZ3nLzA+OMshfpAja8xZBB1l8GJOD6tbMQ7pA=;
 b=MNcY7ilhVVvwPC0YoKlr+IW6RQETezAZ08TCkRA6IyYSbAQLFqVg8RrM51eUaA6cWo6ZTQ+e2I5vk77KXCH7XZhkGDBRv9ekbVktYNgyMqD7GQzCiCtjC/zzmp0hE3KOCVYaSTiHJ4uEnj6x6wJ7pwEUKRzyqYyXqMdyYrKNLpU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 07:25:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:25:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v6 3/5] tools: testing: separate out wait_for_pid() into helper header
Date: Sat, 26 Oct 2024 08:24:59 +0100
Message-ID: <334ba78c4a6f4e58c60634709df26debf4b4de29.1729926229.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0389.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2d9740-534d-4abd-70f6-08dcf58f56fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eY20M5syZkPI+27aKfC1RLMwz6h6tBaY6PEIU1ANwk4Afwhkb8VUxiJhCBI0?=
 =?us-ascii?Q?mN/1Kj4uw7tMMqC9dvaHUYWvp8tZacxlCvrhMoh7qGh7Rxk4zLpIhgAhoA+9?=
 =?us-ascii?Q?QUenE/b6wt9FIGfLDISQ3zIz6DOKBoGUef6gmCuTM3xpGNT4coqk1n0lKxWF?=
 =?us-ascii?Q?ZP4CnwmbhP+9nEngX4Umm9sPD15A3HATM4H9iKLlKpnBp8mhKWoA66X8CRPk?=
 =?us-ascii?Q?Zhd+gY/Ne7PWF8plmXrFGgkDa2F2i6jdpys9UXOqVN6Df+xrW/w425qbRiEB?=
 =?us-ascii?Q?GePS1kOsQ7jM+Iac7h3gfabvT0uNGZRCpR26bDqj7XnIr0cpVGHXoT6wVKXk?=
 =?us-ascii?Q?ERrN924t4n7C28vZn8wXFVHcFuDs/wxte5lMPMx2QuBZ7eUpBGWD9FnIYuyw?=
 =?us-ascii?Q?Ss/dQbQ3SrG8N0x8RNLIo+GxbdWd0m4nxRrO8RYh7yBvcR2MGHmAXyHOlojo?=
 =?us-ascii?Q?40Rou/W+rXDy/IK/OMoUxc+6nv7Y+VivD1kqYcejcgdxNlUzl5KEMPrz3og4?=
 =?us-ascii?Q?mqUh0urVeMj5vqa9epld/begNms9sETIvdPiRWabS+9xM2H7LdPk7Q+ZC1Qe?=
 =?us-ascii?Q?OifNrjCOuqYMnlEG91g4krxBURyXUK+5FBjzrDwjoFuF/bsVvAxLW0/NRPDt?=
 =?us-ascii?Q?DlZhSgLJ2h6QgQ/st+fHRjqLThHf0BHVIImHUCAQRSHrucu91oIePNJJ6ekj?=
 =?us-ascii?Q?Ni9cgnvpdNH2arjkrvoUo/za7SU1rlYzJivBZBegDDhrDJqoSf9+zb1FhAJN?=
 =?us-ascii?Q?Dk7hbNNE7UmJT1xxtqwfycP/ZNC5ypwAN30Gr82uvkeLcbrdWx6krLOdq6aW?=
 =?us-ascii?Q?aRRQIOqbxf/GyO8bj3wX82rLdWBmDOV2PbBQimKRnUSeTyKFEwyp5DeIS1Yx?=
 =?us-ascii?Q?UXqdiPfqvumN8IS2Q1w7AIFfVZbmAPp7hAYrl3NoS3ygbJtaAH22voU4lDJO?=
 =?us-ascii?Q?fh1my9IVhT8i5m4Euva7JDnoyQtp+5LVEGf9NPzoE9O9oF6UCEuHzBZazswH?=
 =?us-ascii?Q?tlJjPs8Sx7Jg6JJQ2BZcKXTqsuP1De7HQrEpnRekSh64v/RXG6bRZ0I44YeZ?=
 =?us-ascii?Q?qa6swYv4d+lAxWddOrTYEU3tSPx6Sl7TduCvuztWMnUa/7vkqiW53skSz9dv?=
 =?us-ascii?Q?hatSrkFcgoWnUKNsXLd5QbW+nJDdOgE08y6o9zV/ahCdG8XOM0kc2Xw20KyW?=
 =?us-ascii?Q?P5M2L39QMD0MQkAdHSVQ1AzJ6JTrd6cRTKps/W/d6+pNuTQ8bVxTayL64yd8?=
 =?us-ascii?Q?vs1cQgAprpw22oySJuJ6a4N0tJ5rKKVWZjrms0e3I1jVigAyUcXoIb84BXYv?=
 =?us-ascii?Q?yYTtLUpSNyQ/1vop4xJ8tps0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCVE5teT6+iRCX4ywqzriyflKQEcCZ7c3gb/Y/eKdgVTg7ocrBzj7QG8o9bF?=
 =?us-ascii?Q?lIiwrpPtCi6K/lM8vPq8xGwpGJnW8wP7s68lZTE2rsFFA5Ffwob0c7jJFfYq?=
 =?us-ascii?Q?bCXS57zJ8dTsLHIH1INirNTlPWwICMCgP0VxVkaA5RL3ilv5N1X2AtI4Q8K0?=
 =?us-ascii?Q?4Ta71jHzjh6QFKoegAo27QV6jvIc12kfmUQ4D9WLEbgDNF3d9QbYA0NSOoyh?=
 =?us-ascii?Q?C/wQsCpColL58KfdYJAeFGjBIp7G4iFbgG5pqrUh/xutxH60g17admGuhAwS?=
 =?us-ascii?Q?l8dL2q2DI7oAnNAGd76J9JbQRyqYh1qyWVKP7geM3+/5jZ/thFJ4gumeei2r?=
 =?us-ascii?Q?IwJryL4vK1/fCgEtZQbiq0ymWwT0N+YCxT2YDoJ6QnooYme3B5eaoexaxAeN?=
 =?us-ascii?Q?mH/lZ6y4zS32FhJ/peQ0znxGIJCRVL0wKfAsh9lpDXg45TTfIKd2SJw9B/fX?=
 =?us-ascii?Q?KG+wKbZhI1saX04KODA1e3+I/PKmFF4SaGmEgVneVhlrZtEYCQUvmSFpPVAV?=
 =?us-ascii?Q?INp9hAPtKHtOXFI68B2wLYA/3+bMAuBnl3a/VgesFstiy44ri8hlZpkmoEWZ?=
 =?us-ascii?Q?zLyXjcI/YtOcagWNZxyVEt16i/y2E+1MThvTC/Zdg2s1tm86WgFCikawkn/R?=
 =?us-ascii?Q?rVsEMTiO3+Tm9arXkbMQezm8Rky+hZ+9eG+UqwFMsqv6nU8SQbLSpSHc5SNz?=
 =?us-ascii?Q?zSq+bCZOISGrkkOmykmM0cV3kCK1EB+cOACZJ8a6GhkqD8OFJFPQSsTs9cZ8?=
 =?us-ascii?Q?DXET/23a3Z73ONke6/ai8nYWfZX8EYCrqn/BtXsFsI2iGbLZIwwJ+RlKZspf?=
 =?us-ascii?Q?rEMCSPtM5RA4u/p+Xdq8b/fS8MOSrHmyT4YRUrOKFvXChpahYr4Q+TARWm/I?=
 =?us-ascii?Q?NEANK/iM3h6xKmomVZZ2KRW8umvHvXTRX0aiT9GyZtOBrh0dzjcJcuIj7DEW?=
 =?us-ascii?Q?TJg2AI08bODuBtWhtBw3EMDqEh3TYGFPRR5hSIy50/KrmRanwAkQoltbSq/w?=
 =?us-ascii?Q?USiFLRKrF/gshD4VyG+dUUqifmkUQKD0JnHczJtIE1DBNY9xgVkqgh5xtpjK?=
 =?us-ascii?Q?KvuU2I0VHonHFJvHDMWOvPnuO2vey3vqxql49/Z/PfX3fjV31DeybdNsBea7?=
 =?us-ascii?Q?E+wjDFsoeFS1jjVZHw1uxVQD5JhuZNhZLH9R4lOAuYRtFny866lc0oh3QNjr?=
 =?us-ascii?Q?1aChQv5Czen4Dhx80WBgn0Ca0KQgTQt/dAnfiqb6p8pYOw7ZoKP7aUaL4Okz?=
 =?us-ascii?Q?WlozyyYnSJyV6YJyyfNyfR2obxYAQtCuqZnYYm34v333wPQRnOvTmjCOrb+M?=
 =?us-ascii?Q?rwUJbqicgml/zGEt1OqTQCwrWFI0Fm8s10qEx147BgOfHMUz2C8LRdLyL2RJ?=
 =?us-ascii?Q?lrcdH7Ae47POEGc07smoTn0QPjyoI4Bp/ry6hLZmr1DC6UZWh904s9UQSabx?=
 =?us-ascii?Q?TFTld5gF+rQ9x5ZN6F8vbqrpaxzPsU2MvsMq3XnoNe5Sd+YQQL16Quj5BtS8?=
 =?us-ascii?Q?fsrymMvZOcDYf/JlIz1ZmhVjlZ4W7t9VATE+VfvSCVPBecqbEnaB4UDeec5U?=
 =?us-ascii?Q?R6Uz03TIkwcqsK7vL1TG/Hz9tYP7O+saEQHMX/YQxaqNkjLpB/9qg2UCpk8a?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HK2Kbpu2+XCjwz6YiZa7I2F4RHB8xJ2k2uNtnP1VLuOVtHsoKLnoOLvfSFQ7GjKENSv+j24rxoDkXhyJ3jzn21+un/zSKaFTLi2LHAoKdRTP7RwoRGkkEtaxznTu7TakH4Ljn4wyq+XzwbJrPBrwdQImxoLItDsFexVjrVbLGPSpVIBWN+VrTiKUlbghrN8BIXibFzZCElUcYjZdVFMAOXYZ9+D8UEKZd//dTnc94dWwR3acGekWGy+rBYe4xdyvHG5oc7oVuvEjjCkaVK7+6cGP2jajHNp21ONtD7/L+l3PHts5+/C4ByJq//hdIsuJ2SRuIguVWhCBv7RlnD+DsdHgEqmlNRDaRfGGImhqZiq2lGYSCN9pujrzLFCiWnQ5k6vn7e5VkQ/u3ogV84X0JvkJbVXWvGYsUJ58gWOv2zDp/xxQozXGHx97Bmj/8UAwrymIL10oTOW5E3wNUj2Jez7BtJfjxnpfQZHi+jIJlShD0MFQQzRaSTy0bvzvDpGMXmxDeTXodbwsaoUV1puCfFA8E6nnAEb+ZkcNnN/QZYyX8rp2XDc+DDMXFmWf3o4fxeLaCGwC4rArDQLjL8tp4zftlTQqzyGUFsYAYfoZBb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2d9740-534d-4abd-70f6-08dcf58f56fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:25:17.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsARB6aulFmDebW5ZA/IqmfWfJF0kX0UP7psNSmXlqREAGoMv22sQVjOue3r66Yghtwf8JA5tDl9cV8+FuahN8MKUJXTpqxooysZb/wRrzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410260060
X-Proofpoint-GUID: 0jM3AnRQHFUG9kVm2YZz7Pi2VNggFJyV
X-Proofpoint-ORIG-GUID: 0jM3AnRQHFUG9kVm2YZz7Pi2VNggFJyV

It seems tests other than the pidfd tests use the wait_for_pid() function
declared in pidfd.h.

Since we will shortly be modifying pidfd.h in a way that might clash with
other tests, separate this out and update tests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/cgroup/test_kill.c    |  2 +-
 .../pid_namespace/regression_enomem.c         |  2 +-
 tools/testing/selftests/pidfd/pidfd.h         | 26 +------------
 tools/testing/selftests/pidfd/pidfd_helpers.h | 39 +++++++++++++++++++
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_helpers.h

diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
index 0e5bb6c7307a..2367f645fe89 100644
--- a/tools/testing/selftests/cgroup/test_kill.c
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 
 #include "../kselftest.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 #include "cgroup_util.h"
 
 /*
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..f3e6989c8069 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -12,7 +12,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest_harness.h"
-#include "../pidfd/pidfd.h"
+#include "../pidfd/pidfd_helpers.h"
 
 /*
  * Regression test for:
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..0f3fc51cec73 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -17,6 +17,7 @@
 #include <sys/wait.h>
 
 #include "../kselftest.h"
+#include "pidfd_helpers.h"
 
 #ifndef P_PIDFD
 #define P_PIDFD 3
@@ -68,31 +69,6 @@
 #define PIDFD_SKIP 3
 #define PIDFD_XFAIL 4
 
-static inline int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
-		return -1;
-	}
-
-	if (!WIFEXITED(status)) {
-		ksft_print_msg(
-		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
-		       WIFSIGNALED(status), WTERMSIG(status));
-		return -1;
-	}
-
-	ret = WEXITSTATUS(status);
-	return ret;
-}
-
 static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
 {
 	return syscall(__NR_pidfd_open, pid, flags);
diff --git a/tools/testing/selftests/pidfd/pidfd_helpers.h b/tools/testing/selftests/pidfd/pidfd_helpers.h
new file mode 100644
index 000000000000..5637bfe888de
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_helpers.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PIDFD_HELPERS_H
+#define __PIDFD_HELPERS_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "../kselftest.h"
+
+static inline int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		ksft_print_msg("waitpid returned -1, errno=%d\n", errno);
+		return -1;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg(
+		       "waitpid !WIFEXITED, WIFSIGNALED=%d, WTERMSIG=%d\n",
+		       WIFSIGNALED(status), WTERMSIG(status));
+		return -1;
+	}
+
+	ret = WEXITSTATUS(status);
+	return ret;
+}
+
+#endif /* __PIDFD_HELPERS_H */
-- 
2.47.0


