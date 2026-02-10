Return-Path: <linux-fsdevel+bounces-76845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEkXDfE+i2mfRwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 15:21:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A371611BD5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 131EA302AF10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FF36B05B;
	Tue, 10 Feb 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="F1io6qCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610D27FB25;
	Tue, 10 Feb 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733291; cv=fail; b=XYOCFHM28pwtp+MrPZmlW3HSywZklB+vRqaVlIYSnbVCGW8kJ6u0pRNKmY6dpTu8I2l5BtDGSNG+emTb5GlCImY0jnAtfuzFnlFKeBapvKqV7Z05CRjaXDpJuPQkuy9/JYPDE377F7VW6psn12YRIx73dNhNpuqOlmYPlD79RJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733291; c=relaxed/simple;
	bh=1lxiN0a4Q3sikjY3JlMojQpGLsM/7bxaNx9EQnEWfk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fiUV3+0rIGYpX02F+UCqm0LmOEY/QdaxIfKo7lfIF1Hb0ayifbYDa17YSlsc7Qhz3x+t56tRav/s4Fwpz/y+JI6iGChJOcr3xWqZydZ0hx0kly0SdtQRRAvkDy11mSwE7PzqjGDZ8AYB3YMPxLOeQg37OU7y6IDI/UxMq2Drstw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=F1io6qCt; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A9nZA4337089;
	Tue, 10 Feb 2026 06:21:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xfBlyKNzZ9i8ZJhRA4sxUIAgaU8oANdWpedfiXySHF0=; b=F1io6qCt+rwZ
	q0AGjQ6IBwyuWf0aUNd0eZcqep9B6t2TFNu7ivDOf6OmeNfa7xQ/XTO61mJeg4sz
	yzuh5s+VEJi1b9j9Hq2KuLRXdxumhgQGYS+o4jb8w9K38Rw5qmqQfsrQbIDa3EX6
	5LVPAbKUqPY/FmY4PRJgmoAiMpazNChlOHgUagPxQBATBd9JJ+I96STXW1F0kI4a
	6w3qCfQpUULzStu70MkW84zfNvLe4Ce2JIhF1QPutroUgq6jSE8qBdlITYqdvW+b
	tJa0D/2n3URCAEB0XB+ZOfTLpAkzWkGInGIqa18227mYQy75wpiRR7OZUpJsJQbs
	GurNR333vQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c82cqtbsn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 06:21:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsdU3oJL8ay0yUwflkx+JhwOF6M0S3i+EO2MX6i948RXldP6V36EnGl3OXakFPJgu7tLKkj2AZ2zf6Z1RgT7EMW4BuhW/O5OZZuuTYtfNTN+boiFV4xApTm4GGd3fGbOqDmnq0RERWX+XgG5WvDj6wCGwDknREYzRE9qlTtHqXDIBjokyB/REZwJGp7RoJRmiy0KHivvfK2G3Fh39/Cza9KB68a4vyWNHC/PM6KxeYxWzonDkU3qsKXSM+wHWi//UMFymEj94K18kKv5AObuAQNIwaOvgYdQV7cJkRYWc7uTvTN8PZMERf1VBDCqjEo+rDz7KZM+lmamzEGNvuLK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfBlyKNzZ9i8ZJhRA4sxUIAgaU8oANdWpedfiXySHF0=;
 b=J6FKkJWK/ygbHWBaz6KCk4oaVMEZYr1Na4kiWFPvwSg5pz9/kAC0bLQ+zhNjFSwDq5W1N4UlBP4GwuvtRe/TBQuevtqukhe6lg2CZ2dZDzDqR4yb6brd7rDsZ9AarJUGEUc9lVfEXMAIZo85H8zG9Hd1PtjIV09ebrI9gXM7cJtP8SbStRkM4brBc41F268ZYHsyed52d0kKsA45FyxJ6Y0sx7dBrACk9l+F7wk+udpMWGQioMFhYPANdZRI0jeiLVLrvb3tbhE3V2/q91v7Cys/4U75ZieQD/CnmVj0oAXXQNSjdAL21iHU+Mm6yNNg/QCUyqmPokq3Deiwaw+kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CY8PR15MB5532.namprd15.prod.outlook.com (2603:10b6:930:94::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:21:10 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:21:10 +0000
Message-ID: <a1bc8ccc-730c-4076-82ec-20bf86dd100b@meta.com>
Date: Tue, 10 Feb 2026 09:20:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Machine Learning (ML) library in
 Linux kernel
To: Jan Kara <jack@suse.cz>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "chrisl@kernel.org" <chrisl@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
 <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
 <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <6ek3nhulz72niscw2iz2n5xhczz4ta6a6hvyrlneuyk2d36ngx@4ymlemzifugr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CY8PR15MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: f291123e-c444-434e-1a8e-08de68afa36b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjkrOHhxSkpYYklWa3JibFBsOWNkQ2NoNVdMdGUyM3RsdWtQV25udFkxeHBF?=
 =?utf-8?B?TFROekNTd2lQRkZQTTc2bFNPZUVwcjFjUitJVTlMTk1leXBwVVFIQjA0a0Fi?=
 =?utf-8?B?UDYwQ2twQS9UWENlY1cwY21FSmNaR1Jkd2lESEY2MWRUTjZ3YVJpSDU1ei9W?=
 =?utf-8?B?R2ZMZHlKSlphdzJIbFhxWjg3OGdGbFd6d0tBSDBqc1VFR1NpK3BmQlpPOVF3?=
 =?utf-8?B?b0x0RnNnTTB1NFBNSEcrbW01Z0swZVBDM2hWTTBvRzA2dndJZ1QzeExYU2Jm?=
 =?utf-8?B?ZFpxMnlJWllVLy96OVVpSzlsbjBOVW4xZXIxZ3hzWlMzc0dCU0VDbFF3bHVx?=
 =?utf-8?B?Z056LzZ2dWYzelJUSXkwUXVndlc3UHRmWi9IZnNtalQwbEdlUTlGendIdDNr?=
 =?utf-8?B?T0VRR0d5YllSQTVmTnpXL3BBWFVTQ3lMazloRlh0NTZCMHM4cGJHNk1RS3Q4?=
 =?utf-8?B?cXNJMnpvbFFRTzI5TU0vOFhQY2RxSzFlSEY4UWlYcnhjWUlDMEJwdDdaMUc2?=
 =?utf-8?B?Zm1qNkZFaHpPS3I1NDdWcGZxSTNVcmdVMENESGlBS1VGdm9oWmFwMFNGbDlx?=
 =?utf-8?B?eVZ1OXNHdDBoRVNCTjFiMXluTFNmMG4yTFRxbFZEL1hyL2pWSXlSZEVJM0FM?=
 =?utf-8?B?dFgybW1JSUhwSXpuREpadk9Ub1Y1Tjg3ZGNnaElSWTRER29HYmlrckp0WTkv?=
 =?utf-8?B?emNkQ3I3ZE50dGgxalp4a3NSWE5uRFJjOHlDOHY4WEtWV0RLYytrYkd5clI0?=
 =?utf-8?B?NmNiMWFvSUd1Q3JBMktUNmZjMk05Y0x1TS9hemFDazloeUhMYno4Y0hVejhJ?=
 =?utf-8?B?STZZNTVmb080Q2U0akg1M0NZclpEbGpWalNCbHBySVIvRXIydENEcDJkV1ox?=
 =?utf-8?B?NVF0cHUwRHBmUGlvbzdwcHMrbTFOK3ZDdGw1aG1DSjdkYzMxczF3UGZVcjBC?=
 =?utf-8?B?Y1gxQ0pjb2QzSXVMSFhrS2svNmF3VUh0WmVSOXg0d1FBL21WSVJZSXdPN1NG?=
 =?utf-8?B?N0o3RzA4V0tJVjFUWEdwVmlJdnNJUVJRckVFYnpBODdNVVNSSi9sQU1EbURm?=
 =?utf-8?B?UDErSUtNN1NPeTE0bkNvN3J1YUFXc1JUWFRPK2pvL1hJM3liQzRGeTI0TGhw?=
 =?utf-8?B?RDVOSWhMRWc0dVM5ZVFKMHdYTXNiOVhWdVlSM2ZLNnJJZWU4M1NYaCtKc1V5?=
 =?utf-8?B?ZmVRa1lLLzlZV3IwR1JvMVV1bTUrSHFkWlVRUHNZZW5Bc0FKQ1BQQVhPT2Jm?=
 =?utf-8?B?b010TmV5bkVYRjJIWEllZngrM0RlWXBKWmdaV1EwcVJxbkQzVTFsZnlzRG1a?=
 =?utf-8?B?T0I0N252dlFHdForUlVJdGNKcUJiU2ZrMWFVZitZeHFIb2FFMjlMUDZmZmxP?=
 =?utf-8?B?VnJZK3VlNFAwcll3NU5DYThHRUxHRk4vaWdMMzlNRDJzZm04bFFjU1RGZXVC?=
 =?utf-8?B?cFUvMW1odzBaV0t1amsvazBCN2JybmpsbS8yTnBZUFhKcnVxekJiVUMrV25U?=
 =?utf-8?B?WUtpdnRPeGVkMWorQUlIbEsyOUxBUkttU3JDb2N2cVBha2Yyb3o4dm9jOFVw?=
 =?utf-8?B?dGo2Vlp4TitKMEFGNi9HUHp4ZnRTdXFneWgrS3dWbm9xNXdnUGgyYjNaTndi?=
 =?utf-8?B?cTNIRzNOTFg3akZ0WjlqN0Q2MmFtbGlsWFozb2R4WXh1aCswbkpLbnE3c2Y5?=
 =?utf-8?B?WkcvQmUvNjg0OCtudVBUSlFOODExSVVYMDFmRFR3bG5USVl3QnIybFVYYm8y?=
 =?utf-8?B?eEFyZDJZcm1JLzZWcGlDdEd6U0hWenFmTjhvRkU4bGlKRmFmREozT0c4T29k?=
 =?utf-8?B?WStHTTdTYkVKM25RYlBWM0Q0WldYZzRsVFgwdjdUTk9lOFNyWU1LNXViKzZ0?=
 =?utf-8?B?M1d5Qkk4a2ZvUHN3Y3ZXODNUZ1FsSzg5QVdZSndaMWxHQ2UwMTBFUzlNWmJH?=
 =?utf-8?B?VUVQOWMyaEhiVUI3bmpGM3ZJcTdqeFhSWXhZaE1iOUlyKzdaN3FlVkx0SkZX?=
 =?utf-8?B?eWtMbEVwWnBKckw5bytySXFXZXZaSjVsSFhWQlh0SG9yZ3Q1YlgxZ1JKc0Rk?=
 =?utf-8?B?WWQrSFBUa3ZyVkl0cExScGpTdEowcVhQQ1pQTXBYZWNKcm1vRmtDS3h4OU9z?=
 =?utf-8?Q?cCkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldzcEc5b0lDcWVrZHRSeXFYaEdtbGZqc2lkNUwrb0VXRisrZ3BjZzZMdTh0?=
 =?utf-8?B?alMrSUUzQmhycGpwQXJ0QXgzVEl0TDhUdkdDcUxpc2hTMTQvd2NaNWljS0dl?=
 =?utf-8?B?dkJtaDF4RllGc01zWXhDMUdnVWdHSng1OU5DTUNIbkVMdDF3dUdTa0xxYXlt?=
 =?utf-8?B?REhkaFg3Yy82c01MdjFvaUk5WUtBaEkra3Q0dzdGTWJnVms2V1VLSWhtU2RN?=
 =?utf-8?B?VytmYitCT3pGTmpId0kwUlZpU01ML2xEUldmUmhEcTUyeDhNdm1CQXhkeUNB?=
 =?utf-8?B?N1dzYmU3SzUrdVFvV3M2eTVxTEtGR2licnVJWjlWd2luZTl0N2tEdnBnK3VF?=
 =?utf-8?B?ZHJKYXY4R0FKOTRrSGhhcGRPMDhBOXdUc2MxZ1JUT1I0aHM3ZWtZSko3YkJ3?=
 =?utf-8?B?WTBCZ1lRUGdMWjdqSTlKa2JpVzNNbUw5ZDEyWktCbjNuVDNBZU0rOWk2OG5J?=
 =?utf-8?B?MFNEL1phOG1kdzF4aTJ5dTZNbE5Qd3BzN20vOVRqMm04V1VZcWZVdjN1bjVz?=
 =?utf-8?B?VnhhK0J0OUhFL0VuRHNxRWpjWHJIdVVxeUVqNmo1cTdXTUxkVTRvLzRCZGsx?=
 =?utf-8?B?RVY3cmdSeFlLWE13SzFiK1VZWk9NZmVLWnpiUXFITWNyK1NOOFFyNFAvYlQ3?=
 =?utf-8?B?MGJpTDVab1hMU09GeHo2MDQ1Mm8xeUVtSlZyU1JmYmlWcEcvOXpSUHd2QUd2?=
 =?utf-8?B?a0NXalpUR3hzMFd4U3gvZDFIZXZnL3pFZm9sMTFCM1diR3ZuMStEaVFNY0VD?=
 =?utf-8?B?K1R0RmJmRjExSnRPQzB5aldXbVdpaFBiS3p4OFdKWG9saWo5eHNsMDVqRjJq?=
 =?utf-8?B?ckcwMmpWNXJRcnhsMW9adlgxZHQ2ZDlJcHhXTGJROHI2QzdVU1pYZkdydXU3?=
 =?utf-8?B?NHljR2s5RENhVzI0a29FNC8wdXd5TE5GL3E1QjJMNFBsSDNaTVM4R0p0OFE2?=
 =?utf-8?B?dzZWQUI5MVVEeTFqU0lNdEVYdzhkY3JwVW4wZFV5UzJJckZVZHhCRjdIRHZF?=
 =?utf-8?B?dlBSajlkZkJ6SVVaYlc1NXhVRjBuZ243L3FrS1M0cFZYUzVPclZWbEtyZU5p?=
 =?utf-8?B?Q205UVprdTVndHR3VGpCclYrMzY2ZXZNV2l3VjhaUjRDNlJnV3djTURpTU5W?=
 =?utf-8?B?eTBLZ25rakZ1dHY5ZSsrU3BZOWVCR21xdHlTT0ZENHdDN3JrWUtFUWU1OW5Y?=
 =?utf-8?B?cmJRa3NJMk1HSWJpS0NOc085dVQyQXpLYzh1bjdwNTVSdVg4SzlUWVB3Z2Rj?=
 =?utf-8?B?V2FCL3MrdHRGdUdWekhacmFmUGVTai9zM3o4UVVFclhkT242NkROY0tndUtP?=
 =?utf-8?B?MitXRVlkckFTU3NYdHZrTTNUcFM0QnowWThXMHozQTN2UlN6Qi94aWxHbk5M?=
 =?utf-8?B?QVVjdlhlRDQzbDZlVUV4ZmZ2eEVJZTY3bHVlT2l5TjJDcHFzb3l1R0JONWZ1?=
 =?utf-8?B?WDZiUkd3Tm1VZjZUVjcwbXJuQ2Z3MS9tMFAxa00vdTR5RXZpYzB6T0lWbVFU?=
 =?utf-8?B?OFAvTDBlem5QWXJuZ0xMdndidmIzOFozbU4wZU5jK21ubHZUeHhNRzJFODJF?=
 =?utf-8?B?ZU1HK1ZEMVpDdHROVDJKNVdWcHVmSWozWURsejhBRnQzVE41Rkoxajc3RVhX?=
 =?utf-8?B?cDhodkIxWllDZm1UMDgzV3RieXQ4VFZXRE1DcC9seDQ4MUNtbHIwZVlMSmJw?=
 =?utf-8?B?aEQ1S2xMMlhUdi9QVkNUL09kTXE0QnhoaVJrdEJYNm1KamozY29TU3czZkNy?=
 =?utf-8?B?T1hWMlFJTUpINStLakNvaWQvanljSnZ1c0JBVmh2MU03aW03U21RNWFHeVFK?=
 =?utf-8?B?SW0ycENGbUROd3dWejFoOFUwUzZxeXRDVWdoanpIV0F3ZFcyMEVTckNFRDla?=
 =?utf-8?B?Vm1WL1pvdHNiWVVMbnVMR3A2LzRsZEpYK0NJNVNNNDBZTXhWdk1WZlVWZFBl?=
 =?utf-8?B?U2QvTmk1ZTU4bGljc21KSWdwMHM1a0haL0VDY21RcGpsUlA0VitXVFZ1WVUr?=
 =?utf-8?B?WGRqVHg4dFYrZVREUmVINzVVa3FBbFc2WVBVY1BpakpRd0cyQ1EwT0J1SXh3?=
 =?utf-8?B?TWxpQTB0RldKRkl2Q0xEQVNQMnBYNEtiU25UejVJT1hWdXRiYlNnelRSWmZ4?=
 =?utf-8?B?cFpZV2ZsSko2aGtRbW0vNXJ5LzZHUHNneG9JMTh6SHZvc2pzQU9CN21XK3Fy?=
 =?utf-8?B?dVRzbXppYmwrUWpHaFd3aVBXTVpBNmZLMnF6V2o5U1ZWSXJsQTlqV3o3TDNr?=
 =?utf-8?B?WnBQQ3pjTWgxc01aTjd6T1JiQUs2NFFidGZFZ3cwL21xQWUrajlDaERrQ01w?=
 =?utf-8?Q?jFvLTYHhUuyaql6WjM?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f291123e-c444-434e-1a8e-08de68afa36b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:21:10.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibBY31FQLI6mmzOefU7DMch35VJl+V4ckC4NOOhkRiqUZ3ZMqgvN84yJwt2w84Vv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5532
X-Proofpoint-GUID: 3n1xEzwhFWVCANkiYj1Up92iNul_O8Tq
X-Proofpoint-ORIG-GUID: 3n1xEzwhFWVCANkiYj1Up92iNul_O8Tq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyMSBTYWx0ZWRfXwkGTPC5TdHPD
 4yqd/wJ1/x14DJR4q0rC1j4yVRwFbts1wPprTjzA20lzbCtE3fvq4zZuLhwzMnf1OAwA+/gDLF/
 1b+NRIErITF5b8OcOKv/dYDS/ikdZNrIacKEkxQzKSDSg31J+d3x5oM/I/kjhlrw7uJjXxjHekr
 Phpmgt8mjsygu6DSgoThxuqq8D9Cge6DA4Zu1R89yZzVXkWK3qfoQCmZMWSofWsmLAx5nLrEKOK
 TwsvLQHJelc2tjiytm24llrrCOg3ADSJ6X6k5TIUkgaPlMqsY1c1wmI8EZ2+vGezjxV+j0Xi0lN
 1MuECitEtu4FvAicC0W7QmmpLpAghJtViCw0sncdnqtrs+APv2FTW4Iccglx2FL2rzojTo2TOwd
 ek/xs3hevpa2RqT9c/uz1yQn3Zi/zZrOnwik/WoF/jkcP+LnWVOCpy+p2osK5l7SaQPVmJFePs2
 d0hQer8fsGqLz59PAKA==
X-Authority-Analysis: v=2.4 cv=HJ3O14tv c=1 sm=1 tr=0 ts=698b3ede cx=c_pps
 a=9FhzUGQqNQs6ZJfz/MkW+g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=WSp_y2gZTyYdvaNmFTkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76845-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proofpoint.com:url,meta.com:mid,meta.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A371611BD5B
X-Rspamd-Action: no action

On 2/10/26 8:47 AM, Jan Kara wrote:
> On Mon 09-02-26 22:28:59, Viacheslav Dubeyko via Lsf-pc wrote:
>> On Mon, 2026-02-09 at 02:03 -0800, Chris Li wrote:
>>> On Fri, Feb 6, 2026 at 11:38 AM Viacheslav Dubeyko
>>> <Slava.Dubeyko@ibm.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> Machine Learning (ML) is approach/area of learning from data,
>>>> finding patterns, and making predictions without implementing algorithms
>>>> by developers. The number of areas of ML applications is growing
>>>> with every day. Generally speaking, ML can introduce a self-evolving and
>>>> self-learning capability in Linux kernel. There are already research works
>>>> and industry efforts to employ ML approaches for configuration and
>>>> optimization the Linux kernel. However, introduction of ML approaches
>>>> in Linux kernel is not so simple and straightforward way. There are multiple
>>>> problems and unanswered questions on this road. First of all, any ML model
>>>> requires the floating-point operations (FPU) for running. But there is
>>>> no direct use of FPUs in kernel space. Also, ML model requires training phase
>>>> that can be a reason of significant performance degradation of Linux kernel.
>>>> Even inference phase could be problematic from the performance point of view
>>>> on kernel side. The using of ML approaches in Linux kernel is inevitable step.
>>>> But, how can we use ML approaches in Linux kernel? Which infrastructure
>>>> do we need to adopt ML models in Linux kernel?
>>>
>>> I think there are two different things, I think you want the latter
>>> but I am not sure
>>>
>>> 1) using ML model to help kernel development, code reviews, generate
>>> patches by descriptions etc. For example, Chris Mason has a kernel
>>> review repo on github and he is sharing his review finding the mailing
>>> list:
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_masoncl_review-2Dprompts_tree_main&d=DwIFaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=vvrDPxyw_JXPrkC8BjzA2kEtwdPfwV2gBMEXG7ZveXM4LhS01LfoGwqhEyUZpPe4&s=rqNez5_rmiEuE7in5e_7MfyUzzqzaA6Gk46WWvmN3yk&e=  
>>> It is kernel development related, but the ML agent code is running in
>>> the user space. The actual ML computation might run GPU/TPUs. That
>>> does not seem to be what you have in mind.
>>>
>>> 2) Run the ML model computation in the kernel space.
>>> Can you clarify if this is what you have in mind? You mention kernel
>>> FPU usage in the kernel for ML model. It is only relevant if you need
>>> to run the FP in the kernel CPU instructions. Most ML computations are
>>> not run in CPU instructions. They run on GPUs/TPUs. Why not keep the
>>> ML program (PyTorch/agents) in the user space and pass the data to the
>>> GPU/TPU driver to run? There will be some kernel instructure like
>>> VFIO/IOMMU involved with the GPU/TPU driver. For the most part the
>>> kernel is just facilitating the data passing to/from the GPU/TPU
>>> driver then to the GPU/TPU hardware. The ML hardware is doing the
>>> heavy lifting.
>>
>> The idea is to have ML model running in user-space and kernel subsystem can
>> interact with ML model in user-space. As the next step, I am considering two
>> real-life use-cases: (1) GC subsystem of LFS file system, (2) ML-based DAMON
>> approach. So, for example, GC can be represented by ML model in user-space. GC
>> can request data (segments state) from kernel-space and ML model in user-space
>> can do training or/and inference. As a result, ML model in user-space can select
>> victim segments and instruct kernel-space logic of moving valid data from victim
>> segment(s) into clean/current one(s). 
> 
> To be honest I'm skeptical about how generic this can be. Essentially
> you're describing a generic interface to offload arbitrary kernel decision
> to userspace. ML is a userspace bussiness here and not really relevant for
> the concept AFAICT. And we already have several ways of kernel asking
> userspace to do something for it and unless it is very restricted and well
> defined it is rather painful, prone to deadlocks, security issues etc.
> 
> So by all means if you want to do GC decisions for your filesystem in
> userspace by ML, be my guest, it does make some sense although I'd be wary
> of issues where we need to writeback dirty pages to free memory which may
> now depend on your userspace helper to make a decision which may need the
> memory to do the decision... But I don't see why you need all the ML fluff
> around it when it seems like just another way to call userspace helper and
> why some of the existing methods would not suffice.

Looking through the description (not the code, apologies), it really
feels like we're reinventing BPF here:

- introspection into what the kernel is currently doing
- communications channel with applications
- a mechanism to override specific kernel functionality
- fancy applications arbitrating decisions.

My feedback during plumbers and also today is that you can get 99% of
what you're looking for with some BPF code.

It may or may not be perfect for your needs, but it's a much faster path
to generate community and collaboration around the goals.  After that,
it's a lot easier to justify larger changes in the kernel.

If this becomes an LSF/MM topic, my bar for discussion would be:
- extensive data collected about some kernel component (Damon,
scheduling etc)
- working proof of concept that improved on decisions made in the kernel
- discussion of changes needed to improve or enable the proof of concept

In other words, I don't think we need a list of ways ML might be used.
I think we need specific examples of a way that ML was used and why it's
better than what the kernel is already doing.

-chris


