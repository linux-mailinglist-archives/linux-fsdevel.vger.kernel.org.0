Return-Path: <linux-fsdevel+bounces-27873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793B4964999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBB1C228E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FDC1B1505;
	Thu, 29 Aug 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LB0l7mbV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OGiSkxKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4A1AE027;
	Thu, 29 Aug 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944457; cv=fail; b=h+OoM2bMZ/MVflsK4yhsRKlZdrTrf5yQv14R1Sq0nxLnCzGnRmHvtTf31AoOQ5ReDLoB84v71sMM39uS7B+VoDJi+CJjarG2dPj6u+73UAiM46/cFvsPScsnji1OYlglD0AZMaGhjBltcnV/BP5p94TYZt7t0OaAQQvIxUeHQxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944457; c=relaxed/simple;
	bh=GvLyWkrhc7Z54wAUJEGwFCU32hRfA43W5UIvieGq1cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WVGDclrRGVXOzJqX+0FwTqJXFmBJ8rknQke5dTberIOF4kZ9a3l14X9/YGfqmqRJcOdGj4BLJD3YQHrFJVc9h3pfDXrDZjXy6N2QKh/nms2ks5cWdXjbWXRDEcjq+28pXhaqiHnnGYaupVpf/aMP6nAJwPc7/D/ONiK7+F2iW4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LB0l7mbV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OGiSkxKj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T94NQC017332;
	Thu, 29 Aug 2024 15:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=XdqKUGnR6i1wb+Z
	WpkClLzJgk967L/6rEBg7Q9UBlJE=; b=LB0l7mbVtQH1U7HPEIrxMPqXHF55a1x
	92rqCzAdMPGQAemIJoLTwd10z+iJrs1AkLtdmQxfLapMcMR05N5QdIoZBPHFRfP1
	shOQ+5nJHaDBmKc5oufGdZvA8DtaWsuWvA9cKmphKb/HwSjSrLYfFZZN16m94E3X
	uhEjvf3rwwWSDdPtG2GQRx/iV+R/ro1QhleTDpPIO2o5+KUfClRjVRE5RsX9SkF8
	4/GuB3jIm+1NqdjGjquCldJbvZp1zIPKkzMJea3uJN82fl4lfkwT1Y35xfgDCfMl
	LoQr0lt81JKannnOT9Ek6osy855hZ1+dEMQ5Fi4nx5j9G+aYJuinajQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv4d76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:13:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TF3M6M034856;
	Thu, 29 Aug 2024 15:13:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw4k4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpSHcHZQxdPAgNOczKvkZbfsj4skgkIQpxUDTxX5tzUpx1PA85wUcG0SL2nNYhWI3gbNPXRidLkINNLqejHi/fk0OCdhkRs2uXdw8Wxl8JEen/DCmHjHjVbsBe0whPOFMYOd8rXoqQFetRvuiUHTqNsHikrWqHezJXuUbRXuQSwKf0wrvrRCjHOZTAHUz/TB+Tsb7mN01mD2ZNQ2xrho6WsxoA0bTnjT0odQE0UKZvMkn2X54N9pmrI/WpdTVN6pjCzrNjfuHN++0Z5kYXwf+RthlNgl2c4ws8uz2tjTaJIynTcTf2SihbhCYaaaWMtEtIKTms46qvE+hUAWw7cwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdqKUGnR6i1wb+ZWpkClLzJgk967L/6rEBg7Q9UBlJE=;
 b=iTceIiMJ3Sh5JmuZ5k2591/xUFvgENIA1EHg8KkuzHfIxVXYxkBGPDCsxA4uzIbSOyUsp4GHFAqQAyUkMczUpzDl86mkbtTVH3clG0xYQtX5KvYM6XZYHAvCsdSeKrreh+prX90cIHtdziliKyfr9clGpoorRnA996L7rA3P+6EKXHgQqxeHolvE8LCQtdlmAc6x9WKDiSxjnP65Qjc3Oes5JT+ybdxXA7EBia8w4/Y4+fqnLF3Tmhu5IJ+ZGl118iUxDlOOpr0Pip0TMah7yVKeILOP3qcW5SlWSzfYANZaxykJIQFg2QKEC/lsUu9N/rJtq0oqinOA7gU47UR05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdqKUGnR6i1wb+ZWpkClLzJgk967L/6rEBg7Q9UBlJE=;
 b=OGiSkxKjTrKdJwG3tqjiQUN90n2L4fT2B/QZtR4vbkWv4SB5+rpVTheI/4Xa3/1gobsYLRtaRDtfix/FUXahgRoQox6xiLF7ubk59QmNhquDTKuuZWsNgLgEVm/QPAMD+umWYNxv32PtFPvOsYoHbfoVcCujIUwZfezjRKoi5UA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 15:13:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:13:53 +0000
Date: Thu, 29 Aug 2024 11:13:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Message-ID: <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-8-271c60806c5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-delstid-v3-8-271c60806c5d@kernel.org>
X-ClientProxiedBy: CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a48067-3534-460d-093d-08dcc83d3193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6OuB/9n2kESwg+/kTjl2f8UBnXkhPdCK8BpFmTWOeW3QmIbX1O3ocn4XlP4?=
 =?us-ascii?Q?eAVbCpv6XS0s236x2CEoGl7E00507CmOL+QY5wTFeY5ZzWySX7+TqH9Lcmpc?=
 =?us-ascii?Q?ikbNxj6g/Xq5T3w7fWKgwI+pFWxOF9ykuGWZDtCgoxhNP2DzlLjitN8b3Cfv?=
 =?us-ascii?Q?l+jJjuU9IomSngdWvcUHxhBwMkXJzO43qNG3i1Co+TES7Do9vSwiuIBOGzzT?=
 =?us-ascii?Q?xhlBfzDc1CxuKPXu+NRhs+NuogxdpYI36R9NGpoqNrwezGOUKVKUJaZpx6Va?=
 =?us-ascii?Q?EF7oKHYqQzHSmZ8W/cplk3gXELzllQS77M028yN+Tkuubop5AzdHXrF1oHLM?=
 =?us-ascii?Q?B8bmpD/a4Dm6e49qOEERckVPqmRW7NO/kZm49w/RvpJViLPR9EUqJwMGbVg2?=
 =?us-ascii?Q?D6k9QE4rXHLpPZkurwaYl5ZAMyypC7oYZj2QwLQRERjemHSbDZ8cWLdYUKAM?=
 =?us-ascii?Q?ig26+ZpI98J3FpNCBsn2nG6AjrwYMlQsoOfB9t1X0BMDdquQl+vG7iIRJRXQ?=
 =?us-ascii?Q?vOM3AbSR6R9BdwHxZGqtpZjDcvzKltNTkZFccLjReSVA1ffgQFaMPQipzPDn?=
 =?us-ascii?Q?PWdYyKzZP+PrxZxtuBeXRRQuBaAQ45Sf5SjxiCuKewhy7KfKytM5oKWn1N89?=
 =?us-ascii?Q?UyRgkdNL0qh6IQ8AnGOV4oYdTgoM4E9OsbT5xID3AwAQO18WjjlGbIXW6lDM?=
 =?us-ascii?Q?hbb9P/OqD+lW6zAg5yplP6pnGhsnBrMF8Wh17ttTWkJTuFFq5oYk4l23lVoR?=
 =?us-ascii?Q?7NTxnqd386wnjNv354pM/AjCzkTbJM1L5zjFGF+izR7G3zbtzwCgsO6znIUv?=
 =?us-ascii?Q?imCXzrNhgSW5N+aYWMpBt97cy2jqJoZ034lCQwrwW6mItlQ85bx+CUomvaMu?=
 =?us-ascii?Q?GZF0MkknfmXoLLQWQQlt1Ek/IxQfpDrPEr1zpSPPmzVdyETUsyM5RKdnqB4V?=
 =?us-ascii?Q?u1VrTASsq0qT4HLk7+8oUFGmSB4e8+H7WCGcVlKpV8Fo4jgoCdac6f+tSiI4?=
 =?us-ascii?Q?VM6N3ApYEKBBOIpHu00eK65V/75fMy/MMhuuM4pdykqP5Do9BPLCvUbOx17g?=
 =?us-ascii?Q?5Sb5WAH1xbaCYhF/nTxzifUtM9hyLt8rJhLTQRulspHhmpM2D6X4y/7aL+KH?=
 =?us-ascii?Q?/u0HUafdYDBzYVLjsomaUsZJxsHprzFOJ1vimLxtodWWvm8mXdsACzdfBnOd?=
 =?us-ascii?Q?B8lo9spXeawuI53T30ndTxar9mfwrxDUQPYOe9L4W3lZsc3RXgDD5dxNF78E?=
 =?us-ascii?Q?HO2duNyJTrzHKPr6MoW3AuqhGInWkPpA7YSzU1K0yUDW6kd8UWG6eEZ3drhQ?=
 =?us-ascii?Q?WlI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDla4B+Q/QsoGU+vS/DMiUdPHOUgGPYh6vl3gJI0tkBOzCempC6v6xRjoTT1?=
 =?us-ascii?Q?vV4IjT2pG9c4DplE5P1wTscUXZFUted2XEmTVseAmSDI/6CJqLuCVOa+azUB?=
 =?us-ascii?Q?V14LjtTLxg8n+J0kcRAOSwvobwux/BFsURuA/omjdFvuu20U8jVE776EZZj5?=
 =?us-ascii?Q?w2A1e6cROQXJcFhaX8rUStArk7YakC40nx8hzkdqhtPxPZt/H3R+4YRqnc7q?=
 =?us-ascii?Q?PS5ePPX4YFKZXDqkc8dAIzZ6ZM8nWGN2/XpmpH+L6WYK0AFaNbpp/HyEpZR2?=
 =?us-ascii?Q?nwkiyJFsIH/d6PpsBXhlVsxns+GxgzkJORH0+j3POrI+KdGl+sjfRvGJq/0e?=
 =?us-ascii?Q?EiWBSVzbFA8YeSWbTg4c8ex4UVwuKe8NrSHbzKa7aURMiXy+Cjt2myd29t1B?=
 =?us-ascii?Q?wH8kBORbzBfnX2Ezg6C3Ng/obCMLUnzVkAuMp6WUshOvt29MiB4UcMO69b3Y?=
 =?us-ascii?Q?iMBLNseTj87ATxabYm0j+WABoIvvdUuM92RA1d9vI9mTz9ik3gyBRQZOdGgP?=
 =?us-ascii?Q?yp40AX/G5jOZ3SI5luTGyA+HZyoV306X0RmILSD+2QNUyxSfLYK6CSzLV6Cz?=
 =?us-ascii?Q?4Px7otpNl9Sbt6peagShMFPFPitSgk4fYh2LuatLx56py2mmDpC0HDMR1UTv?=
 =?us-ascii?Q?27AKoVUVCPu0IPR59KWv5PBOd6Hpem0QwKILYXUv3zanACOR9DCopGshC5Jk?=
 =?us-ascii?Q?UekdiEvuHA23+ZieynD/fE3ZWiREZTRchPnkpGBAveSKcO0hvykgPMhYCR4c?=
 =?us-ascii?Q?T1X1/hGvXhWUSSVppaWyt2y7dXsoPsFf0KEx/LbFbqHBIoFqcyQNxthbGdmy?=
 =?us-ascii?Q?CKaJD6QrVMWvO8Hxp7T8GTVak/wL3q/J28gBiaGZnTVst0qEWRIM9dQ7Gavz?=
 =?us-ascii?Q?VFQSRm8iDqTqXcrX7CETDm0uCC2+STlmO4f2GXDyva8NbbXUF+ZWvylUjg7p?=
 =?us-ascii?Q?jRa4Y6CU9yddk1noZAxNkBEVbwU1q+Bteub0BExWMLYu4s190MeFx1GbE67l?=
 =?us-ascii?Q?zuqUO53mVXK8MpWz+tQMiA2nYxQzNZ5FaoQWpBNk7Blufkd1U2iGFWVQFgwQ?=
 =?us-ascii?Q?RghddNIUgNwP1GHy0twkNfm+H8fqw+SLf9+We18sR8055lVvgR+hEew8+T1X?=
 =?us-ascii?Q?qhzPv4RtEAfj6WbvCVTFCu5qQIho6kN2FdGbzCDpvqmjdPcd+bRQq8xvCAEg?=
 =?us-ascii?Q?s9cOiMZZMlYblNyScAHWk8jly3mofIDQ9FOJs53nUA6YUwvkx2B1gfjvtbgA?=
 =?us-ascii?Q?3VxJcygEpieUlxoIJPBXUQKcZ/i0R/a4PRPsu+u9RA4Tz/WsIDpzVqRNM5fl?=
 =?us-ascii?Q?RQ+NBROrAq4XT+RanRTvFrRnyELtd5rzijt9Qp8aJC0IArLMptS4/DfZzhIx?=
 =?us-ascii?Q?F7f6xfNnkGUL8zUc654gianInNmUqyH35oErGqzLztCT5MG85MNsHQKlDcxS?=
 =?us-ascii?Q?SoZ6G7fjmLrjfZD1U9cUaMdXioGrdCGZgnFLeN6ip1B/SELx0YbjidFLH8jV?=
 =?us-ascii?Q?aFa/kdSqQlXRBygA41NbIVEf6jhFDacvHETWUruHC0cLdtyNtWB5GuDC+YKj?=
 =?us-ascii?Q?PZAXKtgIt4myC/NSXphZvpYWiUHr6i2sSxsnC3sAM8sHfX4q9GLtwmfa5yNs?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ji0gM12QyfpGeozzMU0uPD6/cqRoM+FR03HxnxzCiV95HZvPON2goghSHl4gkPl4Ag2kHccn5nzZ/muCwFvIvIlOs0QE/TeNhkOXXWABM9UFFKbVdyYGt73h9LBwwcI1NRI6Beci2VOkXzea411H4bfe1WKx0moaP1oYFmWE4gy/Sv8f0sEiTQT9jNM6uNEIpHbgclSKFx+eSm7y9ztVo7H3VEIe+gPEbSlVHYuPGaI/Y/smlzF+gO20jajdU7nyGcF3l5vsTmcAyuBrH5BVyl/2Mlb/eRI2gBRkt76fJr7SLglyYseHJnK5IFGLx+0r9hIh6Kdgceao9YJgVZXMOfBpf4f8ol/7IGkcqFToOFbaWtdCgmlRgCaT5pVNOZ+yz37hmRjg2zqXO4T5b+v9VhIr1JhP4McvtWtxINf0eunip1i8cucGHcE/Hie6HnOricrmy3yt5sAI1xSgLRno01EV41bF7sKkhbMYgZ+dubPM0LTRqXN9+2TIkxbErsX0Vi91+AUxtmzAT6ggSUuElmN4xYMUnCrZIWhAb+y5aWYe4q0prIRo5favs2ypzKCsJIEOmbVRTrj28JlnDJy/HODrvvae2cSfQ2sJBFr/9ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a48067-3534-460d-093d-08dcc83d3193
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:13:53.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/RNv0uDK3iF2ZWSl1X17mvJZdUdzyjP1PJO1T2jVHLIMocnHCVucf5br7Z/jSbkQfOVXv9NYvg0C5BTtqT0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290106
X-Proofpoint-GUID: UQYUbsRQNtaWLY7mOHSHt9N6M9P6jNVU
X-Proofpoint-ORIG-GUID: UQYUbsRQNtaWLY7mOHSHt9N6M9P6jNVU

On Thu, Aug 29, 2024 at 09:26:46AM -0400, Jeff Layton wrote:
> Long term, we'd like to move to autogenerating a lot of our XDR code.
> Both the client and server include include/linux/nfs4.h. That file is
> hand-rolled and some of the symbols in it conflict with the
> autogenerated symbols from the spec.
> 
> Move nfs4_1.x to Documentation/sunrpc/xdr.

I can change 2/2 in the xdrgen series to land this file under
Documentation/sunrpc/xdr.


> Create a new include/linux/sunrpc/xdrgen directory in which we can
> keep autogenerated header files.

I think the header files will have different content for the client
and server. For example, the server-side header has function
declarations for the procedure argument and result XDR functions,
the client doesn't (because those functions are all static on the
client side).

Not sure we're ready for this level of sharing between client and
server.


> Move the new, generated nfs4xdr_gen.h file to nfs4_1.h in
> that directory.

I'd rather keep the current file name to indicate that it's
generated code.


> Have include/linux/nfs4.h include the newly renamed file
> and then remove conflicting definitions from it and nfs_xdr.h.
> 
> For now, the .x file from which we're generating the header is fairly
> small and just covers the delstid draft, but we can expand that in the
> future and just remove conflicting definitions as we go.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  {fs/nfsd => Documentation/sunrpc/xdr}/nfs4_1.x                | 0
>  MAINTAINERS                                                   | 1 +
>  fs/nfsd/nfs4xdr_gen.c                                         | 2 +-
>  include/linux/nfs4.h                                          | 7 +------
>  include/linux/nfs_xdr.h                                       | 5 -----
>  fs/nfsd/nfs4xdr_gen.h => include/linux/sunrpc/xdrgen/nfs4_1.h | 6 +++---
>  6 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
> similarity index 100%
> rename from fs/nfsd/nfs4_1.x
> rename to Documentation/sunrpc/xdr/nfs4_1.x
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a70b7c9c3533..e85114273238 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12175,6 +12175,7 @@ S:	Supported
>  B:	https://bugzilla.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>  F:	Documentation/filesystems/nfs/
> +F:	Documentation/sunrpc/xdr/
>  F:	fs/lockd/
>  F:	fs/nfs_common/
>  F:	fs/nfsd/
> diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> index 6833d0ad35a8..00e803781c87 100644
> --- a/fs/nfsd/nfs4xdr_gen.c
> +++ b/fs/nfsd/nfs4xdr_gen.c
> @@ -2,7 +2,7 @@
>  // Generated by xdrgen. Manual edits will be lost.
>  // XDR specification modification time: Wed Aug 28 09:57:28 2024
>  
> -#include "nfs4xdr_gen.h"
> +#include <linux/sunrpc/xdrgen/nfs4_1.h>

Please don't hand-edit these files. That makes it impossible to just
run the xdrgen tool and get a new version, which is the real goal.

If you need different generated content, change the tool to generate
what you need (or feel free to ask me to get out my whittling
knife).


>  static bool __maybe_unused
>  xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 8d7430d9f218..b90719244775 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -17,6 +17,7 @@
>  #include <linux/uidgid.h>
>  #include <uapi/linux/nfs4.h>
>  #include <linux/sunrpc/msg_prot.h>
> +#include <linux/sunrpc/xdrgen/nfs4_1.h>
>  
>  enum nfs4_acl_whotype {
>  	NFS4_ACL_WHO_NAMED = 0,
> @@ -512,12 +513,6 @@ enum {
>  	FATTR4_XATTR_SUPPORT		= 82,
>  };
>  
> -enum {
> -	FATTR4_TIME_DELEG_ACCESS	= 84,
> -	FATTR4_TIME_DELEG_MODIFY	= 85,
> -	FATTR4_OPEN_ARGUMENTS		= 86,
> -};
> -
>  /*
>   * The following internal definitions enable processing the above
>   * attribute bits within 32-bit word boundaries.
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index 45623af3e7b8..d3fe47baf110 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
>  
>  #endif /* CONFIG_NFS_V4 */
>  
> -struct nfstime4 {
> -	u64	seconds;
> -	u32	nseconds;
> -};
> -
>  #ifdef CONFIG_NFS_V4_1
>  
>  struct pnfs_commit_bucket {
> diff --git a/fs/nfsd/nfs4xdr_gen.h b/include/linux/sunrpc/xdrgen/nfs4_1.h
> similarity index 96%
> rename from fs/nfsd/nfs4xdr_gen.h
> rename to include/linux/sunrpc/xdrgen/nfs4_1.h
> index 5465db4fb32b..5faee67281b8 100644
> --- a/fs/nfsd/nfs4xdr_gen.h
> +++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
> @@ -2,8 +2,8 @@
>  /* Generated by xdrgen. Manual edits will be lost. */
>  /* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
>  
> -#ifndef _LINUX_NFS4_XDRGEN_H
> -#define _LINUX_NFS4_XDRGEN_H
> +#ifndef _LINUX_XDRGEN_NFS4_H
> +#define _LINUX_XDRGEN_NFS4_H

Ditto. Resist The Urge (tm).


>  #include <linux/types.h>
>  #include <linux/sunrpc/svc.h>
> @@ -103,4 +103,4 @@ enum { FATTR4_TIME_DELEG_MODIFY = 85 };
>  
>  enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS = 0x100000 };
>  
> -#endif /* _LINUX_NFS4_XDRGEN_H */
> +#endif /* _LINUX_XDRGEN_NFS4_H */
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

