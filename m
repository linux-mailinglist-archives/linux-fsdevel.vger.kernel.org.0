Return-Path: <linux-fsdevel+bounces-59096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEDFB34679
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28C52A4736
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C02FF655;
	Mon, 25 Aug 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UsqofrG3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+p3dpA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E12FE065;
	Mon, 25 Aug 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137459; cv=fail; b=Yw4s2Vnxk21VxMSFCgWbkH6r4G5PsT1FRlbGuAPBxro2B75v/wkj7fW84KJ9pRVCVQcgofaB8x8n3qfCq7PeOEXc66oIgTOglDUex5Ljd4v3pdPPkDWeF8MN5elAkurky+4FF8i4xtJTWXwGRY8wIJ2F81RFz6uh7c9h6qfK+zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137459; c=relaxed/simple;
	bh=VeMQsSBMdHub7kTYU8vUr0XwLu0lG9oDwQIJ7nMNxIE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Gz/EexnNOfxmusllfF8GC6RlbMcBl85Aq874VhF8AHufAETx03a5W9q8eFF4p1i7Xn8Q6lqY8fetarlCdLmC+1me5fHUukcU2POxj5sAlph5si641nbSB5+oDgA3t6ub/oSVJOwTD5LLTEICwCVKV1TPLiuEQR3YDP/so5tAYNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UsqofrG3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+p3dpA+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFfsMe022300;
	Mon, 25 Aug 2025 15:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QEnpKb9gPvGg/M20em
	co49m+J5fWEFuwEeAJuNhlFCI=; b=UsqofrG3J0/6le/8GRYmR1obj12A1x3ShS
	IlqBnA2B1qyRVGUCCA1rHVdZI9BmB42IeELXHYmWiJcJJ9SfkuNlHlK6cF23oVVK
	vzCPxGpOZZLnTO6/UNU/OxHAESkV8txvN2C9WviJngt78tbVxRXeCmDD7hiiwKsc
	VTaWKFwyr7xEFljetLM9VD3EH/lTnCQ6jCB2IxlXrkoBuYpU7GErmxJylIpOXuzF
	6kAHXfonZQWAIv4Pg/+HzOwqWLLCrovE+ENYOnNHonM8Fc/Y2UWQFlCRdeAQ/r+y
	8LTgU78AIyI2j459BK5CLMxHBBOzfkcx674/i7ryAWsJS/AQHwng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8tw9d28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 15:56:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PF2fNg005292;
	Mon, 25 Aug 2025 15:56:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj88n5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 15:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7yKbE6lzGyc6KWKNHbAS8XYgcEruds9zyFMWMl12HAvMYT9W4pJ/TJHdVnyWIfNDCuwRIN5244wIpmtZp9NpAJPgUjsYp2cdD+kKOrzYd4TwIpMQv9WV9jYKeiKcZbOCLrFSM+gZ9EGCcnMyrXUNJnLSiDyHfhrA6WZsD4MTqzPyrCx9cQl4z6dqxcqNySUVdagI9sBLXBrVdOBE4v9FNT64qcqsizVFS6LJI9fnsAsDqIrPcSIw/UReGeuxkc+p/DnTPbYXKXI25qdegAKcvy8CQDYfEffvN0+IUtZshbNHnIa6EnMdPD8lgST+olquFghg5KcSgK7eu0POJoN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEnpKb9gPvGg/M20emco49m+J5fWEFuwEeAJuNhlFCI=;
 b=t102XB/nN0vVYpyt1EZlzFbQb0bkZiqKk6ypSwQMyfZD85NhtvO70p1kiTs/yKezRr+6quxkghUGCOe3DAOqnG3o2+FzBEEPdRkXfcEjgAbVv8EwRFACYnqIeWUwXEUSIDOPZkf/zKHRbhO6u06bOl3tU6RSLuFSSpWpIIOGBhsaKVbCBsUVzVWwPE4E88hrMYLzGXOYHx3zOrZiMAu7j41+sr7fJnzcM6zqfL80+ymTf30tftAYgpr9tHxO/LTXa8oWuMioTfE4xP5IdSJ7rNxIBaPzyKm8IT2PZvL2Z4dkD7CGXhhixnxxPci6FLMi6qmLG0XDTjBdHlEzRmin2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEnpKb9gPvGg/M20emco49m+J5fWEFuwEeAJuNhlFCI=;
 b=e+p3dpA+/ARoe+8TgybhiN88puFz0VeWwO5gknaWb0wQSfYihcy7C/1uvjNv3rm5GlSlamVhCyRJ4Yyv9K9MIG7mqo8ErgQrST1MbTeOr/z4zXYC3+Wg0dKV6xG40AojLjQS7KczHKRVUi9s6qaGZrd3nvT8dx1REZ+JyNTUahg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 15:56:49 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 25 Aug 2025
 15:56:48 +0000
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <dm-devel@lists.linux.dev>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <tytso@mit.edu>, <djwong@kernel.org>,
        <bmarzins@redhat.com>, <chaitanyak@nvidia.com>,
        <shinichiro.kawasaki@wdc.com>, <brauner@kernel.org>,
        <martin.petersen@oracle.com>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>,
        <yangerkun@huawei.com>
Subject: Re: [PATCH util-linux v3] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250820085632.1879239-1-yi.zhang@huaweicloud.com> (Zhang Yi's
	message of "Wed, 20 Aug 2025 16:56:32 +0800")
Organization: Oracle Corporation
Message-ID: <yq15xebs8cw.fsf@ca-mkp.ca.oracle.com>
References: <20250820085632.1879239-1-yi.zhang@huaweicloud.com>
Date: Mon, 25 Aug 2025 11:56:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b5f58b-b65d-4463-bdb1-08dde3efffb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbVEk1ntuIsCe3F6tIwPRoMzIs0lvC9WfxJUlQzg9lstVFa+dM97mwR3EQTw?=
 =?us-ascii?Q?Arrl0AOD45KSSJEwmirhZh1Z41MbFMi1WLNxm3bdtcaZWqxR1iNkjEtIY1Ct?=
 =?us-ascii?Q?aJ3yE3hVV7aC1agtSVwi0W0ISWW1nsz+lSG5R98hFmrW449y9hIjGgxgLXzw?=
 =?us-ascii?Q?X6YOVP+HkX4hfCvjuEHz5P4ak7Bb3U0sWWKXYaiWRS/W7lzrz7JDUZy0r5bA?=
 =?us-ascii?Q?9mMgOipycnT0hi0ipEM7yxngp6xH5aVP3dBnYP9KE5OPtbBWUSv5QoIObfIl?=
 =?us-ascii?Q?cgtjNyvOYuExLzEBF3U/n02AUwPIE2u99/F8HGQaEK6pukF0fjWf3hMJYv9/?=
 =?us-ascii?Q?ognNBjANdOld23ItqUWMQdtlfdMjs56mCSf1jQ9VGiZH0NvRZjKJmyDA6hx+?=
 =?us-ascii?Q?ZzHMIJ//ZpkJvsx7ewSl/RNsTqkUDpRtLUE1xp6mVvCWH7Qbr7zcXzn74Oty?=
 =?us-ascii?Q?C5BYb2l9ixao6gfHxxs0M7P+Oxccv++caP4RlgLo/JW4x83uVsAQAyifC/NR?=
 =?us-ascii?Q?17AHnqGdXmP72XR5v772fGClBk9MBxQHDCx4pl4KowmoRKrn8uQTFQOoF8Ry?=
 =?us-ascii?Q?xUkwhyRg7XlgLiEIf3gxJm32dMuWK6GgVxWFtdLJesnPP+/GAzYxNPP7ELMo?=
 =?us-ascii?Q?L6PB+Lt9IDF9FLvC6p2n6KaFfCkMtoi8dNKQHjPkbTbWRL1FQGSL3H1HTtXd?=
 =?us-ascii?Q?Wm5jeilxUbmezcNepcYGdCDYT66K6tVX0oA2IIq9b5W/7yX0/fUKWngLS0y+?=
 =?us-ascii?Q?VO1rgXdewW56t6NuN2fgKZM3Sus3dlLlEZF40a6OE5dTYzaDZNdCLbbIVkdj?=
 =?us-ascii?Q?yDIAQnVrkygS2A/C+jDknFAspIJ0SCi7rH0Pt/04w2CeRCY3LET/NKlNgf0e?=
 =?us-ascii?Q?rDOFiD9KVUjMc1eCwYwchM89Gqvw3sHZ3OJcd1JKenRxPlct/J3cguq203J3?=
 =?us-ascii?Q?+IiAZLR+vDF8xqqSX8FC2v6ZWfkvcUOjzDtzBgvm5oJ1YWgXwnt2k43WrlQY?=
 =?us-ascii?Q?WpXoscsPbw0b7tRu89hkEE0qelFko+Cs/PeqvsyLvELQviGGekqPR/fYwb5C?=
 =?us-ascii?Q?2iPDUMXraff8tUvcIk+Q1Auc0buAYWTn8PdfPLS//1DfbX0UKiNWnQPnpTnd?=
 =?us-ascii?Q?1RzQJZtdIarSTeXj1/gnjPrMSHdUXduJSvuIQDnJOY9RaQxes2WrJtk2sxWF?=
 =?us-ascii?Q?7HPf3ydrAsDffUzU9vSfvVtj/DigF2mwI0PdqPGFXRnM3Vae9QK5iBK7hXqO?=
 =?us-ascii?Q?eh1VF3TpeLEz64J1NbDJIMmTT5BSCsvMjVqFMPRCyVvcdMmGE/v56fgGJ85H?=
 =?us-ascii?Q?SMWqr3Tg5L9m5yPmlWYHQYR9VwvSZCRGLc4223VjntcCnXAMV5K41sy6dabs?=
 =?us-ascii?Q?a8o9uEzZhxaf/2+JtxyqY2G9LQHfxvf3Sy0EHx/ogDaP5oSDiKjhuFR9zTmT?=
 =?us-ascii?Q?R+LqLJFY0Io=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f53Wys42HscvLt1mHMJtNBhjqdlTOTt5VuiOEQq9lrQYRCk0mgGxyRoHbCrD?=
 =?us-ascii?Q?eFtIM7fMsDad5KYMRhN7qWdkObVYbu2TjqBwLM2+Y/xubNM9vYwQKP9gPUMg?=
 =?us-ascii?Q?yqEFaA6JRS1q6uMMHaOyyuT1JHnQF4HEikaVbtefwM5eRDvgoFf8yR0HJrVB?=
 =?us-ascii?Q?CmCxZfNX6vuc7IUkMg4UPNam47eYIbOTvOsu7K3J5pJlvo1Jnla/FM9MG/Im?=
 =?us-ascii?Q?kY/HEO24646k1xNv5DO547QjlLIM1StwmE3Rni55N2BoUoPgyao0x6GQjKl9?=
 =?us-ascii?Q?Olt6qcsBcBwXIYYgxNHylWHuZOJ/qHN7y43IC47Jz8KaJVVXZMFvqGc/iyfU?=
 =?us-ascii?Q?UFJ3QaetOKiCT6ve8JUfUEF6KbWTZbnBz22B8mhwArMkgnCaoPe5Q2gPPdhu?=
 =?us-ascii?Q?mCUc5X84PRcz3nqFbmzlPDAsIPThkJtT6TuEzhq8JIXRYcVS5MCq2Tl52cLP?=
 =?us-ascii?Q?3qh+yLcS5J1ZGGJbDzUVeKqm4iB4lvky0GTc7n6Cd+xvK1Y2O9WhtV2yB79L?=
 =?us-ascii?Q?hJJ6RoNpe266Jo6ChWqJFneTCw9xaIPKJJQt3ztkYHtao9b3UpHCoSfIa/Wo?=
 =?us-ascii?Q?5WuIzSd8zwXfEA+3c6AI8LlNV/Ocx6/bwFK1eFKUnElgDq54nDv4nSOvLein?=
 =?us-ascii?Q?Wzi28Cjcn3pMLFSujGSnmwqmJoSPghV6UJS8gfIFnRJyOEMPa82Q2sySfmah?=
 =?us-ascii?Q?2AC/TH9DwrejLI2JP9aRqjFBVhS2EqLFcB/kEcthtPqxaLdqM8cy09zLgThX?=
 =?us-ascii?Q?xutZIW0WTRXC99cqnbEu7TL0cmG09/17Le/br3Sa69kSqxC5dhvWPpivFN/O?=
 =?us-ascii?Q?ZBbT6RwiYv6tE8omCR/h6JoBhQPaCy7b2x9GRUUl1WjEgesshGxe2I6XJCcW?=
 =?us-ascii?Q?8A/J2wSDyK3hUAdZMrg3nbg3YOuDQpKQEGpixheNAvaeDtwedlnwSCONGz6C?=
 =?us-ascii?Q?xqLgHG0bEwhxIbkcimFCab00+UJLkiHIubsi+a7o73m0HfcfNz64ad2ugY7W?=
 =?us-ascii?Q?Ju1IeHRu2/pXorjDR+wAtiRy0eqV/qOZfc0ITc8mGXmqta4LGx4SyWS1jjlQ?=
 =?us-ascii?Q?2FwOL1yMXotvkYlPX49GfB+szf/NtR7zgnIkKE3QFqOB6qIY2zO29z8AFsHi?=
 =?us-ascii?Q?I3WV5vAed4ID7DYiom+3RlRbpZNUW5x9TMwQyfeCrypNJUfpjNitMZcrhCeg?=
 =?us-ascii?Q?3FmIm7gBZI1QpYesE+OlaicmKrFnVcbvaeQVfbjg0lkXseGLgmUI9NB6L11J?=
 =?us-ascii?Q?cIFQnLN1DnE/B7HXfmeL7ZaM7A/lutlkw7Dkplmtttl4B5PLA9ZEF5QoLY1B?=
 =?us-ascii?Q?4vJSFHFniwci054FqBiQlfBy/gp8i6P9q8ANOyOALqcbqL2zNQCOm45GhpYH?=
 =?us-ascii?Q?qOJMB8wm3DytCHR99VeWqb+VNnCRP0wxRV3LIFyvK7xyg/uLQkntW/E31h1x?=
 =?us-ascii?Q?HJwZj0hUh0r5U0fKmkQdYLalb9EKUBxDrU9VVH3a4ZqWAkfqu23bdyy7nxWW?=
 =?us-ascii?Q?g6/wmyT+h/A1nzHIQvO7EeMedLgqqwKPmxgn4BI93CmDbCIcoVM1W8w9MbyD?=
 =?us-ascii?Q?NEeO938HU2cmxSZaVNNfxSNM9M0Q4x7yS85Jp3KqpUg6HBA0TTt7M2UT7CWI?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NxQaYyQvsihAkzVulauKYoDyb3T/xHL4Em/VLkuP9fnT8mecwyhp7df113xcYGGe7dX1gtVgrqsE/1+i5MQIpK6feNiyOgtVPXZR8i55FW7BxpR6VY9+7OzGQRAzEAhpMV5UjCoBjUAoZlR/+7BuIUy9E0BLOWVA1BHjB/UTa/zV/yUmCloHcLt5Bvs0jMRlxSWQ7jmX0fCKFXjHw9zmC3D7zR8OLbN7kp4IlbsHfsM3bTbWRGC5DGluiFfUa8vSqAnugUCbavQhvI19BgLEAHR8ttYm1Yb0ZBu3+Q8Nh9UJKC1g/QcS5/M7dWSUX3vo4/sgh0lzlsCVhITovCAF1A/9mPiTy3hmG6XKRxM8+VvDC5OGdtUPE+PB0g2/hFvt1e9G5OGxGQa4HGSGaIaak47TlLtupINwiFaUT4seimFpyLAyLNsNzzPdTOAYCKk8PFJOhRnxqPJGKF2kb/Yw2Yxvr3TcuNJLfDaUwiN754/MNSylPxL0z5L8upM//g6SbJEvvnOE8WvHGfJw+Y2UXH1EYD3AGvCIIrIivNXNa88CL1SiKdOaQ1KeKmneAQ/7T6SIeUhd0Gg9+ijIIqzNI2isknrzWBd7CxSwfupH8jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b5f58b-b65d-4463-bdb1-08dde3efffb4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:56:48.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSQty5ayOXTBS5qoElMqgOGg2ysC7gFHiqlXasB3OfASWKEHen2Vmgxy/sDgS3yjmc5GMpQD5WQ8luTK5HqTwZO2Z/+pRJvELApnSz8Dl+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250144
X-Proofpoint-ORIG-GUID: I-s5JqqW0lIoXKPWwyLZAb-HbJYcfdG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX8wTYTxJenZGZ
 aqrxVRpDGlzuc1hJk2vIL++o0cdmby9UGbmcSrr/shqGn+oe6+Q1reAq+sA0ZPo9VmdihSuzy6t
 xBnAoEEElgdqJepFKcfAD9CAR/nC9uqcWRW8h/s0qor9Cjuo9xCAWs/lS92ymmHSuSB90NZcVAr
 knXOWBtOsEJFKJSk8sobeuse62eULB4dqhsqo0LRlrqPvyTgtIfeEdBQpN7CJtoVGj77Ctn8l/Q
 CNXd5mHDwSqOowIoQNFylNeecbY3I1w/N0pUNb1e+6Iw7RC83kLnO6L9Rm0y/nd2gmd5ovTz8lb
 0aW+endR4rORxr6ii9Tqn1QX4QlQ6dD0bU9SeEZW5GDyiRX5WnBHS6YXXfpQcGBfGnTVcl5t1RE
 oS7VCqcIvpA852C693C6CIrw6q9aNA==
X-Proofpoint-GUID: I-s5JqqW0lIoXKPWwyLZAb-HbJYcfdG0
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68ac87c5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oMu4CXH3tChyjeE4K0sA:9 a=MTAcVbZMd_8A:10
 cc=ntf awl=host:12069


Zhang,

> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES
> in fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the
> fallocate utility by introducing a new option -w|--write-zeroes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

