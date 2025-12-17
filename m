Return-Path: <linux-fsdevel+bounces-71555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E6CC74AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3647B3053C85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0C028506A;
	Wed, 17 Dec 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="dg9BPQCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30701DEFE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970211; cv=fail; b=Qr8u0fg8IZhYFvHiefvxErDBXktScO2vsnXuL4QkTcX1EKgHfRrBMt1br25wh333m5zIgAAZDfb6YmaztDsAIk2+x88arS4EZTBKHA17ucRWHEQuRZUx73j6UjeClvs/mCf7MAzzTnaJQzWbJe2QTCIlwQLBfakvEoVJH1kQR3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970211; c=relaxed/simple;
	bh=daNgCu7bY7B8QmTc+Qw+nq+H7C/p4+n4BB2ns0cdK4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aIO76lDJUpriZp7VH4LpbtCJtWTSys4TGphpkpYEs9PPdysH+qhxYqlgdwiALaEMuU2w2ZPpUJ93tNdzS6/eBVZgi5CBCcdMRG09gV7EiAQKbbLF/sxoixV4sn/0ghcLNylkD9zcw4x6yALQPX/CVmPaKviLJNbII93yW2wBzPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=dg9BPQCY; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020130.outbound.protection.outlook.com [52.101.85.130]) by mx-outbound46-147.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Dec 2025 11:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E01If3iJdbuBOs9BlFjxe3cMaWgCwzsISUBNo/WXFbXwn1Lvc2fVZsJ8nbIImW19PijYXOC3fvJZWh3ecNIJ/8+pP49B+EElWxoVtcm4xQ1HdtjoK7MZC8GBCOkdezDVcSoAzc+tkp8lCl7KqPZ1UatoVTL2Uv8rQ/0qL2mlt8c6PxIVL8k6djWXdNFiIjr+XeOpiibRCCFWSsVEc5f0Po1zOY/VBNwwFPaJ6Ra7s+KXLUkUwDt+mHNAijnBa1YSR1jG0sTQE2rrjNu0TpQqH99EsyChM1mlCgEO6WNtBKaFax8d+XrjIU12dvg2I+KDj2G8fvlMLRJe+m8PwzwbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5Z9SP8lcLnKZMmrzx4ouGdXSYUlhbDbJh04Y6mpc4s=;
 b=MpBMPcbKOHRtdOheYXFVIpcJRvOH7bDvpNwOcj4T74meA+bm2dIZ176qOsj0fpTWdgE4lj4KiwDPojmmEUspztN7dHFlvIKBoB755jtuxN6xXr9DhB/WAvrC4xg7KsHYFGJDsfwlDqjr/5B6y/B1joMTEj1L7lNX4HUh/HGJPEz5XVbBPXzRBTD1WiaIj2YtjZOAog+T9sTQGmd/yDtJ5eZqO0gcbABD2WEeqsNFjjbcNRPuJCp1BXdOrVi865hvNoei5IDXIJ+5QjY7yh8vYBEYKhGn+hdk5UGzVq0P9zd+sIdV/YtG8U4yUl/qE0GoxO+8KesVyIvJOyIgDjiMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Z9SP8lcLnKZMmrzx4ouGdXSYUlhbDbJh04Y6mpc4s=;
 b=dg9BPQCYVnZkmi8qTNLa5wFUL7tZpPfcVIVTfq2+O9ImAjUrjaGBUbKl9dcUif4+FA8FTKeEnoCMUOgD1Fr5WAAFjCErh7cGkOpMxrCKX/wdNBlWc4nKJc8CM8TYRmiYJaj35zXUl6u4MdAPgmBdhe8FhgMlnhe58k2Lj3Kcpe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW4PR19MB6745.namprd19.prod.outlook.com (2603:10b6:303:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:43:05 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:43:05 +0000
Message-ID: <8bd56136-8b23-4a1e-b05c-6f40a06a8d48@ddn.com>
Date: Wed, 17 Dec 2025 11:43:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Abhishek Gupta <abhishekmgupta@google.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>,
 Swetha Vadlakonda <swethv@google.com>, "Vikas Jain (GCS)" <vikj@google.com>
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
 <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
 <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com>
 <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
 <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com>
 <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0069.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fd::19) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|MW4PR19MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a471ac5-bc2a-40bc-213f-08de3d590f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3NlQitHVXpqMStKeUx5cWxJeFpaQnNjM0ZPOXRXVnZMbmJJUEU4TVdJa3Bx?=
 =?utf-8?B?YVliTW5Gdm1vV3lOR1EzaEJjazNoeDFMTnlYdVVPTGpNcTBjdkpESVNqTmhz?=
 =?utf-8?B?Y1VZdWRkQ1lsMmdsc0p2Y3N3L3lFY3BPQTBYZ0lpT05zMHNxcWw0RVNoQk54?=
 =?utf-8?B?V2dIaU9Zb1FnMGtsZlVBRnZ4aWltUzg5UGc1MXhLTndrOVNId1JHbEpwUXRw?=
 =?utf-8?B?QW10TTA3RENoN1Nod2t2UjFuRHNEZUlXYXZOWEZheUxlZTZ4dUkyVTVmbFhn?=
 =?utf-8?B?R2xSeTVUT0taNGUzdk43akNkNFBlS2NOei9MSldhWGdPUHNzYm4rZXhhQ2FH?=
 =?utf-8?B?VFk0eDZMZ2FYSUJGZ09wNi9LamRhMWhDa2Y0U3k1SlErVDlpQlNFeDlDR1FF?=
 =?utf-8?B?WjR0L2dzdXVlRmtGY3RUV0ZyaitUaGxZLzJhbVFVcThORXNzTUd0ZGY3SGlC?=
 =?utf-8?B?cmtvUHVuMzdGMTF1VVlCaC9aTTE2VnRUTG9MeHhtNXhrVER1bGJKejRDOGY4?=
 =?utf-8?B?RHI1RnZxT2pZNFhLN0RQOTAzb0pyWUpxNlU5QW5MbFg2a1p1OE4rTmNULzFR?=
 =?utf-8?B?RzBoYURYWld0a0dhWHBOUHo1bjRKY0dKblA0OEF6eWRVZ0dKQmlnZ2VuSGlL?=
 =?utf-8?B?S0M5aXErOTJBWDk3bm9VN2E4MHZYdmd1a1BPdXdSZGVNZ2lSaDdhaTVPMFEr?=
 =?utf-8?B?eVY4Tk51NXBlSGs2NUlaODhkWjVOL3RnTUx2TXBZUVNkaXZaMUQyUDZKV0xL?=
 =?utf-8?B?UXk5eDlhR1BHK0F5WU9wZjl3TEgzWGFnSHRPZVJUZTlaMzJtZlBhRVZTMnZa?=
 =?utf-8?B?akI2bWJqOWgxS1d2RHJZYjk3cVVsVzJZNnAwVVBnOG14T3l6dFBtdEROOXpW?=
 =?utf-8?B?alNWRlJSamlxNDVKTkZodklPRUZ3Ni90U3JhRDFpODNUeG9RQVo1amxXMnps?=
 =?utf-8?B?UVVVelBBWVRQYTlCcFpmb0kzUGxVcTFVTFhpbWFNbStYT3J3MndEUll3d05u?=
 =?utf-8?B?RUZaMU9uaGViVy9FdHN4VE1RQkRNV1E4Y2I1cS9HNWcxcjc3QUljRXJvdklR?=
 =?utf-8?B?WHhBUWI5d2dEWEplWG1vL0p0bXNpZjhDNkNNdmZ2Mkc3eUtqbUt2UXJSSWNN?=
 =?utf-8?B?V0FGWTY3cGNWbU9NRkpmNGJNNHkvUE5kZFpWcWNhT2hrYjBYbmt6L05hUHYx?=
 =?utf-8?B?UXl4VmRMeWFaVlEvOUJQSkU4WDBHOCtJcENtb2wrWGR2cEsvQ2NjWFdVUytC?=
 =?utf-8?B?TTN3MlhOKytHcTRuU1M4a0hlTWYwQjk1YVFPVVliTDdjZ3Q2SWJBOUZUcEpa?=
 =?utf-8?B?VEh3ZEhEL21BOVdMK0NEVVd4QWRmdE00bk1rZVRkWk81aTd3UFI3bGlicmVF?=
 =?utf-8?B?U2xsTi93K2VHck5ZUmFJTjRYYXRvV3RVdVVUTm1QZE1hNXdpUnpOemNvTllG?=
 =?utf-8?B?MVFQY2pXQ05RZzdhUTFNVnRFMFRDZDJqY0xKUDllcEVsUjNsQXJKNHBtV0g5?=
 =?utf-8?B?L0pDRHoveFJqMVlWMXZSRVJOaEJTeVNVWWZ2Njg4aVREUmFRblBEaWNDVXBB?=
 =?utf-8?B?eFhRb2dmbUhkSStNYXd6bWx0N2pNMEdtWXc4dHE0aVRIemRRc0EvNWNNTTFR?=
 =?utf-8?B?MUlIYXZ4NFp5TVp6SEVLSkl5MFA4bHdpVXc0TkQxWlRuZVc5SmZraWNtdDBa?=
 =?utf-8?B?MFpoeXA0SzNiRjlDWnJGS3lyM3lJVXJiUWp0UE4xWGkveVI2ZVFTYVRqL1No?=
 =?utf-8?B?Y1pUZkJtdnE0cTFIMTFtSStUVDdSOEp5TFlBWGZFZGMvd0MyM251Vi9hMGZ5?=
 =?utf-8?B?SHVvQmFoNjV0YWVHVUZVNWRDWmFVRUcvOWdNeW80RlIrOHVhZVJTRXZKV0hG?=
 =?utf-8?B?MWxQOXVOWEo1T1VSeVliaXhXTnFERzhLcmFxK0ZyZWRRS3g0eGoybThtZll5?=
 =?utf-8?Q?ON9hm8lj2npG4yF49n5CcJVzLs3ORE18?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlRHb0sxZzdralhWeXEwZkFPVjFHQ0dkMFAxbU9ma2JVMVJxMnQzR2M2MTVM?=
 =?utf-8?B?NVVkKzNBTzEycmV3VkRnNEMvWkJFZ2JMR0Jyd2I4d3pXaHBwQ05lVm1zbFU3?=
 =?utf-8?B?M1JZSTRCVm93bENLSDdNbFhma3JIVXR6TWZhR2xIcDBxT0VPV3F1OUhQcTls?=
 =?utf-8?B?ZzM3UGR3R2VrNE1LSGgyckJSaEFUbnY2U3JueGlNUUJYMEhwSG1aczQvNGFU?=
 =?utf-8?B?K0x3T1psTkc4bnB3R2lBZml5YnN3S0FYN2lmT2VNaVJubEdjZ0NCc3UzNDFC?=
 =?utf-8?B?SWtVUDFsZk9MUVFXTnVqaTl0bGpRWEhyNnJUT1ZPMTFrdTdEMmVCamxQdEl2?=
 =?utf-8?B?cEpZUGkwZGRJcEhmdUZlQ0w1STYyK1d6STU1eXBwSmJQaTRnTmF2cVI5SWVk?=
 =?utf-8?B?TG5jeCs4enFHbkM1TE5MeVFHcU54WUZ3NzdXVUdUKythK3NDWXRqblc2YlZB?=
 =?utf-8?B?cHZPbVgxb2s5RUNLZlVDN0M0VXkxeGY1dEUxY29vSlMyYTFrSWhHVm5FZmJD?=
 =?utf-8?B?YzI4N2VTbDRteHN0Sk1lSk5VV0ZweDBGc3BqN1BrZi9yRG9hUnFncmY1b2hk?=
 =?utf-8?B?aDRwdU5rZ1hkOVQ0ekZYUHBTWE5jYWpKbXJabEpKUmZtZ1k0dm9ycTYwMVRN?=
 =?utf-8?B?RTd0OW51SndJbkRzMC9pbTg1bGJvZysvUTI3WU54RXhlRE4vM251eHlWOFll?=
 =?utf-8?B?aWh5VXNOWHFWOXFFRFhLcWgxV1ltUXlTS3ZJQmNUNmo5L2F4Zi9xRTU1V2VZ?=
 =?utf-8?B?TW94ZzlqMVpoc1lCaUVUNGhHcWo1NzA3RnQwaHV6S1BkaTMyMUFNZ1dUUjJY?=
 =?utf-8?B?Q2ExSm1SZHREeVlCQ29kVkI2cFRnbFNYNC9YZngvaG40YzBwOFRtSjVQQlhn?=
 =?utf-8?B?WXRxUTQ0MTRNYWJzbHJobFo3b0tEd3gzRUNYQS8xdFdZcVNWdE5KTnc4VUdi?=
 =?utf-8?B?cUJuczhvVVlrWmVWSitGWkozcllWbEdGNmpZZTlHVWtCMjRtNTRRUGZrMVpH?=
 =?utf-8?B?UlFscUJCQlFNTnVJVm54VFpYbnFHc09zWXNOOHJNQVh5ZmVlS3E4Mzd0NktC?=
 =?utf-8?B?NGdaUjE1RzBJcjVWQnlZUkNYQmpmbW1mY2gyNUd1MUxlTHNMUWwyZWhOc2lN?=
 =?utf-8?B?WUxsODBwTlUwNzFYb3BSYkM5Wlcvb0pQUVphL2ZVNDkrTnM1WVdSbVRSRGsr?=
 =?utf-8?B?ZWM0aFJBcjRSKzFzYXl3SUwzNm45aS8yM0RrSDFrT1dpc2ZMUlhPeTVMOVN4?=
 =?utf-8?B?NFNnYmN2MUVXMDlWWDVZNG9KQU01L1FKZmlUcEZXRHFnMlk2SE52VlYwREQ1?=
 =?utf-8?B?bXdOWG00MElzb3VkUm1jaXdNbXM4dmNjdFMvc1d0bnNoN1Fkc2dPVXRIU2o0?=
 =?utf-8?B?elFMVzJtdk9QdUtRaGZsYTlsMVVtYlJSYWp5SHA5Mm9Nbnk5V3pkV1JZMzJx?=
 =?utf-8?B?Q1pQM0E4eHZMS2JwZ2w5aDJ0TWJ0bjRCQzJEZmFGaXhPeVhqbmF0NUtXUkxP?=
 =?utf-8?B?UFY1WmF4enh4Y0psbDBKbkxGZkRpMUVjN2g4dWRnYVo1NTFjM3Vjd01pc1Nt?=
 =?utf-8?B?Y0Z4dWZja3NrQWh6amRtQWEyRVBXZTFKMm5FNGV5T3o0SlM2UUxPampTMFhK?=
 =?utf-8?B?N2hrWWozdlJLSXAzSktLU3lDUUJCajA0V1dBeW44Y0tqNFZJTTNUTVZ6UHVG?=
 =?utf-8?B?Q1hDYkgzbS9ONHBpZXppVEYvdFVYM0pGNmthZVVJcUozZHpnVTNReTNwZWho?=
 =?utf-8?B?cndHK1FPMm40NCs5NjV1OWxVRnpCc0tSOVdJeWlsR3NzaWdITUloY25mS2VT?=
 =?utf-8?B?TU9STVhnY1hER3Q0QncrbzIvL0NIeTBRMEVudmJTb2pxNHJsVjBBMEtZSkM5?=
 =?utf-8?B?QnA4bDVITFFpZG9vNDFLMExOMkFkSjFUQ01QWU9wUjUrcXFSSnlNcDloczJJ?=
 =?utf-8?B?SzRBblhpSmg3WGJ3UzFNYVRZcWttYWFleG1udFhhSzFnaWFhOHl6QVBnTWNi?=
 =?utf-8?B?cTN5UzBneWMzb3FQQTMzMk9rb2hzcURRaUtxOGM4WndQT0lITUFWSmYrMk1K?=
 =?utf-8?B?ZTB2eDRHMWgycVN2WTFuN2Nib2VrbmRaV1pZbWZjNHZDR1k3dWc5c0xBRUF3?=
 =?utf-8?B?SDlnYitCKzROelF4M0VZOGxiVXlOTFhiemQwTDNpc0tVK3hFOUlMZ1BicUw3?=
 =?utf-8?Q?IjfMW50dQLgNjTuLOQyuXgizAjmdyKn1na5bDZfv5BnC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tyE3T9Rpw9Hk5ip+VDOe42jQzsOOrOOsI3RdKWekQf8bS4VHWJ/LkpxzlWqpPL1URN3tQsSe7ID4odhHJmmq4r5vn1Za3TUCxewolfHb0Xy8L1oxgk/1lPFY0w3BwUe75ZacpFzjZBJoNAGa0+5bDhBoobyE86YcNo8cdhnW0py5JA5aw9YYiVHrYosFpTeseClTnxcLJYFlVS5nlitORPCn0j2J5k3bjwClvaIuiN3hPp+eOeCJBu1nXVR7IHI/gr7FCohTYPo81ufvmB0kY0Z0HO0BTI+D+/rfqUcvwjDGJP1XvKU0BzNB8vzuzCy7o5huuEHnOWvup6Lgq97jHCdnGcidNuSCuvgU9iPOY6jNDMdCT4ORy/m4LM5VB6cUes5SGgLWlAH+mAz3rvEOCAkB5O3fVUm9ZgYPUx5iiRDvXFhnCAKuStfy5F7Wt1VWpQMKCeGTJruDjiYEOPYH08Be6hmC9AsFqfQ9ztd8O57vwQZ8iLPaJpNya0gfPKp5U95JvnqIgGrDjiARblhGYVxO3ECdF5XnNsdp2I/oIhwDL0pGiVWcW2RSYNDj6fPhYg4ubV/HPTX6Hw9HbYvrK9i0/x2ZIR+Ymu5Wor3F5cDNVNq60oolOPbLnxM+bCmP9tiPS5GmH8e3qDZPcHoQ9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a471ac5-bc2a-40bc-213f-08de3d590f16
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 10:43:05.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyTjTeqq/wF5roS8w4lN3WAIgM4XQWutk68XOHUuZJAlHBblsPJTv42TNyQ6Kcq7eh+pARi9ScgTyhcjXrS9Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6745
X-OriginatorOrg: ddn.com
X-BESS-ID: 1765970202-111923-7699-1072-1
X-BESS-VER: 2019.1_20251211.2309
X-BESS-Apparent-Source-IP: 52.101.85.130
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWpkZAVgZQ0DgpNckwNSnVwi
	QxNTHZMCnRwNjC0CQ1xdDI0MjI3DRNqTYWAE6lRkBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269727 [from 
	cloudscan11-223.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1

Hi Abhishek,

[comments inline - on linux mailing lists this is much preferred].

On 12/17/25 10:17, Abhishek Gupta wrote:
> Hi Joanne, Bernd,
> 
> I'm seeing this regression on passthrough_hp as well. Checked it on
> 6.14.0-1019-gcp and I was getting 11.7MiB/s with iodepth 1 & 15.6
> MiB/s with iodepth 4. To remove ambiguity (due to kernel versions), I
> tried it on stock kernel 6.17 as well. Please find below more details:

if you can reproduce it with libfuse and passthrough_hp it will be
certainly easier for us.



> 
> # Installed stock kernel 6.17
> $ uname -a
> Linux abhishek-ubuntu2510.us-west4-a.c.gcs-fuse-test.internal 6.17.0
> #2 SMP Tue Dec 16 12:14:53 UTC 2025 x86_64 GNU/Linux
> 
> # Running it as sudo to ensure passthrough is allowed (& we don't get
> permission error for passthrough)
> $ sudo ./example/passthrough_hp --debug ~/test_source/ ~/test_mount/
> DEBUG: lookup(): name=test2.bin, parent=1
> DEBUG:do_lookup:410 inode 3527901 count 1
> DEBUG: lookup(): created userspace inode 3527901; fd = 9
> DEBUG: setup shared backing file 1 for inode 136392323632296
> DEBUG: closed backing file 1 for inode 136392323632296
> 
> # iodepth 1
> $ sudo fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=1 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=1
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=11.4MiB/s (11.9MB/s), 11.4MiB/s-11.4MiB/s
> (11.9MB/s-11.9MB/s), io=170MiB (179MB), run=15001-15001msec
> 
> #iodepth 4
> $ sudo fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=4 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=4
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=18.3MiB/s (19.2MB/s), 18.3MiB/s-18.3MiB/s
> (19.2MB/s-19.2MB/s), io=275MiB (288MB), run=15002-15002msec


So here I'm confused

--iodepth=1: 11.4MiB/s
--iodepth=4: 18.3MiB/s


At least there some advantage of --iodepth=4. Would it be possible to
provide results for an older kernel that doesn't have the regression
your are seeing with passthrough_hp?


> 
> Also, I tried to build the for-next branch against both kernel 6.18 &
> 6.17 (to figure out the culprit commit), but I got compilation errors.
> Which kernel version should I build the for-next branch against?

Dunno, it should not fail to compile. And you are trying to figure out a
regression between 6.11 and 6.14, don't you? So it should be a bisect
between these two versions?


Thanks,
Bernd

