Return-Path: <linux-fsdevel+bounces-44202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DBA6549A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501091604A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34506246348;
	Mon, 17 Mar 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="acsPMM37";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tJK1EjNE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8A2417F8;
	Mon, 17 Mar 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223434; cv=fail; b=TF9TSsMPCCr9VrWKlrQspkY/3dqxi/aU1AIW4D0bFAHykKcktbJ+7e6AdCAYiwqNrYwZrq2gyiWK/TBObQzOFOpLpXSyJwSrLKsH8G82pfk+SkTJHCdDseUlQManXfW/D9wNVu3sZJsQgF/dnkkG92ZnvWfszTCraQOEbFYKC9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223434; c=relaxed/simple;
	bh=asmHF9z0V0Ft2r5/msjuYTB5+JK5g8cGcqq+yGP0Hho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U93jE8k0oQQM2uPWNm6PysVXs+nIQnYGtaLcBKHL1IkMfZ5dnUih29ElfTp84bbXDYOLlZSljXdp+0Zuj8daVHQ+njgTx8bLHvGXwdELa75ccj8VaV9gJNxKIeofaQyEVxT8nw2zSTulLn0Kx6WYZKjNRfVP4p3ZUr90JIkoKKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=acsPMM37; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tJK1EjNE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qjs1031223;
	Mon, 17 Mar 2025 14:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2KWGOKhpcHrsUhQuNJvNMbWPrqTh861wpDdi6HmE3ww=; b=
	acsPMM37VbEsUG6qKCphr8QmZtOn1uaETP0pqETQRmMOfyvDfmTors6DbneDayXo
	d2m5iJHM8pYYTQkU64Gk8yPV5iVEYhzpnOTk0k7Hfo9t/5qSR/9Tx88Hlgg6Yv8a
	iT2j+CJpDxvkGc0rjy8v0jJmVculasXevxLiLOaoShaqPODpFGNXQ80hWEwUUaDs
	r/RsKauliPn0CjnooIhJUz08mRTrlz14WTSqpyIJ0XUBKgtJ4KQSVCBlRaYNxlU6
	wYJVqU2wvw+UcmKYZYd356xPLfHrdwfBiDb+GkIKMAXSQTQ/EdlhZ3orHKxqnFTJ
	wUI0Ejm9ncIe+6x33axVrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb30wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 14:57:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HEJdRm023599;
	Mon, 17 Mar 2025 14:56:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc49geq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 14:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXT3m6otMXDtUeplFVrAlHjAYW2X3nqwRUvD3kjOh8fseaQYWtChpgGKMn3OoLTL581OPxdw3CSgC6A/8TJUh/nKS55de6YuvVP69UJyAByBUN6uSnRzBdH9QEmsp84uryb1vz2igKalFHpOiLiYdcOPUeBLhpbx+DrEZfkMnZ/sBqPPd7YW+K/+aVY3Goj0AMUZe3TWsrziD7ltPXkNuvQ/gk6w34P5ovptJml7po/KW3VAZICDdmEj949wWLQMGpgUYYAMn+Ap1SVtXYBJJJUdWTNjiiSwSt0AcbNvaTuVQwXIgFaIvtNMChhRn7xx08sgZbS7HfaxqhqF3kcufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KWGOKhpcHrsUhQuNJvNMbWPrqTh861wpDdi6HmE3ww=;
 b=EqSV0LIBuF0g8QCB/oX08uMF8OVdvCmJrV+Hy8gcHTzH4LVaDmgxIBBkVL1B+K38icAE6lLmkSgeNSr+Rkpf4E2IBHE0xyHOLNfSo485XHiN+zr1SAJgWSe2WMS9w8qY35fzOwgtesDO/rJ1ugXnijGRN0fqPjv1VrAY5gjxLXUVdAbtaG6zlqcye0Baq7855ZHEpq8dX+bL1paOO5ATRqAGszyu+GoLM7IrCaHcKQ/HW/QBh139cWm4IPVx4+aUjlvBx7TULeeB3+gRgmeD892p76um71fVNfVXaMSUJhTDgxj3nfc1z7yjU7SUDtMxogOx+BNJ/boxqu0uHfB2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KWGOKhpcHrsUhQuNJvNMbWPrqTh861wpDdi6HmE3ww=;
 b=tJK1EjNEKKAaO8EbVj/m1BBC4DvMgunq9CtWRlEpoy2zu5SdSfuchVgs5gOaajamki0DvmJaCpqcuCQTHNgTwsoGh1OwRdyVVV0NKdJApYLrAcDSC39+9ucT7JiwBr6Zp1OD+vVsdVLpaN1DT+Wgl8dsGYEXnulWLXNQIbFtGIM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH2PR10MB4341.namprd10.prod.outlook.com (2603:10b6:610:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Mon, 17 Mar
 2025 14:56:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:56:57 +0000
Message-ID: <aad48c97-20dc-4fec-aeda-9f87294bac78@oracle.com>
Date: Mon, 17 Mar 2025 14:56:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, brauner@kernel.org,
        djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <8734fd79g1.fsf@gmail.com> <cd05e767-0d30-483a-967f-a92673cdcba8@oracle.com>
 <87r02vspqq.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r02vspqq.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH2PR10MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fac165-da25-44e6-cbf3-08dd6563f649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGxpREh1MnZYTGdYRkJuWE5LOWxFT3VaalVya2R1aDRaVWJ6NTFCbUsvajlk?=
 =?utf-8?B?cE1iSzRqU3d4cWJVRjYyV1hlcjROZHc0SnY1RHYxeUtjckhsYXRqVEhIcmpw?=
 =?utf-8?B?VVBuOEJna3o3TC9Fdm1DR0pTRFQzYTRPVXhxUkpodHdyUGVoWXVxZlk3WVIx?=
 =?utf-8?B?eXVtVS9KWC81ZU53TTFHQkhTbUNRTXIwOGs3ajJhUm1sTHlpV0hnRkR1Yzg2?=
 =?utf-8?B?UktSVTd0S3hkQ0JPaVZDcWpCcWhKYVk0VFRMUEVWTUlvNm1adUpQZVZBWjJv?=
 =?utf-8?B?STNMaVpMWUJZVU14SFJnWGhUVUhuM0kxOGQwOUFuc0M5WnlIenVnNDBrWmwv?=
 =?utf-8?B?SEpVU0RaRm4rYjc0ZTdKSEcwKzFZUk85M0hzTWFKNGczMTByNXNYRGpxM2xU?=
 =?utf-8?B?OTNSalJRR3VyRS9JWXp4NkFENUNsdXRhOUdaeHR6ZnlLQkRjVjcxRE5QQkxY?=
 =?utf-8?B?R1JvUlBteHFsdTY3bmxTbFQ4WW9wWHJxTnFYb1JkRXgxekdVUGhkRTF4QXpO?=
 =?utf-8?B?Y2tnN2s3ZjNVd08rZkh0ZTBWZ0Q2TnlGbFBvRnVNNUVkeDdLanBwakozczJw?=
 =?utf-8?B?Tk5ydGJlY0V3dTIxMVpOcGMvRHdvT1Z3cG1xMVk1akdYVkdLMFRvaklPYmtP?=
 =?utf-8?B?em02SW5ZcHM1Y0srR1dTZVhGeisySUlOVCtLSFdwYzFWSmt0cStSR1ZEaEEw?=
 =?utf-8?B?L0tqblpXNVRxRW9WcXpyK21ualNWMVIvZTY2V0c5bWt0R2NheDRiNVRPWG94?=
 =?utf-8?B?MGk1bkN4aU04ODJxUkZpSEdlM1ordkdiemRjWjJ2TVJ3ZFB3RS9NQTd2VHlj?=
 =?utf-8?B?T3RoWDJwTndqbm1lMElkeTZ4Z1pwenltVEJuYk4vQmZwTklVU0FqdnduNmo2?=
 =?utf-8?B?cXdRS3B3bmtKY1VYWVNZb1VnS3Bzb3lTQkU2RzJpRHNvdHJSdDg3cHZxdGZs?=
 =?utf-8?B?RnAzSzJHdGVHalZTYlJCSUp0Z3MzUW56d2Y5R0FNRnFkbFpkUDBVSkMvUUZx?=
 =?utf-8?B?ekM5clB3OHA1QzdhUUhSK2xZbGZPeWNyMFkxb1U3OU1sVVd5V3ZlU0NYVEdj?=
 =?utf-8?B?YUMrZkNOUlVtNTM2UlcwU01kd09ObkxtQVRRL2ZsbXlnMG9uSTVid0xSSVBn?=
 =?utf-8?B?OC92MEpRaVAybWYvRVBPeXZPRE9ET09NN1pwanFMUjdpSVBSalA5SFh1ZzJx?=
 =?utf-8?B?UFQzWDlFcGVSWEg0b0xIV3Y5bGhMNWQzYTVsU2tyaFZWNnZ1OWFNUGhUV0hU?=
 =?utf-8?B?UzB6eVpYc2ROYzQzWVRNSjZ5SVh1S0NqL0VRQjVybU1pZTl5M1JoMFE2RUp3?=
 =?utf-8?B?T0xsZ1RtU1RDcE40R0FZam5vYzlKaEVkcGh0RzNQRkJPa2ZybDV5a0Z3MG9t?=
 =?utf-8?B?ZHQvN1NqcDlOZ3dVREFHa21IY01NQVcwR1A2b1BFb1JFb1dEK01aSzhBYXVw?=
 =?utf-8?B?bTBkS1hORTlLbGZleE45aVNzdnIydHZ4a0JqZEZBVmk3WWp6VDMyOUFEaGdq?=
 =?utf-8?B?azZtZXpUT2VPaS9zb2FNVzB3V3Q1MTAxT2REbjRHQnA3eUQ3VVp5NjB0d0ZV?=
 =?utf-8?B?b1NadG1NZHJsK0t2bEVkaFB1RlZHKyt3T0I0aXhobW82T1grYWEwUWNjdFc3?=
 =?utf-8?B?UXhGRHRWZ3NUZmlPZ004Vk9rZGlVM1NVaW5jaHpheUx4ZXJscFJmWmt6eU1w?=
 =?utf-8?B?Zklmb2oxLytJdlNrUGRoWkQ3UEtIdy9EWTdSTFVXM2VNbEwrT3ROTU5YQzhV?=
 =?utf-8?B?cUtEVyt0YXJNMXRvRlJpTXh0anZ5Tkxia0g3WmQ5TWhkUTNOeXVsaWRaeDNO?=
 =?utf-8?B?MnJIN0kvVGtNVVVaKzFES1JlRmZxMkEvT3VpRmpEOXZ1eGRwYmVYYS91V0la?=
 =?utf-8?Q?5wWki5ZJEQoct?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2FEKzVFNjdsdDRyNHpUTjg2ME02aUlRQlh3UGpmbkxGdnVwSEtpTHYyTk9Z?=
 =?utf-8?B?T2t5Z3VIVUVkeGpEVWxvU0NIQzNWWmtYbXgrcXBwYm9tbWhTbGp4cmo0ejJL?=
 =?utf-8?B?VUR2QXJVS2lUN3d1OFQ3WWEveG5NVkdsMXVjSlJCdHpHMGo3RndWUkJuTUsz?=
 =?utf-8?B?ZE92Q3NPTU4xeDB4b0VaQnpZUHliRFRONVJ6UkhZUXpCbkE0Y2VuMkZQOVor?=
 =?utf-8?B?eFVvSlZsckljbE1zMU9GaEtwZWZXR1YvTjFTU3I3ZGlwc01RbGQrZHRWUFVu?=
 =?utf-8?B?dEdlWGx6TERjT3loeDlVM1d3b3JsbjhzT1gzMk5tdzJiZDh2R3NpYzlIcC8v?=
 =?utf-8?B?U0dsYm1pcTVCNlNCR1R1cjhKcXpZTTlJa1FEY0ZFTmx1YWduMklLNDMvSnJn?=
 =?utf-8?B?NCtYc3dRK2pjMGhPQjVlblhjc01rTFNveHBtRXJ5TlVsMDJDRnRVN0dSdkVo?=
 =?utf-8?B?TGx5cHVmSXNhOTJOMDhaajZYME9nTE12WjYwWE1ScEdpWks0NHpYRTFGUVlQ?=
 =?utf-8?B?MGl5MjJ6OHl5YUZ1c3cwMEtucXphdXMwT2tFMklHTSswTjRqd2txZExDUmRL?=
 =?utf-8?B?eWdadEFNZkVXSlA4MWhRTHhnZTJISHRFK0l3eG5tZ0lRUDQ3OEhOSG1Cem9n?=
 =?utf-8?B?N1Z6UThEUTJUaDZwVWpibm5tN21aa1JxK05yNU54RUFrKzd1eXJVcDdPVWpl?=
 =?utf-8?B?THFlY3dNSzdZWU52b0dHampXWHhPbVREeXUvMkwwekNUa0JnL3IweWpoL0tB?=
 =?utf-8?B?NThTOXRCS3oxTkFEMnFaRUhLZjJ4aVhDNFdaV1dIUXNTdEoraGlBdEYxMno4?=
 =?utf-8?B?U3NyNzUrWWJEdXBqa2tNZmtzY21oTGVtVVVFeVRoTHRNWWFFK1VRa1lRSU9V?=
 =?utf-8?B?Q09kam5rRXhWRnh3bGVzYktYZGxhcG82blRUMFc5a3FnK3pLVGdwWjVrRjlT?=
 =?utf-8?B?ZUVXZjNoUXhlNWxuRVFQTmlFa0FoeEV1YWc5ZGsyTlhNM0EvRVpjdGNkaEpq?=
 =?utf-8?B?MWU2Tzc2d1JXRVZHamN2OTh4NXlodGNsQ1NKV0ZZRUFHUjFYV2EzNm9JaEtZ?=
 =?utf-8?B?QjYxbWErd04vK1VhZXhvTkwxanY2ajFjSUw1cFdzdHI2YnFVZmdwbkVZc2Rw?=
 =?utf-8?B?MkFWZzA4dkFRa2dXYVRSbm53MDE1ckVaNFlmRzk1b2JMMWh4bTd0Wjk4MHlY?=
 =?utf-8?B?MlJ5aXVMUkZ4b01GQTV0bEF4OTJEdGZVZ2xQc2tnMjlnZUFqMDdQc1NrQURB?=
 =?utf-8?B?cWtkdlpKSklBSlRCMHR0MWwrQ2phdjc5NHFsSjlHY25pUUlEM2hFZStrOXdF?=
 =?utf-8?B?STlCUTdDVmk3Rnl1ZmJheWdzL09VZGJ1Skl4L0U1blk1RjFzUkM0VWZHUkJS?=
 =?utf-8?B?bDBvcmhRSVF6SWp6VXRSQXBhZnFULzAvS3NJUDdDUEljS2dFRnNKY0IwQlN3?=
 =?utf-8?B?NnpHZzh6WmNIN2JTaHgySzJZUVRqK21tR2FhekgrUjZRZU40czBKMmlrVCtl?=
 =?utf-8?B?d2ViSEtBS2tYYVpTOWh6a2VLV2hraDhUNUZnVWJBVlQrN3lsNTVoR1RTTG5E?=
 =?utf-8?B?Rm9BOC8zVTJEM2cxYXdQWGtHWU0wL0llU3d4SyttNTBkZVVvTkNLWUFTeHk2?=
 =?utf-8?B?Q2tvUXJSa2M1SUloNjBlN2ZGd2lDU2NqcGp6dlZnM2gybEdoTHZ2dVNUQ3Jt?=
 =?utf-8?B?N2NRdzd3cDZpZ2VBMzhzN1FkQklxVFpTL3lpb2VLYklkSmlxV1o2Qzlpamt3?=
 =?utf-8?B?M3RiQWxJUEttV0lBSFRqYm1USFpFNXM0aVU3UEQ2RUhLYktyelhROXBOL1Q3?=
 =?utf-8?B?anJpdUxRYmgrc0p1VThLamQxZ25wWDBZMDM4NEZzUnk4OEwwM044MUtqUTRa?=
 =?utf-8?B?VmFlQWI1dVpYajUvaW8yRDhNSVhzVGRBU1NDUkJTTU1YQUlZeVAvRWNqSnlX?=
 =?utf-8?B?TG9QcnRHZkZPM2ZqcVdhZ3VSaGhYOWdKVUp4SzNramRUTGJ4Ri81c2xnSjla?=
 =?utf-8?B?d2JnQ3owSjhwN2lmczc4Ylo4Q2FUMmxlK3d1eGY1UXU0d29heVpNZE5UMC9y?=
 =?utf-8?B?ZW10UzF4RERWWkEycmo1UjhpQW4wbHNBaHd1dU9FWkpIY2paMm4vV2hsS3ZF?=
 =?utf-8?B?ZWd0QzVxWkJGcEdmd3NjOE1SaVFvUUgxUWJMVDh6cllEaklEQ2RUR1NTNUla?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6P1Si1ZUhdR+hF18mJjYa9mfpukD+HJiSzJt/WnQAlr3xHvEDK4mk3L02cybuiOntial10Bt7lr1Lm86OZdVKoqxqc374i0dQQkwnAoN6M3cE+fzC9f05uUXNLy/uh6nNmkhh111Vsf7a1BSbGOSUacsgRVFgX+PAAoI1HGrbqBl7QfSTXXf//Jf7UvxojA+E5ngHp/nGVIPAor0tSS1JFATgxUYJzVVFxwyTSVbcF96ur5xX+O42ZUcWRycolaTzGdUpYv+1ZNtTtq49+EboN60jRfwpkf7B/KtNcxWIhmTaPShFmekYiJi79Uq9HVUZpbSXO9impVshJmJLjLZZ4TEVP28YjPL5tDQdWENdyFZA2SSW4cU4Q9ngk7EQZmqnGs9m+RtnHNp/Do2F+Uqsxxy0s0XwHw3yAqtw4p77drrMcQsQOXXoPWH46ki/YAN0SjyRpIswPXaHG+bPAPskqLNA+sC60Wd25VQ/bTTr2i1x0tzJcNnpo5cHhRp4QqLx5PF9xO8v9vgk/1aDkeSNvMOxnKM5x9pw87ODaPO6IOFilYXH59iyShG0BldFAOb5++vxffRYOvJhQoLxmWnrA/KbpBQeId7oocKLv651u8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fac165-da25-44e6-cbf3-08dd6563f649
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:56:57.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93hC7WQjaVnTOCo1ZHG7Ds+lG3dF1cZdA0z5xyZHopU6O0mFrSZSY4j0xyb98WBvMM4SfhI54qWNjtZOxEKGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_06,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170108
X-Proofpoint-GUID: UKPrIuUmw97AaD2P7G8KvvP2Bh8UHAWY
X-Proofpoint-ORIG-GUID: UKPrIuUmw97AaD2P7G8KvvP2Bh8UHAWY

On 17/03/2025 14:20, Ritesh Harjani (IBM) wrote:
>> And, as mentioned earlier, it is ok to use REQ_ATOMIC method on an
>> unwritten extent.
>>
>>> I am guessing this is kept intentional?
>>>
>> Yes
> Thanks, John for addressing the queries. It would be helpful to include
> this information in the commit message as well then right? Otherwise
> IMO, the original commit message looks incomplete.

ok, fine. I am just worried that these commit messages become too wordy. 
But, if people want this info, then I can provide it.

> 
> Maybe we can add this too?
> =========================
> This patch adds CoW based atomic write support which will be used as a
> SW fallback in following scenarios:
> 
> - All append write scenarios.
> - Any new writes on the region containing holes.

but only for > 1x block.

if we must be able to alloc at least a block :)

> - Writes to any misaligned regions
> - Writes to discontiguous extents.

ok, fine

> 
> 
> <original commit msg snip>
> =========================
> In cases of an atomic write covering misaligned or discontiguous disk
> blocks, we will use a CoW-based method to issue the atomic write.

sure

Thanks,
John

