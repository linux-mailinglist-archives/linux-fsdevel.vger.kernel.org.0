Return-Path: <linux-fsdevel+bounces-43658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A274A5A335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F1C188994A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB9236A98;
	Mon, 10 Mar 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrQvA9nr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ra821CNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54238235BF1;
	Mon, 10 Mar 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632015; cv=fail; b=L4K3HW2e5KtAjglbvfmR//5f+Cmkw19WtF1W9q838qBCk7DR/ROHetuWTkBAFBdrgMzkjr7hWt1PQPYx4OLQ+5Yyu63uvZWrYpFX5FXUxxgmXluXjyk3vMY7doX9UlYmMKK4HUvbA+VOYBlgZBn7Syg/h+Z1wdKSDoVdSk1wc6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632015; c=relaxed/simple;
	bh=VZy06Yen2iuhG+ChvAtf/ZoNa+FeBqLT0CiIrG+yNZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PlCoMFdCj31GtRjRfwsNsXjMqds9erhrDgKG3h3WMJJ7RLemSbL3E6s7xXEWGK7wqD1MZf3RzZ+eZXwCdAtVGof4NMcf+pD/9a1V3zoigjefj6KsXVF7kwncXrafMVxT5WMyRyRXVxUhxH85gFYbonywyklp3vAZQKhnDKyvIsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrQvA9nr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ra821CNC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfju2009816;
	Mon, 10 Mar 2025 18:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DiYkyl5ZMh9tLQIqn/jQG9JCtMnjHLVoU6ntHSceKcE=; b=
	HrQvA9nr1nzlFBq7IgM1Y3xqffHIPxbw85vUgy1MS6uEPclcfMz1L/CeUJzEDt28
	ZTlnw/e6PIRADMI/RiWzbsm10WI6PpK9hftFhhmoF6wvWPSNgYRiXAt4zTNhMmPD
	12NvxniD1Qkio0CqCBxsRr4Ilcld/mNmLvRsZ7Zkk2JG4szmy/5k97XaGjf0A6pv
	yzRyxlxaAdAzpTTjm9I7bS5s+PJDvaE9c7PQXEKJE1EfpMRKiW4YxU5PAas7DLok
	ag4186B7luVkQScG9+dkS9xg1byox2CwGQv7v8TNpHYB3fVJyoI+tkkX67GXOlDe
	e8LM31YfWvUwUWJFv3G9Ng==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt38a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AH9u77030661;
	Mon, 10 Mar 2025 18:40:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmc16j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BY9YnfIHqhkgGQXa/zIws83gd7HFImGqDqcHe/HDyHQSR8W0rLEVdiQoFo7eyP20gBuBW3p5yAiJ1NtI3kYIsNY4agYobDvHqqigha++zkF3tISJIvnBGEyFu2bdXI2ypKJFVJvSsUE7g3UJhCE2jd5kW96y8TqiHPSPopscxU15QIB5Pdg/oiiAl2Uxf+k5ycwJQG8zYgjB/ih1QEGOjn0UtpzsflSozyQExgdc8S6QLwbEK20NE6CqpKG5HX15LBuKh8JgU6nXmz/TsKmGkViIG79uptfQX88xe2004wdPlZXBK6DxGxnLa57Jb/JdVXA6nZL8kra8QNvOXMVu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiYkyl5ZMh9tLQIqn/jQG9JCtMnjHLVoU6ntHSceKcE=;
 b=k2wBVRGh1/0Mnu4WTYXGbw+7DXuTwRWEJEolwrLNepqUXaBlO5NBsonMSfPvpjwHVxW0TDHRWD3WQGrUIHZxd1gzddFNIUoXaffBmkGqAM+skCcc8S96Wh3r5FSprTBpnNndNWonYfZ5YU01GU2Xl7jXQDGOLUpTKC6xIeMJRomWKnQ082qvNiD7+qNeMRd4xm1u5CiGP7Ox3L8/aD70mi0TxU81pnd8TfkXOP/H7Ie6iVP1kjAicWSoPVSKpmoHsbvs6GKbLnNTbAmTPPf/hkF3nafxb6SzRxgmUvvTK38ITMNSFZj9CHtBZb7tL86zhK7QSf/3XBNeCYzC9eO4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiYkyl5ZMh9tLQIqn/jQG9JCtMnjHLVoU6ntHSceKcE=;
 b=Ra821CNCG20cHh8BDszojA3qv7yOqNAxhTTU1aCwg/sUxpDXac8CfFNWyhE1CPKr3ULvPWvIPdG267NJxa64UOK02MeWEGvTKnLROZnt5teL3LDhXm/RfBJQrXYeEV5BBtlJWkroXqFuFb15VSGf/02858/GOgc/xD+2w/ptiMc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH3PPF8F9C59252.namprd10.prod.outlook.com (2603:10b6:518:1::7b7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 18:40:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 02/10] xfs: Switch atomic write size check in xfs_file_write_iter()
Date: Mon, 10 Mar 2025 18:39:38 +0000
Message-Id: <20250310183946.932054-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH3PPF8F9C59252:EE_
X-MS-Office365-Filtering-Correlation-Id: 8836c8d1-1be3-4d4c-29d0-08dd6002f949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XW8y4xF6HrnozB+I0IGhixLIFortVtxYjPpVDmByNcb72t7PPMKJZgJzETC?=
 =?us-ascii?Q?bBSkBbpTWy3xIjQiXlPmqLDkyKI8kPX37D8A1HPHGxLUN6fSAhNkTUmOyqqn?=
 =?us-ascii?Q?TWMUOaSfxm93Ge0GXZx5UY7SFm7FkS1BSZXZSVZn8TTuqokfEEQmxwMieIDg?=
 =?us-ascii?Q?kbtD7EcRdZDx1FyxezZaX15i0CtqLIAL/VOMvxk/yfi6e6ogGzgNcBNgRoBH?=
 =?us-ascii?Q?QihWEAzbCyloZx3//Fvtq/SR5/AyESdonVIGISqcv3YxuTrsgDHCw0ktwl2k?=
 =?us-ascii?Q?YGwTEImv+SiaAnRYahRrCYQrK8j0bRIxg+QNhhhWGOQKYlbT3xOS55iWzZ1f?=
 =?us-ascii?Q?7doYHTJlbtwK0XZEr/d5p4LSKjd5sgNoRRemsWXUmJ2w78mkq3NI8K0do4Mi?=
 =?us-ascii?Q?YpDUSmsF7tt4zok7B64XzzIQq1W1dF76JmzHw36hyXWyfnCLpO2DDvJA4m+4?=
 =?us-ascii?Q?kDRiuUjVyYRC9gH2kwucSwa1xAakF8JMgMwcg+Bu2Y5UIybpC/JUmn1aviDR?=
 =?us-ascii?Q?srhOPOioMDtaxewXCBK8Xl+OmH9bB2l6B5K/DfKJ+bktX7BjGyUWrlMx0G/N?=
 =?us-ascii?Q?r6u+zccIH6DjWAP49Hc4WGqKPbDyOB9j9F8/byEtYwie+w4dHhzfo0kJhTup?=
 =?us-ascii?Q?mGR9VG7RLHhO1ed4jA6CjaMZDxHSeMOB/GaIbuY2fZZVToJmTK+f8oljbN6c?=
 =?us-ascii?Q?RY8YtFAgltQAwoaWENlEvnE5hXlDO+agrcigNEVI+wJ7/r3Q6cOOh1hoDYyQ?=
 =?us-ascii?Q?rpNoozdOvSGaWCI5uH46UM7kpxMe1pWpeIshtr/0l+BsDF5cZgYmV8Bqmkxs?=
 =?us-ascii?Q?yGOfacUb/Sp2p28fpCrJEvPlCAcFy8WdLtYTzg+a8v4aDNDF/2uE+9IMX+wx?=
 =?us-ascii?Q?5xCra434uOB43f+NUMqT3e/wwQY5nrFANUZrUp1mhirnEUNESDY9s9dDqVKk?=
 =?us-ascii?Q?vQiwTW3xIOKIw3SMb36MZ1qqrJQWZ5bgtExaYTs9T+qR7OuC5YfJ78feu4GZ?=
 =?us-ascii?Q?Wl+C8AtHQXL06nm9BHULjqnrS0BmjV5CVatgjKqwVoVKhEgpudH58s3Qi4NU?=
 =?us-ascii?Q?iQa51Em/roqhJgqwayJT5WAj4AtSC+Mjkz/bkMneq5HY5wHzMmpTkn1DMl7r?=
 =?us-ascii?Q?lPJsqtJh6v2xwHgaCwzjHWJ3qKnhK+VMFf3mlf29KS89Phc1KjXILORnTR2o?=
 =?us-ascii?Q?J7iywLoZSuyK23Ch1u7dIIBIScFmX9IQtVoF8aEYf3VDiI5Cu4XxG+GiO+fn?=
 =?us-ascii?Q?uLVL01n4geB+DChPoc4Ig5b5b/J1oMqdZJi2ojMxmMzCdTC3Lp7FelUM8Za2?=
 =?us-ascii?Q?0XfANvqOOa9mDkobxtSbMimgl8di+qWUmWlbnsUfUmWC/bXQikYyrvnwIx5s?=
 =?us-ascii?Q?z/s1z7qqLdPMCbKWoqVjS89uAXLZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZusNACYrwgMJq0aBY9iXyzz6xV1ogBPD18lzYch3jvBb9ZK5IM5YXucpeLa1?=
 =?us-ascii?Q?GtCrpSp0Vgu6IyzXHucB/0N6o1rSlwrUJQ4Ud+5cBMEa5O4/JGB56VS6M6tv?=
 =?us-ascii?Q?EY/mCg36+t1Q59AftzYOHEOrvIIfjVoaOgZPjabgODxxAPtBN9LuArqSfPSK?=
 =?us-ascii?Q?FqCt7KEpvJ9diz0YnCqrPQCcpyOYsCKm+vf9gP5R9UFZKDuCGKAfcUFTqTC5?=
 =?us-ascii?Q?N+psq5c2Lk6Z6eZN2xvXDHwShBIPjkbhPK+Jmd2ukXO3qeL35Im16bovHnAN?=
 =?us-ascii?Q?TLulwQMF6r/ZQvgyBCGTSE2blQewThEP8zTYtQXJThO9mxWcSzxU6RcCtLDf?=
 =?us-ascii?Q?bZQKJKzihtD74rMxt9qyUZKMLIOquh0rWHQypTnh5TCrivBTsSytwYBej3uC?=
 =?us-ascii?Q?7piBhkrBddPgTtts4fJl+vpBfG1EkRK0LablUFYABDdkL9yVm1lgZx6pBwyL?=
 =?us-ascii?Q?dOUgrCq/XQPLvAwg2tKypzSr/v2RgAbmwOBAUE6hLu9LFO++FSzs6I/6HWf4?=
 =?us-ascii?Q?3CNDWQKShbALSdybIzzo6/QbKtC6yuVAbM1jMkVqIy6eg695honOrSVY1ulr?=
 =?us-ascii?Q?irxeGRKy0oO2FmSz5+4f9V3jcOsKtcm6Uq9t+s+jQSFW9MKDcXg4u0f6xUNf?=
 =?us-ascii?Q?WDIcx4gku+otzDPDGuY/I8eIBd4HQe6ZUB/fL8IL5d1PgQGTkRUMwnhyL90+?=
 =?us-ascii?Q?uiON9nIl5ALlh5t+gClmvvmVQreuscCrjtU6iRR2qbtIZpUQiiQ7r72ca/su?=
 =?us-ascii?Q?rxrK/1ffMVEdODnqd1Qtf5VGRBwx7SP1Jquuqw+J3V8RHp7Fd+Hml5L5stwF?=
 =?us-ascii?Q?/JST68WOlB/cH8Qqhiw4+GY9RRkZAMxHHPnrsaGpw1dgobHYmz9BKb9YYLu5?=
 =?us-ascii?Q?AtUF0L+lhCQiFjM7/J8Jw2NAwsx7TE4eCoBbFwgGKqhzC66+oNH6YiTs/3+F?=
 =?us-ascii?Q?Lqwgl9cl+l6Uv4V3DbqYVGG247z7oJXpGNLclXpAG32XPY+4pEKF7TKy99nh?=
 =?us-ascii?Q?hWNMudzl2VQBPwTp2GhkE9pyBgeJ6twffw4TWQF9rN5V9fcu8FMtqn5QFBNU?=
 =?us-ascii?Q?F8tv882ZaPgRGjIN3W0YT5Kd5Mo0qHZ8LYZHrySqqPqPACE7FI2QOHRhnlTk?=
 =?us-ascii?Q?lK8OtBiZdMT/2fHxRMJa62JqgLSl2qHFlR/LnSVwKTsMzUAwuq9I/LGQTic3?=
 =?us-ascii?Q?NHf+4D4x7Nhb9kxIlSEQguSFmuMxLZBaUxifG5M2GNDOS1GUlzE0FCTa9BQM?=
 =?us-ascii?Q?HpIok3Rl2TGHT+0hPX3K5GgimebqVyLAdxAyG6xm5d1Fkx8+Rv6urmcnbJ5K?=
 =?us-ascii?Q?ctRFaN5AWrw23a0hz2r0sQYnvIQVW4+9a9eXvbHwOVUo99fZ6eJPcj+Kb4Tn?=
 =?us-ascii?Q?8WjHFezWFnK8KBa2CzQFrbFJs42SC/EopVKdCLQZ4McMvWVZ466Li/Aouqkx?=
 =?us-ascii?Q?kynVqUyZWITN536vTMgPWMxItOJaztgyNdZyNhOyjH9hfCz3lONnPHv0swns?=
 =?us-ascii?Q?AF4m+de4yCrwHQNEG8vy7cbYoogkf6D5dIyDM1qBlkBLNrLYz/WFGfwWc4IC?=
 =?us-ascii?Q?Blm0lDVZTTkqXjVd+GdRvYhy09RjQOSpsB5D3KPRIaQ/opzkyBIb5B1vZ7vR?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gkgQkVAQKrLxjNDse4WKXbAdd6euxuAOc9Hwdv34wn44zFX14DQgy7e0kP9g1CmoHiduZg8jZlRNbFutgGx/sr8ToLxXecgoSrrwglkqtuqdG8uErKCGGszL9hbbGmMwTRhxXF6r2+UvTPcWJbGm5OqdJ2Kxxzdg/aGj7hKL4lopvT29iRv+kJWXRKJBY2hoJgH4iioT0EelZjb/A2Xgx18qfE88ykuBa7h1LadQNLcvg8ySLoswpukb1yAVgkOcqtSHnpBpnLXlmsZzGdQVPOJl7GtCrBuILS/aPP13ZzEVR36iQPTrATeft1/WFlS+d4tlIn/tVrToMW742DpXRhelrK+LK6V7Z/SIe3/E7qCXK9MSTf526JvV+5UBpAf2XKaXWLJsdy6E/iEcKFOk357p2zdPZR6nLX9x+QqPPjvkuwUfAmcWP/9gzWQwqvptp3hWDg2KeBSIfN65uzHhd11U9CROnggs0MOq0sMFJD5dWE8K5ao/6l04T0DyrNjTRPNcmxzwSSOlvr44H8iSgDJ1D7CXMiH6nJx/nb8sBp/ltHezB7x1JV9FKF3IP2yZQ55pxWJNyw6PdMAGnY5L6GQWf4eMmAzc0E5pkbaETx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8836c8d1-1be3-4d4c-29d0-08dd6002f949
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:04.6716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zrS1q5cdhCK8aLbkX8idT6BQ0igwW47ekFbUVd4A2EF6ETGg/imy5GurzmUnpdI5B3MkX2GhjTDasF3cm2kKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8F9C59252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-GUID: aGiEGW2CHL-GO0RF_y-UwzJo6XRmSwIk
X-Proofpoint-ORIG-GUID: aGiEGW2CHL-GO0RF_y-UwzJo6XRmSwIk

Currently the size of atomic write allowed is fixed at the blocksize.

To start to lift this restriction, refactor xfs_get_atomic_write_attr()
to into a helper - xfs_report_atomic_write() - and use that helper to
find the per-inode atomic write limits and check according to that.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 12 +++++-------
 fs/xfs/xfs_iops.c | 20 +++++++++++++++++---
 fs/xfs/xfs_iops.h |  2 ++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fe8cf9d96eb0..75a6d7e75bf8 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1032,14 +1032,12 @@ xfs_file_write_iter(
 		return xfs_file_dax_write(iocb, from);
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
-		/*
-		 * Currently only atomic writing of a single FS block is
-		 * supported. It would be possible to atomic write smaller than
-		 * a FS block, but there is no requirement to support this.
-		 * Note that iomap also does not support this yet.
-		 */
-		if (ocount != ip->i_mount->m_sb.sb_blocksize)
+		unsigned int	unit_min, unit_max;
+
+		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
+		if (ocount < unit_min || ocount > unit_max)
 			return -EINVAL;
+
 		ret = generic_atomic_write_valid(iocb, from);
 		if (ret)
 			return ret;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 444193f543ef..de065cc2e7cf 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -601,15 +601,29 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+void
+xfs_get_atomic_write_attr(
+	struct xfs_inode	*ip,
+	unsigned int		*unit_min,
+	unsigned int		*unit_max)
+{
+	if (!xfs_inode_can_atomicwrite(ip)) {
+		*unit_min = *unit_max = 0;
+		return;
+	}
+
+	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+}
+
 static void
 xfs_report_atomic_write(
 	struct xfs_inode	*ip,
 	struct kstat		*stat)
 {
-	unsigned int		unit_min = 0, unit_max = 0;
+	unsigned int		unit_min, unit_max;
+
+	xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
 
-	if (xfs_inode_can_atomicwrite(ip))
-		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 3c1a2605ffd2..d95a543f3ab0 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -19,5 +19,7 @@ int xfs_inode_init_security(struct inode *inode, struct inode *dir,
 extern void xfs_setup_inode(struct xfs_inode *ip);
 extern void xfs_setup_iops(struct xfs_inode *ip);
 extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
+void xfs_get_atomic_write_attr(struct xfs_inode *ip,
+		unsigned int *unit_min, unsigned int *unit_max);
 
 #endif /* __XFS_IOPS_H__ */
-- 
2.31.1


