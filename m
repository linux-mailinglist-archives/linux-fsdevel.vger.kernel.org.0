Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF42D3F92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgLIKKB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:10:01 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32368 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgLIKKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607508600; x=1639044600;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1975qScN3yoTnlaPNcI2DN+OsGg9lJbgDAYZETndwTU=;
  b=UKST987JUm3DFSfZ2hXe+4AUN53K4sjq5i2YVQkBZ40AxKGPugrZcp3Z
   FdaDijlLdhLd+mxywoTydhuKN66/SXgHRGT8V6itz2flBfE3325uhMBJP
   VUzZWPWHUpd86XKbLf1PtkHeIpVM1OnT2iYuz0KnDIW0w+pIcGN2ZLb5P
   UrKmA291sn4FLYEf3WriGWQhvKHGuPfQ51BmIYbR4PoGxQFdnnRcwgaK0
   /BlxqvDuxSW56EOAohyRiMhqsRkwvwK52KjglMZ+BpKd2w4KHRlI/xgeY
   pef7UDOUeyAUoRPDHCPrw70vYmbZEFsqnubYBnAEWAqdnf9CN3TaSBrYB
   Q==;
IronPort-SDR: 2Pd46XL2QiBEKWOm6fCOM5dgitowBOizlWFKDSqgwt0PFWt5SIVituk4H4qqkBKljyQwTleBiR
 lmsQYd6bVy3eVVqxD4Fz8MH+8B6DgUJWKrWCzsfNdk4rGU5sjKtR3FWm7HRFkxo+E7ELA4hJzX
 R016cN5m3/dRCBS/o1J/au7d8LHHlEt7wcwEJQBN7JG7NAqwxv5qu40OI8ylN4OjzWPma27sGj
 OikgXZ8o92mbN8CSFz/jYUSSo6U7BLGKlK6uv5pNKIHvplhSqFagqvhlqjR1xsymk7dppLwY9i
 CYk=
X-IronPort-AV: E=Sophos;i="5.78,405,1599494400"; 
   d="scan'208";a="154811511"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2020 18:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjRuoqRbF2H/9B7lQArO5jXjmql8TjMVZ8SYQYZHfVL1D21C2Yxl18pa2MOg4VFgv4Cx6dIsfIoTp1aeMIlBVab/9dwXK+3F68x+td0eckhjQ8oEAviSX4mbIIKmm8UxnGxJewgvsrEjIVBhG/zwmhomWq550HRhm5wzkG1qsoGV9SfpcyZECmrXIfC6Squ5e9LbpB9GHRl7oxaILWTu6F6v7BsENJp6V9HuRNWjzPGOlbM4xZ01IEge5QOtuYw4sj1TqN+i0qdaY7Da7aPiKZ6OiDa81FUNsGO8X+708v+q4eB+jw2elGP+NgenxYiOOySMSNhfVZPyBVc7YBJVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCtLawpGhpaC0ryYeggjqez4G7Uj2ItOTj9fi2Zl6O4=;
 b=OEXE2A7opI9NgVmzy1zaKJSo1wPgFHHzR9adlpnSxkaj/alJYp8fIRiJnxYzO8vwnODcExxeBuMre5QdDIDcGzmmqzPF+SQEuACS5hjx+Skm4i5ixDzFgbYYbBYe9vsXSpXvN0tdH1eR3KxBBJTIczIWJBKcGgOht8YDjtuFfSbBN03QZlxWudzJiCj2Rh5dA/FCeWRICg0TLBFD6Oa5/7MUM08lqkyLEPe2bvzq1qef0tBed8heSwXXBfrntXssYfGE7UcvH8ZCt88hK0gl3gqkLMsQOKRwvoqjXrNhKj5I8o6aeBUCtkDsItrHvJXBXGQAFyspJk39vpgXncE+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCtLawpGhpaC0ryYeggjqez4G7Uj2ItOTj9fi2Zl6O4=;
 b=RVpS9NsTyby3ZFvPigtiwJX/vvEPgAiDH9u+gQiYZ/KhckbU8b3vRaBZwePMc+4V94LuKOrDBBlu3cWfhx+oGQSBqlFBbjznDB1O9l1fFjharBe/+ouJ82Ky/B5YUF/m1ng6kMsXWHggq5YuZ+jvLsh4MfvFwACmgkKeCbhzBk0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7289.namprd04.prod.outlook.com
 (2603:10b6:806:db::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Wed, 9 Dec
 2020 10:08:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Wed, 9 Dec 2020
 10:08:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1Sb3HZRbzGDlk6Pnuh0g860vw==
Date:   Wed, 9 Dec 2020 10:08:53 +0000
Message-ID: <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef02a6f5-174b-4010-8294-08d89c2a6ec7
x-ms-traffictypediagnostic: SA0PR04MB7289:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7289B631DDA16A73AF2EDF439BCC0@SA0PR04MB7289.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpishkbwHhvynPhrUac65OJktK9UXW79rEIPqWmpVbqZNiqrUH090OvDY7sYLtcrJHa45qbH+e76In5/n4O3HAVY7/IK7E6sElq2y8Y4i+auPwbtuq9xAWcp2UCWu/BdUlnksaNGHc9fV21/ll7QW/hJzoiJxo5sfhdTbIPeQHxq0HSKWAzGi4+p8A6OK9WCXI3JEgJVI0heiBN3vE8IJaYnCmdhzukgfKCPI1L+gOrRi3V/WvIhLBEZbKPzFalCd8fUjTaIV30UFhafxAV6l1xeDUXKFqwd87q1w5nmzA+NK2YS/fLqgJPgJnmx+UcGkIHwfKpeJijh8kFQXQJaAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(7696005)(91956017)(6636002)(66446008)(33656002)(9686003)(26005)(83380400001)(186003)(76116006)(66946007)(55016002)(508600001)(8676002)(71200400001)(4326008)(54906003)(86362001)(110136005)(6506007)(8936002)(66556008)(53546011)(5660300002)(52536014)(2906002)(64756008)(66476007)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U0a3mwA1NjKjmPRIXufL6j0IWfYgCs3I+dHmzJJT5wcGCk8wSqBL6wLbZkmn?=
 =?us-ascii?Q?lqRZAXL0AJzlsLT4zqWiUr+plnifWWDrsocfx9mvEO0wVLJ4A9tpDkox0Mpp?=
 =?us-ascii?Q?UWrw3/j+Zh16nJ1g+RRzjp24DQKb/6fLL6r9+O8ynBzMU2wTYWkCxDZAPrLB?=
 =?us-ascii?Q?7plIf0hPfaKdofR3XF9IrE6wyWwsQFudJrwYtbBh8aWeGgdsRvdJVu2r0vjp?=
 =?us-ascii?Q?0BWHfgE0h+Yf6aDBbyLkXgdiOtTpPWvFriwFLR3C6ieXPmxSJj6Uzn7NY4O3?=
 =?us-ascii?Q?wmD7wEduq11X5rKW98Z5Lyyqyb4YaXQ57S0JUfoH0bESQT70taEhj4DYR6Hx?=
 =?us-ascii?Q?KOsyzKCSO0OV7DY5lZByTtJDZHMd8nYTb1O/ToafexrI9tsnSu5ewTl31Jwj?=
 =?us-ascii?Q?NqhqxbGZ9kooZonpapSx/6KX8PKSMdjG9YR1fnDANEek6QQlkPs3MOq3TsNk?=
 =?us-ascii?Q?6vF48+cxAIcvDuNa//jtjRCYD300XN/zjR6U1XA1ra2D2bhYlKcX6ZYyEQ0I?=
 =?us-ascii?Q?t3kP0AGO9llTk/ZgJFAMiwNNJ1ewbN7LxS+sM5t3dFhlImEjUTq7H5HDUNEv?=
 =?us-ascii?Q?WPGr+4y3UnhwYq6AK+biETXvoCPZ7XgvMNHtR3kYGIHQcN9Gafmt8i695s8T?=
 =?us-ascii?Q?Y9VmURCEZ7Wr1UD45kREOV7k++XP9exKbzUBl9dG0vPWyz/woZ0ivP6p907B?=
 =?us-ascii?Q?cVc3darAT6DKXXMQU3QhJbpYilVx4gcX6XBBWBEmyMHmojGsbU7e7BM6YX75?=
 =?us-ascii?Q?Z08N2ZqAbWgc19vAwT0+1PZI4nqEZWLJFx2WhJoTdTpXOBPqIQilBmGsUaBJ?=
 =?us-ascii?Q?YC7O8/lFWHSXLFbDLO3vcQSJ1ifUUnBxZMN4RSQ/fQgX1OYh0vgfZkukggks?=
 =?us-ascii?Q?5SkNZVofperJLaOAIJ3WtNNNFPww5af7zo5pPXX0bdRl6cx0KuAEQHYrohCu?=
 =?us-ascii?Q?EH/a/qlSm7mAKvfzwRzGzfhe3l0cySwB8WntJg982iqlVJuK6f8Xa0E2NlYw?=
 =?us-ascii?Q?aLWn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef02a6f5-174b-4010-8294-08d89c2a6ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 10:08:53.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uG8We+OL4wzIfMmsoiuYZnU/IJfW1v0qnbLzh1FDBti/E2cxyFwhibNA5i7YcyNfUjwRpOA/7bMaDoaAmyvTNcHe3q7f7yLda1jr8Z9DYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7289
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
> Btw, another thing I noticed:=0A=
> =0A=
> when using io_uring to submit a write to btrfs that ends up using Zone=0A=
> Append we'll hit the=0A=
> =0A=
> 	if (WARN_ON_ONCE(is_bvec))=0A=
> 		return -EINVAL;=0A=
> =0A=
> case in bio_iov_iter_get_pages with the changes in this series.=0A=
=0A=
Yes this warning is totally bogus. It was in there from the beginning of th=
e=0A=
zone-append series and I have no idea why I didn't kill it.=0A=
=0A=
IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
