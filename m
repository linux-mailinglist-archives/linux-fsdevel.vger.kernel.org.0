Return-Path: <linux-fsdevel+bounces-79867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM5mGaogr2myOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:34:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A6240144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7541330576E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434ED34CFD7;
	Mon,  9 Mar 2026 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m6Teo3ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0971E5724;
	Mon,  9 Mar 2026 19:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084506; cv=fail; b=bm3Tv6/Fmy7D8X5CxNh5PcKvwcez116jh3vozbyOvvg1WngL5uiLs05xPvGmVW/75QRF9VXL1BU4sRKgi3lZgGFgXw9nTf1x1wPgqwHK8LSEoXLdBir9Bq+Tlha52rChmHbRnBHDWH+1RAus8mQCaLWy7kPtgRnaHuCOEmvgtiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084506; c=relaxed/simple;
	bh=7woXeaRokZ9StTvfJkgsjYX+C6aJfu+dSpA5xLaA3VI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eM953JX52AK6ONwsPfRjZTpVMdFSWiEh3GAUtCsfseFRMiHipRlEtaMWkNGlj8uYxpjCZi2YoUxQVmFy6U5fUiehk44WNwX8OKN7IrHZkSv9VJA7VQ6+tO+v9E1nP4U1UzR3HULqbN7FVmdAmWMiRXulTNeImFza4zOtdj7hg10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m6Teo3ql; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629GOlgU1633953;
	Mon, 9 Mar 2026 19:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=7woXeaRokZ9StTvfJkgsjYX+C6aJfu+dSpA5xLaA3VI=; b=m6Teo3ql
	m7Y0KsbaeJZkYmxC1FCBXT5lUysKiRg3hqI0yVFU+GKMhi9td67owxwC7xBPpB/r
	n43IKJK0V5NIba4imNRCG8kho1jkmT3bO99UfBpPUwDbJpFzCv6zQkJmabDzDRn2
	inUD9ygltY4cbzxx5b4d6W8QYKWyqAIMMRNOiLA+J7zEQDW4Brrhn+tCfi5HbNyP
	8oOErE0uuWxpLBw+26lcoPClFdRFmaOryZJff1PvRwzsV4qHdHVjZgB/g9ZiWcT/
	yFMRh17YSKLjCyVH/m1tZckXWMDyjqbC/zbw/DXTab9c9mlvAWQow6iSoh9avlZq
	h6K8t+tw3SpF2g==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw82ux-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:28:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/6i7tSKJQdWv0HMyqNtsAtDv38CeU5uu4mTQstP63eXkOfkM1uL80dJLnFYhHZwr0O6DZPu6TnZcPkHb6dUD6kORX/PEpObBRTFAWKmPV0pc/I7WTKO9kc2Ogqrgf5yEH7kGV2pI5oZYFs2c5+QI+sHkYrz7j8+kBf+KJHoKd9yGtEvAtEt2LZVru7Xd+gRLciAnEPTIcyz/UhwAhGYLR1fZdFVLtFT30gewVTx2ubb3Zr863t1iKRX43E+iQnvoD7/Js3GT6f0H6nUIrYiQjRhNBvDB1rZmPsiGBiRiE6UgD/3OcHrlCB0oM79hT6852oqV+TBX4G2KvwyfRWAhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7woXeaRokZ9StTvfJkgsjYX+C6aJfu+dSpA5xLaA3VI=;
 b=BmkGTMmrKCXSztwLqv2B6wfGyAQO+9Tqxx3qm+48zRGwz2Vi/gvBvrAxK4pKWykGM2BjAu5jr6koj7EjyJ8cnjRRNpdmhvSBS+0Ujl4jVXBZCR/xYXr4+g07TmTqwWiAnvOdu8vhJyvINGuEdGHnowVDre3mIe/yuvHLTy8EFPhNKg4LEkrcZNkmP3dCuf+M9t6ZGk3EeNS3fM2ACd8xeSKpq1D4YSC2PkdNUBK6PXRqokE+PvsjLOsmCPrS3aE/kRV/gy9T8LYSmWxLrZRXvM76G+eqJTsXyfxtSkYx4zcmPSu+lqc9I/q6f9gUIkTyGHS/GVk/oRIgudoUM/STlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6338.namprd15.prod.outlook.com (2603:10b6:208:444::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 9 Mar
 2026 19:28:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:28:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "janak@mpiric.us" <janak@mpiric.us>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>
Thread-Topic: [EXTERNAL] Re:  [PATCH v5 1/2] hfsplus: refactor b-tree map page
 access and add node-type validation
Thread-Index: AQHcr7pvMWg8VpXOpUOeL6NfCiIp8LWmlkIA
Date: Mon, 9 Mar 2026 19:28:09 +0000
Message-ID: <61e5cb0c41cc65e9e51234c9d7d0216e756d225b.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
		 <20260228122305.1406308-2-shardul.b@mpiricsoftware.com>
		 <26a565dba487cc1290b9abe5fe54fb068bd475e4.camel@ibm.com>
	 <8b2bb4e6d8cff87ace4b0e4d725e4fe573716b80.camel@mpiricsoftware.com>
In-Reply-To:
 <8b2bb4e6d8cff87ace4b0e4d725e4fe573716b80.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6338:EE_
x-ms-office365-filtering-correlation-id: a822aa69-7066-4322-fa04-08de7e11ff48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 Uj4TN09e6Xjo7desDhY6yYXfk/Up4SOiGqIt+hCZPk+lgzZiECvGhbUc4bEFDZdwQjXxu1pKg+gTj8jJQIuqiplY//YzgYkJ8XljDU07VPSWkQobA4phMQivDDTNCA7lhNPianr4T5t8e8TI1bgd9TH2QPXyDaCyLrpQSdVc7NknXcgP7EM5DnYs0iyQW1pZIfiJiXgaIn1iKPzM5xqf52A+f39m7AE1pSQk3D9pls/Pe9FFIMnG/e4ZzOEdTfv6brgdutZD3KZT30at1SRXjSM+/aRSW/uMlYYIgY/yk98Wm6RVcCmLhopK5d80RDuarhTpbHaHUUEEXNTTkhYtUr/879y4J6gixoSgeBGmwf+WRwImYUF3NkmTI2a7I+LY8MKkdbVfx0qY1DjE94/sJENCHolZrW2+64JOMWGHTkyahdi2gsukmGYmrcUBoeBz6EEZye4brWB7VGi3zT6EeKVloLUL/qe9YT46GVwXHVwUBXpZ8S6iKUVLHIERgykmuuLJTSy8RbUSjnTHh0ludk/Creyc6ACYANDuj1qZQcTLdASM2iMS7RgoPatPOaUGYre2FqY+Najwg9H3AU9lJz/UmCpFh/fQRrqtY1Puj5eba/xMHPPez2g3YgEf7/WHIdp+VLRtRKUyCTtjuAvISZGAsvbb9BtF/KIXLj+qq+27XPz/G5fZfZ/Pj2jVVY7nlx7nNe3HXQVwNFjsZ1vQGg0z8pyyGzDRoegdKpscjaLy27JWnVzJceCxTNGqy7n7ZYSbcuUgEZ1D0gngHFmSLW+iBacjioHY4GAZp9boLyw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWNRdVlJNzNVZDIwcm5lZlQyc3JUcU5IY2JkbksrWm02Sjg5TzJoVk4xVXdk?=
 =?utf-8?B?MFI0SlFuRnZpRTlnMC9jd1JzRTVjb1o1UU10SVhoeFU2MDZMZitSRXJhMEhv?=
 =?utf-8?B?MTE2Y1pQR1o2dS9rdTNhMUJSUjllUWxKT1l6dkRtZHY0TXVQQUI4WnMyYkQr?=
 =?utf-8?B?c1BIRVdIMzZzNmFIdDhSaXhaZXRkTWx3Q2wwRCtSdmRRRnNMbmZTc2p6TUE4?=
 =?utf-8?B?MXVJbWg5dXg3ak1kWGk1TmNpRlVaUUV1cDZNOGcrSmR4ZTk3K0pBVm5VREhI?=
 =?utf-8?B?SXRtZyt2djJPZFlTRGZXYXMxZFY3QzBpVEpoanZOM29PRGM0V2xUOXhvbE4z?=
 =?utf-8?B?NGFPSE9JQ21LZSt1YzFtSnY2Y1hSWjVvbDBUbDB0NEdjd0dVS2NjQWpHd1RH?=
 =?utf-8?B?eWJta0h3aHFjSVZlMHNVb1JtOTFNZFZ1T2N2RStReXdyZkxjL2tubmtsYk1q?=
 =?utf-8?B?U2U0YlpKM29XRlNWbGtwU3dHOGpuYlhNMWRQSExpdTNVaEhNV0UycUMyeCtX?=
 =?utf-8?B?dlpUOVIwM1YrS05iYWowbEZEbU10clAxK1dyNW5JaTBYb2JxTk5kSGhvci9B?=
 =?utf-8?B?WWZvSDRxQnptVkhIVWNSd0U4NUpUV2NPaDk3VTZDVjZtRnNZcXNNM1MvSjA3?=
 =?utf-8?B?c0JVem9ySng1VHNEekxTV1V2VDN1WjRMZy9WRUY3Ym1FbWZQWi91L0h4RkVR?=
 =?utf-8?B?bWV3QUpkL3BtNnlablNjMlVWRW9wY2VDM2JSYWRYM216YVplQzBod3dsTEw3?=
 =?utf-8?B?TXFNWENJelJaQVJYbzlkU0s4K2puK3ZSVXJ5NWRoSjZFcjJrelJicUZ4RDJt?=
 =?utf-8?B?bEQ3SkUwbUVmZmpjZzBJSmxmNHkzQklQVXcxMU9sZEFwOWkydmxZUDBUdWZT?=
 =?utf-8?B?MGxlZXlpSGF3ZmJ4YTd6U3hVODRMZnlldCtzb0JyUTh3SXNSc1lRL2gwVUEz?=
 =?utf-8?B?NWkvb3czVm5KTFNXWWo0eUVWSjJ3SDBGQ0kxdWFPQXdpY1ZwSHlsakIyR3px?=
 =?utf-8?B?TUMwbTVKRGxLNVBuKzVGeHMxQk54SVRxdTBHQlRkeFVXT0pJYmFBV3RCWDVI?=
 =?utf-8?B?bS9tSEJVWHBXNGNSN0J0WGFZdnV3RWVlR2dlbDVnMGhlWHpqcFZPTkNPSWZl?=
 =?utf-8?B?eEF5Vy9oMlF3aTJEOWVtOHFIWnhUdCtKSmt5V0IvRlppbGp2WEtUODBRRUNE?=
 =?utf-8?B?Vnh2WlhKQ3RGM0lNbllHRFZQUDdpaTJhV3Z4VkdRT05JY05HUGtOVlR5UmRN?=
 =?utf-8?B?VjF3MGd0cEMzVXhHL0NSbWdDb2xHcVpvSlY4bS9sUmRPSWtNaTV0SDJXbk9a?=
 =?utf-8?B?WUlQTWwzMGtweEVJSUlaNU5GdDNFditNSElkd2tZci9oMGtJaVNMN2t6SUs0?=
 =?utf-8?B?ckU5MDhSdnFZTEl0a0lkTlZzR3NRcDlqVUhlb2k1SldkRkp2WFlOdFAyVi9h?=
 =?utf-8?B?ZmhaTm9MUk8zZmxEL0VlcFR4K2srT1VROXdnbC9IVzJYdGM4VDJaTk5kczVN?=
 =?utf-8?B?dVRVN2Q5ZXdQWGJPL0l3bzY3OWxvYkY4dzlCUUdka3JlelVrUnhNV2RqUXNB?=
 =?utf-8?B?cXNpU2tPNlNOUG9tUnVHcmp1blkxbG01c21iNU95enpFbkRoVklScVU0RXdo?=
 =?utf-8?B?NC9HcVhIOFk2ejRUU1pJaWpNZ2xFRWJCcVZGRDc4VVpFVDZMbkN4eWJQcjNl?=
 =?utf-8?B?RDRjSVRxVm00ZkFSdUpBMUhpSjJnMmJicFZEd0o4T2NDSWlITXk0NGNOamxu?=
 =?utf-8?B?M1lXY3V6WkpneEFudHo0ZW9XSnZ1ZjdVc0tVZEJSZmJmNjhoNldTMytJd3k3?=
 =?utf-8?B?NGllTGJGbUdMbGVzbGpEdkJWSWZmU3FHcno4VzFSeklxaUg2V0NZdjNmelRN?=
 =?utf-8?B?ZUVmNURwaEEzOCt5ZGo2WUh0NFpPNDJFaVBsdE1sQU9Fc08zcXRlNitQdEMw?=
 =?utf-8?B?N21UQ3BWcUNTcWJrSmZZdDZpeDJHZ2RnTGJjMXZqWUJZMVR2dndhU1NGaWJh?=
 =?utf-8?B?SEZuUFJoaVAvSXhWZDg2VVMxTFk0T0k3Q0I4UXpURm9ZMGhxYjExZTh1OWNS?=
 =?utf-8?B?SnUvYUFHbFF5Qnh3NW9FMHQzYVB1cFdOQThqWmdjQURGYmVaRTE3aUovMTc5?=
 =?utf-8?B?aGdWOWdUMUEreWhkYkFIZWJIMmFvRVJ3ZDd4OVhydmpkZEFaSUJsY2hJSnNH?=
 =?utf-8?B?TVI0U1Y0a0p0c0ZWbDRORTQ2N1hXNWlIZS81WW95ZjZzQU8vcXRGanhuTWd5?=
 =?utf-8?B?UzlBbFluanVicFJFRzhZSXRENGNuT0VhelRIWmRNdGZrN2NrcjdrQjdDLzVO?=
 =?utf-8?B?aGh3djYrem1Ea3R0bjB3VkdPRExqVUNSYWRERVpsbkM1Zy9zM25UTTh3S096?=
 =?utf-8?Q?25ZSPaGu7XWhyD0XVMrCkekNhEFqkpd9hUGFw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE2B4C1E22261A49BA0AE0D16A0FDBA2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UKEH8T0Psrw+drqSd7gn0meUKjO7UW5YM1qDFrdL1xH8CDHyyx9ifv+OLX5kWVQ8TVs//8cBycR0+5x0BlvFq2XIjZsQChgyIwP6qrkof25tn5UvBg/rQ7Eg9hvLHBLPyUuXBwh2+mJbwDg8UAOsEysO88fIbH9eXeOb8Sj+p6vh87I3n2EMbuousAvqNGXZmBvKL0/BlFS+gom3++Acv4QRNPanjpTcbMCjm8N650T1rFwJOElhb4AL5bl9dH1kNRsGe0L8BucfCacApev9HE7PK6OIUHuhXbS+j9N0EAfJu88rrHEgZA9c2RJXbdtHOd76qsEXZ549NWSJ7s15GQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a822aa69-7066-4322-fa04-08de7e11ff48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:28:09.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dy+HsWAt1SLp9yMZcui2GicUrZnCQbXo+051EtUd+zszIJENM/Trlc7XPWTGrHLm3v/SD/aFTqGM2aYgr6hDew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6338
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2OSBTYWx0ZWRfX3fempOQCadBZ
 f0EERAwVYLWYkrKYHi5SfFqkozcLzPoaXY9BtdmJNS9eq+81zoB53sf+R8+EJVh1a70ALXdkuBJ
 cM8BGs1WwHiDFvfqNbFvfn1D5wKS6Yp7jreU+4QpyQgyEpZWtBJzIP3RHegVx5i5YfgO4Z9L0QI
 aesWPcfLPRQJVwzh0a6OOdTl3QeV8hO1rr5O93BTIb2f7kxpw67pnE7ndyIozitfRkRSukKF3lN
 NbqByUGqh1DpysOC+Zx/vM/8HBwry6Q8Vx438Ur5r0TI3Nt3LNALuaMugaCIXrP+8dSU4NtSrKA
 JFB4HYryW8b+hu/shJOxFk6Gd2zQSy0B5B9AmzbhSeSdXbNjN/z9ii38FsEN7HVmhxMlPNJbgf5
 Ii5rYwa3dn4z5aWwWbR9KQ+KmMTlc/wvPkBixBB5DRawC7XAihWQ/5LJYLWA9PKxyH2fLj9evXu
 SHHiPHuxA319DCGf02Q==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69af1f4e cx=c_pps
 a=YvyvOXr+GU2iduXSFDI6sw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=-rVpDr8tuYWspdZztikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1_L_fepGjLxT8Nxcj_IywOc5K2q8Dljy
X-Proofpoint-ORIG-GUID: kAOIRxzJeZwnK0ftMj5vhlqZ_W0ymEK8
Subject: RE:  [PATCH v5 1/2] hfsplus: refactor b-tree map page access and add
 node-type validation
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090169
X-Rspamd-Queue-Id: 1B0A6240144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79867-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDE3OjE2ICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gT24gTW9uLCAyMDI2LTAzLTAyIGF0IDIzOjI1ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gU2F0LCAyMDI2LTAyLTI4IGF0IDE3OjUzICswNTMwLCBTaGFyZHVsIEJh
bmthciB3cm90ZToNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1
cy9idHJlZS5jIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+ID4gPiBpbmRleCAxMjIwYTJmMjI3Mzcu
Ljg3NjUwZTIzY2Q2NSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL2hmc3BsdXMvYnRyZWUuYw0KPiA+
ID4gKysrIGIvZnMvaGZzcGx1cy9idHJlZS5jDQo+ID4gPiBAQCAtMTI5LDYgKzEyOSwxMTYgQEAg
dTMyIGhmc3BsdXNfY2FsY19idHJlZV9jbHVtcF9zaXplKHUzMg0KPiA+ID4gYmxvY2tfc2l6ZSwg
dTMyIG5vZGVfc2l6ZSwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gY2x1bXBfc2l6ZTsN
Cj4gPiA+IMKgfQ0KPiA+ID4gwqANCj4gPiA+ICsvKiBDb250ZXh0IGZvciBpdGVyYXRpbmcgYi10
cmVlIG1hcCBwYWdlcyAqLw0KPiA+IA0KPiA+IElmIHdlIGhhdmUgc29tZSBjb21tZW50cyBoZXJl
LCB0aGVuIGxldCdzIGFkZCB0aGUgZGVzY3JpcHRpb24gb2YNCj4gPiBmaWVsZHMuDQo+ID4gDQo+
IA0KPiBBY2snZWQuDQo+IA0KPiA+ID4gK3N0cnVjdCBoZnNfYm1hcF9jdHggew0KPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IHBhZ2VfaWR4Ow0KPiA+ID4gK8KgwqDCoMKgwqDCoMKg
dW5zaWduZWQgaW50IG9mZjsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHUxNiBsZW47DQo+ID4gPiAr
fTsNCj4gPiA+ICsNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIE1hcHMgdGhlIHNwZWNpZmljIHBhZ2Ug
Y29udGFpbmluZyB0aGUgcmVxdWVzdGVkIGJ5dGUgb2Zmc2V0DQo+ID4gPiB3aXRoaW4gdGhlIG1h
cA0KPiA+ID4gKyAqIHJlY29yZC4NCj4gPiA+ICsgKiBBdXRvbWF0aWNhbGx5IGhhbmRsZXMgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiBoZWFkZXIgYW5kIG1hcA0KPiA+ID4gbm9kZXMuDQo+ID4gPiAr
ICogUmV0dXJucyB0aGUgbWFwcGVkIGRhdGEgcG9pbnRlciwgb3IgYW4gRVJSX1BUUiBvbiBmYWls
dXJlLg0KPiA+ID4gKyAqIE5vdGU6IFRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgZm9yIGNhbGxp
bmcga3VubWFwX2xvY2FsKGRhdGEpLg0KPiA+ID4gKyAqLw0KPiA+ID4gK3N0YXRpYyB1OCAqaGZz
X2JtYXBfZ2V0X21hcF9wYWdlKHN0cnVjdCBoZnNfYm5vZGUgKm5vZGUsIHN0cnVjdA0KPiA+ID4g
aGZzX2JtYXBfY3R4ICpjdHgsDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1MzIgYnl0ZV9vZmZzZXQpDQo+ID4gPiAr
ew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgdTE2IHJlY19pZHgsIG9mZjE2Ow0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgdW5zaWduZWQgaW50IHBhZ2Vfb2ZmOyAvKiAzMi1iaXQgbWF0aCBwcmV2ZW50cyBM
S1Agb3ZlcmZsb3cNCj4gPiA+IHdhcm5pbmdzICovDQo+ID4gDQo+ID4gRG8gd2UgcmVhbGx5IG5l
ZWQgdGhpcyBjb21tZW50Pw0KPiA+IA0KPiANCj4gQWNrJ2VkLCB3aWxsIHJlbW92ZSBpdC4NCj4g
DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAobm9kZS0+dGhpcyA9PSBIRlNQTFVT
X1RSRUVfSEVBRCkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChu
b2RlLT50eXBlICE9IEhGU19OT0RFX0hFQURFUikgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl9lcnIoImhmc3BsdXM6IGludmFsaWQgYnRy
ZWUgaGVhZGVyDQo+ID4gPiBub2RlXG4iKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVSUl9QVFIoLUVJTyk7DQo+ID4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJlY19pZHggPSBIRlNQTFVTX0JUUkVFX0hEUl9NQVBfUkVDX0lOREVYOw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAobm9kZS0+dHlwZSAhPSBIRlNfTk9ERV9NQVApIHsNCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcHJfZXJyKCJoZnNwbHVzOiBp
bnZhbGlkIGJ0cmVlIG1hcA0KPiA+ID4gbm9kZVxuIik7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFUlJfUFRSKC1FSU8pOw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZWNfaWR4ID0gSEZTUExVU19CVFJFRV9NQVBfTk9ERV9SRUNfSU5E
RVg7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiArDQo+ID4gPiArwqDCoMKgwqDCoMKg
wqBjdHgtPmxlbiA9IGhmc19icmVjX2xlbm9mZihub2RlLCByZWNfaWR4LCAmb2ZmMTYpOw0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFjdHgtPmxlbikNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCj4gPiA+ICsNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGlmICghaXNfYm5vZGVfb2Zmc2V0X3ZhbGlkKG5vZGUsIG9mZjE2KSkNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRUlPKTsN
Cj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGN0eC0+bGVuID0gY2hlY2tfYW5kX2NvcnJl
Y3RfcmVxdWVzdGVkX2xlbmd0aChub2RlLCBvZmYxNiwNCj4gPiA+IGN0eC0+bGVuKTsNCj4gPiA+
ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChieXRlX29mZnNldCA+PSBjdHgtPmxlbikNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHBhZ2Vfb2ZmID0gb2ZmMTYgKyBub2Rl
LT5wYWdlX29mZnNldCArIGJ5dGVfb2Zmc2V0Ow0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgY3R4LT5w
YWdlX2lkeCA9IHBhZ2Vfb2ZmID4+IFBBR0VfU0hJRlQ7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBj
dHgtPm9mZiA9IHBhZ2Vfb2ZmICYgflBBR0VfTUFTSzsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoHJldHVybiBrbWFwX2xvY2FsX3BhZ2Uobm9kZS0+cGFnZVtjdHgtPnBhZ2VfaWR4XSk7
DQo+ID4gDQo+ID4gVGhpcyBwYXR0ZXJuIG1ha2VzIG1lIHJlYWxseSBuZXJ2b3VzLiA6KSBXaGF0
IGlmIHdlIGNhbiBjYWxjdWxhdGUgdGhlDQo+ID4gc3RydWN0DQo+ID4gaGZzX2JtYXBfY3R4ICpj
dHggaW4gdGhpcyBmdW5jdGlvbiBvbmx5LiBBbmQsIHRoZW4sIGNhbGxlciB3aWxsIHVzZQ0KPiA+
IGttYXBfbG9jYWxfcGFnZSgpL2t1bm1hcF9sb2NhbCgpIGluIG9uZSBwbGFjZS4NCj4gPiANCj4g
DQo+IEdvb2QgcG9pbnQuIEhpZGluZyB0aGUga21hcCBpbnNpZGUgdGhlIGhlbHBlciB3aGlsZSBm
b3JjaW5nIHRoZSBjYWxsZXINCj4gdG8ga3VubWFwIGlzIGEgZGFuZ2Vyb3VzIHBhdHRlcm4uDQo+
IEluIHY2LCBJIHdpbGwgcmVuYW1lIHRoZSBoZWxwZXIgdG8gaGZzX2JtYXBfY29tcHV0ZV9jdHgo
KS4gSXQgd2lsbA0KPiBzb2xlbHkgcGVyZm9ybSB0aGUgb2Zmc2V0IG1hdGggYW5kIHBvcHVsYXRl
IHRoZSBjdHguIFRoZSBjYWxsZXIgd2lsbA0KPiB0aGVuIGV4cGxpY2l0bHkgbWFwIGFuZCB1bm1h
cCB0aGUgcGFnZSwgZW5zdXJpbmcgdGhlIGxpZmVjeWNsZSBpcw0KPiBwZXJmZWN0bHkgY2xlYXIu
DQo+IA0KDQpQb3RlbnRpYWxseSwgdGhpcyBtZXRob2QgY2FuIHJldHVybiBwb2ludGVyIG9uIG1l
bW9yeSBwYWdlIGFuZCBjYWxsZXIgY2FuIGRvDQprbWFwX2xvY2FsX3BhZ2UoKS9rdW5tYXBfbG9j
YWwoKS4NCg0KPiANCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArLyoqDQo+ID4gPiArICogaGZz
X2JtYXBfdGVzdF9iaXQgLSB0ZXN0IGEgYml0IGluIHRoZSBiLXRyZWUgbWFwDQo+ID4gPiArICog
QG5vZGU6IHRoZSBiLXRyZWUgbm9kZSBjb250YWluaW5nIHRoZSBtYXAgcmVjb3JkDQo+ID4gPiAr
ICogQGJpdF9pZHg6IHRoZSBiaXQgaW5kZXggcmVsYXRpdmUgdG8gdGhlIHN0YXJ0IG9mIHRoZSBt
YXAgcmVjb3JkDQo+ID4gDQo+ID4gVGhpcyBzb3VuZHMgc2xpZ2h0bHkgY29uZnVzaW5nLiBJcyBp
dCBiaXQgc3RhcnRpbmcgZnJvbSB0aGUgd2hvbGUgbWFwDQo+ID4gb3IgZnJvbQ0KPiA+IHBhcnRp
Y3VsYXIgbWFwJ3MgcG9ydGlvbj8NCj4gPiANCj4gDQo+IFRoZSBiaXRfaWR4IHBhc3NlZCB0byB0
aGVzZSBoZWxwZXJzIGlzIHN0cmljdGx5IHJlbGF0aXZlIHRvIHRoZSBzdGFydA0KPiBvZiB0aGUg
Y3VycmVudCBtYXAgbm9kZSdzIHJlY29yZC4NCg0KU291bmRzIGdvb2QuDQoNCj4gDQo+ID4gPiAr
ICoNCj4gPiA+ICsgKiBSZXR1cm5zIDEgaWYgc2V0LCAwIGlmIGNsZWFyLCBvciBhIG5lZ2F0aXZl
IGVycm9yIGNvZGUgb24NCj4gPiA+IGZhaWx1cmUuDQo+ID4gPiArICovDQo+ID4gPiArc3RhdGlj
IGludCBoZnNfYm1hcF90ZXN0X2JpdChzdHJ1Y3QgaGZzX2Jub2RlICpub2RlLCB1MzIgYml0X2lk
eCkNCj4gPiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaGZzX2JtYXBfY3R4IGN0
eDsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHU4ICpkYXRhLCBieXRlLCBtOw0KPiA+IA0KPiA+IEkg
dGhpbmsgd2UgY2FuIHVzZSBibWFwIGluc3RlYWQgb2YgZGF0YS4gVGhlIGJtYXAgbmFtZSBjYW4g
c2hvdyB0aGUNCj4gPiBuYXR1cmUgb2YNCj4gPiBkYXRhIGhlcmUuIERvIHlvdSBhZ3JlZT8NCj4g
PiANCj4gPiBJIGNhbiBmb2xsb3cgd2hhdCBieXRlIG5hbWUgbWVhbnMuIEZyYW5rbHkgc3BlYWtp
bmcsIEkgZG9uJ3Qga25vdyB3aHkNCj4gPiBtIG5hbWUgaXMNCj4gPiB1c2VkLiA6KQ0KPiA+IA0K
PiANCj4gQWNrJ2VkLiBGb3IgdjYsIEkgd2lsbCB1c2UgYm1hcCwgbWFzayAoaW5zdGVhZCBvZiBt
KS4NCj4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmVzOw0KPiA+IA0KPiA+IEkgYW0gbm90
IHN1cmUgdGhhdCB5b3UgYXJlIHJlYWxseSBuZWVkIHRoaXMgdmFyaWFibGUuDQo+ID4gDQo+IA0K
PiBBY2snZWQuDQo+IA0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgZGF0YSA9IGhmc19i
bWFwX2dldF9tYXBfcGFnZShub2RlLCAmY3R4LCBiaXRfaWR4IC8gOCk7DQo+ID4gDQo+ID4gV2hh
dCdzIGFib3V0IEJJVFNfUEVSX0JZVEUgaW5zdGVhZCBvZiBoYXJkY29kZWQgOD8NCj4gPiANCj4g
DQo+IEFjaydlZC4NCj4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGRhdGEpKQ0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKGRhdGEp
Ow0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgYnl0ZSA9IGRhdGFbY3R4Lm9mZl07DQo+
ID4gPiArwqDCoMKgwqDCoMKgwqBrdW5tYXBfbG9jYWwoZGF0YSk7DQo+ID4gPiArDQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqAvKiBJbiBIRlMrIGJpdG1hcHMsIGJpdCAwIGlzIHRoZSBNU0IgKDB4ODAp
ICovDQo+ID4gPiArwqDCoMKgwqDCoMKgwqBtID0gMSA8PCAofmJpdF9pZHggJiA3KTsNCj4gPiAN
Cj4gPiBJIGFtIG5vdCBzdXJlIHRoYXQgdGhpcyBjYWxjdWxhdGlvbiBpcyBjb3JyZWN0LiBCZWNh
dXNlIGJpdF9pZHggaXMNCj4gPiBhYnNvbHV0ZQ0KPiA+IGluZGV4IGluIHRoZSB3aG9sZSBtYXAg
YnV0IHRoaXMgb3BlcmF0aW9uIGlzIGluc2lkZSBvZiBwYXJ0aWN1bGFyDQo+ID4gcG9ydGlvbiBv
ZiB0aGUNCj4gPiBtYXAuIEFyZSB5b3Ugc3VyZSB0aGF0IHRoaXMgbG9naWMgd2lsbCBiZSBjb3Jy
ZWN0IGlmIHdlIGhhdmUgYi10cmVlDQo+ID4gbWFwIGluDQo+ID4gc2V2ZXJhbCBub2Rlcz8NCj4g
PiANCj4gDQo+IEkgY29tcGxldGVseSB1bmRlcnN0YW5kIHRoZSBjb25jZXJuIGhlcmUsIGFuZCB5
b3UgYXJlIHJpZ2h0IHRoYXQgaWYNCj4gYml0X2lkeCB3ZXJlIHRoZSBhYnNvbHV0ZSBpbmRleCBh
Y3Jvc3MgdGhlIGVudGlyZSBCLXRyZWUsIHRoaXMgYml0d2lzZQ0KPiBtYXRoIHdvdWxkIGJyZWFr
IHdoZW4gY3Jvc3Npbmcgbm9kZSBib3VuZGFyaWVzLg0KPiANCj4gSG93ZXZlciwgdGhlIGFyY2hp
dGVjdHVyZSBoZXJlIHJlbGllcyBvbiBhIHNlcGFyYXRpb24gb2YgY29uY2VybnM6DQo+IGhmc19i
bWFwX2ZyZWUoKSBoYW5kbGVzIHRyYXZlcnNpbmcgdGhlIG1hcCBjaGFpbiwgd2hpbGUNCj4gaGZz
X2JtYXBfY2xlYXJfYml0KCkgb3BlcmF0ZXMgc3RyaWN0bHkgb24gYSBzaW5nbGUgbm9kZS4NCj4g
SW4gaGZzX2JtYXBfZnJlZSgpLCB0aGUgIndoaWxlIChuaWR4ID49IGxlbiAqIDgpIiBsb29wIGNv
bnRpbnVvdXNseQ0KPiBzdWJ0cmFjdHMgdGhlIHByZXZpb3VzIG5vZGVzJyBjYXBhY2l0aWVzIChu
aWR4IC09IGxlbiAqIDgpIGFzIGl0DQo+IHRyYXZlcnNlcyB0aGUgY2hhaW4uIEJ5IHRoZSB0aW1l
IGl0IGNhbGxzIGhmc19ibWFwX2NsZWFyX2JpdChub2RlLA0KPiBuaWR4KSwgdGhlIGluZGV4IGlz
IHN0cmljdGx5IHJlbGF0aXZlIHRvIHRoZSBzdGFydCBvZiB0aGF0IHNwZWNpZmljDQo+IGhmc19i
bm9kZSdzIG1hcCByZWNvcmQuIEJlY2F1c2UgdGhlIGluZGV4IGlzIHJlbGF0aXZlIHRvIHRoZSBu
b2RlLCB0aGUNCj4gYml0d2lzZSBtYXRoIHNhZmVseSBjYWxjdWxhdGVzIHRoZSBjb3JyZWN0IGJ5
dGUgYW5kIGJpdC4NCj4gDQo+IFRvIGVuc3VyZSBmdXR1cmUgZGV2ZWxvcGVycyBkbyBub3QgbWlz
dGFrZSB0aGlzIGZvciBhbiBhYnNvbHV0ZSBpbmRleA0KPiBhbmQgbWlzdXNlIHRoZSBBUEksIEkg
d2lsbCByZW5hbWUgdGhlIGFyZ3VtZW50IGZyb20gYml0X2lkeCB0bw0KPiBub2RlX2JpdF9pZHgg
KG9yIHJlbGF0aXZlX2lkeCkgaW4gdjYgYW5kIGV4cGxpY2l0bHkgZG9jdW1lbnQgdGhhdCBpdA0K
PiBtdXN0IGJlIGJvdW5kZWQgYnkgdGhlIG5vZGUncyByZWNvcmQgbGVuZ3RoLg0KDQpNYWtlcyBz
ZW5zZS4NCg0KPiANCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHJlcyA9IChieXRlICYgbSkgPyAxIDog
MDsNCj4gPiANCj4gPiBZb3UgY2FuIHNpbXBseSByZXR1cm4gdGhpcyBzdGF0ZW1lbnQuDQo+IA0K
PiBBY2snZWQuDQo+IA0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJu
IHJlczsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArLyoqDQo+ID4gPiArICogaGZzX2JtYXBf
Y2xlYXJfYml0IC0gY2xlYXIgYSBiaXQgaW4gdGhlIGItdHJlZSBtYXANCj4gPiA+ICsgKiBAbm9k
ZTogdGhlIGItdHJlZSBub2RlIGNvbnRhaW5pbmcgdGhlIG1hcCByZWNvcmQNCj4gPiA+ICsgKiBA
Yml0X2lkeDogdGhlIGJpdCBpbmRleCByZWxhdGl2ZSB0byB0aGUgc3RhcnQgb2YgdGhlIG1hcCBy
ZWNvcmQNCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCAtRUFMUkVB
RFkgaWYgYWxyZWFkeSBjbGVhciwgb3IgbmVnYXRpdmUNCj4gPiA+IGVycm9yIGNvZGUuDQo+ID4g
PiArICovDQo+ID4gPiArc3RhdGljIGludCBoZnNfYm1hcF9jbGVhcl9iaXQoc3RydWN0IGhmc19i
bm9kZSAqbm9kZSwgdTMyIGJpdF9pZHgpDQo+ID4gDQo+ID4gSSBoYXZlIHRoZSBzYW1lIHJlbWFy
a3MgYW5kIGNvbmNlcm5zIGZvciB0aGlzIG1ldGhvZCB0b28uIFBsZWFzZSwgc2VlDQo+ID4gbXkg
cmVtYXJrcw0KPiA+IGFib3ZlLg0KPiA+IA0KPiANCj4gQWRkcmVzc2VkIGFib3ZlLg0KPiANCj4g
PiA+ICt7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaGZzX2JtYXBfY3R4IGN0eDsNCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoHU4ICpkYXRhLCBtOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKg
wqDCoMKgZGF0YSA9IGhmc19ibWFwX2dldF9tYXBfcGFnZShub2RlLCAmY3R4LCBiaXRfaWR4IC8g
OCk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKGRhdGEpKQ0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSKGRhdGEpOw0KPiA+ID4gKw0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgbSA9IDEgPDwgKH5iaXRfaWR4ICYgNyk7DQo+ID4gPiArDQo+
ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIShkYXRhW2N0eC5vZmZdICYgbSkpIHsNCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrdW5tYXBfbG9jYWwoZGF0YSk7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FQUxSRUFEWTsNCj4gPiANCj4g
PiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoaXMgZXJyb3IgY29kZToNCj4gPiANCj4gPiAjZGVmaW5l
wqBFQUxSRUFEWcKgwqDCoMKgwqDCoMKgwqAxMTTCoMKgwqDCoMKgLyogT3BlcmF0aW9uIGFscmVh
ZHkgaW4gcHJvZ3Jlc3MgKi8NCj4gPiANCj4gPiBJdCBzb3VuZHMgbW9yZSBsaWtlIC1FSU5WQUwu
DQo+ID4gDQo+IA0KPiBBZ3JlZWQsIEkgd2lsbCBjaGFuZ2UgdGhlIGVycm9yIGNvZGUgZnJvbSAt
RUFMUkVBRFkgdG8gLUVJTlZBTCBpbiB2Ni4NCj4gDQo+IE9uZSBhZGRpdGlvbmFsIG5vdGUgZm9y
IHY2OiBJIHJlYWxpemVkIHRoYXQgaW50cm9kdWNpbmcNCj4gaGZzX2JtYXBfdGVzdF9iaXQoKSBp
biBQYXRjaCAxIHdpdGhvdXQgY2FsbGluZyBpdCB1bnRpbCBQYXRjaCAyDQo+IHRyaWdnZXJzIGEg
LVd1bnVzZWQtZnVuY3Rpb24gY29tcGlsZXIgd2FybmluZywgd2hpY2ggYnJlYWtzIGdpdCBiaXNl
Y3QNCj4gY2xlYW5saW5lc3MuIFRvIGZpeCB0aGlzLCBJIHdpbGwgbW92ZSB0aGUgaW50cm9kdWN0
aW9uIG9mDQo+IGhmc19ibWFwX3Rlc3RfYml0KCkgaW50byBQYXRjaCAyIHdoZXJlIGl0IGlzIGFj
dHVhbGx5IGNvbnN1bWVkIGJ5IHRoZQ0KPiBtb3VudC10aW1lIGNoZWNrLiBoZnNfYm1hcF9jbGVh
cl9iaXQoKSB3aWxsIHJlbWFpbiBpbiBQYXRjaCAxIHNpbmNlIGl0DQo+IGlzIGltbWVkaWF0ZWx5
IGNvbnN1bWVkIGJ5IGhmc19ibWFwX2ZyZWUoKS4NCj4gDQo+IA0KDQpPSy4gTWFrZXMgc2Vuc2Uu
DQoNClRoYW5rcywNClNsYXZhLg0K

