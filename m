Return-Path: <linux-fsdevel+bounces-25304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33C94A904
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A481C2347A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CF20011E;
	Wed,  7 Aug 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcT4L7K5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g/zhtdE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55731E7A4A;
	Wed,  7 Aug 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038637; cv=fail; b=G9QiposbTh1CNUzcFL2cMrpqhbK2VHmq8Ma0e5RB05gMAYkgdHXSBjR3l79p9nGPeGND4v8n5B0W2B/sRG44c7oo1i4/rzdh10e2uG1sD2IJlt/Djpk1NS3cqNar+QyAOT/iyXecFCuwszWxfYuAQihsVjh9RIhjpGWhH51vea4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038637; c=relaxed/simple;
	bh=pvyD2yk4qk1cAH8deIb+psnTo1HvOljnTqsnM2tYQNo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVC88SCt4iAQxTuF8hUFvmGAu9v79jk0lPkxsLDvZF+TYx04qsLByoN+xP5S9RiMoOamrGQv6/oGeNZRgw1l85TqiTSnz5db0qUhX7stMj8Rl0m+mREt0LrHejijnzWaxjVW5f074smO8TugzMP1mYWOJ0nmg/nK28lgcJjNOFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcT4L7K5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g/zhtdE/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASVbw009999;
	Wed, 7 Aug 2024 13:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=w4+1jEMrx0IWVu3TGSZpcGORXd/TAj2vBB4ipSHMjRQ=; b=
	UcT4L7K56fy5GMTUbWbn+a9O2YTxrk1JP6WwD65xZ2N6AWIA5AGdQ/r0azI9EGAg
	wUXBd4U/Z+HhZCfUD3IET+f8AbAVrMFZCAUj2PXec+aKLeNOhCKZURJbf71eUmKR
	S85sJhwl9Gigl17BCtU7HJBtXmlwxWUfOoLz+mTZmPO8PDhvhoQGasKWINwi6V1O
	wJivcsdYFA5cwNWvFlFUR2Kpt3swxzZgExtTkynCW6rD7hobTnDBjSBZvh3Ydy7R
	8q4PxqASXig/8moT2WG5Ljr9VLKXlT6EU1UGOcEoDOFzjcin9X8Yjzkz+qgqQqf4
	SPJFKEnt/ROJX5B1gdJYIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcfmcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:50:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477CRZp2018388;
	Wed, 7 Aug 2024 13:50:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0a18gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slRPMLewo86ae1V+wVuGHy2OEuryXyHG+g7Sdz3obbSo4vECsZ7c1ihRoM9Hamrsah/18zvlTQUgdaMk1Zvdvo2V1txrMSOLIbQSZ4aAGcB53L6r/CTAjJTJV8DhBlFdQnMSEsIrIIOOp5Z7T+LRxYEbr47/xmTfMp/Ot0SzLRjH+l8llXFPYeFG08D48akE1vXUE+Dqz92LpZatQUvKGOy5NE24/bbLMQCl6Ly7sBpGI14ehF5Vj4d2ev5b1D8Ov/yAMZemUxA6/A8nEmgLofcnlhO1t9Cp0cpit8Q4LXnYLBdqQhZYWYkOKrEW4zJPw1WHoSaVwwE6ypD0eFmHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4+1jEMrx0IWVu3TGSZpcGORXd/TAj2vBB4ipSHMjRQ=;
 b=HkDFgtxUfg4SZujOIRGCfdc4uUvTKT15z8BJh4gXuyHl35atLcQJCZLXTo1uX+VmUzJp7O1s1SiRId5Tgp0uaCgQ3vOVSlLjnbVuV9QlbQ8nISqFLLlXOZ/UDQ25gqE5Pa60AJ3v5CrNyhyFfnVpU4009eVo0voyM30QN2YdE3G93D4gJGnBjn4Rb4bMUlXOQwDNwDLSB1v53DBO+xOE+S9W8pfJ9qXpc2+31Sm2AVRdjv8un/fK2jij9tcNMru9y19iqd1nsIZulmkp+35f47EeTnHx9bxx84gSp/z8Wdsb8MSK/XoHBIeUuKisKV/Q4H0+RTQOa/WymbuOp19dUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4+1jEMrx0IWVu3TGSZpcGORXd/TAj2vBB4ipSHMjRQ=;
 b=g/zhtdE/L2rIYHR2YoVl7WRkfaUcoEDq1WOd0TaxK6W3JjCc3n5lrYwr8U03oQeFZ2F0dyP5npupAlUb4r/JVSrZ6gbpv2U0WG0/B/efnttVThqi9I6prsas5+Srr6g6efbRYmyJy+kzjm/x5htmXGJQMNd41Qme4idwNegVf3E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW6PR10MB7687.namprd10.prod.outlook.com (2603:10b6:303:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 13:50:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:50:22 +0000
Message-ID: <19fb82cd-77e6-43af-a0a2-c08700b04066@oracle.com>
Date: Wed, 7 Aug 2024 14:50:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] xfs: Enable file data forcealign feature
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-15-john.g.garry@oracle.com>
 <20240806194321.GO623936@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240806194321.GO623936@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW6PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 76671d55-3150-43d7-1574-08dcb6e7e1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzVEbXJERFk3bmNERVpSZWNVL2h0RmxzV1JSdlBzWWpWUTFvandXZEVjbjU2?=
 =?utf-8?B?azI0Z0xYb1Jtby9OUHRDSTJFQk83Z0R5STY1bUJNTFpJWVUwREVlQWg3dzZJ?=
 =?utf-8?B?b3JELzRhR3hTVEorYWdDbGpDeExkOHpEVjVobk4wZE5kdmFFakZjRzArckw0?=
 =?utf-8?B?cGhURXB6aUFwSlhzNjJOelZaUlRDa2RPQldJY1hpemRxYmhpdURVazJtVzhY?=
 =?utf-8?B?bGhrMHlOck5pTklRWnUzSndNZWRoUTg0alo5NSsvSnJBeFUvSnNHVndHYnRn?=
 =?utf-8?B?d0RWK0dVcEw3Q0VSYWtGSzlnc1lsMGJXQkwwZDBQNi93THR1eklsQVpEcWgw?=
 =?utf-8?B?RGt3OVY2aTV4L1dxejU4ZWJac283R20yYVFWdGVaRWthQnhaSUN3MDFSL2NN?=
 =?utf-8?B?VHdkbkJsWm1CUW8wYXBpL1dVNytpejJqNVFYeGxZeFBLWnc2cTY3UUpSTGJZ?=
 =?utf-8?B?eDhrVlkyTnVIQy9sbmxxSHlmQUt3SjB5Qld4N0xGK01mQm1aZzZMM1Y5Zlo0?=
 =?utf-8?B?aDdadVN0VjNWVXZYUWJlWXZHMENCam5BcGFoZFB6Nmp6R2xhaHRHY0ZFU3U4?=
 =?utf-8?B?TEs2YWhpV3RGbDNmV25HNkNlY29Nc0pvWm51SXgzNEdJMFh1ZVBCMlZoZ2R2?=
 =?utf-8?B?ZzVOOXhaYkgyWE9ndFdGVzZLQ242WDVOdm9MWWZlSlRrMmFYNEFYK2IrVjBl?=
 =?utf-8?B?UVEyb0ZiZ3lzQk9ZQmp3THdEcFZjRHBMTUYzRDJVQlJ1SjFPWGJJY1FkbmhR?=
 =?utf-8?B?WlBIMmhYU2dXeDVjMlEvTFdaRnpkMDJMMmpzV1MrSjVGd1ZUM1N2SDQ0MUhn?=
 =?utf-8?B?YW1VVFpDNVdZdTdMM1k0U0xvSk04Nm5wWGhlR25rUjJPTDFmd2VITlF4K0Fv?=
 =?utf-8?B?cG5VQWdSaW8xYnkwNklka2Q2VnhjSGhMOTJjM01OSGpCa1lpMEVXQXYrT0Fx?=
 =?utf-8?B?KzFyZS82b0RMSFJtL3BJcng5ZUhHR0Q2WkNtUWd0L3huNjEvZ1ZPTmFjQ0cr?=
 =?utf-8?B?QVUxeHJFaGJJYzVpeDF5UXFxSE84YVkrdER4NmFhaGRMaEc3ckRJUktsL3JJ?=
 =?utf-8?B?ejFNOXpyTTFzalN2UmZWbzBMWStta3VaTy9BTFh0ZXN1RzdQU25vdHd0TUg1?=
 =?utf-8?B?dExwRGs0aE1LZWFXZkx5V3hEOEZQbm15ZXhCU1hhbXFiMnp1ZXlkQ2J5OC9U?=
 =?utf-8?B?T3hLL1NMbUl2anQycjNEODRRb21RNERsVy9WemgrY05ISHg4T1diMWZUdEtk?=
 =?utf-8?B?eGxOdXp1VVM4RXhjWUJsMy9mWUJ5RDFJMVYwdjJqay9YUUhXcUJHRHp5dEd5?=
 =?utf-8?B?UFhnSnh4ckl0QmNqbGl5dG8vZDdFbmRiU1IzdlN2Rklaa1Y0VitERDFWdzRo?=
 =?utf-8?B?QU9RWXowU29xTG9iaS9vTGh1SVR3SkhGNlduTm9WQUloSkwrZFkwREtLbVZ2?=
 =?utf-8?B?a3c4NGMrREpLTmNLUlhLNTlKYlp6dW9sWVhLeTYvZzFYK3JFcE9HVXB3SjU0?=
 =?utf-8?B?OG95NWlxVmJ2MlFnTXoxSjJBNEVLS25BN2Rkay8rUCtkWnQ3RXJaaTdDT2ZV?=
 =?utf-8?B?OHVSdS9WYWF5d2N6T09xVXloeDNxQUxZSmIraDJma2t2eW5xcnpCakdDblNM?=
 =?utf-8?B?T2pveXNhaldpajlGWDRkUHhNUEJ6NG5pc2h5SU51emF0ZUpkcVRlZ2Jic3lO?=
 =?utf-8?B?ZWQ2WFVPR3R1dVZrcVdhd3J2S0psVWxuNUdyVnErTXhHSk94aVhWZ3lGR3Jx?=
 =?utf-8?B?RFpQTVFPdEZrVXdKaEt0SFNzbGVSQkNqZUwycFhiN2JDY1pISXhRa0QrNlps?=
 =?utf-8?B?M3Fic1ZzdjYwaUZMT01qZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExOQkZmVGV0YU1DdHJibXovdjhZTEt0LzZ2QWtCS2dBbGxwZ3VhcU1YR2Mr?=
 =?utf-8?B?d0hIK3AwQnJLV0pkaGVoTW5xc3RSMGczcGVhMmsxVGVhR25hL1B4YUdDVWFx?=
 =?utf-8?B?WExqQ3NKUGtGV1FlZG5YZi9XN1F4L1ZHNXlZdWR1MTZScGJLTUg3TEMyV09U?=
 =?utf-8?B?K0JyVk80YUFJZHA5clZ3eDhyMG80dnY0YnBNUzdmOTVHd0NxQzY4N0IvWmUr?=
 =?utf-8?B?TUI5TUN2TGlPZW5EYkxyVGIzU2ZtdW1nT3BROEZOb0hHVnpLRnhNUVI1Wlh2?=
 =?utf-8?B?UWZXS0dXcHJpOEJqSlhYbC8xUFh6eVowTFhLSTdRTmlwYXBCd1ZwU2QyYVF1?=
 =?utf-8?B?ek9qU1F3b2QyS1U2MVBnVS9XUFRYZEdhUkpjTG1sT0doS0FyUHllcnNsUU5i?=
 =?utf-8?B?TFJVRnFpS2JJWlBMbWZlcW55SEdXYlZxQyt5MlBWZGVMMkI1eC91My8vSEQ2?=
 =?utf-8?B?ZnVsUU5TQWVqSGU5Z3BmZEo3SHhodjk3eUVhaWVoanA1MGU5Mms2ZHd5dGNk?=
 =?utf-8?B?cHBmMDJqMVdNQ0RERVNlanN0Nnd4ZWVGbUFYVGw4Q0JINmpjcGJObElJc3hk?=
 =?utf-8?B?NVE5UEI5Mm8xVS9uanFzdXFUTG14MFQ1ckJBcWZUaXp0dXVTMFdWdENhV2Fi?=
 =?utf-8?B?SlUwcTEzLzJ6NkYrN0E4R0xndlRicjNjU01ib09GODlFZHU3YTdibGd2MVA4?=
 =?utf-8?B?M2R0RzJBL1dPay9BZFZ0aCtzVzJkdEh2YXhCVk5CQ01XcU9BRm5PbmhkanRl?=
 =?utf-8?B?NWc0S3FhaG10VzJPWkZpUEwxSDRaWjdyRHdXYWNldHBIaDRHL2Y0WU5RZXR2?=
 =?utf-8?B?YVNHdkMyajNGdzd1cVk1Wk9zY05vR0NiQUlvZ3MyM2FkUDBqRGNDNUxQT3Rw?=
 =?utf-8?B?c1UzNVZrWHQyQXVmeWR2Wms0QU5ia1pWSG91a3pXSjRuTDJMSjVjaDdDRWhN?=
 =?utf-8?B?NjJYVGx0cHlSUUVDek8wVFphbGFrTTVJSzBNUFY5NUZ1Zkk3akhTdE9hOUpp?=
 =?utf-8?B?b3NROXJXQlZWcjg4VlhTTXArNURhdzhTb0JZTzVraGlXQVZ4Q010RWsrVXFj?=
 =?utf-8?B?V012SHQzN0EyRHRMSEdKaFpuLzZNL3l3djE4RnNBZlVZNURYSG1kZVgwd1VO?=
 =?utf-8?B?dkZOL3cxR3lCbEhLOEJ6OG92SUlubDVveU9xc0JqTE5CTVNDQU1SQ3BhZHg0?=
 =?utf-8?B?TTUrdWVwSDc5Z1ZNekNtZklhY2lRRTlEbHo1WkdZR09KajJURkFJbXZoME5J?=
 =?utf-8?B?U29weG9ZUFkwSmdIeTZJTHZsdi9MdkJuZ0JwdGR1MTNabjl5QXYyVmNYY2JL?=
 =?utf-8?B?dStJdDlBZ0F4T2VVK3dvbE5FNXhqZXdtU21ETDhmUkdwY0ZDN096Y0hCaXpI?=
 =?utf-8?B?TnJDYWJDcHljS2crZjRzbDIzUnQ2bkI4cWRYczRjVnBSMllDYlFoV2dhT3BR?=
 =?utf-8?B?UzVMTlkrSnkyMmNSV2crUUJmYk9MVThLWmFXcS9JQ0p4K1ZlcnYzaUs2MWxR?=
 =?utf-8?B?UytiZnJZbXpWb2hzSmN4UVhWaVpIdStvNmF1NGdWblhINDhiemdCY2M5WklV?=
 =?utf-8?B?VEtFc0FyN2lKMVFHa2RjdzVwQUFGS2c1dWlMK25PdmZKSDRJUnZsME1ZYkJu?=
 =?utf-8?B?bTVBYWgzbFdadlV1UHhQN2JuUHJETVFaRVNjdUxic2hVeWRpT2tRZ1A0bnJv?=
 =?utf-8?B?TFJyMHM0eGxhR1JOb296ZmtKdWVDUDNwVEdSaER2dUpGcThFZ3gzaDdBVUQw?=
 =?utf-8?B?Q250a2FydGoyamd1bzljMzdTaG5JeTU2UXpvcDlPMVQ0WXdIQzhUVXRPby9E?=
 =?utf-8?B?Tkkrd2VVTTR4aFNXUDhKdzllUlR2Y1BkcDVpOC9uanhWZ25yM3NtTGRFcHdI?=
 =?utf-8?B?WGoyeWZiNXpuVWliL0lEemhRNWdlSzZucWRFTWJma2hpK0hyaG90NWw1bkRj?=
 =?utf-8?B?TjAwNVdvb0VIZ1pnZkhXTXBTZXF2KzlVMWFubHU1UzloeGkzcXFHWVR6MUpM?=
 =?utf-8?B?V0VNZ3Nyd1FZQ2k4bHNTb3VwbEFnVEF6T0tvbGgyclMyS2ZzbU9rVTZCaTJL?=
 =?utf-8?B?Rk1qOUFadGlZUkcvV29admpTVXRSN2JHbkowMkVsZlNVd3RLbloxOUJXd2pJ?=
 =?utf-8?Q?3u28biNxGdebww8+K8K+NBozn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+yTiLrksltSTZpcLS+Cdr0abF8DWsLoer7xK7cAN3msA5CerFc4D9eHMKBPgauEPIvslbyt5dtaSvkNMx+9I66UBFpPdb9gY1TeZ9kWRVM19QEET8nHke+Ss3WAzx4XkjHxhUysF9cvstdb3Unop9fAyh0wjWw1H/bb4YNeFrDeB16M7+3zGYGLxSMa+24vwVLpL5UT1oVClxRJ2UQ6LGahiNifes+ePaBNCfce8VNPYiUTqyt3QWHkYYJEi+pIPr3Ldam6dRo3oxWb+otAglz5ojCN6Jeh5ekxE07EBeIcIaNOwI+cypH1bdDAXG5mGr4XHQJPWII5UkrX9Q4SsrSz92ufTaU1sS4mkuIw7AJBUXuFzAkrQTKZ97UGG6UT/wNN3BxZgjgp1h1dek1SK9ZudKF6qdX5qQKKbd3rBxYaIHz7xjSJr5vBWQctwzft7bBN6ImqMHrYOD8io7RzwiZuzo94KUQsmlFQzpv3Bu5x+5sR/E8d+7Ek+qFFhM/oJN65KRkVKAq0FPap9dDm8Eg7xSAlUfO//ZrrYmsMr3O7wD8PyxYA5cnril3XUCcDSm3oipM+p5BC0Dr0tHBc07VnYYU+oMkXErxY2XtS28c8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76671d55-3150-43d7-1574-08dcb6e7e1c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:50:22.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/7iw/Lr9Yw8A5Yg+faCKD2Df56Cy8tH8vd4Kv8FLZKpCKgAtfFnsZ0ODc9mZerWOXOL2O4iyVhtoY5ox6Np1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070097
X-Proofpoint-GUID: J1pYRVoKoJZqLcccP_Oa62QIV5AdxYkF
X-Proofpoint-ORIG-GUID: J1pYRVoKoJZqLcccP_Oa62QIV5AdxYkF

On 06/08/2024 20:43, Darrick J. Wong wrote:
> On Thu, Aug 01, 2024 at 04:30:57PM +0000, John Garry wrote:
>> From: "Darrick J. Wong"<djwong@kernel.org>
>>
>> Enable this feature.
>>
>> Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> You really ought to add your own Reviewed-by tag here...

ok, if you prefer. Normally I think it's implied by the context and 
signed-off tag.

Thanks,
John

