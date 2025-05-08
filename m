Return-Path: <linux-fsdevel+bounces-48480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9FBAAFB43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F664C4A9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062B22CBF9;
	Thu,  8 May 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gNzJdX87";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z/oAWzRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFAC22B590;
	Thu,  8 May 2025 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710612; cv=fail; b=CuuQLGAhoHSxKkByV6Ov8qYwOYgruNGdNI4QlKG0hky18VBfoTi7ntDwt4/pvTaHWTdnqHiHgmCckWe2k75TUxWqeAu95ubGgjuG/sBG9dhgIxj12PNrKNHqTsAR8pzYi2aGXe82lFAbo/yq3+isavff7viyyYd8u3lN6g0wF/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710612; c=relaxed/simple;
	bh=5RA5c7N1pLlpY1QGNXWV6eHkfQl8wxGe36aW/cEt2nI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhbS+dE7wyAF3au+/aXUSqTxcaaqDutM0rabeaqIPNDDMv7d4wpz8zAbnRLHbgt+4HtjJaUjrknOBDi8gxF5zX+UwB9dxVvR7l7Dx/xbwkk3PwYnyYRZT4nVUL9eGAMzrHhSbbV6Og5EV2iDSWGdFkuW/mHnr07XRKpfdI79PSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gNzJdX87; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=z/oAWzRy; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746710611; x=1778246611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5RA5c7N1pLlpY1QGNXWV6eHkfQl8wxGe36aW/cEt2nI=;
  b=gNzJdX87WUZaZ6xfjcj0J3Cvdx4j1IifBGwhFGD9FjcqDElYep2jJUgo
   /QnNpcVf1M0AY5VzbNglP0G2lW4AtR2be4+fM/v8rQtATq3Ujbo1cKCCo
   ZVYq4liDYY+R2dSo/MiZgjMnHvGlFu2qHRhXUjz1vPa+753NeKIhx7IgY
   lFVJNv/jH0Y0gijnop/h6meofCjM8Foyr5mms1nSba5jks4QpAlBcdTgC
   guiZ7x+w19ePIbbPxDk8K9n2cyMTBptj6R+V/k9Z3jzjVe3GMMGUZBpOv
   Tn+Cmk+9rwK4M2mAXo4FG3yQ3Wc3Rhmn+mX6yJJYME1hRl9V3ToYnA4Lp
   Q==;
X-CSE-ConnectionGUID: Sq3MLfuJSKCquke5KViZJQ==
X-CSE-MsgGUID: G1MhBELWShiF8DHR40N6/g==
X-IronPort-AV: E=Sophos;i="6.15,272,1739808000"; 
   d="scan'208";a="85605233"
Received: from mail-southcentralusazlp17012013.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.13])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2025 21:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOBWwDv3eNB+6NAcI2LKJLrp3SbJ4IZm0+CQY1t2UhlIzw8XBNkuzy6fd6A5/b8YzHFsWVEfeM0bbSY4j5KHq1uwTjUhRAkTMz3hP6590j4woyNFfzHluoQkN/oUwGkKm0lmwq+4FcBLU2NNsohis+26S+rwIJxbDk2yXJ3RB/6qCipmKghPL6Rd51M6uV5kh7CoY2hSv6Ch1P/Tj0iSlhwlBludSMKviMHzl1T7vDNVvyHtMWadOCjeozvWeU+9UplWwvShUAPyupxDo0UrbIo42DhWd09c4mvvA1a3PxCUATvgjw2Olezq/MG7Z3VPoX5kWmhm/7nYOKYeXLlDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RA5c7N1pLlpY1QGNXWV6eHkfQl8wxGe36aW/cEt2nI=;
 b=M3wy1C0w6mEF03Z++B7pbUBR2IGFoHlTwXPfc1obvXfBd+UfXI+phpOXo6jkf+WuqYG7d+BhyvZMQM5+GR3cPQy6QzMpxJzJGNmSfQUHMyKwEabvSAAhzd7P/ZLDzoGio63bxUldTeeivnZa0v4JxOy5/MJa01OL38SDsXZPv1p1gRZr3ZqeBlNIcoUd33MUzFToj90CsMRXrsuPaMtHf0fR9jZRH6gczxtshtBqvZK0grRfngsWFr4FLLsG/JjbEU5CD58XMfgvtYpwKJCDZjA04vpxNY4nn+BTTLGHwAOX5pagzx00XqAe3l16fBM4GresLkVQUj0GlMZWrhPHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RA5c7N1pLlpY1QGNXWV6eHkfQl8wxGe36aW/cEt2nI=;
 b=z/oAWzRyhHuLRubr+EBn7olq1bJt9vf5PMQjEyp4r/QYXBgY2NJS6Z/YTKGfeuInNjbUtT6k9BFlNjHflIgRGLh6Tq0M4ZJy3UTx+yz9Y8zunPbiZivk/pSRFBOBkEAVvfZ+nXA18JU3ccoANW/JIuXjMscZ9ctCpHVfxmwoE9A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7666.namprd04.prod.outlook.com (2603:10b6:303:a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:23:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Thu, 8 May 2025
 13:23:19 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
CC: hch <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>, Kent
 Overstreet <kent.overstreet@linux.dev>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Andreas Gruenbacher
	<agruenba@redhat.com>, Carlos Maiolino <cem@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>, Johannes Thumshirn
	<jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>, "linux-bcache@vger.kernel.org"
	<linux-bcache@vger.kernel.org>, "dm-devel@lists.linux.dev"
	<dm-devel@lists.linux.dev>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hannes Reinecke
	<hare@suse.de>
Subject: Re: [PATCH 02/19] block: add a bdev_rw_virt helper
Thread-Topic: [PATCH 02/19] block: add a bdev_rw_virt helper
Thread-Index: AQHbv0hKmQdcedBEpECPa65/CSK0uLPHMpkAgAF/FoCAAAh5AA==
Date: Thu, 8 May 2025 13:23:19 +0000
Message-ID: <21a1dbc6-98f8-4ee7-91b3-e71feeaf19b3@wdc.com>
References: <20250507120451.4000627-1-hch@lst.de>
 <20250507120451.4000627-3-hch@lst.de>
 <a789a0bd-3eaf-46de-9349-f19a3712a37c@kernel.dk>
 <aBypK_nunRy92bi5@casper.infradead.org>
In-Reply-To: <aBypK_nunRy92bi5@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7666:EE_
x-ms-office365-filtering-correlation-id: 6b7bde13-f7b2-43d2-0ee4-08dd8e337fa7
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2Z1V3V0ZUxuRXBmbjRhR2tMQnRaVEFDTGRobDdBUndwT0ptZTVSdGlOS1dT?=
 =?utf-8?B?d3BsS3FkZlZqZ0E5VnplbTh1eVpnRlkzc0hFcEVTMWQzTWFHdzFrdEh3dHNQ?=
 =?utf-8?B?VHhCTStvZUxQRW9pTHcvQ28vekx4WDVISmlseGErcFVIQUhwMWhqSG1yRFRy?=
 =?utf-8?B?bnlPc2tEODlzU2haQkxUR2dDNjRYdUJoNzhLbnRtdG0xdkFCc2ZaY3NjalBC?=
 =?utf-8?B?WEYwYThvUXJENDZxUGcrQ2UwbiszSUpVL3R5U2tvQkk2RFR6UlVRRm9jcDN6?=
 =?utf-8?B?RnNvdGxibHptRFhGU2Fyd29TQWJlT2hKaGp0a3FCYytSU0dxWlptaTJvMWQy?=
 =?utf-8?B?R0FlQk5qTi9uaFkvcWxicmlWMkpMenR2UXMyQ2czOWp4ZHA5NUN1RzV5dlB1?=
 =?utf-8?B?M0g2UG5NSklka3R5c1RBYVJOOEU2SE5OQU02Ti82d21VNFQ1TGw3aXBIek9o?=
 =?utf-8?B?eFEyRUN0V213Ym1hSGJ0VzROZ0JSV0tEZTZCM0VtcUN1cEQrVWJUUG9MV0Rq?=
 =?utf-8?B?cW43TW1NRjVtVTNCOHZDZTVzU2I0c1pNakNEdHpPaXo0RzBoYzUrZ0lGU3M0?=
 =?utf-8?B?ZEFYOTFmVnlUL1N3QlZpcmJsYU1EQ0xHdEJsaHREeFRoM25vbkFubWlDVWxi?=
 =?utf-8?B?d2wzNXVqUS9oQlJ5cXBXclkzWXIwNWVuK2J4NTYyM2Jmb2QyVTNNb08vUkJv?=
 =?utf-8?B?Slg2dGxNSGdaWjFKYjRkOUkzNWJXY282NVEvZDFERS8xcXQxSVlpdFJzLzFO?=
 =?utf-8?B?a0dydDZ5dkd2Qi9YeHlNQVk2MW9BemdkTSs2b0FpWldYQWhHS01YSmFucE5z?=
 =?utf-8?B?R1NTd0ZPY2E1MGxsZlpSRzRzNkdIWVdENVpwNG5ReGM5ckNwbjhkVTR3bXJm?=
 =?utf-8?B?MEZzVlZGcWNYbTd0em8xWUY2Y0dmMjJvZWd2QVp4RWRQd3FPUWVKcTJDWkw4?=
 =?utf-8?B?WjF5TFczbDR2andJVVdWYXZpZVkzTWtjQVdOTkY5L0RFMUM5OHl4aElnekFs?=
 =?utf-8?B?L3dvWTVPems3aWx4NDh1ZEtqdUI1YldZclo0TGs2SGZ0NlUwSE9kUzg5dWdV?=
 =?utf-8?B?a3VTVnFHVUZ3TzFnQUpsd0hDTmZZT0hFazR0OEQvRlRZUTU1dHM1a2hXUnRK?=
 =?utf-8?B?UWN2VzVBMkhQVWVnTklFdnJydFBuL0M3WHFVMCtmNmNHZEIrV1paRjlkbjVr?=
 =?utf-8?B?VkZSaE1WcTZTQTZsVWp3Y2l2dXhzTEl1RXBHY3ZreFR6VXJzWGJyVWc3VFhN?=
 =?utf-8?B?Z2VBS2FNYk5iNmVIeWliOTFtQ0orRHRjakdVeGVzMWIyRVVmdjdBZjN0NUhy?=
 =?utf-8?B?NjNWb2pNdjJMRVk4NUtuejJpUjg5S0lTdlZVT1NaL2R6N1VJbUlGb2xxQmpX?=
 =?utf-8?B?ZDVqU1pjNkxNbUR0dG9HL05JcVJMTHZ1ZWFjNVNjcjZ6RXNOUC83RFYra2Jw?=
 =?utf-8?B?NTlKWkp3U2xwWVNTa00rTHFqYkNkak1VeXp2Qmg1SGNqTEozNHNXb1prWWhW?=
 =?utf-8?B?YW1FRVMyNEd0MzdraFR5MkxFMGIxODhmeEIzL0J6RWp2QUZNZDU0b0ZBWVVx?=
 =?utf-8?B?ZndLbXk4SG9tRnFlK1h1K3JpN3pUMzdnL1dGSmp1TzRFSDVMQ2hzTGJvUTBK?=
 =?utf-8?B?YlZOMUI5a3o5bi9sRlIyYjAzcVRaWFppWjBBVUsvcFQ0ZTlYZmtMZW12eUpM?=
 =?utf-8?B?YzZxeW1RUWFUZ0dOWWhPdkd0MDVyQlkrNHB5cHQrT0VHbTZYQzBFYUdkdmlI?=
 =?utf-8?B?cVMyb0hkMXVzTGE4US9QNHB4b04rUTZtWjR5dS9Ub3UwNU0rdzJRaG50S3p6?=
 =?utf-8?B?UzJ5d0ZoNWMrUDlXSGVwUTZobklXMktYeWlYUFJPeklFZDN6MHpUVkR4MlZu?=
 =?utf-8?B?L1g1MndhbitoQnhhM1hGSGp2OE00dHYzaWpBMTZMRUF3NE9maEpLdk5wQ1Zk?=
 =?utf-8?B?UThGeEE2amM2eS96bVdJNXZhRTVKUjhJQjFiMHZvWmMreTZSSFhkS01oQjZJ?=
 =?utf-8?B?STBxV1hYZXVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWN4NGFMUGtycnNCNS9UTW82MXo2VHl3bGtOT2JzVWVuUnp0NGpUU1BSemRu?=
 =?utf-8?B?UnpKRStrOUM2RzBWQnJnTmI5bjU0ZFREcUsyMUZpK2grVHZsakU3Q1NwVlRr?=
 =?utf-8?B?cEU5djNXcDdjbkl3Y1U4emZPZnIxU0dKbEExSXUxZ21rR3lkWkd5OXpoRS9D?=
 =?utf-8?B?dGc1R2FycDI2c0dZckJUYW9iMDNNWEE2REpEcUtjZytRSDVCbFl5bkVOMnJH?=
 =?utf-8?B?eGk3K1lxTVp4di9xdWVXaXlNby8raktoVlZGWTlaOElDVy9JVlErZU5DVkU5?=
 =?utf-8?B?cW42dnIrNGFlZno1bGovbjlmSUUyRkRoME45VllvdytHcWJMaDZ5aFpIN3dZ?=
 =?utf-8?B?a2FRTUgrRXJ2VVo3RjVIaE1Xbk04L1JaN2JERVhmU013b2dqUEFaL3RhVmJw?=
 =?utf-8?B?VVZ5NzBjTEpGT3JITWU0a1A5UVA4ZlREM2hCV2wzRDdsRDhMaS9lTFVkenhW?=
 =?utf-8?B?YTdSclhIT3piTkplK05USHNTK3ZBeVloeENMMW1ES2Y1Y01oWVJGR3ZualIv?=
 =?utf-8?B?eWJMN0I2cWVVcUtETVNEN1JDWkhRUlM0b3RvWkQ0SzVRcUpIQk1GUU5INmla?=
 =?utf-8?B?MU9iVFU3WGE5aHhPNGJ5TnJhUjI2M1hGYTVqVXJheTR4ejgxQVVNQ2p5UTN2?=
 =?utf-8?B?UUZ6UjRGb0hScnNMYy9Id1BwM0h5eWVwa3Nqc2pnRjVZOUMydlZNRzFCVE9R?=
 =?utf-8?B?Wm1PRFdNQlJkQTFJMEUyVkhNWUNhR3BQZS9wL3NnMk9UQUtUYWJNaWV5eUVT?=
 =?utf-8?B?QzBPOGZ0YkdBM0ROc0JaZ09MVWZoMGpoaWt4WmtqQW1lU0hHWGt3S003TGIy?=
 =?utf-8?B?YSt2VFFDY3JBM3p0eDJUcHZJS3VnenNyV25YZU1HOWhVWE5hMkdNTXRoNkhy?=
 =?utf-8?B?Z2dDNmlBTXdjTzdocTdlWWVsZVJ5dGF4Sy8wd0txOUN6QytNZ1gxOVJlSkZH?=
 =?utf-8?B?MXNFYldUVzltZWJJaWh4MVBwNmpQRFl3OGdNa0VRVDJNUE90TnkxL0tQdEww?=
 =?utf-8?B?bWhPUzFiV3lSekJiOWpoK3hQVFR5RitDdjhMVDJOWG1MQitsQWRFNXJoaGVJ?=
 =?utf-8?B?Vy92aDZoSHNYczlBNVRqdDFuVWVRNDViVmlXaEsvL3FlUTlzYjVnQ1ptOXZt?=
 =?utf-8?B?MkFFYnMrS2pOcjhORDNZU3VoVWtzQ1A2SEltbEI3YkZSdnlEcE1YY0tDRVpl?=
 =?utf-8?B?SThWLzc2b1ZKamNNWk5aeUhtRzBNOGxGVCtxTDE1SUlDbW9Od0EvbXFqaGxw?=
 =?utf-8?B?dmV4QjBENHRXNnUrZjdsdGo5OUQ4aGVrL0ZhTDljYmsxcXVyNlhrcWFGZXhv?=
 =?utf-8?B?NG1xbXgvRjh1a0M5K1RIWmUveTVnajdOd1VsN0R6MVA5aXg2a1lxMEhTMW1O?=
 =?utf-8?B?SUxRR2pWVDR4bm1WQm92SzlvUy9FbVYzdE9xMjZsSFV3Y2EvU213KzhIc1NI?=
 =?utf-8?B?L3ZtaDd4cFhFTllkOWN6NzJESWN3M1Y0MVM2R3ZaYzAvSVlrbTV4R1Vvb3ll?=
 =?utf-8?B?LzVYK3NRVk04MTdTSUt2MW15bTF1YU1hYnFhNmdMUW52cDNIdUxiR0hhODFC?=
 =?utf-8?B?MEhWeWhkWUdmdzd1RUZEOGFPZlVyb3R3dEZRMjNjODlqMXMxTUlEYkJkbjYv?=
 =?utf-8?B?TFZ5UVNpK2RyejYyaEtoUlRERGhIeGQyNVZmL1RIVk1iUW14ZFovNEVaWTRT?=
 =?utf-8?B?a0todzFiMk1rck40TXY5blIrZTZpcjBHTy9kaWQvcXkxZk9WaG0xTjdSdUJW?=
 =?utf-8?B?MnF6dWNVckFhb29aUmU4Si90UWlUVzdjYUlIdTEraTd6REw2WHN2cmRUbzJP?=
 =?utf-8?B?bkMzZGFSOFFTWCtoUEQxczJoZjlYMWIwTGpqYVRJbHZrT3JvUHM0dWQySksw?=
 =?utf-8?B?enMrazN6dkl1WFo3N1R1U0ljN05QZ1UwMHQ1djZHOEZETFRzZFBmYUE2eHdr?=
 =?utf-8?B?Vk52Y2FmcGgzdFJlKzhoZkp6aHl2ZzZ5a0w2T2dYYWpSb3B4Mk1ablRDbCty?=
 =?utf-8?B?L2NuRXVZQ0llKzZ1Rk9hZ21lTWxDaHBaeFdnekJ6VUJjdWZuL2dZZWNVVk5a?=
 =?utf-8?B?VCtkd1BsL0ZlS01GL050T3VEc0paejVMYUp5em5kaDZOcXZua1VNNEtnYjJX?=
 =?utf-8?B?REYrZmZDY3pQS1BoNGJTL3NnWEp6WE1hanptbWxaZmI4VTh1WjZYb0Fxd3o0?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5622B6E6F8AFF48B32E7F53F6F66647@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVb/Gb7wAuqx6EQHOOT6cnQFTXt0IcE8UK2mVCx0NzjSIpsCwUVkfgzde6PjmV8Tw/idy/+Y0tG/bGT2mJes4JPBOq9SpRymDqYJrEmLachJHVxlZAg2vSPCNf2PdZS9RLIZgqMgq0lI32cB7O0/5U0mnjldbZ6gdwQjdNC/BATgUMprvvuzzc5ykSBJSri+0T4D/tRZ3EDtQfrsoiZobCOLut6D0r0oNMIIWe/hGLwJ7aT2p8kpkJrzu8KD7EibLsGwzcsJV10pj5J76BaH9QvzMAY34NLGLbYRJylPy19sQ0Y/JihNWJDAcovvh/o5kjQjT9jOThWuJzYuDlfAQz75QD5LqFlfrNfxoeA+mBP4vcO4ttmIdgW+WkQCIVMaa+M9krxWEtVTgDumkAhI0jNkteJRypNPoKwWkUITqvwMRvnQjpSpg/+PR2URXpU8ALB2iPDA+xVT8a3LNP1PgeNdQS3Y+EIQZIyo/LrjyzxcJu4ZD0Ku2CpuURy0Qd3c7QQ/riwDqhUi2BdUUJHpfJ3sIdT/dh+SB9cG/5K3i0Y3etB1oTHnR294BSB8BZWyt+pZtbPGv+4UsSXCOUZ6AUk35DjOKhTJg+2JBVQ9jVpaTU+n/btuOBL/quQEP0RJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7bde13-f7b2-43d2-0ee4-08dd8e337fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 13:23:19.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iKodvAaXbQ5VD6zGCjucO4W+4IYz5UkSGLzZHHEX/2/aDpy1lRuCzEgtly7Wgza37hrZ/bHeXxT/E7ES2nC/I90aFLaSyO5Ex4lSS6ZpKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7666

T24gMDguMDUuMjUgMTQ6NTMsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBJIGNhbid0IHdhaXQg
dW50aWwgd2UncmUgdXNpbmcgcnVzdCBhbmQgdGhlIGFyZ3VtZW50IGdvZXMgYXdheSBiZWNhdXNl
DQo+IGl0J3MganVzdCAid2hhdGV2ZXIgcnVzdGZtdCBzYXlzIi4NCg0KZ2l0IGNsYW5nLWZvcm1h
dD8NCg0KL21lIGhpZGVzDQo=

