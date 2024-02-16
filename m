Return-Path: <linux-fsdevel+bounces-11863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2353E8582A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BD81C21833
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111912FB3F;
	Fri, 16 Feb 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxKmNC5c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aeuVXnBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEE1E86B;
	Fri, 16 Feb 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101307; cv=fail; b=lyfxdLa348GMI3FTEDtk8zJvXoGKZAYku9mDyb8SPAHjXlLX39YfpDE5430L1THH+3Iyj7DPCo0dwQS0A/Tztt1b7xbQnzqAmlTuUiHEnbsjImuTeGIMee/S7HCSNHZB4NolnNLMjdT3sav2oYd6fxcKCyNFBrCBXraKvNSpe40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101307; c=relaxed/simple;
	bh=+Dq1NcJh6orEDVS3pYIq60MVdcdlxAdm88NaaQUtH3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+7fZ8OUDd9myKW88xvcD8D5Ra564j78/lx5tUUHhCoeDF7DfRVOG42Hx2LhcmeqwQTE4n4ORfNgd57Cb8MPieKhHOHcON3qqTmjTkVCn+N+wVG0LuFmXa1h46P5UaTXCwESlLgIKczq1BjCOx0/rJIx9OFRj8zo7joOPF7ayq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FxKmNC5c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aeuVXnBX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCrmaW003281;
	Fri, 16 Feb 2024 16:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=2caXLofBoKD19sjPFfzSofmELykvFu6A8Ehprd4Tb2c=;
 b=FxKmNC5cZRTTH/I35e2FGcEZTtt34ibCLUvyjqOF1+gl1N3HGqo7gtDV474QSLM90SJl
 rk9xs97jWpYOuECNV+6iDaBX7NgjZWjn6/LDN3QwbuDLhHudeY2t1mpOV/gHajLrJwNa
 Rj5l1MzyRk5r2VHRyUok7fXdpBZMaiiSlZFyvJ6yLDqDe3cL0BFIrWoAbXm5AkjjKNtG
 qp1kpjhrMQBD9P/cQHzaQ2yiOeg24t0AX07QOuOjiFj5+OvI/8EAk7J85fjokKOvY9UV
 3/N8pzmtOAEFJSjMQ04vYuoBmn3DiIhYtTsEUR3hjXOw8bc2/iihEi2QX8V5s2VKSdy+ hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0nk1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 16:34:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GGT7J9024638;
	Fri, 16 Feb 2024 16:34:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykjnkc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 16:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeZmPn0ZU0iXfvIioiPPzhWnTS8S4Q2gAVICStHrezMcfvsi7jNW2tlGeB4jYvLP3JR3oJtXZjyxez7cH8AP4IxYvrU3bq87lVXUxy5775CESfXRFLpasFwLzdKmXn9hyP9Rv6Oc530+JSJv9ZSNSYpSib8rLuL5WYRnEJQDsr/Yb6OU+YtxqwF+Ls8R25HU7SQSdu4sj+b9/LN+cUepyH6ocEl8/oqRlaUZ4M65ZgyHixW295fF9QwCi1UTyNVhLBR/Vrk4XMtlkQwY+Qizg/mQzMFTGh1WssVyMQDq28Znbz6CPaVb8mhad8ncZhXa+OFyFG1K+zVgdPgBSD4jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2caXLofBoKD19sjPFfzSofmELykvFu6A8Ehprd4Tb2c=;
 b=e1HjN98clw4v6U+JsYKcuImoFIaUWy/rJFJnR2USvazG73R+QBk/CRjFICOn18pvvYBrdFqxE13JU2LByzU4BtCEdKIBMDUxlmYC7ZCAH9IDZWFT18etopHddOMPTjeAuRCYiukAZs6M0qMyAW4Z6Mx01aEsa+wbfywVHmzmmEbKToAZpGa3KGVPmhyrUiITIMhyL75lxHQ57N8nd0nPHRVi/5R5cGahwkhrr4s3bJy8Qt6JSZFngUySyXkDWUGwrI64dl4nsnxJfiTCUUcKin8ry/65h7GflQ2jNQnAzXJtGJVs8mrpjVNVLPfCzXH1/0lvQ264K2OOdJWeq7D4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2caXLofBoKD19sjPFfzSofmELykvFu6A8Ehprd4Tb2c=;
 b=aeuVXnBXSeSNkAM0R0WFov9RPCIyrJzDbztCvLOHkgVrLzUKE6wA7dWoAMQbkg33WAfklgpuaWAuaMGkstK3YYxEAI6jkCY4CEeM6HMRZAIbUKVChR56kM7xSXJU8um6yZyIHOgfUTUu/4b2VfAftviWboIDpT8vbzHiX57fWxQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7354.namprd10.prod.outlook.com (2603:10b6:610:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 16 Feb
 2024 16:33:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 16:33:21 +0000
Date: Fri, 16 Feb 2024 11:33:18 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hughd@google.com, akpm@linux-foundation.org, oliver.sang@intel.com,
        feng.tang@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240216163318.w66ywrhpr5at46pi@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jan Kara <jack@suse.cz>, Chuck Lever <cel@kernel.org>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
	akpm@linux-foundation.org, oliver.sang@intel.com,
	feng.tang@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, lkp@intel.com
References: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
 <20240215131638.cxipaxanhidb3pev@quack3>
 <20240215170008.22eisfyzumn5pw3f@revolver>
 <20240215171622.gsbjbjz6vau3emkh@quack3>
 <20240215210742.grjwdqdypvgrpwih@revolver>
 <20240216101546.xjcpzyb3pgf2eqm4@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216101546.xjcpzyb3pgf2eqm4@quack3>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a76638-8c40-4f01-9a6b-08dc2f0cfcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bBOInREN16WwaU4WQTboxmnWbsZmjc42/obX2RgxmlOAS35K/4+yq1/LNtem6EIdR2pJZP2wjsHP1buiZDsXuR+mxY83SyzO+SMX3ap128B4SQ4icdRa0CPgEyhd0YpEL59phmqWErkYFLBlLvXKr7/SVhe37wWmn6Ra2Anki+zzWQncW9ui2r2rfH40Gn6UqCrHkzmLn42iH2/vDJ5GyTmfm0p7fF7yaWRVRD18NI06C5pBUnSdSQ4oO2x1lpbcWzHmmYEYE1t/VLmepcf2XYxd2z1hS6+ZKQ8Lvp3qodWJlCznZiE0P0uzAgThCHIRHMC3XJvUSPdFinzHCgVxh2slGiik+5PoUb/RFb/Hu1k/HEX6dZ5Pu17iVvvAE9n/tYCv+cq4gOtniDzZO8ic1YLeNldEMqjDdkc+ymIBPvIwiMYeLaDh6q6NBl3TQKh2kBf5bU/ZglUtzaSqsu2j2SEquo9s/EvP2zhH3mbcVP7MSuGYe4Mco+RVPw+BbPqQ2gja0xP9rYTApdAelKPInSSk7CHCI0l64WRVx0emjeMOb/BGYmFiDb4mv4T4R6RU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(86362001)(33716001)(38100700002)(6512007)(6506007)(8676002)(9686003)(41300700001)(2906002)(478600001)(5660300002)(26005)(83380400001)(1076003)(6486002)(66946007)(66899024)(6916009)(316002)(7416002)(66556008)(6666004)(66476007)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?geNzMG0vp1JKMq0jn9jIkZnU73t1yMHklH53/o0nHJXJnpEG3PkBxmrqmZfl?=
 =?us-ascii?Q?IN4+2c3nSYYUIb+/a28TuHV4EmFQw6ckZTcbhKRDEHN6VmclDNaz2P/S0NOa?=
 =?us-ascii?Q?kvCo5Rid2t6Z0nJiz1UL3A8ITWkcb1xcTd5JgupxOLe8Qbt5kj0wWaITSsl/?=
 =?us-ascii?Q?nRw2Wu1KVZWC9GccQGu87ZyXS/D7OSRCVk/XzS6tTr4aWr7RcoV2awELERsl?=
 =?us-ascii?Q?RjIK0S5BdrI25z18O/6inMHQGknjf4S12a29/YqpsUAOxzNp+5+G1o4ZOZzh?=
 =?us-ascii?Q?AIKp464d7hJPtM8EyGZDdBUueNeDqo7NsIR9/mThBSbqjQn1EH54S6y5zeLP?=
 =?us-ascii?Q?q5Tf6DbSTf/1TTD293HglB4XeAsP2IsRLoLG7oJtYbF7tveDBH+H61sIEd9N?=
 =?us-ascii?Q?Do4Idgvs0QSQtOYjPgxRbE5ozu0BVDPMflJyTGe+zpHfvQ/ydhahQK/9C6ss?=
 =?us-ascii?Q?mgmNAolCy16sZrkjoJ8tBEd2RuK7mv7wtZpLiaaTW5I/UGAP5VlTagJuQdML?=
 =?us-ascii?Q?DfwR5AFINF8zsIsFfkimuMTetyUQ4ew+RMeI6oBp2JBrDiCBZb+2cdHVjTQ2?=
 =?us-ascii?Q?IlcWkSr1ptFCCQICY0JnM1nkqwTsNRX8zUedaXI+jLJQWJT8Zm51rULcoDjM?=
 =?us-ascii?Q?ZqAO/SgNLPabgoxgJU5XxvCIWrKeoInD6ja0d5sAA1CFThjSGXNT+v6wZWxy?=
 =?us-ascii?Q?0h6YW1CB8KAFPAbx8NV+Irdv6zJcELSKzoT+uHZ8iZkIvsl2a/QyIN0GZ/hs?=
 =?us-ascii?Q?f9ORxEVNmtofpORFNetdGkV73y3noptbhCtaQcxYmD0qycx8sHJLIkcElRY5?=
 =?us-ascii?Q?17LzJ/5ICeZCmvIISGGEvqoPAOCzJASkx5N9I6YIjubSXbB/Wq6sO3CirhSR?=
 =?us-ascii?Q?oqFOMkpXqcNr7Ou7TrXVRDDuW/cdwaf+7NAuqzazoTOxcsJn05jzUqnA4gqw?=
 =?us-ascii?Q?zJO8sPqHBX0RKl9I37+fGYGnG/GKfo9l4V/pTy/aZSm4ZV3eioUFXX3zqfWA?=
 =?us-ascii?Q?hYNnxb49nRA8PnMLpsWUjNxR2vxwY5BjuYAgEtMaeWBadVTYd2zrJ0rKDLHi?=
 =?us-ascii?Q?rgHyA02fqNQF6/yUgG7u4L5lQGD8+7y3Sj9NpPLNEeOK164yhtuXVrFDyWCN?=
 =?us-ascii?Q?Vo5hg62J0ciDA8Cct1N72AuzlWQvj+UbeW7dRY3jxY8EZvEV9BDHzKtFSGHF?=
 =?us-ascii?Q?ZP0DwFn9TYTMS0qi8IXmhEt557Yt6dEXLos4/Sq8ky7tWynccAY5bXbtX0Kc?=
 =?us-ascii?Q?fw17DL3wRyL3D3g9Q62rkjBY6BUNokDGdYpAvP1fQ0ZkyU7ZzARK5qkSXOPt?=
 =?us-ascii?Q?ZvxOWD4TXUNCDryKU3OuQL9uDbxHeM7NJBJaHKB66XNUOPbgRfJGkfwYVAJv?=
 =?us-ascii?Q?8yXPHFsxxviQxph3NRBgxgQvMhQUuuyjATetiFnPltY1Km9rh0scct0vUo69?=
 =?us-ascii?Q?gQANKjRtANI4651m2gX6OayxonHqGKrqfznFaOk3OyRmqAJAS0R/9r257njA?=
 =?us-ascii?Q?Un83UPStJ3WC7nYUVOpfFrGPHtKZ6we/M0KKIaGCxVN38p5Ylp324N3o6BZk?=
 =?us-ascii?Q?/rw8QYpjlVehkvgADLZflkGTJNzIx6aqDntL7OIQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k5Q/0X9Cv0b3RaQRyNegKq//P85RTse7ej5hVpYvbMqKA/v3GUX2AKDFyXO8CMBBpY8hNqSLERVCUFSvK7lmgYkwCdIpfZ6OVfukPV2Md5uE7NSVlAXqpVGegHTgKr6hji4AN3fwCzBAohFLxNCQOLI1CKtchzlvNg5vLkbk2kV9Miio+QhXigHmrtsnTrhJmSiTAK31TBQLbdSBpUX7BYKL93+WbOSvBB1R9mBLK+F25aY0M1jpEttJzl+Zi5MsW1VVQzDmLffYb4YStsmXWmjsuaoQBJRPE+wjJra8n0JOj+TI2maTCegceDMELJDL4n2vux9uCnKCG7/i6rcOULUFZYvYBRicUz4oheCNUEriyByX8sWpS0j5O7sCKcvTXQ+HB8+Ve+Lq9bAnbqiVE0re71qOxWOmHJqyeuVSGVLV7a8ndjU1CGk08VxAGdSnsNDwYryG4IAlIiQxeHOfvMgsM5BX67uURcLtq97xSM4w4d0P1/0/5OfKVJx1TotAOuiJBRnkd+PBmKSK/aqH/7fP1rE2uCxmqS27xRR02yoNNzwp0z46gqxnBI2xkUsE6JAgAU8HcMtLiI69vxS0KrIY0w6hNzMnG8f+rrRy7TM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a76638-8c40-4f01-9a6b-08dc2f0cfcf3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 16:33:21.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaYJKTLDzi/yKjL9Hof0W1MwXhDbuFDfxnXroa6WwOpYia6hS21wdGkk6+BMJcuIPjHwNE2yZy/Psv9J+geA9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_16,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160131
X-Proofpoint-GUID: sVE4T54mjSZJ5YkOANB0wLB4i2Yu5OcT
X-Proofpoint-ORIG-GUID: sVE4T54mjSZJ5YkOANB0wLB4i2Yu5OcT

* Jan Kara <jack@suse.cz> [240216 05:15]:
> On Thu 15-02-24 16:07:42, Liam R. Howlett wrote:
> > * Jan Kara <jack@suse.cz> [240215 12:16]:
> > > On Thu 15-02-24 12:00:08, Liam R. Howlett wrote:
> > > > * Jan Kara <jack@suse.cz> [240215 08:16]:
> > > > > On Tue 13-02-24 16:38:08, Chuck Lever wrote:
> > > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > > 
> > > > > > Liam says that, unlike with xarray, once the RCU read lock is
> > > > > > released ma_state is not safe to re-use for the next mas_find() call.
> > > > > > But the RCU read lock has to be released on each loop iteration so
> > > > > > that dput() can be called safely.
> > > > > > 

...

> > 
> > > Then how do you imagine serializing the
> > > background operations like compaction? As much as I agree your argument is
> > > "theoretically clean", it seems a bit like a trap and there are definitely
> > > xarray users that are going to be broken by this (e.g.
> > > tag_pages_for_writeback())...
> > 
> > I'm not sure I follow the trap logic.  There are locks for the data
> > structure that need to be followed for reading (rcu) and writing
> > (spinlock for the maple tree).  If you don't correctly lock the data
> > structure then you really are setting yourself up for potential issues
> > in the future.
> > 
> > The limitations are outlined in the documentation as to how and when to
> > lock.  I'm not familiar with the xarray users, but it does check for
> > locking with lockdep, but the way this is written bypasses the lockdep
> > checking as the locks are taken and dropped without the proper scope.
> > 
> > If you feel like this is a trap, then maybe we need to figure out a new
> > plan to detect incorrect use?
> 
> OK, I was a bit imprecise. What I wanted to say is that this is a shift in
> the paradigm in the sense that previously, we mostly had (and still have)
> data structure APIs (lists, rb-trees, radix-tree, now xarray) that were
> guaranteeing that unless you call into the function to mutate the data
> structure it stays intact. Now maple trees are shifting more in a direction
> of black-box API where you cannot assume what happens inside. Which is fine
> but then we have e.g. these iterators which do not quite follow this
> black-box design and you have to remember subtle details like calling
> "mas_pause()" before unlocking which is IMHO error-prone. Ideally, users of
> the black-box API shouldn't be exposed to the details of the internal
> locking at all (but then the performance suffers so I understand why you do
> things this way). Second to this ideal variant would be if we could detect
> we unlocked the lock without calling xas_pause() and warn on that. Or maybe
> xas_unlock*() should be calling xas_pause() automagically and we'd have
> similar helpers for RCU to do the magic for you?
> 
...

Fair enough.  You can think of the radix-tree and xarray as black boxes
as well; not everyone knows what's going on in there.  The rbtree and
list are embedded in your own data structure and you have to do a lot of
work for your operations.

Right now, it is the way you have described; it's a data structure API.
It will work this way, but you lose the really neat and performant part
of the tree.  If we do this right, we can compact at the same time as
reading data.  We cannot do that when depending on the locks you use
today. 

You don't have to use the mas_pause() functions, there are less
error-prone methods such as mt_find() that Chuck used here.  If you want
to do really neat stuff though, you should be looking at the mas_*
interface.  And yes, we totally hand you enough rope to hang yourself.
I'm not sure we can have an advanced interface without doing this.

Using the correct calls will allow for us to smoothly transition to a
model where you don't depend on the data remaining in the same place in
the tree (or xarray).

> 
> > If you have other examples you think are unsafe then I can have a look
> > at them as well.
> 
> I'm currently not aware of any but I'll let you know if I find some.
> Missing xas/mas_pause() seems really easy.

What if we convert the rcu_read_lock() to a mas_read_lock() or
xas_read_lock() and we can check to ensure the state isn't being locked
without being in the 'parked' state (paused or otherwise)?

mas_read_lock(struct ma_state *mas) {
	assert(!mas_active(mas));
	rcu_read_lock();
}

Would that be a reasonable resolution to your concern?  Unfortunately,
what was done with the locking in this case would not be detected with
this change unless the rcu_read_lock() was replaced.  IOW, people could
still use the rcu_read_lock() and skip the detection.

Doing the same in the mas_unlock() doesn't make as much sense since that
may be called without the intent to reuse the state at all.  So we'd be
doing more work than necessary at the end of each loop or use.

Thanks,
Liam



