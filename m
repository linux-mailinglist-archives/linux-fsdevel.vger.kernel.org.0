Return-Path: <linux-fsdevel+bounces-54516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50D6B00495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C051BC503C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F8827144D;
	Thu, 10 Jul 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSRkMJfn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eXVcKfnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C01EA80;
	Thu, 10 Jul 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155998; cv=fail; b=C9HN1Bgeanyqahk78TweMOADZ8z+JwvECRnJEqk/IDmQXD3EcHfioUs6w1GMqlckaqDnLNRSkIbj6bMye3BeEc3iQnmtwT76mL/FbfSmrEPX7bvmKeBqnBE9gMW7iyb1UP+wcLx1thEUveUd9AugdZg1cAwYksb8bfmQu17PUkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155998; c=relaxed/simple;
	bh=q8LqjgalFM+jT62y6YWw0KHIglhhdPtLYgMMWVaifBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/dMF4KKP+K/DzP/ML4x3IgE1LENx4W+NY5SgFLrzgMZ+IRmEecJLEnLnijDEWVL0Y5x8FNc5e1iwas8RawcUS25K7xwg/I7tYmnBdf+AnuDPqkS4GtONSOG4pDIAMuJROdJuTj7gKVP8EXHWtXhIMS6SMEnA9HbdQfUpfS5maQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSRkMJfn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eXVcKfnQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACQxIp020774;
	Thu, 10 Jul 2025 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y2ItumvwU8Sa3Qtr7A0AwABK+mrV71aZ6pKhYpMNUGI=; b=
	eSRkMJfnrpDoafisf8qQsZqACXk59eaLR8UdZM4vxygGwzQLZ0boKl/oYSfwwprz
	hrx5vULbE3BDt0WZPQB0UCxdJJ558uVpkVkh4EuPqYh+98JmtFwLWJ3zYR5QVRAg
	M0WjSsu7YGVvAPNHz38UzdykaC+yKNaReJnAtaweCn3DomIl+5ogCUHtot4hrtSt
	BW+5+jjoaCqZcNZEWDhFQ3oDlqN8igWtV7OxTN43NfQ7Y/TSLDmrP3ibJBJbQU1d
	kwf5aBGKcG7QXcIl+VKPsIO0hWELs/3/veROGoMgO38WMjjO78rJH9tIbkeQ0eY1
	GLZ1n5DKF40jSoZYxfO/Iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tdhcg75q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 13:59:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ACFi93023605;
	Thu, 10 Jul 2025 13:59:48 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcj55v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 13:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlroXg0fCOapk22B3lhvAbS564XAVYav/IwvnUeLkj8e1YaOdMYXxmU9gVtcmiTk4GTF2hg3AMsQF5QdAYH2uDWYXSq/omovibAMMNvA6PeKOInnMX32j6I8chw2kwFpmPZW58fQjwDXQltuAGI4C1zYFj2af2u2S8hU/Blf16g5QzWSrItHEmIznoEStqtCxeh9rPFKElD/9JW+j7Oueo2FRebbaGwBWIBgiwwi9q9LtjvbEo7gy39bZ0bLbZIc2VYE0BHv4zcsTR1uPHT91jSv9qrH5NTKgjV3IKnD5ODajxAO0GRxNC5vIijOIpzeGJPOS8DpDsNfUEnEVMybEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2ItumvwU8Sa3Qtr7A0AwABK+mrV71aZ6pKhYpMNUGI=;
 b=f6Lb3V3JFDAuShFmGpL/g+1x3pBbHrLF7tyaN3brFZfxLjcG5nMLVPWAXWSEBtZrdfRl30/83+xdZuvZ7gMhdhoR48E4ITIT+zZfs6t+o4FZNzU33R+IZAA9HRoIXf8PnSbIDCes04d8IjOYUkfaAs/cccows5HAm3y197l9xcp6frchpascoGP/1RLPP6WrRRCjqds8FCtoPwakCEqgsr0RRj6m2ELYwsnwmQfyj0OyNUTjO2bj8RoUEET1+cBASnfcvDtCfzKfGr+s4IPZjOejwqJXRZogFxmteHTzSF1dLL3/1mlwcApgQ/STKxtcfEA8wmTFsf0k2xkIWclg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2ItumvwU8Sa3Qtr7A0AwABK+mrV71aZ6pKhYpMNUGI=;
 b=eXVcKfnQbugoN5bkRYxuN25F5Xpoto5Awdgsn4h7YS2QibiXPTynJv7GRSg7MzbmErARIcU/umlxQiZHIqKFM7gYJVmfCAFOx1qLN9fvavC+QJ17DHMRKlggADhqhYyqHonKYYerT/E0UAzaY6mS6v+Qo68L4xzyPGwveBD3j7o=
Received: from MWHPR1001MB2317.namprd10.prod.outlook.com
 (2603:10b6:301:35::22) by PH0PR10MB6433.namprd10.prod.outlook.com
 (2603:10b6:510:21c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.23; Thu, 10 Jul
 2025 13:59:45 +0000
Received: from MWHPR1001MB2317.namprd10.prod.outlook.com
 ([fe80::ad6:f772:35de:63a8]) by MWHPR1001MB2317.namprd10.prod.outlook.com
 ([fe80::ad6:f772:35de:63a8%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 13:59:45 +0000
Message-ID: <67083442-4717-4cd4-80a9-5790c535da99@oracle.com>
Date: Thu, 10 Jul 2025 19:29:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 5.10] fs/proc: do_task_stat: use
 __for_each_thread()
To: Greg KH <gregkh@linuxfoundation.org>,
        "Heyne, Maximilian"
 <mheyne@amazon.de>
Cc: Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman"
 <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Sauerwein, David"
 <dssauerw@amazon.de>,
        Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250710-dyne-quaff-a6577749@mheyne-amazon>
 <2025071044-bunt-sister-9d9e@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025071044-bunt-sister-9d9e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0046.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::7) To CY4PR1001MB2310.namprd10.prod.outlook.com
 (2603:10b6:910:4a::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2317:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d25974d-37c6-4f9e-b0c5-08ddbfba05eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnoxWGc1KzFPZm1OdnY5b0xnclJ5dGlIMFRiK3lMN01qWU45SjBwM05pdmNn?=
 =?utf-8?B?MnYzdXh5ekVyc2pVSHNFNWpCM1E4Q0xuNXdvNHptSEI0RGN2bGV6VTFaV3dK?=
 =?utf-8?B?aGRJKy9uVm83cG94ZFFXUmFSRXhXRFE4Sld1aERNckI2QWtYcXdVMWkydkor?=
 =?utf-8?B?YVhEcDZ2Mk1yeC8rMk9RcGNwNk1YL05QMXd6U2g2SkUwdUJuUzRYZ0VpQ2Iz?=
 =?utf-8?B?cnJaeVJaNG8yNzJrWUlZdU1xYzhRYUVPWTVZQVNPWjBjV1ZJd2phbWt2SERU?=
 =?utf-8?B?VUp2cjErSzRreUN5MW10dndZenJleU1CUkc5cnpETUNzeEFaQVAxd2NQYkdr?=
 =?utf-8?B?em9kU29lSk93OWhVV3VWZDdmU1U0TVJJbUVCNWcrZzZIS252OFJGMjEvSEpw?=
 =?utf-8?B?MXY5Nkc1cGNZK0drVUNXN2xjVVUvT0d4MXMyMHRtRVNqNFRYZHBmZ2lZOTRv?=
 =?utf-8?B?Z09VT1lSaTdleDdlOEF1TjVNZXpycnFGTWxFVlpXQjNBNTZKcjdNTDhndkJD?=
 =?utf-8?B?RDN2T1I5M2g4SVhMekpuMTdxVDFwNUgzSnU3VDhZOXc3dUdlZzJLbTgvTzBI?=
 =?utf-8?B?YkhRL0FrbGt1QWFOMVVNYjhVM2p1bjV6NGNNZE9vY2xrd0g4Z0MveWxqazZz?=
 =?utf-8?B?YmdaYnhqVmpFTHRINng4T3FsNnNlV1FSaWM0ODU1NGV4UWo4dURTMjZOa1lx?=
 =?utf-8?B?UXRLeXhyV2VrVzVDMU4vWjViUWlDNHU3MllYaGZFT0MzbHJSRDJXK0FPZ3Rp?=
 =?utf-8?B?MGZXeng1clhMVHQvdDdoNElGSEdSeTNxbE1GZjh1cWZwWVNURHl2QzFLQ2ww?=
 =?utf-8?B?SHNwdEljSW5qYy9QZENMakVWUjRqN1JZKy9vZm5WKy9PN1JRaVF3cVFFNmFJ?=
 =?utf-8?B?ck40cm1IY3E3U1FEMldRUTFlV3I4eGVMTmU3dlNJWmtLbWRidk90dTBKTTF4?=
 =?utf-8?B?NWUwZXovditJVDQ5aFZIQzA0OXZ6Uld1QlMwUklwWjZOL2xSQkoySy85MFpi?=
 =?utf-8?B?eWNaeXJjT0dvNEQyc0M0MGlBTll4Z3ZqSjJncjFLbXMzZU5HTFNOdTk2VWdV?=
 =?utf-8?B?cmQxc2daYXlaQVpuRWZmNTNWVXZYUFNYNzQrMStSaW9JUkEwU1VwYjBkTUNE?=
 =?utf-8?B?Mk1YMDZvZkVBbmxWZ09oODAybERrRy9jYU9qV3MrM01GVUxtVlhVcXlpQ2xu?=
 =?utf-8?B?WklLbVYwTGdUOTVHRXhRcUlZK1A1ZlcyL0s0b2JvUWdtWm8zTXR6emRyNTRI?=
 =?utf-8?B?Q1ZkZldUVVcwS3RLQm9iUXFpUzRFa2F4bXg0OTBsNkptcjU3ZVV1K0x6SHJ5?=
 =?utf-8?B?S0RxMk1pbzhaWjNsenU0ZHhTL3plZzNKdFlGVTFLVUdUNFpEbXd5cVk4YzI5?=
 =?utf-8?B?ejNLUjhId1ZaaWVrcXRUNWRBTHlZSU5aWXM5dG1GSGtHWU9nZDNHblk0MVlI?=
 =?utf-8?B?SUZ4RVFwRFR6YllkZmFrbVRpNDQ0UDBMdVE0U2xFeFdBSHI3ZmxFMVBVWmhs?=
 =?utf-8?B?eUszcUxnM3lYUzZtWTVEK1IyZ05HelVFWitVeU9INTNEVS94Yi9ETUQyQURy?=
 =?utf-8?B?VFZmOC9BeUw3Z09JUmRqbCtrNEhpczlheHRUTmVrVEJRb3NnSGNoMHROSStQ?=
 =?utf-8?B?RGdBUm1FNm1BeHN3ZktCUGlSK1QydGNqbjlYVUNmNzRFL2hlL0E5SXpWVzJZ?=
 =?utf-8?B?TFRzV2g4Y0lOUHpwQUlGZzAwOVF0Z3VseDdxNUNqM2huRklKTnBsaHpWTDc1?=
 =?utf-8?B?cEszaVEreklxcmFEZWtRWkVwYi9nem53MUpKMVp4bXkwbW02MGlNb1pTWndu?=
 =?utf-8?B?T1dEb21weFhGMHJ1RUQ2RnUxZjVELzRwVE5odjljVjFGelU5MDNyL3N3OGJa?=
 =?utf-8?B?bEVud2tsTHQwQWhGcmtIakZ3WmMxeERnc29xMjhHVWJ6Q2dWQW0vVitIaEpX?=
 =?utf-8?Q?w0LUu0+WxRyKckabfBv2oSlj98E81J6U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2317.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGtwcGIzUXVxSDhtb0EwSDV0WHVVNUhuWXJNdVlGS1pVYndUSjk3L0FzTHdS?=
 =?utf-8?B?eEJ6OUFQOEJTQUEzTXZjRFBOMkJhbFZFU2huSU50SjBubWZXV2hJRUsrcThZ?=
 =?utf-8?B?cUJORDVsQlBYWUNkb01pbUJ2TWRHbktIdnpSeGh1VEdWZGtWN1lNRUdKQ1hL?=
 =?utf-8?B?S2YyajN3WDJ6UlZtR2M5VmZZWmlrYklLRjJDYkdXa1hGemJFaU50aDdIOEVx?=
 =?utf-8?B?VTRqMGRPM1NZN3ZWbXUxb2hOUkk4Z2k3VlhJYk9FZms2Nm5UWnFNdWVmVTVY?=
 =?utf-8?B?ZzVhdDA3cTJFNVgwOEw4TzA4Y0szM2JSRU5kaC9mZ3JCd3dOenVaNS8weFND?=
 =?utf-8?B?Q200QnZiQUVpc3BINUx5aWp5U0QvenFxNWI1LzJNek8xNjJnbzJEQ204MEdX?=
 =?utf-8?B?NVg3VS9HcUtRZ2VZaWFNWHl0a1RQb1ZPS05LR05wNzVla0hzR0FnNFhJSlFs?=
 =?utf-8?B?bVRnYS80d2p1R1JDK0hDM09vKzRvSjY1MjloV1dCKytjUk5zODNVWXRWTUpC?=
 =?utf-8?B?VXZHRmI5TVNlUFdoOHFzMElmbFFlYVlEWm1hbHN3WHJVRlhlTDlkTENSNTdS?=
 =?utf-8?B?RWJaNFFaa0RiMFZZdlVZU0J0blRCVHdFZnUvSW40MDVsc1Q2MWxtblJzanNa?=
 =?utf-8?B?OE01MWdlaVhqdlVLa25jTFpzY3JpVGhmaHdXWHI4cnpCblJML3BhcGJyK3Vp?=
 =?utf-8?B?THhjQlBuUFVMQ0tsaEc1SlhQODFDVWdWU3VNdUluUmQySVo4M0JRblh3MnNu?=
 =?utf-8?B?RXRuV1FtUjdidzJTOEtPQXNCWmxmdmFMUFF5RU1WOUluNnd6RnRSZGttc0hJ?=
 =?utf-8?B?ZDlvbVdvNExIRWZDd2g3bVVrQ3Fhd3pRUkxKQjYxck1KYWRweStDYStFUXJY?=
 =?utf-8?B?SVBTOVJza3VZRFV2U1NEYVFZbGJyaGtycmVITmZ0ZG1MNHZmSm53ZFArSFNY?=
 =?utf-8?B?MTdGMHllSkpsenNaeVFTYmtVN1FKYlNQZTVpZGE5MHRFQW1pZVpuQTVoaWcx?=
 =?utf-8?B?dmJaVlJrYzB6Q2p0ZDVySnNTYS9zQlRwdldSVFdQVE9rV1krSkl4bm8raTgr?=
 =?utf-8?B?R2dwUWhoVXF1NGdzb1JwWFo1a1hJaVNBSXF1YXRjLzZNa003ZFhxSEVOUXdV?=
 =?utf-8?B?SXlkbHRqQWY2VHhQUjFnUzRjRllPeEdTMWM0TGkxMHFycDIzTkdmZlBvRjRs?=
 =?utf-8?B?YWgyNmFTYXVnZjBjZk5VcmRUc0llb3R0cTlOU29QWWJiaFErekNDZm9KalVJ?=
 =?utf-8?B?MmZMN21jL2h2cWVkMEk0RDJraUpheVFNN2RlZFVDNHlQaW1HaDR3UUhkTENz?=
 =?utf-8?B?SldlVEtQMndVeGdqVDVIREVGNWJqMS9sVTNCbzFHRnM0dTlIcUwrTmwyeU5x?=
 =?utf-8?B?YXIyREZidjRTNmt4NExIQkFKRkpTOG9jMGFoZk56N2E1bkRqMS9Qd0Y0NEpV?=
 =?utf-8?B?WnNQWU5nN2xWcStObStHb0E5MFdzb1M5em9LUEpudkV0N2dUdGdzdTdXOTFG?=
 =?utf-8?B?T1lrSjlzNWVOeEI3Vms3eS93dzJ6L1UvalZpRkEzb1VwRG00ekx6bkxURnpQ?=
 =?utf-8?B?QVp3aDY3MGRrdVNUL25ZdEY0RXczMlRCRXIwaHlFeGhlQWJUNkJ6YWFPWTFR?=
 =?utf-8?B?U3MwMEZTRmhEcG5UWlZYYlhsWE1ZTTgzMXZMWkVwcUE0NnlERDZQQUxyZ2RP?=
 =?utf-8?B?QjQrU2NjS0NpMmlvR0RIOUc2QVhuSTV6TWJ2ZXZ1SHVib21CM2I3U2NiSlZz?=
 =?utf-8?B?dFNQMGYwTkJPUEJBZXE4eVFyOXYxWUNwVVEvNHdxSTZoWSt0ZzVPRjMwNnl5?=
 =?utf-8?B?ekd0eVpXV2xrenhxbFQyNE4rbmx3MW1wZy9aYVlidDRwK0JtL1lGeDVZNnhp?=
 =?utf-8?B?YUZhbkFkVlNQZHF3VXFLZ2hTRnJITnJVbmJHVEFkNFZSZzhITGVUNmQySmZG?=
 =?utf-8?B?TkVRM3dnM3Fhekc1U3V0WmRvRStIODN6K1lJLzlPZzF0ck0zTzY2cDVQOG8v?=
 =?utf-8?B?MDR6U3RwQlJpZDlLOSszUkQyb3BtVHdYeW55MWk5UGNkbHRqMld3WlMxbEky?=
 =?utf-8?B?dWdOemFyQk5wZ2pjL0l1eHdTY0hYZHhVSDNoMUFnS0U5VjcvVDM1QWFwdzRl?=
 =?utf-8?B?aDlZRUYxTjFLUzZBeWJXY3JZTDJGWmxybi9pVVhvY0ZTdzFHbWx1c281aEw1?=
 =?utf-8?Q?2w+3YQ/1qXkQLuvz6HgPBPU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WQ4vENRzUdGHAligsj/Lb+6676l7TsdosWai8CrMLpru4s6YaSvovKRZeM+XF0m8wgChrbGo4ohA9ViKDelQ6OAiu/HSInrUDv4MFDWko6ZKqPblMKUrNkAudxjDtPG6xKoz8N8VdknJ5hUlvmBu6SSSbryWUlziM7uxpFaKrU1tFgKJZFwsw/OjKq0LvZjBQ9dExYHdNfyWtiUKlzD7nixVpCMITdPnurgDjQn/lwg5ngt0U8x6XNZUoIsexIoz4XcM18KFGuKtKYSY8MfZ/dxbiN51nv/p5FmkqrCVg8av6h2pGgVjfAByZjsppTF0Hxmv6FFNV1Q25v/JY3aBnoxQf60kifYA6WtYPtAIzGiDMd3ppFDVFSGR4szEMwDbI8cMfqEbvpfYtFhRtC0ftHNCSN/t0IqPx+dbIIzYyKfxWpK9bPuhuoCFgGIY0Jl5OHtXMky4YKycJ7PxgLISEqDRgvDt4UXN+xk+M8H3ymjj+ERAYrZo4gauad1SBiU1YiHYzRAuNY8VCIqBRTte+nKWA4xTsAzzuOjbfd7+esJtUL8bwj93TNsj/MRV12NC/XuDGpJnTevFC4rNa8EogrepiZoR+7r3q/GQerOtQ/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25974d-37c6-4f9e-b0c5-08ddbfba05eb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:59:44.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH41KUU80G1YsXOxSYHhb4/DxDMafF/8Fz6KdmzkQW/ppN1yR0p9xfKdhxpU0qI2/9JDGEYfi1rcG2OJGNq4ZHYL9JTqUOx9NBFsQBFK3i+d4V/VrZloWxnyEdeggN/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyMCBTYWx0ZWRfXwGN+kPBnXekb xrX98dsyU3GM4Lg8dUrVcyy/78j7nsgMGgjZWYxQegffiDVs0UO4ignhdnCJFYIETGl7bAW0T0A i8d33sRUrV85u5ykqBYLwtBcHhYyYlaxMATTFW4AAbV0pezyn1egDmYUBBVaI76RzU7i7QLMEcD
 cB6airlfekX1Rb36sVnMRYv2ogGc0C+YE3ajtBhN8I9uK7i2EfESFB9r5mbmE5j2w5QTxwVgaug X4E8D4x7Tef11qFoqEq3ibEPOIg2yWhbZQfXjtkpEOBX02QT2AsBVZnNjhm118HtnK9Gg2msPLr jsIT+UMPD8EUAdyKN30H54uuhy+u2BTMseHMh83VX4GJYukjj4VT4ni+RBifA2ckpBtqrQilfxA
 NoLWEQQBJ8jPSodbInA6tUayunVnJlHNkiULJ0Cqe/V17pTUiWLZ7C3SSoJ7v151GLC1+UwK
X-Proofpoint-ORIG-GUID: hv39PWnji_-p_vgKs2GUr5VuRuo5PJDW
X-Proofpoint-GUID: hv39PWnji_-p_vgKs2GUr5VuRuo5PJDW
X-Authority-Analysis: v=2.4 cv=WOp/XmsR c=1 sm=1 tr=0 ts=686fc755 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=PtDNVHqPAAAA:8 a=Z4Rwk6OoAAAA:8 a=p6NqzbVkboAfrsl8yFsA:9 a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22
 a=HkZW87K1Qel5hWWM3VKY:22

Hi Greg,

On 10/07/25 18:39, Greg KH wrote:
> On Thu, Jul 10, 2025 at 12:35:43PM +0000, Heyne, Maximilian wrote:
>> From: Oleg Nesterov <oleg@redhat.com>
>>
>> [ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]
>>
>> do/while_each_thread should be avoided when possible.
>>
>> Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats")
>> Cc: stable@vger.kernel.org
>> [mheyne: adjusted context]
>> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
>> ---
>>
>> Compile-tested only.
>> We're seeing soft lock-ups with 5.10.237 because of the backport of
>> commit 4fe85bdaabd6 ("fs/proc: do_task_stat: use sig->stats_lock to
>> gather the threads/children stats").
> 
> And this fixes it?
> 

Our testing also showed that after the backport of this commit(on 5.15.y 
based release), we don't see the soft lockup anymore.

> How?

I think __for_each_thread() is safe whereas while_each_thread() is not safe.

This thread 
https://lore.kernel.org/all/20131202152437.GA10896@redhat.com/ explains 
why while_each_thread() is unsafe.

Thanks,
Harshit

> 
>>
>> ---
>>   fs/proc/array.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/proc/array.c b/fs/proc/array.c
>> index 8fba6d39e776..77b94c04e4af 100644
>> --- a/fs/proc/array.c
>> +++ b/fs/proc/array.c
>> @@ -512,18 +512,18 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>>   		cgtime = sig->cgtime;
>>   
>>   		if (whole) {
>> -			struct task_struct *t = task;
>> +			struct task_struct *t;
>>   
>>   			min_flt = sig->min_flt;
>>   			maj_flt = sig->maj_flt;
>>   			gtime = sig->gtime;
>>   
>>   			rcu_read_lock();
>> -			do {
>> +			__for_each_thread(sig, t) {
>>   				min_flt += t->min_flt;
>>   				maj_flt += t->maj_flt;
>>   				gtime += task_gtime(t);
>> -			} while_each_thread(task, t);
>> +			}
> 
> Ideally, the code generated here should be identical as before, so why
> is this change needed?
> > confused,>
> greg k-h


