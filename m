Return-Path: <linux-fsdevel+bounces-75313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGCkGQLfc2nMzAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:50:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4F7ABE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 21:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AE68304445E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC592EC54A;
	Fri, 23 Jan 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WNXAwV92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FF2A1BA;
	Fri, 23 Jan 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201304; cv=fail; b=tvA441SUwVwKhgE8PnT/kLBj8HBUbBlFs4ClKejU/9jv4bJCY4JrDOI7XWEMOKnk0Th89olNCPQckElay++mdHANC7E4lW0+0zNYt/fCW//blU4KSprrdb3oA7SPAejzwI42TF1FI0p4nNelM0zuMejXF/BXeHdV6nOaYOkIU7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201304; c=relaxed/simple;
	bh=rfAiJ0PMfeQvwykGnUQzM1RNX4iPk9LDfrEc7BrxzN4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jArlrN1DQ7ysfB2XDuOXptXLoj0rIwxFARV5HoDXO2U1tRGi6dJm+OJ9rG64ZHUdGMeuvy4SP2j1OBBqKwGK6OLf5puTGf6hxAm1fjtwSopfUpo4F1E2mmi/4VNFxAh0IvXrjy0zfnLd3a3sIl7w0BrqhWMOZ8hehf8+bcHVIR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WNXAwV92; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NCcpWK007813;
	Fri, 23 Jan 2026 20:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=rfAiJ0PMfeQvwykGnUQzM1RNX4iPk9LDfrEc7BrxzN4=; b=WNXAwV92
	4Xq9eNxCH2yB8rGgFBGbHcGc8FUkuKYbA3nAF2dWZFnalh2CPHMZVGsP934MiHeQ
	41yaQUyfP69DzJMRIHjBX/Y5CXKO33Pe5BbtAQFAGc+ZLD+j+c+NeePpz4y7rSM4
	1yG6IU1hmFjggvb61nBkR/5UgjdFihZMNJjfYcEOfrB+TgcW3e70Uahv6Qj75tT2
	qgC1hj8lY75fxM9TjUEe4qUw77Iu0In019ErCiUHCuBVlxkWdmd+WYc9vcE6irZx
	uMJNg0E5kSfmGX0+snzoS20LLdUISQDRg9WcVDoojcRSorjqBsSZ27bpO8B49nOv
	Y5kVwyiEJMrYmA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukrea4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 20:42:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BADGyVuCCqAQ6rG7qjlV7KjF605XIkFBbVG49a0UvITJycFzlTGqRSV2Epg+GuWsRBFjBVwd7hZuwgPyMafDs6H10uGsiWhrVaJHvKV3vEf0LrCsuAa5MunKLkoH+VaSZRFNs1XoWGoxMhU0ADFct8NCtEskKf1tXNc4W1H2gKGED+6Q5IMWRi7NWhWk4DlyPn7gqvNCkY+Co54nVFXqu42ZAi464pxnkQBThRVf68o23U4EzBb6TLDFMQiP5eYEA4iCijdpMdks6PFj5EFNlTkOC4azReUkk0JqS7gcSMT1fZYRv2rs8IeBodoHe3Rn6B7nSg4bGpmbhrdGCiJGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfAiJ0PMfeQvwykGnUQzM1RNX4iPk9LDfrEc7BrxzN4=;
 b=K3vs3gZtNdxzjoqFINQljiJ2c2XhD+LhrcYZ6DIOFgvhtNZycbUNvDP2WmHTkNdkavNvlkyAwTtazoq3Sf4aECvz+I1t04Q5b7uPbJ6PJgO9EIlSE6uq/4ShJ061Vtv69q3N4dI5bGaHl97klx/Pw2K1UzdG4+iaczrEFi+mRdYy9KsmBJhxhnFmjGBCpb0sAYW3UuyCc04oXJ5POGJjZ52vavoicYed27/pIB2RnltXjXpD8ThnN3a0GD2TuzYvqxNQxf82BXBAxKCuNPE3E2LfUtZFwvAOea/CZHIjO/6CE/o6tV0+hZUpTaAGxaiVhkwSKMsQcInr0b4qVnwPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by CY5PR15MB5462.namprd15.prod.outlook.com (2603:10b6:930:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 20:42:14 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 20:42:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "qian01.li@samsung.com"
	<qian01.li@samsung.com>,
        "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>,
        Patrick Donnelly <pdonnell@ibm.com>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Data placement policy
 for FDP SSD in Ceph and other distributed file systems
Thread-Index: AQHcjKTJlfFaqwLMmEm7IooAgQHEoLVgNtMAgAABZIA=
Date: Fri, 23 Jan 2026 20:42:14 +0000
Message-ID: <754e529d3d3d8874889f8b7dfb87e89de24b175d.camel@ibm.com>
References: <b4bbba0993d4c1abd6566d8d508bbb47aacd7671.camel@ibm.com>
	 <aXPb-tehcuOvSC9V@casper.infradead.org>
In-Reply-To: <aXPb-tehcuOvSC9V@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|CY5PR15MB5462:EE_
x-ms-office365-filtering-correlation-id: 894e1153-83f2-48a6-ebbd-08de5abfe3e0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVJJZ3FHOUdocG1LNkw3MDBUcnZQMkVoRmZaeVk4Y2JCbDkrN2M0bytlNXZM?=
 =?utf-8?B?b1YrRXdPTEQrbzN0bVJiSmx6UVZjcHBTRFFRZjZPbk1PclpvN1FPR3lVcEtv?=
 =?utf-8?B?QXFaeDl5dlBmTk9DUDJCMlNZZitIbi9UV2dlMXZkdnRCNjdtcEUvQmdHeHJ0?=
 =?utf-8?B?bU51VzI2VWtsMHZLblNCSmswTXE1MUFYSUttUWxtdm5LczJwOEdUTGRGNkkw?=
 =?utf-8?B?ZzhSRWRqcTVOMjVDaW5Gc3BwSXVUM3Y1ZDUydU55RzRnOHprWEVqdjhlT002?=
 =?utf-8?B?eFMySHNzb21nSzJKektPTHRyUzlydXh4Zk1WVk9OVmJ5djFtNU1nZitRUyta?=
 =?utf-8?B?T2tIaTdrdlB3ZjNoRUYyZHVPSUFQUS9PYzBpTWY1dEgyV1hZN2lVUnBiVVNv?=
 =?utf-8?B?U3h6MU00WXFwcUM2VG96eklhSkRwT3Q1RlA0cVEwSE42bmgxYTF4cTd6MGE2?=
 =?utf-8?B?a3YwK0lsSzBIRjczS1BNbURHclJLQmFvR1IzQzRkamdJOEQyMHZHOXVUeVJa?=
 =?utf-8?B?a2R5ZmhYc202bWRBc1pNTmJkQU1JNXlacHBrLzdVbi9iY0dUU2YxL2ZtTnVi?=
 =?utf-8?B?TkNPMXZuQitIMXFUTVZkUFlaQjg3VFdOU0lWWERFbDFPQ2lhTHVVRThMVjVi?=
 =?utf-8?B?UmxXMkoxemlFZ1JPRjE1M0JFTURVKzUyYVhOOGFrZXdsVFovNzBrNnU0dkhX?=
 =?utf-8?B?T2ViYTQvMm9iT3g4dWRYbW11U1dFOTI4alp0S3Rjc0o1WFZXREdqS25GL0tC?=
 =?utf-8?B?bTJBODZPVTNQdUNzcVZ1T0tvVkxmY25GcTRkc3NLVWJlRkhmZmtrTFlkOElJ?=
 =?utf-8?B?WnBGNTlTckx3UE1YTXVTaHBOOVBXb1lFd2c2MmV2ZG4xeTdZMDE0VVZmTUNo?=
 =?utf-8?B?TUpaU3d3ZjJuUmZCNnFyd1lqb0dOcXd1MlY1amVvOUJ6U2VxaTIxUGQvWE5F?=
 =?utf-8?B?Qks1N2VzeTN5dzhic0JoU2JwZGpOR0JhK3hqNTNKbXg1c3dyVTdSK1BFUVNB?=
 =?utf-8?B?RzdWUnB3RmxvdWl1Nk5EV1NHTzNFbHFSTFNJRFQ4VHpTM0h1YjF5a2RzejZP?=
 =?utf-8?B?OTh1KzFxWnFRWjlIK1BhODlxRnBrRkgzT1RPVlVORTlvb25Ya0NLU1JJU3FT?=
 =?utf-8?B?S3lBTFpaT1NZV3h3VUMyd3M3c09UaHZlRkdtVWlhTUNWWmtKa0dvU0VTOEhr?=
 =?utf-8?B?OFgwWURwcVAzK2YzL3hxbHcxTTdOVGZjOGVBWVRnb3l4QVdCMGxadVYzZnBW?=
 =?utf-8?B?YmFHNERzenFDUExaR3cwbDZLaDlFdDlid0xVNE5uVmc0aWhwSEJDd3F4V01a?=
 =?utf-8?B?RUFyeFlnS1JTNXFld2NadnpMdnZmY0JHa1ZDY0JZa1hmemh2aUt2d1JuYWlo?=
 =?utf-8?B?a1NVTXVCNDFJaGVPOU5uNDV6OCtPa3V4cG5lbEg1b3Q2eURBcG1BYThkYzZC?=
 =?utf-8?B?dGpJQktXZmc1RGFPTEppSDZxUDlJQVl5Z3RmeURzRWJEZVphdURCd1NuZXhu?=
 =?utf-8?B?YmZqa1ZxN0c1bEpXMDIxWjlqVWFQRzZHUndQQWNoZVdFbGN5cm5uMElEMnBX?=
 =?utf-8?B?N0grL0Jod3pJMDBFbDRzKzR5VzlsTkg3a25BV3JPUEs3dGs4cEJtL1ZuNWk2?=
 =?utf-8?B?THpDc1liZzZFWng3UGw4aFp1SjNpeW9nQXZVNnNFSGlxWUxpKzJqMzR0Sm5i?=
 =?utf-8?B?WnVkS1c3SGh3UE1kVjNMamFVRkVUMFg1Y3AwTWF6N041eWJEd3plTkRHQWl0?=
 =?utf-8?B?UktvdmZ4YVNFdVYxQmVRNVQ3UTVGbmhqSjMrRjZGK1M0aXdiS0oweGpxcHls?=
 =?utf-8?B?ZFp5Znlobjl2VTVKdVZxdFZVMktUdXlGbk1Wa1VkOHhwdXVUMytvZHQ2L2VQ?=
 =?utf-8?B?R2ZpUTBQYitMZkVXWnQ2TDJsRnI2ZlhIcDJEQ2hkWWNqaDd2WlFCZXdVdTRN?=
 =?utf-8?B?cTRGM2VjOWFlbyt6d0Nzc2l5MTY5NnBaVUIxVFU3cDJ5OG9GcmVjNHM2WEFF?=
 =?utf-8?B?bVlXMUg0dmR5RnA2amIvR3FBSWg0cGtQb0ZDQXhFS3J1T1NReDN1bUNHa1Y3?=
 =?utf-8?B?WDg4Q05OUC9ZWEltTE1iKy9uUm8yWFF1ZnNpVDVRTXZ3SDV1ODE1bTQ2a3lN?=
 =?utf-8?B?ZUd2NWNIYUFyVzFiblpOaG8xVDdkVlVWRDVEMURSdnBWSElCWlduMUVuTjVh?=
 =?utf-8?Q?VqyRX2aqtxiIQ3OvzzaCdTU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW1ROFJoc0RlYkttZ01nTTVSNjdyd0FONHVGclRpcGdUWmlzbFcvaEFKY25U?=
 =?utf-8?B?SFQ3MXprOE1BVkxIMWxZd01BRUJzcjRoMk9OR3RySHlBeVNteHZnaTVmVUh5?=
 =?utf-8?B?WTJIVWlkZXNtWE4rOFVtWjJ3c3NLd1pHL1ByemhzZnFmbGxNbWJnUE5JUlky?=
 =?utf-8?B?d1Q1YlZlV29qNGJTRHEyaUEyaFo3TWhndXFPSTlhODJacyszdCtoSld1Qldp?=
 =?utf-8?B?Z3RaWlNtZTUyelhLZDNHL0xpQmxXQlBpSVhPZVhmMTBnbTlWSkVWMXUyN0M1?=
 =?utf-8?B?cExiSWQzbVlOTkJLUGUrOUhYcmNBV3dIN25ETUNaaTl4TCtzVlg2MHlXOXlF?=
 =?utf-8?B?WkgwY1NiZzl6QkFER3NKS1hyU2c3cFU5L3Z6bXRmRTZxUWNZTnI3aGYwQzVO?=
 =?utf-8?B?Tmd6dldGU2hEaWIwWm0wL3RFOTJoQTJpc2FWQVovaGp5MzZsUFpteGNxNWFl?=
 =?utf-8?B?Mjc4cktsTHBWeElsNjVBeTltZzR2YzdVY3VLTTg5emN5akY1R0ZZZHF4N2tt?=
 =?utf-8?B?cFYvMGdRVnpNZm9LMys2cTl6M2JOZUFBMkkyRjhwTnhLekYwNWljTTcrUktG?=
 =?utf-8?B?dFlGQ0dtMWUzYW50dTZvMXdRcTNOR1lEQmVvcEFwdlRNRWxVWVg5QVlhbnlt?=
 =?utf-8?B?U1hwQVRieWVJc0JEbEZNejJvYk9jUGU3ejZDcmpOc0N6Y0hRMkJhWmpoYzNo?=
 =?utf-8?B?VDZoTDZSODZ2bVRLL21NY29KK2JmLzMyRUZ0QmFabkVFMk5CMGVGaHRZTFlp?=
 =?utf-8?B?MnBzWVJzTEdTL3p3SU9BcG1RUWdIVi84U1BidThiOGYydHdwQ1RpY0xOa04y?=
 =?utf-8?B?ZUxySG1NRDVyMUQzVkR5MzlPTlVxbzJlSTZ5Z25oQXkvYWN0U0EvZ3djRkwv?=
 =?utf-8?B?ZzU1WFVPeXRXMWFTeGd4cjkvTEdaa3YwV0ttbmdRR1o5M2c3T0FGSE5nSFdM?=
 =?utf-8?B?M2UzdTc2RnhBNTI5Z0dvbXpjc2RoVDdBVjZuZkRFbkxxR2VRM0ZDN21qelVw?=
 =?utf-8?B?Z1hBSFdJVzJWU2FVVU9teTlXRThHbDhnUUtjdWdkenpSWlR5dUVoVDROamRx?=
 =?utf-8?B?bUlnM2xqTXVPRWVINDdkN2gxQW5obUhVR3JCVWY3dk00TWI2MDNIL3NlZWxr?=
 =?utf-8?B?cHZNdGxkU3RhZmYvRW4zWnphNFk2VkFMQW9OOEp2aExpcFB2alYvUU4yQWV4?=
 =?utf-8?B?bXF2YmdxcHBXNGV1NnNPVEFLb2l1NEZyVk1nUmJKdSttK3JsRjRmZ2IwOWF2?=
 =?utf-8?B?dnhINDR1MTZudWF1dnIxWFZncnpZS0N1NG9KU3JyUkZ0S3pLdDhHRmh4S1pI?=
 =?utf-8?B?VFNTb0dzUGtYY3ZUN3VCYWI1azNLRVU3aHNGTU41TXRJQ1FodVcwTlFMN2Yv?=
 =?utf-8?B?VmFwazZwUnZsSERoK0EwNzUyRFZBYU0yWjdnZ2pkWkFFNGhYWFBFNmpScVpB?=
 =?utf-8?B?VlBXSVFybXA2YUd6Ykl0cFhwNTg0YWRjRk1hZ0xnTWpzcnovOHIzR0JwWGNx?=
 =?utf-8?B?ZzZuQ3pJNCtHMHhvVDRLUTVzVDVkMnZaeFhlUUNVMEF5TFJBWUw2WHQ4SjF3?=
 =?utf-8?B?aDJaZ2RuODhRd0V3RmdUUitrVHpZSDY1ZytjckQ2aFJiQUhzN3dQOW9WeGQy?=
 =?utf-8?B?OEdUMzZ4aGUxQmQ1bjh4TUZlYVY2ZDhjQnpobjRlM0c2eHpGVllyWmcyVGxr?=
 =?utf-8?B?WGJmaVA1ZTZJN2JsTHFIWUNwT09vdDdUeHZqeDBNc3N0YVErdVZ4VVBaTHBC?=
 =?utf-8?B?bjUzaFJVS09XR0pMayt2dFY2cFU5QUlKZHFJQWh1WXZSNGtSZEpQNGJtNmtX?=
 =?utf-8?B?Z2IzSXhJZENiUnZ0bytVcnRuYmluRE5FeForNmNEQVdaSEFNSjZsakg0aE51?=
 =?utf-8?B?a1h4ZXpxaFp0dDhRNndzYmVTKzYxMTVwWTNQcVFuRUNhSlVNOHdtZS85M1E3?=
 =?utf-8?B?eU9vc1VHaklzRVZ0UU4rZ05ZeDVpYzBiMWdsT29iWTVLazRmU3VYcjRWM3FU?=
 =?utf-8?B?c2NSaWVLNFhhckR2ZjlGaXA1WjBDTUNoTGJCdWk0WFYvOWdNTzJGZkdHUklw?=
 =?utf-8?B?dmhjNWg1MFU3dkdhajYyKzhGVGlkZmp5cUlLUndVUFdIN1EwU0F1Ky9lN3FI?=
 =?utf-8?B?THFiTllIR3JRTHp6blh3ZUZGaWZjaGpISUk5WUVjaVRJdkttTG01TEVIWjFz?=
 =?utf-8?B?akZwNjBCeVlEblJ1NHdlSlRCa20vSXltK3FUQWtTQXI1ZGhIbGNxdTZRVmR0?=
 =?utf-8?B?WkFHWFdkQkU5TWxNVkNZeTBjTit0OEF6VVlTQVpSQVkyMkZpN09xOWkxV2ZT?=
 =?utf-8?B?ZE1KK2VxaVNkcm8yUXBUNUpzY3QrTXBZcFFJMlhUL05CMUZEVERHc3gveldU?=
 =?utf-8?Q?bYHzOF2UQWJhtu12goTcUfZYlBhO4jkdtM2YG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C42EA0E3D487DD459CBB8EFE2813E630@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894e1153-83f2-48a6-ebbd-08de5abfe3e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 20:42:14.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f787bRrkp+buCI40FzLvtmfLB4f+O5fEgxpPEpkSWXSZQjZy5EGUV8Y0G6F/Z1hc5niR4GhlCnOlnm3Wnx75Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR15MB5462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE1NiBTYWx0ZWRfXwA+YjlSEVvl7
 8KBz5c63iov9XqsvL71mbEIg6/7Wla+YBvPHIjXwFjW/6KiUaEnCM/Gto8EjNZDJk/LXx/6TlGA
 crhXkJLjU1Rm4N8uCteyGIG7MTM6zx11R5Q014QNgIVzZm7gOuTca+9Znx3tfC8q8X5UMd5YQqG
 2PurpqPr/5TsyV1NvampiQGY+9oV2Ps1aUDt6ka4L5w8wVYmz0RjxbukdkzDHxKLZxqRvuMfoeb
 bPXiwuVJwkGgcWwdEIdA2YA4Gnie7MlLIkr8hv9j16RpMtSa3sez30b4caEPqRHrEOkp6rnZqCh
 flaclIrjU6/h9g29+zpv0lUz8ygFZ0ssvtwbKXCdqhbGu0BgYH04GsQMb7xJy5R3ASs55Gl0YDQ
 TEyIEBLm2m5kHnSo4QnNq1iRmeyY6Qk/USuXfOWgjItWv9thrXAjasm/5SJjQtOH7rV0EOICjz1
 7Jh+yGHzAUTuNL97vfA==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=6973dd29 cx=c_pps
 a=TdY+Vr9RQ+qa4geS/iuwdA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l9IqJEQH8NzX9FWBOwQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mH0t_evVZVHm5slalXnu_4_BS6saoA3m
X-Proofpoint-GUID: mH0t_evVZVHm5slalXnu_4_BS6saoA3m
Subject: RE: [Lsf-pc] [LSF/MM/BPF TOPIC] Data placement policy for FDP SSD in
 Ceph and other distributed file systems
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75313-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C8C4F7ABE9
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTIzIGF0IDIwOjM3ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToN
Cj4gT24gRnJpLCBKYW4gMjMsIDIwMjYgYXQgMDg6MTM6NDlQTSArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHZpYSBMc2YtcGMgd3JvdGU6DQo+ID4gSSB0aGluayB3ZSBuZWVkIHRvIGVsYWJvcmF0
ZSBtdWNoIGJldHRlciBhcHByb2FjaCBmb3IgRkRQIFNTRHMgaW4gdGhlIGNhc2Ugb2YNCj4gPiBk
aXN0cmlidXRlZCBmaWxlIHN5c3RlbXMuIEkgYmVsaWV2ZSB0aGF0IGl0IG5lZWRzIHRvIGV4ZWN1
dGUgYWNjdXJhdGUNCj4gPiBiZW5jaG1hcmtpbmcgb2YgYWJvdmUgbWVudGlvbmVkIHVzZS1jYXNl
cyB3aXRoIGFuYWx5c2lzIG9mIHBlY3VsaWFyaXRpZXMgb2YNCj4gPiBkaXN0cmlidXRlZCBmaWxl
IHN5c3RlbXMgY2FzZS4gRmluYWxseSwgd2Ugd2lsbCBiZSBhYmxlIHRvIGFuYWx5emUgdGhlc2Ug
cmVzdWx0cw0KPiA+IGFuZCB0byBlbGFib3JhdGUgYSB2aXNpb24gb2YgcHJvcGVyIHNvbHV0aW9u
IGZvciBkaXN0cmlidXRlZCBmaWxlIHN5c3RlbSBjYXNlDQo+ID4gKGxpa2UgQ2VwaCwgZm9yIGV4
YW1wbGUpLg0KPiA+IA0KPiA+IFNvLCBJIHN1Z2dlc3QgdG8gbWVldCBhdCBMU0YvTU0vQlBGIGFu
ZCB0byBkaXNjdXNzIHRoZSBiZW5jaG1hcmtpbmcgcmVzdWx0cyBhbmQNCj4gPiBwb3RlbnRpYWwg
dmlzaW9uIG9mIHRoZSBzb2x1dGlvbi4NCj4gDQo+IElzIHRoaXMgcHJvcG9zYWwgZm9yIGFuIEkv
TyB0cmFjayBkaXNjdXNzaW9uLCBhbiBGUyB0cmFjayBkaXNjdXNzaW9uIG9yDQo+IGJvdGg/ICAo
SSBzZWUgbm90aGluZyBpbiB0aGlzIHByb3Bvc2FsIHRoYXQgd291bGQgc3VnZ2VzdCB0aGF0IE1N
IG9yIEJQRg0KPiBwZW9wbGUgc2hvdWxkIGJlIGludm9sdmVkKS4NCg0KSSB0aGluayB3ZSBjb3Vs
ZCBjb25zaWRlciB0aGlzIHByb3Bvc2FsIHN1aXRhYmxlIGJvdGggZm9yIEkvTyB0cmFjayBhbmQg
RlMgdHJhY2sNCmRpc2N1c3Npb24uIEJlY2F1c2UsIGl0IGlzIHJlbGF0ZWQgYXMgZmlsZSBzeXN0
ZW0gYXMgSS9PwqBwcm9ibGVtYXRpY3MsIGZyb20gbXkNCnBvaW50IG9mIHZpZXcuDQoNClRoYW5r
cywNClNsYXZhLg0K

