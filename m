Return-Path: <linux-fsdevel+bounces-49409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341DBABBF51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C2A16DF49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4527A111;
	Mon, 19 May 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i+Pb1bLm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L56MbYN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F41F5841;
	Mon, 19 May 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661839; cv=fail; b=uM05ffQ+M5TRxTAVKM7NBpNN25qP+ngvcsmZVyvZL7IsY4BCd3gjvPkfQ4+dmHaT1KttBiG1jlERE96mZU/FuMuoQIwJAHYh/R1iX6tzlyRy6dS53Euhx4XiY0IXufPuvOoik651OMEpDIs9C14ypgLkMwbO9mQh2UtY+WQS8eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661839; c=relaxed/simple;
	bh=2Blnog5reKy9uT+p/70iJZ5LQMscpUoNLvmJFPf3zaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BP1yaqfSBdSG/NpsY4hVoRLPmEgbnbdvBHAoWEnygD4SCM2g0juMBrNbilbw9Bw1Os0S2LydTxefosrYUfnj4wf7QpFpNM17+ZzqxE1guI3yk6BTca65LaIiCP4A/a5NGvNVdy3AVyZj+FpZo3mPCYtLQ4HZbXxcfWmkdoLk5bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i+Pb1bLm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L56MbYN3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6imJJ024963;
	Mon, 19 May 2025 13:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rytG6/5NNWS5K1dF7+
	F/QanXFJo9Xp4qkqCriwp/qjQ=; b=i+Pb1bLmmkNvyZQOlvc/TX5xnl3fe4h17p
	xQJJ/PcCN5fBAqYPn87LUKQOF0/Cu+oyGB0FFmf/RPL1Y57BSkWmD8Q2ZATIM1go
	1CQBqjHVBdOL1wqHmnHd+ojDenaR7j0BMgMELtb8kESMVYa8RsPIvy0wWwVl/InK
	bEw4jXnAEPeR4ywcixq+Y32OBvaLG7ksiNYB1VbJvngSXet6g3aj+EdiyOEupLgR
	bM0/fcAZx8HEVATvlWzAes+iFLKHRq+SPW+QCGcg3KJENWzt72OZF91RFItPzCQy
	2afMUVfqUlz1t5oykRdk2VBuF0GPJduLvbJ/u80bWfGtDZBaPWRA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvek0hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 13:36:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JBlei5037132;
	Mon, 19 May 2025 13:36:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7er0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 13:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLcMPRb/OPp3AViFJlF51HpoVoprOI1TSws8tzu0QQNd2fXDvPWRPRPDAnpVvieC1Lb77xYY+kw83wM7auVZRGFbg4Ba+X/mbyNHohcDQOM5y1oz10la2ih1TFxFEx1PlyPglh6BRR5v+pBoaxeWTAE4SHNQlUOFpv01STpn/itBGKpRP4wS7jyiDMysioiwpld6YVYOJ4uIHn9vtkxQahCu5vnaS1GErLM7r+D7HYthMPL4ZwUZKjcXU9hRjXhNRaV0t8GwEFXz4yMp714SzXZBUdj+uUqLsWGx1W3d9TVy21At8ALrI6NpPirSh4qtDznkkY2nlnvdvDGv91ql4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rytG6/5NNWS5K1dF7+F/QanXFJo9Xp4qkqCriwp/qjQ=;
 b=WBFJWlxxFhc2R0aMxryBJ4qHA1djjEl3C0zP37OrB53Azup+W+1sdG/38ilKN2nWvJDvrgU2x7KxkN5l13BV1M/PKXevAzCYQO0/VqdZ6hylw0ziw4ndb8h8jRA8cZ4noTXR55pVAGtjO0MvwtGqkaWHxmq66ME1rTGtoUnL9JtvZDrpDMIdiaiXRuAVfCs6Be9I3sgkR4xdeApsF12Mm0yB534G4vm+UXg/hgaOzR8HK0A92Kz1TFaOGDcX4UZzKSbEjpXPANBkiw7dpVDJjt8JElLGKkh076mOmIgKzfevlQDtIXOAdg/w8STcZczScz0WXuECp41USPOHFbVUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rytG6/5NNWS5K1dF7+F/QanXFJo9Xp4qkqCriwp/qjQ=;
 b=L56MbYN3WY2DMhrwoZSEuXhYUTeaRJc0bK6aW9HHUW+Cs6g9TwlVyIE3k7yEJUruUvoNq0pYxAPLhU034/PSOXce0H2t1XcwgJbibKu6dvjIXoOsNeRsLTQv/NDyGcxrlGWQ5SyvL5SRbzgLp4X3HKIN50SVs+myWJgyQEN/xDA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 13:36:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 13:36:53 +0000
Date: Mon, 19 May 2025 14:36:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <0b84abb7-a6a6-454d-bd02-861c49840ff3@lucifer.local>
References: <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <202505192132.NsAm4haK-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505192132.NsAm4haK-lkp@intel.com>
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fea592e-144d-4ed7-9143-08dd96da378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kOtLX9X179TEpb66dJILSDQPaPH+OqYDvFtfB7GUVhBKmX+RIWU7pttWpeAf?=
 =?us-ascii?Q?4nJCFlQntlehxoukQRtpQRR5cJ0VsR659ePPGnpg7fGpgaoore50JParOYbx?=
 =?us-ascii?Q?nsv3WdsuUXvvNMo2+AvqNyEGQJCur2otiHO/dgoalsyIKEJddJTXpOORQiSl?=
 =?us-ascii?Q?t34g3Yk7k1eAuu28OgJCOnklzZmzcPTYOCdPfXLoi8czN31aOMZN6qbZJjY3?=
 =?us-ascii?Q?gbBZQzjU07JYXWeIgZgNODX/lX1gZh3DZgxe2aii0/zPdyVWx3WO+tKwLou3?=
 =?us-ascii?Q?zXf5hb/4QsLL8jgwmJ5gNqG40+cjkhLJjsE1b4HyEFzV6pl2mrz7iG18ymmw?=
 =?us-ascii?Q?T2k9D5+/c/dGKnGiSH89Rzqjn0l2M+If6a84Js83AQTpW7pQwTuD1OWz16Zd?=
 =?us-ascii?Q?ymO0hvlB2OK6Bo1ZYi0FusjLQNCbxH7ff+rYfi1PRJwkrlgFHiEEUGqQVqDi?=
 =?us-ascii?Q?ZOwSiTTx+fDdROy33LdZ6hY7sTrVtmwUU7f5OvD3xBfQ2VKqwzx947urnNY4?=
 =?us-ascii?Q?h8YKc+epJijBFybQYFb9qKh9m7Lpa2ZElxT+flGa+9ZIrX7BVlmL5HNYc/3j?=
 =?us-ascii?Q?E1+V80I8a+ee0GwTSuJAJwNk1LoG/yw+hty6I/XVRRbowd5K70hSW7ZCVX0s?=
 =?us-ascii?Q?wR8n2WuF0YknxmI3lFlD5mQW+9tZtT2GNFgrANzN1Po8bdaFWo2Kxzx6zgOq?=
 =?us-ascii?Q?jxYQYg2rdq92iXCAivk7IQt+GEovvRPOam8Pxs3hFJoFUHioVf8DFwzFQa9t?=
 =?us-ascii?Q?LT77ukH0tc+aGxyYfuyH3s12my0HAw/jmtz/ys0tJbIeJLyRwrbUC9Z5sByo?=
 =?us-ascii?Q?r8TeotZRr5bY+2uLpVlFWvUIi5nTjrNhA+5ZHHKVyhkjCOv34XheQeyGKTGV?=
 =?us-ascii?Q?hwbP8j8IL49ygZvyXbefg2VfeHSX32TH/uXG4Ga2yBPBPMqyJRDV+84ybMVr?=
 =?us-ascii?Q?akWBU/YSqMburgv4SPdfoVoje5edGAmCjCykhieL2UIZAtf+/RmLPSADLt9Y?=
 =?us-ascii?Q?7Jokc0l6Ls4Tt0GjMN5gLOuSd9MIOWUKRNjKGqjYL5iYcKCFgLYzcCCmuYtm?=
 =?us-ascii?Q?/ar6fqUjPdia5fOcSgvWR9MWVG+0hFsO611HzSiYhZoSOKvGrGE5Q+CNgyet?=
 =?us-ascii?Q?+CHrnM/OcUS59BNFmNdPaFKbrSeit52ZSnyybXfjH39cNfnVTscOvpTZZY3K?=
 =?us-ascii?Q?u5cv4xOGt97+f+OKKqKLMxTVY71Bn0mv0WWRfwTgZBA3UdaMr4DhPexN2f4G?=
 =?us-ascii?Q?wsPvrDn8J2klkRM5gdzRDqcAPFDjPst2YrEkV7dmXtDlMnOkLVUVSmdy7bFl?=
 =?us-ascii?Q?7mdRvt+8bIPLwFpKUCDi41Lj4pNHwgJAcbbdt/0iNuY5eg3C/Uhjhplq/dgO?=
 =?us-ascii?Q?9y72IGAGJrygLEW1fGdgXTdJ8Vnc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bIXLIOl5BOhRy2GqjzblVazqUnMNnh5kjO4QUfkaDswW4yGJmy3jlh1iq1Y0?=
 =?us-ascii?Q?Foa94pVFjgZMoyu5DKwrF39SNenLuxfyOFHogzUsOhyEJiBv0Zrn26z/Yq5U?=
 =?us-ascii?Q?Ze5BxnaiS77mS6PAK2n4/aISNT37jT+Cu2yt8omFCHaBx2SB0MUgBqqIqMnT?=
 =?us-ascii?Q?cm6gQok1u+YjxYWtECTXTh7u4v/8XcYcNx5AbvRQl4+5sen8aDJ+ScRJQrko?=
 =?us-ascii?Q?lmEhcD5gj6sUrLN6l2z0HTyfq4fDiwPYqd6DJLMIJUn0bUWngKg6Xhr0/u6l?=
 =?us-ascii?Q?0A1uyzR1tAOQUMyvPAYYlUvZxU5+n8uauUv0icsihBLX7AN2f3zLpnOg9w46?=
 =?us-ascii?Q?za5hP46kjkJCqGeoS/tTa4ntScXBNJenazlCo7LFHg8SjdyCYcf/dRoHBJi6?=
 =?us-ascii?Q?LZfTLXlgzrBw7/7sRekpIYZr0S6wGXYWN8RexHmE+AkVyOUW3PDUnCYQ3BuH?=
 =?us-ascii?Q?ezz12m+3Eu0Iwy7FEMB5tzC/IcrY5YrdfrctYf0sIabadxzPzIhP9ns6QK9y?=
 =?us-ascii?Q?rWjYj1YeXWl8DMlqDDkyOZ7MpNeClA61mlFKIK57RBT80yDfNCYRUrGi3Sn+?=
 =?us-ascii?Q?HCJX0gchprlAadvq64upPLXkkgz/WbJedQZ5U6OZ7cfqTfcmBAmvOUQ0elMX?=
 =?us-ascii?Q?3y8aF1nbPbhRVqWD5HhkPvFLkKMB8siRsu9WkWJROeR6Z7f436ndFXQdwArI?=
 =?us-ascii?Q?snlvgov5abwsYcoFrfQO/5szzIyrCooWS4hOdXbFJ30RZeqgISmNPLmucSmv?=
 =?us-ascii?Q?TRalu7BcmF+zcttou+FWBhFJdiqwtNZtr9UbFyYeSGpTDBIslN1CsNQx6yOk?=
 =?us-ascii?Q?kPPbc+yhpGE7tzjsLZ4ZjSuJQkYeR3Q0vZDq/xgOzRKMJoyltARBfdKAPv3z?=
 =?us-ascii?Q?pZUDbFgdNz80umU/UrtzU7vq38osB2/RsbhKNzuNG36X9nwpPTIxj6K9OoTK?=
 =?us-ascii?Q?Nawas88vZxgrw9SQ22tZhnnRv0IDnV01BW4dhTv1OOvuBwQNvDDrKHklu+lM?=
 =?us-ascii?Q?bYAIRJcqizwHwZ7GlOkS7MRieJ58GCvczEGC75aTHVs8Sk5ZHLLN6p3++8e1?=
 =?us-ascii?Q?HbaqOLDA5y64XzjpltC9s9UMWHOiQrscOIPYto+PEDubFlGKLup7h0K1SmZV?=
 =?us-ascii?Q?kmyGfLLGIv69sfPpIxXqJTot/I3NwyIpU+GT2WdOGJOgrO8q4YeATPbD2bBk?=
 =?us-ascii?Q?NGdGDslHmr8XTkSQMOCYzwW3Z0isAg0yLsh04OAznV9OY8B/ly9vcCZtCM9V?=
 =?us-ascii?Q?OMNOZkuhqeHxIn3kI0y/fOuyvuREawyG8m0r3LWhybB3fr7M+4be0hPty5Io?=
 =?us-ascii?Q?uW58e25yXcDYyf5Q9CmOPtjauyP01lxU2ldZEcOEA/gjNpxMzem5SkT0wcOs?=
 =?us-ascii?Q?g79DQz8Pdp8Ke2p18Zwgd4lkFfTCnY/4Rv3qTGy5ZGsO0DrINoCWIxBlVXId?=
 =?us-ascii?Q?o3OXdsbIu9VEHPh0ymhFHuVX4qqDa3/0K981asb8BbSaU8XS/FXtdWMj3trl?=
 =?us-ascii?Q?UmiOEBvuhuP+Z6IX85DJ9bpKACR+FXl7Fyso1RFRDj4LCflT5k7XZzBClfNM?=
 =?us-ascii?Q?76jMeOpfvz3WBKnkgV/+rqrY0cGZNwx6dUcKbB07ZwCdv5bl1PxVe086JMZw?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QJyl0fXKzydUo8QiXBv088lUEg0UKO7YWCd3b6oDBQK4O9Wy/TEK62lJXegggjdKAT8t/zJMhdHpOJyqUOoaqho3DOg/+ZKycQT2t04fIS7SlupzowaAujBlyv7Fh9GqraYpHi+xmmyyhYJhNFdFiFqUlcC9Z9PEd2qCCKIgAYIOBJldDXrvdpSdaTFwbTUNhGQWU0g6w6kmnwzAHWi9y4hs+16AdtSxT0nOfEdBC+YiroscJnZt5X9KezVzV8oBiJtwzUREfu/xcsSy3rfCeKD+yRblMG7+1ydu2BWDWwwh6hwtdffGT+H1YERxr6QlG8g4fyXM89k9qOGUngAvdOM6NvNImY3Gual2GeLkg5icRNUz4nm2rP515UaQDwzCB4LwDKNrX3hJIW727Bc7sFZyyEalIFxgqMYcFAtVS41BQQ/7b5lgehM5J1FQl8txTUP/lT5fTw8Bo5xi2eaNptvhWCa+X8uMPlCXF1Ch7iWosgeRHIlzPnyxZpvuvCzTVlrEYbQka0U8j6rHZJP18uyWoxf7XtO77k/m8wCSBDJVBkfgNm+mPKhRwtv11KxLhE88IhryASP7SczQCKy0i08JvbmUSIEVf7xjwS7BvGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fea592e-144d-4ed7-9143-08dd96da378e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:36:53.6549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBz0m9zab7M9egbXrsWZ38+GTscEXFwaBlymdfCvyngO+8QxCyOFi2PGBuswQtp83xKI/nYfHaxJCAiCl6Xjq2ErH/9KILywh3rLCEh3wKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190126
X-Proofpoint-GUID: v1ueoGnyO7U-cS7MLxUAy3ZLXtrRyj7L
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b33f8 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=pudWWHukelJLBKHqbQkA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: v1ueoGnyO7U-cS7MLxUAy3ZLXtrRyj7L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyNiBTYWx0ZWRfX90qE+RLkm1DB /9Odxt+Zh8mZqfRdm54s84DBBvkPg7Og2VL36+RgAF/oXqNdidDGVfCt026pTzU4gvfuoW6RI63 bdHD2/agrwEkZ6dlICmKvtENrhMr+AZeIpGsZF9TSA2YoYWBXFfQcBJsJyhvIHhFxApJV56PC4g
 LvbTUHLYSVZX5ZA1MnnYuD0WVaSU8/q0l1LrNhaceJoJx3324eZIUB0TDy/pT4TgoveRVg61gjC ZiSkSUPTSOmoBNB0sYYteGni1Lc4zdjKi5fTdnnPoQLW1r64u0a9ebguCSK7dSz/4iUN5TiGv6u uzp4EyIo4wy2pUFz0/JP1UThMgTEolVofcfoMcCXwyyZF+qFYroCrmDuvdQYNiTGB2jC+C6nWpQ
 JorWmJeGPsHQGxomiUT/6pC+r6+zE97TKpXUGt4d2njMgH36Bnmh8Ejd+iTOdMlogno0vbXd

Andrew - fix-patch enclosed for this. Silly oversight.

Will also fixup on any respin.

Thanks, Lorenzo

On Mon, May 19, 2025 at 09:19:50PM +0800, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-ksm-have-KSM-VMA-checks-not-require-a-VMA-pointer/20250519-165315
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes%40oracle.com
> patch subject: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
> config: x86_64-buildonly-randconfig-001-20250519 (https://download.01.org/0day-ci/archive/20250519/202505192132.NsAm4haK-lkp@intel.com/config)
> compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250519/202505192132.NsAm4haK-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505192132.NsAm4haK-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> mm/vma.c:2589:15: error: call to undeclared function 'ksm_vma_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2589 |         map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
>          |                      ^
>    mm/vma.c:2761:10: error: call to undeclared function 'ksm_vma_flags'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>     2761 |         flags = ksm_vma_flags(mm, NULL, flags);
>          |                 ^
>    2 errors generated.

Ugh ok looks like I forgot to provide an #else for the #ifdef CONFIG_KSM here.

>
>
> vim +/ksm_vma_flags +2589 mm/vma.c
>
>   2586
>   2587	static void update_ksm_flags(struct mmap_state *map)
>   2588	{
> > 2589		map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
>   2590	}
>   2591
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

----8<----
From 2dbb9c4471f6145a513b5a2a661c78d3269fc9fe Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 19 May 2025 14:36:14 +0100
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/ksm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index ba5664daca6e..febc8acc565d 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -97,8 +97,11 @@ bool ksm_process_mergeable(struct mm_struct *mm);

 #else  /* !CONFIG_KSM */

-static inline void ksm_add_vma(struct vm_area_struct *vma)
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file,
+		vm_flags_t vm_flags)
 {
+	return vm_flags;
 }

 static inline int ksm_disable(struct mm_struct *mm)
--
2.49.0

