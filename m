Return-Path: <linux-fsdevel+bounces-47993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31437AA8504
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912AC17873A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA21AAE13;
	Sun,  4 May 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OBOtMGmS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EtIe8z8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9C61A316A;
	Sun,  4 May 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349224; cv=fail; b=jlMUl3wW/K/eP1qFLfIgCfPfqsg0Lqv9kixj00wx5zsSAMN3k2Dmmx6oYwincG0ztErUQ46P3LsJl6ILKhmYf/dG8XK0X2avuoi9x7ODgy8eKd8foGR7au+Fc6NhhmnJcxGgAhTSRjUeyP1T5UoNI+lFdiXF+d/M950Aqu98Lvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349224; c=relaxed/simple;
	bh=wm7rSgXjAJHQhi8ehc1aU3KcZ144tJmRrGCHWg7nJCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KkC3i4/nQxHr/LKiXtsnzu+pUbxY73l4Q/9//2yAsfDAUI6pxqlEk6wtIgua4zTT38ahhxAPfIwuSgCIjOYtNx36mMB2fHxVFGHsrh6nhQEJAgQNp9fJGCOZZTZWeiZS5CuH74wrprGXXbnZ55I7VkGNIettwP9AIVdTN42GrcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OBOtMGmS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EtIe8z8k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5447MmsP013216;
	Sun, 4 May 2025 09:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=; b=
	OBOtMGmSP6Pjc4U26Zb2yk43+Es0o/zBGNaRtzlF8Fi8UwZFYg/+Ljd/jw+JNJtq
	euVvG4u7FnHW0398E9HNhL6012hEDyK9j9OqxSMpbqQKWqDDQ/mhoBWq43qepCFW
	jpbFeD2nMS6Hh+aqA514ek0pD9VitrUyWhZAaL2SXS+6p28HU3kx9a9hYAEwabhr
	emVO5JO2qcsjxUmDvTAl8OZAiiliQ6nOzeqoG0kTOuZNBKfOdPfA5HoRc9KrFqmK
	8uwn5MduDAv33xFX0tJE9FMYby8rUFy/wcxqM3xVWVSAI1gv1oy8cDgRJMi19igV
	2GzL1kVJkyUzcsS9adBYmw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3smg2se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445tJYZ038371;
	Sun, 4 May 2025 09:00:02 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k6gf9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COWEA3hWNVSvKFN2KOhFqcTD65UGxDEP2rqVppgfs5dKd0fV4ryYuxLcKliUGiADGw9m5foDWvwRI0aCWuOgSFAGh6GOELJAjTll1yrDf/dw0+1pnCzrFVltThqtBt0V0N9H2NU/vjgBohAP2RVy7w/3UEA3i900J6Q79biBFHrc5TtA09V1VNV6DQI7aZOSBDxb1idYPY/R0dUui7pjEImEjZUQazwoEsyu+yai9I+WuyE4UiVZUnvIkfTuh+72wbRRRp+cRxAxK7k6wj7biTnyvAyThdRf/klvLcPDTLNCswKAMwueEjdBbvHCbeOV8MgKx0ltOx1okhrvsZeI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=gnRfZ+1dwLqA0nD1YglE/4t9oo6RA0wcMtXXktY8oDWOh2yC22RBgcAGVzX3LY7C/fCgWIJEfT7ZOqmPEgaiFe9naS33LgnWGS/LNBxAwsvmzMsl2GvPUmyKi7ejXZ5x0JDyrPmaiQybbK5eEGNO0blyIhjb16382IEKxSwP5ccGb9NH9KHheZeXSocN7hiFLq5+pR8wzCe9FyEhGRTrY8NGl/6EUul6LP+weyEoCt5ZIOcyfPfUOHQK7nxdTUiXYQkDxjmhuw0r0Fv0InHfPJE7zGsfxIcXz65a+3uWXzdtKo7+E6JChZwQSvpQ/TBMaBWrj5cfLBck/B3AbOeblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=EtIe8z8ktSeQWKtiUPyRx2Nnqf5ZcgLWjGXdWxfJV5poys+dPjyMZI111pZF6zRnGlhuwM2jyvVrSyFzBenpFt7Qp4CahzidK6369RpaiXHLxO8pYPALHNDUvgw4Jb6tADwAJXKSKN+jwb2GAQuRz9ZRV13ayuxvIgMCyVbLqOk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 08:59:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 08:59:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 03/16] xfs: add helpers to compute log item overhead
Date: Sun,  4 May 2025 08:59:10 +0000
Message-Id: <20250504085923.1895402-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb62be2-d32f-4829-5520-08dd8aea0c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Ht90OZTcihCamMShs6/sEsPx+EKSExzN+wc76RAhBrpy4TTpotbfcn/wm2o?=
 =?us-ascii?Q?WBppU1kMZ5O+x630dDlHHyJDeEZcnu75U/yE9BiN822/rlz1LizkSwzBX5Vy?=
 =?us-ascii?Q?mdrYkFKX4G2eG1TVHSpOZ5gipDDcI8VObPQqoTSvmhPgAjRMGvMblQZtYrDS?=
 =?us-ascii?Q?jWaqD+ORrj8lHdrdt1R3+4f9W17KB6Jeg5zGsBzm2ZLv54eY0sRe0Ddluf3z?=
 =?us-ascii?Q?tT6PLKZ/bsZnUmccgMDXbes1pv4JxHxSsSsMVzkoEysebg+XFFNw4UBfSN6T?=
 =?us-ascii?Q?I2Zblgy4GoXyFewwBrYIScl9mXFD+2H1go8vL8ywbijurL2PFNCpWfybhMeH?=
 =?us-ascii?Q?ofethMeVRJWsaVgJO50tOZR+8+cCasRceqnKOayvLMXwOCoxqjzHg8k3s1KQ?=
 =?us-ascii?Q?CmUtvj17q/Pmy0HYs1YL7OAGt9CLZd57vlsk9zCMZF85xroDZ3+DBKSzmSfX?=
 =?us-ascii?Q?Ms5U15G88a3VvfakWzRR91xpBKx/R2/aHcNFPWds4XBQ2ycwp87796asacqN?=
 =?us-ascii?Q?B6vvvSeBTcD4jbfAkE1YazYMUBelMgxIWtrOVtZP1SnANrbTqGpvZqgynzXo?=
 =?us-ascii?Q?xKcd4fNlfpkYQK0mM0k6C7oBZH71KfZrmzdm+bTZU+ha35kKAIfW+5TeyHV7?=
 =?us-ascii?Q?rGRz56FxUykjo8uMSNibts3gtfsve7sTJ/tGUKdByfna595ZD5OMW+H5tsj9?=
 =?us-ascii?Q?kNaG0LY5JvWZeGBWtAp3dFoU1TAmRZiYr0DV5LryYZs6fsEKBjQiozuO2lfw?=
 =?us-ascii?Q?avA0K7xBzu72X8RPgtyuUwUygiAt885xooGJ6CngRFYsmGkABJac+jZWHPML?=
 =?us-ascii?Q?R8YWN6Jn3ygVJA4WLoZmvVwUVLVpfNUYQ1/qldYpiOn+IGlQLT6oIpFVhdzi?=
 =?us-ascii?Q?HfMqGzMkbmnW/P0cP7+qUx5Cs4wMSfp4sQVgG//rXMlSwMC1u2aHCUf7yFae?=
 =?us-ascii?Q?52nighdTjOBttRZ9Fr+x2Xhy5NhDhOCQpwNBiG5GUZGD+obeMfmfbtlc5GEi?=
 =?us-ascii?Q?cSmounwsOozDyReEd5NAA/ETbSqISPKp7WO+O3OOG7KaS3ZURoCdLKyMzv9A?=
 =?us-ascii?Q?bzTyQ1yKwdp1fT7rMJrNMrOF8d7FAhtx08yhAcJxiF1QX5b5hVTzJtZFv1aD?=
 =?us-ascii?Q?zbPnfX0dycbdX2yojNBIIAm2Z+V09x9SlysDlxO4is0bru2RXUgekqhoEPYC?=
 =?us-ascii?Q?696nrjhA+c6NSf4qVAc6bco3P8vnXvZcHr8oG/r051Qf/WoYvv5qMbx4Vk4w?=
 =?us-ascii?Q?yBubMglj+oXyBBbbikMqF7xe17wDJZi7cwfYw3hgVY8aTefIGLutvn/DWmz6?=
 =?us-ascii?Q?lhrwmAcBpvqh0TbWR+xIn2tFrY25IK/w/QydVZW6SpOu3jiG4CybqdpzHTdZ?=
 =?us-ascii?Q?rCmDMsTRIgM+gw0bBi69VGk3Aob/dYoYvTC1Dn7lyhT2EvHRm7/cJKRht1R3?=
 =?us-ascii?Q?nCdrR8fIPX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9QB1RvTTR80aITIyV+S+40Z4aHOAns0h3TZMdDjzNyhlh3ouQDCl1qqc9I/?=
 =?us-ascii?Q?6p6TL7FQxsuchEsFe3cDUM0ek56KU0egTWLc++I/YV8Klr9fsHVVHUv+XB3c?=
 =?us-ascii?Q?fJFJ9/KMdy4bG4U9cB9+smsjNV50vDasra02dmekdecPwuqf0xjMQr5BXmGB?=
 =?us-ascii?Q?kIbDu+DwLFmUnm7pGN+e7QZqa0zZn81U2llyHTsJY1DM6xqDfUGVIF9o7Mr0?=
 =?us-ascii?Q?8oSd0Fqzg/5k2mxd4LLrD5D9xCU1JNofEzkh1yvZxUfMw3ROYHU/wjREsZCH?=
 =?us-ascii?Q?DT4cBZRWrd4bDjsfJyvEM0KDwycmizlCchaUngvHwrmSvJcotsP5BKU+Cz/v?=
 =?us-ascii?Q?AjHTzhTZbeIJaRLpDWKKIn44JRja+qUJJ9s8pFfm96OAmnGFzpcrXILJTlVG?=
 =?us-ascii?Q?+yJSqBDl+TmfA/gdbzQZcv5VbwUI9D5QKS53db6z4FIfpgc8cSp4dqUUEzU7?=
 =?us-ascii?Q?B8CKCN0zxXevIIK+/v3zhD18I4olLXbeC8rByKIB8U9oHbknJnqu5lR3n/Gm?=
 =?us-ascii?Q?jC3xxYPQ9famFlAUjdNYm3bkop/n8N0ltgooMT4zzBTq+PiF+tJ7WM34JF6d?=
 =?us-ascii?Q?X2TekliNdWR0ZyTGQiBGskpyfufPiwAYOpvDx5GSiZnCTL5v11AtO3ge8/ua?=
 =?us-ascii?Q?H3ypW5OAcT5c3wNRsagMGT2Kd7nSRQuMqckU9XVOWa/iJkYwGZryxuyh8hv9?=
 =?us-ascii?Q?Ow/sgRba2PiRsw0IWN3QBCust4ysAduOQcjYACWx8uBgdT85B19dHAb1nDYp?=
 =?us-ascii?Q?phXV/w8ofyAyaA2UiErZKzEksgh02VdhshaQYIyDbSYUmiQs9fIkM0M6EfIM?=
 =?us-ascii?Q?o734MnT7ZeoJi6kEJ5OAL5T7XiQW2oWfpvbVNCOUeytqmIFfsl+SSHM1swGQ?=
 =?us-ascii?Q?OD53mxz+W9bKONpvySR7b/8Ki8mb2tJzuaXqtbCCMw4Ea43f95Ctk7+mXBxz?=
 =?us-ascii?Q?11P9jAs1WTQqwtD44I9sj8Bmz3atbAxQvIdlsuG8k+nW020+SY+Jrw2zn4c1?=
 =?us-ascii?Q?mNfhSRfR2d1JTEgz9hETJP9OBvD8Glm1/vj29sX26OW6R+oZrZ0BPeP2DARI?=
 =?us-ascii?Q?IVW9zv7aKK//2Q5xxjezT9GLHk8ySgEZKmJtAlfBvASKNBx5VkQupbLUEblD?=
 =?us-ascii?Q?VhTri59hi8lsasFuGm7VsaHWrrTPJ5DXsBRs6KLjsazjEKjUgxyTP7CRGQKR?=
 =?us-ascii?Q?lgkQ7VP0komm2z/oFXL7pvmkqoPX+uvkGoZZMbcRN8XPuUYpf6llUZKccacf?=
 =?us-ascii?Q?igoKHVpD0QKziHPmVTCy1xuWr88962CWk1D9lwDGSXB+M6ZcPA0oGDaiIsjm?=
 =?us-ascii?Q?gBMwuWnWZ0SwDmilCyvQPyjmAEt0LCt779nd2w3ySkh5iRKoklttOyO5W9Rq?=
 =?us-ascii?Q?ywYM6HgtJRe1qmS4jvrrxalexQijFxxAJEzzhFML4+xuTXb4rOJ99Qi9oN2l?=
 =?us-ascii?Q?Z5YlLEXsTVVdpUdOqxSHd2Yj+i4TJMG61jdPyC06zs72sGXUWBNMNgvlb4vS?=
 =?us-ascii?Q?1rAFOLznFjeVvA5bb2J37r8gts2zVEmE28frSjPXnxbiR5jiRbkn52IVLLxp?=
 =?us-ascii?Q?1NQCReRaYrSOqNy6atawrhb2tl4SCS/jui0nE7LjtTSrgjPObBT4MsgTJSu3?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n1887v0qHtVB41yAUbECqsbzfNnIkH9yvooyYUA1Y+cBYp3Z1Lp2LGr+41mFIzXQmYDMYUNOXsw/I/w0AtVpYObp3a/zNs+ybcGcLquJ7m60GZoK+kDguKNj2ih3QGjEa18QeH2wVtNJoHMc3LndVQ/ydYVEZhVWeLJijSRFICPiGvj1cNZyufzbX17GQ7fBv6OP+XSNqlxBxV8cb1a6zRC4Wl1JX3oVzmWya5+PnUn8L5Z6Nmh0v94HmsxFunKa+nvvzbiPcJ3cGNri7+wzNCb8zZnCpCUyjalwVouaf2uSly8R/pc2moGtzfczmSelqI+xe9VnrbWRTA6YElWChMDui3ofpnZvvhAG3D8hzwtVplB5q9EwywBc0vuAJZbrZOpGjgtWS4OwOZwh7A/ByHqvyxwEBaxJv3qdgaqVDtIBgGFS/Z8NHA2FaR0nFOHJPxUluhu+wRjz7bGzlXridP+Y9lxP3Ysd5ncFn74XaUYatjDbkL/I+005eGxsLMKiZ2MJ3OvC8xQmX1/Ns1sE51ccvlaFEv/nlh4doYt0OWvdb6DjpVJlRwAT99dDJIzKW4ChHB7Gcice6dZJIdesZ940igKquqBl7Vke5INhk34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb62be2-d32f-4829-5520-08dd8aea0c83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 08:59:59.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+fK3QdWdfYQlHCBBXMNIztrh6JF4mzB7xXrqgC+gXMiTp+cevIiYEAHIcrZFzPyWllP1ghbohjzs6mbuo+6iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX7wVvJcPubHQ/ HzeJaAovLvE05beDPf2e1fkmrgujd1VQcL3XfWd+lZP9Tg5gNIIgOjsaWd2qskAVMeRxQ1B4WiC XlwiqCbkkZCvBV+ZRpvCHYnGTCNEicsR7r37nqz0Rr3UULRvmY66j96s/wEDvLRiNRs3NF5oxQs
 6iTI3A7NZ0wJQvP23C/UgPx4XgxXcsproWgIQV9hZDmqfjSpWdI1OryDzHd4Vtm8ruWowcpBVYj /D/kh3ZamSA9sQQVi7WGG+n4ic/cTp+LSqnJlPJbS4NLMRjI5SPQNLwK7aadvQSBt9kzL7kRdwv gSX+mf/pbERhOPTiUjz03zz1J6qZWblllR8GU7DYZDk75HXwXJ+MWOvK2jGPBZ4J8DwWjqgENrZ
 rJj8tJ/nrst6e3JIWV4SO1krkTK7uWl8pcjj1yXKsE5L69Xg3OHyhrULwoFd9n+59iOZGg12
X-Proofpoint-ORIG-GUID: molaMx7aPP_JmUAKp-x4_J-7M1h5rl1e
X-Proofpoint-GUID: molaMx7aPP_JmUAKp-x4_J-7M1h5rl1e
X-Authority-Analysis: v=2.4 cv=bNgWIO+Z c=1 sm=1 tr=0 ts=68172c93 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6KFWBsMsv8NWCX33yDQA:9

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


