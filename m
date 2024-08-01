Return-Path: <linux-fsdevel+bounces-24816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E79450B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1F01C23EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E41BCA12;
	Thu,  1 Aug 2024 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FOEpW7L+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y/bVGEDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70D1B4C4D;
	Thu,  1 Aug 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529929; cv=fail; b=NPLJ5M7u2BwtVxmKiLWOhNVrq6FDk59MQAQjUx47BCtHnHpmntEK4fxVZW2CvZnMDpX7sDhkdQJ9Ex7cEPZTfDxFRM9b0P1bfplR+zJHPq2TKkR/LAqadegZOhKfxFTiLLZdwqGsbuL+8L/4+S2MS5B4mwNcju9aBPgs0Uk6vNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529929; c=relaxed/simple;
	bh=F1lBOLtMgtfS00hl6XbX6lr3fK1+2gcVWOelAxGiE1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lZ4l1KFUzXmbOy8f21ZZ18+rcq09nmz380a6cBbYd7OMQV5fl6spIsFAq3L5vtthd0+TSV5qcJurkju9NmBEUD691NJ7tZRo9cTl5s43QFAPkmYe+uIFeqTxb6mDFwIk+JNfyzGyBFWp2w4S/vMKk3ugMerIzWrC3yHwyVn0L1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FOEpW7L+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y/bVGEDT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtX23023392;
	Thu, 1 Aug 2024 16:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=UPNtKdqO6E7kq+F8wAx7MU/BC64nkfahgWoyy/EgeWc=; b=
	FOEpW7L+78jtlqLfIDbp5dETYn1Ccj5G+y7+NXam/fzyetBfvnOUod9OOyNFFG4p
	ap6ssuQwoUo1pOY6su5NSxk2QWpXbKobFW9puS96wzpo/kRAOym6eZzZeTa1UReq
	aYAQk3MmNsxfrA+iHMVw2TtIEq8vWOGEvdgt9GA47zR1cYjt5Gb+sX8spmwh/wJe
	knSYGzJjQ+g8qQhFehs78NPKcCZS94iN++2D2vcGNYhMTONvz4BR6mSo+scLR+j9
	XjxMl8CCS4q56l+55tdZLrg8PoAb4cBgaVjuFp39k1CmUsyc/Ku8PzBgi/NYQWee
	mh+fYTigcVgHmdrpEhF97w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8t4c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471FWhLN035584;
	Thu, 1 Aug 2024 16:31:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp0es85-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMLhlYuBEOLXcezroTzgJ/ybSp0ultKbhrkCK4E+TDmoz7giH06s6DGO/Zd5SS5WK7Dbib+rxNJL36uaxyQpbEN4+5iyQ9769AXSbDfi2/jI7nLicV8MeJgFcydK5yLbrvywtBhpu1wOFLxDSa3TsTYyoq702qyKo95PeAWt42Mf94HkB9C1YKvyby/Z3ytBqQ3r1Btydk3gshQg7+kgsZ/gQq82Suc/5VtTH75kA+o2a5KUM5/gxFJuvoegfJxw5Ig9xw2zlarzv2jgGcqtmOXTgLeoq0JKbg95szULltMj2AP3+t+cNNYbEp6BDKr4UyFmWV0886OU/SOBGrTuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPNtKdqO6E7kq+F8wAx7MU/BC64nkfahgWoyy/EgeWc=;
 b=Qi/PkuneVi18qAiP29A9GSMMnaHwurGykg8f7UCYZ8UNDtVJM+xksjhXDR5eD1enidDX7nAsgS6ICO5sASj0xICcwxbgHVepbg3kFaqaiWXAbqv9JsI2E/Bhk/3+5QhzEOk+GrAXVyKRnkBjpBHQuXeNgQto2kd+fcjRvW72kg7xr0tz1M/gk2BSo60oYbMeyhAXBKIZc/oqjRaiF3N6F1MSr3QWgPT94AhKnfSUiFr1N6X7nSkghaUpt0oNbfevsxWo4aeWDFaoa6jEjwaSANQz8fH8kjFgTdkmm2Dzz2xeXUvabfprLsB5gtToqFtHcg5cO9GDN0W1cZR6ie2PPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPNtKdqO6E7kq+F8wAx7MU/BC64nkfahgWoyy/EgeWc=;
 b=y/bVGEDTstZxS97pxEaLOzeM+zPnK/BFQM2q9Lk9oLa1HCOfD23CnVRudhJvzmRP1e/MjVkBwDEBMabEKxuYizPUksPAdgPfkYm76zotTBdiZHaAnZjQ1sv9rS+pw3Gcdc5b2f7TPkkme53O5fawDFBLMkbd1OICxttmdx7HW1Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 08/14] xfs: Update xfs_inode_alloc_unitsize() for forcealign
Date: Thu,  1 Aug 2024 16:30:51 +0000
Message-Id: <20240801163057.3981192-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b95ba4-0cc6-4f00-bdb4-08dcb247708a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lo2RX2RTidwL+9XlFL3H28TAQzeePAUWejoByFqAtRu2qG/yjWIvZlXnBGvq?=
 =?us-ascii?Q?gNvPcPx72wU2682Y/t6tNExzi4RTTOene5jIBEEohWWVGId2GD3h333lJB3q?=
 =?us-ascii?Q?0hqUdp1mMyjltIsc2qxLUY0/GKwU+YtZFe6l2kb/xFs9WB0Li586B7Q+oZBE?=
 =?us-ascii?Q?befj+RauJ+Jm2MwO7VXvQzzzBn8EWaIXHsLiHcMIQD3p0HCAXGafds3sGBxU?=
 =?us-ascii?Q?RPYNXSjezNRYKGUV0UOTbc0jeRkiutKu2swmJ+bKvH3gBhsN/SKgODYN6J0V?=
 =?us-ascii?Q?itBHjxsQMppi0m83ITxS5s85V4OR5fUfsiH9UnH+quh3jeD1fGvYgYY0g3Mw?=
 =?us-ascii?Q?cqDAcm2UtSyeAxsWAnP/ZoHspA3120XkFBkgUOJ8Fyb9icbA6t6X+U7uTicL?=
 =?us-ascii?Q?OfQRGjLvtorSHM7RUZrmhaSEvYRap3eJ6NpS+I22xjZPVME76HU+MyHOolQ0?=
 =?us-ascii?Q?DEGnsqd2uge4h1dK+9hYn0dBwmR/X+XKORk9Hx7OFr7y1ttJsbk7V9mDyLt+?=
 =?us-ascii?Q?cJiCeOUX/3uTl59WSHOCouLlK++v04cu5gJjKbo3F7k1yMwHTJbK0ZjH/bXv?=
 =?us-ascii?Q?0Gl12+UMvtMa5/o95gkGEoX1B418gie1PU1E5p+1cNEnqgAcw0EOmnzNeEnH?=
 =?us-ascii?Q?d6lcg0I6oZUIIGMUzIc6EbFtnIRKNd5aaFnvWdXwFiGKksITLHr19lIFNK8i?=
 =?us-ascii?Q?pC4SB4H32+psjvKc31z0dQeGF3uRySjPybMqS+3oXdO3kKkEQ7+CFOdaROMK?=
 =?us-ascii?Q?5uQXwiBi8uvSS9PN+Vb/DTT0tqy9hz9023ivrpasQZJ3M5QBpwnfJV5CbG08?=
 =?us-ascii?Q?McYxWGvHiXp/5qKt0ufz66UzmpfY70hth/n7Kkoa9cKvWuNRkNM6uKAwfoEi?=
 =?us-ascii?Q?4Y4g58+svzUUKPBH10O3TYm3l8i0V+jqLCNQR2kr5i6Fl0+4hPQH9/nzOlNX?=
 =?us-ascii?Q?Qw1IMxoJyz/SbfsDw3udHO02ghH38pxuJCIyHQnKMTz5qkuG4cJToloepIMw?=
 =?us-ascii?Q?5XB8+H1Jm9xNxvuNQzq+3xmq9iilWkDQcmHMLca7Z3lvveCBdSS35MjMGlTF?=
 =?us-ascii?Q?jheGC65mL59BvyvcAr/PLhfaG7a47KVEEXOQnI3n47gACkJL+rnvGXI/IspG?=
 =?us-ascii?Q?jkDFWAy4nRqt0WdrY875jG43P7UoSGv9FMm3AOQwhtyaCGtTYVqnPQ/aqRDA?=
 =?us-ascii?Q?n/VXUwhK53uc03Vx7Cl8w2Uv+6nU4HetLt4qXQ6STNVsOc+JGwKw6n4gxxFv?=
 =?us-ascii?Q?+fo+F6FV0PjILwa1SIKhpD0dSt0DztDR1D/QbgQdHbI79Q4RyLQxGrcIW1Nr?=
 =?us-ascii?Q?e8KEFWPtAB+OmFA+2AZ2P5AthC5SRRxuM5C+xKLuwr2hLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMeHlzzVEaMmV9iQ4IEOf6Nj1zN/Fgh90BHlLNsRvaA40E2U7dbF2m4aEybG?=
 =?us-ascii?Q?RvxLe7dPDBXfD/tOE4haZZNx4zoIu9xRuOlo5rwqtt1EXphZ/FJb2irQQ8X6?=
 =?us-ascii?Q?Uip40Fyp7OkrSeKPUBgR8gLj8tw9YxO5+adO053pjLXg+a+dGJSPzcZW5bl1?=
 =?us-ascii?Q?u7e6oNTO/nQGPscR9LrBvHhc0/QtBqNcSvHIkGGJkAo2TNs2E3giNEvAHzpN?=
 =?us-ascii?Q?uUgvtNi5yQKE9i0ez93WZA20q4AzG4RHVlLxvc4GVATr/yWpwcpo0fh48jfP?=
 =?us-ascii?Q?TSZBvC/Nn3slISBzyP0JGxNV05EKEPz8FbTn/Rjc5w7rMWl7krEjea57Q6n6?=
 =?us-ascii?Q?NaLntFfLZcSSLMLXylcMsr6LC3P2PZLk6MpsgKN0MfD6rfdehn4LD0zstJZ3?=
 =?us-ascii?Q?aycalARuhWYxizO9RFVazU3NWxLTgbxCJ3Nqi1OyWDi/W2GQOCq6hlzYFmOw?=
 =?us-ascii?Q?8Z1UPWrF6lUjw1MNbmFZKqn9HA9TnC05C1nwm7ByYeUBg4OeI3DIVmAc4w8G?=
 =?us-ascii?Q?eppVZKu4AlmwVFbdyY6ktgK618JTgonbF5t065UZnfODcS0yp3WB2FcWw9oG?=
 =?us-ascii?Q?zqlT/3rZxHdVUeYTccf7ed/ykq8d9TQzTiiQMy6bx+qUutZQJTRn0Oc0q3sz?=
 =?us-ascii?Q?luQ2qlYh/xf1d0hoC9oGD51ui6B+324OiPoJNpIRitzm9vl+huuxTPHSnMoK?=
 =?us-ascii?Q?WXcu/1vxqh0o2TEd9nJWh9vmG2zbL4vR5IloR6lSPhCvyeMGdhgjG2eNr2tv?=
 =?us-ascii?Q?GCqNHPXbvU9h31b99v48Qr3XWI/Mgqp6rc+CPIeoJIMbbH6+1CKVfu+2DEOs?=
 =?us-ascii?Q?POtR7s+3MY+06gEBgvdJKtQAKsUSCWoSwRK29KkiMTxHl2j2OCA1F8VZV+s3?=
 =?us-ascii?Q?Taon+CmIVU/vSHuxVQ/OrN2GR5xrpUkqaz0lcImP34EPYRiYNYziOThUUTC4?=
 =?us-ascii?Q?+uoX+zt2IK6Pck8evcQELoCykZj4mPV95cO1TbOvcWg2PR7rPsKyYVzBgv8/?=
 =?us-ascii?Q?dXrN5+CPoSlhjGFuCWdJ471JPtxXPDIli8QdY4o32KrPuGIwdrHP8cPvbFYg?=
 =?us-ascii?Q?PtobcHx2oUfkb3/JHJtG5MfectiNNW98TOdDOQyPrVCG/FbttLJwt8aX7Fh/?=
 =?us-ascii?Q?2tD7+Bt8X1V/MNWf+kW1Ou1E45gIxDl38pta8eoAZWTmCmxTzNE7fByoUYmi?=
 =?us-ascii?Q?jpSI0FFHm+0SJGu1WpgKDwSaED9mv75q5gbINsZNyAH8HptpaHBxkhD609nx?=
 =?us-ascii?Q?xwmKpdEHCbjzxz+pU38pJrk15Xx1ivExAkGQhc6RGIfBkyXye5IdcjPdzSMT?=
 =?us-ascii?Q?DMum+fZwN2JPFfOFyyYNk0kYiNAur/2ccnJl5SeaLR9/0vEC/rTwBDOw0T+n?=
 =?us-ascii?Q?0jgm5Uw/oLTgCLVstk0cp9mavg4pCRpoaZPFg3OrXRTU4zULuD7RtTybovaj?=
 =?us-ascii?Q?SZkySeQq+q9RHLRb9JYqUy156zfUr+bmtnWtgk90fnaU9iZKpUk5K0IJ2Ewh?=
 =?us-ascii?Q?umwtzBceKPrQhd1ewMzhr+wpTpDbgWUNLhQ9Slndprw9528Qjk1UKZK45JNF?=
 =?us-ascii?Q?IhEIcQWQt8mNQsM7CujQ51DIrhF5FWKdXCG1tmA05mSvVeqJmK94WIO2XNQ4?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UrXj5ehz6n9EoiqMKrwiId+D1Kpbl+L8xHfMuruQR1uEtyh9itDnjgywmJtnoqH+yD4+QBeSyZhlJKddoC+mup8FjsxtzilwBv8afJogOVbrAtGM9bh03ZrifhJi7gEDR2JRP00HTHvinEkP6yMf+coIEmIrv+ONAM7fCm3BbuPVgkvuUWfbkQQ35xQf6sb2S60cZCODCYGiXzR09Az8CIQ4Vh/cF5PVkc7gT3l6j765vA/ml1UiPS1F0SjaN6yzve57Hej0thw/qb5CCk1+7vuUn4m2ezfZDcBkjz8RB2XMRUqCppSA0zBzyUiFTPyv4zL4c9HJ6+1L33/6T3JgmAV2y5LdjU+quvLLc98VsN71DodGFZ8MFjl/Z+f8OQ7g84iKj5lVQ93HaxmnAHUVkjwduJxXrLp0LvmdyxMFayNrTR+XbwdwkliMJKvobCMfWNK3bj7MHXquj3Mqy4oDJVhuUbfBncyxWsqSWXwR3np8T9kiQg/djCu3gCPGrEah+f5B83JQ8wiIkWahnt6mqtRZiB3y+QouBN6ay5tIDeYsGIg6ir3uV0dUQ9ROCGT/v1kVnoH3lY0I65Hkv6Lo57Vd+BSsHjtwCjc7CFTlZmw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b95ba4-0cc6-4f00-bdb4-08dcb247708a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:48.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3fJLURSqSx6Vo6sgkhL7IJs0Knr/6sVUY2aqGPsaqerBc7K1QgG5yZptzrTSrxXyFWKpi13V6m/FGWwzxCyPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010108
X-Proofpoint-GUID: l9RbobgXnC1Yjq4b195jowR6EP8wqxgy
X-Proofpoint-ORIG-GUID: l9RbobgXnC1Yjq4b195jowR6EP8wqxgy

For forcealign enabled, the allocation unit size is in ip->i_extsize, and
this must never be zero.

Add helper xfs_inode_alloc_fsbsize() to return alloc unit in FSBs, and use
it in xfs_inode_alloc_unitsize().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_inode.c | 17 +++++++++++++----
 fs/xfs/xfs_inode.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 7dc6f326936c..5af12f35062d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3107,17 +3107,26 @@ xfs_break_layouts(
 	return error;
 }
 
-/* Returns the size of fundamental allocation unit for a file, in bytes. */
 unsigned int
-xfs_inode_alloc_unitsize(
+xfs_inode_alloc_fsbsize(
 	struct xfs_inode	*ip)
 {
 	unsigned int		blocks = 1;
 
-	if (XFS_IS_REALTIME_INODE(ip))
+	if (xfs_inode_has_forcealign(ip))
+		blocks = ip->i_extsize;
+	else if (XFS_IS_REALTIME_INODE(ip))
 		blocks = ip->i_mount->m_sb.sb_rextsize;
 
-	return XFS_FSB_TO_B(ip->i_mount, blocks);
+	return blocks;
+}
+
+/* Returns the size of fundamental allocation unit for a file, in bytes. */
+unsigned int
+xfs_inode_alloc_unitsize(
+	struct xfs_inode	*ip)
+{
+	return XFS_FSB_TO_B(ip->i_mount, xfs_inode_alloc_fsbsize(ip));
 }
 
 /* Should we always be using copy on write for file writes? */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3e7664ec4d6c..158afad8c7a4 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -641,6 +641,7 @@ int xfs_inode_reload_unlinked(struct xfs_inode *ip);
 bool xfs_ifork_zapped(const struct xfs_inode *ip, int whichfork);
 void xfs_inode_count_blocks(struct xfs_trans *tp, struct xfs_inode *ip,
 		xfs_filblks_t *dblocks, xfs_filblks_t *rblocks);
+unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
-- 
2.31.1


