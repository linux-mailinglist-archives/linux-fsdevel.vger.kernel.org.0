Return-Path: <linux-fsdevel+bounces-47505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE5A9EC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3923418841C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75DC266EE3;
	Mon, 28 Apr 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iB0aYg5Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gXjgYK4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83925F7BC;
	Mon, 28 Apr 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832322; cv=fail; b=mdtwHBNEXfh9wiLdl31l/JU0N/zglhd0/S8iLt+VeUQKe3qIv1pM8k77AQoDY2Wz6AuEpWUPeu/DJO5qpskXKh3FoBbOMoumruv2zeS9l20L9yqZh4WyIdK+KNor0Wv4+Knf+cAS8pQer8uouBxieddUAWrgPziiRDsi5ldxIak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832322; c=relaxed/simple;
	bh=oX6nXmeBS/Juxjb3OgiZnajNxDLm1ZaubWkzP/j7Qgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CqH9330MYrWQKcWdjOpmNubh/4oHLpL6Ayt53efzKjWlXfVnxgGlFWCvgHhFWXsNk4YSY40gGgO5iobF3b35GfYG4PBzFCAF2HH9AFCiTjUDPKJd11JSaRW8KdckbUSD3Nq14O1UnRWv4ZzucLGZONOzS8VLC+HOJI0WuqYcLvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iB0aYg5Z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gXjgYK4C; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745832320; x=1777368320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oX6nXmeBS/Juxjb3OgiZnajNxDLm1ZaubWkzP/j7Qgk=;
  b=iB0aYg5ZgFWyQbnVKVOyxbFE7cG8VwT3N0vZY5E2BuEmW1tTPbtlOC/k
   /hfIY7NJUIUBf/SV8LrbKSQr8P+XW5uY+FjGT/ajeSS3z7pyeZhfVS+af
   lTL1YcSBmYNQn5yxSD8TvAti6SOFAQ268RsRtqjYonpyS7gfEnKorb018
   nCeFxHowWEkeAQq3UCosIFUlrmFsxM9iLmg8bsQDAoZwVTGGv6PtYuOR3
   F0lJldbEaMO2CNpcbEUN3nkND4TEKW4n48tJGzWdhPLEHQsEkPd3pEVEV
   TdFnjtAeVCJqsBcA+b3K4EZ+2OCC5+zYMFXDyRgm5JCpIgNRJSLIb5QMD
   Q==;
X-CSE-ConnectionGUID: kLupZn4oTqaGgf4jrcqyYw==
X-CSE-MsgGUID: 9pFFNAFyS4qNzH4EyiWHFw==
X-IronPort-AV: E=Sophos;i="6.15,245,1739808000"; 
   d="scan'208";a="76688501"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 17:25:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSdKaZ5iFoVmV4VjQDo8a6z2oIVPIQ6mITpwAMk2zSVFUbq84SwzRoA5mBdEd3VzMoqf5F8BQeO1BH3RP7LAw16RpfazoYP4LFdzpk5jTciphS8B4JkMOqZ5lykpDreTIZvy1R/wFtMdGif50W21wNoYVDKZC7viagBw7FRuCA5k2Px0wfuO+WoAuBU1vTlXcG3u1oQntPSSscUgG1+yA/y470eWPg/d5CQL0R+f3gV8dfqdKJpcWvrAX8AB1lfz8X4WfbYxRD1bQOLVS1r2uVhyklqeFiZpmU8QRX6x4HEgRob3/qojpgYgNUhr/Nf28yUQThg2GDStf5Bbq7vwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR9wgLkVZkbE+w9MPva/OMGPacKKZD7ap4VMuuIUVkM=;
 b=YAyZhdrK/5/prpHOU6TiYxdOrhPO+fvg9tSSfb2bO0oynxdSDnnRKh0OXEmgqmddBizWxIUgFm+8VIS24//el+JhWrmIjlhPLFuvH0hzXvOqYAEy9+uOWEddyPjxT5DtWx5jKP7+dovIqNFSo8l0NYWz0M71K4XwAp79Me+V+My7XCA0sCChQRe+6hZst24ySGugY02htSFUOj20rcUxpm1J73Qb5GT/bJskFIJ8UdjDTUJNLHcGoh2CxDzsY4yC0frTZL8fQ6ZXGH/RgVKnoq/vboQQe3Fyicuig50yCwnUAr4/hsdMcpaVSYuW5YvZMHaujvvBVR4uNPInPoqPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR9wgLkVZkbE+w9MPva/OMGPacKKZD7ap4VMuuIUVkM=;
 b=gXjgYK4C5UVaM6Od69EdkihiVMhnqHTkJKoHtCVLImNQAWwunzXvAhyG0yliGXike5s5uJXXIMOMFXV5hpHHSAJfjkP3SMYoJR4eC6gvaf3AYieKr8pglKSx/FjwuN4s03iM2QTbIaV/WJDfVVgTqaEGbUEXBApBNJiDecFbOrU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ2PR04MB8535.namprd04.prod.outlook.com (2603:10b6:a03:4f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 09:25:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 09:25:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, hch
	<hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"bmarzins@redhat.com" <bmarzins@redhat.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>, "yukuai3@huawei.com"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
Thread-Topic: [PATCH blktests 2/3] dm/003: add unmap write zeroes tests
Thread-Index: AQHbl9iSuzW1B+y3X0qB2g4C3g3UvLORqIwAgCcUv4CAAD3pAIAADjkAgAAFxYA=
Date: Mon, 28 Apr 2025 09:25:13 +0000
Message-ID: <pbuxtmwqk5bdmxckwwkjob3lh6mg3et52w3xdvsnjjwmofschm@pkotcbnp4ypt>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-3-yi.zhang@huaweicloud.com>
 <t4vmmsupkbffrp3p33okbdjtf6il2ahp5omp2s5fvuxkngipeo@4thxzp4zlcse>
 <7b0319ac-cad4-4285-800c-b1e18ee4d92b@huaweicloud.com>
 <6p2dh577oiqe7lfaexv4fzct4aqhc56lxrz2ecwwctvbuxrjx3@oual7hmxfiqc>
 <a5d847d1-9799-4294-ac8f-e78d73e3733d@huaweicloud.com>
In-Reply-To: <a5d847d1-9799-4294-ac8f-e78d73e3733d@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ2PR04MB8535:EE_
x-ms-office365-filtering-correlation-id: 36fcb551-a641-47ac-fed1-08dd863694c0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Z0VzYIIgHU4EAWOLL10s/uByuNeC8bRqrYId1qm252xs6F8YKYfifSzG2h5?=
 =?us-ascii?Q?k6GvPiQDQJ1FRcKPTDPxskFwhGt7cXdpbs0lCeplnnuUPG12QvBHCQIilszL?=
 =?us-ascii?Q?dfVDfubVpzZAV5ID0EDifUta5TvL9e28tHr+CP6cP3tZ0+tiJ5NIQfqribnl?=
 =?us-ascii?Q?jnlzf2/zOG/u//+1KkN5Rk1OkZog0lMkHPW3iTs7EintNGlA7wIR4bQC9/bq?=
 =?us-ascii?Q?zTkNTyTpy0VWtSEuqh4HXQ4PZylVsCaJqtPTUjdxDpKdnH8GGYVaRODpq5iR?=
 =?us-ascii?Q?m47OVbGu+FnHdNAohysqSZ/IJQMGDXpgrZTzTcyZxEXhJCgUY03KeizD6Eft?=
 =?us-ascii?Q?c7V9qpAzerwAO06xVhODWwnwzV3nSz++LS5YdVRXES0wveXLB6lASRvMQXr4?=
 =?us-ascii?Q?XikDQVOIOq/Jwo2M6E3z4RUkE168Ay4eASehGEeN0XeMYoaOoD2YfwzyZ1gK?=
 =?us-ascii?Q?HLrBF7uXj375FyzfoFQ9lbwhEFZ2Vw7Hl2F2eQhQWuFrju0YzzGil+Po8oJg?=
 =?us-ascii?Q?TjvJoKDKlJYW7UX0U2MfS8vEsCnCVgmoqBzB4yZXaMEBrtZPUGwjfffHL4VE?=
 =?us-ascii?Q?I8y+mEYd4UdDB4h9NdsbmVy6kZzLyO1jtVv/K4j9qJ6jtOGnjfwboXjOC3Ki?=
 =?us-ascii?Q?po/qGbczeuw+pocBgi9ryji2eZHYEQcyDKNqtROtSEVCun5Eb2k2hCE2Ma3S?=
 =?us-ascii?Q?b9Md6HUm33/OLF/QGCVEvAknkbfkM7JDEBQ98D++4FOzEkqISgKfFryB705a?=
 =?us-ascii?Q?tRjeho0osARKSJhHm0VN8hN1VaUi9L42HWaSSJRw3huqENaM5wxAEL9LRbXW?=
 =?us-ascii?Q?GwqJ8krhcRgKjqdTBw8DxXgsWmRAjf2kgZsJboPPOGZY+ixR0d7a0ITkY0i/?=
 =?us-ascii?Q?02ItctBijpXzoZ8RmR34fNKIgOP6K30x5YrlQK7G0nh/DibaWBAU4wU2jqa9?=
 =?us-ascii?Q?silPXDQJoAc5Ecy+DS3hbO/Hl24nz8vOPOtFQGQTXZXJy+5IYTnhLV5uzh0/?=
 =?us-ascii?Q?ete/0wqUilZ2JMG8RuKJW6i0gw1NiDv8pFBKomGmhRXqrHc+dME8eI6S2u7j?=
 =?us-ascii?Q?j334DOTqoqJO9bWwAebyAdkspnStL5v8+itTVrquXEZIYWBlD5gghmKbJjU2?=
 =?us-ascii?Q?mus/PfVFXmcRhx/+iaHBAG6RF46pouzJ1PFOhLqECNrcFn9WmFczSY1Cap1c?=
 =?us-ascii?Q?7ulK1+YAXKvsDSMIuxv6eMw4/RyH+1hSmWQj7RQ4/v5xCufQaL3prCesBYI+?=
 =?us-ascii?Q?eMJobnnQu6BP0k7nBtfZvR8NYdOmOFeBTq/riH8wn4XgFpObsSlDrkkxXHkL?=
 =?us-ascii?Q?D60KErCkgYbTYB3LAvPCb4+SQrsPqFRbA8rQCJAv8s4virSV8nY6pMHUw20Q?=
 =?us-ascii?Q?YGzYETJXDQ9QPcq4lVrnWd9qBiuiHtarOA/l+P8ZoQpd7oQvy42WKqPZEU+L?=
 =?us-ascii?Q?WrjHrCcPZSydzogFZSYd/RVu/iBu9Xwp+qx00uFAd8rPUN0QOrsqfw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s6ESpwzyDOVkmNDYGOGhPKBUJf3XwDABDSGiWXTozoXr9KRsAeEB3cu15gjf?=
 =?us-ascii?Q?9Mb9jNbZlRZ94tRfJVmXqfUXc/KA1tW4afLqPYoHoJNaa6c0bDr90txUskPG?=
 =?us-ascii?Q?5LxQtb2jrou3D30Ir46A/3MVY5jcWL7B3KfaqQKHg8HXlT2Uq1//D5JL0qOx?=
 =?us-ascii?Q?VIHJALInFbn0ims90n1yWZ+4nk/n45n4oZGKuAL8CROMpmh2mLKRKLHID+W7?=
 =?us-ascii?Q?kZXR6WclYI6jVVBKmgweHw2FTV62qZCIY6BMF1+BJ2GVq8OsGWegOE9Yssu1?=
 =?us-ascii?Q?+TMaGGxn19pPs+cuz4MkQGmtTzzoYH4G0uVnNesxDx5WZ2eFr4uImS+TRLiJ?=
 =?us-ascii?Q?qB2Xz3QKTiUb8VmWmqUPpUZt6+saoxG1L0l5KeASQ5EFuz1VsrI/y/dsM/fq?=
 =?us-ascii?Q?cBeNa70V8ksMmIiy3oazbXLm5+x41QVdvKNxR2bJcdttzLYD5sbZ7O4Fe/sk?=
 =?us-ascii?Q?V0k2ddP8Nn5S/IkynmR6Hs0P7ClyuErrr1CDw6kHTwtvgViOAtrNORagqMVo?=
 =?us-ascii?Q?RGaO29oi3jsr9B/jxQPdHq2L0Dw8mid33gN2WY93etOfArg76CwRXUJCdrnI?=
 =?us-ascii?Q?5KgX3qfxTD3dnLUacP5AIga/7sIpU/py2bP4VK5Dn8ETxr+rCOAe3cCDREZE?=
 =?us-ascii?Q?7V88q6/CQiO8qOPGJFyAuSXiT+jIUNqu4/ym4VzHbiZaG1ZeAC+MULlsBocZ?=
 =?us-ascii?Q?ufeijcrmguupvEhAo7fHys/tRvofw0ZBJEKxtkQAFK7vPh0wBZzFrVpRWtIW?=
 =?us-ascii?Q?Y97GOstyb+F5fw3E5sVJ/657B7ZVh+CUKGtC0VM39bYLLRjfllHJ1eHPUlZM?=
 =?us-ascii?Q?nSo7+hpdoKCCq80w27gMwrdJhOvk8DYWryaXJrl/nsQAOvrsw8jGme4+mhpP?=
 =?us-ascii?Q?KyhJ/0PjOEd67WXJEan+3HvYVsopURN/msCFQJL9MM0Uk2JLW3/XKZLLDkW0?=
 =?us-ascii?Q?5i/ve5b2AM0982MFOiPCxfOUa9ofn8BvcQcaF5mU33kq6VJWI9yfAx/VtiSM?=
 =?us-ascii?Q?fWuUDUvaZNodunnkU7HYBw/q99n4w7v1+D13GkmxUp5VxpGJ8LoswIBj5zny?=
 =?us-ascii?Q?htgDb2+m2tZBXNDkzMHq7q0a8I07qaZzY3EPVkC2gZw08FxMkH2MQL2ReS2a?=
 =?us-ascii?Q?my13Ps/BVdcOtXguh7Pjiu2YEFGqmfohvIu0REw+TfBqWgEJJrPh/+Q8JiQO?=
 =?us-ascii?Q?zg1/5JoW0X8iwgfutPlDpE4FJFkVE4HulIStkkybNIAu8JZIfUtT7YHZjS5a?=
 =?us-ascii?Q?XWXH7o6hB1q0PrqdXZMgdaeqsI2wbj2lyjEPmGJ1+iJhux4lUs+1J2cRq8Fn?=
 =?us-ascii?Q?XuE9cYvy1eQnW8eVmFzcKpQMU+EBIlAmCHRRB8LTIZclHiJCK9Bgey/StQRK?=
 =?us-ascii?Q?0mtHB/jAGemuLTPbYVFSvZhC/R8eAGfO+3iL0cr2rjODSjE5ohfGkiKfUq91?=
 =?us-ascii?Q?ICKho1+bEO6wePkF6o51rr+6uZR+LysE7X3IpzjIrhE8KTucguaAuczElrWB?=
 =?us-ascii?Q?uPI4Q6vyEkpEEETcDKjB11Efr7b9erAWGxkkPyYGNGxcAir2T4tSEsF317BL?=
 =?us-ascii?Q?U+WrygHA0ETWt2rLjiEb18StczzU/mHUyeCWHo5/o3CsvBABT9vONXgPoZe4?=
 =?us-ascii?Q?ge1cs5vBlRdmd0eaJ5sOZzc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB648B97E4A7044F8780DE4778F92023@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XxGo3dX+VbqXcSNcc0ltxWRXJ3F9kAIG0Pqiijx6wjB6OOVH9q2EGU7CS7I1ufGOM9/0OFHDDDmnqVCpHRttlvd7UixapowH8PnE5ebKHFeiz/WZJGJjo7E0Mzb0MTXUwgvPdN6F4F4tabbsoKIfxQ9A2RTCCVqsB7u5+rNg9+dFCNStpWNgC2S31vK4yrQmrhAxPG8cOBAHLw83oWAl+lgRhaXoOLYiNlgMtVglnz6oqOzGI0GbmGn+Ge9EVYvY+fUFFPbM3kfmgLHEJOTJbNTB+f0Xxb3dK98A29KE0RUwA+5tw1Z2zgKos4QxzBdQ0fq+9XfKtPxcolpJBIfOn+9uECNp3NAacOKSGF33UadpskMTyXlqvISgK+OmH3kONV+iRLpO41J3vwz71Du/j+32fSJpjxl237siV4m8tTEbesilmr0cORkgey1Rms67WZPrTPpZ+JshIzAfT1U4VtXDQy6c0D4Wk2NJpp7MhRAbGQ9+ntNssPp4JDVEaYMSgF/lAFFTpLxiaDIR/uwhzRscIHYyb5MHDI+mqA2Ddb3yYsTN25y0OZGiRzBIO7s0tbAAkXNxvzLgjMecyL9U7pw8ikoj/g/d6PZ7cABtpYxQTQEkrLGDiW86a3SjtiYI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fcb551-a641-47ac-fed1-08dd863694c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 09:25:13.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEXtk+5X5HfVtp4OVGK4dMm48wN9Afg6gv2e4a6A4a1WArcN4PkPWMQmJyzST/ZKNND1Z8YIHr3MaNkKJHjStOBXw+kATm6MH9SGWHmfARM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8535

On Apr 28, 2025 / 17:04, Zhang Yi wrote:
> On 2025/4/28 16:13, Shinichiro Kawasaki wrote:
> > On Apr 28, 2025 / 12:32, Zhang Yi wrote:
> >> On 2025/4/3 15:43, Shinichiro Kawasaki wrote:
> > [...]
> >>>> +
> >>>> +setup_test_device() {
> >>>> +	if ! _configure_scsi_debug "$@"; then
> >>>> +		return 1
> >>>> +	fi
> >>>
> >>> In same manner as the 1st patch, I suggest to check /queue/write_zero=
es_unmap
> >>> here.
> >>>
> >>> 	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_un=
map ]]; then
> >>> 		_exit_scsi_debug
> >>> 		SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs =
interface")
> >>> 		return 1
> >>> 	fi
> >>>
> >>> The caller will need to check setup_test_device() return value.
> >>
> >> Sure.
> >>
> >>>
> >>>> +
> >>>> +	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
> >>>> +	local blk_sz=3D"$(blockdev --getsz "$dev")"
> >>>> +	dmsetup create test --table "0 $blk_sz linear $dev 0"
> >>>
> >>> I suggest to call _real_dev() here, and echo back the device name.
> >>>
> >>> 	dpath=3D$(_real_dev /dev/mapper/test)
> >>> 	echo ${dpath##*/}
> >>>
> >>> The bash parameter expansion ${xxx##*/} works in same manner as the b=
asename
> >>> command. The caller can receive the device name in a local variable. =
This will
> >>> avoid a bit of code duplication, and allow to avoid _short_dev().
> >>>
> >>
> >> I'm afraid this approach will not work since we may set the
> >> SKIP_REASONS parameter. We cannot pass the device name in this
> >> manner as it will overlook the SKIP_REASONS setting when the caller
> >> invokes $(setup_test_device xxx), this function runs in a subshell.
> >=20
> > Ah, that's right. SKIP_REASONS modification in subshell won't work.
> >=20
> >>
> >> If you don't like _short_dev(), I think we can pass dname through a
> >> global variable, something like below:
> >>
> >> setup_test_device() {
> >> 	...
> >> 	dpath=3D$(_real_dev /dev/mapper/test)
> >> 	dname=3D${dpath##*/}
> >> }
> >>
> >> if ! setup_test_device lbprz=3D0; then
> >> 	return 1
> >> fi
> >> umap=3D"$(< "/sys/block/${dname}/queue/write_zeroes_unmap")"
> >>
> >> What do you think?
> >=20
> > I think global variable is a bit dirty. So my suggestion is to still ec=
ho back
> > the short device name from the helper, and set the SKIP_REASONS after c=
alling
> > the helper, as follows:
> >=20
> > diff --git a/tests/dm/003 b/tests/dm/003
> > index 1013eb5..e00fa99 100755
> > --- a/tests/dm/003
> > +++ b/tests/dm/003
> > @@ -20,13 +20,23 @@ device_requries() {
> >  }
> > =20
> >  setup_test_device() {
> > +	local dev blk_sz dpath
> > +
> >  	if ! _configure_scsi_debug "$@"; then
> >  		return 1
>=20
> Hmm, if we encounter an error here, the test will be skipped instead of
> returning a failure. This is not the expected outcome.

Ah, rigth. That's not good.
How about to return differnt values for the failure case above,

>=20
> Thanks,
> Yi.
>=20
> >  	fi
> > =20
> > -	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
> > -	local blk_sz=3D"$(blockdev --getsz "$dev")"
> > +        if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zer=
oes_unmap ]]; then
> > +		_exit_scsi_debug
> > +                return 1

and this "should skip" case?


diff --git a/tests/dm/003 b/tests/dm/003
index 1013eb5..5e617fd 100755
--- a/tests/dm/003
+++ b/tests/dm/003
@@ -19,14 +19,26 @@ device_requries() {
 	_require_test_dev_sysfs queue/write_zeroes_unmap
 }
=20
+readonly TO_SKIP=3D255
+
 setup_test_device() {
+	local dev blk_sz dpath
+
 	if ! _configure_scsi_debug "$@"; then
 		return 1
 	fi
=20
-	local dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
-	local blk_sz=3D"$(blockdev --getsz "$dev")"
+        if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_=
unmap ]]; then
+		_exit_scsi_debug
+		return $TO_SKIP
+	fi
+
+	dev=3D"/dev/${SCSI_DEBUG_DEVICES[0]}"
+	blk_sz=3D"$(blockdev --getsz "$dev")"
 	dmsetup create test --table "0 $blk_sz linear $dev 0"
+
+	dpath=3D$(_real_dev /dev/mapper/test)
+	echo "${dpath##*/}"
 }
=20
 cleanup_test_device() {
@@ -38,17 +50,25 @@ test() {
 	echo "Running ${TEST_NAME}"
=20
 	# disable WRITE SAME with unmap
-	setup_test_device lbprz=3D0
-	umap=3D"$(cat "/sys/block/$(_short_dev /dev/mapper/test)/queue/write_zero=
es_unmap")"
+	local dname
+	dname=3D$(setup_test_device lbprz=3D0)
+	ret=3D$?
+	if ((ret)); then
+		if ((ret =3D=3D TO_SKIP)); then
+			SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs inte=
rface")
+		fi
+		return 1
+	fi
+	umap=3D"$(cat "/sys/block/${dname}/queue/zoned")"
 	if [[ $umap -ne 0 ]]; then
 		echo "Test disable WRITE SAME with unmap failed."
 	fi
 	cleanup_test_device
 =

