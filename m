Return-Path: <linux-fsdevel+bounces-74919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKj8LaU4cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:35:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA625D5A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2CB2A5FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087623E8C69;
	Wed, 21 Jan 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GnOeR22P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C03E8C5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026476; cv=fail; b=TaYk71Ep4l88/uifDUfmjPMY+YaEX6L6qi2pMr77fa6jRRm4oabrgGiu9uVDMWrjk465NjjLAGGJ7fwwny1QsL6bud3Zuxrxtkdo3WLjcibiAlu+5c0u+2X5itAQyDAQzX8aNB0s7eKgCwBVX8ZGOqroW8G680qF8+r4+mhP4Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026476; c=relaxed/simple;
	bh=8Ogxe30jVNkS1Ad1cTSNneaXY7icDJJdto4yIsvzcC8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=M+1kjBIIDJnhp46NhgkFuBYfDgscDXLVr0M95atrD3YzervJIDVSfj3wxRDqYDRHFqqJrJsWCpsvs69Y5j0KDAK3w4NvqYcdwNiN2CaGgOy4laUj3W1msDbts1JcE/3KOGlN6LDx5jAANqjDcexqAt9T+CeC2XBpyvdL4EXH4d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GnOeR22P; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LCJE1n021317
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UWPMijWvDufvRkd21PxFfcbUJTMMWdLKyla/7Jqz6Tk=; b=GnOeR22P
	YefXpfb2TTGyChW38/EHCSqnYyrzjxaHihlxhoUgPR3ZzNzYMCMqCGvLg+homlYt
	oRAVPE6+Ilt7cnjyMbDhAleOaCPdxur87TCI8qUeqfG+i0fXhHx0cce+Bg6vG60U
	TF8Rzqb1VQibeabn0pMgAqz2PrgkwiNBMN1crBP4xWpRBXKEQz9YmrtjyI6O5dpY
	tK2ZWnTryetnGMlJU7Loa5yErfia38doKbbGErQdlzdNjZsKHX95nsf/oTIHuMxm
	ddFOV+zGoNi0deNsBZdIbq+fp+Fykh3A9AUUbNi+0D7LLxCL0q/lThHcNL3DeC2I
	nlGyzRSbpLCGrw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6129c4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:14:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LK8CSb016774
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 20:14:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6129c45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:14:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LKAQ7M020607;
	Wed, 21 Jan 2026 20:14:31 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt6129c43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:14:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIQTLtaJWAyhPDaoh4TzD9m1qpXjwMMgTqAWTl7eSIYHtcFDSN7FlLQeCFR8bsz6EtEkicgLlG7cnPmNPA+Ms/RURmvsrtiNvZKRho2wZ3A5UHkGEgHvPpaRGKGPD5m3iE830G/dyJr6aCdDBLfa/B9exiHvNUL1ARA+oXFaP1qFvXuOv7cT8x01J1JF9WMbyMi7cre6S9i03bpGKWaojSR08LBTh1CA/3PsC2uH+0TYBBzAFTiv7aeKBH4iOnHua3nVkkYXFXtzvJOJ28S/s0M1DznNTFlpoZ59/y6gSJMkUp/HhGnYCMailqP6I2oiHzVW0xK84S2lqqxblmSxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK/yYhg5nECshT+S72uStMtyQa9xNDdBWCTTxwSvtEM=;
 b=tTncAho5aq1V7Pf7gUxuEj3Xev4U99KEQjNh69LeHBT63M9nDiTDFJaIwxeNrAfgPVyoM/okVremerT808XSH6M9MMxOc7GkPEhmDrT9EIWVq5ZXfvGCw/ACjglSsAl/SPPTWkRdJwmSzPp367DhmekK8Fjd1vOcR2souaVc69Us/aAkr5T5CVlMN6V/62HjyWNrESPwLhOOFM8D4zIAa3KHIv9PbA5ai3N9s2h7GK4tLuHZVEnB6fXYu9mk/pOvuqtLrp2TkTpkwTG/01O1nnZWd5qtbmrxfiRXJ7mRU93iOsbdGsg6ND2PoaYD2Aw/m3CqGdWc4qnY41VFFsQung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV3PR15MB6585.namprd15.prod.outlook.com (2603:10b6:408:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:14:27 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Wed, 21 Jan 2026
 20:14:27 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index: AQHcip+XFWvxH66pQUOmqR70xccoEbVdD9UA
Date: Wed, 21 Jan 2026 20:14:27 +0000
Message-ID: <5b3c275b93ba5df4bdb42dc2a5342ebe63782337.camel@ibm.com>
References: <20260121063109.1830263-1-kartikey406@gmail.com>
In-Reply-To: <20260121063109.1830263-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV3PR15MB6585:EE_
x-ms-office365-filtering-correlation-id: 55970d4d-fbaa-41a9-1459-08de5929ad83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1cvRi8vMk5JTVdPNE5qdUUwaGhiME9LZUdNd043Umo5Y21xNWVtTDM3WnRz?=
 =?utf-8?B?QkhIa0VwN095MklsOFBRR1lCeDZOVFZ4RC8zWmN1TFRTVVJSV1MxYkZOcU9H?=
 =?utf-8?B?dUx4dWw2TzgwNDdvQUhPZXYwa0M5cTM2bzNlbHBxVmVNRUxwbVRpZzBtSndt?=
 =?utf-8?B?ZTR2bURtdmY5bmhoeVpmci93V3kvd0lsWWZSRWJTYVh0aXRGVHFvZ0w1L3E1?=
 =?utf-8?B?aE1FYi9MMWlCc3BUTlRtQ0xQcHVMV2N4M1ZSdUVIL0w2dHpqOWNlbUxpK1Yz?=
 =?utf-8?B?Qk55cnBsNjZwejV5ZTlQMXZHNW9TckVFclNOcTVDcmwwL1h2WkRHQlBNWk50?=
 =?utf-8?B?aU1oVUJabHRXU1BxbXppSFg5akwvSjNVSXgrcXZlTlZVZEliMEs4WHRKZGZJ?=
 =?utf-8?B?Z0hseHdVamlGQW5ySGNxTDUvQjYrYUptYmhnZW9HNFhOVkoyZG9VMURwVG5C?=
 =?utf-8?B?NmxtZ0JrdnpqdmUvVHozWk5KdFBHSUV2eVpXbGRmNHlPMGNMQk1rZzdGZzhN?=
 =?utf-8?B?RndqWXUrY2wxV29KdWdJT2FrYmIrRk1TUGNjUW9nemNuN1QyYkROemNRRHBQ?=
 =?utf-8?B?S1Q1Tmh2N1dNZzErYlJSUVlJb2hTNTRwbTdCMzYxN2tZYzllYmJlaTNrWm1r?=
 =?utf-8?B?R2JBSytpT2pEckdhcTk3WUdZVVpmai8vLytaUTFGemlqSTQ4Yy9jRmxMUFFO?=
 =?utf-8?B?QTVCaEVBcnljR1pUdTF5M3A0WitKbDlpdVZsSE1mdGZ1Uk5IUVNhVEJBWkln?=
 =?utf-8?B?SUpNNHpjWGhlS0p1OC9LaEdNR2lBa3djSWpLQmFPbm0zQVovclBhZEx6Yi9x?=
 =?utf-8?B?VkEyTDUrOTlQVC92RENtb3VNa3Q4TTh0R0VNY0IyK3htdTBlcTF6RURuTU03?=
 =?utf-8?B?d1ozcjZhMElzSWhtUFd3NUptVjUwWkw1RHRSM0Y3NTE2b2RhQ0VFNmt2RHl0?=
 =?utf-8?B?Umw5K2hKZXYxT0RTRG1iOC9HdXEzZlBjd3ZMYjJhNVRRaUI5cHk1RytlNHFQ?=
 =?utf-8?B?cFE5NXg1VVFZUUVnRS84VDNIUDdvWk1BQVkvbTJrTlBqY3VKWjloODhMUG1u?=
 =?utf-8?B?NGxWQ05vdkN3RzA0YkcwbzJkQUo4WTk1cXlvc2ZqdXMvRmozVlVWWGdzVFkr?=
 =?utf-8?B?U2I3bHVNL255V0lJbEw5WlRpeDc1cUJycGhEMXJWTmxXUDRpZXgxTFd6ME1H?=
 =?utf-8?B?WFM4ZE9WdUNrK3pZd0JKRC8rQ3BJQnMvTXZsOHNjbUdncDF5eHBLMlBUMUt0?=
 =?utf-8?B?eEc3dmg1dnRJZ0JBeUpJYzFkRHpobjBybEoyYzdJK1pOWGpnYjRyS3ExRkU1?=
 =?utf-8?B?Y3dyZGlOR092Mi8vTmZOQW5OUkNqbndFTjJ6eWtRb2M4V0J3NmVIaUxqL2Mr?=
 =?utf-8?B?ekRFZ1RnOGcrMG1Zait0NWJvVnFKeThqYUUzemkxdGRUREJHTnFjaTd2ckVv?=
 =?utf-8?B?cWlveFo3cDl5b29sWVFpenMraDFsRlRVZDFYUDBML1k3U2VleVRtMEoxd3VN?=
 =?utf-8?B?YlpLdE11R2t6cFl2MXdBMlJyaG12TWpZY0d0KzNjV3ZYNGNFV3kyb3ZQaDc3?=
 =?utf-8?B?NFRkNllHd0tvdjVFZG50bVMxd0U1a0krWHd1SkRGWDFGVWFXaS9vWFdObTNX?=
 =?utf-8?B?blM3OWJ0cFFYcDhkbDR1VkM1OXIyc1dINWJLY0htQ3RZRmRaMlIzVUVsakI0?=
 =?utf-8?B?ODIyMndHanUrbUt2VmRHTmcyWlJnbDBGQXZDN2pGRWEybWFYdnl2dit5TGt3?=
 =?utf-8?B?cCtuaXpUN05tL0hEN29zakwxR0dWSDgzZFZVMzhlZ2xqM3ZQV0NnNmptYmIr?=
 =?utf-8?B?YVlQTW5ZNVdnZTBCL2Z1YjV6L21vMWxIZzBhMlZKcU5vTWhSR1RLZjZ3M2Za?=
 =?utf-8?B?bktERWQ2SE15UExmWFVCN0JqUXV5UHVlL1luNXg4Q1ZzNVpFWVo2RTlCYjZv?=
 =?utf-8?B?QnJWZ3dudjRiNXh0c0lXdGhKMzFGc3gzeW80ZDRLY1hKOGJDWVU0ZE56SUdO?=
 =?utf-8?B?aUNqeWZTYkFwTVhqQkdDajJXVHRyVG5yREFUa2grQWJ6cnRlUnBDV0MvV2lH?=
 =?utf-8?B?K3NQZEptWHplSlphUTM2azU3RldyQlp0bEh3MjVqQTI3VzErUk9mZXl2TGVr?=
 =?utf-8?Q?WIewrIB3SaPhYazEENk3h2ODe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c203S25oTWhWQXdGazNXOEdzVG0wOTlFWExFbEd5NDc1NTlIUENjSWFMNnRV?=
 =?utf-8?B?YUgvTXYzeXJLUUdkTklZeGJTZENzWmxQaklIWHRsNzRvNnRYWUs2RGlCckIw?=
 =?utf-8?B?WW1GeVBOZ3hSTmZKTFVsd01ubUVoRWE2d0kvUUt6Q2FyZEQyN01OZ1htaUxo?=
 =?utf-8?B?RFRZZzB4eHc5UzR6RXM5TS8rR2lSZ3AzZVZUMjJ5SVNXdDdPWVNSdE5Tb0NC?=
 =?utf-8?B?SkFya3pPaFVHOEpqRUhCQlhLWDBZRzN6TnFJc2pBVzdJUVlnUlBURHowYWdS?=
 =?utf-8?B?NDRuaXlaOFc5RGNrTFR6b0ExaHJiUlhMRkpQbWlBV3ErWkM0QkF0ejJPOUxZ?=
 =?utf-8?B?Vlo0bmcyVTR6bmFZN2REMmtpMVh5TkJ6OVk0L3dIZnY0Q1JsNW4xMGlPZ0JR?=
 =?utf-8?B?QnlZK2piM0tuWG1JVjF3bGp6dzRWTnFDM0VNeVdYc3VXbHBNQUNBUU5PZ2tL?=
 =?utf-8?B?VzFJWGJjSmVpSnVEZWg0dE9JYVNEdXhGVkF5dXQ4SkFpUThURC9CTWVMZ0l3?=
 =?utf-8?B?UmZpUXN2TWRRZFl0OWpBa0NKbzhHYXdRV0FLYnJUQk1zWlEwSWdJSDYwTFNp?=
 =?utf-8?B?Zk56OXJlNC9UdFZodkRKdUV2T1RxOTRWc1NBK0dVUDNVdzcwdXQwc0NWZTk1?=
 =?utf-8?B?aGlXUHZRMHZBc1I5ejJmMXQwRDIyWDVPTis2NEVGS1JmdjZyQTZwOGo0bEcr?=
 =?utf-8?B?NmVLVmNzUUU4eVNZRkZGL0pQVlJ4QXlWOW5pWU10eCthd1crQUZ4OUtHVDJq?=
 =?utf-8?B?bnZKUnh1bGhscXRiQ2hqQ0ZRbVdCemRSK2xiRGZrTGRTWXlqSHdsbFhWYU9i?=
 =?utf-8?B?bG5WcVg4blRBdHU5T1pOeUx4cm9hMHN4RDZLRm5rdGRoRUROR0JGNlpxdWt0?=
 =?utf-8?B?cGdvVlBtM2ZhQzhhTk40T3VHeHhwdmpFcDIwbzBPamQxcS92TUZ0OGZSY0xa?=
 =?utf-8?B?RmN2Ym5kN3UxL0xFbER2N3JOQ2tRUW5WYk1aUW1zWm1PUU9zZ004WlZCVS83?=
 =?utf-8?B?WVVsNFhRNHlGa01nYTdydFJBMzhWSnRxSDdXdnVIT3VaSnRqdndTM05HM2lF?=
 =?utf-8?B?clpmcDN5WFF2Q2FtRDErWWt5Z0czdVRnVDJVR1ZTMXhrRUFoc3dNWG5VdzlV?=
 =?utf-8?B?Nmo1YXlvNXo3dHh3T1pOZ0Y3bW5CQnYzd1p4angyV3JveEFUY04yNWFjRzdT?=
 =?utf-8?B?Z0tCYWRhYno4MWNqU25xSDlIOWpYb2cvVFRldFFGYzV5aDlBSEVWYVlKUnQz?=
 =?utf-8?B?T0FDbW9Ya1A5SC9SOGhKbEhEaURzbjZmU0g1aTN6bnR3cEN0WDBEVmhLL0Nz?=
 =?utf-8?B?L1FPNzBacmFhTFN1eXkvMzM3cURWdkRmZDFzUk9YTTIwdE4zTUxuWlI5TzVF?=
 =?utf-8?B?eHM3VTMybmlVL3NPVnl5QWJmcDY4bHg4aGw4RFArZ293MWp4a251VDMyM1VB?=
 =?utf-8?B?OG5pem1OamRVQjNqS2NIandjS1lWaVl0QVA4aERkdVdYS0N1QmlrWFhjN3JX?=
 =?utf-8?B?TUNrU0RJZy9wOG1mWmdkSndxRVc1eFViT2lva2E5aXFyVHhQakJ0Ym5RV3M3?=
 =?utf-8?B?WFVXM2VCZU0vcjFETjdtRUVBKy9JVzN4aUZLWlMzRWRyK2d0VmRqK3ZEWE9Y?=
 =?utf-8?B?LzNybXp4dWlkaVZiNTRMNjRxYk5xMnltY2NhRmlEWVRBQktGNXc4dkxRekdN?=
 =?utf-8?B?MHlWdnA3bWpXYUtYZkpyUEpQUC9mSzdDZHF3RjRrcTFzRzJlNDJFdVp1VnFq?=
 =?utf-8?B?RmJEUS9PR05Vb1JvYTYwb2VvV0c4Z0VISnBDaGRRUHQrTWR6TVp4ckNDKzUr?=
 =?utf-8?B?NzdvbkI2REt3NHdKdEFHbVJyVWJiWTI2amc1QnE3QllwTHkvL0hnM3RkSEdh?=
 =?utf-8?B?NUNzVHVoeCs3SWpldyttQmZqSjMwUjNxcHJka0YxQlhuOW9rc2o0alpWMC9Z?=
 =?utf-8?B?cWxSTFBmVHFmbFc2YnVnTTU0b3Bya1lpeFJuSHUwTjE2cSs4VUFCaklBdnZH?=
 =?utf-8?B?Mlk1NHJvTklyUTZ4REV2UUJseDNTZ2xwdDdFVXRvZ0YrNDhOVFpKWDhGakNM?=
 =?utf-8?B?OVVYK0xPRU5oWjBzbDdtL3pJVWxUbTRvSjFpNGw4c1VKa1dZMjRQWGwvV2U3?=
 =?utf-8?B?a0xtUmkwcjlRMmVIODhJcDhFc0xtNlRLajNVM0QwVm5Hbkk1M1FIOFoyejQv?=
 =?utf-8?B?Y3BPMEhvU2JqNG5jYU05OW9XMVNqTVVYY09OSER2MGpCOGpZaTNVcmdrWURo?=
 =?utf-8?B?RzFvalh0RkZQR1h6Mmo0MjRJSHdYMmNWcUlEU24yeURSNG40bm42YUZCK1dZ?=
 =?utf-8?B?THQ2QW84aTE1M0p5REJiUDRvb0F2L0RjK09VOCtWU3d5THFxcjRSbjVNV1BS?=
 =?utf-8?Q?Hq+up5jJWwllswlMP7+vGNKQ5+I36KHXI1teu?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55970d4d-fbaa-41a9-1459-08de5929ad83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 20:14:27.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g24CUUkbwv4u+aXTMwHkLuzlIvd0N49HxRo8Pp4UsnInid+Rx3ownsRNqmmCny2p3IYc3blzlnmCX0An5vCTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6585
X-Proofpoint-GUID: g0aVu4ya2FMrrehmc1fNsFPO17ilRT0D
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=697133a8 cx=c_pps
 a=zrdfMquBAX+f6GZXohoIpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=wsh3KXQWTHkVHAGvgMEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: SeftltkIILv2PCj0r9oP1npGBZsB-LJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE2NSBTYWx0ZWRfX9dE1O/oh4W3L
 Qjd1l2Qe5TgBL+0sO9gmys3xp7/lHItJ0YWfCX1WLjui2KX112r2DbQ1ttDbYwCxnJMf41JMp23
 F3k3b6IveS9pkd1V1kNy4X3eNYVtyab6dJsDCyyURoRcUmJNu+v+B12vWFQvZSt+TReA7hWXZs/
 gMCRu6BK+HVGQhuUWyeD7qzb2r1aCBW41L2/DOE8MvQrBRz2zvWK3Ckw4YQoaEoUNZSgqJAO9l4
 +2T6U8eRDE8+gxMtF1FGCni+PD/v/kGCtZGEeu9ADPARYKr2KZedy3coHNWpfID2yFwUyye7Q4H
 hP8O6wJXE5XKnGCfaSMvgMdiyZy3H1XUj//HUEtAQ0PQ8FI9+HpwT5a62RZ3fZO2WtzU3Z/4BcV
 Ga8mt7nWEs4utXzJfPBumF8FIbXgSemW6/Yki3PZRf1RbflLHQb27QG2Bxy4zkhfHPia8trFLp2
 sbnZO9Wvv4T6M7YULDw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D5314135075FE43A55F0760969B9781@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH v2] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2601150000 definitions=main-2601210165
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74919-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,vivo.com,dubeyko.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,reject];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,appspotmail.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3CA625D5A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-01-21 at 12:01 +0530, Deepanshu Kartikey wrote:
> Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp() during
> filesystem mount operations. The root cause is that hfsplus_find_cat()
> declares a local hfsplus_cat_entry variable without initialization before
> passing it to hfs_brec_read().
>=20
> When the filesystem image is corrupted or malformed (as syzbot fuzzes),
> hfs_brec_read() may read less data than sizeof(hfsplus_cat_entry). In such
> cases, the tmp.thread.nodeName.unicode array may only be partially filled,
> leaving remaining bytes uninitialized.

I still don't understand this point. Please, see my questions in the thread=
 for
v1 of the patch. Could you please address my questions/worries?

Thanks,
Slava.

>=20
> hfsplus_cat_build_key_uni() then copies from this array based on
> nodeName.length. If the on-disk length field is corrupted or the array
> wasn't fully written by hfs_brec_read(), uninitialized stack data gets
> copied into the search key. When hfsplus_strcasecmp() subsequently reads
> these uninitialized bytes and uses them in case_fold() as an array index
> into hfsplus_case_fold_table, KMSAN detects the use of uninitialized valu=
es.
>=20
> Fix this by initializing tmp to zero, ensuring that even with corrupted
> filesystem images, no uninitialized data is propagated.
>=20
> Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd80abb5b890d39261e72 =20
> Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/all/20260120051114.1281285-1-kartikey406@gm=
ail.com/T/   [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
> - Use structure initialization (=3D {0}) instead of memset() as suggested
>   by Viacheslav Dubeyko
> - Improved commit message to clarify how uninitialized data is used
> ---
>  fs/hfsplus/catalog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 02c1eee4a4b8..56a53d2d437e 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -194,7 +194,7 @@ static int hfsplus_fill_cat_thread(struct super_block=
 *sb,
>  int hfsplus_find_cat(struct super_block *sb, u32 cnid,
>  		     struct hfs_find_data *fd)
>  {
> -	hfsplus_cat_entry tmp;
> +	hfsplus_cat_entry tmp =3D {0};
>  	int err;
>  	u16 type;
> =20

