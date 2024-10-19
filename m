Return-Path: <linux-fsdevel+bounces-32422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277B9A4DFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C21F2683F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4B2B9D2;
	Sat, 19 Oct 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LKntPM/r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rBCfWJMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686024A08;
	Sat, 19 Oct 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342432; cv=fail; b=sLvl6ajeGM6kxQcZvoY7Cn9LkKfXmICcE9HkYeFjJUgww9RdIK+TVFG5QtVPYh7Qg4hYWppeKff02/isbUmZRbqKmXio/kZi9x3F9OoWMDIJZ9qG9Jhi1VhkRcOubB08+oJe5+JRzuOtFZuhIJ7kB719UKYbMdyvSTGlw31WdEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342432; c=relaxed/simple;
	bh=d+YfYbHEwj/hhNNJ0Gmuh0J3TJFkwDUl+QLfdbBcbCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chlC+738HKphX26VYCMnrMJv0AXfZj/tharP31IWRryJsR7lB78roOj77n/dX62SQJTaI4hkSnSIjNVVMCteWC5e8OCpYw7YPTZ/IoO4eCSB+Bv4iJAvj1bIXrmZ/FiSfzraKGmxFgygdVA9BPB25xPutPs1S764rP19VbTwj+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LKntPM/r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rBCfWJMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49J7t6Fx016227;
	Sat, 19 Oct 2024 12:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8+Zx5wv887XsG/Kv67UK4U8gZ7JUuJeZT2NA7tkHJ7I=; b=
	LKntPM/r94mJfOHIdIvOe0s0n/9uKnCZM7kvCgbXxFTmTqk1fjcUsKlAw95QPmuq
	maWjDB2tm1yFwfcQ8wnxDbFk4zTMURJke16MgCV/JIXWUBU2qQ03P7OhFKf1bhzE
	rrhR4u1OJ+1ULzHgz4Xe/MjIEJep7EI5inoA8YdkIvHchJjJuQNL6U3kMJLEFfhq
	6+dDY6VyNZiCqwOZlJRCMLREMre32hTentI1EtKtn1aMPo6hb04DBkd/gsRjDzes
	/FmBmP1WOtNNIizQruupg8jlZ/xRhmOyCVsdvt4LTf/km7WVBPvNlRv7Yja8I0TH
	VrFwypEiA7gheoS6H/lBng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54589tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49J7Uvwt022635;
	Sat, 19 Oct 2024 12:51:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8esmbq9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Oct 2024 12:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezSIxfiyQt0PpijCgCs1KWMDPdfsPNwAw9RwkqHk4zfSGQw3bQ1D8CTdT7O0QXrT1Xamd0d7smE2R+NfEds3NaJR2yt6L269RDmhRVjbh1gW+QzPUtnb0018wwB+bcnaBYz4bfwP6Bh6AMZEZUkhOA4PbRoKmdG1YxCfb6S/PEJkngTD60p5XvkYp/mAYdXa7ojZ1RUA0HyL0YoVzh3bP0n69+LHIHDifBSV2Gm0fI8JcXaspjz+XhcYy6+0nQ1nLOT7KL8+i6cQqHGq0v8FAbru+puksFF2CaIB5U6INZBkBejABMJLaBX5GBkly5SvoXuJHzqmsfzHwHV0HBv0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+Zx5wv887XsG/Kv67UK4U8gZ7JUuJeZT2NA7tkHJ7I=;
 b=Wf0HdPXtM09Kv0FIOLMN/s6Ai/kg/v+kEzaXHNtI5q+TTtXNj2gna2X/B4eh4ss9hRLylQt8Dx3yO+sdI1wEcB0WF6E0cKcb0zSuJ5Vb6IygPxW1xFZzJM+eDqkS2+fAGsvt7272OsSMvamlNe0cJn/5mtQKYBnR7HDOI5Nxy3mKbGMTALyE3VKFWGJ3vu9lMr/kmfPQqP99okJavrvLvxCxV3CM3WVn4I6vv6+UtMRny4gx+TXmnE+8o5uo/0qQxR9c+ydPeaCDLsT/vpVlFE4tllB6pyY1eefmW6898H027b98TKif++QibNL7xXuRAURc9K+FGIuv+wV9hUCQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+Zx5wv887XsG/Kv67UK4U8gZ7JUuJeZT2NA7tkHJ7I=;
 b=rBCfWJMWXCbQivEah32HtM+/7xUVmpS6oHOaOgU2ErIocXrjUaIlSy/ZKxWg1Vj21hmnaFb5hbaMrbHKvTICbANbMm2X0zmXNJC+cLRQqi3SVJbSQaTZhJOUULfcV6XE7aKKO5Ogqi4Ek0jqqjmWJSr5VJYGI+rZYLV3DxTBirE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW5PR10MB5874.namprd10.prod.outlook.com (2603:10b6:303:19c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Sat, 19 Oct
 2024 12:51:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.020; Sat, 19 Oct 2024
 12:51:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 3/8] block: Add bdev atomic write limits helpers
Date: Sat, 19 Oct 2024 12:51:08 +0000
Message-Id: <20241019125113.369994-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241019125113.369994-1-john.g.garry@oracle.com>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0311.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW5PR10MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ee4e55-aef6-4bdc-a2b7-08dcf03cbea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fbtltYVoiwQaXy1eBJCO1R/EiZtDBLt71aXminfUxiwhB9fX/h9uyaA+Cev?=
 =?us-ascii?Q?mAPC4VOIYCayhSo05caaQwvUuNTVfdNDcsNG+kaPBydwJHLD14tULTgO60VL?=
 =?us-ascii?Q?Qa0ag5jD/p+hIPm9oBaKkQByGEVxdJWz+Vdd3Jo13FRl3l5vJgTZf8fO5gAM?=
 =?us-ascii?Q?z5VMBO61r1ldbaOX3Mi0ap0ir/I+V29nnCP5sCv8Rlb720tOyw5kiVJh6RPh?=
 =?us-ascii?Q?XfL3XfukLrpZrVVNph2P2H5dbiyHMPl4MdR2h67IJqFi3r2ryzGc4YxkOYJh?=
 =?us-ascii?Q?5RgFrkmod9lkB4RqkWiqTUSykerzzN8plcMExAe/78w70KbEJfA/8lyxb+iS?=
 =?us-ascii?Q?ytAd2cKvnXWuWX45wRyLu/jmwRPdT1U6DlaHDFKww3u9CQqlEEh/Tv8T5vzY?=
 =?us-ascii?Q?0D0ZGG/dkqz0f0BnUp5DvrRCNdbgraQb+ScRZkWWaPKtPsE5kIWpV2WbFUCC?=
 =?us-ascii?Q?/4IFaWKvt/eisNkscf0/qhqEsFX6rAW3DwLFbfjMn1tGb5azgWauHVPZwffM?=
 =?us-ascii?Q?FQ4zx5kuwTGD5bWRlU+ydo+iJ2jQq4zXy2x9txPv49lnrTHnzTD0j0rUdQCN?=
 =?us-ascii?Q?bmAAgEZeWHfm89/vJ4W+z0w1yp0SolvTS7PodJfzQys2jSV8oK9HmMYIP1J9?=
 =?us-ascii?Q?fKbZ4U8Y0gVXgYt7xBkANZYi1h9FRiDOFjRt86FMGOp3K2IbrroSMaRPhmRv?=
 =?us-ascii?Q?Z8qD47/dx98yYV+T/g0mDYuiAHsAOjcob8UYYWx3qGXlLgzAwOMdapVAUvLj?=
 =?us-ascii?Q?zehBm0jihkAC3ai0SJUXjlRNs8xip7uH/EizRLbGpRxC7k0lGPXEs3SmbpOT?=
 =?us-ascii?Q?hKeJ1eq77EXR66cTfKLDpjZnz5h+d2lEZmsXXGk9JF1Jb7Ljdk9pTQrRsIyt?=
 =?us-ascii?Q?ikz3xKLotfLAwpKKTkEet3gvPc5qaRGjU95DCtMnbZy8lp7BuFF+aU37VHIQ?=
 =?us-ascii?Q?cNrlaIW+XKKa1JI5HBnPeg654zHMCIPYSIw+8vTdIlFPMPF2RSLvJuAhQ4bU?=
 =?us-ascii?Q?hYeqpPeFVS/xeXUmFrCXuTpt0smQBEdMWD4ND2UfupDFYwKnyartHEynAj8e?=
 =?us-ascii?Q?j+ZCM945GcPdEHUQ/r7l+vQzhX5ggbt4QhVjDThY3YRoNK0QwbTQRkJh0jMA?=
 =?us-ascii?Q?ZEmp1Lfop1RAHosfPiRz/1WwD8VwD7B7lglPlKcK2LbLwzpFxRCu4C1zUPUz?=
 =?us-ascii?Q?bOkN7ccVo1rAK6/id5cjxd57U8cvsfmkLjByhgKjS/gdDP6InVOg5+tStQzq?=
 =?us-ascii?Q?QhFmds8YPd5LzyJDSk1ClHi2pmbd+N6nYKDSKY5vRknbqcTc5XgCyZYYPX1Z?=
 =?us-ascii?Q?Vv2aw9z7SPqfLZav5Aw/PtbQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQcu9FE4DuzciO5WMtW+ujvxYJyAiyjBlHMezNPiKzKh/KCe6OJMr87TglEI?=
 =?us-ascii?Q?7uQUlOqjCYIZoM7zNnJiO6L8DTT1zL2r6jzak1W5YU/z9FvKsk18kB5ccL5x?=
 =?us-ascii?Q?5ztrMFIfqsdE31gBZ4Stgi8F3ZPyi+CqZiJCUxCD1w3WoOU+cU3rCCq4zVuX?=
 =?us-ascii?Q?jz1uhUXVEWw0wTUepZ9a6c0j26R0kqjpNeCbvQTxdMV1j/y7BzdCBTig0k/x?=
 =?us-ascii?Q?peqQ8Itx69Uo30bHDldK4svbc162dz6UFy1qK4SfPFVmlp5ZL2heGLbOd7ur?=
 =?us-ascii?Q?wuvpzfXs3i1UC3Mee8TYiRYVm2G/aUIUel2Ez34oOoRciA6yqlHFKDHhIRU+?=
 =?us-ascii?Q?ToKO9MwS74j+SQbhug2Z6Lhgmp2oVqs84nsHtJlEbf2XeTotbiTt6ZX3D41R?=
 =?us-ascii?Q?4SC2S9SyiaEGMe3k8nR/0JrLMhqCNdN5nCFOuhZQ7+mlCiCiNmwMF5pi2Fzw?=
 =?us-ascii?Q?sJINMXyvZbkD91T7r//EIK59rRDCysxS0y4VhLbl+5c6hi8fPfHG23KCMsEn?=
 =?us-ascii?Q?MayMWj8hSOje0L743S9qDtcNNL5pPtsGK0/55W/zOuRxnhyLB4su75Mf+L8C?=
 =?us-ascii?Q?v5aIRIaYvfQO7K00NNsX3LAYVkzlG8iokgReolSs88VP6Xt8fTMlBXj7Hw8U?=
 =?us-ascii?Q?RWQHLAjFEl1ORGNTH5jVDBVFZD/paEckR1ossUHntLOo3PLubGRmneC6123P?=
 =?us-ascii?Q?LBLnFEynOfaMptvpiTALL1In3WBglu+MAgmbyoZMiWYKetJQfRha9ivxDo5a?=
 =?us-ascii?Q?oYd26GDhqLVizAKAwiPdeN5SfXoat8wUzurg7S+hU+d2okyhcVvl1+hQ4X+m?=
 =?us-ascii?Q?GA7ZZ85MtxdMpR3A1ENEUOspng6xk6vuDHSBLIdrm8qfhCqocJ38TOCyx+Qc?=
 =?us-ascii?Q?a5a6LgC3ZydNmnQBHjvk2nA3NJ0Kg9h+PcbHsiqcAjctuHJ1f1WoQqYdDKwy?=
 =?us-ascii?Q?jqkKpq+2X99cxB/a1OYsP5xxeAo6YjY5Q956VQaWtYN02yxqdRPzp4y7omUu?=
 =?us-ascii?Q?YaJgp3wmNmRckW7ERjRT5hECakQ8VkHbPYlyXJQvmpHcvi36+MT7ZSQLxUjM?=
 =?us-ascii?Q?490sJv6oaw7rLy/xrhc+ZNLIoYyXqSR1jaw/Q260Rse89iDp5+ttscwynocc?=
 =?us-ascii?Q?S/XKE+Gjz21u1ul5WcIx9A5Ay4OeCdmFhRsUlNV7wswpphbfAWg5/GVWKTEb?=
 =?us-ascii?Q?QcVrfyF5jiQQHnNh0Zsbj0fQNMz6fb+B/w5tHg2V/QzazCeGZKw9miinlLAo?=
 =?us-ascii?Q?d/qjYs3+B/co7DgajzTt1jpLLZBj/yQXgKTTrmhdVahVTsABBCRt9Xur3eg/?=
 =?us-ascii?Q?cs5Vfar24La5POtHgnVEVakSDOIHDjCh0W2+jCkrf8fMAPQY4odDc8o4BNwz?=
 =?us-ascii?Q?UURJ43r85PB28MLb5389y5qiSw9WAixQUlU2yuCja1CruiBSvQvBgJk1VFPF?=
 =?us-ascii?Q?gVDq5fd6sYSVcoyA0gEEZlEp714kvZk3/1At37e49mvHZMGi6Vtnqqu4cCtK?=
 =?us-ascii?Q?tRZTsBhmPMHg/v+nBeZbttwPDGS/JOEFlNE3qmhEswBFE16+9iJuoyU3FQUK?=
 =?us-ascii?Q?2epqChfvSJQibsjjKhd4rQW746cdwWl3fRJcGSj1pa1sww5KzBAVtC8VaITH?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9zAT18L9W+XmhJPr9Rj9uBdhR29loPKtLqqGKPrdB+NCSuXqmat6qzX1uhJY/17U8+x1YixCkBryM8/ueV2v6FWF2l+Lsc17hcri/jxHwEL27RrdspTXSEKVmxDUbcC0O1QPaeNxYEsQwsUTDQ45Gwnv/cAco55GzjaBAKy1hOI9jT6jwF+7n84gHp2xXTf7eOHc4PGtAomt6TRy5rytvwU8M4Uf4G8hyDDWwmueqlHQrNtCZ4RizcIrn3tsnJL5aJele+yPvmg4pdADWiz14eeJ6upMLQ0yR+pz4jJ50ALhWVhg9YlqZVK05yeeM0iST59zDH1LuO2teI+nZgofOiJuAuken/1whrK7Z17+jLB3tc0FGx4EBk1hMdSxZ/K6wQbPdW0Lx+KZXaiGZJ0s8x1Q1x2MS3F3eR55PmlrkTahFHtQG29B5JbS7RHmNAYbLC7/kOHLH6xU2jJnM0alsM4M15YBDEWt2jnbZzkMAQ8mC9nYzlg3RsiARNej5yZS+Pu6gHZTTBrel/cuo6EP0zcbRtd8bTfjXki49goxGdCmNdeh0m+u3xDCbokx29drd33QVICjygvNa7uv5imtPnyGlMLQ3ZvFKTxFwGTAHSc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee4e55-aef6-4bdc-a2b7-08dcf03cbea2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2024 12:51:26.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av3UFCSycamUSFi6NzJPOkOa6iwe2nUINoy3rY8BQER8fMvz17AgOiD+EV4xMjbrOmRxUESxZOK1o3NQX+/Crg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-19_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410190094
X-Proofpoint-GUID: ro-5EAOiPK1PBBWgglonKvhE44iQgpg3
X-Proofpoint-ORIG-GUID: ro-5EAOiPK1PBBWgglonKvhE44iQgpg3

Add helpers to get atomic write limits for a bdev, so that we don't access
request_queue helpers outside the block layer.

We check if the bdev can actually atomic write in these helpers, so we
can avoid users missing using this check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50c3b959da28..c2cc3c146d74 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1674,6 +1674,22 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
 	return true;
 }
 
+static inline unsigned int
+bdev_atomic_write_unit_min_bytes(struct block_device *bdev)
+{
+	if (!bdev_can_atomic_write(bdev))
+		return 0;
+	return queue_atomic_write_unit_min_bytes(bdev_get_queue(bdev));
+}
+
+static inline unsigned int
+bdev_atomic_write_unit_max_bytes(struct block_device *bdev)
+{
+	if (!bdev_can_atomic_write(bdev))
+		return 0;
+	return queue_atomic_write_unit_max_bytes(bdev_get_queue(bdev));
+}
+
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
-- 
2.31.1


