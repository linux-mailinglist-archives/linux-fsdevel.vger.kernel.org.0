Return-Path: <linux-fsdevel+bounces-79870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF2qF/8jr2n6OQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:48:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C32404D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FDF6300F182
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0F410D1B;
	Mon,  9 Mar 2026 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s7+zcAeu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C9325495;
	Mon,  9 Mar 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085692; cv=fail; b=GXe8TFCER43ArS+gqdcljQxjmx6h2tMkA5wr/uQsmOWEkMPajovA6ckpL/s5iAsMBgzr5k7pWcMDEKrGw5DDefio4FJx5ICVFbSdTDjx01I5WTsYavVFKL/jnkzWRKH9L1k77FEaaLiuxWkFTbzNwj+ih97xzYZOqSET/NNLfGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085692; c=relaxed/simple;
	bh=jPgzjVsHN5Bp75q//uubvPyTfCCYphJSWMD8fQZcGRI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=H+nPc4V4Fx3Aoeo7KbG+yHckzXEYD5na6gorBqPdOqOO9T1lcs6y1q2HztiwL3riTegP/oDCaBnIpmwummtRu27eIhCqGpLMwA3NiFDVuSE4ayjg3LXX1S4nOd+IyQosJsgpbNd1rGYNvUsndEFAGe2Mp7p4t31ezr+Pvbb8Mcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s7+zcAeu; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629FGbKl1597685;
	Mon, 9 Mar 2026 19:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jPgzjVsHN5Bp75q//uubvPyTfCCYphJSWMD8fQZcGRI=; b=s7+zcAeu
	tPBaVeh5PDBDs/5aCB0/32w1ZqfMT/bXo7rdcQuqLDJbid2BOE2+PTzOgU+6gHwE
	d7IBjuZahwwXSbaZ5qGWDsUy32bgFZMI5OGZR8n6GXZVlGiwSEvYtuig42VdvcHf
	+M1YXp9uyXk82pok2yr6P2E1zdjfstZyXcxWv163viMj5Y3yHzISIpZgu8T8ADoQ
	W+JI2+xFhkmg8lClpiWuwlcNBT42tkcqbI2hi3lmhxx1CZVip+/zlp3lslhVbo6p
	U+sL/vii+qWAfKFfF1Crmdz+/3Ri9/QMmNZQjd9DWB+0i1Zv0ux1e5djVvYntmYv
	G2rADVKIVN6eSA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7vq0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:47:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGBx24BqXR743+l1Px2X0BjURqFTMP6uRXwJXuxIrKhM1S86zJplJ56WHK8WXqzvhr3PL5FDLJOVtok/T8SZiEx1XtxDLlOyOVMfNoY0z1DKEwtASs6GaXiKby4hCG0lvo5W2PDD4nBOgg+7Rx6SnReH5RQkHO6aCfqWVgZ0TltbSVe+9od6cQtKnREtzwQmyv1HY0W3lCdXnX73cJD29xsm/DNkntqGWmP3QK1+Iuwk50Ndy8Z4X1UkEkfOMJEklanrMJhqwYzyuxid9y+W/6aEcrszXFHl3MT7LGGGHdFSMHu/oVlO5Tqe8YeeJRZRLjreHIq0LLhCfbWcd11flQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPgzjVsHN5Bp75q//uubvPyTfCCYphJSWMD8fQZcGRI=;
 b=X4TgAUxp9Q3exAUCkxmmErjEU4/1AoMlYQ9OfjYXDLOXryzBsnBvYiNXBD1zhKqgaT8EwqdOuyI1OBf6FTheXXa0332ev+db+usRyK5pAVkr98XE5kS7yHhCxhNmEbTuTLbFmflnvMe2TQySIIuudi1QXvKKCSAoyxS2xKi0OyUM86zNjhjz8/ERgC2wzhRPjmfmMVV9lEj3WGzJtfIPfkSmmA29PhZbfSgDeZJX4/xWoCmb+J0u4CtcAQM9Lai0tPiPLxmPu9ZYBfUf+BPh6+YICHv4+Ns2iA70TRAGYpYXDgV80RnuoJj92TJkkFDGXPC5611IxKT3DSkAOaW+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6544.namprd15.prod.outlook.com (2603:10b6:8:1e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:47:53 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:47:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hyc.lee@gmail.com" <hyc.lee@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cheol.lee@lge.com" <cheol.lee@lge.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: limit sb_maxbytes to partition
 size
Thread-Index:
 AQHcq9hDf3IahKMroEqX1R8/F3zmX7WezIeAgABKD4CAAATZAIAAEm4AgAFn/ACAABr6gIAABxiAgAALsYCAAS6+gIADc+0AgAE9QoA=
Date: Mon, 9 Mar 2026 19:47:53 +0000
Message-ID: <32997ac487b258aa219c66d870eb3fad71bb9de9.camel@ibm.com>
References: <aaguv09zaPCgdzWO@infradead.org>
	 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
	 <aajObSSRGVXG3sI_@hyunchul-PC02>
	 <532c5cdf12ced8eee5e5a93efe592937b63b889d.camel@ibm.com>
	 <CANFS6bZm3G9HA3X5Bi2_KGZDNGuguQzG44-cMcQHto2+qe_05g@mail.gmail.com>
	 <e979abaf61fa6d7fab444eac293fcbc2993c78ee.camel@ibm.com>
	 <aaomj9LgbfSem-aF@hyunchul-PC02>
	 <f174f7f928c9ee29f1c138d9ca1b23abfbc77d0c.camel@ibm.com>
	 <aao2Ua94b16am-BE@hyunchul-PC02>
	 <cecaebb4c333439ea6e10808908f69cd3f3dbf95.camel@ibm.com>
	 <aa4ZxJ1Lkk_9-f-C@hyunchul-PC02>
In-Reply-To: <aa4ZxJ1Lkk_9-f-C@hyunchul-PC02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6544:EE_
x-ms-office365-filtering-correlation-id: fcf17eab-7965-4f06-34e9-08de7e14c0cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 u2aIwariDP2Smv8NRjbyWPejbdu2zJVlEXdoiQ/kUblHi9TIeR55wK539QFNFv4XrJu4J8SV0FTa8Gg61GXoa52WAdBJuO9LjhEz149BstUyzRxQzXQeVXqddEk6IptZEH9V93ESx1HSLBK2ChP7N26vszwMk2hciVVsr+tucpuF5ZPVJjQ+qmari4Pd9N4JcUq9uuaQF7lZb1acLbQiJMDs+THDuS+DaCCVUYX4G3gvCWNDfrm5nkuNo2BwLAPZd99TIkAhpBdAUUp3zJFLTeNZgqRF4vxKQRHoEIk7vX1GVR4fZagmGki/nXDhBO9PJcA+jwNXSLHhQcZpqAJZnwulX0kDWjh1qXBKgF5e5rmcod/dygLEoX8Bxcyc0sEzO5moccCJaclBu9LYncc9WtiQZx0tQUD+nYjGJnFAZaOM+6VQdQTwGq1BwyobZdh0fm2l9DRUco6d1CUyd7e90bwMJTWV2/jOSvFxqgVpjAWo8HcqwWlQcLEQTm6Fcun77Os3u7mg4xB55XaNWr7++/6YPtPiB90cayl5AY8RxgNEpuKfLyQlruyrIFHiR/ZOB0qbue+TJjBcxSeOSYBKlvdJVrIoH2osTWfC4gLp/Yl0q9Puv0oIunjBPcbGL3KUDQd3zJbjSfhXVvgs2k62CH14caAMGteTjRcZSse78D99sEMXXCLHKABxHcR/imcwat0vphlm2jFewn7BAuCBboaNtyTEIkiGpjCgz6PUpGJ7o72aGfOT/ifDSRlE/Qiu5zfffzzK1nG6J06oMhm5DE2Ir7KeilobkcpGLkjTAjA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0Q2YkYrNEFGa3c5Ykg1YzJXZGdnb24rRGNscWNoQVE0N1pSdkhmbUswaTRn?=
 =?utf-8?B?TGNXeXprdldCZm5ZQkk1WVUrR2dSRWpKNk9ESGxUY1VEanlROW5sVWR2MElX?=
 =?utf-8?B?dFJlaVVhamlKZVdjcXIyT040NUgvcis2eEZibUFpbXlTMjZzLzliUjhpUlRw?=
 =?utf-8?B?U282UTM2cFd6dkZMZEo3QmwrSGhuQnVqbldvLzhyTVEzRG9LVmN0SW1FZXly?=
 =?utf-8?B?R3Fxak94WHNxd1BNUkYzUjB0TjZWSXFJV1hCM3EwMFYxWjJFWEVNS2xmWEpE?=
 =?utf-8?B?YTRqWS9MK3g5WnBRaHg3WTlKM3FONkVBQ0xuc2NnRmNhVHNpcEpZVVllWUxo?=
 =?utf-8?B?WWk1OUJqRmxFZGo0bG1xZ2dPRkVTdExPSTR6L1BNZThobHlkVGdNRzZFRHNm?=
 =?utf-8?B?K0IvcC9rY3FIdlRQYkhleHNWWUpFMlpmcHI0aWNlOUhRWU1kQVFmeHJWa3VH?=
 =?utf-8?B?MjNWNFVaRHlMU3hPdHkzdVBPcHN1ZHBTOEJSZ1VyOGR5SDJMWUhRMlFlNEl0?=
 =?utf-8?B?eFZ1UGVJZVBKNm93cEFUd2UzVkVlUG90WnVyOFp2bDFRMTJ5U2hrRldiRHZk?=
 =?utf-8?B?U3VlbmNMQlNwR3QvV2ViTEVNRGV2UFM4TDQwd3VNV2w2M2cwbnBTSCswelBu?=
 =?utf-8?B?NERpWml6bllmMzg4VUs5cTRhNlZsMlhJK1JORzZKWCtKY21HcjRSSFFsRVRi?=
 =?utf-8?B?QnlibTJoSkdnVGFEZlpmbGpQT1JTWllyMEUvT1pwbHhTZkVJVjVKdmYrMkdm?=
 =?utf-8?B?VUs0aTZYdGdaV0VSZ2hZR09Cb1ROd01Eek11ZG94UVB2UXp3NEsyVTQ5eXV5?=
 =?utf-8?B?ZUJ5UTY1ZHpQUlE2RlJROUhEZmtHd3ZlNG9CR2ViNVBmQzJpYXppaHdQWlZa?=
 =?utf-8?B?eWFueTVCaW5uRGhVcWRHU0Z0WC9nVzh5UUd6eHpQeWwwMmQ1QTVEb2JYcytO?=
 =?utf-8?B?ZDNvNXdRUk16SU9sZTRmdE0vVzAzMHlFVHh4RkdzbWJ5bXFGZzJpTXNqb1JY?=
 =?utf-8?B?V25FVGNnWXB2MDFva1pBT3Y4NzkrV3pWMXFLcWdGeTk1NkVsakk1N3dWazlC?=
 =?utf-8?B?YjQwb3BsN2NYRFUrbUE5b3ZGL1VaUUlRTDlINElFdDh4elppb0IzcjdOY2Zp?=
 =?utf-8?B?ZFJIK0V1Z2NUek5jQVNCNVUzUk12YWJ3UkQ5MjlVZFNXTTRXNFBhTy9JQUhi?=
 =?utf-8?B?RkxjbnB1WmZEMXNhaXlZa0FYTXZ2VjZOVnA0d0JyTFNOc28vbG1IUmlERG5J?=
 =?utf-8?B?SnZiMlI4SVgvZGJST2JUNkZwUjRSNGJRK1Z3SGlXaXRIb1lTQ09BV285M0Fz?=
 =?utf-8?B?aXlIQmlwZG9YbldRemVCYm45SUkxMDFocUxQdWZ5YTFvZDIvbExiQWxFUzF5?=
 =?utf-8?B?YXl5QUJCL3JRTlROUkJHQ1FROTFkK2h1RlMwck5xQStKNHBvVnBLUXZIZXl3?=
 =?utf-8?B?anhJVVdQeVR4VlRZcTFNckt1ZHpDQ0ZVNnIwdVJweUhXazJ5aDBhT080RDRU?=
 =?utf-8?B?b3E2MWNIT3ZHNFl1dmN6MEs1bk90NDBySkFNNG1iaFFTM1BQbUFGcUJDbVlO?=
 =?utf-8?B?bHpYcnJoTXdRd0NHWTI3SFQvZ1dzL21BZy9wcFBtcEp2OWNUVGNqVFhlQmww?=
 =?utf-8?B?YzVZSll0TXdaT214T1V5aTlSdDUrSnlDOGtsRkpxNTV3Y05SUUQ3ZlZzOXR4?=
 =?utf-8?B?R1JHSEl3cG1mK1FXd3kzTjhHQWZNZmRON29QSTNBaldxWXJCTUVLdU1Xczhl?=
 =?utf-8?B?VEVYOXpxMVliT2Q0amJzNWpSVXluZml2ZHFFdlpqZVFTcXd6K3B4K1pDTit6?=
 =?utf-8?B?czFUMFhwYWpQSyttK3Jqem05YkpFUnBuR3hXdnFBdTlicnZRL3luVjBjN0VT?=
 =?utf-8?B?VFFWdG5ZWUs2bURrMTRZaUhwc0NUWm1nd2V2TDBZMzJYcXFSNlhLb1k2RUZI?=
 =?utf-8?B?cVFUbC91eVJNK2FGMHZWU2FYRnI3eG1qMXBpSExZUUgxMFNyK2JtelBQUFJ4?=
 =?utf-8?B?d2RTUXdOVUgzTTh5ckMrQlV0N1ZvSHgweUpsazBleGxKL0pZVC9uaE9pWWd5?=
 =?utf-8?B?aW1yQUxjb05YR0ZZYmlRTHlhTVpRMEREUjNiUHJ1VExyemVIaE9kcU9DTXBJ?=
 =?utf-8?B?OTZSYzAzd05pTFBFejI2TlhCYW4xcis5cmE5Ym54dmV5RlV3QUNPVTgxdWs4?=
 =?utf-8?B?aU5wdmJZeEtrS3ZoUnppcTVXOFF5N1FQWFpHTGk4VjNWSHJCcXh3N1Jkc3Vv?=
 =?utf-8?B?WlVkMFhqOEUyNlFBM2hXL1FLVGxVUzRVRWVmcmNoR0t1R1lzazBSR0tHOTlo?=
 =?utf-8?B?Ym9GYTE2SjM4bEJSQzFWSTVNcXphR2xwd09wMnk3eUFYd0puYjdZbHlaN2dp?=
 =?utf-8?Q?PApl+rqsmJYAikCVizeUwkgY3bFS9WAeqSjkC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0093EBD7570A44BA6E5488E4379494@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PM/KiGcnAKrzh8o0w9OwgWQ6A+EHZHmUWyn6O6mFejs33JixLKZZWfAHr1lBaixsPy0A7zZU64XYQ1ylt3vf0Zc2QW3hLC3VMKDuPKpxWGfoXkfXqglpr76x+9bA3eB3hhi9ulYzgzsgeAmYSv6SunRAAs/iTyR1LulIucgGMbN2AgT7ipJdRS2y2DNjd1ro7L4S9bgzznFvjbG/Al1qFBBTHJocFXo9y/FQ8DNSE8eM7Aur62qcfvmoLe5vN8EHvbt1pezZGagDf9V554uzbgjiXH8nboVFa4bkB9V+zHzGNMzzfsvtt5fmEwl/VqUOGs6bt8I7CqSsYh5/GOnlyQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf17eab-7965-4f06-34e9-08de7e14c0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:47:53.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHmgf2Bi+NusH5Td4+YlWXnndzDd9p5Q2VbcMwDoyxDn2+vFIAYF7yvXp6N27/2lpPN+wssWk5+T+VfmTXVWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6544
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dgVK-DZIIvnhBkwkOYa5HsodCe1BodlP
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af23ec cx=c_pps
 a=KM6hcDErBpdSH7DPVcpu/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=4LVtWVTWoAHacLhovz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NCBTYWx0ZWRfX89kWV5saoQPv
 hvG+dlzE1RisvBtxC5t9lPjNJwCnPaP+jMetxn/Zb7iIXoc1aDbqHyexTQHCJ96VlAOxpi1gg1T
 qI0gZLu0GHG2ubPqggSahvhhGxuBkoRAixJiQrkiBAiIHRKTuSkAKOHLunIQmyxr2I1v3bbDw0K
 EwIa3TYp/V4qxn4YmbEXR8pVWMW5iq3OVv9lBbjVnxFQt/5jTab8lQKCp7Sd8gm7JLCNrq+uODb
 UYrIzUyYDJlUgm1h4utgkKA/BduAX1PLHd9hZePimfZWJpASzkYPPCR/L46r/lcv0pBDQcGq5+F
 QzTWnq3xWDeMZY5BqfjXXStzoGTqiocsPqHTUI4dY2XvDYkDgk32laXyGGy0HYeez6oHk8g/36d
 oNFvldvQOnGZMr6mnPc8pFAZEnBW0/gZG3I5dpeqDpgL4o2NmLEBk2gWUwoG/Qd4mqbAO4zjYso
 ARh4WZbjMeYzG+zgpUw==
X-Proofpoint-ORIG-GUID: aAaloz1Lycql5wYs4sgv8m8OawY_dxiJ
Subject: RE: [PATCH] hfsplus: limit sb_maxbytes to partition size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090174
X-Rspamd-Queue-Id: CB4C32404D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79870-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDA5OjUyICswOTAwLCBIeXVuY2h1bCBMZWUgd3JvdGU6DQo+
IA0KPHNraXBwZWQ+DQoNCj4gDQo+IFRoZSBlbWFpbCBpcyBnZXR0aW5nIGxlbmd0eSwgc28gSSB3
aWxsIHRyeSB0byBzdW1tYXJpemUgdGhlDQo+IGRpc2N1c3Npb24uIDopDQo+IA0KDQpJIHRoaW5r
IEkgd291bGQgbGlrZSB0byBzZWUgdGhlIHNlY29uZCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4gSXQg
d2lsbCBiZSBlYXNpZXINCnRvIHJldmlldyBhbmQgZGlzY3VzcyB5b3VyIHNvbHV0aW9uIGluIHRo
ZSBmb3JtIG9mIHBhdGNoLiBPdGhlcndpc2UsIG91cg0KZGlzY3Vzc2lvbiBnb2VzIG5vd2hlcmUg
bm93LiA6KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg==

