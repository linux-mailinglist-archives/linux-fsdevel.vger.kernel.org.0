Return-Path: <linux-fsdevel+bounces-42711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6DBA46693
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7696B3AE0D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB4222562;
	Wed, 26 Feb 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JyoydheF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WHoON9Sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF122069A;
	Wed, 26 Feb 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587347; cv=fail; b=pZLhYoel8JOqoxWvxRrtrWYxsSJT4DcG0JWdsT0GvvfJ6HjwIfTp9RpUnNrW8VM04qCWBPhOejgumTMrJGBP8L68ePA320hZ1M116eSVTb/6QDAMyHLYztn6ceDY6+E+w3+7MahqtjCWj17LeLD657CZs8W7wIgrbuGxC5sf4jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587347; c=relaxed/simple;
	bh=5Q4edy7SV8DOP5XUj5ARZhxIDyNXF8kvEm3WSShL+g4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gL/864WjHeHPDkpsyDH26NRRJ4y8BKqGlHGIAlipNECZRf2l70/YJwVufpT8Lta3BDbTdLhVGXmMruvoVyp5hmMVcAsslxK/NZFQZ341s/F7SDY0OburOsbJP59zZPx1Avk0+V6SiUu6pUE2HlgQH8/GyA1nZQgfdEWBqaOI/U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JyoydheF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WHoON9Sy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtZuW009819;
	Wed, 26 Feb 2025 16:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hhrWrFf74wJlQclw3Irri4TLR14VdEhiv4cQvMor/CY=; b=
	JyoydheFShZ6yaYH8tqUjeYegGWwg2JELCpt4LMU1JMGPY4OIfFb94Ntx8OKmqp9
	jEViAfVZ2gz5wsI3tKoUV0ZkHAUesi7uZgTG3URtIulVZzqgm9rxjvXTfrFThIp4
	wYGdMqi5ibqyn9Hy+hEkNgT5+T0FnhISnf3Dq2Vb4bLd2W1B17RV+3xic/9c7QNh
	M4DboeabmnLw9XpHWlNMZVsRm6OzPTTY1cA0N2bpnof4vRbIQTyMtaQ/rf9iffEq
	76ULgkque2BZIAeIDq3mGlCFsuwTn3JYXe9HnCX0M0DTd/UAC/d1ElwSlNZpGqHo
	5R6rip+jGxiVQGOsTX7WJw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdhkex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:28:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFU3bF024503;
	Wed, 26 Feb 2025 16:28:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51axc56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 16:28:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsyOZiACfNfTY7MdTPY1HC4XbbeW7M4rcergfX6R1cxl+nu36dFdpmI5wH4D/vhN5V5xU2Qa9/h3m2Rx7E1RiyqUE/F2sJPaA4c5QMYtYIde2d+a+nWNnYZSepg+YE7Lc8fOZk4ztRHSCqKknB4YodusArswwT+OgWKxmAEEZ9FXcOWAJn6v23wF+cCrgsqiaKb6u+1Azb1gkjyb0jl05+OTpo/25FEfj7LxR6LSjz2itn7CyxEFFyo0zqnDrbzTPg5TzqqkNzwfTWOSBH7KDz3kfXWqx3NNAtv15H7D8957Ml/siKtYdh53KwyLvreUQJVd2pTS7jqFxLfVrx/t2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhrWrFf74wJlQclw3Irri4TLR14VdEhiv4cQvMor/CY=;
 b=frzZ6fgU8dx3Md5tTEdNhOxVEMIMbEmVO5lfhPaBBNu5VISkOwTiCjZfvLK6bJTLoIxNM7WmowO7Nm99YrLHz1BCUG22FDB7ROVtrO0tNVJEACIYTXHdJc/Z7dqciicPUgZruUIhI3COXlVaDDSLaizR0l2YMWtObq3z94TULg+CUZGKcttIDOHH5oGoQPqqmWMRCWE5e8onhU7mZGO7xt+5KBNqn1+h//jbj6zIxlESh9yruhym+wR8YY9+ShcYia822V2TMwJp2Z8fNyJF3WZzn+bXNaHFYNQY49xEhlzlRWJadsxdZkspmIm2LhKkZQVPx+TEyzpDT7sDORgqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhrWrFf74wJlQclw3Irri4TLR14VdEhiv4cQvMor/CY=;
 b=WHoON9Syrx3MAwfkW3p4BrSbkHt67oLliZirpdwoyv+vH5bmATN2+txf24njxFkNqcazq8An4mqLIYgX8LF5anq4JjahBzHnSYW/Z2aeYOGalY6x1FWOAWu3WW5HlQinftV8Y/2fzMZVBcLu8ovB43yIkOg5of1wCMG2WvMP6nM=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 16:28:36 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 16:28:36 +0000
Message-ID: <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
Date: Wed, 26 Feb 2025 11:28:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable <stable@kernel.org>, Takashi Iwai <tiwai@suse.de>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025022621-worshiper-turtle-6eb1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::15) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd0ffd8-bee5-4208-02ec-08dd56829ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHRGZlh2VFFxQVEzMjM2NEhLZTNZV3lyZmxFY2VxYncvYjB5T2JSN1dzU1RZ?=
 =?utf-8?B?Q1BuWkMwMnB5U0U1R2tBS1h4cGhHWEVYQlllT3dTdjIwN2ZOZGtQR1JHRDBp?=
 =?utf-8?B?TVVhOUkzWksyM01hNXBxQXc1VXFXQ2ZRd1docGFJcHhkNDVNYWxZbjNHSFh2?=
 =?utf-8?B?ZWxJa1g0RGY2K2REYWtMQlQzS0M0REdKWVdHRjYrV1pPT25ZdlJ5UnBVZGFL?=
 =?utf-8?B?V0xERld6OTZPWFcwaDA2WUdmUkY0QU52a0pUeG00OFd1YmZ5Y0kxdWp5SFJq?=
 =?utf-8?B?b1Z6cWh2c2t6WXRqTmh0OHBoeGRiYXdOWmVBc0RFY3psN0cyQ0tXNFQ1S080?=
 =?utf-8?B?UzJGTllkek9uRTVIUmdFNmtuZ3lDUk1FU3JKOGREVytMM05FR2FMVXJOU2Uw?=
 =?utf-8?B?MmFMZFc4MUxYTFQ4L24xM3JCSDUzcFkxUDhxdHdHaWNuL216MElzdnBrcXlJ?=
 =?utf-8?B?cXRZRWxvRnp3UHlVUGoxN1hoZjlhVjRURXRRaHRTcG5QQ0I0T3c3c1VycmNQ?=
 =?utf-8?B?MXIxbkxqTVJ3aVdRRXlSeHJNWlRLRUZvYlpRcSttOE1iVU10UDk5SlJZczFJ?=
 =?utf-8?B?SWl2L2ZPODFRaCtkMG5WR29lTFYya3NyQjhlUjMyQjNUU3BncmcvMmJSZjBj?=
 =?utf-8?B?TVJhYzJqemxTUzFFbFJKTDJIMElCK04vVWpWb0xoYldBUldPS29xdXQveUpD?=
 =?utf-8?B?QW4xTXhnYnBZdTRZZzdUeDNNU0J4NE9vOFhieXRGQllTeEF1NVhWdld3OVhQ?=
 =?utf-8?B?aUMwK0NPSDJoT3Y2eDNvTmNjSzNMQm8yTEF0QXlNcSt4bnFjQ2E1cXFJdHVj?=
 =?utf-8?B?MVpoQ0ovSCswZTZUQnFJRGVVTVAzZ3l3OENnL2JROUtZUGRnSzZLRGN2cVd2?=
 =?utf-8?B?dkw5d29jc0xQRTV2OUlSeE9wMWFXd0d4MDBPTlJrQ1hMSkl2ZVNRbGRIOTVJ?=
 =?utf-8?B?UWVIM2lQWDd0RThlNHUrSVYzd2N5RlZYTUFNbzBxQ1pKWXRWeVhqVWRPRjJK?=
 =?utf-8?B?dUVtWkc1QTB0bkFYMXVtRzlyQVJ5SWpEN0dWVUpxazlvNjhMdjZ0K0NmdHlm?=
 =?utf-8?B?TXp1SEttMVZrelU5cnZsdTdSOGpaclQ5WTg0K3VDSHNNcnFGdlRCNXo1KzJi?=
 =?utf-8?B?cEU0ZnlCVGt0ZHdlZWFOQkI4TkdPdE1FaXZQT3IvUEMvUS9BTlp1aEt3TkJu?=
 =?utf-8?B?UjlkS1hLeW9YM0E5alp5MnhQZkI2bzQvdG1ucjdQMU15ejQxcHRjWkhOWVoz?=
 =?utf-8?B?ckF0TWhuNFIxZHF0ZGFlSmU1NDlpa2NIeVRocFZRNjZRWlJkL3R2OVViZHBH?=
 =?utf-8?B?RzF0UGJCZzd6SkI0bWlMbUhzejl5eEZUc3ZiYnJlaDhMWlNTUnJXTXZsRkRx?=
 =?utf-8?B?R3ZqdVcyMmtRUlF3UnUvU2RqOWYrUjRETVNZZGxEUjJ6WjJjS2drUTZ6ZGxQ?=
 =?utf-8?B?QnV3NGxyR2Q1ZFU4VHdXN3hnc25ET2dJeFFJNmdQYkNlTy9nc3JrNzRZRFlR?=
 =?utf-8?B?dmp3QTlzcDJWQ25NSG1tcm5qTkdRL2d0dFJiMWh0YWRNemRDOGJkZXlqRFQx?=
 =?utf-8?B?MFkyQmVaU1ZKalBQSUJrVk5OTnY1NzNWYTVTeGc1UEx5cGxRMjdFSHdydXVY?=
 =?utf-8?B?MmZFVi9HbHl3akNOczB6bzlvWXV4NFc1TEYwL2QvYmZqTXdMNFdIbzYyanlo?=
 =?utf-8?B?bW00b1ZhckYwZEJvS3h1S3hyM2hkK2phdHdGZk9XR0NTYm5reDVQQ3hHSEFR?=
 =?utf-8?B?a3lTcmFBcjlTUFpwR243MFlxMkRDcFI1T0JSbWZBV1U1UWM0d29kcU5jcU5B?=
 =?utf-8?B?NmY2NmFlTThyR3FrbHVPOFRKUFloL2VjcUI3ZlhjQkFvb3FYMUJWMC8xRUhM?=
 =?utf-8?Q?LtIBBoDWqTOh3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW1abk1MVS9zMFFCNm95b1J2UUNNeU9VSXEzSGd3Qyt0WUhHUEMwWno3cWJT?=
 =?utf-8?B?VGROT2Z2WGQ5Vms2R2YvMjJHdkx5aW1ma09kSGhzVEtQRUlmZ1lFTmR4Ty9V?=
 =?utf-8?B?Rm1XUkdOOERyU1BYRHhpRUgyWitzWXRnT3V1OEt2amJ4cXRvcFg4dEp5ZGxk?=
 =?utf-8?B?TlQwTnNJQkNIelV2ZUZUeXhpRkhPeFB6R0tLOE5NYkY1QzVFc1hNa0ExSkVU?=
 =?utf-8?B?MHl1aC8wZERnczVjYUpJdVQ3ak1WbVhmbWFNc2pKMExWZVFLZHpWZmRzVldO?=
 =?utf-8?B?cDdkVnArL0plem5CaUp5ak1KT3FkdXVkTXk0L2hyVURUTVFwMXFoOUxJR01Q?=
 =?utf-8?B?dXl4NXVLRnM5MDV2cUlGR3l2Wml5cEVrVEhCeTlqbU5PVlNGcGVZVE9VUmNq?=
 =?utf-8?B?RXNsTjZ2MndXdnU4NmxZS1VjVjUxWS9UQ3NScytXSHB0amlocHlna1J4YkUy?=
 =?utf-8?B?WEQxc3BXaUFPMXBveG5BMUZpZTBMNHhTYUtVek5UTk1QcC9ZeXpqWXY4d3VU?=
 =?utf-8?B?ay9nSTFTWk9OUzlBbkRzeFI1TWduc2tnMzBKa3pURVNFQ2RPNnJHVVhTaUs2?=
 =?utf-8?B?MjNaMFY0Q0FPWXZITG1wRXVrTmtaa1ozNnJPVEtlbzZETDZiYkxMTlJlcTJ3?=
 =?utf-8?B?ZUNnajNVc2tEelhjd05rUjAwT3BDWEJuWk1iTTdIQWl0S3ZrdmdzNlNSYkN5?=
 =?utf-8?B?MXV2R1o4ZThieUlpQU1QV3ZyM2J6T3M3dGZDUS9xeUdZcVBlKyszdEVMWnE4?=
 =?utf-8?B?NFVwZlc5Q2VnczYwMjFISTlNWFNVZDYwTThWNmVUUUtTeGh5MTNKbFhUUGYr?=
 =?utf-8?B?aHdFMlpjWFBqamZsRTgvanY3RWoxMmRpYWV1cFEyMzllWVJ6QVJ0bUJLWlNV?=
 =?utf-8?B?SE9hbEFJbWpwQ3F6Wk5IcDkybUFDVXZkT0FNYi8xcjhTSUtpLzBHcWNxRzlD?=
 =?utf-8?B?MEtUTWdDYk5RdFVOOGJhTGptZ1VuU3hOdkxQUklHazNXUldXZ2lDK2tGVUVQ?=
 =?utf-8?B?ZmdBTUdsQlg1ZWsyVWJ4QllDK3E0ZFkwZ1RwdkVsR2JPUzJ4ZE5EV2dVdE5r?=
 =?utf-8?B?Wm1TSEFBVGw1emdTaGhoa3BNSTM5SnkrMkFmb1oyRlhaYUc5dk5QQldiUnk4?=
 =?utf-8?B?SERla1d6SlBnWTR0SHVHOE82Z29PWXQ1MUlhY2RRMnc2ajl5enpUTWRLV3ZH?=
 =?utf-8?B?VUx6eUhMZUk2R2MvSVpLdUZpekZ6SVpETmcvR3Y5TnY1S0pJbjVrU1pjWUVR?=
 =?utf-8?B?U1QyZWprOU9hTExRR2lHWlZFdWY2OVRUVE9yZFg3WFlGS3E2SmgvMjg3S0py?=
 =?utf-8?B?b2thV0hDNkJqRjJGdFlFc09zQ0t2SGh0aU9SUG9GeFFwcTIrS0NqYVF6amVM?=
 =?utf-8?B?S3lFelkrSVZFWmFNRWFlVDIxNFdnZWpsNVNSSXZzU2xjV1ArNnllWmovMmFy?=
 =?utf-8?B?MGZCdnJNUlM1VFNKejVlOTBKeXdocndXZW51R1hrQVNxYWpOSEl2R2tCQlhR?=
 =?utf-8?B?MjIyb21GSjhaT0kwTnBxVldaVlI4bnNzRFBVNHl4WkNYNHZZMnhpWlpRVS9E?=
 =?utf-8?B?S3o0OWxXQzNxOVJwa2IwaE9Mbm0wNjFHUUI4a0xvQ2JKUjBmWGN5THhmdzY1?=
 =?utf-8?B?NzUxZ0RwTVJLNVlmSVlrZEZHaDdJcER0M3JmU2xhVDVBQ3R1a1ZiQnlCSmYv?=
 =?utf-8?B?M3BJVXF2NzlVSnZPcnk3Q0piREFhK040UmxQb3A5Mk9oZkFrYmNjREszTHRp?=
 =?utf-8?B?NTV1N3VwbExCY3F6Z2MrS1N6M2xqZ2UwSGpENk5Ud21sbGRMbVMxM0xpTWdi?=
 =?utf-8?B?T0JXUi9nSjNHV0RFQ3UveTA2d0JWREFPV0tiRnFUVmZsNXMrbERocmxhNzk2?=
 =?utf-8?B?QlJiN3FOMnlrSTlyMjVzMnZWeTc0bkJZNVUwSFlabmNVMHdOWDZiWFV3dUVp?=
 =?utf-8?B?cGN3NHJmNncwQXgvV1dwYzNjK0xlVlMrc0xaVnl4Q3VQamJlS2ErNzJTMkxx?=
 =?utf-8?B?bmFGZExvSnduMjRvTDIrbW1wV01ueml1Mjd6WkZLUnZ6SDR3bTFNU05mSEM5?=
 =?utf-8?B?clZ0dGNMeHlKNGR2SFlqUEZKVG5SdlBRQWpLYWo5VFlCbEUxNXlSOEpLajBH?=
 =?utf-8?B?OXNYUFpBeTVQN21ZK3FBSG02a054SlVzeUZBWWtadi9MN0RKeG5sQU1hRmdw?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SCdDzgzcwh1TmqOkYFnD4eUL/SbsTiQWESAvZozrxoxcArq4zIBp8y2uh4xoEZ2ffHlYsiC9IMtDGTpkq5CIDDyRCLrLm0NwVdyPwLDvn9T9gE5CyoV3rugbIdAg8eJIK7OwurzPmI/RAubqHOgjkjgrjgau+8/uM2lXjxJkFinzZwAR3XqO7kW8Bg595qSrk3bMGCsAWPcsfTsuAs3UzA5h8KAUMOtlxvPZHE8prMy4qSomCpmtqLSGBBohpTIpczvYe7c6A4a8Zyv0eUY/8uyG9EnvCJUu61WOAhsy5lOtoLeU1GML44HsvqbJCg8vmY3wW5kbeOcZbNEowOtAFZ9UH6+Vuc6xdeV30X5AYUqk/BtgRwpjSf+2IHicHf7Y34LgOyIRont7Qjp27dyzq7kiBWfqdd5QzbE+go9lUf1PzEH/hV6Ggm42LiabhfGF/Xz0ko4hrWxQ6xHl9ucNjMi/bYN6YSvxbp+HCTBIE65vWhofcXS4tLX1bWP90VykYcyAhNdTfcMoYD/xM4BQn17b/xHC4s1RBhqwSQGLzsgEKZTpFF5Ho9LR1bZ8Eu+HV1jOEVCkwrXJBlVl12NI+mDpLvOSJiVhWOLaXAZxbiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd0ffd8-bee5-4208-02ec-08dd56829ede
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:28:36.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uOUtTNrFZ0n97f1EgV+213Evc05iAm46dZWt5Om7dRNfzqdmvi8di/UXqf3bByYl7+a742yqqmGSKPdzQd79Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=472 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260131
X-Proofpoint-GUID: Md0a8xT9oSMkdm6JjdJTVl87TQ1fOa_G
X-Proofpoint-ORIG-GUID: Md0a8xT9oSMkdm6JjdJTVl87TQ1fOa_G

On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>
>>> There are reports of this commit breaking Chrome's rendering mode.  As
>>> no one seems to want to do a root-cause, let's just revert it for now as
>>> it is affecting people using the latest release as well as the stable
>>> kernels that it has been backported to.
>>
>> NACK. This re-introduces a CVE.
> 
> As I said elsewhere, when a commit that is assigned a CVE is reverted,
> then the CVE gets revoked.  But I don't see this commit being assigned
> to a CVE, so what CVE specifically are you referring to?

https://nvd.nist.gov/vuln/detail/CVE-2024-46701

The guideline that "regressions are more important than CVEs" is
interesting. I hadn't heard that before.

Still, it seems like we haven't had a chance to actually work on this
issue yet. It could be corrected by a simple fix. Reverting seems
premature to me.


-- 
Chuck Lever

