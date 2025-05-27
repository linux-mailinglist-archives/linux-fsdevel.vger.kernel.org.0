Return-Path: <linux-fsdevel+bounces-49931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D830AC5BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED3A9E1D57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6365212D7D;
	Tue, 27 May 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rlVOvhdn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H24wQ9hb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDE20B800;
	Tue, 27 May 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379817; cv=fail; b=RXvJtAlGdnMnPGvDUGB5anYfTlCUlelF9sxAl3HX7F8KsTxGfM9Exnd6T9b6GOy966cdihmiRdlBO4DQtHtXD30EODwsdxr4SDf8k4r9NYj53FL/oPw6Xxa1N14I8Qk41a9SdVN0Flfn/jpvWk1C+bMxCZEtT5GehajgWukrtoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379817; c=relaxed/simple;
	bh=WkbnhvJ3NnvSckANtPuTpfEHgK9Fwf8zgbCqSqnKz0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m9JBHu6kcULjDq4Pg+3JENsKaGQuqn2ooVhogiGjA3+2Z/nBnpqF9RlKXJGcW246CBwNC+th2ZWBohVsorUYffh5d59GFjJfxTX7AwOOZtddMwFmkTLiBqDt6AhDjTE8+qyw6JI4ZGrWzdINlLOiT0u5rm4IpoOGxLnX9xvVLoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rlVOvhdn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H24wQ9hb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RKtqCj003391;
	Tue, 27 May 2025 21:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=M9RQ3XgWsQnk15iqALfI5FA1Tz55ZK/GxkMvVd35pas=; b=
	rlVOvhdnAa0GO22FiuxvSgzYshyujaEm2QKZWorH4ywMcg4onHgsyO3jTEKagCT8
	Ag4FnGdmqfVhvVltepQmvxqVYrRVVYeFgqGf6groLmBfTLVKfkopV3AcKkobnikN
	XJPjM98XBTzJxlRwxcpk5OfjE5CvPZ60ipd2RhzFn1++5MRPKEiTBOyY0HwpgDie
	5Z5u8Q0rkEX157cM46AL3isEUdhSV9KVaG4zzkY8HmxbxxSSFVZiQdX23EJy0dA2
	QqbaQU8HR6/5DNPbBRAUdXYmDJnTu3MTOOAaoagTgusR+A94gvWVM8h140gw/2Y2
	E5M70eTD8Gg3Prhhy1CxlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykvg9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 21:03:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54RKOvdr007260;
	Tue, 27 May 2025 21:03:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j9sgug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 21:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2GWPsFqnDXjxvH6c2xDrqS3BeDiBEuk4FggO2BRonUxmI9YCryjbmu4ioNlVTemlXugBXimSHP5O+EkWgQ+OSSIForfTkUBy7f/Loi/Ck62EEmHsBv3RupfVksxiC1+ncTPnRkDeu1rQ4xFVXjeqU3YcdXQo7B+j3vlIFnYhlC1edOPddauzFsZ0nQ2nPyjy7hzkJBWGtZQXkha4169BO5F41kCmnYsoY98zw3v0K8IDK4Mjv0sTXHUYptPYcCEjRks+dYvia11nzhIY4l3H9KyGgwUuxvqokNej8KLG8ujC1O7GW6IfI4T3oLMoRm4B9EIgApqWa/1OPDqtGI1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9RQ3XgWsQnk15iqALfI5FA1Tz55ZK/GxkMvVd35pas=;
 b=nKNKmjM4mlQXXMl3jj5BtWkYeyfQ6hcvWOUa6F4TJhiBN+Efnej6iyYaiYWTJu0mUPGP0cPz66B31DQHAqH/IUobAlnTBICvohWrIRLWK3rvkv/9bgZEm+POvQQ/m+LVfB/+knJ1RoF4p0HkK/amEVOwt2Q5bCR0ojzHPaj1ySHj6G4RnbmJnL3Gb7A7jcVMBQE2mD3tA/p91EPVsIDcmOTepdbgMBdKBOgGXnbCMur6WmhjEqdpPbr3DlDg0D3peE+ERHW1luvX94CmxiTaVJHvKM7UOdH7HjDrO+p6NZCtKol/WvFL9v2+2/3YzaVfAAAytYxa3ZzZJl+7xG/qZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9RQ3XgWsQnk15iqALfI5FA1Tz55ZK/GxkMvVd35pas=;
 b=H24wQ9hbO1ukewkdiiHx0qlstfjiw6bgvFM/8EUK/HITt6jph3bZqlaFoXlKsIzQyu1m4W22KOTKpDL7uhQGvPjZSjoe9U+HuuvNgjdZZWW+aOalA7JUFuAWxbhTPn9n6/vpk4274pGxQQqOdZh6sEgdp6Egwp81NX+pB5nHMsI=
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by PH8PR10MB6670.namprd10.prod.outlook.com (2603:10b6:510:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 27 May
 2025 21:03:07 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::8c24:37e7:b737:8ba5%6]) with mapi id 15.20.8746.035; Tue, 27 May 2025
 21:03:07 +0000
Message-ID: <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com>
Date: Tue, 27 May 2025 17:03:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: Paul Moore <paul@paul-moore.com>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org, selinux@vger.kernel.org
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:610:32::20) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_|PH8PR10MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: b803f1ee-5d66-476b-d8ab-08dd9d61e160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzZEUzI4dFRhUFdtMTZ6L1djSWZkTldUcUQ4NUZQbmZRcXZhRVNPKzhsdGlK?=
 =?utf-8?B?TUdGN3Q4NDVuVWkwV0lyN0hWVDU2M1FRWjF4QjBKUWhVN1g0U1B5RVV4cnZZ?=
 =?utf-8?B?N2JyR09EL3JqVTZaZGdYc0VvTGdqbnpLcGFmT2FrTUlIZ0RONUZsQkk3VVJ6?=
 =?utf-8?B?Uld5SXZzbHduRHBCK1NnckhaV2t0WXNMaWlLQ0NEdC9xS0dYSTF0aHRTa2Mw?=
 =?utf-8?B?RDVLWUk2QkNJQmVOTFQxVWk3d1NucUkxa1FjQ2cwaTJGODRBaHhCYStuM3li?=
 =?utf-8?B?SFUyenRZdTMyay9yV3Z0WGYwM2lDYi8wTFB2SFIreks1cEtuTVErRU83Wnhz?=
 =?utf-8?B?NWNaZjNRQWw1Rkc0T3dmQ2xZRmQ5bkVFMWhoK0R6MEswaXBaaTE3cTNld3l2?=
 =?utf-8?B?ZmI2elkxQ0VjNURjRUd3U3FZc2IxMm5ObmhyZFlRb2oxMGdhM3gxbmR2eHVB?=
 =?utf-8?B?TTVyNUpnd09SZy81Yy9yMk8yQkdKS0phRXdoSXdnQ21vL1JoVkRBdHlpVkZW?=
 =?utf-8?B?OVFoL1lhajI0OGozeHVtTjBQZzlseWFxbDQxQzZ6NHVSek9IbXFKZHRlTDRK?=
 =?utf-8?B?UTZicWVPMUxmTGlya1UxYkM5QVVldW5JWFVMSGVndEhEVGMwaFljbC9Ub05K?=
 =?utf-8?B?U2p3eCtMazdkbFJSRWh3akNpWFhWeFFLOUttLzI0NDlNaER4Zm5vMXNZUDl0?=
 =?utf-8?B?SFlyTUZqWXBnaUpMZTlkMUF4dFhrT0pnZzMraHdoTDBuYy9BSTY3d2Q2Sm4y?=
 =?utf-8?B?MG84VDRnNUtBL2NIK0luclB0TDJSZVdGRGtmckQ2TVhMelcyL2xhU2owTFF3?=
 =?utf-8?B?RjRQa2tnTnJySzFML0N6NHVZVkFTc0NrN3UzcG9xWVF6aVc3czlPVzAySDdT?=
 =?utf-8?B?bUNmYk44VWFCZUt3bUxKVDFoR2I2ZlJ2TThmWS9xaW41SDc3RHIrdnlZNlVv?=
 =?utf-8?B?Z21ZYVlZMldKaUFoSHJMV0d1aFdYeGY4aTRYcHc5Rno3MmVMRWRGd3NaM2Uy?=
 =?utf-8?B?SWozeEVKWCszVjBUcFFMbkFsaU1hNDdIY2xpVzdKYlgvTEl0V0xyNHJwRnJw?=
 =?utf-8?B?eDlidXhPbHpHVHVTSklhMW5IWTlaMXY3QmV1MW15eStwZUU4SHNZTEEydHdp?=
 =?utf-8?B?OERkM0xaVXVHR3Z0TzdlRmIzblJJVktQek9qUzJPL0RqUjI5bFJka2VtNzlB?=
 =?utf-8?B?cEJuSzBWemhteEZhZHhYdHZSUEZVbVpjdlBJQ2xXcVdvSjVKbys0RUN5cWZu?=
 =?utf-8?B?blBUVysxcG5sUWt4eDB6cFdOZ0xnRElhS25EUlBFUGdSdWxwc3BnOTYrVkZm?=
 =?utf-8?B?b254bmtLZ1FkVjVlUFJyUkVxdXora1ZRSmk4WEx6ellqMVlYWFJ3SSsydGNy?=
 =?utf-8?B?YlBmZzIrVFVXb2RPYStEeTBJWUE0MVZZa2pMbklxbWJheVhXaHRQdDEzZlNS?=
 =?utf-8?B?OHg0RFBPWU9XdUFWSEJQVDM2MzcyNnVjSVppclZTWkxpSWNDNEVGaDdBcmRG?=
 =?utf-8?B?Z01FcmlicU9iSFVDOWsrTU93Z0pwTHQvQkRFSDduak5iNzBSNUxyMjhJL3d5?=
 =?utf-8?B?ekpPU1N6aENtNzIzNktaMDlqMm1NNEdwY1ZEdGtyeGxSQktWdU5tc2JGclIy?=
 =?utf-8?B?WG9VNmtmSUpVNjR0WHIvbzJNY1dtOXpDZW1SamllVEZKTEp3R2h6VHM0Sm9I?=
 =?utf-8?B?STVWb2hHY290c3g4a0VQamdtc00veWdlNmlOelUxbVFjcUFoTXUxRzhudFlR?=
 =?utf-8?B?Y3QweUd6MTF5YmRZM2x4OGlvVks0Z3JsYWFBbjFKT3c0akdIRnZ1UFltT1RL?=
 =?utf-8?B?bzR2MmdXVGdzTEhMVGt6WlI3Q1g0NGMvWUh5T0QxcnhETi9HTXVWdGJHTGZP?=
 =?utf-8?B?dk1xWmJrL3RmcjFNU1FQY0V4RVgxS3R0QzdaSWlXWUU5cHFuT3NJYlBEaGNj?=
 =?utf-8?Q?VvagNtlxsgj7JfW8HpevYUZR5mjTsEg0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNZUVBjUDFjdTdFTTNPMDdJMUdZaVYzSUVaVkxIYVNyNzZQZG9WbjBnTUxS?=
 =?utf-8?B?ZDcwamJHMHlaaFgrTXkvZXJOek5pc2Q2bnR2NFptUGdkUHFRTnpkQ3RqN3BU?=
 =?utf-8?B?a0oyblkwcW4rcnBmTkoyTDNtaFRraVE1ckF2QzdKalNsdnAzTzRaL0UvMHAy?=
 =?utf-8?B?b2h6WTNlZmZWUERQRHlKTFl2bTNUQ3dLTXNrZUxoSmxGenJuTXRXNVp0c1Fr?=
 =?utf-8?B?MHZwV3VUUklyem5MUjE2TUtxTzdBb1NtNG5XMzMvaDh0RE9GRWtZdWRnZmVv?=
 =?utf-8?B?ZlhKeDh1MTN0akp5b3ovU0U0MUlwZGNuMG1lNU1MWFZmUzFraXB2aVlJOWdR?=
 =?utf-8?B?bllVakI5UTRYSy9LSDRLUFh3UUZXWXBnUXpWbGdSK1BSVlY1VTY1dW01OTBq?=
 =?utf-8?B?VHB4NWgzL0s1dFZ1WDhlaDVvV2NFcS80K3kwTGxhbHdIVTlKZ3IyQy9SRFcz?=
 =?utf-8?B?bWZMUlRJODNxcFFyVCtCTVk0UUo5VUE4MkZRV3VjVmJCeWdaSlN6N0hUSzNo?=
 =?utf-8?B?UmZEK3FhN2F4YkpnU2lKYnNacWFYbnl0WDlUTkpYc0UyWGpCQmhzZGpUcmtB?=
 =?utf-8?B?bTBqdnN3Q0lMbUEyNVd4bitYREgxVGRYaDEvSTY4MUxGdFV0S0xsRGNJTUta?=
 =?utf-8?B?aEZ0cGJodlpWVWxKeDRxV3JMRDJMd2FkdXdoTk0rQWN4MjJ5NkErVUY4M3RG?=
 =?utf-8?B?aXlnRVVsR01tYWtPVTZYWEtsU0g4MkI0MFIxOXgwZ3pyamxBRjgzZjBSZHdJ?=
 =?utf-8?B?L1dUWWlIWDJiLzJ0WGpScStNK1hlMUFvSlhiUGZPQ0NqaTgzRzBSN3lHcFpM?=
 =?utf-8?B?eEJZdmM5cjRvNjZVeHJTTlliYkJtM2dmaGZ0dk1VQVRZWUMrQytWSkhRMXoz?=
 =?utf-8?B?bUtDaThrNmNlck5NVGNMUmM3WXoyUXNrMXdMM3V2UHdWSU5UaUFnMllVS1JX?=
 =?utf-8?B?UGhxTmxBRlRKUFlDMTVQVWl2eFF0WTFVZlFXRVRMSDBHdThrclB4ODcvYUUr?=
 =?utf-8?B?bGpNNzQ4dTlUdklsbjdER2J2WEFXT2FVYXl6ejJpd3R4N2M1cXlydDdGdDVs?=
 =?utf-8?B?MWVpK3RGUmE4NjViUm5wa1dHbDlIWHdwanIyYTlpdTBSRkUyQk9mZ2lHRVpL?=
 =?utf-8?B?ZnhSbVpzdEt2OE5UV2FpeGgwalhYN3IyZ3JSSkRLZkw4WGpDa0RzWUtMRlVo?=
 =?utf-8?B?N09CRjVJbThDN0hGeUhlWG9nUzMyN1dPZTVQY0piTDVGZjZzS0lBemJ4Y1lL?=
 =?utf-8?B?SERweWp4MHNwVnMya3lCWWNHSGhIRnVUQjlUM0ZVWUdBZU1OU2pLczhlK013?=
 =?utf-8?B?czJnWEE2cEhPeUZHM2tmWjA3YXV5d2JLZ2tWREExQ3c0ck40ckg1M0lCY1Jl?=
 =?utf-8?B?cU9OeFpUcktsakpjN0VtRDNTUHhjMlZBcENGd2U5WlF2WmNhUFpaazV6bE9t?=
 =?utf-8?B?cW4wRVMzaXRZYitucS9yOTBrMHdPOERKSkVPWlV4YWxiQnJYYStzT0EreFNG?=
 =?utf-8?B?WHBUT2x5Z3hKTXQ4WjFLdVo3NjVSTTUxVkMrU1FValNCTFJZQnd6TVdkWkRG?=
 =?utf-8?B?TjBWbHUrQitrZDFFbWVBTmlwUXBobjZPR2tZUmROTGhLSHlBaTF3Z2NlcEdT?=
 =?utf-8?B?cDVoRVh0M3hBdWdSUkxlaXlhcGxEWlFUVk5tbUk0eHF3c1ozMU1qV0kzTGJJ?=
 =?utf-8?B?aXpmeGNaMnR4TzRkWEkrdEFRNHhuTVlBNXQyMTNFUCsrZ1VKWnpJUnBlQ0I3?=
 =?utf-8?B?Nk5DNEFYZFdqLzVjY0M5Ujd3SW15ZWJxbXhrU0s3NnFHZHVYaHBnR0s2cUl4?=
 =?utf-8?B?Y0ZQU1dnLzEycVkyUXhCZXVlb1AxZGs5L3JPc2JOT29XelJ5TjZtMlkxcHp1?=
 =?utf-8?B?RURzZFBuOThwd0FvNnF6alRXclJlNUJEWDg1SHNReGtnV0gwRGpHUFRzUWhs?=
 =?utf-8?B?MFhCUExaQXZWMkNlWjM2R2IrUjQ0QnNkeG1HbDFNR2s1V0VxMjJwYjJpdGdz?=
 =?utf-8?B?U3g3YzgydURNaU1hclR3Y0JxMGtLUDJHclEyVFFCMFVoUDdTN2d0UGRxSXJw?=
 =?utf-8?B?Q3RqOHFFTEVVM1VCS3hrRXRudVhVNm82WUV0T2x1djNFVnJmak1YQUNNbmVU?=
 =?utf-8?B?RjNQWnFjdEkxVHh3LytXZWM3Mml2U1JzYnc5eDNJd0ltUjBVbWJZNldQbHFM?=
 =?utf-8?B?b0hkaU1oTXdsRy93VXk0MG03NXgxd1NSWnBjU2pxeTBGeVdrQXoyOEF4QjZH?=
 =?utf-8?B?WWpJR01FWjB4cEgwZVprQmZPSjBBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hDVfFhkmrGQ58mqWBinggWi+EUhUoNTGbsm+hi1aMq94EYzPvI3PbFeJn132r1aql+/piBl9SeDsDyTEI7pGLtlj1luEPe4kRROkI0t0AquVfaU3kYzUIdBsBYFcIl4d+cH+v2BDg0URITM/AnKtD3rEw+whpf+UdplcuH1JG3kZr2MIYePa6zmYp1suS6PaYtpEZiZ3Ws3HNuqBmzxrY4XMnMqPgOCMUe+xDODGGSzJM5dQVU3KYHrcTSOvRggAAi8OaU8vxWVukE8jv7cF7raBRS97tlOd5oFjW8xDAQKe0gF4Q1QIh2z9N4AkFQlv5hiRjoqWrRLcOyGGZ3C9Geap7E/SxaCdiQtfOOFbH0Z4VPoPfVuVnJOrUZlHM/zo4t5EsrwOi65gJBMBFV5ltt8LKsCbh7YqAXFpzVRxIEPY2vHHcXtBoIvPslhxb2NW8kvZjL7m9nKQzihouLqWYm7zkcoClST67kQiVZ/Gbz4bkCE3rRD35lpr+rdozkNthWf3IdIaLAqmIIZVXug/Q3xonJN/lKFDkds/4dew+W40QVTJPUt+MPH4umv95PtkS7lna6A7NjnymKPQdVms9O+yZI2WWZaPXTuYpmmNHWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b803f1ee-5d66-476b-d8ab-08dd9d61e160
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 21:03:07.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxXBTRPy7uHhrdIQkQ6KD6dnm0ZFmJZY9Wx8nb1GtSzLw8BJ24q98F2711bnD1JT+OVZseSH7iFHZ6dJRTeEFhH6pYqrf3lzyPJnlOsIA/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_10,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505270177
X-Proofpoint-GUID: 7OxGQWRl8HCE2xN7zNeAwQIQ9z4kZjdu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDE3OCBTYWx0ZWRfXyCIQHHlC9QN0 3iFtSp33s80YI7723ecYf9PHQisjcxExyrTvbgaK6klZHyjWVWsuudvQ2Nu4zU3PUYZXtJ0lWvt t6ywnphyvaDFvupXpvSPPY6I30mDH62uVQew9xabSo/OjH0eZfvzoOoNjufRlIn7xCzWEXtwG5L
 aG23fYORou0841qCNq5nIuqq8fqrD3BRLY/J6syWlfzunMYsGqrdsm5ytS0TkhwPFY17S0BibDH N/rM8qHXWHSRw/weYdmUi3M59e8FwlAd1SN6huO5CmQl7zZbDRLYMk08XW/lqI4G4mVjf1k3ynp 8FTyhrfFDAl/MbwKp8UufQG/mDL/a2gs2KDWBkKr8m9RiqEBMih4C70hJ2uVd+6vBmXPn04SVSv
 03WzT0XK/dS38mLtz6Piqi/aL/9pG28CF4GghO7JjRzftw9NYFM1rTtEkgIsNWaRM+cwnv1w
X-Proofpoint-ORIG-GUID: 7OxGQWRl8HCE2xN7zNeAwQIQ9z4kZjdu
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68362890 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xVhDTqbCAAAA:8 a=yPCof4ZbAAAA:8 a=_mPn2qRBWebOHtzo1BoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22



On 5/20/25 5:31 PM, Paul Moore wrote:
> On Tue, Apr 29, 2025 at 7:34 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Apr 28, 2025 at 4:15 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>>
>>> Update the security_inode_listsecurity() interface to allow
>>> use of the xattr_list_one() helper and update the hook
>>> implementations.
>>>
>>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
>>>
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> ---
>>> This patch is relative to the one linked above, which in theory is on
>>> vfs.fixes but doesn't appear to have been pushed when I looked.
>>>
>>>  fs/nfs/nfs4proc.c             | 10 ++++++----
>>>  fs/xattr.c                    | 19 +++++++------------
>>>  include/linux/lsm_hook_defs.h |  4 ++--
>>>  include/linux/security.h      |  5 +++--
>>>  net/socket.c                  | 17 +++++++----------
>>>  security/security.c           | 16 ++++++++--------
>>>  security/selinux/hooks.c      | 10 +++-------
>>>  security/smack/smack_lsm.c    | 13 ++++---------
>>>  8 files changed, 40 insertions(+), 54 deletions(-)
>>
>> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
>> folks I can pull this into the LSM tree.
> 
> Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
> on this patch?  It's a little late for the upcoming merge window, but
> I'd like to merge this via the LSM tree after the merge window closes.

For the NFS change:
    Acked-by: Anna Schumaker <anna.schumaker@oracle.com> 

Anna

> 
> Link to the patch if you can't find it in your inbox:
> https://lore.kernel.org/linux-security-module/20250428195022.24587-2-stephen.smalley.work@gmail.com/
> 
> --
> paul-moore.com


