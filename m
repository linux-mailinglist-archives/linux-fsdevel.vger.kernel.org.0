Return-Path: <linux-fsdevel+bounces-24438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9193F490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF44BB21809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C5148855;
	Mon, 29 Jul 2024 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JYqZUL7f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o3sbG6nI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A111487FE;
	Mon, 29 Jul 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253909; cv=fail; b=RbbQK4mk2Bk8tBYvunAgCOAUvIZ0cSdNJWca0UofJpNUbF81J8TRtd2+PBeUjllQEkj6sOqx5/pqw39QisQoE3m2O1bHWow2DwFLO2k9xx8lExucZhukiwaiFZOC64NPEADMGvdgtp3x4fzK8MNzn4TgAORCdndzuKlJqX+ub9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253909; c=relaxed/simple;
	bh=WF5MaBf0OuKqyo4tlhdPrMGZMjR9ABPXDjTHLH//Dac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKSJjOurIPmZSdeKQ2Ah5p/xZOHGKvP4r4w0SVlJEsubCQNbGjIrz3ma/9DkNBu0wA4VkZxhSYgA04r+m20v3WF6q+afJqEgotjjfvmixNjsq/AknnCa7vg4QKI5qiXvhmOVrnIPGJbR+fovjotWRetKgEH25aPPwIzH5+hQal8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JYqZUL7f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o3sbG6nI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MYjJ006241;
	Mon, 29 Jul 2024 11:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=AtZXBCncvd+GENkOrV4WmcTQW0fb2FkdkewaAOgm5ys=; b=
	JYqZUL7fZMckf0dS76Rd9fcQvuQQYvasZUzi9douS/rCQtszHVjEl6fSwE4Gd8ar
	5rbZbMh4tgn9vguat5tdzTTU/0RUqVUmqIYJOYnWmaFKolkeaOKAQjxTH2nOQLTN
	02diHuzoWgL4eGBxj6qNx+d/tBgT+lcTiIB+nM3ZN2VO+kjxKwbNiS+JToHF7nKL
	AOz6RdvtDuvRDi55i9ZQrxtCDtb6zq1EIKhtGi3MKcrHk6sANAiq6FxQsUNuj4SN
	EHT4f4PCxJnHhSKrSX3mrHvd7E6GEhymn7DajoLvfiTGSVhkuvZeirgIrPhNduvn
	LefhP8CYMPLzvLc78jYvAw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40msesj93r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TBaggO035584;
	Mon, 29 Jul 2024 11:51:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvnun13g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb4ammERSbl6/YrBXmwQ8+9qwISQYn2xS6SmL+xUfxzj6SP0bdkQRzQH5Ib4zZM7gKaqtTRzsqyCZEQKji4dm9Bri/KUWK3gMmQjj/CR3a7Eeb3DV9WmnVNDJybu4+zAeFIuE0BXeJNgYZ8bVXKTK/eF/SekxyAfdQg3frMQWJqfn3m/DzicDSKmBoD+X0+svVbsAk1OHaHJ+Ieb0JW1lM82o2AXvQblll/gyxHEC6tJTlk85d8Avr573E+jmo7z2VGW95vrZofM1Y3vEuFlYuJV14lflLdQmvnb3LSVNg0QpTmF8N4yqE8/1njNVYZj55ovzQ2Dh1tksV3z83J+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtZXBCncvd+GENkOrV4WmcTQW0fb2FkdkewaAOgm5ys=;
 b=hd+PVPK+z/fiCmXSht9s3fsBTzhtcaDHpjlntiKn9NZb8cOh/jlcbv3Mrl6rTS/Tkd5bnm0rgtsi+BiLDxxSCZDyGbxxBE7md2tPdzQj9sOcxTbED61lwPZV73904a951smXZvE/mJhIyyppE1odGZyucbD/oiYy5kBX4+sj5fa/MeEicYCAXlZkMQawfwApCTlNEnQ/eh2T+b23sZAup+sni6wGCmyW8R0OBphDaDJ128YDtKM9zL9x6VzoJyoiH8DNBgkbmEb44Y9Mcy0g0WLXqH/GN6iaiyFij4zXvWOCW+PED7tSGpMpOKM5xWrJvzlE87t3XHaV4kDibZJAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtZXBCncvd+GENkOrV4WmcTQW0fb2FkdkewaAOgm5ys=;
 b=o3sbG6nIZGesLDEEPaEMMo0oALvjOCgTTFth2NCMHe7ndMB7SLScqmElGY5gQbofOa+nVk1iOVk/NQsAD3tpKxRhPVcNwSDvfacN7RvzQk9zUEab3aUG4Zv9+FjXLckq315gzoWKJ8yjdpqZMO1OG5OBZdSwODAIW3tHGi7jEm0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:51:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:51:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v4 6/7] tools: separate out shared radix-tree components
Date: Mon, 29 Jul 2024 12:50:40 +0100
Message-ID: <1ee720c265808168e0d75608e687607d77c36719.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 172a0041-aaf2-49ee-412b-08dcafc4c33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxv/I43mpsQ4Vi086oCPatly+pnsFBpWWlIw3q8J8XeobgUvu8JrhZ3Qztft?=
 =?us-ascii?Q?i+B5J0VGXhPoyzMotUgdd6wKOxsfIHuEMZJQP5kDLESOagCYJmgQpdq2D32Q?=
 =?us-ascii?Q?5/+MKgJjgnrAEpMmdsIHkjnPFfvZiykN+B4JFoQ082RgPtzuT/AnoUXAKeJQ?=
 =?us-ascii?Q?sOr3gASlqBPTHb7vqZ6Yve83bIzDbT4+xSkitd3nsNmS/kFnG1Ns6lPLwRSe?=
 =?us-ascii?Q?Wdn0GrUuNcoVV/aHPw+9r/A/1b6t7KbPnj8gKBTWI4eg4gEvs8uInAerfMFI?=
 =?us-ascii?Q?FXhZcwEY3pZdzhSdT7Vn1lr2ePDVMAwZK1a6IfcHgrmmv5XE12NJB2F+CLt6?=
 =?us-ascii?Q?FvygI1m+5ZsGsqfZ/GB3wK9J0QJKKXIDSzWLiOzSveS//Ks9BVJLplvJyqRT?=
 =?us-ascii?Q?CYnkJLkDGfKyMHubBKka2cjWYganwrG/OABfhDQLy8FCLCPjG7jrmdqwX8t4?=
 =?us-ascii?Q?PrkNt336TvWng70P2HGnWd/SVlFmijBnfvQZ8PAynVIHP3NBeBF3H43g0qaC?=
 =?us-ascii?Q?zC4unmkIRaxUBc9ivnPloEKzbRJn34kSDtNryd8lwPCqXx1+hQw+JNHLGk5S?=
 =?us-ascii?Q?k6CwuQ5YqJ3jSKkRkA2fU2fcjEf0Qixx8YubFdD5WHx7wN0SptsgMCpYcf1K?=
 =?us-ascii?Q?a47upA3545y4DcoHjHGvNpElaAYhV9o8BTmWzqc2h6Y+FcZ9gXy4ibyyEg8G?=
 =?us-ascii?Q?EzvheV4oNacXucijMZlQO5Sw8Jgn1i72Wx+rNP+w9053kKh39Zw+T0EovZqN?=
 =?us-ascii?Q?M9ulNex7+4R7fLKPDOuiGkNm7X2hOohycpN0xWn5OBD9NlFF2GutnHwdDXkf?=
 =?us-ascii?Q?IOkPF0na9XNTkSEx0XvxzTpzDwM+viM+8RIkRAXkfSh4N53B+aiyoQCcwafx?=
 =?us-ascii?Q?0xss5GKVFYulUpMLJzEiiVor6yPhwPgB2d7qYrHILOz0ZH14MrmyynwyVti4?=
 =?us-ascii?Q?V6AUlGw2+YooOdR+rJctF+eOSX5jXooYI34O6njlnxYRI3+oItyDitYsfU5F?=
 =?us-ascii?Q?CXfQoAeVdjnjtiE+Etbqrz6v1dG9jIcAaOu5W9SUtP7NYKYjGr9Zdfq6uyVb?=
 =?us-ascii?Q?AqVNtfr+qTIwT4yvSlEkD27EkZPTiQ3TLVixux2SuCaUgj6me2GuM1jbycGv?=
 =?us-ascii?Q?mMrXqAOyGjlauh/D9CfF8tWSLyePEiLBO7wjjPy3cHmzcOMVMc2sf/XmJv/k?=
 =?us-ascii?Q?wBN7E330nQGdbZbUmekqVxzIRr5wA+/ZudKBoSsTVlY+W5eV9gglgs11p0AX?=
 =?us-ascii?Q?3SbdhPmWZlQSCl/nrE8NzvulCx+DtpH2hfmHLHnVflg7rreUNDlXYWRB3vmc?=
 =?us-ascii?Q?TwQSUOPGf+kajpKEg4/rwIcZNLLhdvHxaY+shKHSyqsPwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1W+8zeNJCRrR7+G72zR5y1zIFcrgS862YMidzh45zvCFEoiSchuejklNm4Li?=
 =?us-ascii?Q?zuQtKKLOM2pQTkrOLKIPc5JR+Pv6/QZjz/Et8Nlhk2zN3V57KHMSFuBjxq79?=
 =?us-ascii?Q?of9TRrL7xlz/msMibK6JmCJWMGuPsYKJ9dI8bQtA3yRI4/rTiUJR6fjC39aY?=
 =?us-ascii?Q?4wyOHdYtLKlSVzvmcL4GejzohfKUjvYCFYnydifWAM/zug5GyjntORC+T7w6?=
 =?us-ascii?Q?U3KDweUgbZOJJth/WQIqMU0Nkpsx8Tn28LgICxUMW0CrBf7lbY3dFMeWjBgV?=
 =?us-ascii?Q?ekVEshMeDJlFacCZ/acMEg33XRe27tLGEppip7OStgCoV4u07ytVwIBKIXnn?=
 =?us-ascii?Q?1mENayRP2om1czitHp1+dr3oMIf9agOpMG8d5mX1EDiSct/5yYtF+EWKd2KA?=
 =?us-ascii?Q?5s/GR5Qb34Amtcdc2dCZpX9pdnqy+6N/QmizjB0y6qb4VFmKzx56tA3Hjzrr?=
 =?us-ascii?Q?+m62mVu22XDa5dP9bMfk2pyWM5h28kdqSeK1gPRqNzkOvSfvP2wW1l9jfq1u?=
 =?us-ascii?Q?/FYdx5KvRf04Jox9yo1GDNBuYfoJOJxHhfzTHMdwYvYAWGrw46waG1ZiXxaq?=
 =?us-ascii?Q?QZp6rqAbkwQCXqD/s64CzTo/+EhfjYzvwD2V2gNWLtfHlhJ+KGWudfzdhg3I?=
 =?us-ascii?Q?Gbr3AXaTnIU/GwYhNtVaKyJp3/Mhm/2Q38k7YosWmSzQEJeiml4rtMjMknUY?=
 =?us-ascii?Q?dpHQDJA4P+dJJKypZRAu3z7RJBUDLNlgthYmEUZGeIpco91rqhg8iWKFGuW9?=
 =?us-ascii?Q?mrwr2gn1r9dN2/mCC/hWLlbG7ktIU2wUJr5vsvF8Fh85v7mx8GPczEn4yakW?=
 =?us-ascii?Q?lT1mAdN2lpSmeNsioHUa44n742o6sFYkhuaFFIK/pDR5zAn/3exvk6xzB3pA?=
 =?us-ascii?Q?lfvTSpjCjCrwVk6oHge5MNzq9LZ0+VO0dFRaf0SB6BSz55mu8On+WaE89e8I?=
 =?us-ascii?Q?22sAEx5JkM3gPB6cH0K/ppMb88C2hx62mO2JfjsW5kb6rZ/TkxARRvN9rxUf?=
 =?us-ascii?Q?jSGY+PKsjzu5uRR1kssdLLg95+iACDe650czo9n8ASe9elNcfKpCuI5vUyWq?=
 =?us-ascii?Q?sz5gnrcmraNHhkAahjVXvl94aIK0uHoBl0BSyUE1Gf8xMxLNrMOmHh0HLVJC?=
 =?us-ascii?Q?2Hfx/KYlb6zECHGYU9slwBtFBwYTQFWok1vnWPk5lgoMuWa3VXiFMIgZMWXZ?=
 =?us-ascii?Q?0HQE3VbFC1fsPUJgmiz9ThX4uK+h1PcTy/kEFTsCpJhUiS/BfdIt56G2eguy?=
 =?us-ascii?Q?0j+Nh+i4NLJ4twlQwDQV0zkA26Ogrf145uwAx13Uaui2nKzEgKNlhQAHXXbC?=
 =?us-ascii?Q?DPtQGAWuFfoHdRJ0VX39HuW/Gc1H3HIDySSIWVpHR4TP+2h0K/rpU5e5aqGW?=
 =?us-ascii?Q?Kh2WkoX7Z/GE7CBznWKRI4mZyuNadUpQhlV1WoQ04c8c/891uJtfqYgogRHD?=
 =?us-ascii?Q?euvkA3KVY5uoj6IfcaLbg+mwaJz8UR/KgoE5HQCkCmx12gcKhIPcNVbO+Xur?=
 =?us-ascii?Q?SDgz2uO1/BCiq5C0t8C70vouw07UcbcPAY23ZoUH5TAuCRBsslq1m9vasWXL?=
 =?us-ascii?Q?fBun6Ys5h7hLqZDnnH7rYVb67iUdE4y1oHaYqDJlRfH/CcW9uuYwkCAabJiZ?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s/9r44hE/7GcLXHCxqrrTv5jtbgpoXEUHdqHYkDj0GFRdtg/ikyidyQ05M1yJBPMOU+X4qmVoXBcGf6msL8+StKlQ50jv889kfokX92Q33lVpFUFotDM0Thev50K2McIFrwquJCpjICvqWBmM9vEeQCRunDfLQmwjUWMnxVgS3fWmDeld6bHDFtqZMZqZDbmmnoR3yJcSVHxmAAwjtg2BkKUnWYLEEiCpYwcBT4r9pBTz4gFpxS/ocrMfZscAw6iusHBXu5YA/YlZ+YKoXQ84m8BpOAQ9/iJNtenFAxZiaJFK+/iYUNZLgO++UrCqXRLBOrnegk3NInK2kLvUxF0Nku/+dLYdgkPtTtGz1YkIhWiMAIfFreyyUVFrjxSEM1nlrxsbOHgp0fymiJHuv1jOdBA/eQRlpCRq53eQKdR1ZFbKBfkElLZwxnVyhhwRWurM4EtPuEkEpZBZ+X3lNpjpPPYKiFu642yHacWRoUtK+C/zIJdxI+tDs4++Axg86uKwbwNm6Ut5ZxEpw/cLydyotUYvAa8bdkjANsmsAaOV9rwYKVgDtosfYAP8QceRacf/a/xgjstC7ebWGlrq+famW6eG1+Gzz/GRMv8Tr621I4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172a0041-aaf2-49ee-412b-08dcafc4c33a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:51:20.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWxfqEYmhTmhXFGKDjCG9Vs0HYJHdOcv7rNlsrc84g6IpD4mqkBkjlTZWhbNW3J8cNJnbz2GYKUEs0i9y+wfoowewt//1ra2uGrstKEkiII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290080
X-Proofpoint-ORIG-GUID: EPHT3_G4G4fr5d51coDx5FxOl2uygRL0
X-Proofpoint-GUID: EPHT3_G4G4fr5d51coDx5FxOl2uygRL0

The core components contained within the radix-tree tests which provide
shims for kernel headers and access to the maple tree are useful for
testing other things, so separate them out and make the radix tree tests
dependent on the shared components.

This lays the groundwork for us to add VMA tests of the newly introduced
vma.c file.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/radix-tree/.gitignore           |  1 +
 tools/testing/radix-tree/Makefile             | 72 ++++---------------
 tools/testing/radix-tree/xarray.c             | 10 +--
 .../generated => shared}/autoconf.h           |  0
 tools/testing/{radix-tree => shared}/linux.c  |  0
 .../{radix-tree => shared}/linux/bug.h        |  0
 .../{radix-tree => shared}/linux/cpu.h        |  0
 .../{radix-tree => shared}/linux/idr.h        |  0
 .../{radix-tree => shared}/linux/init.h       |  0
 .../{radix-tree => shared}/linux/kconfig.h    |  0
 .../{radix-tree => shared}/linux/kernel.h     |  0
 .../{radix-tree => shared}/linux/kmemleak.h   |  0
 .../{radix-tree => shared}/linux/local_lock.h |  0
 .../{radix-tree => shared}/linux/lockdep.h    |  0
 .../{radix-tree => shared}/linux/maple_tree.h |  0
 .../{radix-tree => shared}/linux/percpu.h     |  0
 .../{radix-tree => shared}/linux/preempt.h    |  0
 .../{radix-tree => shared}/linux/radix-tree.h |  0
 .../{radix-tree => shared}/linux/rcupdate.h   |  0
 .../{radix-tree => shared}/linux/xarray.h     |  0
 tools/testing/shared/maple-shared.h           |  9 +++
 tools/testing/shared/maple-shim.c             |  7 ++
 tools/testing/shared/shared.h                 | 33 +++++++++
 tools/testing/shared/shared.mk                | 72 +++++++++++++++++++
 .../trace/events/maple_tree.h                 |  0
 tools/testing/shared/xarray-shared.c          |  5 ++
 tools/testing/shared/xarray-shared.h          |  4 ++
 27 files changed, 144 insertions(+), 69 deletions(-)
 rename tools/testing/{radix-tree/generated => shared}/autoconf.h (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 rename tools/testing/{radix-tree => shared}/trace/events/maple_tree.h (100%)
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h

diff --git a/tools/testing/radix-tree/.gitignore b/tools/testing/radix-tree/.gitignore
index 49bccb90c35b..ce167a761981 100644
--- a/tools/testing/radix-tree/.gitignore
+++ b/tools/testing/radix-tree/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+generated/autoconf.h
 generated/bit-length.h
 generated/map-shift.h
 idr.c
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index d1acd7d58850..8b3591a51e1f 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,77 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
-	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
-LDFLAGS += -fsanitize=address -fsanitize=undefined
-LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
-LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o maple.o $(LIBS)
-OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
-	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
-	 iteration_check_2.o benchmark.o
-
-ifndef SHIFT
-	SHIFT=3
-endif
+.PHONY: clean
 
-ifeq ($(BUILD), 32)
-	CFLAGS += -m32
-	LDFLAGS += -m32
-LONG_BIT := 32
-endif
-
-ifndef LONG_BIT
-LONG_BIT := $(shell getconf LONG_BIT)
-endif
+TARGETS = main idr-test multiorder xarray maple
+CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
+OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
+	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
+	iteration_check.o iteration_check_2.o benchmark.o
 
 targets: generated/map-shift.h generated/bit-length.h $(TARGETS)
 
+include ../shared/shared.mk
+
 main:	$(OFILES)
 
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-xarray: $(CORE_OFILES)
+xarray: $(CORE_OFILES) xarray.o
 
-maple: $(CORE_OFILES)
+maple: $(CORE_OFILES) maple.o
 
 multiorder: multiorder.o $(CORE_OFILES)
 
 clean:
-	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
-
-vpath %.c ../../lib
-
-$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
-	../../include/linux/*.h \
-	../../include/asm/*.h \
-	../../../include/linux/xarray.h \
-	../../../include/linux/maple_tree.h \
-	../../../include/linux/radix-tree.h \
-	../../../lib/radix-tree.h \
-	../../../include/linux/idr.h
-
-radix-tree.c: ../../../lib/radix-tree.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-idr.c: ../../../lib/idr.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
-
-maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
-
-generated/map-shift.h:
-	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
-		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
-				generated/map-shift.h;			\
-	fi
-
-generated/bit-length.h: FORCE
-	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
-		echo "Generating $@";                                        \
-		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
-	fi
+	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/*
 
-FORCE: ;
+$(OFILES): $(SHARED_DEPS) *.h
diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index d0e53bff1eb6..253208a8541b 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -4,17 +4,9 @@
  * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
  */
 
-#define XA_DEBUG
+#include "xarray-shared.h"
 #include "test.h"
 
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_DESCRIPTION(X)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
-#include "../../../lib/xarray.c"
 #undef XA_DEBUG
 #include "../../../lib/test_xarray.c"
 
diff --git a/tools/testing/radix-tree/generated/autoconf.h b/tools/testing/shared/autoconf.h
similarity index 100%
rename from tools/testing/radix-tree/generated/autoconf.h
rename to tools/testing/shared/autoconf.h
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
similarity index 100%
rename from tools/testing/radix-tree/linux.c
rename to tools/testing/shared/linux.c
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
similarity index 100%
rename from tools/testing/radix-tree/linux/bug.h
rename to tools/testing/shared/linux/bug.h
diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/cpu.h
rename to tools/testing/shared/linux/cpu.h
diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
similarity index 100%
rename from tools/testing/radix-tree/linux/idr.h
rename to tools/testing/shared/linux/idr.h
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
similarity index 100%
rename from tools/testing/radix-tree/linux/init.h
rename to tools/testing/shared/linux/init.h
diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kconfig.h
rename to tools/testing/shared/linux/kconfig.h
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kernel.h
rename to tools/testing/shared/linux/kernel.h
diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kmemleak.h
rename to tools/testing/shared/linux/kmemleak.h
diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
similarity index 100%
rename from tools/testing/radix-tree/linux/local_lock.h
rename to tools/testing/shared/linux/local_lock.h
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
similarity index 100%
rename from tools/testing/radix-tree/linux/lockdep.h
rename to tools/testing/shared/linux/lockdep.h
diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/maple_tree.h
rename to tools/testing/shared/linux/maple_tree.h
diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/percpu.h
rename to tools/testing/shared/linux/percpu.h
diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
similarity index 100%
rename from tools/testing/radix-tree/linux/preempt.h
rename to tools/testing/shared/linux/preempt.h
diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/radix-tree.h
rename to tools/testing/shared/linux/radix-tree.h
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
similarity index 100%
rename from tools/testing/radix-tree/linux/rcupdate.h
rename to tools/testing/shared/linux/rcupdate.h
diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
similarity index 100%
rename from tools/testing/radix-tree/linux/xarray.h
rename to tools/testing/shared/linux/xarray.h
diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
new file mode 100644
index 000000000000..3d847edd149d
--- /dev/null
+++ b/tools/testing/shared/maple-shared.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define CONFIG_DEBUG_MAPLE_TREE
+#define CONFIG_MAPLE_SEARCH
+#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "shared.h"
+#include <stdlib.h>
+#include <time.h>
+#include "linux/init.h"
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
new file mode 100644
index 000000000000..640df76f483e
--- /dev/null
+++ b/tools/testing/shared/maple-shim.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Very simple shim around the maple tree. */
+
+#include "maple-shared.h"
+
+#include "../../../lib/maple_tree.c"
diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
new file mode 100644
index 000000000000..f08f683812ad
--- /dev/null
+++ b/tools/testing/shared/shared.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <linux/gfp.h>
+#include <linux/rcupdate.h>
+
+#ifndef module_init
+#define module_init(x)
+#endif
+
+#ifndef module_exit
+#define module_exit(x)
+#endif
+
+#ifndef MODULE_AUTHOR
+#define MODULE_AUTHOR(x)
+#endif
+
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
+#endif
+
+#ifndef MODULE_DESCRIPTION
+#define MODULE_DESCRIPTION(x)
+#endif
+
+#ifndef dump_stack
+#define dump_stack()	assert(0)
+#endif
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
new file mode 100644
index 000000000000..a05f0588513a
--- /dev/null
+++ b/tools/testing/shared/shared.mk
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
+	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
+LDFLAGS += -fsanitize=address -fsanitize=undefined
+LDLIBS += -lpthread -lurcu
+LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o
+SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o $(LIBS)
+
+SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
+	generated/bit-length.h generated/autoconf.h \
+	../../include/linux/*.h \
+	../../include/asm/*.h \
+	../../../include/linux/xarray.h \
+	../../../include/linux/maple_tree.h \
+	../../../include/linux/radix-tree.h \
+	../../../lib/radix-tree.h \
+	../../../include/linux/idr.h
+
+ifndef SHIFT
+	SHIFT=3
+endif
+
+ifeq ($(BUILD), 32)
+	CFLAGS += -m32
+	LDFLAGS += -m32
+LONG_BIT := 32
+endif
+
+ifndef LONG_BIT
+LONG_BIT := $(shell getconf LONG_BIT)
+endif
+
+%.o: ../shared/%.c
+	$(CC) -c $(CFLAGS) $< -o $@
+
+vpath %.c ../../lib
+
+$(SHARED_OFILES): $(SHARED_DEPS)
+
+radix-tree.c: ../../../lib/radix-tree.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+idr.c: ../../../lib/idr.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
+	../../../lib/test_xarray.c
+
+maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
+	../../../lib/test_maple_tree.c
+
+generated/autoconf.h:
+	@mkdir -p generated
+	cp ../shared/autoconf.h generated/autoconf.h
+
+generated/map-shift.h:
+	@mkdir -p generated
+	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
+		echo "Generating $@";                                   \
+		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
+				generated/map-shift.h;                  \
+	fi
+
+generated/bit-length.h: FORCE
+	@mkdir -p generated
+	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
+		echo "Generating $@";                                        \
+		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
+	fi
+
+FORCE: ;
diff --git a/tools/testing/radix-tree/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
similarity index 100%
rename from tools/testing/radix-tree/trace/events/maple_tree.h
rename to tools/testing/shared/trace/events/maple_tree.h
diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
new file mode 100644
index 000000000000..e90901958dcd
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "xarray-shared.h"
+
+#include "../../../lib/xarray.c"
diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
new file mode 100644
index 000000000000..ac2d16ff53ae
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define XA_DEBUG
+#include "shared.h"
-- 
2.45.2


