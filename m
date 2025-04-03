Return-Path: <linux-fsdevel+bounces-45601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89042A79CEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD813B4DD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CD4241668;
	Thu,  3 Apr 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YWUzBjwu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h+f4P0VK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93A2405EB;
	Thu,  3 Apr 2025 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665184; cv=fail; b=cu3TJhDTF7k5OQ8UYowqEa4hazR99VwFPRop4VAsWvWr56rkT6bF7iNiAxw8M7Q6MHyczStHeNW3hm6P/sVzNHMtrLDJGiic+cVNJIchvr4RhGlivNOcTr3yIWrlP9ibG22ZT0LcUuCsribngTR2eiQ7zQhK6oC4WrCvIFq0szQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665184; c=relaxed/simple;
	bh=VNE+s3gfJcXq80WStw6BdGdSGSEv59KpDYMq4lgzPD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJCu4ivDE0e8cOexuVJK31y/gb+gMKFLsZkOZh/9qB3hi+b2LKjyRvPKsiKcX33S8+erPOqLBn9MNjQTOK68zBv5irJmsa+BytpAAOq2NN4beiFuuw9ook9YuO/AKqr0mSYmpJ0NgPVs+JU43FnCSm1NZb01k/fsPZfZvQ3fjEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YWUzBjwu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=h+f4P0VK; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743665182; x=1775201182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VNE+s3gfJcXq80WStw6BdGdSGSEv59KpDYMq4lgzPD8=;
  b=YWUzBjwuFTx2VIvZ7H8h+65dT9NJEEeqVwAiK5eyJuZ1scCL5WVf/pg9
   +6GWYd6Kcxb06hPBf7pp61X9zvrSMD92aw/UlF4aKmS0QV1EuiCa03i8/
   q9KNS3PqfP73nnzUTSK0kL4NNt8A9pWcRDb4o0RtbrJ635B/Cd5ukuO4y
   M4p2EPJ8XKtQNGfTkkc8uqRTmP8MdQ9e1eXK92o/2h4c0mTdZWhcGPCoF
   0riGlNX7aiVav/kwwqzg7JVBfu4hD6RebQm4Lk0++xvm24nPV9eQLn6d/
   JPlkplvCCpE/afJXhLg2xn0SehOz4sjuOrfGJtQ+vTU0iDw0QkcqiT1Lq
   A==;
X-CSE-ConnectionGUID: laAfOlFpRAeNcDg+qlJapA==
X-CSE-MsgGUID: XpxXqSm6RNu2Dspo3P53OQ==
X-IronPort-AV: E=Sophos;i="6.15,184,1739808000"; 
   d="scan'208";a="68570227"
Received: from mail-westcentralusazlp17012037.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.37])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2025 15:26:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag1rtvCAUzGyJ6iP/JNoVCrw82hG7JSYaMUIB6iLHF/yaNLhw2VgLwgtmv4PimkieAp2bS4rIDamR0QjCoC9GwNriW33nyUkUgJ8siTi9WVAy0Tetj9s4V+e6Y4XIKMNtGwsM2PDt/7WzySgQfUkADLLdGGLwM+JBM1GaqfR1tQABMUaQ7+zvHixPHsdUpTeIQyKDeWJMCsDN8KNs5pWpHYoxumxS2isBHmylaKuUNPB6Spf31R/sMhuPUCTfa6k55mBRzaKryDXJaYNm2UreiYng517/YBW8Vz8vXNDPrcD7SGjSIGQXIrxC/PgOEpsVv9lXmRvx53dLWqlbMmHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiaf4iI8TxcpsAH9U+M9YUVSuOUeNJliuTGxpN6IA28=;
 b=A6k7tL+lc5KR+jV+fhwG7FEkY+DKr49UWPWbn+Yfdz2nFRNri2DxVRCL/XmgpjdwG787fDMhUXLSk+A6o5Gd/WQQWdN/VmELfWiMQOCEczIJxxmjNVnBoFp/XvTuejJDTeHQ5RNobCcPxf0brwdzKs+8rMZMgXu+8oZJjF50WNyxgeVzZ36uGN3r03/NdHNdJa0WdbyocyGaWhHaHtZRX2YIVuoAor4Z7SLhXJs7IP27xkKyBWbFSETWfAckTsvZIbNFIcDdJoUtiQ0yGp1+46fGZaHejJ+bY1h0C/Es9NJabRZb+w6nc1SWl/35qcrTEojSpU/2v87DHckoYRKlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiaf4iI8TxcpsAH9U+M9YUVSuOUeNJliuTGxpN6IA28=;
 b=h+f4P0VKfm/ORd7xLtGdrfUBxDkcP2u4TTZDH1qZh6q6bwSgMMYtuh2EC9Jvj9Ntrj5h3kEaEiflmw2qj3sQWZ+qdNw0750B0gor46akqMM/uVgTqQbC0BVGc45AGbY2P1IYsoWoB+3jSPPxIwDuLtWPEYsxgphq1n1Jd9MPBmk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7691.namprd04.prod.outlook.com (2603:10b6:806:140::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 07:26:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 07:26:11 +0000
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
Subject: Re: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
Thread-Topic: [PATCH blktests 1/3] scsi/010: add unmap write zeroes tests
Thread-Index: AQHbl9iRLG9wT5WiKUmWJdNkg3daDrORo6YA
Date: Thu, 3 Apr 2025 07:26:10 +0000
Message-ID: <krhbty6cnaj3zv4bka4jmpwmm74v7k3cts6csp6yoc7xjexoyu@6yrwd7rr2rip>
References: <20250318072835.3508696-1-yi.zhang@huaweicloud.com>
 <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
In-Reply-To: <20250318072835.3508696-2-yi.zhang@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7691:EE_
x-ms-office365-filtering-correlation-id: d638b98f-ca80-4251-47c5-08dd7280ceea
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kSzopheMWZO0E5JW5Oid8iT/ctaaDKkbpsxfvFqz4FikrN6zb8q1E3vnc/3Y?=
 =?us-ascii?Q?GilK/3+FFwA7LERy2AFzU/mana45Fzw6uGGR+eqV71Ew0+Cx9YLLkLCF5ZI3?=
 =?us-ascii?Q?WQB60fzfHTzAZN3C4SoPJDnsKEBvIKnEljAMKSIgsjirnGMAqm3taImHybN2?=
 =?us-ascii?Q?EoXs0HoaxIFYQpXghLeKMCHzLmqUioUVSvOrNyDOxbIlTO1nuNd/NtUWU/6V?=
 =?us-ascii?Q?gpFZCtButh5+72jpWlIzt4Os71xyZJvMY0mpyhXDpwryOEJbzgYLXkyZ8Hag?=
 =?us-ascii?Q?o0C/flZ/t2h8ekt/1H16CpkX63nMTXglx3EaemmfAbUnJrVVicrLCSdbjmwV?=
 =?us-ascii?Q?2I3cPo1eWIkZq8eTbgGmCzg1tlYg5q3sDlWbry1HbZ+EwyI9sg8eZFVJJxot?=
 =?us-ascii?Q?m52cxYao7M7BungbX8b8xPnOND3ndYV+pTlxZhStNiSWcOZahv+JtSkvwG35?=
 =?us-ascii?Q?TifY+TO+rwCR0fjlF6F9t/uIL7e+AzxcVW92O//4umpNebEmUeAYGKmtgGBk?=
 =?us-ascii?Q?buLePwcbXRfYBH9iH9Zo2khpJGWkgifIMnZN1/6fIDx0NuTGx2zuaAzg2cdH?=
 =?us-ascii?Q?iTVtHimkIZxJPM3va/tASItccHpEvrCK/X41XWPXhu216sNdavYkVMUjU3uk?=
 =?us-ascii?Q?MPN9iMgNH+vUsD6b/9bvZ40SWPL8xWBvpnTTT0I/UEleFDqnih9WzHZLr+jI?=
 =?us-ascii?Q?eVHrWi9u9r5ohDNuWOBtfWRAFa/Jx57jMS4kVKiZyv4g994SUE1U+hDAeLOk?=
 =?us-ascii?Q?A+MOmzXUF7wUW07ooE8KlhrRTW73p2Imgg1SrbLoumHZB0sMU5NzWp+sYjSQ?=
 =?us-ascii?Q?QxEA1CohM6xzz7Qu8zZWNt8ntuHxudFdWdMTsGj+GXjoEooUUO1gJWRKNeA0?=
 =?us-ascii?Q?5ESy9OZSn5Eg2U4315QSsl1lRiLKHtNDbdb/pIycrCSast7T41+7tzwQRDof?=
 =?us-ascii?Q?ObdZP9q51l/3Tfz8t6wsodXg6jzjw/m7RkMBi61uR5tTtsGa4ZQ1tTWVNDK4?=
 =?us-ascii?Q?8LSxS2bj0CyNdR6UQ9EeYHimy/XUa222/WgisyTXh8oZB07oLkwsHE5NzZoM?=
 =?us-ascii?Q?87MByMfcI6V5blR9JSgh1XC/P6xBFRkKzkfHvIgux4iGJFp9vWYLPskMoEXK?=
 =?us-ascii?Q?8FpScA33m/T0siXmbQO3J/SMJRPeF1LywawUvq5wBaNLhtiod/vAvPcTW17V?=
 =?us-ascii?Q?OeR6jpD16ljOfkVMHEJv9ZdXiR0cMMdSqUDj6z5LxAEFfBtdopcvVslGzZcZ?=
 =?us-ascii?Q?ZJWuW8payPzZ8t7dsXDR8fxneJhCeNEQtJqTyg0Wixr2LJSQEVjmUpD8iURC?=
 =?us-ascii?Q?BvgMw8LvCahmPCFBw0YyDPxHsC44yNpZFwNgRx5aso/hX12D8wpPOHANh7J1?=
 =?us-ascii?Q?ytEiqugei4sR2JRLB4IcOSU5930U0TPebv4xALhk1tsCfzWaNKhcBSfvFvoB?=
 =?us-ascii?Q?BdrZ7ilcbQXUp2mS42O3N4SUHBlIkay7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uFsdn4H5bzx27ou+G7YE1YLvKi5QppiOZpCug9TILF/gp7zEoMIJVMLIbzlQ?=
 =?us-ascii?Q?WZgdqS/fX16Frb/9DarC6wJfEpK+Ne3AB6qZ65gR+prCojhrjnkck2veI53H?=
 =?us-ascii?Q?ypkrEkKEh2Q4TcZtNz7psJr8doHYZTTpgyEhlu0d3v5AxisK7B+jlULofZX5?=
 =?us-ascii?Q?MVoxTgsW1XBGG6VTp/wBtrcTT25rYFBbbLg4Bm4Vn+k6bF9KdNh4Z61jBg7+?=
 =?us-ascii?Q?a2FtSgnrVcsS2GS4aTrxU/578H8fIxmEPSJ5Ahua3KINLX4nj2zophuw8hjQ?=
 =?us-ascii?Q?AtIKXtG8EgZ0IWR1O8+7TU/G7zvrkogeFDSnxdjFwIeEXzci4D84j5dDxlFl?=
 =?us-ascii?Q?fAAbvmIGtWY8RgbRwK1pNqa2qwwKjB+z6XNqrYDBDZ5ZeGDnoUF+16bO2YFr?=
 =?us-ascii?Q?SC3+nU7rUXeFVlSJrQEK76/XLGUNcxpogOJFA+9jtzOpZswN5zDFIW8yT/jS?=
 =?us-ascii?Q?hvRfRmxFA/wR8igfTV/gtLUu5/i47Uj7bUvMFGbGPJdx2tmJmTVmo+RHirH+?=
 =?us-ascii?Q?akKWUeBIUiZXsPNnm/bX+sSiETg758iOvah/HXGn1RTQK/5r3zCwHRTqaJQQ?=
 =?us-ascii?Q?RW+nHA/ysPXH8voafJuUfyJRm5pwm1cJrkNDZNZ2BtuipHp36l0kSr+IR95W?=
 =?us-ascii?Q?8GgFjPQufg+fHQ+MDLeES5kB3UFuaCHFCtvD7ikUbcKYiNEuNpWVuBhhzajl?=
 =?us-ascii?Q?AyJUre9m1sBS4sn49kpMFcGMwz3VrUU3FeBbOlXBFfZREfYW98dyxLWr+C+Q?=
 =?us-ascii?Q?0pgvw0jSuHGkcq+ZmikIkl3hrAvMMSgmUxB3x1jXg4uXPgtWsHjcrxqYg2up?=
 =?us-ascii?Q?5i48R2Ck+x56AEU6FFZRPFlkPpEVSfJZSXuSPTsBuwhkaciJLuq10jCUp2NR?=
 =?us-ascii?Q?orvd4CF8EOyLzvGV4RCq8EFgENzjVjFT+EazihstTdGacFxzvx8btYG9VR+2?=
 =?us-ascii?Q?foGza8vCAfkdftehfrYtH4rJXgSEoSbRwp2P3XFWvUOSHhHaneoQeD8YZqBO?=
 =?us-ascii?Q?X2KjTdjl/rtzpqTY3lYnPa5do5024M4znCe+wQM/oOFvgeWkcktyUmy1//mR?=
 =?us-ascii?Q?Vmn6sdO/lz2elWKf9V8k0TStwr+XF3oNU0hsQ4gxl6Pvxvz0z4m29NPcDAxF?=
 =?us-ascii?Q?jPjJm7VVaO/5R0THDtJUMhH3uZdPHpNGJlMsj/NuvcUdrwV3FHRi2RUpvURV?=
 =?us-ascii?Q?m1TrjGqWacGWsqTV4fmKYi/FoPTbqSKhRUFaxOa/wL7/6jDciA6t/5zyoDf5?=
 =?us-ascii?Q?qI91JVAIR3CZhXDLGnr/8sux1K9VbtvwFYkOmIjxK3CXb0YM9TwKsnOyQZyR?=
 =?us-ascii?Q?lODnZT8q2beebxQzi4bXKpJ9paN1J/oGg6SE3ohj4gvlQHD+ZvQrtaeBONcs?=
 =?us-ascii?Q?WHdJ8e7yNtSbtYcQWYMF12d7qBFvpueD0/jdYCmF069uYJGC5qvYEq44vS1q?=
 =?us-ascii?Q?AaT5vtVxUG/xjb6IIR9+iIwVDVGKViGslpBu/MNxmRGyEnDIETMlFGQH7iqA?=
 =?us-ascii?Q?m9sTWbT4wZ887YAB2C6Vk3ZRkKnh4fqoOGVqkpMpo0UTP0+RBf4dNVyEw9t1?=
 =?us-ascii?Q?ufo+nZYt3PzpJNUwgDj7fSnWerfxQHL/zkE0mBMuNpBtoZtX9NrvrITaQeCU?=
 =?us-ascii?Q?yUvqcmjVdVN3ZbeHkBRRWGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3744485F21AEAF4C8CEFD63BE6E8C4E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EnuCssR42N+s5hywRQ3dpCiYybcxZ11TrpEoKgCuPUD+EsA5HQLemMyA9mRJsv0eGvlVnGlzFKnbhZK1rLUR9HuLSoyDUvem3WW/RLPvi2PiJvIpuZx5QVYXIs+xkMKwTcZu+uwnqnodPE6G7pvTFbsbWUtAof4P5Whjm19wLCYubCD9su/7effsA6jO7I24AOBqR7R0IB/ng8kFhGga1QV+iDbbDqR+7BC5c+GqG1Y3GwUlEGC2OixbkKzyAXW59fClnmgPiC4H1TuwXK1V2+aQkqrJelN8qPmeljsye6r0kN9E4d70t5HjHreCPAl/R9CwSGaQYMvcp77/Y9vRVAoRVb8InQ88QcEkshqYGhmWAnPga8kDByygXu8P5xjjpmPpOTo5CQ9rapsSTd60tgkiSbCngnRhGm0hsErhBGmeXuQXRyDET1YJJvIxC+2sJpyLtBHE7NDxBybgvkUULifSYVfBJvFmFRRkxLLpisxLAA7RFCCFb/oWnSkkuXXTBvOBZ+K8B0lj4H3pBCBLRXUB1xgpGi/6XGrI0zVP7ct9qvVvULFRzeFOlR6cPOYGupE0FFJBMC5VvrcoA//OvBDukfR9CEUixltfUCzUANGHoY68HYJsEL/YdgxsYc96
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d638b98f-ca80-4251-47c5-08dd7280ceea
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:26:10.9288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oi4lhEd7seKWzB53ezgrw94PYfhK+Y3k/AnnBnt5b/hJGZMwx4EOKANn1Ky5NatTcMQUXuI84N8MOlPrFHo5lh3Z7BHup+6K0wBnJP7GyBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7691

Hello Zhang, thank you for the patches.

On Mar 18, 2025 / 15:28, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>=20
> Test block device unmap write zeroes sysfs interface with various SCSI
> debug devices. The /sys/block/<disk>/queue/write_zeroes_unmap interface
> should return 1 if the SCSI device enable the WRITE SAME command with
> unmap functionality, and it should return 0 otherwise.
>=20
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  tests/scsi/010     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/scsi/010.out |  2 ++
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/scsi/010
>  create mode 100644 tests/scsi/010.out
>=20
> diff --git a/tests/scsi/010 b/tests/scsi/010
> new file mode 100755
> index 0000000..27a672c
> --- /dev/null
> +++ b/tests/scsi/010
> @@ -0,0 +1,56 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Huawei.
> +#
> +# Test block device unmap write zeroes sysfs interface with various scsi
> +# devices.
> +
> +. tests/scsi/rc
> +. common/scsi_debug
> +
> +DESCRIPTION=3D"test unmap write zeroes sysfs interface with scsi devices=
"
> +QUICK=3D1
> +
> +requires() {
> +	_have_scsi_debug
> +}
> +
> +device_requries() {
> +	_require_test_dev_sysfs queue/write_zeroes_unmap
> +}

The device_requries() hook does not work for test cases which implement tes=
t().
It is rather dirty, but I think we need to delay the check for
write_zeroes_unmap sysfs attribute availability until test() gets called.
See below for my idea.

> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# disable WRITE SAME with unmap
> +	if ! _configure_scsi_debug lbprz=3D0; then
> +		return 1
> +	fi

I suggest to check queue/write_zeroes_unmap here. If it's not available, se=
t
SKIP_REASONS and return like this (totally untested):

	if [[ ! -f /sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_unmap ]]=
; then
		_exit_scsi_debug
		SKIP_REASONS+=3D("kernel does not support unmap write zeroes sysfs interf=
ace")
		return 1
	fi

> +	umap=3D"$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_u=
nmap")"
> +	if [[ $umap -ne 0 ]]; then
> +		echo "Test disable WRITE SAME with unmap failed."
> +	fi
> +	_exit_scsi_debug
> +
> +	# enable WRITE SAME(16) with unmap
> +	if ! _configure_scsi_debug lbprz=3D1 lbpws=3D1; then
> +		return 1
> +	fi
> +	umap=3D"$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_u=
nmap")"
> +	if [[ $umap -ne 1 ]]; then
> +		echo "Test enable WRITE SAME(16) with unmap failed."
> +	fi
> +	_exit_scsi_debug
> +
> +	# enable WRITE SAME(10) with unmap
> +	if ! _configure_scsi_debug lbprz=3D1 lbpws10=3D1; then
> +		return 1
> +	fi
> +	umap=3D"$(cat "/sys/block/${SCSI_DEBUG_DEVICES[0]}/queue/write_zeroes_u=
nmap")"
> +	if [[ $umap -ne 1 ]]; then
> +		echo "Test enable WRITE SAME(10) with unmap failed."
> +	fi
> +	_exit_scsi_debug
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/scsi/010.out b/tests/scsi/010.out
> new file mode 100644
> index 0000000..6581d5e
> --- /dev/null
> +++ b/tests/scsi/010.out
> @@ -0,0 +1,2 @@
> +Running scsi/010
> +Test complete
> --=20
> 2.46.1
> =

