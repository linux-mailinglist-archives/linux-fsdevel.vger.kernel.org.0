Return-Path: <linux-fsdevel+bounces-51995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA1ADE0D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 03:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411EA17B091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DF19755B;
	Wed, 18 Jun 2025 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYK+eJyN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MQCqQoWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AD2F530D;
	Wed, 18 Jun 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750211356; cv=fail; b=DXhcF8ErB0UOwm6bVGBiKJ3xVwKWU1dfnrv/511fkaLV4teJ4pfmsEcCrkt1cD5uY08/MwFhJWFcnRX56c+EZVJ43TP+sRdc+lTOT4NlEQIARaJCR7tEK6D7PCdvZPAN/IGEFUisUdWcKQ3If5NmXmhO3kQIPYhxe/455VgUdAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750211356; c=relaxed/simple;
	bh=D9Uew9PDXwt9NAIgnCy2xuq/0py/boq3+wkiyb8gf/g=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=I2xfEuQAqalDuKr+nOv0NSKk/fKkWhRAHbaD9JR+0lpg3Ox03v56+ligtVeGcH9AVgYTjgP3YdCM6pclNqF9sQYXW4cqxtcsGqtwT98rOpIB2EYrZtspEQuetRP0GwBesy5RN4plicHqTaY2MPHO1sTSxe8VWUaWgOL3WUjaUS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYK+eJyN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MQCqQoWe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HLSwjv001282;
	Wed, 18 Jun 2025 01:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=l3QA4dklbFG0vz6arf
	3f4CrnaIOOZpcueD1G/KZaSBU=; b=ZYK+eJyNDfMeXWqsRsxJEO+pklR3QZOez1
	YrdmBiiu6jwqVCtyPmUizFcHb5aepXIFK9efDUBi+rRnZIgaA/s+zH63zTUsI+FN
	evJcU2X7nD4UXqIv3RVDmjcNOF7Qeh3/C58YsItUrH8/juhknB28jlvJjXG9nzM0
	dHvl8wWJIi9xTzbGiyNBMBTZYAIoiMAmJtsJG58Ayr5PJHsg/x1wdgEBaQr0Ii/M
	sueF/0yzkDNiZnUV6mAFGcLWXoSHsPUeJFGt61Mzg4rkk9PipC3FzeXI6xa7UMcM
	ci4KmakmP3Sk7fDbedo355mazZmwHPwuTOHG6uHMqnE8OEa1voSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd6s9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 01:48:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I1QOxA036275;
	Wed, 18 Jun 2025 01:48:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhghdcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 01:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAUq3oZu6eShT8cA3YNba5dcNZRN5mFdqBiDmy8biP52OeovKFf9mzIKV8gnbBdazvjC6t5LAsFEefj4qSJ5vHHXBcM4gRxLWEfiBPfDF4e8MPsixBEy/025o4DhBXieK2f1Z4s8+KOy9/0MDUBt259gU5Aj3/LVwLUOiuSar5ou0C/rGRM2aJCpMHWsyjHcFJDM8fgR5KkLKWk/RC8wABKyrTxExsQ6iGFaeNzInsXYm9GN7EEOFque3XvIAdfB9IgikjTDmmZ0TveBbWv/fhi7G93R09hVE+xjVSHSKRj4cRuvSFMcW1BAn9ejQJvaEgudLNgIVgInhyz7PuO16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3QA4dklbFG0vz6arf3f4CrnaIOOZpcueD1G/KZaSBU=;
 b=rfIYd12KvrCtyUz4f/y4AOf+OTBFly0hwmh7dG1fH0CW1x0TMXJpMVJY8lv7ikmVSqz6wz3zsju5oI7EpHR41HLB/AZH5clzKSqn/q7QBNDeohgd5hAqm0ng1YxSEIpfsalxko21W/02W01po96tc2xVFhZeX1QhnEJWiAk8cBSuDtvabFgvy57NZ7FOuEnSHiVVFNZDePnCYJLfZmo52UBavIec1jqRDDFPY3bsq5P18Ef7kxKEzTeA1a+qrTrNF5pT38L5dGNqdyQbmtt0hrAnus2LxxRfBcd8qSPPI+Vr5pChI1rXfFBI6yxPIitKx4GIm0jAqucmxnJ2SiiUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3QA4dklbFG0vz6arf3f4CrnaIOOZpcueD1G/KZaSBU=;
 b=MQCqQoWedZwCrcrhFsJWIj3bN1x77ql0/Q8aeFkDHyPLhBexI+GHK8p0z9QFRvzRGHu5ywlGhN+emgpQ2lO1e2GDi+laVTNpWAVTRezD0XJFE3/a7Zb95SweC/Wi6HMx4aEDgHVKaRKlu3j2+Q0GTyLdmPnAjR5ModbHyoa7GF4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA6PR10MB8039.namprd10.prod.outlook.com (2603:10b6:806:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 01:48:52 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 01:48:52 +0000
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@pankajraghav.com>
Subject: Re: [PATCH] fs/buffer: fix comments to reflect logical block size
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250617115138.101795-1-p.raghav@samsung.com> (Pankaj Raghav's
	message of "Tue, 17 Jun 2025 13:51:38 +0200")
Organization: Oracle Corporation
Message-ID: <yq1msa5x218.fsf@ca-mkp.ca.oracle.com>
References: <20250617115138.101795-1-p.raghav@samsung.com>
Date: Tue, 17 Jun 2025 21:48:50 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0334.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::9) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA6PR10MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b1083e-9d0d-4638-68e4-08ddae0a46b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ctnra7QeVGKpmH3X8q0cj4kNik/MNhoo1PIamTysG3yHvlMG7dVxGIjE9OBn?=
 =?us-ascii?Q?GQZEoITwN5y5vBqLRFGm9Mj0BvVn53kXBx4l0K/fwld9kPwGFo6lb+YXYtqm?=
 =?us-ascii?Q?Qtg42mryqrAM8H1XjeCO02OvGPyfTFQIWovG5DAk/ttXw1XjmqHrPlIag+TW?=
 =?us-ascii?Q?Pk5NZODj0CMI/JLm6OtMHJn2YPV1uQJfvcbvwS4eoSfSWV/3bx7jnuwmj/eW?=
 =?us-ascii?Q?PmANhfT692pqUbs8gQULUzjd7/o3UO/J9PeODUUc+XCJhyMYWh5dO1upBpZy?=
 =?us-ascii?Q?FVwmtH16J876IWwRKocRys+jhT7OG9md8KR9F2Fz1OI3TCjE7Kw47E09Rkvm?=
 =?us-ascii?Q?G+OGj+ivBzLTIU0UQoOsfsaGNbgIqgKveg2pGx3HmvoHL5Rek2AhCLXm1Yya?=
 =?us-ascii?Q?3eAwiHpPiISgFKFHhzwauIABxzoDQxVFLVYbxvUEMeoQgUoE6Y2NvQZTuK2W?=
 =?us-ascii?Q?Qi5i0qmEg7rnwuVEB7j+NKPdMRW2b0Rw/meMEO2OaWnNV7hg0KqQ3vOPXQPy?=
 =?us-ascii?Q?TICH2cLsuv4MJrAO3CFHfQ0MGqj8SGhuGw70+I2FG5cA6xEu+GKKWvdNbtsN?=
 =?us-ascii?Q?h83U+3KwAQhkKLQlQvBl/WLQroGZdtVQpJW8Ut+/u0a3Xnx6MfjABVjUs7tx?=
 =?us-ascii?Q?VJ3KuDAURte8//Edzie8qXGYQ0j2Z/Yprpbd58yJavwTYUgY/cp6TIb8lO1B?=
 =?us-ascii?Q?jc+0S/Y/wX/1Gvp+OPU9pmSXiz/jkPRk/1w++Birvg422qGyAmDxa/16wFv0?=
 =?us-ascii?Q?9knO8QvwzgbMS5C6DC9yOoqYbRq4TIPGWfSsFL7VHGvaVE+UXWF0S+peqNvY?=
 =?us-ascii?Q?GrvtmSOOutHeXGsItqFThj0DjL0VofJIeolVYkpqrD+x2p41FksoWr1sONB6?=
 =?us-ascii?Q?bdBfvIlcBYX5wzgNOshzVpM+yxSTlyZulUbvC0ufyPurtdJJsQ92GwBMZIXg?=
 =?us-ascii?Q?PpFt3T5wNbdOl++lHrryA+vvY/dVTeFL3D0xD6hGAtLkuEgj1KZnTQavdse7?=
 =?us-ascii?Q?NF6k78JFejOBkrBi7Y0UHOp8L14sX75rMQAT0H0sRueDMY9aQZwIRUL8th5C?=
 =?us-ascii?Q?KQ46BgyQaOkr3JQyzK62nlXxnONF6Wlua1fcW0OHNBOdHMC0yoqCc5bTU/9L?=
 =?us-ascii?Q?nFPXKrZjax69NARAHB3j/grVkusomqKT8RtVf9tUcQ7mCrvriuktzDoBlNbo?=
 =?us-ascii?Q?ZaDq5Kz3iZsTh4PrXFilM6oo2WzzyzMpkKWhXG0Yn2GgXJHk2nXqgBYap+j/?=
 =?us-ascii?Q?lZvoxbG+wbRdN+ZHJZm3ugCCuQlHe+SkvyVGHomMSBby26WbGXKd+j1ode1K?=
 =?us-ascii?Q?WKYuUPNk3RGtuTzvr7DJx0VBccZBhpIo/QamWNCPpqVMDzBllugCpXoXkzqw?=
 =?us-ascii?Q?J8CAB+F/A8Nzc2dovwn6U47aPKDwQh/BGPJbrn0IIqoJDb7q4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GJ9FUxq5WxZcoioMLEfdlPyhQNZ1NULdbWJTOTtVwCp+r1dmcueT1jU+ef1D?=
 =?us-ascii?Q?SLDrFRHqoOG+ksB15whwPzD8vL5QJuCMAbAOX9+UxNvNdc/iIGXpG25xuenJ?=
 =?us-ascii?Q?mFM39jOYhz/Hj3KjgUla2Ndq0oOLRX5BvTSvjiToa2gcANeavniwDs1gRm7E?=
 =?us-ascii?Q?jMHHyc2WaA2Xvkq/EtUHZ1kn/al5ndWRV1TY6THhYe3QrjlgfE82MpcbLIJJ?=
 =?us-ascii?Q?J4s9I8aLmu0wWwDI+fALr+HTtQpjPjYi5RC+2KWl9Qxwe6t0BgcdM9X0Y/6H?=
 =?us-ascii?Q?X/lY70lymM5Iqz5/hRQOSS2wztAPGr9iThsvNWS8Cgxg8pxCD0k8DvprB+Hv?=
 =?us-ascii?Q?uaff1IUEHN5gmDs6N6YtrjoJHNJu7MA+WHjbTP8nHrESAt+M1jj8ysEjw1mK?=
 =?us-ascii?Q?sbmxZPQHRgA/ofzhUk1d1IurlN/qhgAA/XRk7OYEw/YpgIZ923/wknxMRBZ3?=
 =?us-ascii?Q?uZzHP7Ato5Fi98NlGuvWOav9rQFJI8KsO2J6X3O6frHkAVIljrCzSWBPwXMw?=
 =?us-ascii?Q?SOFTCnnhwrXRGI0f9H+LNU63XT3GcRKhuw/NtEONvMwF/9OZ1AwVM965Ge79?=
 =?us-ascii?Q?7jNvCvlGUINz+yAEjVQeEfhFt+37C64utcw6u7b4OakXeeHVZ/prw+qrCE4l?=
 =?us-ascii?Q?HZ0iTGn547g1qDtoEK159xrQhYDiBj5fqcOTphpxnl/P22IxriktQZHPzpdK?=
 =?us-ascii?Q?l9ivrNB5dIvSooYwGsE7989EgsdJFL1A4HA44W/cPI0kAqatrxH1KgbFaZq6?=
 =?us-ascii?Q?PPHfSvVQStoc3Rva1MxIgYq2DdPksAQxNj/isFpBdb4aPvwyjbZCPkj7qbn/?=
 =?us-ascii?Q?4M8DLDGMLon7czXxnxyycHEu+eDj1+lvo88HmniR1bIrOsZRMsuJQlOWYVL/?=
 =?us-ascii?Q?oU5GWaZVUKGIU6bmN+2sgFsODYiu+TicwNSBe2GWXIzdIVT620IKSSkr1Fi2?=
 =?us-ascii?Q?bpcCUBwjj/EPf740Fy8nnBFPwpb9JXshBkCsowsMg5KLkMkgzsjZszgeUpbe?=
 =?us-ascii?Q?fmzxbSa/QDAgWdtEl3UvPcPDLzUKpM101hf2oI4CunODzy+tjSghzXScfu2d?=
 =?us-ascii?Q?+cvzxs5DmMA+KibjljZ6pgKSfbc8OSlxeJ4AgspLsUDsI8L3qLyNWhnM9Avr?=
 =?us-ascii?Q?b9FFO9weTK+g6OAEHtmL0OTiy1aObDeBKg7iI1wgYK0zA/uArlK2BJNBLC4w?=
 =?us-ascii?Q?3991sLX0hwFArEv1CeLNnOK9lF1MeMIefYDqcDoqG7s78MwtYzall6+znBGj?=
 =?us-ascii?Q?RPuUV18SVACk8OFkm0OomB427Ft9+GjxHEzlhYH9vS/7Szv7Opo1yRlb3ixr?=
 =?us-ascii?Q?2m+Qg76pfg97fCUAjLznms0+oOknd+WFElA/Fan8UakLCWKaT/WdehK8oHQX?=
 =?us-ascii?Q?fJp+DVRwPqQSGCr6Xy7vcekvLf+1CoseH4rRdMD4ZYkvkTVCw/bdYVVCnj8N?=
 =?us-ascii?Q?mbP/lSQHdTNUwdOxt9M38gOQs1GUMDNro2PjG/GMw9p/rwiDPsWnDS795boh?=
 =?us-ascii?Q?Ps2RHtTPhAOLbs8C4LvjbV00fFH9qCSCJy8zwQ1L/1dLTKYCCFAcCMTHtaJ7?=
 =?us-ascii?Q?81d8D+5xiU1e5xJ+oUzMjTBzzz1ERDFLb0OOsvRN+KF7Wnr3eFS27VXyECBb?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8uEiVKV2M+neg+C+oxM9NcCuy9H3NgBdelN4NJYU/sNwODbg4Mxeg5yK07fVLoZHQBeyhXMQyfs8ELXXoXl7w8Yap/JC24gckss68ntM/TbxtwjG1KMaB07ShHJbzb1BfiApw+jG8OCjEiyuraiNKB+yDj0uaeP4NoHIaJbKn11HjZDPcbndc4xlhmIN5EIOel3x+9NWwi4n2SD76qJeE5uZVvMj+a5PYlj1R6c10lUgtW+/QIytML7hENO4FCwa0aphaQ2zuPJtSB/kI2wan+DO65N9WGxJ2WR0aLneKk9ytfbQtTxVfLnMXFF2XmAM86bYAUYj39QcgF6xspVUTNQCB/XsggwFIGXU4S8H908akbq3hozDny98lgId/+PkShnbzL17M3sVyn8jc9P1Edxd185UCXsmjFoBpSXUSfsktFo/JSfoiIO903O04EAZyn4cPEtcDx6OP1OKfIvBUyAhclbSJLUKi8g5aCigfc0fZ+v7fL9iX52vfwG51P/1cfQL8TlMjoMdb3R9g0Q1FkGyGwaGiqFImz4RptnZt9zunUk1uOhh3shVbf4oIqtyYwh4cL2I4HxEpmyh9HxIJzPWDnSJ1dub6J8zI/qNK+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b1083e-9d0d-4638-68e4-08ddae0a46b1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 01:48:51.9127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpinaiABHY0dowTc1mNrvLN/4LORkqVShya+YxirWYfpLLe4WDqQgiiMcIZOtvUdEb5qpmoSx+iZRvyH/n++jD3jsPc9GSR2IoMi39KSUnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180014
X-Proofpoint-GUID: YLX9Kj4U1qb5vO3XEJHDVnvLD9oqL30V
X-Proofpoint-ORIG-GUID: YLX9Kj4U1qb5vO3XEJHDVnvLD9oqL30V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDAxNCBTYWx0ZWRfXxXSunLaRDGM9 jiEw479Zfq1WtcIxI/dItu3GD7JsoKMjb5otrVVOWswtnW47zIU0szZRrlomHLoqLyDmvbBK2JM h/w3lqJQ4tbXpO4Z+LNeVSPa0kWtWdTWr7mIuMTytSIgdV1SVX22drfZE1WqvMloyCLcNeHm5TB
 3M3EPctJGR5EZhsOmEy8Y5FgdrT8BP3kHbm7Zz4GDEUDrWlNorPduyMl4BydHG+ux8INR86W56q 5gE4bfxFU4g2tQq9+gAHa5Vn6PfpzTYtWKaHhWl9IMP3CDRJEqnPl8rJhSt911kdaEoG7265gN4 +cqnQk7DyAhntGDRsJzsob1hlFKxP6/oMqTrhUY89MyLD72cEhGS5ujp45rJpOFzIfjtBVjJq2w
 VYN/rXJmxr+kTl7ZanV26kkZrD5PepU2zESes95IxWeT+23eQIDpxB/kb3KtV2UhHer8I5V+
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=68521b08 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=k09an1wQQ9CMLg0MnfAA:9 a=ZXulRonScM0A:10 cc=ntf awl=host:14714


Hi Pankaj!

> -	/* Size must be multiple of hard sectorsize */
> +	/* Size must be multiple of logical block size */
>  	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
>  			(size < 512 || size > PAGE_SIZE))) {
>  		printk(KERN_ERR "getblk(): invalid block size %d requested\n",

OK with me. However, maybe that comment should just go away? The code on
the following line articulates the constraint very clearly.

If you tweak things, please fix the spacing for "(bdev)-1".

Either way:

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

