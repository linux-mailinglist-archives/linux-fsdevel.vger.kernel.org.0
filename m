Return-Path: <linux-fsdevel+bounces-59775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B59B3E0A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D391A81234
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10292E0920;
	Mon,  1 Sep 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eiteXukL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Zn2GtVq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5E30FC1A;
	Mon,  1 Sep 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723936; cv=fail; b=aTT43rU16qt+3K++C6Qr8DxC87EjaBPq6OVkN6z4L3kTce5b/aEgjVTITJSjFxwoicTr88m+sVJOHo1AqmR4nl5QLjMrTF9JgX+koDCMzFO4srXNGnK8LNwrVd6EHNKwZPeAagr5B1U5p40T6O9evl3b1B+4wPtY4Hcibq+aOCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723936; c=relaxed/simple;
	bh=pv/Ywvuqt0kSwj/9blSpkUh/0jmE3IQqcJmsEP1Xv9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3Zoq3eCtQgx8vcTjyMqdowuDOkNwIc8wBwgsYrNCla4WuXSuoYUJatKbLjzu/md25WiMYIq070QARxdio1JyCKgzpMJMXtro/qnkizgXPlDyKVRjAc6zInTvOQIgHbXllwkH6wqo7YC6voUov3THurTOhjrpy93JEf+ADTdeyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eiteXukL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Zn2GtVq8; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756723934; x=1788259934;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pv/Ywvuqt0kSwj/9blSpkUh/0jmE3IQqcJmsEP1Xv9g=;
  b=eiteXukL/H5nPhTazt2pL8O0jlIXKAbC37aZAdKVQhCXB3fnAIQAEeHx
   TpGjhO6fScDdE+ww7Oz+mQt+J9R0kKEeG2ra0GCB+5udVaALdTz8gIOh/
   D/fm/J7TzYt3Httk/IPPjMVwCXIibDCeYlbxPnNbP5MAJDxgjOFb51NSa
   269a2vAPS6eKX9DJ3x4XiAJ3HaKQo6AApg4vZz1qPO+8bcg2baNpa/+V5
   REg6xFUe+CfL78EeJzSBmi5p0K0plZnonCN2S6cb9X8gupaMcM5ZAAC4t
   6pcmz/lR0Uy7I0L07QrfyPC8S8k/Ewbxluepxn77+idif5RQUweacDJFI
   A==;
X-CSE-ConnectionGUID: vKdisCkYQjKBNH6Tiv1yqw==
X-CSE-MsgGUID: zerZhaM9SnqyKFaffhAFqQ==
X-IronPort-AV: E=Sophos;i="6.18,225,1751212800"; 
   d="scan'208";a="106132133"
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.62])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2025 18:52:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKzCoEVg8EaoNjL594EyDVDutfk8RnAShnwC69kNUi7lYNw0GBpCHwlOwAljh0gbFyWquBxBuTF7E5u/TwGJI6HzryiGDEfJf5QHCh00WQxF5c6A13/6iMWnWIfroDAaNEGs/6uD+HxSYEEhVbRWdwM8a/j3HA4TSgklF6j2Xo8h9hrSmNmgSRpygeQtbQZ7JiywsNhY32VsTBBxxQNw6UpUBsp9ePDhyM+hdLzhcL58hFXtNvyEjqyw+0YcDkj3EeIqyD9k8S9cNL4FUfuxTcnIxBsSV2fNQfQS8KaYovY/SKKIed0XCTJ8l7GmY3HcLPCkQVDTu842TLYJSZ2niA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dBimC9VBoCG/rJ11RGOyl2h9yhUHtzD5N71ocOq2iM=;
 b=n3quLCbo2NXuJD47HLT9FEdMSD5lHSJ7zBBe1BJqwS30p/uhnr0SZOouzjctP4C+auIWCA80NAYoyKdYyd0tBqgaw+X8xn9hQnxhWgFxC+r8WejvG/XBrF/DUTEgC/R/OQT89taqTaVxklhi9l+VeJQfO9/9h/0J77EWIwEhKMt435ULOQQb3+oFqpEvrNP0UPiYkkNcKvHKBz8zyDmFr8ejDtGxnW5+xnakCD0Ejzdg4+UTI7rnBy2MlBfKm+xq2R9jpasU6uekPYb6bSGMQuSY4r71GpMvplnkWE9RDEyUMxc5Be1pSrPQiGHJgTsVtQ24moBDROKwZn5+QRfVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dBimC9VBoCG/rJ11RGOyl2h9yhUHtzD5N71ocOq2iM=;
 b=Zn2GtVq84b8gXDLon7l8eTt3TZYKJMswfOWNg0eRlEhsTnhVT8TBg5W8JyW2jY5+zhNvVPiiwMQoxBVzlAnVKa1BkmeErNobJpmdXm2M0FYDuwC43zmhLKeGj9gwKXa8U8JAO3JDtKqAD0kuMCbBo7fYMuOb8cIkuRijb5MJxL0=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by DS1PR04MB9234.namprd04.prod.outlook.com (2603:10b6:8:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 10:52:04 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 10:52:04 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC: Carlos Maiolino <cem@kernel.org>, Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 1/3] fs: add an enum for number of life time hints
Thread-Topic: [PATCH 1/3] fs: add an enum for number of life time hints
Thread-Index: AQHcGy5z8GIOy0dghESg7mz9iKIwIg==
Date: Mon, 1 Sep 2025 10:52:04 +0000
Message-ID: <20250901105128.14987-2-hans.holmberg@wdc.com>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
In-Reply-To: <20250901105128.14987-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.51.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|DS1PR04MB9234:EE_
x-ms-office365-filtering-correlation-id: 44d1c79b-7c26-4786-4146-08dde94596bd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KgjZURTMx2hJh8M2K9cdzS/jX3ueuMsAlUCU7ZOTwQAjWZkH26PGdX+g6D?=
 =?iso-8859-1?Q?9mmxvaVZCcduQRK9TsYJmO2jQnpDYnDks0SvCT8I2rG8ugXeZtS4WiBZOQ?=
 =?iso-8859-1?Q?o4DuaSoV1kovwPeDHMJgxiaNEGR/OlFftXNY5fB1qDE27qq9MizFTkCe1w?=
 =?iso-8859-1?Q?pfkXnbuA5GoX54by+bHrfe+qQGx5lex8dyK7ta/Fc9EnA6uGmsf9ktKewp?=
 =?iso-8859-1?Q?4YkXj7lc0253F89IM/Lv2rFe1nZT3WiqeSblnnc8nGyb5OarD1U2yZhhon?=
 =?iso-8859-1?Q?s6ggbIfXkX8mGih2k1Ag++TdfQfLtvzbJpwJZ7CwywP8DDF7Mne35JeFe5?=
 =?iso-8859-1?Q?BJQJaSE+PAt7VNn1MOQUNHGi/vnwPomqflCsU7Amusv7cVKLHFWmPDmpr+?=
 =?iso-8859-1?Q?+3VqjKUKvr2RFiw43p+vvT/xUrT34daqhMbzTYqARjDQCXZce/vtcK6BMa?=
 =?iso-8859-1?Q?wC6cGksRrsk+oKoMTedG8N4MYg3WdZGPMPfBqVuraQKB7TFbbNCNj7QhzS?=
 =?iso-8859-1?Q?WeKlFrt2wwCL1JVM9zyN48nEDy1J2IUz2WbhrA/9juXpeRL+5SMgI8MtGx?=
 =?iso-8859-1?Q?icKRkoDJvbwV2kGBISohj63b/SVDBbuQq4t8Q9fEQHGYILO0AG5fcjceA/?=
 =?iso-8859-1?Q?MTaSERUnX50ft4GIkUtqbr1GlQC6GOpWKggQ/Lq1zpB8TxS+JViv/xhPrb?=
 =?iso-8859-1?Q?2UVuir31+uBlLEoW6mddX1OLWwttuXbXaXXr/nhm2pAPpVk8Q6gktY2zVm?=
 =?iso-8859-1?Q?zS5Vs/essPDw0eVn0M6dt/GFqyz2kn0kbwxGbseQnP8h8jEoB8MLaRf+36?=
 =?iso-8859-1?Q?1HkfgCKdGUYxdgGFeKYQxU5T1XOoEREsC8C/c2+SqPzU6JX2DjtgUwkRi/?=
 =?iso-8859-1?Q?rRgKcXcuAb8nHGpFfX3ZfF3IjsY0a8MTVDjpi33eHC/35B2JiFNektsofh?=
 =?iso-8859-1?Q?PqgsppKZMSljfjgkDwVS+zvt5ZNcDbqJBfVkiTGmIODGFcwzDoFN2Ibs0A?=
 =?iso-8859-1?Q?+5SXfuakPrTO8sXim1mlcw2fFBSlswtlahjjnb2K+SiCwwr+xKJ8ETjLXM?=
 =?iso-8859-1?Q?P8HRelD1/1GM9TYnUbnf6drIc+dSiFAHbD13rS9hzH4Ucto1BQtjrafnl4?=
 =?iso-8859-1?Q?YOZfH95xaNSuK6X/L13et07DyF7q0spLXwh24d6Suf+RAUNVPsuYyheYKh?=
 =?iso-8859-1?Q?rvMP8wecP5HGVRbcl0bovvo+seGZryjd0jfXU3iZb9W6sdyCcjFjp+l/Mm?=
 =?iso-8859-1?Q?iv7hGbZY3vv8kt7ccew3K/f2DeSyuYhThH8rTmec9qI7F48/ZTivVbe5Gb?=
 =?iso-8859-1?Q?plqYsfRjZbEHNN+Pd5zp4TnxMJ73v19ZOybRykBemiQG9zJl02XXZUeNW2?=
 =?iso-8859-1?Q?4gdRlvGFraWobTtliqpITEqOlEWl5ajv795NCNafgRVVpfqqlM1HvE1mfU?=
 =?iso-8859-1?Q?FN0Ochxg9L3KaYgsmsCbK901RFgR6GolxWnQbgvykKAT7ZkA606Wh9DWZ8?=
 =?iso-8859-1?Q?u32ETpnZlW5gNKwl6EmZBjPL3ssvTGQbfiE2zXnVVNAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RIkhCaU6i28itU0FjG0ZzAvtHjufYz6u18roF7SniQOEjAS2KdSgdKA2Dm?=
 =?iso-8859-1?Q?IzagzONa6OjhTUMcaW/bsD6n7Oc0+9ZJf1SLQeHbd6DhlyR7J7syIxy5w4?=
 =?iso-8859-1?Q?jaF8Ri+mThyaRQOp0WoyFxYMOu9b32qQ0RLJqnGIGD0FWS2zYqZaHcmhQ3?=
 =?iso-8859-1?Q?d8/s3E0k/3ACefM6V+0R6C+t+6Tdinnc5wIlys8jVqgMAMIN37XkHUViO0?=
 =?iso-8859-1?Q?UvhDiifC+XiKoLnrFe5bolcRyaODOYBUbOs+cTYNpzuVf8im4MeVjvugJX?=
 =?iso-8859-1?Q?ho4S7H5y4gQxIEnn7C46VW8imPaWp/+pMm9TlklbNVrw1338kRR8Q+nCiy?=
 =?iso-8859-1?Q?IWneJvGEDqF7WoQyHMjHRlDzmycNHGaXC9CBntIIwB0GKjfzQOJeUZqyYA?=
 =?iso-8859-1?Q?+1lZ4Cr6qSP5HiA0aWSZJE2cHXAOEL3QJMS/SPA1AToEc5c45rwtgdGpJ+?=
 =?iso-8859-1?Q?P1QaNi8mobi4B/VEXKW6gFKzliVW0+lVq+kdNT8aqZN8jqUCyJYJ8lqPhJ?=
 =?iso-8859-1?Q?prTUfOgy0bVUPGeDjpyJnlLiKCvYjpL6znImYZTIivqFOQruk0Xntr6H3y?=
 =?iso-8859-1?Q?8kAXyrEXrZ7uKSP/GrP+E7UU6D/boXdmx5c3z8MpzC6M2hMveFA8ukNYIh?=
 =?iso-8859-1?Q?C5XH0rfCcVG79c16DN1mt4iUe4hp0n+IWVkgItJLPqMEL+xtwbJvVYqB3O?=
 =?iso-8859-1?Q?F+UpscKRau0surJoSV7JZgX7FC1/MehNMLc+/5JShB3yLxFH6p3Euqs21L?=
 =?iso-8859-1?Q?T/KUrRep2ofKwShGHQMgCbBsjXS5BRafUVVEny8KD17aq12+19/4UBMiOX?=
 =?iso-8859-1?Q?FlgRvOPtH8FbQ7vcs9PvGcf304p7nFZGpXnnG7WInkR6yZDREXI/PShTwU?=
 =?iso-8859-1?Q?SOTitQbnWVw7HsxjxUPkx82wAEYlwjiPtdREwpv+ve74XaxNlQrGk6wf3h?=
 =?iso-8859-1?Q?LCgUH6AhhtyCKdgS6aEpfhdpaWghs0ZuLHvGd5rhSDlNG2sCanswvWO5p4?=
 =?iso-8859-1?Q?I/Mu55v/vNx2B8qTDesNShCffFsmIxo3p68WKNKolEontYqDpDfOV1UJ/s?=
 =?iso-8859-1?Q?6nWPy1WJj+ad8sbnKyjWQgj75TFVc4VWDbsH0dJwJvRhRVulJ8HO2hrw46?=
 =?iso-8859-1?Q?6AZr4ccb/QYw2NK/ndXOIrWpRGInFEw2QS3umDNGNBFSd5ZaSoxtmVlDow?=
 =?iso-8859-1?Q?k4eonmbWXZZ8fxNmHHpPgIGY2aLodRGuPXcvEevLvI+vISdecyKL9+nGBh?=
 =?iso-8859-1?Q?5wCOJUGhUniPxLJLvxlVyrgqos3cJFVSM9RHQ4pMIDn/Svbgm5Jdf0CgYd?=
 =?iso-8859-1?Q?2QbvbiIwDq+OWqcR4VKM/xpTaH9eh/9ib5sJD4lvzBxxAF5pQCwats8dU3?=
 =?iso-8859-1?Q?RvnbiBM6fCMB0eukCw2SxhNpsXFdhhVs09LN+zKZQe4w0H5tgr1DRwzb5J?=
 =?iso-8859-1?Q?smhx1y0IZ+jv/iyTL3x9rl8RkGbv+G3Tpnivwym/mn8UT9jYKN1H09cCgb?=
 =?iso-8859-1?Q?/Auavxh/yPXty47CP1/RWUzwUQ4c6BDDSsb7zK97uciIdH1dU6rY526x0e?=
 =?iso-8859-1?Q?HBfJduy3Opw7pNtR4EIKvNnnnjv2HtCoFaVB+d1+HOHUkVXeuKXFJMZ3w8?=
 =?iso-8859-1?Q?AkfYQlBQa4JeCX5LqxB9ueiGAL5dD6F+EAzWx7iWTtQAoS9Y3qiYAnkA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XriVtJ2fjMveAjxa5WGgAbhkQlXq+51nv7f09uUOwC/vxReD8UkwahTwRCUW+k3bISMhaynLlKkngxTRVgNmpyex8WGPtJH7gd+YO9DZe1D5EDG2UBnXYA2RLX1wuMBNTXgyGK6pX7uVboyc1z16GRXNFZVPM10kCBgyOgRMw3Q5znotMx+gzVAteABR4Kqy3N4a2SKp98Td4cQCkvST1d+Daao6ZtOq4+yCVo1AH65cO/Jae7ixcl7iAmoCcBMCAg2hmoG5TINASwnsdRWSJqUG2Qm77IByIgo1tiz/Q89ckJ5MmmD0QoS95Ep5pF7MyLSBwLZdVtqXoo9ojM4YHi50J0WnHlzdrBaC2SU4ov0n3J2dxPmfhWrgiWX6pVZXtN/xOyl6g+OmM9hNtU1bT6hHw+1NvGiTDSpjC5llGpSBtHwgelyMUBLZvWVEt4pEw4Uw2VLn06B7dZtKNtEVwP9RumRQi31Ehjhz7/cxBBtSGs1dfiB405Gc1kN23ZlgnmAphCYhBLL4+/opz7I86uCfHn/HWTjVGr1pjqwwahNBEqqaLWhyww0GZgb6wulxBUvMo62lEza8cuLlwrFidhyzjL2QU4LvmOIi4RjuuFSrqWrGc0p+yqBX0t4RBI8+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d1c79b-7c26-4786-4146-08dde94596bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:52:04.1679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvOgIeir26QgXmRIYay68dwnnYpGiTafSSEluipIXC/9afBdwNUwuVQC+gkyIzmtMx0VFTgAUctqXF+nuaSDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9234

Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
values write life time hints can be set to. This is useful for e.g.
file systems which may want to map these values to allocation groups.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 include/linux/rw_hint.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
index 309ca72f2dfb..adcc43042c90 100644
--- a/include/linux/rw_hint.h
+++ b/include/linux/rw_hint.h
@@ -14,6 +14,7 @@ enum rw_hint {
 	WRITE_LIFE_MEDIUM	=3D RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		=3D RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	=3D RWH_WRITE_LIFE_EXTREME,
+	WRITE_LIFE_HINT_NR,
 } __packed;
=20
 /* Sparse ignores __packed annotations on enums, hence the #ifndef below. =
*/
--=20
2.34.1

