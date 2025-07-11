Return-Path: <linux-fsdevel+bounces-54656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9704B01EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459C91CA7610
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A32DE717;
	Fri, 11 Jul 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbrHo1SA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RLcYJp3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591321CC5D;
	Fri, 11 Jul 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243282; cv=fail; b=RD9mNJjrpS0NsvZpT5DTobmHqC5OgDbmjWztUkpoevGTsbPzcq4B4ZFY+8sPmDDKBTO3QWf2/sYIN1x5ArjEAioAnzEe8zZdb7YC3jLGoys+ZKqRactNblCPtdStb2M1NJr+9RoJTbmy9nZhaTJOYZO5fFUpSZBCj+a5cA57RU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243282; c=relaxed/simple;
	bh=0ol0eWumH6fDXUdQbgIROC4PyZuPoHnzSijQWN1O7EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvyf5QoXJHASRrxTNwekwi6yryWvHH4GebRZR8ac35mC2DAGo+pqyho61bxu4oodwfTswiHNVnDAYTJcsF9+UZ27ZnbwPYE5JsBe3+7sns6jl37ZJQFgFbzXG0lcOhDJj6wxdT5NVkGBOUG+sRXI845QYLxgWC9+KBPz7zQfei4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbrHo1SA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RLcYJp3l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDfivL003678;
	Fri, 11 Jul 2025 14:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2tCZcytoIcaJFqsyaF
	oPFF4aLsKtQ15Fk2V+ZHtaEYE=; b=VbrHo1SA0J9u0P2xFvXLpdCh9FRgJHkrZt
	nKkOUnuJt/PWAiTR71zBLM3RXvZJhv4HmFMXB6QwzZuMUjKh89sZn8gHyRdch145
	benC1hpOMSJ2OwbIP0X/VqGgDrQrVcyee+AUSw7/Su6RT5u8ASD9YbpZiKlAQODY
	MmrcFbiTxJghLzLDo40tznsEkdBiY2dc98kjMYrDlk002WU3GbS+1sKVxyvGXvID
	7VaWOVMrEq/keSXbu8gQUo8X0QR58dLBRVUVR+XaVVYestzmGgYPTgWXejndtbNX
	SKKhL0Lk4wsygwmDKjZriNctrxzrk0JVyhJG83m+hbWTch0ZbBkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3qgg24k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:14:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BD91cV014184;
	Fri, 11 Jul 2025 14:14:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdmqqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN03q5h8vCjW1hlMiRLYoBrEM7B5oU2fwVW8kcJdhvR2WKQiSOI7KlQyIDoNBs11TzG+Z54vZvYNIbLxEDvV3Z53AmCqU2as+ivay0WduuwzC74OcSJpQDVhHxh/T/qcJ8vTaQU9vgUBHEVr2Wuprv9OD9jyetLRM9yype/aHFsjXwRq2TEewm8DR5YULIyyRk0AMlezSbAHbiU97ie8j3JezvSRyMFF+u/WmrS8BXY0tVu+qg1u2kHWWoJjnN+cuG5azEbMPo6w7D8VGCeqJjlj9L3PeaORN8EJILMfh7HZFIruBar/1PGf+Hp5S5s3xakAxdsqBdeNvJHSHGoeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tCZcytoIcaJFqsyaFoPFF4aLsKtQ15Fk2V+ZHtaEYE=;
 b=rvd0v3bx4UBd/SACHhpJJ79wz/7fGQynSrGlWiMVCQm6etOw9uJysgCjQVGPt+P5eAN/M0DdUTx18pv1cv+6F/c6hoCLwc54/QOye0/8mPOpg8P338ZuacybQJ5stxnqNZTeGxxtm0x3KcOuQzNvbbsf/3WafnqQbo6r0dcL30dBuBLJeKuc8Jang5Efc2kzOPjSnW+PjW6tu4/NDBMQ8pZXHJKXDKUVkV6GrzEci1+66lZdsvFv7Uetws4Xjv4uUGErjZyj4QRIdma25arvduZMYVSQdvCaSmxdvV8FNQIUguclVtrvedFxSYz5+PcHxw+zH+W6tAFVVn0+LNyE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tCZcytoIcaJFqsyaFoPFF4aLsKtQ15Fk2V+ZHtaEYE=;
 b=RLcYJp3lcJ2NhUtsLgP4y+wZgg8mMMjLsWH5L2590ak6yt6XOJTaCILvfmYmtZu8h6dDEprrk7GXc2g9NNShAAZj5FOF0dCXRke21JkO4rxTVnxKwOYIZ22wJ0KUxCCe3Xkjl6Wi2j6IDFsLamhh7XXA+b3iE2fjbnaMOFNkPTU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8492.namprd10.prod.outlook.com (2603:10b6:208:580::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 14:14:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 14:14:03 +0000
Date: Fri, 11 Jul 2025 15:14:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <e5a58805-e621-4628-b78d-f5d6e4b6334c@lucifer.local>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
 <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0653.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c280286-af63-45cc-1575-08ddc0853055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aq7kiGTrh8RVwBjEHoRfsk4NMznLUBxLB/xqtAUKb/eS+NMEchwqSVM468te?=
 =?us-ascii?Q?bLXX64oKy76xgGZZeoCHgbZwJ7fNUD56WStcqMmDccFY6Io5et5hUSmjdnxD?=
 =?us-ascii?Q?K7it3IugS5LH1VDYDuShEkAcKPvF3jIq6x6bgAqD/chIHYfU5k1Lnr6r01qI?=
 =?us-ascii?Q?YiyYd/dRIoXEMKNrLGRr1lW2slgWy5Z4gWTBlQ2DPBrMEAiCZn+nzy/pfY6f?=
 =?us-ascii?Q?5CforlnJW/MuTI2fJi+XJwxsiSADfEYV2uC6jIRMqb3uzsNutoLtiwbHIi3q?=
 =?us-ascii?Q?drptudI8wzTLRMJ9KjiRkew3KWf7pOSGrSCGFyU2Ui2tuPAnoXLqzxn60J5H?=
 =?us-ascii?Q?qUvn4IhqcPzCbAR1FnKQB70abY4QQKZfVw9/padCIszTzzu53ogJTFAoK9cE?=
 =?us-ascii?Q?eTNlW/4pHKjXmIdlnae2vZZICMd1vUlTk9gAqhKnwj/JgD08mSSL3SpM5Ee1?=
 =?us-ascii?Q?qkNcc88cEy10+TCuE9NqoiiyEP8oIGgZSvgnoznP8zenHKP+fhfWxmN7991n?=
 =?us-ascii?Q?SFN9yFITKMNYO9aOq87BVrkG3DLYDnxEHbkz4xLQZPsITg8X7ODv98lE/1aO?=
 =?us-ascii?Q?Z2lHt3sO9esneatBohl4hBAne3XBx8OQ5EbKIcmRuq2Z2gl0oGdlR/spoCQv?=
 =?us-ascii?Q?B56GNnXwumaRMt+J+EY07/jseXBTk2Fe/UmWQfKIyQBNaElXeBhELd5a8P/S?=
 =?us-ascii?Q?Fq6Zxt9ExHYVKzslieNdtBpBBC2lUmh81CfqVMDZJ/iLuc1r+rY71woKzMYS?=
 =?us-ascii?Q?S3ePhmaYE+w6NnF0AwahulQJS6vlbepUwuU02F+KWjffaCEgx7CIqWX9BQhH?=
 =?us-ascii?Q?W/xKuSQnvYBMSP/kyEWFSpU+nVYy20JxVcDEq2Cq1xz0TltP3xABM4oMf/Zt?=
 =?us-ascii?Q?9fPHAedk0DzJl4/ovHYPtsUiGxRfH/rd2TmYgu4WZJ59L44YYL4S5p+WnbOF?=
 =?us-ascii?Q?csN8Cxeki75+VKxOPqLaUpvN1ft+5cv3kxBzswjW0+Gcr8w44HlS8SnIBA9T?=
 =?us-ascii?Q?28UvJ5/qEaXLIsx+k/W8SlABJD9EoJaodcaHyMRIU6IEFlaWjRmz7YfNS+Hq?=
 =?us-ascii?Q?I6z//SwvhRUcvYoXEgTeP3xuD6MHCt7tBxNNwAsTK0LMZ7qJ+tJcPeLotsxE?=
 =?us-ascii?Q?mSLQt+nMY1SVsyGi+wt82ESAdI0MVn04UDs/Zs3jVeKyRPK2WDb2R42kOq0J?=
 =?us-ascii?Q?T3rIxCZBEBVWSdAc7Yyeyzdlj2wji/A7gDWgOWNVFK6FI8eoX0RULw5DqhEb?=
 =?us-ascii?Q?/orSmwKY+GeR43R6TgSHq9zc0o3AduCRL4fpiG9lWmMR7Kbq9tjSn4udItfq?=
 =?us-ascii?Q?iNXqPGSWYoZGBHYdfYx/DccJ6FlsrpjV0SFcwZVTVS1u13SL+DmYPWv5jUV9?=
 =?us-ascii?Q?eP0o/6uW8y22UbfiPi+jMiGRPuPdPnAn+qHl3oyVCRzv93D+L6oTe4F51oMf?=
 =?us-ascii?Q?IjQNpo4ZXks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r6PbyIlph3FXT59ncYqTNfjHw0+AMHgq7Np8TrKSvMhrros76jopAE7ImoUx?=
 =?us-ascii?Q?vjoE7l6CuvGdGYfXyfByO7GXPl4aIUXDXe44g12Y0ami5UV94ByT8H+V2/ZN?=
 =?us-ascii?Q?30m0sKlOfRef9/fkX442zMlYhtzCp+LEX4SqVoEWPjRytp5CG5OLbgvIcnWD?=
 =?us-ascii?Q?4GFj/eg/Tm6Q23RXo9FoHpIxxxdbVKYIZ5TmFbqvDxWakpF0PNgI8QH7PJj0?=
 =?us-ascii?Q?rUOl5wdF08aHHVaQbdA/+J9BwhDyfZs2tx+Ih6Vx7hOlTI1mUf+th4PtlAor?=
 =?us-ascii?Q?12XrpYwmQHwfU4u4d2UGwGJ2F4MrpE7qxQt0jnuaXsL4eIlwe9SAjQ0ozBse?=
 =?us-ascii?Q?BAl1QjZPHfyk07E18+Nnew4jIs/MEjdAlZWinZhuQ6NHQH++Fz3vEoa7Q/nf?=
 =?us-ascii?Q?+v6OqDnVBnlv/q58SPrCuSTQTMl1cqTivfrTlbPxvas9isgkJxoJbY19jpjd?=
 =?us-ascii?Q?FYe42PTuXRZ3NMMIW233GY1ErqDmCxwiKS5mwb6UZo+tqV1AHIjoGzUkEbPO?=
 =?us-ascii?Q?wlT3hOGWdAu+Xwv24LxGhTQAdboYk0ehIS2+MoNhXoVPDivMbrobz3/mnF7K?=
 =?us-ascii?Q?L/cOGvdVZSjijv+hYRLqOpkDvJzEooB7wLNPZDkcOCjeemkkxqlY1wXw7Afo?=
 =?us-ascii?Q?Njpk2yHI+3nO8MXAzBkILN00WcpAbKuL9FfTzpVZGx1aPXKXiGwNoMUH8hBS?=
 =?us-ascii?Q?s/JDgxZeC6/Uc0Ys6QoOMcfLMktgKOqflycWtN99miu+mR+LoImZKV3RxkYF?=
 =?us-ascii?Q?BceD49PxNuyAjhW3s8wsfghT+nmBW8A35RL2Xbj8FnXLiXiLezw6OcnRrcvi?=
 =?us-ascii?Q?ewK8JJfyXu4+lzCe8/nd2fCVa93N9NdSoR4DDjpfNiX2en55nM/vrB7vIOlL?=
 =?us-ascii?Q?5mhO6hNY5LxJb975rZ1GeVupM8hsKn49WfxtXM8DdzV3S4AK4Qf/tBjg/+iI?=
 =?us-ascii?Q?8zvlNzsPs/Opo/ZzM9qicIUqAyTC5ck2WIOWlOYv2MHvignQLyP128Y7+m3p?=
 =?us-ascii?Q?wonoDXDh4slpIK8ZK/5Eh35/1ogVOKmZOEEU8eAefRy/wmVLFxnFUQHWkyrm?=
 =?us-ascii?Q?IWxTuCTzn1p0ZewBIHzh0BLlF/cO7wp4OCwKbz210SRtN5IW+y+lGx1ePxTS?=
 =?us-ascii?Q?qNnkemvAF8HeQ8CC7AK0VJEfUsfQzkw2BIZjCO8IbxHzEt3bVelfqwGgcznx?=
 =?us-ascii?Q?9QdEmDHAVoFk0rjgokOLn+3AQFm6x3jxJ1or4/6YKZqAfwoY8R1k8zZw0Jvn?=
 =?us-ascii?Q?NQJsbejEJTgU4wLuMctt/JcduRMgTGa0/Vy6QoJ+Ohry+KjG+NuGzMB49Lj3?=
 =?us-ascii?Q?jyCw8Q/bq2im7Atk6suv0yOPpHZN1nEIPDU6Oe9ytA+2pYRL6jdQXldPDa1G?=
 =?us-ascii?Q?Ice0GvZivGNw3qacrs7TqnoD3OIFki0BPICpXTfoGLtVWh4sQh65xk3hqrou?=
 =?us-ascii?Q?8/dhOYNHBNRmAierfpdxQRIswOtrb/E3/mtZfm23V3LV0hqPZVgXsD+wcUyI?=
 =?us-ascii?Q?siOgVrkNn9ngQ6g0GpCZzGkrlFJYYwNTOuA+QibiUIvnsOuYk0uoDXbv4MR6?=
 =?us-ascii?Q?OxkXF66z/+u2hBPouXY2hOR2VrNHdYfCBjHONoBrR/vmAorwseRjhAI7tmEd?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bw7Jdren0FY9Uv345FTuYibQBeQDBYnc1tK0aIii2JhNl73QQYNAxq/hGtlL8V9gz+ikWl33xhpqs1DELrAiCQdK8LXSAa5IE91AQk4eoA2MK6XwvgKx8R/ecjpbzvyFmuQAkj9qshrZeRXdbopNz/+TUnJxwVet4N+o+ZmAsYwcx2Q1Rmiwe5V5375E52R5U3AvnJtC8fIK+85e5J4D5AB/0lI5wbMyQg+89lK9OmEWGL4pP63TuEaNZQPUxb7wbevU2Anf05M3tCH/39nbraFVjXiKthJlrxeXnwKM52VB8nmkH4yHGcSKy/3WSfcHGCP4u9uC2m6Wi5H7ko+drXh/4qq8WCqiduz2Qe27t27/VICGQC9MhengamunrNCfpykrHvrAYE9oWLwIVX+wjY/jb2z+NOtc1tUuDUC/b1r5KsNuAk2TQIuDSInoGrDawcJ2ILb/lRMrGrPGjs/AA9kJBKcFrAsPYIhRgayIMiSpr/yK2+GeMk6vB/7OWAKKA7Ps1H849QTaa/NGO0AMnWrKHgzgchTcXBwIU2w3SB+6kjn9k6I+yjpB/rFxtcqlbxCcQjgL7nMQjAlfu4X+sy5G9SNLNABIfbpBl6sSBgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c280286-af63-45cc-1575-08ddc0853055
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:14:03.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Te5RU6pMy2tK6AxSaGPsukKGCSyeLxS3ucVrd8/M4ZNj4TdbLn4J/OvzbkUf470E9edqogF0ZcJ9gCgux6m9uDEKhXUvn6mymn9Kl4JiAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507110100
X-Authority-Analysis: v=2.4 cv=BePY0qt2 c=1 sm=1 tr=0 ts=68711c2e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKt1_be61vWu12dQlMwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: EaUcp7eJXX-DnwdK3nYWORv9ClYtRXEM
X-Proofpoint-ORIG-GUID: EaUcp7eJXX-DnwdK3nYWORv9ClYtRXEM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwMCBTYWx0ZWRfXykYvOktN9YrU k8jwF8P4iFXfiKkUxvq472W0dnrBNxgej1mMsROeNC0AzVfqnWwVDVjHHMiC/3jg3PQR8wpXrw3 gHFo/8PK80+5IgOc+ZTLPMV9r9eLna1Z7fynB9MbaXgrDJ5nNRq88JmEBZaQCkXPsXZKpAT/Doo
 8BrpuxY6xwDbqteGBVRxpAcmAr7hUYjgCgHMjwt8M+unnw88tmQ1/4rE6qV3xdyP7b2z793x0jx gsmf/QT3mO8GM2lxeQBtccBKa00BsK4mWtW/k471T3zlY255cmwkuBd3QCRs+TJ5Tx/lsEWSQs1 eqgtCBkKEeYF2hDG0NVBVl3oUXIorg4CTEjKW6dYWRWeVg6AwnIfW0PqOOSDVtWUe4b1wn6QJzF
 eRrowRB933lJ9+QcQ//gr0RhP95nHeyjaxdGErAGCJV7QcIVUTvj8IwqLaE1ediv2Ko4JtC8

Hi Andrew,

Just a quick fix-patch here to address some nits! :)

Thanks, Lorenzo

----8<----
From 3656941531c0fb796f5a8ca7664832e58d468607 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 11 Jul 2025 15:06:06 +0100
Subject: [PATCH] mm/mremap: address review comments

Make seen_vma a local variable, and add a comment when vmi_needs_reset is
set to explain what it's for.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 59f49de0f84e..142dc5287d8a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -69,7 +69,6 @@ struct vma_remap_struct {
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
-	bool seen_vma;			/* Is >1 VMA being moved? */
 	bool vmi_needs_reset;		/* Was the VMA iterator invalidated? */
 };

@@ -1190,6 +1189,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	/* By merging, we may have invalidated any iterator in use. */
 	if (vma != vrm->vma)
 		vrm->vmi_needs_reset = true;

@@ -1807,10 +1807,10 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 	unsigned long start = vrm->addr;
 	unsigned long end = vrm->addr + vrm->old_len;
 	unsigned long new_addr = vrm->new_addr;
+	bool allowed = true, seen_vma = false;
 	unsigned long target_addr = new_addr;
 	unsigned long res = -EFAULT;
 	unsigned long last_end;
-	bool allowed = true;
 	VMA_ITERATOR(vmi, current->mm, start);

 	/*
@@ -1828,7 +1828,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 			return -EFAULT;

 		/* No gap permitted at the start of the range. */
-		if (!vrm->seen_vma && start < vma->vm_start)
+		if (!seen_vma && start < vma->vm_start)
 			return -EFAULT;

 		/*
@@ -1846,7 +1846,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		 *
 		 * So we map B' at A'->vm_end + X, and C' at B'->vm_end + Y.
 		 */
-		offset = vrm->seen_vma ? vma->vm_start - last_end : 0;
+		offset = seen_vma ? vma->vm_start - last_end : 0;
 		last_end = vma->vm_end;

 		vrm->vma = vma;
@@ -1855,7 +1855,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len = len;

 		allowed = vma_multi_allowed(vma);
-		if (vrm->seen_vma && !allowed)
+		if (seen_vma && !allowed)
 			return -EFAULT;

 		res_vma = check_prep_vma(vrm);
@@ -1864,7 +1864,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 		if (IS_ERR_VALUE(res_vma))
 			return res_vma;

-		if (!vrm->seen_vma) {
+		if (!seen_vma) {
 			VM_WARN_ON_ONCE(allowed && res_vma != new_addr);
 			res = res_vma;
 		}
@@ -1878,7 +1878,7 @@ static unsigned long remap_move(struct vma_remap_struct *vrm)
 			vma_iter_reset(&vmi);
 			vrm->vmi_needs_reset = false;
 		}
-		vrm->seen_vma = true;
+		seen_vma = true;
 		target_addr = res_vma + vrm->new_len;
 	}

--
2.50.0

