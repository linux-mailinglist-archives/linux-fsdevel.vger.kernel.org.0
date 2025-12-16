Return-Path: <linux-fsdevel+bounces-71495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A8CC51A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 21:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 155393099BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CE337692;
	Tue, 16 Dec 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPXrG3TV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B9335BAD;
	Tue, 16 Dec 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765916941; cv=fail; b=rsSQ4TQp1tMRc6Qp0LxeR1s5+5t3W5U68Lq1ZrzV7F4DP4AGAOTAQOPga7J/99P7i/jFwDpzNgMexQZsC3AAfJHYZ7veQu33rq6rXHqL+LebMN1BWWkejGRnW6zjF8dWbqxSAJ9HAzIqJF8+cG53v4bgKNMhr9KSlGvQydelC+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765916941; c=relaxed/simple;
	bh=P5MPgkWsNiu37d4Kqbi6bETfH3VqNfugTedFDHidvx0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kNP6fHP4YROpzMijRnvUaNcTVTKVUNaBLJmI1vX73U+U51+5DH3ZqgMUjMuPnkUZjGEXyZ7y9d3t2Isu0zpmtd6K80vPNawFwYn/aedkSe7aOEcqLl0EvlipLx7BkDvbUzquKx8Ui6P0AEhlur+g1ouv2/odwF5le7MtVgRrBIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPXrG3TV; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCEP9o032017;
	Tue, 16 Dec 2025 20:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=P5MPgkWsNiu37d4Kqbi6bETfH3VqNfugTedFDHidvx0=; b=WPXrG3TV
	jS4KghiXpTnm7XflidsoRYhkqu6uo1fwxV6Wv30OoSDspsF4RI+RgzfTCdEAoIwb
	BK6b8QSb49RhMJKcKGB5DhatW5Br4kQ+7MnmqB2UYNnv+uIPdh4u2mGVgBD4TUE/
	tsmUfAt8OsYmoFN77iFtOTcI9Kfosh3LSKz7zGgNZsVp7kccXeGPgHnUAU+KWnxk
	fWVw4nOX+qTFfgvppEZ685qJhsXHdDEzJzo94GzaNExAUFNE1co0kTUD7hmkztYU
	CJEEtdIBv2w+IOMNfWUE315J/g2JwJahx78rVeOOa9oxyP9MPjkwCjxuCwLxQN6V
	0svRoPdYXiC3pQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1gn0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 20:28:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNhRUwqXV38Tsfufe/FDGn5iDw0dxwG7r5he7Giv+VGf68Ra9h+Ff9N01wwSYkVIbgweb32ZXawohRYB9C3G6v9z5mQSsDDCFFHMXc2EczV9FyT0pGDT2HawuKWYnebxRCy9btWWmKNZl8PBjm2LnfGY+mTbs74rruKvkDx6bYvFm0gRoyBYPRg54G0gMITwpVVEVTuZ3XmKmm5LtzkooDMDl/nQv2TZKPC+MBhH7dLwvQl1N0f5oHRM0GeVuBwUfAiwlqvovb90X0pcFVSEE63i7RoPG3dC3hjojz/7aOPhv7g5dh6DPZ7fg07AUAVog+GXrTnzOhO+m7FXYSmvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5MPgkWsNiu37d4Kqbi6bETfH3VqNfugTedFDHidvx0=;
 b=ZJedRLr7Vy6guOSNH/aEDQDmPcxZQTsnUzZU5LsVyE7iyezWgIUEeWgUgOAuX0mwkmM5xtGnAFWI6wINPICIThgkYb4WxywvbSuSIcfnl9xRfUJTcFsqFZMa5Rp5QGvoCga/tXHnoKgL/x4Kp6LJRb3Yy/PBMFXiH5JP6eic/r13/062xFMkLBUA7WYz893MSMsd00wR2Z1t602sR+ECUeJ27cqqTgKZqmoY9CIoOCOmnp2IcKeqpkxDKX8wmA3DoLeLqCQpebHFxRMUcv/xOYTNpKnpam25dhjVI4D9vbkMOynOLxUp3R8xeaj9D9evirqKCa094lou0cygg3lxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6442.namprd15.prod.outlook.com (2603:10b6:a03:576::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 20:28:44 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 20:28:44 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "zippel@linux-m68k.org" <zippel@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>
CC: "akpm@osdl.org" <akpm@osdl.org>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
Thread-Index: AQHcblGCaMrmGlW/VE+mHTjh/7eAsbUkuIIA
Date: Tue, 16 Dec 2025 20:28:44 +0000
Message-ID: <1e0095625a71cca2ff25c2946fd6532c28cfd1b0.camel@ibm.com>
References: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
		 <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
	 <a817a3a65e5a0fe33dbdf1322f4909c3ff1edfcc.camel@mpiricsoftware.com>
In-Reply-To:
 <a817a3a65e5a0fe33dbdf1322f4909c3ff1edfcc.camel@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6442:EE_
x-ms-office365-filtering-correlation-id: 67a6e63c-8d64-4e43-571f-08de3ce1b5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXM1WlhrOFcxaWxCUmYvTzBLS1VYUnNodWNtUU9pMWwyTDJNRGNJMDJIMXJQ?=
 =?utf-8?B?eStPTS8vQ0V4THBNa0c2djVCYm1MaU92dUhFY0d0MXBnMkZRTnJ2Vzd3QnFr?=
 =?utf-8?B?eGJndjRkZlVDTkZHdFVtMmRIYk9MVTlIcnJmeWNwT0NzV0U3SjVmaU5nV1BH?=
 =?utf-8?B?a1d6eXZOblR3R3pPVy9mRjFEYzhoYlJiY3pReHlQRm5rMXJSOWlxZjJVL2o0?=
 =?utf-8?B?V3VTQWRRRzZZYUNUTS9hVkp2akRjU3dhVzRMS1ZJRGdJbG5RNXlGd1hFOHl5?=
 =?utf-8?B?aWxKMnNvYlRYcVBCZ3FxSzZTTlczbVljenYzZW84K3RoQ0FtQ3BRa1hYUW11?=
 =?utf-8?B?ZkdTZmlGL0V2ZDlnZ1VSRnVyZDZKb3FvVHZJcU1vMU5ycHJxcEU3eEZsTEU3?=
 =?utf-8?B?aEE3QW4zSXh5cFhiRDVOOFdpQkNPMEJDTnpJb2I4T1MzSEJoNFhKQytXZjNU?=
 =?utf-8?B?Z0VON1pBM1Qya3NQWldxNkFCU3MxQldDRnBVTzAvQWhHcVZ0TEQxK001U1Ry?=
 =?utf-8?B?SmlsU1dmdzhmT3Y3ZTlnUkhxZnBmYWxQZHBQWTdkOURnaWFtZGdLUWZabFUz?=
 =?utf-8?B?b091cnBtZERDRllyVjA4Z2w0MGdHOFdSRk9LUzZvZXhxZGRDVVR3dm9ORjNv?=
 =?utf-8?B?MmJNTmxnTGxZMGM1VTYrd2xKbG0waitrcUZjUTRpNDJlRUprTys3UGZDbmR6?=
 =?utf-8?B?eVNSV0cxTk1zZ0l3bExBc24vUWZKQUR3c0lybHJmODN4R2hPWDZBbUFwZUd2?=
 =?utf-8?B?cDdsOWswVjlNQTF0QnczRDdEMHFoYi9MT0NPRy81VHdqSXNnK3BtTlN0Y1lN?=
 =?utf-8?B?bjZIR1N1SmlKQzNUTHZxcGhiTjBPZ1E2TFNBV0lSVVFBd2RnTXN6MHhEYUVp?=
 =?utf-8?B?eU02MGREZlN1aWNMUHp5MjF5d21RcnArelJVSFBjY1FPN1IrZlo1NWRhR0c2?=
 =?utf-8?B?a1hTZzBpdVJDczdmb0dHZC9GcFgyazEvTXRTT2FpT2FzMVBkei9mdllTZ0Fo?=
 =?utf-8?B?VmJ3QllKbE55UjZ2dmtaVGhtYU9lNEJlYlM0Sk9QOS83QW1SU3NFVFpTNGY0?=
 =?utf-8?B?L0M5VElVTHBCWnowVWI2cU9sNS9hNlRDZFAyeGgyRkNEaElobHBReVAyOXQy?=
 =?utf-8?B?MXlDOE1xVytBKzZrNnV1UnEwUkNnRnlheEtFQ1BxWjJ4Uit0bnMwWEVXUk14?=
 =?utf-8?B?Qjk2NElvMitHelRaTmtRWG9Rc1A4SVJKMmtmVWpTcDV0RzR5ZXkzQnNiM0ls?=
 =?utf-8?B?T253YU1xVVNsZ091N2FaM3BETkF5NEpsVGNpMThqMU8raUZDaDFncVVnZjdx?=
 =?utf-8?B?ZnpFcnBBbFBFM3dEckJ4dVl1N3kxUUp3MERCU24zZFRaNUZGWEY3bTBlMmRv?=
 =?utf-8?B?clErdStOK1BvQWV4cGQxSmI2TTVSMDZWYWtWZ0xweHlId0JObWhpSlAwUGpT?=
 =?utf-8?B?TkJYVjdBd0VaK0ZxbkhVQmg0MXlNeGZWc04zc1NCaklpcHMxK256bDdxdkFu?=
 =?utf-8?B?VEZWdW9PMDYvemd5MXNMOUVxRG1sMGxSQlVVRDE0UXBHckxpaWFRYnRMcUZ2?=
 =?utf-8?B?NzV2S3h0UWQ4K2VrNDRuU1pxbUxnTnBsYWRiUDJOT3pCZTVuUlVVV1hTS0V6?=
 =?utf-8?B?ZWFVeGF5Q2VyU2QzNG4zZG1RS2JGeFJwbitMVml2YXJNMm1ReDNpd2IzUk1q?=
 =?utf-8?B?UnRyUVVsa3NxR0c3NFp5ZGh5MUdHaEVXTVlLMGx6M1VqbUhWUTNpNmE0d1Bu?=
 =?utf-8?B?WmxXNHZDdEFjOGxTUkVIQW9JV3M5a2JYTzh5Z1pWSmF2b2Q1ME94eWZWWjMv?=
 =?utf-8?B?S0lORG5wWHJ3ZEhIdEZ2L3hIVE44TEdGZjZ3NGVNUmdMQjFCc2NCYnMrRjlu?=
 =?utf-8?B?emJyMk85MkNmYW5GbW9TSWZGMG4yT1dZR09seU9zblNZbWFUNnpwUjBZUjRi?=
 =?utf-8?B?UnVWUUluekpndnZ0TXlRWDQwQWJIUDIyR0poMGw1anFlbnFRWG5QNXhJYXNn?=
 =?utf-8?B?bU5zUGRqc2JRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K056YzVIUHhncW02YS91RE9OVFhrNTZLT3g3RXZiTnh2aGdOMDRKMitwaHBM?=
 =?utf-8?B?eXlPd056YnpvVGtPbFhEUUtoTW5EeGVnVFIzRmZGc2pYSUh2YzVJcnNHNSsr?=
 =?utf-8?B?L2x3cll2ckpucHRBQk1DT3hMY1ZZRE9yOXR0L0xNdVhrdXRUa3J4QVdGc3Bs?=
 =?utf-8?B?ZlpsYk1jQU13V3dTUDMwRkNDZmFEcUdYN1BVKzNNL3Rya0NtODh5c1JRRCtB?=
 =?utf-8?B?UjZOUzBobWtFREVVMXFla3BGanNMMG5UM2hIU3gxZkJyVzFQaXdMeEwzVjZ2?=
 =?utf-8?B?dCtQejBsM1ZsbkZrK0JqekRYYnBGRXhsTzhod2xSOUx2eVNxSmU2NjMwUDE2?=
 =?utf-8?B?T2VHMnQ0endNdzZUeEdtK05JTmV4ZWk3WWk5ZWlidUptamFEN0JDdDdaYS8x?=
 =?utf-8?B?elZMQ3VoK0tyK0hDTkFyb2dtRG9nVExSdWxNd05FQWZ2dUpkYTFvZXNmM1Jy?=
 =?utf-8?B?MnZUVzFLKzJNZXhYRy9iK1U3NDlGWUhpRGFXYytpVGYrYlZxUElYM1AzMUJV?=
 =?utf-8?B?bVVMK2ZVb1UrRzJkZUNabjlwWHFIT05qQ0JTdkMrMkxGSHRKdi9jUkR3WDc0?=
 =?utf-8?B?NEpuK1JYTFl4bW9TanhiTHJuVWdBSXBFTjVMKzdyWEdKaW1GeGR6ajAwTHJt?=
 =?utf-8?B?WXFpMEEwNTZlelUzdEZwY25meWVHc3FkNkt0NU9ZNXpQRHBKNGxWcE4yVm1V?=
 =?utf-8?B?eDRVY2xqY01DQlN0TDl5UWNnQVpianZFd21aTXZvcE9ZYUw2Zy82aHUwVGNh?=
 =?utf-8?B?Tmo2cmY1OFRIN2FIUHA4NmF6NWdTN0xXRzU1MWJYdTRYWDZJNkhuc2Qwajdu?=
 =?utf-8?B?RGp2emp3VC9oekg4aWJCa3dFdXUwV0xuWmJxcVJ2Zk9VQU1NZVVVV2ZLekRW?=
 =?utf-8?B?YVFIbVBDK2QvL2JDSVpzZkw2elhZQ3FlQ25QWXUwLzduT3pqRUtyb3ZjbXda?=
 =?utf-8?B?V2JQVnljQ05YOXFJOXRYU1UzU2g4Q0xBdVVIaEVXWVkwQ2FoUjBlRDdBMll1?=
 =?utf-8?B?YW03Njlld3FtcmkwOG1uMTlxY0FkTnV2bUFCdWc0N1J2QzBHUzhjQWFlVjhJ?=
 =?utf-8?B?b1FnYnEzUG5IM0FXYitoOFpWYzYrdFIrU1VsbHp1UTlnb2ZUTUpDTzNydkdU?=
 =?utf-8?B?VG1rZjVBeUpxTHd2SlhIaThFcFZkUUxUWnlsL2QySWE1M3JkZDdTck9TTmRp?=
 =?utf-8?B?azVwUktRTFA3Y2ppd2F4aEo4UTVVK0x0cUkrTGpqUDdNYjNxbEU0N21kOCtQ?=
 =?utf-8?B?eXRja0lWTy9SdW8vQU4xbmZ4b0JSaFU0eWdKTlFlL3BXNU9vWmV2bStsTlVl?=
 =?utf-8?B?SUU0bm9mNHlGSnBFNTQ2VGdDeVByRzg3b0t5MDd0NlNzd2hybVJkZTVPQVdE?=
 =?utf-8?B?cUhBVFdUc3FGU0RHV0RhMkNzbnQwNnk1U0RXK2toZDFlN1JLc25ya3lLcFJu?=
 =?utf-8?B?RDFkVzh1RjMyYTI1YWYzL0F2eWNLRTl6a0tGWUN2WmJRY2s2bmJza2lBdXNP?=
 =?utf-8?B?ZEFnRWw2NTB3cEsxdWF0dDN2aXZXcW1IOFlxK2N1ZTZKdm5kMGdOa0Fpd2p5?=
 =?utf-8?B?Z2swNzZQbVc5VHFJRS9NZXYwNkJneGhlWlIrRHhrZmUvOFdDY2VwdFZGa3Fx?=
 =?utf-8?B?c3JhMEpMUmRlRE9TbStZS2tlRVFkdEhPTDFGR0wvTkh4V3BWZHpVSUp6TGVy?=
 =?utf-8?B?UkYzYmliU3I2cERCRDUrVkRtR2lNYXZ2a01QM1dpRlY5TjcwM0NuNG1yZjVH?=
 =?utf-8?B?VDVneUZZRk9wQzErb2I1Mjdybmd6TjFwSkhZSXFObCtvdUlMcGJMcU9ib0l2?=
 =?utf-8?B?VDlFV0NuMHY1TXRzcGJyWFlrMDU3TUMzdHdTNWROcklHa1F4bkFML20vSjMv?=
 =?utf-8?B?N2gxakI2WFExRGI0Tkw2QitTOGZvL0JJQmlWNlBnSGlGS3V0Tjg4RXB2WUQz?=
 =?utf-8?B?dXd3RTArZzRZVENxR2Z4dm0zMFYxUjhNWjdJS0g1TlF1QzJVT2Y2cG1UU0Ra?=
 =?utf-8?B?UFdJaHl4KzByTHUzMnk4STB6N1hnMFNhODEvTW81bzdKOFNCcnRaeG1JSjEr?=
 =?utf-8?B?OVdrOHIrcEhuN3JlbDJnN1VwNzZaUVhvKzNRdmxwYVRiSkkrWUFvTVBzZk5Y?=
 =?utf-8?B?OE9NYlY3WlBQZVNPOXRnKzRNUVFURm9tUjhsVHFWSWtQTUllUldiUStCdEFI?=
 =?utf-8?Q?mWqqIR27rP08IauyaeK5afc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B6AE3EBB0BE0428F86B2B76A10BCA4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a6e63c-8d64-4e43-571f-08de3ce1b5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 20:28:44.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fWThKAtyqZXxdpYHLcVkBDRVc5vBoSAIYCQ1PzZGwI4I84CSReyjs8eugj6NMippgX2xpz3Wzb6SBPYWa2oGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6442
X-Proofpoint-GUID: 01joQXT-k4m0MU1irzHzw_61IaWznvS3
X-Proofpoint-ORIG-GUID: 01joQXT-k4m0MU1irzHzw_61IaWznvS3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXyYArVZTRykMl
 yYM559T4q9Qu95pb4HJ71Op46elpPJ8gkkJo+oRbNJBIPnt/JHYgrYiaBdA4pbwZ/4NJEWW/uD7
 9Z7tc4vcSkH4BgE+GKKZs9JuxCIJ6B7rZxX7nLFodxCg5T2b3EymB40eVHSgDeFc8lny3wOaVYF
 SLo7v9TQ/vZ/qj5Wn5YdmFJnDdH3RhgR1aTlY2mk9Xz118IcoXCCWbm8TFqrFxTwQw1BjTz5Kv6
 dgLBA8QNQINywNw634PzgcMvEIND4b4cYi++mImDoh7sc6il/iyyjupZwzgWHBTm7JoMEojke5u
 x5S7X6c+MDKdOHRdoTCClh4fqDBR64gojX/54iZx+lxtvFsgYuIdUH0QzKRkV8C3xsYgAdfPT78
 MPiSpKC/san110eYBMHVWD7pQkc21g==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6941c102 cx=c_pps
 a=oJ9tI0XfeScUaspqi3eqJg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8
 a=YWOk6ECHN80OajCZ4W0A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
Subject: RE:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

SGkgU2hhcmR1bCwNCg0KT24gVHVlLCAyMDI1LTEyLTE2IGF0IDExOjMxICswNTMwLCBTaGFyZHVs
IEJhbmthciB3cm90ZToNCj4gT24gTW9uLCAyMDI1LTEyLTE1IGF0IDE5OjI5ICswMDAwLCBWaWFj
aGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gRnJhbmtseSBzcGVha2luZywgSSBkb24ndCBzZWUg
dGhlIGZpeCBoZXJlLiBZb3UgYXJlIHRyeWluZyB0byBoaWRlDQo+ID4gdGhlIGlzc3VlIGJ1dA0K
PiA+IG5vdCBmaXggaXQuIFRoaXMgaXMgc2l0dWF0aW9uIG9mIHRoZSB3cm9uZyBjYWxsIGJlY2F1
c2Ugd2Ugc2hhcmluZw0KPiA+IGVycm9yIG1lc3NhZ2UNCj4gPiBhbmQgY2FsbCBXQVJOX09OKCkg
aGVyZS4gQW5kIHRoZSBjcml0aWNhbCBxdWVzdGlvbiBoZXJlOiB3aHkgZG8gd2UNCj4gPiBjYWxs
DQo+ID4gaGZzX2Jub2RlX2NyZWF0ZSgpIGZvciBhbHJlYWR5IGNyZWF0ZWQgbm9kZT8gSXMgaXQg
aXNzdWUgb2YgdHJlZS0NCj4gPiA+IG5vZGVfaGFzaD8gT3INCj4gPiBzb21ldGhpbmcgd3Jvbmcg
d2l0aCBsb2dpYyB0aGF0IGNhbGxzIHRoZSBoZnNfYm5vZGVfY3JlYXRlKCk/IFlvdQ0KPiA+IGRv
bid0IHN1Z2dlc3QNCj4gPiBhbnN3ZXIgdG8gdGhpcyBxdWVzdGlvbihzKS4gSSd2ZSB0cmllZCB0
byBkZWJ1ZyBsaWtld2lzZSBpc3N1ZSB0d28NCj4gPiBtb250aHMgYWdvDQo+ID4gYW5kIEkgZG9u
J3Qga25vdyB0aGUgYW5zd2VyIHlldC4gU28sIHlvdSBuZWVkIHRvIGRpdmUgZGVlcGVyIGluIHRo
ZQ0KPiA+IGlzc3VlIG9yLA0KPiA+IHBsZWFzZSwgY29udmluY2UgdGhhdCBJIGFtIHdyb25nIGhl
cmUuIEN1cnJlbnRseSwgeW91ciBjb21taXQgbWVzc2FnZQ0KPiA+IGRvZXNuJ3QNCj4gPiBjb252
aW5jZSBtZSBhdCBhbGwuDQo+ID4gDQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IFRoYW5rIHlvdSBm
b3IgdGhlIHJldmlldy4gWW91IGFyZSBhYnNvbHV0ZWx5IGNvcnJlY3QtIHRoZSBwYW5pYyBpcyBh
DQo+IHN5bXB0b20gb2YgYSBkZWVwZXIgbG9naWMgZXJyb3Igd2hlcmUgdGhlIGFsbG9jYXRvciBh
dHRlbXB0cyB0byByZS0NCj4gYWxsb2NhdGUgYW4gZXhpc3Rpbmcgbm9kZS4NCj4gDQo+IEkgaGF2
ZSBpbnZlc3RpZ2F0ZWQgdGhlIHJvb3QgY2F1c2UgdXNpbmcgdGhlIFN5emthbGxlciByZXByb2R1
Y2VyIGFuZA0KPiBhbmFseXplZCB0aGUgY3Jhc2ggbG9ncy4gSSBmb3VuZCB0d28gZGlzdGluY3Qg
aXNzdWVzIHRoYXQgbmVlZCB0byBiZQ0KPiBhZGRyZXNzZWQsIHdoaWNoIEkgcGxhbiB0byBzdWJt
aXQgYXMgYSB2MiBwYXRjaCBzZXJpZXMuDQo+IA0KPiAxLiBUaGUgUm9vdCBDYXVzZTogQ29ycnVw
dGVkIEFsbG9jYXRpb24gQml0bWFwIChBbGxvY2F0b3IgTG9naWMgRXJyb3IpOg0KPiBUaGUgU3l6
a2FsbGVyLWdlbmVyYXRlZCBpbWFnZSBoYXMgYSBjb3JydXB0ZWQgYWxsb2NhdGlvbiBiaXRtYXAg
d2hlcmUNCj4gTm9kZSAwICh0aGUgSGVhZGVyIE5vZGUpIGlzIG1hcmtlZCBhcyAiRnJlZSIgKDAp
Lg0KPiANCj4gICAgIE1lY2hhbmlzbTogaGZzX2JtYXBfYWxsb2MgdHJ1c3RzIHRoZSBvbi1kaXNr
IGJpdG1hcCwgc2VlcyBiaXQgMCBpcw0KPiBjbGVhciwgYW5kIGF0dGVtcHRzIHRvIGFsbG9jYXRl
IE5vZGUgMC4NCj4gDQo+ICAgICBDb25mbGljdDogSXQgY2FsbHMgaGZzX2Jub2RlX2NyZWF0ZSh0
cmVlLCAwKS4gU2luY2UgTm9kZSAwIGlzIHRoZQ0KPiBoZWFkZXIsIGl0IGlzIGFscmVhZHkgaW4g
dGhlIGhhc2ggdGFibGUuIGhmc19ibm9kZV9jcmVhdGUgY29ycmVjdGx5DQo+IGRldGVjdHMgdGhp
cyBhbmQgd2FybnM6DQo+IFs0MTc2Ny44Mzg5NDZdIGhmc3BsdXM6IG5ldyBub2RlIDAgYWxyZWFk
eSBoYXNoZWQ/DQo+IFs0MTc2Ny44MzkwOTddIFdBUk5JTkc6IGZzL2hmc3BsdXMvYm5vZGUuYzo2
MzEgYXQNCj4gaGZzcGx1c19ibm9kZV9jcmVhdGUuY29sZCsweDQxLzB4NDkNCj4gDQo+IFByb3Bv
c2VkIEZpeCAoUGF0Y2ggMSk6IE1vZGlmeSBoZnNfYm1hcF9hbGxvYyB0byBleHBsaWNpdGx5IGd1
YXJkDQo+IGFnYWluc3QgYWxsb2NhdGluZyBOb2RlIDAuIE5vZGUgMCBpcyB0aGUgQi1UcmVlIGhl
YWRlciBhbmQgaXMNCj4gc3RydWN0dXJhbGx5IHJlc2VydmVkOyBpdCBzaG91bGQgbmV2ZXIgYmUg
YWxsb2NhdGVkIGFzIGEgcmVjb3JkIG5vZGUsDQo+IHJlZ2FyZGxlc3Mgb2Ygd2hhdCB0aGUgYml0
bWFwIGNsYWltcy4NCj4gDQo+IDIuIFRoZSBDcmFzaDogVW5zYWZlIEVycm9yIEhhbmRsaW5nIChS
ZWZjb3VudCBWaW9sYXRpb24pIEV2ZW4gdGhvdWdoDQo+IHRoZSBhbGxvY2F0b3Igc2hvdWxkbid0
IHJlcXVlc3QgTm9kZSAwLCBoZnNfYm5vZGVfY3JlYXRlIGN1cnJlbnRseQ0KPiBoYW5kbGVzIHRo
ZSAibm9kZSBleGlzdHMiIGNhc2UgdW5zYWZlbHkuDQo+IA0KPiAgICAgTWVjaGFuaXNtOiBXaGVu
IGl0IGZpbmRzIHRoZSBleGlzdGluZyBub2RlICh0aGUgaGVhZGVyKSwgaXQgcHJpbnRzDQo+IHRo
ZSB3YXJuaW5nIGJ1dCByZXR1cm5zIHRoZSBwb2ludGVyIHdpdGhvdXQgaW5jcmVtZW50aW5nIHRo
ZSByZWZlcmVuY2UNCj4gY291bnQuDQo+IA0KPiAgICAgUmVzdWx0OiBUaGUgY2FsbGVyIHJlY2Vp
dmVzIGEgbm9kZSBwb2ludGVyLCB1c2VzIGl0LCBhbmQgZXZlbnR1YWxseQ0KPiBjYWxscyBoZnNf
Ym5vZGVfcHV0LiBTaW5jZSB0aGUgcmVmY291bnQgd2Fzbid0IGluY3JlbWVudGVkLCB0aGlzIGxl
YWRzDQo+IHRvIGEgcmVmY291bnQgdW5kZXJmbG93L3BhbmljLg0KPiANCj4gICAgIEV2aWRlbmNl
OiBUaGUgcGFuaWMgb2NjdXJzIGxhdGVyIGluIHRoZSBleGVjdXRpb24gZmxvdyAoZS5nLiwNCj4g
aW5zaWRlIGhmc19ibm9kZV9zcGxpdCBvciBoZnNwbHVzX2NyZWF0ZV9jYXQpLCBwcm92aW5nIHRo
ZSBzeXN0ZW0gaXMNCj4gcnVubmluZyB3aXRoIGEgInRpY2tpbmcgdGltZSBib21iIiBub2RlIHBv
aW50ZXIuDQo+IFs0MTc2Ny44NDA3MDldIGtlcm5lbCBCVUcgYXQgZnMvaGZzcGx1cy9ibm9kZS5j
OjY3NiENCj4gWzQxNzY3Ljg0MDc1MV0gUklQOiAwMDEwOmhmc3BsdXNfYm5vZGVfcHV0KzB4NGEw
LzB4NWMwDQo+IFs0MTc2Ny44NDA4MjZdIENhbGwgVHJhY2U6DQo+IFs0MTc2Ny44NDA4MzNdICBo
ZnNfYnRyZWVfaW5jX2hlaWdodC5pc3JhLjArMHg2NGUvMHg4YjANCj4gWzQxNzY3Ljg0MDg3OF0g
IGhmc3BsdXNfYnJlY19pbnNlcnQrMHg5N2IvMHhjZjANCj4gDQo+IFByb3Bvc2VkIEZpeCAoUGF0
Y2ggMik6IEkgc3RpbGwgYmVsaWV2ZSB3ZSBzaG91bGQgYWRkDQo+IGhmc19ibm9kZV9nZXQobm9k
ZSkgaW4gaGZzX2Jub2RlX2NyZWF0ZSAodGhlIG9yaWdpbmFsIHBhdGNoKS4gRXZlbiBpZg0KPiB0
aGUgYWxsb2NhdG9yIGlzIGZpeGVkLCBoZnNfYm5vZGVfY3JlYXRlIHNob3VsZCBiZSByb2J1c3Qu
IElmIGl0DQo+IHJldHVybnMgYSB2YWxpZCBwb2ludGVyLCBpdCBtdXN0IGd1YXJhbnRlZSB0aGF0
IHBvaW50ZXIgaGFzIGEgdmFsaWQNCj4gcmVmZXJlbmNlIHJlZmVyZW5jZSB0byBwcmV2ZW50IFVB
Ri9wYW5pY3MsIGNvbnNpc3RlbnQgd2l0aCB0aGUgZml4IGluDQo+IF9faGZzX2Jub2RlX2NyZWF0
ZSAoY29tbWl0IDE1MmFmMTE0Mjg3OCkuDQo+IA0KPiBQbGFuIGZvciB2MjoNCj4gDQo+ICAgICBQ
YXRjaCAxOiBoZnNwbHVzOiBwcmV2ZW50IGFsbG9jYXRpb24gb2YgaGVhZGVyIG5vZGUgKG5vZGUg
MCkgKEZpeGVzDQo+IHRoZSBsb2dpYyBlcnJvcikNCj4gDQo+ICAgICBQYXRjaCAyOiBoZnNwbHVz
OiBmaXggbWlzc2luZyBoZnNfYm5vZGVfZ2V0KCkgaW4gaGZzX2Jub2RlX2NyZWF0ZSgpDQo+IChG
aXhlcyB0aGUgY3Jhc2ggc2FmZXR5KQ0KPiANCj4gRG9lcyB0aGlzIGFwcHJvYWNoIGFuZCBhbmFs
eXNpcyBhZGRyZXNzIHlvdXIgY29uY2VybnM/DQo+IA0KPiANCg0KVGhlIGZpeCBpbiBoZnNfYm1h
cF9hbGxvYygpIHNvdW5kcyByZWFzb25hYmxlIHRvIG1lLiBCdXQgSSBkb24ndCBzZWUgdGhlIHBv
aW50DQpvZiBhZGRpbmcgaGZzX2Jub2RlX2dldCgpIGluIGhmc19ibm9kZV9jcmVhdGUoKSBmb3Ig
dGhlIGNhc2Ugb2YgZXJyb25lb3VzDQpzaXR1YXRpb24gWzFdOg0KDQoJaWYgKG5vZGUpIHsNCgkJ
cHJfY3JpdCgibmV3IG5vZGUgJXUgYWxyZWFkeSBoYXNoZWQ/XG4iLCBudW0pOw0KCQlXQVJOX09O
KDEpOw0KCQlyZXR1cm4gbm9kZTsNCgl9DQoNCkl0IHdpbGwgYmUgbXVjaCBiZXR0ZXIgdG8gcmV0
dXJuIEVSUl9QVFIoLUVFWElTVCkgaGVyZS4gQmVjYXVzZSwgaXQgaXMgbm90DQpzaXR1YXRpb24g
b2YgImRvaW5nIGJ1c2luZXNzIGFzIHVzdWFsIi4gV2Ugc2hvdWxkIG5vdCBjb250aW51ZSB0byBi
ZWxpZXZlIHRoYXQNCiJzdW4gaXMgc2hpbmluZyBmb3IgdXMiLCBidXQgd2Ugc2hvdWxkIHN0b3Ag
dGhlIGxvZ2ljIHNvbWVob3cuDQoNClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTgvc291cmNlL2ZzL2hmcy9ibm9kZS5jI0w1MTgNCg==

