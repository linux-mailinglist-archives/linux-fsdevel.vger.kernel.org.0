Return-Path: <linux-fsdevel+bounces-22655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C391ADDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D47428130F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9719A297;
	Thu, 27 Jun 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mtKc2Xlr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s2y1m7V3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD21C6A1;
	Thu, 27 Jun 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508860; cv=fail; b=R4HwT1VOyHdF/P2V2QK+ViX2K+N8Gq53Ca+rqlyoQ1MhdoBcRPjz3xm4gun9QPkWy8veZggfZpZAc3nCc7PLXjo9W7tnrsJGkUGfwT2sWhrm9a5+M6zveYzyZeBQFnUG9j489oUuqmyqf9BW+GYXRgMAI+1UIDLl8ho7QOzCwys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508860; c=relaxed/simple;
	bh=IV0FoV8+DfbIcbxnPeqE6QW9YfOeoMmH33ArD1Jjx9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZ8TDtyTh+NnlYMTXIeFZJUmRDrLwVjQc6e364hIaEbtPlwX4NLueSTNtPlhmxRCvRHwY8YsJ3riW4gI8mXP4Rj+j9qiKQ6kKaph97ioCfufZ1mNnw9xWL/prlrnqgzRFY44lmubiObvh3J9e1+V3w3XDzQPrBCL1m/DyU6oqpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mtKc2Xlr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s2y1m7V3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtTLm003652;
	Thu, 27 Jun 2024 17:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=trkp4xwKzrCxDqq
	rVw+o8JfubJybtQE1IHiAqB77dGs=; b=mtKc2XlrVphm644qmmuc+/oJ5c0eFns
	GGYRAC6Tz9PPdUvtZUcNc9gN9e8e11IaH5VXZJqWFA1YbojR2wG8JYGQZX1+SAur
	E9ovW7oNftO2Wd3QLOAX+0oTkW9TLNsxvyndJ7p/sqo0mO/BYQ5k5qdrgfJ54LFg
	6wyh4v4qOnCTPg1iZDN3DRsc+In0PUsSjsdpbthlccLIAJmQLddLjazgfNu+wQqp
	CRoWgIRLvqJUQCDdKF4PnEHj/xHB0rO3IoIoMcjbMAOia3rtSdOIoAkxSgv4fTPY
	UbNNgLnoiWfNfT1TGukMPD3zcHH3i/WD0NBbZIxGmsuS/JMnSq5A2LQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7spjx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:20:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RGEY2u023335;
	Thu, 27 Jun 2024 17:20:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2h836x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 17:20:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp7jd7uXvdUOZOtKlXaoMPf9P3VIFkJNdMIjBPMV95fMRgLZar4z4uIz4gsu5ek7SqR3L4mPF3+NSDOb9S/ZxzlijfdL/UyCAppIIv/TG4/MfXajXppmN8hXGc9dovO6VY5BzZlRWGjv/wS5HHA9wrO4YDq/Q6DSDFRaGe+hwCAHdwq1n3e9gSxTJ1ZKWN/sz/OKRHYf97lZCgWofvaEpCUt8MLTph8ux7Yw/XooaC7Q0GeNd08NPzqvL8LnnP5p0CWQ1epkHLe8ZScE07Ixv338zURS7kkbh5ppx5NLcvZUASHSoapFARUv4VjxIeAlml0q0OSTFCCl36bTdM9Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trkp4xwKzrCxDqqrVw+o8JfubJybtQE1IHiAqB77dGs=;
 b=gxH4vtLl73l44VJ77ZsfuDgzDh4g0zKWfkUbJFCavMHyePRprd5PZAgGiSdi61Q7UnPVJJGXsASyLn35rriWD/pC5iTmBnw8NzvHsQ98aewdtc3D1ZMbR8DVMsjRiJP1Q/LY+W1W73JEB3kKTHZkhVlFaIsKSm9YhNRCNpodIbRBNet98ldNwyKjkLLHMC68LWMJrbKosCk0BG0u++lt9y//7YPOg4YBcmU8yLwlKc51HF13WVAa5un/E+uu5cUEU6/jwDRjkoslKlCx5okWte10J9zgKdxWNbhBMDQ0zG7dGzUG0ShH4zSoKudonu1HB9k64qRFSvJb6l/3Rnwxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trkp4xwKzrCxDqqrVw+o8JfubJybtQE1IHiAqB77dGs=;
 b=s2y1m7V3fP7LS0oMa6nFS+mt4spMlGxRHr+q2s1bJJEEAsDPAQE6/0+UIcKwjXJUgj0uROIUyouD1voAJyCmb4DYe0S9sTM7CgxKlr5NsGIs/Ggvd1m9v1aGu1UQ9hOMmlfUSi57kv1HfL0quhngDJ84VyyXkhflnqowBrxY1po=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6273.namprd10.prod.outlook.com (2603:10b6:510:213::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 17:20:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 17:20:33 +0000
Date: Thu, 27 Jun 2024 13:20:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <mefk223e65nkizav5yvz2djgyqprrw3uclyctvebdvr2crph34@cktxpmr6bdgq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 37934aa3-73b5-43c6-7f27-08dc96cd73a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y1VW+Bn6n5NAochoFq3tFmOkBULTSggZNPvJYj1TWRseGthfliY145i1RI5o?=
 =?us-ascii?Q?ysDqQVB8ImlqmgYpoflyc6f1FUhjMAQw6C1XuQtomcF88OjMlLUeTkosIPxt?=
 =?us-ascii?Q?PY1KySMKqHsriWQDMtp3df70OzJYlVkXHI4bfSngiE5q6ScoYuTmUAVelVMI?=
 =?us-ascii?Q?SWX0rujLWEvZuLAvWxYxoPFHnKYelShbQQD0BV1ZDJdIHUodaWyWOfBRzTqi?=
 =?us-ascii?Q?G3kn7USVzhWLpzCCjwirNO7z5yQEYPd3BGH6yz8aYpC1YFMXwglMqwxJxmT2?=
 =?us-ascii?Q?ZygM7cuTeDMSvQQSVzoYROL2Pe8zNCKaJayTZsdZUxdNn++Ih/u1DviFk+LA?=
 =?us-ascii?Q?YUQ9B+voD5+x42M+3d03hFI2Gekoisd1vFEZtSM1xki5GzmziG+l9i3sEasr?=
 =?us-ascii?Q?4gnT/ydr1Wr5mAndR6k+k3DImKMH6Sf9cGRNwgAp7HLQemLm5Bk6DzO+BhRw?=
 =?us-ascii?Q?3SoGNiYeUDIQMDWKJmLGvRalfo9vLGaFIwNJp1Apr0QwYu5ToYYX7lXp6Fs5?=
 =?us-ascii?Q?sI7PW1xz94qV8/deypufDjoz+8U8j84zjGznk0RxX24Bik1APxk9JmHZ5RS2?=
 =?us-ascii?Q?PUzT3p0jdGqZvVn/zvNOQJu09LJyXcUYUQ7q2LtXV9rVoE7TqdMJauvcMXqF?=
 =?us-ascii?Q?426exIl7FK535k5+A4W1qnZYOMaJx7b2EYQmdQfM14ubtB7F7JypMcinZmag?=
 =?us-ascii?Q?GKJ4GI6kWvNj7oq4U4LVXqwfwqGqB7vvSz8VqfUFB/lshx/wMnM9hy8t5Ze9?=
 =?us-ascii?Q?dbFVCDa0eTp0cD1Ts3rle4PEbL9TzEJbMFqxWNpTjnPxjH0m/3HZH6loqXnY?=
 =?us-ascii?Q?9OlKlo5mG8Vd/pF97oBMujoNv76T1Cdl1GyC/zFlBVtP90NJeMPZbzPU2WBE?=
 =?us-ascii?Q?xeWjXG55nR+VTxzI2GAWnXeC5qTeGQdTKUWz575O1ILW/5Z9ahl9iOGOqOlo?=
 =?us-ascii?Q?Kfr5ggGoRzoZFqUqpmUtJ1NG7VjcwokgiECJJSGhfOczz5a3WzN4qmLr/GHa?=
 =?us-ascii?Q?FiCWR4oqGcb+p46WclEFQgmPYLfbkaiIs8BpEY9m9WqgmwOpnVkyl/ZpwOCl?=
 =?us-ascii?Q?bE+LF3WghACxSoOdYxYSWjHtanfz68tVnXH72AS01KArn6bjoR4zRSptSZhv?=
 =?us-ascii?Q?GgXr1ss7ZYnMFmsgLwyZEcves482kTve3nrQBU0OckKUvgUyDYDKx7pvDfgK?=
 =?us-ascii?Q?bPCiaGUfseN6Vbo3AQzU0je5tm6x6/KErfXPaW9WCEOYjr9tP257dppnQFZM?=
 =?us-ascii?Q?B8C2LwAUMXq36nbcxub+moMZCycPhL2J71bLsi7luaHg0+V1VQrc7Yz0z5Ks?=
 =?us-ascii?Q?VdAVzOz9l/Nzk9g100fgdeAH1ziXi+wQVRH+A7TKSgaY5Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7MXJYkOj6pYaW9DOOkNSC4THLUtUJNiiGFE8ZkiOYzqLnUnxj0PgcivtpucW?=
 =?us-ascii?Q?rFVc49shA3Cgm6nxYbb7ZJz8tue0o7N0raVgATi/VgZxHW+2j3eGtBKsp/GK?=
 =?us-ascii?Q?Eme2aGNovKq9qSN/VsYOGiJdfVRX/VZ4mcpmaBUjr92bwbrmoTfFjz7y3KHz?=
 =?us-ascii?Q?FY68a7/Xf8225G5XJSG0prtnImM5vUpHp3SN/bxSob49Yzmss53Z2sPkF6Ac?=
 =?us-ascii?Q?1WIekMQTQ9b6SDhkCpSaefwBE2RuJzRPq78mEpHQOelMymJvF8qicTjTfAAK?=
 =?us-ascii?Q?ZyUe6aeVqMhXx20OAW1A+1KwZZ0PS3Xm6D6FprNnJKPA+d5mN7z8o42okX03?=
 =?us-ascii?Q?AuinnyHVSA8uAT4c7aRD526LJB+ZJ8Qgc4frdqcNdVrwISk8G3T1m8snoy/c?=
 =?us-ascii?Q?iuBCvwcS0X3SJoLxZS86FIz/K4MldazxYrB6aphxm6/G1i3AJRq2tlVuvJOU?=
 =?us-ascii?Q?6RWVrcIMzPgrRajmmxwFqpR8zyiFwVLrjxOXyOiwPGhTE8tUBn75oERG95ra?=
 =?us-ascii?Q?FoGqWZb2+UzWz8D63fHFyKOLXfgI/ZsYaax60p/yb9gomgyFw8bhCXXglX4/?=
 =?us-ascii?Q?w22MU3E8lQ6m67d/XlO8DPc47QthdcDm4z0wVgGr8xbEgM8m0XJRObOL7H1s?=
 =?us-ascii?Q?4MyQssneI6izdyCr3v+DLpOFekhVWa4FL+vBG0ZSicVxAGjseOx1YsJN1bj5?=
 =?us-ascii?Q?dBKZ2gss4VXrW8HdcZ4+klp1v2o27LJ1S7jmN3Bs5yRVItq0lOFbuCHu6Iml?=
 =?us-ascii?Q?oAGqMglEEhW73Zb31CeC29PGcl54XRDOMsjvBJuCcJQWNnFDdBM7QIY3Mr/M?=
 =?us-ascii?Q?qslyyumag8+ObU6dHCJ6XL9xFRRB0zkwijE7ErUlo3LhW5qwKvLrYzV3sy82?=
 =?us-ascii?Q?BCS+kkVBrRJljkSMrqf2wSgRDe+suurrQwEqOrTLVIwFk7cI3r87V841SA95?=
 =?us-ascii?Q?k9SkAVETNDgA1OvlMB+knGIqFCx9z1JCkfRZTACaFZ64pmCqlIc8jEQzuSKQ?=
 =?us-ascii?Q?E/z1LKNiRvtmoyZDrrI+Lq1qRNZQFOlPsxd2pbcHGiCHXrfhyePYVmDohP81?=
 =?us-ascii?Q?tZ/R6F1KVRQApZvqBwPnQ9VflnHIW6okZDfvf8tAjkrmHdqLLsDKoZEYX7VF?=
 =?us-ascii?Q?sNA8ql/G7DsDVjf+LN2Ga2v4qJ5saXrfC5WV6gXQIDgijYm+1JMBJ1b9GQXl?=
 =?us-ascii?Q?oEqXHLqVCDpAFtLALCaI6sewEf10+hgapo7wDfcpdxT8WglNLoCxjOIcUti/?=
 =?us-ascii?Q?OXgexZrUN7aKxpSfuSB1U5otja81+/o/TG6ZPHhbbvu9kRTS9hsglUsC2Tlh?=
 =?us-ascii?Q?+BzAwJ2I75Tqfjlgdm/bslsxBgyWxcRTSy3qO4EIrD25VK7mag1QtUQwijPl?=
 =?us-ascii?Q?EYuspPxJoPm0oj2iFioHa4F/0FEORiZim5cICzHYbsK60ACFNBww3mXCLJ6l?=
 =?us-ascii?Q?xSNOJpMsDHp26MMIw1Pj/XT/S8sah9Snx9ZXufSMQI7lNzVYngelRUzmyXxi?=
 =?us-ascii?Q?r3Xb4WrXOEYHUXQfwOgekNPd6hNB2Gmv2nWBil5uI89Fa+QPEZ7i8BBcx29n?=
 =?us-ascii?Q?w42fnDoUXJi0BbE2bmqojITztx/Ys3az3/qeSCi6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jB3IAwkYZ8bNsOI3SnhBgt/bNtojWGnyYFfj5xRRnYNBxc1s1jD1TkILqfWF2A0rjwas9YEjPi5JtuebJYHN48aPg3RhLHQ5A33V9wZ8yE0QmT6MI57byVMmtjkUxEP5SjAcwawIOc/YEFzhMnCLVnETCwnZBySu195zR2HgegwRjqOuTA37XYeRyPZ2pZTQ4M4ciBTYiepnGqcAAKrNqtE6y53AYGmlQ4mIIX8oVYXVfv+3l+i8BU+i9oS/E39o4QU5SJ+6p3lqR3QakWsULCvtWRy/B7EM23LJDoLsmhQp9sIg6r6conbMW4SAzc+fIqAfdTi5RspPZdUCCWuPbX16Y3KrilMX8FGTqXUaJXh3fnm1cPplruDKy3Jsr/RgRn8+eNpoOFAO+mK4dZm0s3mcCwDPX2QCtUOnqZL/WXkNr3Fc2AQvb+sDHl9rwmOKfQOGd/q/GS2JxWOfgtwhJLSZtct6Eke550AP4nDoPkSD51hriDWVwKrvAIjK2LFnszM+Rht1qwW+H6nAMdZFXboIFqmCiEhyvSaJIQ6Bqhzjei8jVn0q2WGnHhPXUw94WFvKLcmd2FSG71paYM/wZl1Nwgh1jPUE3EFpKo5VNVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37934aa3-73b5-43c6-7f27-08dc96cd73a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 17:20:33.4035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daH6zVI9lKd29yeJgLb92c1Gz/efe47zow+GCCLqXSLFlJv29Qr1VeAyG2jmh0FUnrZbZnawQGso6v1vorJrNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_13,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270131
X-Proofpoint-GUID: jm2O-ICodHihtl099ceCoir87woeI07p
X-Proofpoint-ORIG-GUID: jm2O-ICodHihtl099ceCoir87woeI07p

* Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:40]:
> Establish a new userland VMA unit testing implementation under
> tools/testing which utilises existing logic providing maple tree support in
> userland utilising the now-shared code previously exclusive to radix tree
> testing.
> 
> This provides fundamental VMA operations whose API is defined in mm/vma.h,
> while stubbing out superfluous functionality.
> 
> This exists as a proof-of-concept, with the test implementation functional
> and sufficient to allow userland compilation of vma.c, but containing only
> cursory tests to demonstrate basic functionality.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  MAINTAINERS                            |   1 +
>  tools/testing/vma/.gitignore           |   7 +
>  tools/testing/vma/Makefile             |  18 +
>  tools/testing/vma/errors.txt           |   0
>  tools/testing/vma/generated/autoconf.h |   2 +
>  tools/testing/vma/linux/atomic.h       |  19 +
>  tools/testing/vma/linux/mmzone.h       |  37 ++
>  tools/testing/vma/main.c               | 161 +++++
>  tools/testing/vma/vma.h                |   3 +
>  tools/testing/vma/vma_internal.h       | 843 +++++++++++++++++++++++++
>  tools/testing/vma/vma_stub.c           |   6 +
>  11 files changed, 1097 insertions(+)
>  create mode 100644 tools/testing/vma/.gitignore
>  create mode 100644 tools/testing/vma/Makefile
>  create mode 100644 tools/testing/vma/errors.txt
>  create mode 100644 tools/testing/vma/generated/autoconf.h
>  create mode 100644 tools/testing/vma/linux/atomic.h
>  create mode 100644 tools/testing/vma/linux/mmzone.h
>  create mode 100644 tools/testing/vma/main.c
>  create mode 100644 tools/testing/vma/vma.h
>  create mode 100644 tools/testing/vma/vma_internal.h
>  create mode 100644 tools/testing/vma/vma_stub.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0847cb5903ab..410062bd8e21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_internal.h
> +F:	tools/testing/vma
>  
>  VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
> diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
> new file mode 100644
> index 000000000000..a8b785063b1c
> --- /dev/null
> +++ b/tools/testing/vma/.gitignore
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +generated/bit-length.h
> +generated/map-shift.h
> +idr.c
> +main
> +radix-tree.c
> +vma.c
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> new file mode 100644
> index 000000000000..50d2a69ddff8
> --- /dev/null
> +++ b/tools/testing/vma/Makefile
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +.PHONY: default
> +
> +default: main
> +
> +include ../shared/shared.mk
> +
> +OFILES = main.o $(SHARED_OFILES) maple-shim.o vma_stub.o
> +TARGETS = main
> +
> +vma.c: ../../../mm/vma.c
> +	cp $< $@
> +
> +main:	$(OFILES)

This needs some work to automatically run the copy target.

> +
> +clean:
> +	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h

This needs to clean out vma.c to avoid stale testing.

But, none of this is needed.

What we can do instead is add the correct header guards to the
mm/vma_internal.h file, change the tools/testing/vma/vma_internal.h
header guards to be the same (ie: remove TESTING_ from the existing
ones), then we can include vma_internal.h into vma_stub.c prior to
including "../../../mm/vma.c", and we don't need to copy the file.

Essentially use the #ifdef guards to replace the header by ordering the
local header for inclusion prior to the c file.


> diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
> new file mode 100644
> index 000000000000..92dc474c349b
> --- /dev/null
> +++ b/tools/testing/vma/generated/autoconf.h
> @@ -0,0 +1,2 @@
> +#include "bit-length.h"
> +#define CONFIG_XARRAY_MULTI 1
> diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
> new file mode 100644
> index 000000000000..298b0fb7aab2
> --- /dev/null
> +++ b/tools/testing/vma/linux/atomic.h

This should have header guards as well.

> @@ -0,0 +1,19 @@
> +#ifndef atomic_t
> +#define atomic_t int32_t
> +#endif
> +
> +#ifndef atomic_inc
> +#define atomic_inc(x) uatomic_inc(x)
> +#endif
> +
> +#ifndef atomic_read
> +#define atomic_read(x) uatomic_read(x)
> +#endif
> +
> +#ifndef atomic_set
> +#define atomic_set(x, y) do {} while (0)
> +#endif
> +
> +#ifndef U8_MAX
> +#define U8_MAX UCHAR_MAX
> +#endif
> diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
> new file mode 100644
> index 000000000000..71546e15bdd3
> --- /dev/null
> +++ b/tools/testing/vma/linux/mmzone.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_MMZONE_H
> +#define _TOOLS_MMZONE_H

It might be best to use the same guards here to avoid mmzone.h from
getting pulled in.

> +
> +#include <linux/atomic.h>
> +
> +struct pglist_data *first_online_pgdat(void);
> +struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
> +
> +#define for_each_online_pgdat(pgdat)			\
> +	for (pgdat = first_online_pgdat();		\
> +	     pgdat;					\
> +	     pgdat = next_online_pgdat(pgdat))
> +
> +enum zone_type {
> +	__MAX_NR_ZONES
> +};
> +
> +#define MAX_NR_ZONES __MAX_NR_ZONES
> +#define MAX_PAGE_ORDER 10
> +#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
> +
> +#define pageblock_order		MAX_PAGE_ORDER
> +#define pageblock_nr_pages	BIT(pageblock_order)
> +#define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
> +#define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
> +
> +struct zone {
> +	atomic_long_t		managed_pages;
> +};
> +
> +typedef struct pglist_data {
> +	struct zone node_zones[MAX_NR_ZONES];
> +
> +} pg_data_t;
> +
> +#endif
> diff --git a/tools/testing/vma/main.c b/tools/testing/vma/main.c
> new file mode 100644
> index 000000000000..b29eeb0daf31
> --- /dev/null
> +++ b/tools/testing/vma/main.c

If you employ the use of header guards, we can rename main.c to vma.c
and produce the executable "vma" instead of "main".

> @@ -0,0 +1,161 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <assert.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "maple-shared.h"
> +#include "vma_internal.h"
> +#include "vma.h"

You can directly include "../../../mm/vma.h" here and remove the vma.h
file you have in this directory.

> +
> +/*
> + * This skeleton implementation doesn't necessarily clean up after itself
> + * very well, so don't check for leaks.
> + */
> +const char *__asan_default_options(void) { return "detect_leaks=0"; }
> +
> +static void test_simple_merge(void)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct vma_left = {
> +		.vm_mm = &mm,
> +		.vm_start = 0,
> +		.vm_end = 0x1000,
> +		.vm_pgoff = 0,
> +		.vm_flags = flags,
> +	};
> +	struct vm_area_struct vma_middle = {
> +		.vm_mm = &mm,
> +		.vm_start = 0x1000,
> +		.vm_end = 0x2000,
> +		.vm_pgoff = 1,
> +		.vm_flags = flags,
> +	};
> +	struct vm_area_struct vma_right = {
> +		.vm_mm = &mm,
> +		.vm_start = 0x2000,
> +		.vm_end = 0x3000,
> +		.vm_pgoff = 2,
> +		.vm_flags = flags,
> +	};
> +	VMA_ITERATOR(vmi, &mm, 0x1000);
> +
> +	assert(!vma_link(&mm, &vma_left));
> +	assert(!vma_link(&mm, &vma_middle));
> +	assert(!vma_link(&mm, &vma_right));
> +
> +	vma = vma_merge_new_vma(&vmi, &vma_left, &vma_middle, 0x1000,
> +				0x2000, 1);
> +	assert(vma != NULL);
> +
> +	assert(vma->vm_start == 0);
> +	assert(vma->vm_end == 0x3000);
> +	assert(vma->vm_pgoff == 0);
> +	assert(vma->vm_flags == flags);
> +}
> +
> +static void test_simple_modify(void)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct init_vma = {
> +		.vm_mm = &mm,
> +		.vm_start = 0,
> +		.vm_end = 0x3000,
> +		.vm_flags = flags,
> +	};
> +	VMA_ITERATOR(vmi, &mm, 0x1000);
> +
> +	assert(!vma_link(&mm, &init_vma));
> +
> +	/*
> +	 * The flags will not be changed, the vma_modify_flags() function
> +	 * performs the merge/split only.
> +	 */
> +	vma = vma_modify_flags(&vmi, NULL, &init_vma,
> +			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
> +	assert(vma != NULL);
> +	/* We modify the provided VMA, and on split allocate new VMAs. */
> +	assert(vma == &init_vma);
> +
> +	assert(vma->vm_start == 0x1000);
> +	assert(vma->vm_end == 0x2000);
> +	assert(vma->vm_pgoff == 1);
> +
> +	/*
> +	 * Now walk through the three split VMAs and make sure they are as
> +	 * expected.
> +	 */
> +
> +	vma_iter_set(&vmi, 0);
> +	vma = vma_iter_load(&vmi);
> +
> +	assert(vma->vm_start == 0);
> +	assert(vma->vm_end == 0x1000);
> +	assert(vma->vm_pgoff == 0);
> +
> +	vma = vma_next(&vmi);
> +
> +	assert(vma->vm_start == 0x1000);
> +	assert(vma->vm_end == 0x2000);
> +	assert(vma->vm_pgoff == 1);
> +
> +	vma = vma_next(&vmi);
> +
> +	assert(vma->vm_start == 0x2000);
> +	assert(vma->vm_end == 0x3000);
> +	assert(vma->vm_pgoff == 2);
> +}
> +
> +static void test_simple_expand(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct vma = {
> +		.vm_mm = &mm,
> +		.vm_start = 0,
> +		.vm_end = 0x1000,
> +		.vm_flags = flags,
> +	};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +
> +	assert(!vma_expand(&vmi, &vma, 0, 0x3000, 0, NULL));
> +
> +	assert(vma.vm_start == 0);
> +	assert(vma.vm_end == 0x3000);
> +	assert(vma.vm_pgoff == 0);
> +}
> +
> +static void test_simple_shrink(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct vma = {
> +		.vm_mm = &mm,
> +		.vm_start = 0,
> +		.vm_end = 0x3000,
> +		.vm_flags = flags,
> +	};
> +	VMA_ITERATOR(vmi, &mm, 0);
> +
> +	assert(!vma_shrink(&vmi, &vma, 0, 0x1000, 0));
> +
> +	assert(vma.vm_start == 0);
> +	assert(vma.vm_end == 0x1000);
> +	assert(vma.vm_pgoff == 0);
> +}
> +
> +int main(void)
> +{
> +	maple_tree_init();
> +
> +	test_simple_merge();
> +	test_simple_modify();
> +	test_simple_expand();
> +	test_simple_shrink();
> +
> +	return EXIT_SUCCESS;
> +}

It would be nice to have some output stating the number of tests
passed/failed.

> diff --git a/tools/testing/vma/vma.h b/tools/testing/vma/vma.h
> new file mode 100644
> index 000000000000..87a6cb222b63
> --- /dev/null
> +++ b/tools/testing/vma/vma.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include "../../../mm/vma.h"

I'd rather just drop this file and have this line in main.c (or vma.c if
you decide to rename it).

> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> new file mode 100644
> index 000000000000..8be8cbecf3b8
> --- /dev/null
> +++ b/tools/testing/vma/vma_internal.h
> @@ -0,0 +1,843 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __TESTING_VMA_VMA_INTERNAL_H
> +#define __TESTING_VMA_VMA_INTERNAL_H
> +
> +#define __private
> +#define __bitwise
> +#define __randomize_layout
> +
> +#define CONFIG_MMU
> +#define CONFIG_PER_VMA_LOCK
> +
> +#include <stdlib.h>
> +
> +#include <linux/list.h>
> +#include <linux/maple_tree.h>
> +#include <linux/mm.h>
> +#include <linux/rbtree.h>
> +#include <linux/rwsem.h>
> +
> +#define VM_WARN_ON(_expr)
> +#define VM_WARN_ON_ONCE(_expr)
> +#define VM_BUG_ON(_expr)
> +#define VM_BUG_ON_VMA(_expr, _vma) ((void)(_expr))
> +
> +#define VM_NONE		0x00000000
> +#define VM_READ		0x00000001
> +#define VM_WRITE	0x00000002
> +#define VM_EXEC		0x00000004
> +#define VM_SHARED	0x00000008
> +#define VM_MAYREAD	0x00000010
> +#define VM_MAYWRITE	0x00000020
> +#define VM_GROWSDOWN	0x00000100
> +#define VM_PFNMAP	0x00000400
> +#define VM_LOCKED	0x00002000
> +#define VM_IO           0x00004000
> +#define VM_DONTEXPAND	0x00040000
> +#define VM_ACCOUNT	0x00100000
> +#define VM_MIXEDMAP	0x10000000
> +#define VM_STACK	VM_GROWSDOWN
> +#define VM_SHADOW_STACK	VM_NONE
> +#define VM_SOFTDIRTY	0
> +
> +#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
> +#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
> +
> +#define FIRST_USER_ADDRESS	0UL
> +#define USER_PGTABLES_CEILING	0UL
> +
> +#define vma_policy(vma) NULL
> +
> +#define down_write_nest_lock(sem, nest_lock)
> +
> +#define pgprot_val(x)		((x).pgprot)
> +#define __pgprot(x)		((pgprot_t) { (x) } )
> +
> +#define for_each_vma(__vmi, __vma)					\
> +	while (((__vma) = vma_next(&(__vmi))) != NULL)
> +
> +/* The MM code likes to work with exclusive end addresses */
> +#define for_each_vma_range(__vmi, __vma, __end)				\
> +	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
> +
> +#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> +
> +#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
> +
> +#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
> +#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
> +
> +#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
> +
> +#define AS_MM_ALL_LOCKS 2
> +
> +#define current NULL
> +
> +/* We hardcode this for now. */
> +#define sysctl_max_map_count 0x1000000UL
> +
> +#define pgoff_t unsigned long
> +typedef unsigned long	pgprotval_t;
> +typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
> +typedef unsigned long vm_flags_t;
> +typedef __bitwise unsigned int vm_fault_t;
> +
> +typedef struct refcount_struct {
> +	atomic_t refs;
> +} refcount_t;
> +
> +struct kref {
> +	refcount_t refcount;
> +};
> +
> +struct anon_vma {
> +	struct anon_vma *root;
> +	struct rb_root_cached rb_root;
> +};
> +
> +struct anon_vma_chain {
> +	struct anon_vma *anon_vma;
> +	struct list_head same_vma;
> +};
> +
> +struct anon_vma_name {
> +	struct kref kref;
> +	/* The name needs to be at the end because it is dynamically sized. */
> +	char name[];
> +};
> +
> +struct vma_iterator {
> +	struct ma_state mas;
> +};
> +
> +#define VMA_ITERATOR(name, __mm, __addr)				\
> +	struct vma_iterator name = {					\
> +		.mas = {						\
> +			.tree = &(__mm)->mm_mt,				\
> +			.index = __addr,				\
> +			.node = NULL,					\
> +			.status = ma_start,				\
> +		},							\
> +	}
> +
> +struct address_space {
> +	struct rb_root_cached	i_mmap;
> +	unsigned long		flags;
> +	atomic_t		i_mmap_writable;
> +};
> +
> +struct vm_userfaultfd_ctx {};
> +struct mempolicy {};
> +struct mmu_gather {};
> +struct mutex {};
> +#define DEFINE_MUTEX(mutexname) \
> +	struct mutex mutexname = {}
> +
> +struct mm_struct {
> +	struct maple_tree mm_mt;
> +	int map_count;			/* number of VMAs */
> +	unsigned long total_vm;	   /* Total pages mapped */
> +	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
> +	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
> +	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
> +	unsigned long stack_vm;	   /* VM_STACK */
> +};
> +
> +struct vma_lock {
> +	struct rw_semaphore lock;
> +};
> +
> +
> +struct file {
> +	struct address_space	*f_mapping;
> +};
> +
> +struct vm_area_struct {
> +	/* The first cache line has the info for VMA tree walking. */
> +
> +	union {
> +		struct {
> +			/* VMA covers [vm_start; vm_end) addresses within mm */
> +			unsigned long vm_start;
> +			unsigned long vm_end;
> +		};
> +#ifdef CONFIG_PER_VMA_LOCK
> +		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
> +#endif
> +	};
> +
> +	struct mm_struct *vm_mm;	/* The address space we belong to. */
> +	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
> +
> +	/*
> +	 * Flags, see mm.h.
> +	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
> +	 */
> +	union {
> +		const vm_flags_t vm_flags;
> +		vm_flags_t __private __vm_flags;
> +	};
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Flag to indicate areas detached from the mm->mm_mt tree */
> +	bool detached;
> +
> +	/*
> +	 * Can only be written (using WRITE_ONCE()) while holding both:
> +	 *  - mmap_lock (in write mode)
> +	 *  - vm_lock->lock (in write mode)
> +	 * Can be read reliably while holding one of:
> +	 *  - mmap_lock (in read or write mode)
> +	 *  - vm_lock->lock (in read or write mode)
> +	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
> +	 * while holding nothing (except RCU to keep the VMA struct allocated).
> +	 *
> +	 * This sequence counter is explicitly allowed to overflow; sequence
> +	 * counter reuse can only lead to occasional unnecessary use of the
> +	 * slowpath.
> +	 */
> +	int vm_lock_seq;
> +	struct vma_lock *vm_lock;
> +#endif
> +
> +	/*
> +	 * For areas with an address space and backing store,
> +	 * linkage into the address_space->i_mmap interval tree.
> +	 *
> +	 */
> +	struct {
> +		struct rb_node rb;
> +		unsigned long rb_subtree_last;
> +	} shared;
> +
> +	/*
> +	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
> +	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
> +	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
> +	 * or brk vma (with NULL file) can only be in an anon_vma list.
> +	 */
> +	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
> +					  * page_table_lock */
> +	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
> +
> +	/* Function pointers to deal with this struct. */
> +	const struct vm_operations_struct *vm_ops;
> +
> +	/* Information about our backing store: */
> +	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
> +					   units */
> +	struct file * vm_file;		/* File we map to (can be NULL). */
> +	void * vm_private_data;		/* was vm_pte (shared mem) */
> +
> +#ifdef CONFIG_ANON_VMA_NAME
> +	/*
> +	 * For private and shared anonymous mappings, a pointer to a null
> +	 * terminated string containing the name given to the vma, or NULL if
> +	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
> +	 */
> +	struct anon_vma_name *anon_name;
> +#endif
> +#ifdef CONFIG_SWAP
> +	atomic_long_t swap_readahead_info;
> +#endif
> +#ifndef CONFIG_MMU
> +	struct vm_region *vm_region;	/* NOMMU mapping region */
> +#endif
> +#ifdef CONFIG_NUMA
> +	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
> +#endif
> +	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +} __randomize_layout;
> +
> +struct vm_fault {};
> +
> +struct vm_operations_struct {
> +	void (*open)(struct vm_area_struct * area);
> +	/**
> +	 * @close: Called when the VMA is being removed from the MM.
> +	 * Context: User context.  May sleep.  Caller holds mmap_lock.
> +	 */
> +	void (*close)(struct vm_area_struct * area);
> +	/* Called any time before splitting to check if it's allowed */
> +	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
> +	int (*mremap)(struct vm_area_struct *area);
> +	/*
> +	 * Called by mprotect() to make driver-specific permission
> +	 * checks before mprotect() is finalised.   The VMA must not
> +	 * be modified.  Returns 0 if mprotect() can proceed.
> +	 */
> +	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end, unsigned long newflags);
> +	vm_fault_t (*fault)(struct vm_fault *vmf);
> +	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
> +	vm_fault_t (*map_pages)(struct vm_fault *vmf,
> +			pgoff_t start_pgoff, pgoff_t end_pgoff);
> +	unsigned long (*pagesize)(struct vm_area_struct * area);
> +
> +	/* notification that a previously read-only page is about to become
> +	 * writable, if an error is returned it will cause a SIGBUS */
> +	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
> +
> +	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
> +	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
> +
> +	/* called by access_process_vm when get_user_pages() fails, typically
> +	 * for use by special VMAs. See also generic_access_phys() for a generic
> +	 * implementation useful for any iomem mapping.
> +	 */
> +	int (*access)(struct vm_area_struct *vma, unsigned long addr,
> +		      void *buf, int len, int write);
> +
> +	/* Called by the /proc/PID/maps code to ask the vma whether it
> +	 * has a special name.  Returning non-NULL will also cause this
> +	 * vma to be dumped unconditionally. */
> +	const char *(*name)(struct vm_area_struct *vma);
> +
> +#ifdef CONFIG_NUMA
> +	/*
> +	 * set_policy() op must add a reference to any non-NULL @new mempolicy
> +	 * to hold the policy upon return.  Caller should pass NULL @new to
> +	 * remove a policy and fall back to surrounding context--i.e. do not
> +	 * install a MPOL_DEFAULT policy, nor the task or system default
> +	 * mempolicy.
> +	 */
> +	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
> +
> +	/*
> +	 * get_policy() op must add reference [mpol_get()] to any policy at
> +	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
> +	 * in mm/mempolicy.c will do this automatically.
> +	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
> +	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
> +	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
> +	 * must return NULL--i.e., do not "fallback" to task or system default
> +	 * policy.
> +	 */
> +	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
> +					unsigned long addr, pgoff_t *ilx);
> +#endif
> +	/*
> +	 * Called by vm_normal_page() for special PTEs to find the
> +	 * page for @addr.  This is useful if the default behavior
> +	 * (using pte_page()) would not find the correct page.
> +	 */
> +	struct page *(*find_special_page)(struct vm_area_struct *vma,
> +					  unsigned long addr);
> +};
> +
> +static inline void vma_iter_invalidate(struct vma_iterator *vmi)
> +{
> +	mas_pause(&vmi->mas);
> +}
> +
> +static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
> +{
> +	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
> +}
> +
> +static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return __pgprot(vm_flags);
> +}
> +
> +static inline bool is_shared_maywrite(vm_flags_t vm_flags)
> +{
> +	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
> +		(VM_SHARED | VM_MAYWRITE);
> +}
> +
> +static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
> +{
> +	return is_shared_maywrite(vma->vm_flags);
> +}
> +
> +static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
> +{
> +	/*
> +	 * Uses mas_find() to get the first VMA when the iterator starts.
> +	 * Calling mas_next() could skip the first entry.
> +	 */
> +	return mas_find(&vmi->mas, ULONG_MAX);
> +}
> +
> +static inline bool vma_lock_alloc(struct vm_area_struct *vma)
> +{
> +	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
> +
> +	if (!vma->vm_lock)
> +		return false;
> +
> +	init_rwsem(&vma->vm_lock->lock);
> +	vma->vm_lock_seq = -1;
> +
> +	return true;
> +}
> +
> +static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> +{
> +	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
> +
> +	if (!new)
> +		return NULL;
> +
> +	memcpy(new, orig, sizeof(*new));
> +	if (!vma_lock_alloc(new)) {
> +		free(new);
> +		return NULL;
> +	}
> +	INIT_LIST_HEAD(&new->anon_vma_chain);
> +
> +	return new;
> +}
> +
> +/*
> + * These are defined in vma.h, but sadly vm_stat_account() is referenced by
> + * kernel/fork.c, so we have to these broadly available there, and temporarily
> + * define them here to resolve the dependency cycle.
> + */
> +
> +#define is_exec_mapping(flags) \
> +	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
> +
> +#define is_stack_mapping(flags) \
> +	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
> +
> +#define is_data_mapping(flags) \
> +	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
> +
> +static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
> +				   long npages)
> +{
> +	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
> +
> +	if (is_exec_mapping(flags))
> +		mm->exec_vm += npages;
> +	else if (is_stack_mapping(flags))
> +		mm->stack_vm += npages;
> +	else if (is_data_mapping(flags))
> +		mm->data_vm += npages;
> +}
> +
> +#undef is_exec_mapping
> +#undef is_stack_mapping
> +#undef is_data_mapping
> +
> +/* Currently stubbed but we may later wish to un-stub. */
> +static inline void vm_acct_memory(long pages);
> +static inline void vm_unacct_memory(long pages)
> +{
> +	vm_acct_memory(-pages);
> +}
> +
> +static inline void mapping_allow_writable(struct address_space *mapping)
> +{
> +	atomic_inc(&mapping->i_mmap_writable);
> +}
> +
> +static inline void vma_set_range(struct vm_area_struct *vma,
> +				 unsigned long start, unsigned long end,
> +				 pgoff_t pgoff)
> +{
> +	vma->vm_start = start;
> +	vma->vm_end = end;
> +	vma->vm_pgoff = pgoff;
> +}
> +
> +static inline void vma_assert_write_locked(struct vm_area_struct *);
> +static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
> +{
> +	/* When detaching vma should be write-locked */
> +	if (detached)
> +		vma_assert_write_locked(vma);
> +	vma->detached = detached;
> +}
> +
> +static inline
> +struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
> +{
> +	return mas_find(&vmi->mas, max - 1);
> +}
> +
> +static inline
> +struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
> +{
> +	return mas_prev_range(&vmi->mas, 0);
> +}
> +
> +static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
> +			unsigned long start, unsigned long end, gfp_t gfp)
> +{
> +	__mas_set_range(&vmi->mas, start, end - 1);
> +	mas_store_gfp(&vmi->mas, NULL, gfp);
> +	if (unlikely(mas_is_err(&vmi->mas)))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline void mmap_assert_locked(struct mm_struct *);
> +static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> +						unsigned long start_addr,
> +						unsigned long end_addr)
> +{
> +	unsigned long index = start_addr;
> +
> +	mmap_assert_locked(mm);
> +	return mt_find(&mm->mm_mt, &index, end_addr - 1);
> +}
> +
> +static inline
> +struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
> +{
> +	return mtree_load(&mm->mm_mt, addr);
> +}
> +
> +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
> +{
> +	return mas_prev(&vmi->mas, 0);
> +}
> +
> +static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
> +{
> +	mas_set(&vmi->mas, addr);
> +}
> +
> +static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> +{
> +	return !vma->vm_ops;
> +}
> +
> +/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
> +#define vma_iter_load(vmi) \
> +	mas_walk(&(vmi)->mas)
> +
> +static inline struct vm_area_struct *
> +find_vma_prev(struct mm_struct *mm, unsigned long addr,
> +			struct vm_area_struct **pprev)
> +{
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, addr);
> +
> +	vma = vma_iter_load(&vmi);
> +	*pprev = vma_prev(&vmi);
> +	if (!vma)
> +		vma = vma_next(&vmi);
> +	return vma;
> +}
> +
> +#undef vma_iter_load
> +
> +static inline void vma_iter_init(struct vma_iterator *vmi,
> +		struct mm_struct *mm, unsigned long addr)
> +{
> +	mas_init(&vmi->mas, &mm->mm_mt, addr);
> +}
> +
> +/* Stubbed functions. */
> +
> +static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
> +{
> +	return NULL;
> +}
> +
> +static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> +					struct vm_userfaultfd_ctx vm_ctx)
> +{
> +	return true;
> +}
> +
> +static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
> +				    struct anon_vma_name *anon_name2)
> +{
> +	return true;
> +}
> +
> +static inline void might_sleep(void)
> +{
> +}
> +
> +static inline unsigned long vma_pages(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +}
> +
> +static inline void fput(struct file *)
> +{
> +}
> +
> +static inline void mpol_put(struct mempolicy *)
> +{
> +}
> +
> +static inline void __vm_area_free(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void vm_area_free(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void lru_add_drain(void)
> +{
> +}
> +
> +static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
> +{
> +}
> +
> +static inline void update_hiwater_rss(struct mm_struct *)
> +{
> +}
> +
> +static inline void update_hiwater_vm(struct mm_struct *)
> +{
> +}
> +
> +static inline void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
> +		      struct vm_area_struct *vma, unsigned long start_addr,
> +		      unsigned long end_addr, unsigned long tree_end,
> +		      bool mm_wr_locked)
> +{
> +	(void)tlb;
> +	(void)mas;
> +	(void)vma;
> +	(void)start_addr;
> +	(void)end_addr;
> +	(void)tree_end;
> +	(void)mm_wr_locked;
> +}
> +
> +static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
> +		   struct vm_area_struct *vma, unsigned long floor,
> +		   unsigned long ceiling, bool mm_wr_locked)
> +{
> +	(void)tlb;
> +	(void)mas;
> +	(void)vma;
> +	(void)floor;
> +	(void)ceiling;
> +	(void)mm_wr_locked;
> +}
> +
> +static inline void mapping_unmap_writable(struct address_space *)
> +{
> +}
> +
> +static inline void flush_dcache_mmap_lock(struct address_space *)
> +{
> +}
> +
> +static inline void tlb_finish_mmu(struct mmu_gather *)
> +{
> +}
> +
> +static inline void get_file(struct file *)
> +{
> +}
> +
> +static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
> +{
> +	return 0;
> +}
> +
> +static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
> +{
> +	return 0;
> +}
> +
> +static inline void vma_start_write(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
> +					 unsigned long start,
> +					 unsigned long end,
> +					 long adjust_next)
> +{
> +	(void)vma;
> +	(void)start;
> +	(void)end;
> +	(void)adjust_next;
> +}
> +
> +static inline void vma_iter_free(struct vma_iterator *)
> +{
> +}
> +
> +static inline void vm_acct_memory(long pages)
> +{
> +}
> +
> +static inline void vma_interval_tree_insert(struct vm_area_struct *,
> +					    struct rb_root_cached *)
> +{
> +}
> +
> +static inline void vma_interval_tree_remove(struct vm_area_struct *,
> +					    struct rb_root_cached *)
> +{
> +}
> +
> +static inline void flush_dcache_mmap_unlock(struct address_space *)
> +{
> +}
> +
> +static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
> +						 struct rb_root_cached *)
> +{
> +}
> +
> +static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
> +						 struct rb_root_cached *)
> +{
> +}
> +
> +static inline void uprobe_mmap(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void uprobe_munmap(struct vm_area_struct *vma,
> +				 unsigned long start, unsigned long end)
> +{
> +	(void)vma;
> +	(void)start;
> +	(void)end;
> +}
> +
> +static inline void i_mmap_lock_write(struct address_space *)
> +{
> +}
> +
> +static inline void anon_vma_lock_write(struct anon_vma *)
> +{
> +}
> +
> +static inline void vma_assert_write_locked(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void unlink_anon_vmas(struct vm_area_struct *)
> +{
> +}
> +
> +static inline void anon_vma_unlock_write(struct anon_vma *)
> +{
> +}
> +
> +static inline void i_mmap_unlock_write(struct address_space *)
> +{
> +}
> +
> +static inline void anon_vma_merge(struct vm_area_struct *,
> +				  struct vm_area_struct *)
> +{
> +}
> +
> +static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
> +					 unsigned long start,
> +					 unsigned long end,
> +					 struct list_head *unmaps)
> +{
> +	(void)vma;
> +	(void)start;
> +	(void)end;
> +	(void)unmaps;
> +
> +	return 0;
> +}
> +
> +static inline void mmap_write_downgrade(struct mm_struct *)
> +{
> +}
> +
> +static inline void mmap_read_unlock(struct mm_struct *)
> +{
> +}
> +
> +static inline void mmap_write_unlock(struct mm_struct *)
> +{
> +}
> +
> +static inline bool can_modify_mm(struct mm_struct *mm,
> +				 unsigned long start,
> +				 unsigned long end)
> +{
> +	(void)mm;
> +	(void)start;
> +	(void)end;
> +
> +	return true;
> +}
> +
> +static inline void arch_unmap(struct mm_struct *mm,
> +				 unsigned long start,
> +				 unsigned long end)
> +{
> +	(void)mm;
> +	(void)start;
> +	(void)end;
> +}
> +
> +static inline void mmap_assert_locked(struct mm_struct *)
> +{
> +}
> +
> +static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
> +{
> +	return true;
> +}
> +
> +static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
> +			  unsigned long vm_flags)
> +{
> +	(void)vma;
> +	(void)vm_flags;
> +}
> +
> +static inline bool mapping_can_writeback(struct address_space *)
> +{
> +	return true;
> +}
> +
> +static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
> +{
> +	return false;
> +}
> +
> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
> +{
> +	return false;
> +}
> +
> +static inline bool userfaultfd_wp(struct vm_area_struct *)
> +{
> +	return false;
> +}
> +
> +static inline void mmap_assert_write_locked(struct mm_struct *)
> +{
> +}
> +
> +static inline void mutex_lock(struct mutex *)
> +{
> +}
> +
> +static inline void mutex_unlock(struct mutex *)
> +{
> +}
> +
> +static inline bool mutex_is_locked(struct mutex *)
> +{
> +	return true;
> +}
> +
> +static inline bool signal_pending(void *)
> +{
> +	return false;
> +}
> +
> +#endif /* __TESTING_VMA_VMA_INTERNAL_H */
> diff --git a/tools/testing/vma/vma_stub.c b/tools/testing/vma/vma_stub.c
> new file mode 100644
> index 000000000000..d081122ce951
> --- /dev/null
> +++ b/tools/testing/vma/vma_stub.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "maple-shared.h"
> +
> +/* Imported from mm/vma.c by the Makefile. */
> +#include "vma.c"
> -- 
> 2.45.1
> 

