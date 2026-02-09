Return-Path: <linux-fsdevel+bounces-76763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF4PEsBfimk9JwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 23:29:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84D1150EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 23:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5DA030074DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB20314B8C;
	Mon,  9 Feb 2026 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kv37uM/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7814219E8D;
	Mon,  9 Feb 2026 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676154; cv=fail; b=gqEJcnuPQuvs8SnIVmG9PvKKTYF6LPwHNJdk0Av45stgk4Ia2MF/ZksKIAbZ0XKDhgnHNgVB3wQiQV0JxllcIGvMB/TbUv/aS7GP8FzaXZf7i2Rd+maEhv7bKXkKRHSUhiY1n62Q3Mqq9HcwKI6HKigY++qosyJu2OBWdRMt/+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676154; c=relaxed/simple;
	bh=qNdhpd4jH1lhEa1Mkbzi0k8efySctovQlJKmFDQXvT0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=uT02T9Um77tCrgO+9k8Jxp32BmSrwn7TxAn3J+SI1fARmrzWJxoIqlXHCE0lWYmHsiZSJXTK4b6xpcrCj8KFuDLxs7ToTnOqU7pwlUO2XXkaOwaJDYUK87vuNE9TXsaRZfrR6bDh/VTpjaJSqR3mioXLFrbOWUNl3x77Nb9yMQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kv37uM/Q; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Fga0u451836;
	Mon, 9 Feb 2026 22:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=qNdhpd4jH1lhEa1Mkbzi0k8efySctovQlJKmFDQXvT0=; b=Kv37uM/Q
	anc+pZ03Oq/RwuWfjRKtotFVB96XHNWf2ezzA0IoJWqyeqyx2DY8pf441c9zThYI
	NqBEj9QiL2Khn8KC9dwP/IIgah5k7aOj07Z+M1C6age4fa40d//fyHIzCKnfrchI
	+qm8QUEf76GsRaD1cQeJrnph3/tTQyIp1wjrSrAze80PhHSCw3SU3IEpeYltH+Z5
	UHjkSZqgYd7aZNVaYVXLL8yf5AsWopG6ulG9mreR4aCK0nYRiMN0HgwaJQ0Qw9by
	uXHJUbrcPmVDtXz2KCj1G+6rW99nDGKobQMVibEPul6utSFF31nPz5WOQMeHbiq2
	nMaBgz/njgHuCw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696u9g61-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 22:29:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ3uIvipeOjjYSAAxVqdDok2EDvNdSzpk8Qfc63GY1uUTJ6lBofTm9F/ggBzs8UWPwKbMIjtt2PLOhf++/JBj/lLz49EaeVN5q1n5AUKZNi40etWP8iaNhu4jCCvycXL1FkP/ixB1nKMOD8Cz0aV7C82Ao43OqLvoWJf6Bt7vPQEVad2yAT2v2Wl46viQJ4ScBEam0M8t8PvsfRuVFWWrW+fUfxpV/9i8awXUuoWz8tATN9SCM7LENr2sOsGUtcITuisNTjV7tCU7LNRl+pwaRq9soC2x4RyLSCC7pwHsV6zeWHrUXDsOS/agJeB6Q4/o4B7xmd62J/OJAB5PSYlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNdhpd4jH1lhEa1Mkbzi0k8efySctovQlJKmFDQXvT0=;
 b=QMil6tBvW3mGQVoTjnKPF6YF7XZvQUY6ayLOt/33nrSy+aZKr6LiYMxKDyLMxwl1KwD1xuPogGR2dtefvSS3fQ/y93lsW+qlEfMZsoFQaiSST0HBz+8cgfnoL/LkAUSWll5ZnmwiwgS9wvl91CdYF8DM6lPfaSmKPArWHnc5pjnUvOZAmJEl5ZLD6YIkZFmUGtXxAt7R93H6UruBjpN8QpPqNNpHMVvJHeH2ZtccFiEwVZCYZKUF53Y0V20roQ+w5O1aZikU3i/Td5mQ3pvVSh+UxkJznJvdSCki9Os5VfatvfueVswvBjP5Uulde6ND3cwBOJx1c6muBZRdYhJjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPF33AC5CB8F.namprd15.prod.outlook.com (2603:10b6:518:1::493) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 22:28:59 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 22:28:59 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "chrisl@kernel.org" <chrisl@kernel.org>
CC: "clm@meta.com" <clm@meta.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [LSF/MM/BPF TOPIC] Machine Learning (ML) library
 in Linux kernel
Thread-Index: AQHcl6AqIZ7MB3V3T0Kp7gdR9aR7gLV6J2AAgADQVYA=
Date: Mon, 9 Feb 2026 22:28:59 +0000
Message-ID: <a994bdedca7d966168076044249a58e52754c6ac.camel@ibm.com>
References: <47d21a6821c4b2d085f7b97bcdaa205bfcb0e0ad.camel@ibm.com>
	 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
In-Reply-To:
 <CACePvbVH0ovOcBqCN7kJ3n0QFmvuf+_5tMeRXs-JAQ+m5fdoCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPF33AC5CB8F:EE_
x-ms-office365-filtering-correlation-id: be2f575c-dbd1-4084-c99b-08de682a9eba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzJrS0xYcU4ybGZXVWl6QlhJQklpUTViZWJSQXZTWWhSZHZnVHlhaVFLNWZ2?=
 =?utf-8?B?T3RHa1htZHdxamVWcVA3a1o3SXU5MzBZUkdvTkM5RjliUXpIdEdKU0V6dUFr?=
 =?utf-8?B?Sm1teWdYL0NVN01hc25pc1V2eExaMDRNVHpwUnI0dlpzTmQwZ201dFZTbXlB?=
 =?utf-8?B?QWg5Y1draW5Nczg0cEhJNlVMZE9vOVp3QmI5YVZaVGQzMjlJSXBkN0ZrMiti?=
 =?utf-8?B?bGgxNlFFUGpvUHdaY1cwKzZTMndaOTJvSW9QMlp3a1hRc2xJdjVGNlRkbndl?=
 =?utf-8?B?bFZod01vSk9EOGJYVnRqYU54ZGp5R3lxQ05DV3FDd3k0YklHdXRmdExJUGFV?=
 =?utf-8?B?MGlYSlhYWmQ3dkdtUElYUGFCR3d4R09ZSkdGQ2xZbkFxa3dSYWpWSlNuNkNX?=
 =?utf-8?B?QWhXYWFacHVJZnNVTHN2OVh5KzNoZkF1aC9oVkxTZzFkVWZrN1NwYzJQVkdS?=
 =?utf-8?B?SzEva2dLYnc2ZDZNYVhRS3MwVWRybDVGdFcwOWhSaWttN0dmc0J0RCtsb1Y1?=
 =?utf-8?B?aVRTZ1FZaUpuUHdEQzAxUkZUM1RMTm0zT25WSzFiVHJJNGhVdWpVSzArdTJa?=
 =?utf-8?B?QWE0cEZGWXdtcmdmQS95dTlTRFlDdzZjaXU1ZExNbHFBdW5sMytWanVDWXNp?=
 =?utf-8?B?YVpFRnRtdmdWeUdJMjRnR2hZSFB1TFVOUHFMMklDSTk4YVBnYzB3K3liSlZq?=
 =?utf-8?B?Ym5YNWZoQXhiUFBtMEdIK2c5ellMaXh0eUVEYjRlcVlYYWxETVRrWHZqeGRQ?=
 =?utf-8?B?UUlDWWZCZEVycnF4ZjlFejgvcWlGU09IMVdZQzZkMWNRMkpxQkdjWVVSQ2F4?=
 =?utf-8?B?WXEzZEM4R3YrUkhOVEZJdUQ5OUl4bnhUdElITDBzeG5GOXp6NzFJeUR0alBX?=
 =?utf-8?B?NHBPRTJVbmE2TFVTVXRPRzlWRS9DOXlraFBNV3FGUCsxYVoyZk9CZHFXWENF?=
 =?utf-8?B?M2k4dVBmdHBRY2VmNklSemZRSXBCL3lqUVZOcGV4Z1g0cE1sbVQ2REFkV09r?=
 =?utf-8?B?czhMM0J0dVVESlhEZW5wMTZsVmlmRGt3ODVXR0R1aFVjbXNSZnN2Q1Znd1ds?=
 =?utf-8?B?Um44ZGw3VXVqRTB3TFpldUxVTzc5ZHhnT1dLcjVkYVJxL2lYWW0ydk51aUo5?=
 =?utf-8?B?c0FicjZNS1FnQTBSaWdBb3NhOGtNQzM5clFSd1FnM0k5TTdacDVYNFNaNThw?=
 =?utf-8?B?UG8xZGpYUDhCUWltY0wyWGg5Ylg4ajB4MENmdDJlQU1MZmMwUFBaS254Skx1?=
 =?utf-8?B?Ukc2WVNIQnJoWVM0amJiTGd1eXVnRWI0cjQzQ0hNUWtEVjh5WmtTdllkcWtN?=
 =?utf-8?B?cFdManlkNHNpTmc2eElSL25Wb1JFd1ZkTmMzSHQrZFBSSWUwT2pzNnNjUGlX?=
 =?utf-8?B?RzZoTFZKRHJNWjQzdVlETXJUY1I4SWJlTnowNXZhVmI3bWZBdnFwdndWTkpK?=
 =?utf-8?B?VGVZeTFSSXNjYWRqam85SmdPK3ZSZFpsT1RnaTJCaFE0RnZTdGFjeDhpb0x4?=
 =?utf-8?B?cXNwVFZQSjNoYTBOM08xcHJacTEyNE41Q0k3NUFsNVJ6MG4rSHdOdDVoT1I2?=
 =?utf-8?B?aFdzVlg1aXpjNHFZN3dQZURINGZybStURlBtS0NsdUVybDBFRGxNM2xNWUEy?=
 =?utf-8?B?NVpqK0xlV3MzVmJTSUh3Qi8zM3BoT1BTUk9nVmxMaWVRUTRsanAxQTM1aDdj?=
 =?utf-8?B?NEUwdzJ2aHFjYUJ5M3Z1S0V5YjlYSDZNNEh6Mml6WmhlUFl0ODZGcnRnUzZP?=
 =?utf-8?B?RWZLNXFCRVN4d3Q3bVMvUWJvUlkzQWQzS1ZjOVRVeTJRenIvL2hWaWxTdUo0?=
 =?utf-8?B?WlFwWGp2Zjk0ck5CY3ZFZGFrQTV4dHR1U2p1SXpYRHl0VmNUODkxNGhPbUhn?=
 =?utf-8?B?L2xORllNOFFzdlBDT3Y4QVJVckpzSHZ1akliRGZ2dlMrUFlTVkZ5eFdHUDVr?=
 =?utf-8?B?eG1BK2J0RlBpM0FTUkM2OG5obHdPSWYyZEhFU2tPd2xyR0lFT3U1WHlTWGEz?=
 =?utf-8?B?VlV3ZktGeUZ1Z3pWU0c5TFh6c09sOW9DREJHNUkxZnQ5bHdqTXBmWXBhM25a?=
 =?utf-8?B?a3NjVU9sQWlXenFlY084bWlOd0F6a1VGYmR4L3V3ZXNCcUpPbGl2NEZKS1dL?=
 =?utf-8?Q?ocWo+yJXbH6oWw+MzqdXqz4fY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFllaTA1bHNNalozZ0RVZE55TmJ2bnJRWWh6c3lXaGhicFVvbFEwOXI2ak1T?=
 =?utf-8?B?SDZKeDBEOEFla1BPRkx6WWx6TnQvZHM5d1hrVzZnNFBLcGZqOE54UzlHMFds?=
 =?utf-8?B?VTdrS25BTndIdXgvT2tHVGxDR1czRjJJNXRzSEd5WldRTE1UK1VPQUI2a285?=
 =?utf-8?B?bGRVWlR3NEx0eTZhOVRWTHY1Mll4c2RDMityRGlRUzhRMFZWV01zdmdWVXdn?=
 =?utf-8?B?TFBsTzRtaDZVSStKUFFDa21tdmhvbVFLWjBOT01zZG1PUk5kNWNWUCtiM2pm?=
 =?utf-8?B?SWRPc0J1RmtVNXBnT01mWitqNDRKaUxBSjc1STVxVVRodzU5OGIrRXlwUDc4?=
 =?utf-8?B?WjlQd2RvN3loS1VOQXJxUVUyN095dUczSmF6RDhVVkp4TVE1UitXTlpML2xV?=
 =?utf-8?B?c2l5ZnFKUTd5ZTVRTXJldFE1aDZ6NlBjSHhCZVBtWGd6ek16OVFqemtOMjVF?=
 =?utf-8?B?VXNDeldNcjJSaG52eVZHaVUrZmRoWE1wM2pDN29YQVJTUDJ1RzhEeEhMbzh5?=
 =?utf-8?B?RGJEVmg3dk96dDVUUC8wNDk0WFN1YTdQT29hVnJ3anpmemZUK3pHTVNZTUo5?=
 =?utf-8?B?MjJRNm9xUXhMaWhDa3piRzhkdk1Dc3FDNXU3MTNFRURibk5wb2NXSE5vRWpo?=
 =?utf-8?B?QmpXaFh2aC9Zekx0UTQ0emoxYXN0Z2UxRTJWdXp0ZzBUamJPZ285TGt1TEQ2?=
 =?utf-8?B?ZnR0cEIyVnI4a3BIYW1kdVR3MDEvakxuTkY3SHJYMGkzQkJsOWlHZzNOZW00?=
 =?utf-8?B?UWtwZzVXNTFhaTRYQyt5Umg0U1hteUVSR2FGa0VZdk5FcldxNGg4Y29sNHNz?=
 =?utf-8?B?dVcwRmVjOW9RNzVxcXhWcmIrbE9Va2hQeTRUdFN2c0tMekRkM0VGRWdaU3F5?=
 =?utf-8?B?WXREa2xUMUJMTGY4SHM0Rll5WDZ0SnlodTJOd0c5QXpQZ0hlS2FUa2JmbzhK?=
 =?utf-8?B?c1N0QzBueHNFaXJ3eFkwY3VMVnZPckx0RUs0aTdQU2dSVWZmdXlKUzBJbWl0?=
 =?utf-8?B?azJtZ280VDlqOEwxd1hRRGI4bDFMQVpkQkZDMzRXbVhWTVZtWm5lSTQwMURh?=
 =?utf-8?B?anVXcVRXUHg0S29HeHVMcDFNL05TTG1vY2ZqTWVZZGhLWHRSU1Nqc0hwdnVk?=
 =?utf-8?B?QTliTlFneEJkWEdsN3RZRlRUd3Y3YXE5RFBPL2VwVmIwM2RYL0VvSG10ajlP?=
 =?utf-8?B?aVpoOGFWNXY0ZXpwNmt0MlNMaGM5bGduUDNTc0lrRzBHaytxdDdYZlB0MU4w?=
 =?utf-8?B?ZnZDOERkNW0xQmxDUmpUNnl2Y00yQnlET2R1eDhNcnBpZDZVYnhrb0ZrcnN3?=
 =?utf-8?B?elJ3UkMxOWpFWS9BaDFXdWwwME05c25ucnl3WXVvRUdvSTNpU1pLUC8velhQ?=
 =?utf-8?B?dmR4d3dJVU9VN2lDUURZK3R2MGRoUytDc0tpS0NCY1hLR1ErUm1zclVvcXVM?=
 =?utf-8?B?VTBnWmhkNHpIL1p6Z0Q4eUxDanQxYnVtWUxNOTJzMkhDa2hVVnpOcE9XYlFV?=
 =?utf-8?B?UGFRVWhTd0gxc0NNNVRIbHJUblVXTkhSTUlOcUVhT2hrcStsdjFzcDFXYVhy?=
 =?utf-8?B?bDFZV04zd2FUWVZ6S3I3Sm8rV2JCTGJkZytqQ3JVVlpVM2ZSUk9lSEdCUjJY?=
 =?utf-8?B?NHlIc1NSamZvV2lYakx5ekV4N1ZET09EV0E1MUVRWmpNZTJ0TUNKSUpiNGpC?=
 =?utf-8?B?VlhQM0JUVUFDYmI4ejN0aDhwVUJWYjUrTXIybzYvU0tJLzZOV0plckVJampq?=
 =?utf-8?B?YkJOTEU0SStnSmNBRXVqMi9lWXNlSGRFclRpOGdVaHN2ZFcwbklvSE9jc1BO?=
 =?utf-8?B?RTNRVnlRWjVtSktJY1VYSWphZm4xZEt4OWtCMDNTajlZVzRMb21ITjVwcDZn?=
 =?utf-8?B?aElXTlM0RzQrNWYxNHJ3WXFHWlIwN1FiUTZGSk5PdzhYTnRXcXVOSWI2MUg4?=
 =?utf-8?B?RzROL1d6bVpXNGlwUXNCZHBRUVhiTmFUME16K3FHOWtyRTExOG1WTVNObnpW?=
 =?utf-8?B?NXlSaWlpbXNtNExNVTE2c0J4RkRLbEdhdkFWSlpmT2d4WklBZVBYcDVSRURG?=
 =?utf-8?B?SHd6aVJoaTk4azV0RTBLdW1aMXF2RGR4SnpQMCtuVU5UWTNLKzNGcENwV2lF?=
 =?utf-8?B?WjR6YVhmenVVampyc2NNZSt2OXdTb2huSzFtdXpFaFJNK1VIOFkxQ0N6NXIz?=
 =?utf-8?B?M1JCamREZlhJTzVaSjBRb3BLd3ZWSmdZdTl3akhtZDNGb28yWmgvODhWQ2hS?=
 =?utf-8?B?c3AvSldLSmZTOTlReWVuSW1JZWdqSVg3NFAyWmozL2JRWGgxcWFOWHl6VEZB?=
 =?utf-8?B?KzczeEduOGdtWkx4R2t6dCtQZ2VmaHRiRWw2NlpzVVhGT3BGc1VReUxld0RW?=
 =?utf-8?Q?VZpj3D2+gvVKg5J+mKCu+Lg0NuOvmjcyc0heD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC8E7A0779A99F459CE7F3AF5FA66B9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2f575c-dbd1-4084-c99b-08de682a9eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 22:28:59.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmnGe42xhABuudEwiQVKIL0jtWCqOgz+IzmBSzqx50evOG2IBL1ih6vh9RUFxYwRRBBAP0D/6RXv5/WnPNV8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF33AC5CB8F
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698a5faf cx=c_pps
 a=6F35cL4xT6GZaKJ9H0o0MQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=rvewIBGNQqaUG2j-Ng8A:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: jgY3J_kjQ8lr_i1Ci_XYAjSKalw0B_AY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE4OCBTYWx0ZWRfXz5exf6fft6m0
 Ehyx6agu/EPGmYr63yleZJJRmr8pBIe3KMv/bPzoTHLQKYTniUH0kXTCBREVfCJIxVy7AOOKVL7
 Am5LJvW7qE/7qg5yWuUEZDCqxk7E1kX7yLjgip/JVBSulx4zFpgNHRaifnJVHXfO8shhnxg3zom
 lzZxvPdzfpxF7zIyu+jXTYDDRV65Y35iwE3xfE6H62lkcrCiIje6L1B/tOzhN1g8+In+WgV4Oe6
 H7EKr1UgDmYLxTJOyvcmjG2MPH7x5P2IKILwzrv4TEkC7FHZ6+h7G/cXarzC+z8JlzpVqXwIpuv
 tgIW052cH2Ng7uoq6fd4vq2wTJboakc3XSC8gBU2i7LugK244adnmkco3QzYw20GLCFiLjGsALJ
 ZCaUlZeTSVbVl3U4P0S7XNpjpJHJZhtEN6Yg9iJTqQT8mdaCuooZt4OgooGd2GkzVh7FHJWiRKK
 rALhotsfoeCrIppJOLA==
X-Proofpoint-GUID: jgY3J_kjQ8lr_i1Ci_XYAjSKalw0B_AY
Subject: RE: [LSF/MM/BPF TOPIC] Machine Learning (ML) library in Linux kernel
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090188
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76763-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E84D1150EC
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDAyOjAzIC0wODAwLCBDaHJpcyBMaSB3cm90ZToNCj4gT24g
RnJpLCBGZWIgNiwgMjAyNiBhdCAxMTozOOKAr0FNIFZpYWNoZXNsYXYgRHViZXlrbw0KPiA8U2xh
dmEuRHViZXlrb0BpYm0uY29tPiB3cm90ZToNCj4gPiANCj4gPiBIZWxsbywNCj4gPiANCj4gPiBN
YWNoaW5lIExlYXJuaW5nIChNTCkgaXMgYXBwcm9hY2gvYXJlYSBvZiBsZWFybmluZyBmcm9tIGRh
dGEsDQo+ID4gZmluZGluZyBwYXR0ZXJucywgYW5kIG1ha2luZyBwcmVkaWN0aW9ucyB3aXRob3V0
IGltcGxlbWVudGluZyBhbGdvcml0aG1zDQo+ID4gYnkgZGV2ZWxvcGVycy4gVGhlIG51bWJlciBv
ZiBhcmVhcyBvZiBNTCBhcHBsaWNhdGlvbnMgaXMgZ3Jvd2luZw0KPiA+IHdpdGggZXZlcnkgZGF5
LiBHZW5lcmFsbHkgc3BlYWtpbmcsIE1MIGNhbiBpbnRyb2R1Y2UgYSBzZWxmLWV2b2x2aW5nIGFu
ZA0KPiA+IHNlbGYtbGVhcm5pbmcgY2FwYWJpbGl0eSBpbiBMaW51eCBrZXJuZWwuIFRoZXJlIGFy
ZSBhbHJlYWR5IHJlc2VhcmNoIHdvcmtzDQo+ID4gYW5kIGluZHVzdHJ5IGVmZm9ydHMgdG8gZW1w
bG95IE1MIGFwcHJvYWNoZXMgZm9yIGNvbmZpZ3VyYXRpb24gYW5kDQo+ID4gb3B0aW1pemF0aW9u
IHRoZSBMaW51eCBrZXJuZWwuIEhvd2V2ZXIsIGludHJvZHVjdGlvbiBvZiBNTCBhcHByb2FjaGVz
DQo+ID4gaW4gTGludXgga2VybmVsIGlzIG5vdCBzbyBzaW1wbGUgYW5kIHN0cmFpZ2h0Zm9yd2Fy
ZCB3YXkuIFRoZXJlIGFyZSBtdWx0aXBsZQ0KPiA+IHByb2JsZW1zIGFuZCB1bmFuc3dlcmVkIHF1
ZXN0aW9ucyBvbiB0aGlzIHJvYWQuIEZpcnN0IG9mIGFsbCwgYW55IE1MIG1vZGVsDQo+ID4gcmVx
dWlyZXMgdGhlIGZsb2F0aW5nLXBvaW50IG9wZXJhdGlvbnMgKEZQVSkgZm9yIHJ1bm5pbmcuIEJ1
dCB0aGVyZSBpcw0KPiA+IG5vIGRpcmVjdCB1c2Ugb2YgRlBVcyBpbiBrZXJuZWwgc3BhY2UuIEFs
c28sIE1MIG1vZGVsIHJlcXVpcmVzIHRyYWluaW5nIHBoYXNlDQo+ID4gdGhhdCBjYW4gYmUgYSBy
ZWFzb24gb2Ygc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24gb2YgTGludXgga2Vy
bmVsLg0KPiA+IEV2ZW4gaW5mZXJlbmNlIHBoYXNlIGNvdWxkIGJlIHByb2JsZW1hdGljIGZyb20g
dGhlIHBlcmZvcm1hbmNlIHBvaW50IG9mIHZpZXcNCj4gPiBvbiBrZXJuZWwgc2lkZS4gVGhlIHVz
aW5nIG9mIE1MIGFwcHJvYWNoZXMgaW4gTGludXgga2VybmVsIGlzIGluZXZpdGFibGUgc3RlcC4N
Cj4gPiBCdXQsIGhvdyBjYW4gd2UgdXNlIE1MIGFwcHJvYWNoZXMgaW4gTGludXgga2VybmVsPyBX
aGljaCBpbmZyYXN0cnVjdHVyZQ0KPiA+IGRvIHdlIG5lZWQgdG8gYWRvcHQgTUwgbW9kZWxzIGlu
IExpbnV4IGtlcm5lbD8NCj4gDQo+IEkgdGhpbmsgdGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgdGhp
bmdzLCBJIHRoaW5rIHlvdSB3YW50IHRoZSBsYXR0ZXINCj4gYnV0IEkgYW0gbm90IHN1cmUNCj4g
DQo+IDEpIHVzaW5nIE1MIG1vZGVsIHRvIGhlbHAga2VybmVsIGRldmVsb3BtZW50LCBjb2RlIHJl
dmlld3MsIGdlbmVyYXRlDQo+IHBhdGNoZXMgYnkgZGVzY3JpcHRpb25zIGV0Yy4gRm9yIGV4YW1w
bGUsIENocmlzIE1hc29uIGhhcyBhIGtlcm5lbA0KPiByZXZpZXcgcmVwbyBvbiBnaXRodWIgYW5k
IGhlIGlzIHNoYXJpbmcgaGlzIHJldmlldyBmaW5kaW5nIHRoZSBtYWlsaW5nDQo+IGxpc3Q6DQo+
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZ2l0
aHViLmNvbV9tYXNvbmNsX3Jldmlldy0yRHByb21wdHNfdHJlZV9tYWluJmQ9RHdJRmFRJmM9QlNE
aWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtF
bHZVZ1NzMDAmbT12dnJEUHh5d19KWFBya0M4Qmp6QTJrRXR3ZFBmd1YyZ0JNRVhHN1p2ZVhNNExo
UzAxTGZvR3dxaEV5VVpwUGU0JnM9cnFOZXo1X3JtaUV1RTdpbjVlXzdNZnlVenpxemFBNkdrNDZX
V3ZtTjN5ayZlPSANCj4gSXQgaXMga2VybmVsIGRldmVsb3BtZW50IHJlbGF0ZWQsIGJ1dCB0aGUg
TUwgYWdlbnQgY29kZSBpcyBydW5uaW5nIGluDQo+IHRoZSB1c2VyIHNwYWNlLiBUaGUgYWN0dWFs
IE1MIGNvbXB1dGF0aW9uIG1pZ2h0IHJ1biBHUFUvVFBVcy4gVGhhdA0KPiBkb2VzIG5vdCBzZWVt
IHRvIGJlIHdoYXQgeW91IGhhdmUgaW4gbWluZC4NCj4gDQo+IDIpIFJ1biB0aGUgTUwgbW9kZWwg
Y29tcHV0YXRpb24gaW4gdGhlIGtlcm5lbCBzcGFjZS4NCj4gQ2FuIHlvdSBjbGFyaWZ5IGlmIHRo
aXMgaXMgd2hhdCB5b3UgaGF2ZSBpbiBtaW5kPyBZb3UgbWVudGlvbiBrZXJuZWwNCj4gRlBVIHVz
YWdlIGluIHRoZSBrZXJuZWwgZm9yIE1MIG1vZGVsLiBJdCBpcyBvbmx5IHJlbGV2YW50IGlmIHlv
dSBuZWVkDQo+IHRvIHJ1biB0aGUgRlAgaW4gdGhlIGtlcm5lbCBDUFUgaW5zdHJ1Y3Rpb25zLiBN
b3N0IE1MIGNvbXB1dGF0aW9ucyBhcmUNCj4gbm90IHJ1biBpbiBDUFUgaW5zdHJ1Y3Rpb25zLiBU
aGV5IHJ1biBvbiBHUFVzL1RQVXMuIFdoeSBub3Qga2VlcCB0aGUNCj4gTUwgcHJvZ3JhbSAoUHlU
b3JjaC9hZ2VudHMpIGluIHRoZSB1c2VyIHNwYWNlIGFuZCBwYXNzIHRoZSBkYXRhIHRvIHRoZQ0K
PiBHUFUvVFBVIGRyaXZlciB0byBydW4/IFRoZXJlIHdpbGwgYmUgc29tZSBrZXJuZWwgaW5zdHJ1
Y3R1cmUgbGlrZQ0KPiBWRklPL0lPTU1VIGludm9sdmVkIHdpdGggdGhlIEdQVS9UUFUgZHJpdmVy
LiBGb3IgdGhlIG1vc3QgcGFydCB0aGUNCj4ga2VybmVsIGlzIGp1c3QgZmFjaWxpdGF0aW5nIHRo
ZSBkYXRhIHBhc3NpbmcgdG8vZnJvbSB0aGUgR1BVL1RQVQ0KPiBkcml2ZXIgdGhlbiB0byB0aGUg
R1BVL1RQVSBoYXJkd2FyZS4gVGhlIE1MIGhhcmR3YXJlIGlzIGRvaW5nIHRoZQ0KPiBoZWF2eSBs
aWZ0aW5nLg0KDQpUaGUgaWRlYSBpcyB0byBoYXZlIE1MIG1vZGVsIHJ1bm5pbmcgaW4gdXNlci1z
cGFjZSBhbmQga2VybmVsIHN1YnN5c3RlbSBjYW4NCmludGVyYWN0IHdpdGggTUwgbW9kZWwgaW4g
dXNlci1zcGFjZS4gQXMgdGhlIG5leHQgc3RlcCwgSSBhbSBjb25zaWRlcmluZyB0d28NCnJlYWwt
bGlmZSB1c2UtY2FzZXM6ICgxKSBHQyBzdWJzeXN0ZW0gb2YgTEZTIGZpbGUgc3lzdGVtLCAoMikg
TUwtYmFzZWQgREFNT04NCmFwcHJvYWNoLiBTbywgZm9yIGV4YW1wbGUsIEdDIGNhbiBiZSByZXBy
ZXNlbnRlZCBieSBNTCBtb2RlbCBpbiB1c2VyLXNwYWNlLiBHQw0KY2FuIHJlcXVlc3QgZGF0YSAo
c2VnbWVudHMgc3RhdGUpIGZyb20ga2VybmVsLXNwYWNlIGFuZCBNTCBtb2RlbCBpbiB1c2VyLXNw
YWNlDQpjYW4gZG8gdHJhaW5pbmcgb3IvYW5kIGluZmVyZW5jZS4gQXMgYSByZXN1bHQsIE1MIG1v
ZGVsIGluIHVzZXItc3BhY2UgY2FuIHNlbGVjdA0KdmljdGltIHNlZ21lbnRzIGFuZCBpbnN0cnVj
dCBrZXJuZWwtc3BhY2UgbG9naWMgb2YgbW92aW5nIHZhbGlkIGRhdGEgZnJvbSB2aWN0aW0NCnNl
Z21lbnQocykgaW50byBjbGVhbi9jdXJyZW50IG9uZShzKS4gDQoNCj4gDQo+ID4gV2hhdCBpcyB0
aGUgZ29hbCBvZiB1c2luZyBNTCBtb2RlbHMgaW4gTGludXgga2VybmVsPyBUaGUgbWFpbiBnb2Fs
IGlzDQo+ID4gdG8gZW1wbG95IE1MIG1vZGVscyBmb3IgZWxhYm9yYXRpb24gb2YgYSBsb2dpYyBv
ZiBwYXJ0aWN1bGFyIExpbnV4IGtlcm5lbA0KPiA+IHN1YnN5c3RlbSBiYXNlZCBvbiBwcm9jZXNz
aW5nIGRhdGEgb3IvYW5kIGFuIGVmZmljaWVudCBzdWJzeXN0ZW0NCj4gPiBjb25maWd1cmF0aW9u
IGJhc2VkIG9uIGludGVybmFsIHN0YXRlIG9mIHN1YnN5c3RlbS4gQXMgYSByZXN1bHQsIGl0IG5l
ZWRzOg0KPiA+ICgxKSBjb2xsZWN0IGRhdGEgZm9yIHRyYWluaW5nLCAoMikgZXhlY3V0ZSBNTCBt
b2RlbCB0cmFpbmluZyBwaGFzZSwNCj4gPiAoMykgdGVzdCB0cmFpbmVkIE1MIG1vZGVsLCAoNCkg
dXNlIE1MIG1vZGVsIGZvciBleGVjdXRpbmcgdGhlIGluZmVyZW5jZSBwaGFzZS4NCj4gDQo+IEFz
IGZhciBhcyBJIGNhbiB0ZWxsLCBhIGxvdCBvZiB0aG9zZSBkb24ndCBuZWVkIHRvIGJlIGluIHRo
ZSBrZXJuZWwncw0KPiBidXNpbmVzcy4gSXQgaXMgbW9yZSBvZiBhIEdQVS9UUFUgZHJpdmVyIHVz
ZXIgc3BhY2UgaW50ZXJmYWNlIHRoaW5nLA0KPiBtaWdodCBiZSBlYXNpZXIgdG8gYWxsb3cgdGhl
IGRyaXZlciB0byBjb252ZXJ0IHRoZWlyIG93biBrZXJuZWwvdXNlcg0KPiBzcGFjZSBBUEkgdGhl
biBleHBvc2UgY29tbW9uIHVzZXIgc3BhY2UgbGlicmFyeSBBUEkuIEFyZSB5b3UgdHJ5aW5nIHRv
DQo+IGRlZmluZSBzb21ldGhpbmcgbGlrZSBOdmlkaWEgQ1VEQSBhdCB0aGUga2VybmVsIGxldmVs
Pw0KPiANCj4gPiBUaGUgTUwgbW9kZWwgaW5mZXJlbmNlIGNhbiBiZSB1c2VkIGZvciByZWNvbW1l
bmRhdGlvbiBvZiBMaW51eCBrZXJuZWwNCj4gPiBzdWJzeXN0ZW0gY29uZmlndXJhdGlvbiBvci9h
bmQgZm9yIGluamVjdGluZyBhIHN5bnRoZXNpemVkIHN1YnN5c3RlbSBsb2dpYw0KPiA+IGludG8g
a2VybmVsIHNwYWNlIChmb3IgZXhhbXBsZSwgZUJQRiBsb2dpYykuDQo+IA0KPiBUaGF0IGFnYWlu
IHNvdW5kcyB2ZXJ5IG11Y2ggbGlrZSBhIHVzZXJzcGFjZSBpc3N1ZSwgdGhlIGFib3ZlIDEpIHVz
YWdlIGNhc2UuDQo+IA0KPiA+IEhvdyBNTCBpbmZyYXN0cnVjdHVyZSBjYW4gYmUgZGVzaWduZWQg
aW4gTGludXgga2VybmVsPyBJdCBuZWVkcyB0byBpbnRyb2R1Y2UNCj4gPiBpbiBMaW51eCBrZXJu
ZWwgYSBzcGVjaWFsIE1MIGxpYnJhcnkgdGhhdCBjYW4gaW1wbGVtZW50IGEgZ2VuZXJhbGl6ZWQN
Cj4gPiBpbnRlcmZhY2Ugb2YgaW50ZXJhY3Rpb24gYmV0d2VlbiBNTCBtb2RlbOKAmXMgdGhyZWFk
IGluIHVzZXItc3BhY2UgYW5kIGtlcm5lbA0KPiA+IHN1YnN5c3RlbS4gTGlrZXdpc2UgaW50ZXJm
YWNlIHJlcXVpcmVzIHRvIGhhdmUgdGhlIG1lYW5zOg0KPiA+ICgxKSBjcmVhdGUvaW5pdGlhbGl6
ZS9kZXN0cm95IE1MIG1vZGVsIHByb3h5IGluIGtlcm5lbCBzdWJzeXN0ZW0sDQo+ID4gKDIpIHN0
YXJ0L3N0b3AgTUwgbW9kZWwgcHJveHksICgzKSBnZXQvcHJlcHJvY2Vzcy9wdWJsaXNoIGRhdGEg
c2V0cw0KPiA+IGZyb20ga2VybmVsIHNwYWNlLCAoNCkgcmVjZWl2ZS9wcmVwcm9jZXNzL2FwcGx5
IE1MIG1vZGVsIHJlY29tbWVuZGF0aW9uKHMpDQo+ID4gZnJvbSB1c2VyLXNwYWNlLCAoNSkgZXhl
Y3V0ZSBzeW50aGVzaXplZCBsb2dpYy9yZWNvbW1lbmRhdGlvbnMgaW4ga2VybmVsLXNwYWNlLA0K
PiA+ICg2KSBlc3RpbWF0ZSBlZmZpY2llbmN5IG9mIHN5bnRoZXNpemVkIGxvZ2ljL3JlY29tbWVu
ZGF0aW9ucywNCj4gPiAoNykgZXhlY3V0ZSBlcnJvciBiYWNrLXByb3BhZ2F0aW9uIHdpdGggdGhl
IGdvYWwgb2YgY29ycmVjdGlvbiBNTCBtb2RlbA0KPiA+IG9uIHVzZXItc3BhY2Ugc2lkZS4NCj4g
DQo+IFVuZm9ydHVuYXRlbHkgYSBsb3Qgb2YgdGhvc2Ugd2lsbCBiZSB0aWdodCB0byB0aGUgaW50
ZXJuYWwNCj4gaW1wbGVtZW50YXRpb24gb2YgdGhlIEdQVS9UUFUuIFRoZSBtb2RlbCBuZWVkcyB0
byBiZSBjb21waWxlZCBpbnRvDQo+IEdQVS9UUFUgbWFjaGluZSBpbnN0cnVjdGlvbnMuIFNvIGZv
cmNpbmcgYSBjb21tb24gaW50ZXJmYWNlIHdpbGwgYmUNCj4gaGFyZCBiZWNhdXNlIHRoZSBsb3dl
ciBpbnRlcmZhY2UgcmVxdWlyZW1lbnQgbWlnaHQgYmUgdmVyeSBkaWZmZXJlbnQuDQo+IE1heWJl
IGhhdmluZyBzb21lIGNvbW1vbiB1c2VyIHNwYWNlIGxpYnJhcnkgb3IgTUwgZGVzY3JpcHRpb24g
bGFuZ3VhZ2UNCj4gaXMgYmV0dGVyIHRoYW4gZm9yY2luZyBhIGtlcm5lbCBpbnRlcmZhY2UuDQo+
IA0KPiA+IFRoZSBjcmVhdGUgYW5kIGluaXRpYWxpemUgbG9naWMgY2FuIGJlIGV4ZWN1dGVkIGJ5
IGtlcm5lbCBzdWJzeXN0ZW0gZHVyaW5nDQo+ID4gbW9kdWxlIGxvYWQgb3IgTGludXgga2VybmVs
IHN0YXJ0IChvcHBvc2l0ZWx5LCBtb2R1bGUgdW5sb2FkIG9yIGtlcm5lbA0KPiA+IHNodXRkb3du
IHdpbGwgZXhlY3V0ZSBkZXN0cm95IG9mIE1MIG1vZGVsIHByb3h5IGxvZ2ljKS4gTUwgbW9kZWwg
dGhyZWFkDQo+ID4gaW4gdXNlci1zcGFjZSB3aWxsIGJlIGNhcGFibGUgdG8gcmUtaW5pdGlhbGl6
ZSBhbmQgdG8gZXhlY3V0ZQ0KPiA+IHRoZSBzdGFydC9zdG9wIGxvZ2ljIG9mICBNTCBtb2RlbCBw
cm94eSBvbiBrZXJuZWwgc2lkZS4gRmlyc3Qgb2YgYWxsLA0KPiA+IE1MIG1vZGVsIG5lZWRzIHRv
IGJlIHRyYWluZWQgYnkgZGF0YSBmcm9tIGtlcm5lbCBzcGFjZS4gVGhlIGRhdGEgY2FuIGJlDQo+
ID4gcmVxdWVzdGVkIGJ5IE1MIG1vZGVsIGZyb20gdXNlci1zcGFjZSBvciBkYXRhIGNhbiBiZSBw
dWJsaXNoZWQgYnkgTUwgbW9kZWwNCj4gPiBwcm94eSBmcm9tIGtlcm5lbC1zcGFjZS4gVGhlIHN5
c2ZzIGludGVyZmFjZSBjYW4gYmUgdXNlZCB0byBvcmNoZXN0cmF0ZQ0KPiA+IHRoaXMgaW50ZXJh
Y3Rpb24uIEFzIGEgcmVzdWx0LCBNTCBtb2RlbCBpbiB1c2VyLXNwYWNlIHNob3VsZCBiZSBjYXBh
YmxlDQo+ID4gdG8gZXh0cmFjdCBkYXRhIHNldChzKSBmcm9tIGtlcm5lbCBzcGFjZSB0aHJvdWdo
IHN5c2ZzLCBGVVNFIG9yIGNoYXJhY3Rlcg0KPiA+IGRldmljZS4gRXh0cmFjdGVkIGRhdGEgY2Fu
IGJlIHN0b3JlZCBpbiBwZXJzaXN0ZW50IHN0b3JhZ2UgYW5kLCBmaW5hbGx5LA0KPiA+IE1MIG1v
ZGVsIGNhbiBiZSB0cmFpbmVkIGluIHVzZXItc3BhY2UgYnkgYWNjZXNzaW5nIHRoZXNlIGRhdGEu
DQo+IA0KPiBDdXJyZW50bHkgYSBsb3Qgb2YgdGhvc2UgYXJlIGhhcHBlbmluZyBpbiB0aGUgR1BV
L1RQVSBkcml2ZXJzIGFuZCB1c2VyDQo+IHNwYWNlIGxpYnJhcnkuIE9uZSBjaGFsbGVuZ2luZyBh
c3BlY3QgaXMgdGhlIGhhcmR3YXJlIGludGVyZmFjZSBpcw0KPiB2ZXJ5IGRpZmZlcmVudCBiZXR3
ZWVuIEdQVXMvVFBVcywgYW5kIG1pZ2h0IGJlIGNoYWxsZW5naW5nIHRvIGV4cG9zZQ0KPiBjb21t
b24gaW50ZXJmYWNlcy4NCj4gDQo+ID4gVGhlIGNvbnRpbnVvdXMgbGVhcm5pbmcgbW9kZWwgY2Fu
IGJlIGFkb3B0ZWQgZHVyaW5nIHRyYWluaW5nIHBoYXNlLg0KPiA+IEl0IGltcGxpZXMgdGhhdCBr
ZXJuZWwgc3Vic3lzdGVtIGNhbiByZWNlaXZlIE1MIG1vZGVsIHJlY29tbWVuZGF0aW9ucw0KPiA+
IGV2ZW4gZHVyaW5nIHRyYWluaW5nIHBoYXNlLiBNTCBtb2RlbCBwcm94eSBvbiBrZXJuZWwgc2lk
ZSBjYW4gZXN0aW1hdGUNCj4gPiB0aGUgY3VycmVudCBrZXJuZWwgc3Vic3lzdGVtIHN0YXRlLCB0
cmllcyB0byBhcHBseSB0aGUgTUwgbW9kZWwNCj4gPiByZWNvbW1lbmRhdGlvbnMsIGFuZCBlc3Rp
bWF0ZSB0aGUgZWZmaWNpZW5jeSBvZiBhcHBsaWVkIHJlY29tbWVuZGF0aW9ucy4NCj4gPiBHZW5l
cmFsbHkgc3BlYWtpbmcsIE1MIG1vZGVsIHByb3h5IG9uIGtlcm5lbCBzaWRlIGNhbiBjb25zaWRl
ciBzZXZlcmFsDQo+ID4gbW9kZXMgb2YgaW50ZXJhY3Rpb24gd2l0aCBNTCBtb2RlbCByZWNvbW1l
bmRhdGlvbnM6ICgxKSBlbWVyZ2VuY3kgbW9kZSwNCj4gDQo+IFRoYXQgc291bmRzIGxpa2UgdXNl
ciBzcGFjZSBpbnRlcmFjdGlvbiBhZ2Fpbi4gTm90IHN1cmUgaXQgaXMgZm9yIHRoZQ0KPiBrZXJu
ZWwgc3BhY2UuDQoNClRoYW5rcyBhIGxvdCBmb3Igc2hhcmluZyBhbGwgeW91ciB0aG91Z2h0cy4g
OikgSSB0aGluayBJIG5lZWQgdG8gcG9pbnQgb3V0IHRoYXQ6DQpNTCBtb2RlbCBydW5uaW5nIGlu
IHVzZXItc3BhY2UgYW5kIGtlcm5lbCBzdWJzeXN0ZW0gY2FuIGludGVyYWN0IHdpdGggTUwgbW9k
ZWwNCmluIHVzZXItc3BhY2UuIDopIFRoaXMgaXMgdGhlIG1haW4gaWRlYS4gVGhlIGdvYWwgb2Yg
TUwgbGlicmFyeSBpcyB0byBpbXBsZW1lbnQNCmdlbmVyYWxpemVkIGludGVyZmFjZS9mdW5jdGlv
bmFsaXR5IHRoYXQgY2FuIGdpdmUgdGhlIGNhcGFiaWxpdHkgZm9yIGFueSBrZXJuZWwNCnN1YnN5
c3RlbSB0byBiZSBleHRlbmRlZCBieSBNTCBtb2RlbCBpbiB1c2VyLXNwYWNlLiBBbmQgSSBiZWxp
ZXZlIHRoYXQgd2UgY2FuDQpwcm92aWRlIHRoaXMgaW4gZ2VuZXJpYyB3YXkuDQoNCkFuZCB5b3Ug
Y2FuIGNoZWNrIHRoZSBwYXRjaHNldCBbMV0gdG8gc2VlIHRoZSB2aXNpb24gb2YgcG90ZW50aWFs
IGltcGxlbWVudGF0aW9uDQpvZiB0aGUgaWRlYS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXQ0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDI2MDIwNjE5MTEzNi4yNjA5
NzY3LTEtc2xhdmFAZHViZXlrby5jb20vVC8jdA0KDQo=

