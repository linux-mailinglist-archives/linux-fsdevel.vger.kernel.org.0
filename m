Return-Path: <linux-fsdevel+bounces-42686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D795CA4628C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C23D163857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A23221735;
	Wed, 26 Feb 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QjU2H/+i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vxoxmQSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95821D584;
	Wed, 26 Feb 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579633; cv=fail; b=PeCCJcqQFF2A39Q+d/opVBEfFg6y55xk8JU7k+GKo9yaUxnDnWuikkibmCRjU1zacwgi1Zn8tI9n6AUXd+PMvWwsE3PYwJhVZ8hbkp2rbtjIeJDVr8kdkOCmuY0Wajw97PWlKrjrm/iDWlIyItnsZhwD6VU7celdCgDhD+vIAFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579633; c=relaxed/simple;
	bh=9PgiM+tv1dU2RFTGr3m0BdbjxULHwugh/fxmy/6iEuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNqTO0xo/8MmJihDt4D0BKbyFAX4I5KgRaeBw5nOYH7pMzGpgp93f3SLtYpr00fqAFzd7tEuBujON44T8HGZWXub+q/XBbfPisylQ62HRb8DOw4cgrPGQtdyQlH+dc172y0iCy7kJT10pm4NrFK+zIiGEExM/81Y9H3QKaJllqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QjU2H/+i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vxoxmQSS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDtYJj032226;
	Wed, 26 Feb 2025 14:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=l23+RAmbD1qscDs3VUm5nHyyP46g9hVdQOWz/i3TgWA=; b=
	QjU2H/+iRk/DQPvUXZvl90QiRpGQpU+u4EbqvcArD/ZZBNmaDv8/oqevwaks07Yx
	kJ+6bnKoSJO2oIgrppNqwmzMw91JcJPKXRD3Fd8/rmpMDqYDPoahJFiw3hOcqk0m
	KU2cW6/2SbRvSDnec83o3vTIBKLTYgBQE3GCc2FdxVbNRxTluHbs1SXTy7UOXi46
	5fZ/ifpZNPsqXUAn9tDl+I18AQdXQ3IltDiwj1CmZl9+9ZZaT8S+zoUSqzkuSj9e
	bP7NAuTDMvNxJuJItZt/MG30T6eLt/x92SS11qfJ70EHTVNkWOA4TCtJExg8Juje
	zt8ycV5b3DN95VQUlJYU6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse189f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:20:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QD6DAW024390;
	Wed, 26 Feb 2025 14:20:26 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51art3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cll0C8joTPkq9IoNLxGgL0+nNPq6Zt+B2eJy7pLnBBHBJ1UO1d87yWtBgQRwguz1+VhgGxDrKGr+OYz/lHk7ZWcPijnyjYgalyfvzDzhQcbAGWRpeWLUZIUDDac4rzvuMZuWiMFUuLNX1JSxfc78yP6QRoq1U0lKZK50wqnbuCleFWfk3+LaRf2W6YklGj136ipGTcvJ6cyyFuaDAx4hDUX4EL7/dDITlx2/aB9ZXNiQpf/2Qexm6+KT9yBltqFZN+20GcQ+Dd6y7NCWNxnrVXAuFUedsPtboelThiq1tFS3I7uViHvY2YLU55jLZfcDtOlKrmr+9mJyBW0Nn7y9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l23+RAmbD1qscDs3VUm5nHyyP46g9hVdQOWz/i3TgWA=;
 b=D+tljtlcaoZzNdU3qK0UqAT5raiz8Wu6/IFvJjMQH1gKfnFAQ7CEF64z1kfOOzuffLKtevZecmI8tjNP7Dvm5hC0aLor45x3AW4g6u9ct/eIh/ZGBIel7kMUuQpqidHzQzT1NopzIC7iFKzMP2AMVXvvA3eaTIjlIpBxdVWToO6JMqi/3qjcBlNqz95oIG826FzRIZvyuqIcquFwo1H5roOH4d6JZ5D5Dsle6FUtjgmUz9kWfe7wIcuOZc5uGVsgbawuHTS3IAEWl9sAuK83jw/elTV3ahn6HhQMntEtDQeNI58CmtpJKELTliTN758aAabv1sQAHsdQqFgkta15hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l23+RAmbD1qscDs3VUm5nHyyP46g9hVdQOWz/i3TgWA=;
 b=vxoxmQSSWGLyViPVoGGCV4tjzj5idylbxTo9Eq++O/PaT3LiJTLGT0ADz9NdW/j3pftfYSynkvozuprWJzkVWGWLp/AIi+E+ctodANtgxCopC6YjI6afskqjs3sT4YDkshLzraBz7IY1yGGTgK+09TUgNu6WNkekr80BZ+7sYek=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by PH7PR10MB6459.namprd10.prod.outlook.com (2603:10b6:510:1ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 14:20:24 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 14:20:23 +0000
Message-ID: <7a4072d6-3e66-4896-8f66-5871e817d285@oracle.com>
Date: Wed, 26 Feb 2025 09:20:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Takashi Iwai <tiwai@suse.de>
Cc: regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
 <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
 <87h64g4wr1.wl-tiwai@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87h64g4wr1.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:5a::35) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|PH7PR10MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7a01f8-eedb-45e7-63c2-08dd5670b4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmZza2RGc1pVd2Vzd1BGa25GUUltVnlRMEd4empiQ0lYekJXZVVDRmlyMlp3?=
 =?utf-8?B?OGFpcTVEMGFrTjl2U3psTXBMZ0NhZGgyR1lRTEpWY0VEdjlPRnJtSEF2SmhP?=
 =?utf-8?B?R3RDaUdJeWdhWmJVS1pJbHNtSU5xKzA4dklNendzUGs3WXVqRHpZdFpZT014?=
 =?utf-8?B?bi9rRXhLOGZaOUlZc3dMZ1ZkNzdZajd6bTFIcXRJZE1XMDlUVjg5c3FDL2xR?=
 =?utf-8?B?SHh3Tk1CMitVdkErMEdmY2NyQTI2U3ljN3BkWkNxaFFjaExwaE1xWUIyZ1Nz?=
 =?utf-8?B?U3pFZXBHWnQvWWpoYnQvVXMySVpvVmcraVdpcHdKZGpQTlN2NG9XSGtlcUNz?=
 =?utf-8?B?bGVuQ2RzMi9WaHhMQ2VUdm9TRjY4akZWV2NBKzBSVXpRRWpJNW1BcnQwaDlN?=
 =?utf-8?B?K01xN3RGSVBJZHB5ZDhVMncyTWpTaytlSWRTQS9jekhqY2VSUTd3S0NQb1hk?=
 =?utf-8?B?TFplMHFXTWViYitzYkU0dG9YYzY0WWg3Mjd0Z2xTN1BpVWdiRnlORzVycVVV?=
 =?utf-8?B?UklwSGkrZEFNOUtjTjlyRkFXM1p5TEMxdldoeWUwY0lmTXdHYytBbjgxbkFL?=
 =?utf-8?B?Mk9iVm5iSWVXd1IzOHZJMXo5YzJDQ1B0YSswZWZmMHo1WmJmVUcyZ3hwTEYr?=
 =?utf-8?B?elRZRWlNOE1uRFBDQjBKcW01UGFPU1U4RGY4ZnlkWjdOelgza0xrRE14Um1i?=
 =?utf-8?B?MnZXK2tueUtNVkZLWStTSUJvdnZ1UjVGS2ZPcDRoN3Q0bWZFMmZEWk9HRm10?=
 =?utf-8?B?MDRQYjFuSkRvajYvSzQ5WS92ZVNjQ1JvZCtqcUtFQWpUYzF6enVMdjFpKzho?=
 =?utf-8?B?elVOQVdvVzZTaVdlVW80VmFrald4L1dpNGJ5dzFjYnpNUjd0VUVCOTIzdCtI?=
 =?utf-8?B?RDRWZnhLbTVIbGZLN3ZJcHo5ZDh6NjR3amJUbmtHWmtpUGNWMDFWZmZ3d25l?=
 =?utf-8?B?VWQxMmJDbGxwMldKMkxpTVIzS2JCTFFOWFNUNU1KLzg5K0xzVU5YaXNSMmQv?=
 =?utf-8?B?VFNvL3J3NFdVNkUvNUVHWG14d2tzOHFpUXlsVjZnbVdZVkplZlVTc1NiKzdt?=
 =?utf-8?B?V3NZUkV6N3UrODRHMjFKM1NYK0ZIUUpwSVBLVTFyeG5GUEVwQkhuK01HY2d4?=
 =?utf-8?B?b3p0RmtveXIrcUJEdWxGRG1UakpMMXhoN0ZFcjMwazJXSlJQNXN1Wkk5Tmlx?=
 =?utf-8?B?OXlRMDcxUGF3cEh4VVJhQmdROG5jSnpxZlZERStWT200VUhzZG5vQlZDeUFQ?=
 =?utf-8?B?NVVrbUs0VGlRZS9SeWVLTVZkZHRHYTFZVHEyLzd4Qm5TWmRETUtiZzIvRk10?=
 =?utf-8?B?cExkbkUwMEkrVE1DbzhvR2lpWHh4L3dIbTRqUURLTXBwTWs2TzByQ3A0TGs4?=
 =?utf-8?B?WWJuV0t4MkdFYWU2dHVBT1I1WC9WUmo4N1hicWlCSTQ4N2gxcUF3SjRCT1Y0?=
 =?utf-8?B?aFVtTUo2dTFjRE9BeDl1eUNLVmFkL3VYVTgra0svVkUrZlhHdDNNbWd6UDZa?=
 =?utf-8?B?R2V0SEkxbDI1aVZRWHo3ekpQZkdVUEFwUjluZmlYSXJvM3R2Z3FIR2FuODVh?=
 =?utf-8?B?OUlzYjFvS3Bxa2V2aUVDbEh0cVJNZWZ2Ny9QOTZ5c1l6MXE1cFhkZTg3NlRM?=
 =?utf-8?B?a3cyZm1CSkNKVzViZVdlcWlydjd3aGU3MkdtYytBSUdUSzdPd2YwcVJoMXZa?=
 =?utf-8?B?ZEllUlNIU0d4RlBGcWQ1V0VPdnUyNU1XN0pTU01mVDdWV1BJTkNlYTBaTmJF?=
 =?utf-8?B?NWVqblVkWGlvYlY5bHcwRU5JLzJsV3hmVDRUdDVReDEvYzh4ZE4wVVNZWGtw?=
 =?utf-8?B?UDNHbjE2YlY0MmJBZ0hQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC9MUTNiMjdpZTFvTXUyY2FzMVFpL0M3cDhTWFVheVpEa2RCbmNNTE9pUEhP?=
 =?utf-8?B?aEpVT0N5czUzbWVCZ09LQisreEJzRGJpUU5ZRnNQZHRWMHl0Z0padmFzZXNz?=
 =?utf-8?B?cis3amhzVXB3eWMrTW1jYy9jQVhhYlZhNkxKajJSTDVBVlVOZGx2TENiREhL?=
 =?utf-8?B?Zzlyc0dmRDkvQVVISksrRWVUU25XclBvRkJMN3MrSFlMYkRaRSswREZSbitK?=
 =?utf-8?B?alR5OHlabG5HVEJXUm1FdFZ2VWFQVmYvaUg1K3JWUldKZDNjaDFOU3BIdVU1?=
 =?utf-8?B?TjMvRm1RMHNUandGc3RrLzhVdktLR0toRVNLQ2lFV09vcEQ2SkJqdDF6SHda?=
 =?utf-8?B?cURZc2FLcldRTGhlb2MrVHVCems4eVBEOFpzLzJzMS9RVGRaYzM5N1hQZ2tK?=
 =?utf-8?B?RXJuTTQxeFRQZGsvVFBRd29pNXlMUGoxZW43UTNzaXpSU2R5OWQ0UVFMSVlM?=
 =?utf-8?B?SDY1aHVFaXVnV1VOZ3VHdG1wMVVkZTJ1Wk5ucUcrUzJsbWR3SlFFWTRiWGt1?=
 =?utf-8?B?U3VDQnByVzJ4cG4wc0dzakM2NkJWa1NONm1XdzRkdXF6UDJ1UzZDWExjeTl1?=
 =?utf-8?B?SzBkTUtpZkNEZkt2cnNrc0NWTmc5VGpxdnpseHg2VnVpM2ZJclByTUlWSTZj?=
 =?utf-8?B?UDh6VklwZFh3VzVMdFhIMm1DSzk1N3JPK0psZUN5Y09aVVJrOU5KZXJVN2Nm?=
 =?utf-8?B?Tmh1V3RqSUVpRjRKVFN2K0pRUEdSVVNPZFNWbmZMZjhtWFd2djAxcStOMGE5?=
 =?utf-8?B?T1JJTHp2VGhiWWxZV1VlT1BGaG03RlpNYTdTUUdPMzhQQVoxaEl5Qkg1MTlB?=
 =?utf-8?B?WmFYSkplbzF5QlJYMSs1SStEaVNiTzJJZy8vWnB6T1V6anpNMExZZlNJbUtC?=
 =?utf-8?B?eGUveEh0RG9BY0lEZS9zYzdpTTFMZnhjOENua0lmYmtHcVhSQ2VXQlB3bFla?=
 =?utf-8?B?SFgvWUNYUGhoR0ZvK0RYWlFnZmRMQ2RzY2JOd0s4QlpkMEhhMGRRbFVWU0Uv?=
 =?utf-8?B?MEQ0U0Q1RmZWd1Z3Y2w1NFY4eWdmSHlPNFpDb1JLdzg2ODMvZG51R0R2Zksv?=
 =?utf-8?B?WHpnTG96T01maVhxNnBBeWVvdkZnblFCMTRidllVSFNJN0FmT2pzclg5SVZN?=
 =?utf-8?B?TGFpVGZXUi9UNHQwaUZ5TldLZUxNK1VvRGlWVGJubHRLRjNzYjhTV1ZMZmdZ?=
 =?utf-8?B?ZVUvVHRqR0RKQXpjeXlUMnRadS9OR1dPemRTSGE4OExHN1lkaC9WRWJEZUlp?=
 =?utf-8?B?djlUMkNFK0x3QTdjU2VzbXl4R1E0Z1A0WVlkK3dZQ1l1L1Z4emF1MnorL0hR?=
 =?utf-8?B?NThYRW9aMUs5SkpRMUdnN1pabGViTWpHU0tLZ0wzcDQrWE8xTjZ3bHJobVJK?=
 =?utf-8?B?d0hDM3dwUTNXelA5bEZ1M0MwbnNqakFBcVgwVC9zZG90VVdQeDN3Sitjb3ZV?=
 =?utf-8?B?OHBqSmZQV01XZ1BocU1ERzUrMmZUdnpDUEpWKzFHTXdUNkhraDVycy9hTHZz?=
 =?utf-8?B?bzNDWVBOakIvWWwrd1pMSlFFS0w4RlVXTDNJUDl2VEhXTDlOSjNsUjl4Z3Y3?=
 =?utf-8?B?aTg2ZlZWeUtkNWxsdEdwYS9IZURiYjlNclFpRit1QytnZW9BaVBLVlI0QXBi?=
 =?utf-8?B?RGtFVDFWMTVqTmxQMjZOVVp3ckt4WnpURk1iQXhFYkdyMFpnU056NzRjQTEx?=
 =?utf-8?B?ckJJeWhySEdDYURCOXZ5bnVkLzFmclJkRXZ5M0xEdGxaMEZvbU1xMHU0dkxJ?=
 =?utf-8?B?WnR2WlFseVNnSktpQXVvMTVmbkpkeTlJYkwyV2U2bGdIMXpqcnl3aXJBazVy?=
 =?utf-8?B?cFQxbkoxRVZlQzBaSWVkK1RxZi9oZDMvZ0YzZThLRkluRjdaS1g5MlMvTFRS?=
 =?utf-8?B?NnhFemRtUmVkUHVGUEh6YjlTbldQRFY0NmtTa0JDbDJpL1ZvRXZZbFBKNVlL?=
 =?utf-8?B?UjlMUnQ5d0tmdStLc1hsbUhwYmNXS25ndkR5aUlkQ3U5SkM4SXBkY0ZPMUV3?=
 =?utf-8?B?RktxTjRkZ1N3cUI4WDQ3N2RpdnMrZG5uaHNzYkFOUHViV3YrZWloMEJSZ2NJ?=
 =?utf-8?B?SVlwcTR6R1JPWVcrcGlyNnpvRlJUZ3hiT2E0QlFXamVrU2s5dXRJM1FsSWdx?=
 =?utf-8?B?eXZhUG5jL0R2ejY4MUlsRTA5d3JHYnlScU52c2tGM3V4RTZhdUxpVUlwbWkz?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Coy0sA/4bsMo6WkTQQ9KBIEjFUxXNh7IhQmfvsze7h/2IRyUk1H6Hnrw15z6Rnp/UxtQmCQydbCoQc6K/Xej04o2suSnWIbPWoJXaf3/oyRrn0JK3D/PiGm+9azzmlmv5jxWGkz5oWt4iyA5st7MRGs0klLijjNLie6n8jK6cT0H1QXHhC3GCHtL3A+y0c9qwN0AkGxbxsrmEat5WttFtlRFqW6No1RNfaJ5CidG83YmmNfV49UOXTK0o071HaitI9orGeao8Cf+hmiSheLqeftNh0KcKM4EdXhhog41avBgNs1b9gFZZsiLEvo9v9EtyNNg66WbHNe9HoLB8ADSBcRgDLY4qOhNKTpBfH90CCps8QBGdz/ri6SJyr6WYQtoX+wCM5S4Ss5NYMQDHqprnP0cxWprkNVHSaVUI6UJqk5f8mevEcqYKUoICKasOiia8HgAtL3iBIWu/pLk2tFYHn6/yi2h+aiak1NWOShplQpH6c3UTsqsNm+hVYuPpTwfElVxsCZKYqdE5d/4XLStzXK0cEeRNh7MORTcdHMf4c1v4Pdasi8A63AEr8/fVEgoXO7HJdr+7sJLXx/9UDcHGCTE3S5kRmK8MiKNvHKSEvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a01f8-eedb-45e7-63c2-08dd5670b4b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:20:23.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaktRyYeCjcLstWDQrzG4OgvJwQiBvImcVK6OMazL+bvmDOKLR1I7wCEbCAjChkV8QXWjNo8QFrEazNWY73JAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260114
X-Proofpoint-GUID: P7LbxArpNl_B3zbrGHZsCcVa4Hr4dW21
X-Proofpoint-ORIG-GUID: P7LbxArpNl_B3zbrGHZsCcVa4Hr4dW21

On 2/26/25 9:16 AM, Takashi Iwai wrote:
> On Wed, 26 Feb 2025 15:11:04 +0100,
> Chuck Lever wrote:
>>
>> On 2/26/25 3:38 AM, Takashi Iwai wrote:
>>> On Sun, 23 Feb 2025 16:18:41 +0100,
>>> Chuck Lever wrote:
>>>>
>>>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> we received a bug report showing the regression on 6.13.1 kernel
>>>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>>
>>>>> Quoting from there:
>>>>> """
>>>>> I use the latest TW on Gnome with a 4K display and 150%
>>>>> scaling. Everything has been working fine, but recently both Chrome
>>>>> and VSCode (installed from official non-openSUSE channels) stopped
>>>>> working with Scaling.
>>>>> ....
>>>>> I am using VSCode with:
>>>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>>>> """
>>>>>
>>>>> Surprisingly, the bisection pointed to the backport of the commit
>>>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>>>> to iterate simple_offset directories").
>>>>>
>>>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>>>> release is still affected, too.
>>>>>
>>>>> For now I have no concrete idea how the patch could break the behavior
>>>>> of a graphical application like the above.  Let us know if you need
>>>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>>>> and ask there; or open another bug report at whatever you like.)
>>>>>
>>>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>>
>>>> We received a similar report a few days ago, and are likewise puzzled at
>>>> the commit result. Please report this issue to the Chrome development
>>>> team and have them come up with a simple reproducer that I can try in my
>>>> own lab. I'm sure they can quickly get to the bottom of the application
>>>> stack to identify the misbehaving interaction between OS and app.
>>>
>>> Do you know where to report to?
>>
>> You'll need to drive this, since you currently have a working
>> reproducer.
> 
> No, I don't have, I'm merely a messenger.

Whoever was the original reporter has the ability to reproduce this and
answer any questions the Chrome team might have. Please have them drive
this. I'm already two steps removed, so it doesn't make sense for me to
report a problem for which I have no standing.


-- 
Chuck Lever

