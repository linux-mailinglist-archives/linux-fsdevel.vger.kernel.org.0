Return-Path: <linux-fsdevel+bounces-79239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCLQNoDxpmnQagAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:34:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276E1F18F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB5B307EFD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221133DEAC2;
	Tue,  3 Mar 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/UP2Thi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sirIUePR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55E3B4E94
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547879; cv=fail; b=M+zi/H/Z+3CHEJTStCjUrDfPaNyFb5FfRe9OncVzLJcxP9XysQLQfCc7AOIUlFPbkH6eqJj0FaFI1JluYNsAn6omAWaNlUegJYeyCdWcXlODob91rkXxNOHpsTnxZHhxvKQZCzcfg1sYfWuajQ//GlX4G9LHt4XNuOLASxDc2hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547879; c=relaxed/simple;
	bh=V/X0efB/EtLvd2OZqvaiyntHOoLXJGWQUsqQh5LDMEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pq1frJWmW2KkfE3tkzVyP4Hd7DW9a3eku77JDlfZUtDQtZcqA8m8Xfx0ZTvBZ3avx19jKMCtJC2F400DaVMA8ueqbkzYtfiU6Ro5+zFeLo/CjZbXjec0c5KS/iX1IvuF6q2+LdW67mWJ7ZGm4wD9kj+JkgbwaaRlsLY/77JFplA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/UP2Thi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sirIUePR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623EFsqt281347;
	Tue, 3 Mar 2026 14:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qW4cJokNHvYHmqhk5PMhKoVlr+5FJ2z3lICmGSH7m04=; b=
	I/UP2ThiDvrzalLoBbdQ1EJ1WMDGhmVmjXqyYS9ZcnooFZIVr0JXPyX47vpEyPEC
	uBv6+dslzNktu9rjJ8kEiavLiR4in/GMgRp9KUfEsHEqaSzBtYZTZ0whjla1DTBE
	yQVb5lNON0MEl3B/CzyESXJbutaSfgwwNwG/ooXNVXYvJ3Vw4blR4Jsqzcm1UepK
	A/g+aIMlhyfMH8KRZjPoKvvcEjvAFZwhnOJT10q2N88q06B+82/oFrI3p60B0roq
	Aiwry8x+Ukoo8Xldpehx1O5RsBeb62dnVxqzI7I0x48mNC3jeORnAEnF1Q6eMcH/
	krmx+a/dDuUB9hnrMk6M5g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp18mr0f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 14:24:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623DEl65027528;
	Tue, 3 Mar 2026 14:24:30 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpta4qqb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 14:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8atd0MYsVth0aDJVjoBngAMtGj+Cg8TbwdHxiEMFucTJZKfjGrM2hj+gnYiyyDfVmsDEfF+it3WeMEtNxClI/TuOj+frsrZyEs1ZJVJ2sIvS/+QNvrcZTQvXk3Z82I6jrUJxyZqFM//5S11rA5Wwm2H1Ogvb+6hPc5vFrV8x2uhQFKBKtkFJ4VpfKXYH6kXxL0uveaYyP/oxXXHVvQkYz7Wr2p0KcDdSf/VaFPdOCIIdh0DY1X4BkRdc7/Wfb/Yrc562TYzx4AB2Xcs/sC5LJBAzWYQbwa2vUMFXw7SoCM4gE2LhOnq7IHkqdCcgmv0WF6YuraogvH7JZDUBzmE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW4cJokNHvYHmqhk5PMhKoVlr+5FJ2z3lICmGSH7m04=;
 b=Jtw6n2tDgqweWE/RJbP2TC0JKsW+xCrdGiTo3xAtHdXSg99fSH9B+prnM4pRYGv4PjiS/lrwzsNQ0HjA6PbDT/d98NP1x7mRj3V4jR6RVIuTlQAiUuDEQKCdAwSOJ5MMYeDHMP2gDIoZidK200wTxNqYHE00x78sjXrb258z5CanB59hx0P4ddrzoWD8sCRUdn7KFUoJA4m2nZbyM1XgnWm3ylPDsuxRcLtK7z9FOxt2fw6H7i1mdvZ3VTG5vhc87pvcvM8CvRUkOh4/NUdBXJvIlhxs3zKbWXW6zxT7/BWlVmHhfZb2KzPdEnhxh9DBsB0rNJfichch82upsVLy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW4cJokNHvYHmqhk5PMhKoVlr+5FJ2z3lICmGSH7m04=;
 b=sirIUePRYLTrFoS3nLKDuwL8Jr7fr6pgt5YbrdVN169ZlMGiwhAT+0wjw4Lf+Sz2++conNt6S6lb28wwbkTSPWg6pqRoctM6gfKlPYO1rEJNVJU1+j6PetaLjcl5hNuP66Vg7Re7OhCOuKDvUTQFopJe1WhN78VFSsd8JA6JxmI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 14:24:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:24:26 +0000
Message-ID: <b2e28d69-ede0-4e42-9d76-2f14f68479cd@oracle.com>
Date: Tue, 3 Mar 2026 09:24:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: use simple_end_creating helper to consolidate
 fsnotify hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
        NeilBrown <neil@brown.name>
References: <20260302183741.1308767-1-amir73il@gmail.com>
 <20260302183741.1308767-3-amir73il@gmail.com>
 <fc9c776f-bc8b-4081-ad9e-b4ebc40b9974@oracle.com>
 <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <CAOQ4uxjHeUBfFLwahmaHj+ZKq=CxQGShi1-m_HQuWSjMa=f1-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:610:cd::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 32dd98f7-2116-48ba-e61b-08de793092dd
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 utDsDJaRmPdDFYYMXE0c37LhTCMxaVtElNKNNc0n996eIwFX0ANWBmKpx+twNQ1MzQ7sYVQnDiB8B8DV/umuhcBPBI7Et7DxKKkYlthaZLjHmJhSSfD9lBitwLu9qVgdaHgQ4vSXuGZ5FCxUEh7oHQP+ElFCG2kO+8uBE4wUuFPIuouizXuawcDGJFhD+hB1HWFXgmmxkNwIZrz86h8Wft+I6P5ZiQlDaFGG/Us6IrKWAJd9WWotpQ+Lg+8XR+FJ84vKbicwDEGwbca8ARJdZW56aT9gdwVlXKo1mPKkinDRoxNpTuCDIwVaEqyhkKvu/imEkcw0lK9Fb10N89p53x8T5mAZrb58B5DDonNTjaQR+2gT7fUZHIj2aWShGRRRt1Gje7rMwfRMjFMcBaKz/aF0Ls5I1KzlvuvegmM3PXev5NRP4clc8SzJFSev/+YnW3yLy/U6QeQJh7gmG52UTEWrROyjpgsPh1GGNHv2t0o2qtXdN9VACaJByciL8PvziuLlWT0NarsEGd479iT9iFeh+qKKQx5qsGBEILuQVHoiYISyf0T9USEIUISdm318IejCmlXer+uwq9rSA+a+BXAP7hmO9OQp278tI3bumRwvwFGuuMtgbuifV8PmxlD/w2w6wLakwMZW9wJLedOn0mXq7wvVzBCFn0W0XFIz1dy9zFi5gHv/P09Y1YGGYGyvxlDukk19+Z4GyXT12Yre0TUOMH11qpOtg6YNhOrbBIc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUppOE0zeVZFdGR3OXdVbEpNeVlDQUkzaFB3OWszNCtab3preWJYZTF0SDF1?=
 =?utf-8?B?U1BHRlJnSnhDazR1YnRmU3UxUHNwaGFCZUdNTE11Q0tvdDg0NXFSOE5mMmZk?=
 =?utf-8?B?S254RGVMclU4MlJwM3hHMTUvZlNMcnJERkxEZXlPMGNqVkNqNE9sSDF3VjBB?=
 =?utf-8?B?bFdtQmFwYmxTMEtQUjEvSk9YSm9YdkhxQXR2d3prdnU2ODE0UVBYVStTYWoy?=
 =?utf-8?B?NkRPVUhFTGNuSWVwenJ0SHVUb3JMY2xQNW9CQTh0ak1NN2NuR25IaWhtNkpr?=
 =?utf-8?B?L1BXZmVKOGlYbS9PUnh4L3BjRzZES2pveG5nRnpEellSMG5HSVhKZ1ZmazBm?=
 =?utf-8?B?N0hxZWtPb3dLM3dVdDZnNEVDempwTUNBbnRqa2p3WjdKeVUrNzZjR1pFcDJR?=
 =?utf-8?B?YlpHRkovN2F5aVdUUGdUejJVNlV4L3JqcnNadUUzNmdtcVRadSt3U29jN2Jn?=
 =?utf-8?B?UVJaN0lGY1lBVjExUDZtYXZpQmtDZU1PTDNBS0Zqa0VEdFhEMFJkdVp6ZUZl?=
 =?utf-8?B?dlQzaVd6N0dmRmdvN0Y2S1ZOMVJ0L0Rvak02ME9LN2JHMUN5SFI3b0d0SFpN?=
 =?utf-8?B?ak1rOUpad2FYOW84TVdwSnVmYlBLUmpXM2t3QkdMQUsxNHg5ZnVINkxFTHlo?=
 =?utf-8?B?U1dQQ2c2UXVqOGZRaURnb1E2aWtNSmhTTkVrN3J6akgrTC9INE1BdjA3Tm54?=
 =?utf-8?B?Y2VLbDNzQkpHWjBOTTcwa1pOMU5Db3ErUytIekhMWGx3R3dtWllDMTRsNUxN?=
 =?utf-8?B?QUt3blBXVHYvT2lmbGFIWDNuM3RmVnAyNy9HMnd2UkdXMzYrdTBwSTZ4VGlO?=
 =?utf-8?B?NzhyNUhNQk5SRkZBajM4RTlDR3MwcjdHNTAyOHNDeVZKeGNrTzB5WHdxeTVx?=
 =?utf-8?B?eFZrVGFIYjhEbXhFQmpnNm9GS3hvUHAxeXA0RE5BMXlvY1pRaDZyZkhMNGZN?=
 =?utf-8?B?Z2gwN0lkQTVTUldOM0ZMa0tkazk4OUlnbjBaVEUvQ2tXTFNzejR1Tm5QWTZW?=
 =?utf-8?B?dmFsK3B3L01IUForci9QSWZsOENYeVAvYkw2UzJGSzlidjIwVW5xZWwvK0dz?=
 =?utf-8?B?bzV4Zkp3N0pRQmxNQkp0ejFtZ0FjdVpzcXVoUzlKVDF6WEk1aTgvY08vbFFC?=
 =?utf-8?B?L3BCUmxUeGZ5TExadlZCRU16WnV5dnU0MzR3Y1E4MDF1Q3FlTjlsdlJYK2tZ?=
 =?utf-8?B?b256bGRKL2ZPQjVRV3hRT2NtcGdvUXA4LzZGeG5PcVBiNUtRMVBYc05ENVlE?=
 =?utf-8?B?MXZUQ3RZbFRtb0Y5UG5hVmZENXg5V3hMOTkwRXFPaDk3V1dsVHNMRVJiV05C?=
 =?utf-8?B?eXNDb1lrZ3FXb09jY1o5TUZWMkJFMDJETGFKMERoMkFHVUpZblcydWtyMTFx?=
 =?utf-8?B?eDJmSjRMZTNQYm5RK2lBOERzbDFtMFhGSUVvZzVUc1hZVWpEZXFLTVpRd2RB?=
 =?utf-8?B?VTZ4M2YwckxTVFZNSTFqZHFmNkhiZUFwNGRBLy9QbVNRVW9RRzVOM3E5RXZi?=
 =?utf-8?B?dmFuM3NrQ1F1czFBNWlrL2NISjdjV28vR1U5blBrcXc1S1Noc1Jab0ZkYTZs?=
 =?utf-8?B?V0lsK2ZKNEFaM0srOEdWbU1hWnhHUUpVaEFqT1FDMFA1ai9tNUZiZzFSL0xx?=
 =?utf-8?B?YkRyL0NvdmFDRXRXMzlEMEZkWnlNaGVLckloYXJGUE01a0RPTFI0MUV2Yzl1?=
 =?utf-8?B?OE90aEF4TmJsSEFzY2NCNC9ZaWh4UnZZM29uY09pYVlsS0srMXZOSCtBL05t?=
 =?utf-8?B?WjA3UVhUc1l6ZWdIMWc4NDJVYkQ0cUhLbEdBSHRSalpRM1JyMFdncWM1WXNJ?=
 =?utf-8?B?QVRGVEhlb3dERmdXeFV4Q1VBcnlkVWxEWVlhSWY1dzhxZ3F5VWxIRHlsNjNT?=
 =?utf-8?B?OWt1NWlkQm5ESXozZklwQjNjQ2R2eUNkK2MvdWFLNENWUDJIcU5HcVl0d0Zi?=
 =?utf-8?B?QmcvcDFHS0FyZW5Cb1k0ckk0Uk5YTDR0aW1STUtOR3lISXpaRXVKL0hCeVBE?=
 =?utf-8?B?YWs3elVKdVYzK2lZR2ZxMmhjTjhTVXBVQi83VVVjOGJuSFNXT3dERnhQVlhk?=
 =?utf-8?B?ODhlem9jTkZWQ3RZNWpoZGxIZWdKVmpEbnZ1K21wc1FqTjh4NDd4QVRPUW11?=
 =?utf-8?B?TWJ3NUJJVXNzSDY0dE5Wc1B0TmlrTXY2U2F3UU42Q0JDNEVqd0Z3TEJGWXFx?=
 =?utf-8?B?YWJ2TnJzMnNLeWFwQ0gwZldTeSt3WFVmeUpNRnBSd29iNFdQakdqTm4rclNF?=
 =?utf-8?B?R1VmK1VVbDRiL2Y2VWNBc0VzQS84S1dTa2FCU3VhS2lrejAyMGV4dGZxVHBG?=
 =?utf-8?B?SEluTEZzZit5L2pGVlF2MVluVHBTSVhzM0FIWGdtL2JjUExxL1g0dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5hlqq619qntgMm+1kAVPEhI7aiRuWcHgjiQaTo5EwYqWjMdX9R+1LeXe80tHbD9qDBx9nfIW5KRpDYPxsvtGWOpxVko2cuKc4n82C/UMpS7djetMCcI/GBKlCCslVlqf7FUmte54mQwgERguPm7cXLeQ8G0RxpLldZ+hAHSjAVqrH9I5j5Z+XeKuKFGlEwHxBpijWRzMha4b0cXZqcnZC2cxZyG2erg2sgrRPTbkbGlBNGyxG9+6t08UY87Cg38I7j4Xz0Ui/hNYNTydlmTDztwt77Jv6bavD1JKfIDJe5w08diY/Zw34ALeEf98iw5KexC0j8693PibK7nTV1+t/JjK3oXxh2G8yBZECzHFaEcPpZWfSSzTcbdkBEadTS8wMUHzSJpi4wIvgJYRcLhg2zngYH6EuFCyIU4tPANxvXLA8tjt60TSqSwteSV4+/ehYPW2SzYzlphOg8rE1IKOwn+ngJ/WJsANlMpTUKoOhyp/bBDxBgKik5bP+cg5tIcbcPHqrN4fyGXV9U5FgtY2U4XWi2SOejkEKaQeOOv+zkh4w0U26O74Z1dWEzMDvlvjtePcz/pTV3ehoIjKs5TbixNBvmGoxVa4GV617W00o+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd98f7-2116-48ba-e61b-08de793092dd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:24:26.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmtaplF6rPRwoGdhh0Y5mx3tLKhZWwpCsTdcT4Z2tVsgSAzrLNHop8LhUqXdNnTpFUVzQN0PgQbLcnsZY/NObA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030114
X-Proofpoint-GUID: Mra8-qwhdTBwERxcfG0TRpdSZIXlhKcn
X-Proofpoint-ORIG-GUID: Mra8-qwhdTBwERxcfG0TRpdSZIXlhKcn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDExNCBTYWx0ZWRfX7ztIJmpMCwMt
 y6V5NNX2uy+ChAZ0SbGhJHE/qnDoZin4SNhPD6vO6SAJe2YOoGUh1/5mIZAFlHWturrC/w+76ry
 ljbmqqAOPAlAxEah6AB7lhau2JIVqz9ewJsvVc2PSOrepM2mf9LuFUP3NU0nD9hjQjqINE3JdGy
 92mk/bX7l4QwX5KRs0xhvQDLV8/jWhaP3F1taQunFIfL5ZtKxR1pZVmqfYUqhPU/Cj+aHjyNHVH
 5onYgz8QMsGUYMoRtIw9RQ7irjuaP0RCf9VMm8lqhjngvgk4oGxZtMGZm4r0NZbnq8nvaGNSsMP
 5rIWbhXPlPSrjEc1tqEeiGthzycYscWUvSoYzJIrG4IJyeUMr4yv3kBZd7X50syctFYlQ+32kHn
 6Nw6wqqdOQn+Z4j6Ue8NlDNyKzEicRAIG3+H3+GH+ubuXyP6rYDQXxLdcmLkHwljecanLbeMsgk
 XgS/GdDTPX/hyQZl5PQ==
X-Authority-Analysis: v=2.4 cv=HPLO14tv c=1 sm=1 tr=0 ts=69a6ef1f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=zO7uOHDQm3MjoJfuk4cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: 6276E1F18F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79239-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/3/26 5:05 AM, Amir Goldstein wrote:
> On Mon, Mar 2, 2026 at 11:28 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 3/2/26 1:37 PM, Amir Goldstein wrote:
>>> Add simple_end_creating() helper which combines fsnotify_create/mkdir()
>>> hook and simple_done_creating().
>>>
>>> Use the new helper to consolidate this pattern in several pseudo fs
>>> which had open coded fsnotify_create/mkdir() hooks:
>>> binderfs, debugfs, nfsctl, tracefs, rpc_pipefs.
>>>
>>> For those filesystems, the paired fsnotify_delete() hook is already
>>> inside the library helper simple_recursive_removal().
>>>
>>> Note that in debugfs_create_symlink(), the fsnotify hook was missing,
>>> so the missing hook is fixed by this change.
>>>
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index e9acd2cd602cb..6e600d52b66d0 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -17,7 +17,6 @@
>>>  #include <linux/sunrpc/rpc_pipe_fs.h>
>>>  #include <linux/sunrpc/svc.h>
>>>  #include <linux/module.h>
>>> -#include <linux/fsnotify.h>
>>>  #include <linux/nfslocalio.h>
>>>
>>>  #include "idmap.h"
>>> @@ -1146,8 +1145,7 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
>>>       }
>>>       d_make_persistent(dentry, inode);
>>>       inc_nlink(dir);
>>> -     fsnotify_mkdir(dir, dentry);
>>> -     simple_done_creating(dentry);
>>> +     simple_end_creating(dentry);
>>>       return dentry;  // borrowed
>>>  }
>>>
>>> @@ -1178,8 +1176,7 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
>>>       inode->i_size = strlen(content);
>>>
>>>       d_make_persistent(dentry, inode);
>>> -     fsnotify_create(dir, dentry);
>>> -     simple_done_creating(dentry);
>>> +     simple_end_creating(dentry);
>>>  }
>>>  #else
>>>  static inline void _nfsd_symlink(struct dentry *parent, const char *name,
>>> @@ -1219,7 +1216,6 @@ static int nfsdfs_create_files(struct dentry *root,
>>>                               struct nfsdfs_client *ncl,
>>>                               struct dentry **fdentries)
>>>  {
>>> -     struct inode *dir = d_inode(root);
>>>       struct dentry *dentry;
>>>
>>>       for (int i = 0; files->name && files->name[0]; i++, files++) {
>>> @@ -1236,10 +1232,9 @@ static int nfsdfs_create_files(struct dentry *root,
>>>               inode->i_fop = files->ops;
>>>               inode->i_private = ncl;
>>>               d_make_persistent(dentry, inode);
>>> -             fsnotify_create(dir, dentry);
>>>               if (fdentries)
>>>                       fdentries[i] = dentry; // borrowed
>>> -             simple_done_creating(dentry);
>>> +             simple_end_creating(dentry);
>>>       }
>>>       return 0;
>>>  }
>>
>> For the NFSD hunks:
>>
>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> FWIW, you are technically also CCed for the sunrpc hunk ;)
rpc_pipe.c is client-side. On the next round, Cc: Trond, Anna, and
linux-nfs@ .



-- 
Chuck Lever

