Return-Path: <linux-fsdevel+bounces-31970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0C799E9A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849611F2282F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816C1EC004;
	Tue, 15 Oct 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PlhnMGfD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QFO70AIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD716EC0E;
	Tue, 15 Oct 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994985; cv=fail; b=rwfzm+9x17fRnY0hc+ZYo3ko5y+i/ldldAEwGwIlQEjAeYVjthrQ+A0hJE6H/1+Gx3sHY4Cg4GArbKMq5ZbTg6FA4CBjAi8iHeKgtOTd5HF5DYSv80HDXQhjL5ifiJmCo6pBI9cVQhZct9rRETF/J7DqJXS9AaSh8V2yH/aO07Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994985; c=relaxed/simple;
	bh=FfkpZKV0IaymFyOmFpzIZjn0KJztvpiiRDmqot8poes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oL+TrVurlw1zif3kR6lkbumeSHeHYXAgxo7qECY/NSSK3ycS4gjERAxBnmTz7Nu1zggzQGkRqDRD3hXMckDcF43z+mxPuZjwFBtQ73jeAfrAwCxSvn3RnAQf6vTTmjDM95S6BySXkRhz1VEZwNro/C1Xi8aN7UFVNNCkFSuJnKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PlhnMGfD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QFO70AIR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAHDfm010197;
	Tue, 15 Oct 2024 12:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gQ3ix7wAAHDhImuwxw3IVE8KwF9kPp/FgFbdbXlcOYQ=; b=
	PlhnMGfDh/lGSWkI2uiu/4/i1zzglRBA79SFMzM0UXswegoxEtUNPT0AmTCBi1m4
	YAdy5M87FmAOS0C6y/GNB9OB5oqKp8FkxCkfaSnQ5nZKVZMpurX8Ftn93JrTeR5j
	JryPXVUz966B4YLDIDJsamABMFpmFmp27DE1qj+W9W0GzvFL6Os9nSp+xlVF6esp
	KgA2si3TDJR3TnEcZRmX236PXeNRnraYb1Z/21PTnPE1VJhljW+Z+faG3izUgRHl
	gMIu6mgT3Q9gU/w0GSBYwD8etL8sa89bUNWTPhbeYr8IlT1qww+2GmDIF07kd+h2
	E5HPlBcZ4C+v14CNk8jXVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt0vc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:22:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAMAaw036106;
	Tue, 15 Oct 2024 12:22:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdnu8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 12:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZHTxLfNSqD8RSqqPlmJmXMLMKsearKq1BYQE9HT7jzsG/Q8dpaxrze80LrLHswF4mFqsvnAOmhIoJCadZIoTr1JHsNvN8qZWqfP0uNjioYxV0/LXf879d6mEiZyqyHhsFi/6KpqVgSPqEF0k4QHsFh17E+cDn4qM4v3wBkZ53GLnYSsk4JhTiNZWjGE+unmVM06bAmzy7IQc+r3UtXJq9xHOxPxtKH/jF3ICEm8ww9fFxSbje+gR6G4hoUeEc9xikeImeqr5HY2qo4M/Mu4j8SlheW+eLPND0jg7FK5jFkbYXMJm4iOuPWw6a7My/dC09YiiNyBHlflk3W52G5nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ3ix7wAAHDhImuwxw3IVE8KwF9kPp/FgFbdbXlcOYQ=;
 b=uug+mI7+K5Js+vnlI0S6Q3N7kIcQK9i6NVQAXJA8szzptioavsPQsyuR0jhahwuDfO1niiRNl9laSt/oGPjh2PClJkwyhm2xjhDW/WbUUXMgHoV6PCzeVbJfzBjvaY4keqBRndUAMhJcmn2WLcnajZajylI1AKRRkVgaiP/FY06ROtaiZv9/pwPGoD2f1rufxJS+1NS1UWD2gkdenqh5Wm+cPOE73I8ZNVEPQ52g62LhIJTyy3UQ76aVJShdroWU2v+r37WYq2sbMyU+3hPciZs/wgdLTkDzMYtgAvFZ+zKuPKtKPbhMWSq7R7XjG6arVxkqYHmaHCERJ0imNUqo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ3ix7wAAHDhImuwxw3IVE8KwF9kPp/FgFbdbXlcOYQ=;
 b=QFO70AIRVuiqyLq48tAHbF63BUbwwRyZ5IsvL0rC2iRKsSp5w8aTb42SW/C+CoJf9JUR60pvZqgHDXSMXrqSMqJ2Jsrv9O2R+jaZJcYPltzDkiuNgKX+8d+yt5brXIrKPT7iqFjfgsjOH2zYzJDfW2vxewvnpUIyiipiuoj0uao=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7199.namprd10.prod.outlook.com (2603:10b6:208:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 12:22:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 12:22:31 +0000
Message-ID: <9c05dfea-339e-44e7-9688-b5206726a1c5@oracle.com>
Date: Tue, 15 Oct 2024 13:22:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] xfs: Support atomic write for statx
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241015090142.3189518-1-john.g.garry@oracle.com>
 <20241015090142.3189518-6-john.g.garry@oracle.com>
 <20241015121539.GB32583@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241015121539.GB32583@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afd03f7-4feb-4d5a-7304-08dced140ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHA1ampoOW83Ky9Qamh0bEVjSW53UXpOVDFUNHd4bDlzdjRGZXJDZEFIY0cv?=
 =?utf-8?B?elh5Ty9adGRLUGI0Uk9qT3RxMENvZzdWZDhmZFdZVndidCtMV0cyQ2NHOFJs?=
 =?utf-8?B?WnY3VWhVRWk1bFNlckdrNlZwSWNQZWt5WnRPcDdFSXZKRGV5ekFYWUJQcGh2?=
 =?utf-8?B?dThVbTY5WW5RbExYZlFQVXY4QkFuSGJRYWkxU25ETWpxYUdMN0xPVm1OV3Ji?=
 =?utf-8?B?djNvbVpXMUNUcFlPL3I2NTFZdW42SWpCa1kxMjBoT2hSRkxJd3orZExMOVVs?=
 =?utf-8?B?OTU1ZDIwaVJKcHdpeW1hNm96alVIYUZ3bFVZYWxOVFg1UUFRKzU4eXFXYkww?=
 =?utf-8?B?bEFiS3VLQWtXejN3aUNJQ1lXSkJ3TFJOVko0YStsK1dvdkVXQ2VjaFpSZ1Rv?=
 =?utf-8?B?UGtMZk96Sm9Rb3VQcUJYS1cxZkQ4eXFQZzZtOTlRdGtFVkljMGhqalJRTzNP?=
 =?utf-8?B?ZUNWL25LVmxHUE9PMENEQ0FMS2JBN2h3Sk8wbG1JRG53WTMwbkZZU3M3SmtB?=
 =?utf-8?B?Y1d4V3BPOUVwVWt3UmVGUXE0VUJNZ0g4MXhRMGNaNFFMdUxOMVFXOUYxTmR2?=
 =?utf-8?B?Y1lFaXpRTThpc20vaFJJaUdmb3d0YVUvbFpOU1A2c0ZNZkhQZ2hLSGQ2bHVk?=
 =?utf-8?B?WERiOVpjVWN1QUw5SGNGYmlXTGgvbU0vQjgrWWRESmdHL1BjblVxOGUvVGxI?=
 =?utf-8?B?SlUreTZ4RjdBSXJrUmNONWx4ZUVyQ0FtbE1xUEh0SDRxWm44ZWdBdjlWSzNi?=
 =?utf-8?B?dDVWazdJSkdsaDNTYzhGOVJMZjUra0hOR2E3Y09qMlNTZHhObGoyNTJ6cHhD?=
 =?utf-8?B?OU9iR0V1Uitzb08ydTYxMHd6YWQzT01nS3VXSHVtTXBOV0Y0UUdnYTN1eStO?=
 =?utf-8?B?NDhNdTVEd2lkcStBWWtqTVBBc0VYdnVjLy9ieWI1cWVwRXJIS3BMVGFXb0hR?=
 =?utf-8?B?Rnh6SFZmNGo1dVhEYVlYSE4zV2FqOFhyT2V6V09iem5zSzNRdWMwTEJzSTVq?=
 =?utf-8?B?ZE83dDlSUFQ5L0hNdDVMRG1jN043QjF0dEt2R3lRc0NmNUpiYkZrMnZJTy9T?=
 =?utf-8?B?RlhPYnJYK21EdnB1c2phYlU1VTlpdGJLUHozdUVNTjR1L0ZOeE53dzBrLy9K?=
 =?utf-8?B?WkdtNzhpOUlqc3hHR3FzS0Zka2VZcGVQNUpUVGpSQUVKd2dzY1dqOXA2bU5X?=
 =?utf-8?B?aWVGUm85OXptVVpJSzROdTVYRUFSSi9HS3NlSVhieGdFY2tnc3J3Z2ZlQnRl?=
 =?utf-8?B?RWdpY2JTS1RmNnRRcXFTNmo2Y1FyZE1KUlZEOUt6M3FwTHFBNDUzdVVoNU1i?=
 =?utf-8?B?K3BLWVo5WXozYmp3OGhYa25CRlJVSzJQc0xKVUZNWDRVQTI5M0ZNR2Z4REpt?=
 =?utf-8?B?Sm04TkwwbStHRHJIOGZVZEJ1eXZtZ3BtUFBxWEI2M2o0M0h2TGZ3WWdiU2VI?=
 =?utf-8?B?Wkt4RDVqV0VWS2pjTjdZNlh6MktkcXM0OFNYSHZtcXM3MVRJMG1wQkpOUCtU?=
 =?utf-8?B?OUV3MkdERHVNYkJkQVM1RHpBYUs5ZUIzT1lEVHJYOXJ3M1ViRzVqK0JDOThL?=
 =?utf-8?B?L1V5MjZrSEg0ME9hUkd4VmdKSm9vVUZWeWxtRHlCVkEweXM1bWRMRDR6Y01V?=
 =?utf-8?B?UDI4UzRsMG44c1dZMzh3MmxrL0Rac0hhVC9YNndpcU5aTXI5aVhGbGgvbnFR?=
 =?utf-8?B?SFRxcVFzaXpPOWd0UGFMQ0MzK2tNdGhkbS9mTUdmdnFxWVIrVXZlNUR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1OU2daem4wQUlNdXpBQWRtWmdTbzFuc01yeG8wQitNMGFibGFxaDQvRXo3?=
 =?utf-8?B?NlRERCtabVpaWWZ1QWtrTFVaR2Nwdkc1c3poK2JYeWgvNmU5dGFLVGVNdU5w?=
 =?utf-8?B?Y1ppa05yS2RjbnpLRDFVNnpSc1FBZExnNjdFSndvZ3RVOEg3aThVRkNzU1Vu?=
 =?utf-8?B?aCtydVR3UlN1UERZKzJQRTg2Tk5sNUpTd21DQ0tBYTVWVWpYb1hYQXBtZ1ZE?=
 =?utf-8?B?MnpjZGYxdEp1ZEJld1ZqbnRNNFZRUlR6cUloR0ZjN3Nndi94QUtBdkJsbWpM?=
 =?utf-8?B?YjUwb3dlOEt0ekppRUNZZG5HVFF6bVZJV3gxTGw2M010dXI2cm15NjRqOXBp?=
 =?utf-8?B?ckFmVmFiNlFsUXVsZU1VNjIrSEQ3TnBSZEdkWEh6N3p4OXpHZzA4NVFGOVRY?=
 =?utf-8?B?TWFEZzdRaFJMZWZBRXF3SHJiWlpWbE9ya214VVhxNG9NZ3FXZG9UZ2N6Z1R3?=
 =?utf-8?B?OHBuTVBoK3hYVHZJdlBUNlpqQTROeElBb0M4ZzFtOVAyNmI1ejc0VmFkbnJY?=
 =?utf-8?B?K0JDcFU2bG5nbStqRW8vd0pwU0owY05JcFRjQ1R3Y3F4dHJSblQ0cnhtcTVC?=
 =?utf-8?B?c3UvVlg5amQ5Zkl1Y2Fka3NUTGRUTmJFU1hWNU9KSVhacXdrUmZGTkdpUTgy?=
 =?utf-8?B?SlJLS3phaGd0YmI3Q0lwQ0hzOHVsakg5UlFPbTdEbGhlUnB6WXpsUjRhZEJL?=
 =?utf-8?B?SXFRbkhlU3BUNitWT0ZaNHJPREFObDMxUHRzdVYzQlVYUU00U1dScXFxSThB?=
 =?utf-8?B?MXhGN1pVdHlYblZaQzlKcnNzM1pITk9DdzhJdnIvYnNOK1FidDBlTTdLT2xy?=
 =?utf-8?B?eHFqTXJhcndGQi92aWxJWHQzLzBxNEtoWWduL2t2emVRNVYvWHVxbTZWMnRZ?=
 =?utf-8?B?Szc3L1NBQUR4MlpDZXVaVm9LZGIyenZONGlGRHQ2SWdoRXVIMnp0QUFCMk52?=
 =?utf-8?B?aEowZE1pUmhrU0dhRmJaS3Z3ZmdKL2hETWhHUDBPcG1LYm01cFNhYTVzY0ND?=
 =?utf-8?B?M0kxMUNPNzFqdGt2anRpaXcyajMwZm4zQ3Fja2EyNHFiaWN6M0pDRjFXbzVZ?=
 =?utf-8?B?bFVCM0VjUTdzNEFEVE9QaVZiS1pHVDFVMncyY1B1UURlZitVZXh0amlmUGoz?=
 =?utf-8?B?QldNMnlFNm1JTElhTDJwUkFVZTdDckdDWTh2bzVmNTEzR3NoK3ZGWlhDYTlj?=
 =?utf-8?B?VjFNWnExOW9IMVVSbE1PYWIwbGg5ZzNiNVVpVEJzQ1VZckpDQWZSNk9NeHVh?=
 =?utf-8?B?QnorL0ZHL0hVVTFINEVsc2l6TnZHaGIyVDhpWE9DRlc3WUtSWjU2Rnc0eUdJ?=
 =?utf-8?B?WmlXWFpTUnRpd0FyV3RuVmtVa0h0Q0pNbyswUU8waTQzTzVPdEpqNE1kNDJZ?=
 =?utf-8?B?emFmeEc4clRVQlJpdzZKT1V5b0t6RjRzaWxYMHZQblNWbTROd0Y5RnJEN2E3?=
 =?utf-8?B?d3lNazZ0aGZudytnWlMvckl6TmJpbk5EVlVlMmU1QkZrd1prUjFPRmliRWh5?=
 =?utf-8?B?anBmdFcrdTB1Zkl2SUhZWTFPVUhIdXk2bGFESlN5TEpQc0kzQXUvdTFVdFJI?=
 =?utf-8?B?SmRSMlg1Zjg3aWtGRVFGRjFMRmNERC9uVXd0Zkx4ZWJXK2l5TWZkRUVFVlhE?=
 =?utf-8?B?d1p6K1pubFhBZWJpTHVUMnNmczFjU1BGMW4wSUpIT2haWVVPODIyK3Z2SlEy?=
 =?utf-8?B?TGJDOTZYZjlaeUw0QVY0NG12ck1tNDkwWEVvSXpDeVppQmVjaWhHNWg0SWZt?=
 =?utf-8?B?SEQvdm1nOE9GOVdsZUh0bU5rVG1aYjUxK3YvSUpWY0JiaFMxeXJkWXo4cnVH?=
 =?utf-8?B?VTdzRlFVQko3Vk80MEx4WEFISzBJdGNFaUdhQWllQyswa3hUeUhjak0wTnZD?=
 =?utf-8?B?cWFZYzgyZGpoQ2hieTNsTnFXb3ZuSStWSWx5ZE9FcW1XbjNvamJOTGJpdWN4?=
 =?utf-8?B?RXNrTnkzV2RqbTNwS1dQR1VhZFRLVklNSW15bkEvZys4T1hnaFkrR0xXNUUx?=
 =?utf-8?B?ZUVNMnMvTWRVMFJPOHhyMFo4eHBjS2JYaC9hYkdBaVhHQ0h1bld0bWlCVmhq?=
 =?utf-8?B?VENraWpkVWZBUnJYUXpkRFYrUXU1cFVPSENIV0dmK2lCd2hrTlRYa3FKUmlN?=
 =?utf-8?B?dlptbzh0RTBRbnIzQVgvaXNaR0NlQVdPZm1mOE1Va0gxQ2VsSVJSRUZwK1Nk?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SclfDZ/UcfEJ/9rQxpMe5GKMbSYV2zzbPrpEXJa7jtzUSk0Xwa2s8TXgYkIN3yR61PNeJhRH/hMH7rkznHaUwSFUONTsJDYdo1F7xGzVd4h6nPiHp+l+CyESonmehyCQBnr6xJdlJxyd0T+IfBGJsOr3OTEee0gLZS5gU1/fEogY87a8iI6Ys0IVZMhuEJqRxIH5iPsE/Vxv3TbAomZc1MkY4NXc1NNe+RXJXgQ7NpwW0Vfh/2AyW3hJVHO7vkPu9VoXCGjL6GHUOx2BIctwmJ+KJmnKqEfu2cfOtEK2UKH+6URdTnXm5l6xY0rGPgsGS6xDgUPic8JPZmw5gtJ9ljPfXvEc/jE9QPF8hmx/uPQm7jaSvyJWEZ0iJzOrBvPWN8o5wcfm0IR2OwFykrMh9hs5WRpB9KI74sWnEDssDZM9dL1tdvbOEW+Bz7nxlDtZKKoB+4dNYNINcsz4RIedPc6SLtV83gkPMR5/csQ7kncfSf+GF5kQyULKAw7P8wa//kwrXr4bkFbFEL9jxWA/btiCev6e7uWRqeINEYjEbQDIkJGcRqT10+xsyFH+1vBLemqv38gU8vAUUgLaGjj+T7oU4Klsch3EgCJLzw2rbNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afd03f7-4feb-4d5a-7304-08dced140ac4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 12:22:31.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCs7KpW8eOaiNV1tvdbURMT9ginT479CDjx59AkKSi1L35ScGNTI9ghk2Lhmkzl1/S/d1hp3JL3klIFbF/iJ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_07,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150084
X-Proofpoint-GUID: SRozL6DMQqy2-Ld-3HKrBtCZIoZ-MrEn
X-Proofpoint-ORIG-GUID: SRozL6DMQqy2-Ld-3HKrBtCZIoZ-MrEn

On 15/10/2024 13:15, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 09:01:40AM +0000, John Garry wrote:
>> Support providing info on atomic write unit min and max for an inode.
>>
>> For simplicity, currently we limit the min at the FS block size. As for
>> max, we limit also at FS block size, as there is no current method to
>> guarantee extent alignment or granularity for regular files.
>>
>> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_buf.c   |  7 +++++++
>>   fs/xfs/xfs_buf.h   |  3 +++
>>   fs/xfs/xfs_inode.h | 15 +++++++++++++++
>>   fs/xfs/xfs_iops.c  | 25 +++++++++++++++++++++++++
>>   4 files changed, 50 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index aa4dbda7b536..e279e5e139ff 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
>>   	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>>   					    mp, ops);
>>   
>> +	if (bdev_can_atomic_write(btp->bt_bdev)) {
>> +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
>> +
>> +		btp->bt_bdev_awu_min = queue_atomic_write_unit_min_bytes(q);
>> +		btp->bt_bdev_awu_max = queue_atomic_write_unit_max_bytes(q);
> 
> Consumers of the block layer should never see request_queue.  While there
> is a few leftovers still I've cleaned most of this up.  Please add
> bdev_atomic_write_unit_min_bytes and bdev_atomic_write_unit_max_bytes
> helpers for use by file systems and stacking drivers, similar to the
> other queue limits.

ok, fine

> 
>> +	/* Atomic write unit values */
>> +	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
> 
> Nit: While having two struct members declare on the same line using the
> same type specification is perfectly valid C, it looks odd and we avoid
> it in XFS (and most of the kernel).  Please split this into two lines.

sure

> 
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	struct xfs_sb		*sbp = &mp->m_sb;
>> +
>> +	if (!xfs_inode_can_atomicwrite(ip)) {
>> +		*unit_min = *unit_max = 0;
>> +		return;
>> +	}
>> +
>> +	*unit_min = *unit_max = sbp->sb_blocksize;
> 
> Nit: I'd do with the single use sbp local variable here.

I think that you mean do without.

> 
>> +}
>> +
>>   STATIC int
>>   xfs_vn_getattr(
>>   	struct mnt_idmap	*idmap,
>> @@ -643,6 +660,14 @@ xfs_vn_getattr(
>>   			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>>   			stat->dio_offset_align = bdev_logical_block_size(bdev);
>>   		}
>> +		if (request_mask & STATX_WRITE_ATOMIC) {
>> +			unsigned int unit_min, unit_max;
> 
> Nit: XFS (unlike the rest of the kernel) uses tab alignments for
> variables.

ok

> 
> Otherwise this looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

cheers


