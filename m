Return-Path: <linux-fsdevel+bounces-15849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D75894B7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD69A2836D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 06:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93372BB1F;
	Tue,  2 Apr 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="A7CGFidQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45021340;
	Tue,  2 Apr 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039555; cv=fail; b=BZIroxmSf2vvc9km0xMYlxsbzwacvkUfpkL1amu4eeZZz87HhFHTu39TnLhrQz4g4/BnaE+9LOUhGAeh0+1PPXGRlNexVlyDn1eyz96HRKB7DFP25J6O4TPxsI8VG+GfMxuLzMJkVOnNzomF09MqdzjvcP6RT6PLj97g8Dglo3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039555; c=relaxed/simple;
	bh=ZBEAXjMl8aMOJStM89IW/3Bd78fUZuAHkBQ/AZwUAGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtFmZGx87TDB2vAQmIzjMZzXkomk0U5s30eRPd+H9oZyYY/kEAgo8+0ub6IRQmoGmYVJqZOikHgLwllzav7KXWoDRf3CfNSjyinry48/OSfaPCu9eoAyLD3A3YjGi/AembcTsVSoIWAbJbfQCfVjOlusE+R9zJxV+6R4FpFeIFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=A7CGFidQ; arc=fail smtp.client-ip=18.185.115.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.56])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 9308C10034EFA;
	Tue,  2 Apr 2024 06:32:23 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.171.124])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 69DCF10000C4D;
	Tue,  2 Apr 2024 06:32:15 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1712039438.648000
X-TM-MAIL-UUID: 66fca560-4a5e-4235-9f5a-556509e14da8
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 9E71A1000041F;
	Tue,  2 Apr 2024 06:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlyCwV4WCbhV0P+lbpRtzFgGSR1uDGUA+XFrwWxH6CJKm7DAbnXViMCiH6a1XDUdheA6fb+EosxWZ4ez8R4j6q5XroK274k5l7u2ay9uNr5BZLEGMfhrRxckcCO+lMiy3BwH0NBdntsaexN2HG5yq9xtFUi1an0X77H9UjRocMz+KMzgz9F7d3Q0w7Kiyc4KjWIPcUNjbPExhemLmo9dURqUNiUYo2P+OkNPZUIZDqkL/xvUm/gQprD9umO+vjPO1zUkE3NQ42KzUCiXtLIOtg+JPC3Npc3WBimvnZU1MG+v6luNHs8xy42KwYSlBPI6XuCAxDGgjwz4bxJIHOvv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qs0KpbVK2J6Fqba87auZMO49qKNG9wDQGX6mRNhOTc=;
 b=HLADAHymBaTD7/n/uFvEOAST/iqs06xE2ngsGIoZkaH1Qqij8hmhggFk7vbivKmlb07Tr5gDxg/8hkaIhSzC+EMVpcQZttHSSIN5XvnL1P34Wcmw22lEN3YGKaYajewEtQIZ8Wc2KY+DEtBaVmODKsOgaMP91boJA6Va6cJD/MHxSFQNI3mZiKu8KWBoO/0MTxlNmlFnR01XJ0eiAUu5BrgNDW6ASsJUUK57TVVj5qtTi4STgKTP5+0fV28DIIUmJL04x23WLoCmDVm27ZPSykEdlb4ZfIEUwuqXmkN0NhCuJ9Aln+d4k6Z067VNXkFxx2kL5I97D1Ced2IiqpRYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Message-ID: <cfab0ca9-6e01-4fe7-bf00-3e1e7cd5b33e@opensynergy.com>
Date: Tue, 2 Apr 2024 08:30:31 +0200
Subject: Re: [PATCH v2 25/25] sound: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Pankaj Gupta
 <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
 <20240331-module-owner-virtio-v2-25-98f04bfaf46a@linaro.org>
Content-Language: en-US
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <20240331-module-owner-virtio-v2-25-98f04bfaf46a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|FRYP281MB3161:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fIOq54zz9MjbZGfW0IyOo00+ZveeYzBUBtoIDl46iUfIMnzeu+vTPV9G54jRufB9xtyN1SJgzy4syB6pUDEewcGzGmARyaUEc90sUbRgmsDrKe819Z80/z3vgINJIekjovyogS/XTp/EBxkIOSWNaJ66whwVox7e99xvL8NxD+HwAZ2jHmQ+TsqD3wrwuZJLuzQrQyi5EFNmyS5fdgmy2vzXKKJrIgwUKRHy14E1ldSsMkCiZrq5q8MP2RSafNX5Ep8C9X6A8i7Lh5tConcf49cGHKYiotxJV33vUr9a9fQisNF6leN4Ku38nZIW8G4WpGDZGOt6s0S60GyMXP5OVPd7c6ZYT891EILhOmyxM1NQI0QjEd+QR7xyDvBuAAZEUkFQG8IuIlPMln1iGyTOiwkCdwUDlTfCAnw1Pa7RDmqaKbcx7JDwooRlrlrcUuYpvIo6Wyv1NOqkQVAQ5LgIefzf1OxqIQcoFku95BjcG98I7PGzHFlLgXfL80U0jxfIKK8KxrJy8GE7XZKgadhy1J65AJ/Kxe6y9fFNW4jf8EnGr02Gr25zDt+ZzMkT+H/Mtrl/nzYgtmlTX6CxT82DFoDjKsWvTryQBIWSDN9b/GKTVYSBzWC6QvFwCKD2u6vbrfO4EZwdB2rWnysbst+Fu9m/RjBm9K8KIpca1RpUEq+L0gAfTaWE2DefZdolC5RREJeqXw+7ThmMxeMgLZj0xA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRUVjYyTkxGV0M0a0VaNlZuQ1NzVDNUYitoWnAwUXRWVFdqVW8xL3ptSnB4?=
 =?utf-8?B?VHVjTEY0VUtEZ0I2QU5jZXlHcEd4dSs5K3hmdEYzb3dzeFR1czNxZ0lBQ01G?=
 =?utf-8?B?WFZoQ2k2TXBWNHV4S3VSQWwxNGhIS0JoaFk3R1RzcW5LdHlsOHA5NVJxUElp?=
 =?utf-8?B?eUpJN2lEV3daeFA3aXZVa1Ura3REa2FNS1p4U21OTDY0NVl1b0tWZndSNnRs?=
 =?utf-8?B?c3Q4aFhocUpBNllQZlBSVjl1QVlrbDBvUVF4SDFZSUx1eFZlamV0UnFUVkd2?=
 =?utf-8?B?dUJGYkZjY09rakRaLzNPeUZtYlRDdGtqSkxDSmp6dEdMbWRPbS9xaUJWbk5Z?=
 =?utf-8?B?TEhmYlhVNW5jb3lQYi91TmlXZ3BoaFh1UkxDM2U3K21OZmI1dWNIcDRVSGVw?=
 =?utf-8?B?eXZweFIvOXpjSWhtYkVWK3lROUJSVmNIaTRUOXdYUndZVjFKczNWMDJQRlZm?=
 =?utf-8?B?amJ0aFFJTWhOclBVc2VySjRZaG9hQTI4cThXR0RoMHdQaXlibDJNR2kwc3V4?=
 =?utf-8?B?Q0VjbDVGc2lkM1JIUE1pVGNIS1A3YWRNVWhZd1U2QTYwMHhlZm5nRUtSUGFw?=
 =?utf-8?B?dC9lVjFFKzRTQ1lPYmVucTRmYUUzSVBBR1laVmdPaTQ2RkRsckdzeGErZkNF?=
 =?utf-8?B?WWl2S3pVY1JzcElhY0w0cnNjSUVla3Q3c3NvMFFJK3hHUmI0aHB0ZVkwSVMx?=
 =?utf-8?B?S0tSejhsSmlIZFZXVFdOem9JcWtIVy9Ta1VvN1ljZUo0cnZZZ3BmSXk3NDNC?=
 =?utf-8?B?OFQ1TXZKczhKdzd2RTlYU09iNHFBUVB5bTMrUENISHYyZ0FmWEdkV2dsOEF5?=
 =?utf-8?B?UWtVTFRENTV5MkZONUpSOGpqU3hBWE1HTHZGWDRaM0FXSDBPdW5MVDRROTln?=
 =?utf-8?B?ZHFrVSswQ25BQURkaUJFdG1qNGh2M1NpenFuRFhCcVNCQmVhY1ZRREZ5OVNT?=
 =?utf-8?B?MXdkUGdaUTdjNWxYbVJQMWg0cHNYbFp1UFB2cVVURUVOMEFuMkdTQ3ZaeUdQ?=
 =?utf-8?B?dzlLcXh5a3V5KzdKQTNVV1VQZ2FsMVU3OE5QQW1pL3FwMW5TQVZvRFFZVG5O?=
 =?utf-8?B?aDdrK01FNFZVdHpRTWxZK2JMK29pOEZhSmhXNHc1RElsY1dyVVI5cHRnWE81?=
 =?utf-8?B?c0NBVmlhWVNGd3RxZzBvM2I3aGR4aVA0MUNOajNUaGxZVnNhSDEySWkxUDZH?=
 =?utf-8?B?ejNrRnNLVWJJcGN1UnRoQXRxSjZqQWhVckZnWkVpK25kVUpra0E3c1NHdFJJ?=
 =?utf-8?B?RCtNaUoyRHJ4bnp1QWh5VS9GV09ydnk4bEpKOUpIaW1xRDBPbnNrNVIwOVQ1?=
 =?utf-8?B?cEJVeTU2SDQrd0hrS1Avd09FR1VBSkZPVnp2bWR4ZlV4UWJ0b0VLOUNvcWVM?=
 =?utf-8?B?OGUrVTRsVi8yckxjU1MyWjU4b2h1VU1oN1l1aXBZdGdMN3FISGJuUmxmLzRM?=
 =?utf-8?B?NEpQR2RPOVZIRnNzWjk1akt3WXlrWlFtc25NTFJZN1RSdS9xYkt4cjRWam5F?=
 =?utf-8?B?NnNzbEhjMUZBSlpieHBJVktCZFFtWjk2RTRENUoxYTROTVhXQzNEaExCWG1w?=
 =?utf-8?B?UVlFbklZYTk5ekZwUHhsTlBwM25EaWprcmprYkZKS3lzU2JDYmdWblB6ekJB?=
 =?utf-8?B?MmF1bW0xQUNFV2VNU0pkSkVRRnRkNkR6eHk0OXRBTnpuWnk3TnpSb21FVGdU?=
 =?utf-8?B?SysyWFprU0FTRFRtdGtHTm1pQlZvZmFLNXRRV01OUW1lZzRWUG01c1NlUGw4?=
 =?utf-8?B?dmRqV1pGSTZNUFpRTHJ0eUhXbEFMczBEdGJvc0J4UDJEVkkzU29WOW1GSjNJ?=
 =?utf-8?B?WDRUOXl1ay9OekVtRHFYSWV3R2dCMXJwT0VsZ2UwM3lhSEdiVWRRM2dsbjdI?=
 =?utf-8?B?TUgzeCs4YjlyMGFDM1RPRmM0RDYyd210NEtLdFFHRy9MRG1rYXpNYXVyd1FC?=
 =?utf-8?B?ei9iVHpnK0pWMzBBSW5xZTRiTG03OW15ZGFNbTdQdHRHL3FjWTlGYlFwdlIy?=
 =?utf-8?B?d2NyRnN4dVFOaXdac0RSOVE0MXdzdEcyS0draThveEVwbDNseEpKSEkxMkhL?=
 =?utf-8?B?SmVndTNoRXJtSFNwL3dIMGxzRmdkeCt2S0Q2dzhWdCtmaVVnY1h3OSttODE5?=
 =?utf-8?Q?VC6GVSFSz9C7S9Wo4L5XZo+QI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2547a1-b8ea-4071-42df-08dc52de6885
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 06:30:37.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJhIWTU+RHOaEdakYzkQ1ad7D2hwRbYVRgbjUAiqMWbve5wY9sDF6b/+ijvv4JfRXP0crWSexiqoil9yPFVbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3161
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28292.005
X-TMASE-Result: 10--5.445600-4.000000
X-TMASE-MatchedRID: wQVy7q402w1TzAVQ78TKJRhvdi92BBAuZK1SF2R3edhrIVA3IGfCC6DE
	DQa+uiKUH2xok6cGGNABKhB2N2U17vLk2AFN1sunQj0AQ98QP92q8lf9o0av1xIIN3MAx5f9anZ
	VdS5mxHyDZQoKdarzvOEvGuhUCHAT+IFpwsDCYKBaOxpgjiWHdd/upPexrMg4sZFfGXBYeAAKjR
	CEKUuElpLHk4pGN/0DFk3xbexPTOS72HhspQkaIw==
X-TMASE-XGENCLOUD: 9e9e9fa0-8253-4e7c-919c-70703b990615-0-0-200-0
X-TM-Deliver-Signature: 5FBE828BD7A94C0C52584343C217624E
X-TM-Addin-Auth: 78cuz+pexj/pn1SmQsOZGkZZYypEyT/44Vj2byjl7NNjYTH0fSc9lfkL0fP
	xPDhlwk1PfhNKWFCVMj9tFI8/gEUTGFLrDXomc/w5mFspJcQvW8bjQnb+FSG9QRjqGtUQPFgol8
	Ww9/WL3vHqsq6VQWeaWmBp08o0va3jKPQsEnlzZ5fzN5HBIyRVKAaEU3wb8qnjye0TzNasLDM1I
	71TpnnRTvDzoJIdCdDaXnUWrAVcysLbHbzZ6kIEdTILRnq/hwrHCMEGlyZhZlhz28TwTs1DY+2x
	REGvXOXiBuZsb1o=.P4ei9focH1shZUt6/8XbQLxrdp4UTkVfy2yLfcnabYWfblNk64FUohEbOH
	UOH+AMU/Ckd5AX1DzCuC3+4Pu7tKP9ejAofN7LVSP+lhgk3VVOx0jCIddBoOEKnWY3gRH0uu0Qq
	02k3cH+Sqs0Y+R9KIz9YUAS1GDXDErPQ5pKO+r6mKkGlw1dwLJnnE2bJ6LTbHclwxioVu4fuqA5
	Ph+bsLwi3zQKkiYBOfTAez8aGkogKYXjce0bfeArPtVJ73vac004ukEG9CR33oxoH/MOn+1CRzM
	fR1QqFeto2OlRdIhVbHa+koY8W3at2JdfvqmDciv2+HiNF/koBYm+QsZeOg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1712039535;
	bh=ZBEAXjMl8aMOJStM89IW/3Bd78fUZuAHkBQ/AZwUAGs=; l=889;
	h=Date:To:From;
	b=A7CGFidQ7EmvHwlJ1HrqwRnbnsXMZ3gjCVHFSGu9WkvgXKcwtOK84GoQWE+sJXa5d
	 C8qilhq95NUIlunEbT3uRWpyT2VZzaGUvb8Y8d+kPfevSbp3Hw3Ja6cIYRlU5oY12L
	 F4TIBe2UNLP7eeessSTSj8EAc2Z/5aPHH3pgY2KKN4hILWfJmMFxhfhXvFhdgJC3TC
	 z4/hz6/LS4+jn1K4yfEJ57JrIjDulP2cPA5aszppGAdznzIyF3cf9zzvdNAoeFJO5J
	 kVk+MnW6pUmKdCb+SrYsC0H+aO2JxIouNRNPYR8g62naKKGqj/f+AvcOv7RVCHQJ+A
	 tPhogaFJgwvHg==

Hi Krzysztof,

On 31.03.2024 10:44, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>


> ---
> 
> Depends on the first patch.
> ---
>   sound/virtio/virtio_card.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 2da20c625247..7805daea0102 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -438,7 +438,6 @@ static unsigned int features[] = {
>   
>   static struct virtio_driver virtsnd_driver = {
>   	.driver.name = KBUILD_MODNAME,
> -	.driver.owner = THIS_MODULE,
>   	.id_table = id_table,
>   	.feature_table = features,
>   	.feature_table_size = ARRAY_SIZE(features),
> 

