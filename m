Return-Path: <linux-fsdevel+bounces-51031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E5AD20B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9638F169875
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37425CC73;
	Mon,  9 Jun 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iz883pqz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/pBWf/E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7748137C2A;
	Mon,  9 Jun 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478599; cv=fail; b=bDLDED+VKVIj/yJNCazDcPbYAZf1bGEujJUgM7JcP3mYZKu6qtPVyp9oXMyPKeLepiFqwvXTC54uTWcn5NeShpXp3Ja4I5etWOcyzIF74J4YKQ2PyJ9cyaGaaMtCCA9ae6+wN9DEMSTzNxL1eFu/nQR+wwYujx1fhCbCjWUwPCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478599; c=relaxed/simple;
	bh=XZUVLKUi1+P9vgsM89HjdJ/CgpNjNtR4Vtk5NqWute4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sur9+D89i6tybRHTLRc92edNnDoIjouuIO7NdROZ2YVdjHQkr7OXcLuIqLgLdp9gu7cVVMvt20kbmE2dfPGDeGDAJ1wwrPyU6lwZGT54FBh3rg9s2QnoiBJgBHOl9ZviSL8qrnP6soR5LTfvJJSE2RbYb/yWMgEmh7XG9nRIns4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iz883pqz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/pBWf/E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593fcQW005864;
	Mon, 9 Jun 2025 14:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2L3vhKlWZUV4X6BWVG1AAUT2Fq4NdQl4lOEZCUBwyaE=; b=
	iz883pqzr2HaFfMBIVSxvdb+FaUBLzmtEzpY3WXENA27uZLe2o537Til/vmT/614
	nVgAGZj+DHOF9F4+/uLHBH8hLSUmK4TTZ73Gk69Mq27DuLdai99wH9lwVBl8Pncr
	Zmdh+2XQVne4UIJ0YoWXxXAwoKu+mGjMXwb9WF2mRhv4R4f4MYxkhVZ4TGla370f
	my9/iRN+5InoXoZEkHvOSs7cqyWue1OAXIqgf/O/EHPwggCrpYUIKd9aeK+ERxZY
	SM5yFWJpUhov3HNHjCZuUp4GHVxBcvFmYFizlVKNAkre7LIiliYub4Hj0fkGm2NS
	V9iXk1ZW6BrNkWvNqk7z8Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dad26dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 14:16:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559Dx6Tu011796;
	Mon, 9 Jun 2025 14:16:31 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8g6n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 14:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gljP17KE9gKW4QDZp+5SF0XCE+HKwJ5s+t99JiTu2i/PCpDow8efTGTWX/dkhlabpnGSU+xdU6+zZ8DKtxg878JBz36MZfblDqknPcmJrg26d+3bRxbZvX5iaRk3wtxEvlkTQxilE/Zc8mVkAYUbYSLVQxCC6urnWgAs+kF8edFthPPaTVAfz9Qe76uIfdkJEvJELfZ1CVgU9lKiNU0r4Rg8MT/rWeArbkQd57YazaTqo7l+LE8ykAQ1AypQd0+w4WwMmGiarcJaTS4P+v2fcjEP46jIpv7VcPH4JxKJ5JRTpApCKEqAfMJhveChsXhnzeHzNDsqy8Z752CqKn0/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L3vhKlWZUV4X6BWVG1AAUT2Fq4NdQl4lOEZCUBwyaE=;
 b=Ii92aolN1rAi4+QF2H6ckB0GGRnvxvZv0d7Dgr2nm5Y+0GxV+v2pNIzOc/oKUAJe+KYosgiLZQN0GjvTm0jUUZUb3WqxzPX4AZjyMauyxaREwnJpDHXtfdWQMQx0ijWGjlRMurNCMoe33SRRhNg3zc6osx9mzwgDn0g0Gu4fA2hbTqIGxNHRze6NkrkaS5sSadevPh6jtE+x5lhMrIRQCiqv48o6/Rm1Zr7v6Fxv3PdZVAIeusdGaqIzkMU4pZbXFIdCkKCk7BGk+WeAmCX3jLI2EIkLRcS0bCHbZULjygho0UkMBt5132F9j3veP+xJ9wveZDCcYFxxWqrKEHD6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L3vhKlWZUV4X6BWVG1AAUT2Fq4NdQl4lOEZCUBwyaE=;
 b=V/pBWf/EG9g+DCOxh2UsSEIr2zV4E/65lwUq/dFLfNlS75SVYcdKamF4A7Ap0vKMrpkegfo/RChuZtO8AG9TJHauwqPVfEpOj27e3gYLum76odrofXPnoTpXtrVz0iGEfk9VelvKQwWfR2dDZfwircQi1XDZ4x80l1Y5lfSdH1g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 14:16:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 14:16:25 +0000
Message-ID: <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
Date: Mon, 9 Jun 2025 10:16:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
To: Christoph Hellwig <hch@infradead.org>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEZ3zza0AsDgjUKq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aca645-aae2-4106-0250-08dda7603826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vzc0QmJHcURjSHpLaTNCWEZjdFM3K2VGU3pDQzRXOENFc3NhUjdNUWtYRUdh?=
 =?utf-8?B?UjRSTmpXYnRkKzZLZ2xJNW5HRUhxRlM1Y2hGZWgxZ1g5QjVMZTJNMTBaT3Zp?=
 =?utf-8?B?MWl4b29VSDJWRVRMcy8rRTVrN3dnTzNTN3Z3U2FXTno0TkFyaW51MHJPVTIy?=
 =?utf-8?B?QzdYdW1XS2l5STRsZGRDUEx5cTY0Mkk0bkFnYzQ3QWJqaXdtTFlEZlVPUEFr?=
 =?utf-8?B?VjZUczNPaFpSaytGUEpHWEgzd0V5eHprN2x5MDJMZUdCVGFsMDlBOHphWHFU?=
 =?utf-8?B?U082MzJ0SnVidzlCSXZsU1hHdWZ5dXByVzZ5bzBzRzRuYjZneDByL1dYVVlp?=
 =?utf-8?B?SEw1Ym9SbGdOSW9wMFFOdWM3TEVydlZIdzRDL3Z0WmlmMXFSb1Nydi8vUmov?=
 =?utf-8?B?aW8zWHdOcnB3SkR3aFBibDZPdUFiNms0Sy9HUjVOTlNZc0NGRGJ2aTFmb0FT?=
 =?utf-8?B?Yk5TVGJUWitwZXdvdUcyYVpDTVJkTmZXelpPNlIwL1M0dm9VbGY1clFNdEN0?=
 =?utf-8?B?ZEZkSEphLy9JS2dOUGZqYWVYVHVsVGkxNlZTb2UyUytzZWlwdFlSeXVJR0pB?=
 =?utf-8?B?WUxkOXNSSXNCSkx4U3h6Zkp6elFKcmF5QVpDQ1czeUo1dlVPc25tTjQzNndm?=
 =?utf-8?B?Z21jRkM2eE5rQ0ZpY09pVjRLOW9rNVNGRjVsTkhNb3JJTnpJRnBUMmc2RTdJ?=
 =?utf-8?B?WGd4NjB4UGNGOG95ZDZGakkzTEU3S1ZIMFlKMnpFNTRzMzAxUzlRUlNOVTdT?=
 =?utf-8?B?b1k2bU1meDdMem9YeHJDRzJlWjExYUdLWGhzclBXRmJSQmlUU0hzUDd1MG56?=
 =?utf-8?B?SkdXUElDQzBVRG96dSsvSmJMUFFCUjFveENLMTNDYmZCVFNtMWlwL216SGV5?=
 =?utf-8?B?QmlCaGUzU3hwNEV4eTREME4ya0x4cjRLZENFSmx5dFZ6N0xTRlBsTkZEODVV?=
 =?utf-8?B?NGFLbDVUWnNsamRoK1AwSmZUSVp3cTBDa1kydlBpUHNhTkdJY295c3B4V2xG?=
 =?utf-8?B?THNBT2d5bTJRZlNoYWN0TTNoVlEwc1d2QXpKekJJeGJWY2RKbytqMG9HKzg2?=
 =?utf-8?B?Y3NPcDBwbzlJOTBiNFpaUXFyclBRSk9ETHdCNXFydUxIZlE3VEErTW5QRkRX?=
 =?utf-8?B?Yzk2dlBTdnl3MjlUSDJHMUZKYndUdEpMTFhtSGJCa1Nid0lCYlVBUytvT1d4?=
 =?utf-8?B?SUdMMDFQUlAvSUNNOC9kSEx1U1ltTVpiTjFlU2pEVkEyZDZTS3pSVmlkQjY2?=
 =?utf-8?B?UWtXeUdmME5UZGx6RGxLNVVidjFlUFpmRy9iNGs5RUU0c2dITWZJUThxSUo1?=
 =?utf-8?B?Q2pZRGdYQUMxOU10QnhaVEhzeU5ZeVdHaUU3ZDZIdWQxSytTRUdqd2JTK1Ev?=
 =?utf-8?B?eU5jYjlKY25zb3VRN1VTdEw1akYzUnd1WEUrc2NnRzlscDAraVhQZU45azg5?=
 =?utf-8?B?cnFwd1ZyektGS3lES3hlTExBNzRwd0cvTCs0S2RBSFZjdmgrK202ZllVd09U?=
 =?utf-8?B?Y0hRV29veEMwd3dqOVdDcDV4Zk5LZ25IbTlJK29nd0wrQ1FmVFlkYkIzRkdl?=
 =?utf-8?B?ZVhUUEZIalFFSnM4KzJyU1VSSjFTQyt2TnZrR0ZQMWZ3cGYrZW1oODRaQ2tl?=
 =?utf-8?B?STFVRFdHUzVJSzAxSHZzQ1FCQUZJRmpxMXFyWVFnOVFXUVk1dDIzSkJkRTRi?=
 =?utf-8?B?eUdCbWtlaEovQ0VXQlhVbXV3S0lhTHgzTmZIR01MWENxaHhOa3lpMHYwYWdS?=
 =?utf-8?B?a1hsYTRLcXFGbXIyR2d1aGpVYk1NSC9pdmkzS1JIU1NkdVZpdVg1WTVPcFl0?=
 =?utf-8?B?REdKbmtycVRLN01jWXpMNHE4V3ltQmsydWlDeE4vemlCcnBqZWZxREk1SW8v?=
 =?utf-8?B?TEhZVDZqMHEvdEI2ZkkwcGpJaFlYMDRjeU5RbEFaUlhJV2hCNzNHZGdQZUlt?=
 =?utf-8?Q?Lw6qhDY8M+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzBvVTZYekRIeXJjQVVmZmd0YlZ6Z20wR1J0QklRSVZ4QTdjb3FmcWhObllJ?=
 =?utf-8?B?Sk9rOHFQUC9NSWdnVis2ZmVqRStvMHJFNkFpSUQ2UVdmbFFhV2lzNlFBMitw?=
 =?utf-8?B?SDExNTRReUs0UWJqK1hZM0l5RksrQ1g4MXJKOXZlOXNEa054L3dTK0dMSVh1?=
 =?utf-8?B?S3NudTVwa0FpUy9VK3A1VGk3RCtZaC9PNUZkK3BJTEtQTGNjMW9DMHJwSDZq?=
 =?utf-8?B?bTVPOTB6UWtvblBVWjNrWGt0VHhRcDZ0VUQzSGxvQXlMVXQ4QXlFa2xUQ2xU?=
 =?utf-8?B?MElPRGxLVExWRkNVZW5hQXU4TUxCQ3hNTGsxMUhoUC9sRURwdUNkeUwvVE5s?=
 =?utf-8?B?UldIdm0zK1NOc0pBZm56elAwNldPU1RocFcxV2hHRDJaazdkbU10bVpLZXJC?=
 =?utf-8?B?UnFXdSsyUE56SVRDL2I1ODQ2TUFrVXNzM1hFeWMydVk5djIyZXlhWUJsRDUv?=
 =?utf-8?B?ZTJOc3lETjBsT1dBdS9LQXRtNWRrV2RrdTFQcTRlcndGSVR4TjF3bzRWcjBp?=
 =?utf-8?B?R25aTENaQWlIVno0OVNrbCtpc0N4Y2prbzUvMzhITlhraHpOd08zdXdTWUNQ?=
 =?utf-8?B?WXJRdEFwekdUY3NDbnVnSXUvUzRPVDlEa0JkT0k0RU91b2lYanlTZmd6bVBj?=
 =?utf-8?B?aWg3ZE1sTnI5WG5vYU1ESjdmNmJudlNmUk1ZV0s0Wnp3SFU1OUFtOTlzd0h5?=
 =?utf-8?B?cWlIempvNldyZ3RETWV3aEF1OXcwSkNWWW9wQTd2dVZ2bWEvOW1Hb0NidFNq?=
 =?utf-8?B?ZUtNR0gvVjIrVzZYZFhvSkJia29DK0FqTmR5K1kvMlNBVFhuZGN5VHlTaGd1?=
 =?utf-8?B?akg5cENwOFp1eVlLc01HeENlbWgxMExCSjduTzdwOEVpdk9VaHpTODRWQnJW?=
 =?utf-8?B?Y2txT2ZKWk1nZGh5eHlYdTFUdTNBYk9EWDBIeVBhWG9tRWVPdHpjUnBERDBM?=
 =?utf-8?B?K0l1dk5PaXpZcThaMW5VMHp0TkRDWE00U0pNQmc0WHdpayt0SytvUGxGSXIz?=
 =?utf-8?B?QzZLaWg1TWJ4c2M3V3NROFBCbEVJaHlGdTVkNzd0OVk2VVZQU0s2NW83ek9T?=
 =?utf-8?B?S2FBYi9CUS9lRC9PUjY3emNETnhTRkY2a3JhMitvYTZjdTl1WmhmOThrTzJF?=
 =?utf-8?B?UUxrMkJaNStvaVk2bUlqZXo1WHR5RkY5QjFBSXEzZzA3ZWxaV1hGLy93Zm4x?=
 =?utf-8?B?SzdvNkRjc0didi9QNUQ3VGFCaDBITTdZMERLM2pLdVVLbjVmdU5KMHU0OGZF?=
 =?utf-8?B?NkJiU1UxQWt3YWhCY3JtakYxTS9yeU8xUDJ5STdsaE1JSlUvcXBlRlFQcW5L?=
 =?utf-8?B?NjRrUVhWQ0hiQWZwMUZselR5TXRZWmJDbXpVa1RORVAxcEhxemQ3WDgzdFRC?=
 =?utf-8?B?bVg4NGlnNWxRQjhtSUh4cCsyTm9GZGtHK3BudURvYktUZUFPYVVUa3Ezckts?=
 =?utf-8?B?VGZhRTZVa0NtZ25EM2JmR0l6SXlMYnZhejVvdkVWNFFFUzJXeWVNYmNQa0pH?=
 =?utf-8?B?bTd4ZGZsY0QxZmordkNFelJ2WEthMnRhYzZrTmh3ZUZNWE5UN25WTkhIT2pO?=
 =?utf-8?B?WENHSk9CYnEvdStlK2tscDBVMEJ5OHQwdU5jc0xyUTg2Y3FaWmxtYkR2a1dJ?=
 =?utf-8?B?T2loN0FaZUVPcEF1NmttZ09VZy9BaXpXeTJoclZRQS84M2p6elpqTWYzQ203?=
 =?utf-8?B?aUJIdEFVRDc5QWowVlNXMkUwRW9LZzgveWtOSUs3VEN1TFFxbE82Zkw5NmJC?=
 =?utf-8?B?NGI0YStWTUZXYXlpMDkxREZ1ODZzd0IyREJ0THY3WHlDK29ocHBmZkxoL0RG?=
 =?utf-8?B?dDl5bU13MFVOaGU4eUNpeVRxa2lUNWUxQlBtbDh3WC90M0RjKzMxbm44T0Zp?=
 =?utf-8?B?VXFCM1l6em5kRmQvbmkxcWRSQVZRYmFEaXNZa1lEZ0I5dHo1SjdWQmF2VVlH?=
 =?utf-8?B?T3IwWUdxTWcxbk9hUHhhaGxkcDlnWCtVSzNrQXY2Y1hSQUtQK3ppSnlTZS82?=
 =?utf-8?B?Y3BFbkRlSkhMSjhoSmpkV3Azb2pwYjl4NllRaFVYUW5kOVRobWVaYkZHWVpT?=
 =?utf-8?B?ZHNpY216TE9BelY0MlJwNHlWMmplMngveDFNbitXdEh1VzdqZ0xOcENjRGQv?=
 =?utf-8?B?RllIS2laOWt4RXdsUW5mSWV0NURoOVRPYk5DcnRMZGhVS0tmdTZOL1NqWUt6?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Gw2f9+/wq6XzfLFJyzETjsgJFYLKgLdpKAnXzEaVcDg6nU4NXRxmyKIddyY3BjuvAg3VQeoWBVCfIzGZFqFWlM5N/G+NKAqLUPHopyJxA1YXdxAwApaHTG5gE+60Ce7MX+jyvlUCdVwJeNnmCiRIOssKdwpOI5kbYe/9s2PU38MvaFceMwEGsRT3cFK0kCsRw3BbZ+hRcOyqqM2UobLx3XmZcGt/1RR8AikkHhpPLMllVM3cfkeXOAticUyzcDoj6FRbZYTy8cXI2oqodoiWsfCQV/ohRElnyi5v4yCGZnNMXUzkzRrteyAADhmfNcjA3E88yRYKznkwTBpgsY86Xc6gu9fAQqWk2GzGcNiDyuX90mrD4GRFaP4bmuPi3VVNcXLAE/Xm5f64vFSJ6bKJiHBbGkVwXimT4U2saOuiuBgjSr7mIxQrL4LLMPg1C6T9BZSoAxdXVaWvIITx7XRYpBPvtByBGg/nj5/Nh0F6NPltz041MbS3auWqqrvy6eU6CrPfzv7wnq62a/K1VDfTQ+7qw1IMK5ARViPjGe0mF75A81x9EJWg1Xxl030PRqtzh2zvMZ+0zWbULCgbrR6mjc3PHI3dqYEOUBKr+IBNLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aca645-aae2-4106-0250-08dda7603826
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:16:25.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+EqaYUTZxIM3AY1IW4DXmtcsTfXOkEJyuC++BCNEWUzXbQZ4VgWHaXeuvsq1EypPAhBu9BqCJ4ekaBNHa7NyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090104
X-Proofpoint-ORIG-GUID: m5iKk_3dqOxJZ2sPdN16kEviEu8EAdQ_
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=6846ecc0 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=eJfxgxciAAAA:8 a=QJxrZSrV5E6HhGdoJ0cA:9 a=QEXdDO2ut3YA:10 a=xM9caqqi1sUkTy8OJ5Uh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwNCBTYWx0ZWRfX6ZJYpV7+ylmP J234pSszecogxCXz21O+IWpg771u1vXGN9E1I8Fty0w8vnTpWMGCeUMlCaO/gPt5AuoeKSNeva4 wgLoqr1rqcOgABCJ2V9wAh1pM9wSRLmqbCokGTftQIhVwqC0Ilwe+zPS7n8yKZOJO7481bFVOIz
 cudiAgZyP5v8pEi0+cDIfR5hiuj611t9iFiRqp8veqZVVzgvYLNx0uo1OOK5MD1daFLHIew9SaP G1jAibESRzwM5U5jQrt7K9WywQG8B8eKwtogDJ4N9syyorE2dC/beexDV90woihMOzeHrBBjt6d AQGH77zLBDaRlvLItxvIKFKuMnf+xirZVmLImlmh1AeqGfICoFIvvqwoamJDydqVV0J69LLTizp
 g8+JVRgjRXYkg/Z/sr43W7B/JoLMVGuQvUoensmbdx+dPrmSF83TPMTgZlAPvuopN7BTasF0
X-Proofpoint-GUID: m5iKk_3dqOxJZ2sPdN16kEviEu8EAdQ_

On 6/9/25 1:57 AM, Christoph Hellwig wrote:
> On Sat, Jun 07, 2025 at 02:30:37PM -0400, Chuck Lever wrote:
>> Until very recently, the Linux dentry cache supported only case-
>> sensitive file name lookups, and all of the file systems that NFSD is
>> regularly tested with are case-preserving.
> 
> Linux has supported case insensitive file system since 1992 when Werner
> added the original msdos FAT support, i.e. it exists much longer than
> the dcache or knfsd.
> 
> Specific support for dealing with case insensitive in the dcache instead
> working around it was added in 2008 for the case insensitive XFS
> directories in 2008:
> 
> commit 9403540c0653122ca34884a180439ddbfcbcb524
> Author: Barry Naujok <bnaujok@sgi.com>
> Date:   Wed May 21 16:50:46 2008 +1000
> 
>     dcache: Add case-insensitive support d_ci_add() routine

My memory must be quite faulty then. I remember there being significant
controversy at the Park City LSF around some patches adding support for
case insensitivity. But so be it -- I must not have paid terribly close
attention due to lack of oxygen.


> That being said no one ever intended any of these to be exported over
> NFS, and I also question the sanity of anyone wanting to use case
> insensitive file systems over NFS.

My sense is that case insensitivity for NFS exports is for Windows-based
clients and/or compatibility with Samba / SMB clients. But it does open
up a whole bunch of twisty little corner cases that I'm not terribly
anxious to bite off and chew on (See the i18n Internet Draft that Ted
cited earlier just as a start).

Perhaps if we can narrow down the requirements and deployment
environments, some limited form of case-insensitivity support for NFS
might start to make sense.

Does it, for example, make sense for NFSD to query the file system
on its case sensitivity when it prepares an NFSv3 PATHCONF response?
Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
of internationalized file names?


-- 
Chuck Lever

