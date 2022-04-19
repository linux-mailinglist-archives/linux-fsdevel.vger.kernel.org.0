Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18050688A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350576AbiDSKRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350726AbiDSKRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:17:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EAC1A5
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650363295; x=1681899295;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NqPrL4YehgAOG9aA8Bc8BiT+Dh1JESbFlq4ShJJdhd08shMajGUwj2cq
   S+cRBqEqeu+o0oik4mxBeWqAAm9852GEg03xbuOmdbn0sM6vF6Bu3P+1b
   myb6gVh3O4lENbgpDhvhqU1AFSsr4ME6n2iXjRvlHgRnY7aifW3PGZJLE
   hi9Or8gPWhhVMZqhh9HA72tD3mtbhSCOWkUeCjKKigpFPHw/ZmplHSUIw
   SLLmVwip5/xqZaAu7a7SprHJVdQjPSkFqg4msJbKPB3clDTiCO5HdEZYe
   xEbtRSC0f8nz1sKfK77eu8zkqxXRYO8XgjDP1RyjeFpNiDU7RHClkrm/v
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="203115109"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 18:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGP7prjpBEi+JUvlvUeQoIyPg8i+kxj8qAvphvI60ce4zX/CddV31yrYHy2x3NP9o9BgTtPAu867gEIyUEiNl4WEe6zlmVzrGGviMtd4NEVuHw4C/sq3eFgOUkLySuQeUaNp1aFGqCt+xksTxzdV6dqJXjYXy3v7KtGNA0q91ZxYqzhoASJhLZZZsWGKB5f9+4VpTgy7DR4NOnGQoZJ+gJUGFTIYC+aBrBTOPq8dEo40YLYN+UzgEW/fPzfSMJY0C5O9mDYkRpElLw7ly0hSgjCRMqmHtCkoxKwG7gTYu587ZdXjZogL4Q/07Qa1iq0hUhlUbrGm4hYKPkFZnTQw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a3v6pZBLN/segUi8SXXWSTkpEXk9R1cXWeSVvv2JrZw2l1bqbCrJ1miHW9fDt68jaHZq4I9FuhFihbz7S+I9XH37JLIerwaj6/OJHAwave8uaktGx9GVsXY3Gl+VKiupRXjz/E9abwbWpvplQKpTTnyE1l7JVa47vX+OnrVXUxhe2I3MpPSRxGQd28Coz6p2ZPIWxJV34xBv1b0kGTidRIWP1yY5FwBrKZCSnMYREq0X+bu4orV9E8IZ6ZsddcxZPMHXyuNveBhPF3grjCPZjZz90EIzZu5/2VLu4+H65JuLSe8Oe2bgbN4zpGjYRlXerOq3iD6x/Olp5Qz9E0BXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GHuBNr9MgLHYBEH6hzXBv27EJN5ThXHBm78PdNAoWxhjejElyKkioR2wmi3EdGysznRNbMKWS11QFG4mmBLUGGw55prij90fKfQenlPPZnoTmlTD8YYE0uSrk0njRdQEuykcOxCwLsAg35VQ6GCJvYMM+wmbD6cHsWNo+hQSSo0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 10:14:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 10:14:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 8/8] documentation: zonefs: Document sysfs attributes
Thread-Topic: [PATCH 8/8] documentation: zonefs: Document sysfs attributes
Thread-Index: AQHYUsFaQ3XcDgXLL0ysWqnBcxL6KA==
Date:   Tue, 19 Apr 2022 10:14:54 +0000
Message-ID: <PH0PR04MB7416C41EE84858A63E2C76599BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-9-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86abe0ae-864e-44ca-fed8-08da21ed72f5
x-ms-traffictypediagnostic: PH0PR04MB7320:EE_
x-microsoft-antispam-prvs: <PH0PR04MB73202CE13C57E5A17D65F0D19BF29@PH0PR04MB7320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m44Z9oLBX9CjUy1DitxXS3uoCI3nydF/zasyGXAymdrdFOTkcz4KjPSyAITcssz58lUWBVdmo4NRXwcIOfa5gnngx1TFRPYipepsNar1BBZlXga+03LoP8B7Qhit4fBQFGBZT0OLdZOIrEsdNp2gvVZEUVjkuEQW/Gt1wScA1wGorqjBfjV0cL4GfOhb79wtFlbL/Q2+tAJE5oLzIQxBddAelyLiaX5Bnt/qd12813PG6YeufKwidi2d0WsWEoQNhaL0l28HZqdEtl5izSVDH22c7UVVPE1Qx8QmbxHTEwmsZe8v6VZnIjAhiot0Jcef/R7eF+Fiyb8M6rwZnbCqPhcJvjL+LO4CI/xqvJrPdOsWaXTqC5F8pZdYI5OIxHRF14kj0e8fpQHSG3aE8+DQhNPP4LBAWfObvw4oMYvzSL63HzGdAtVW5pLPGkwqFRPJhyMqQ+jiCY4lygUhf7A+pUk3sBqzMA//4OnJ/leVjvw8eTv9brWSdYBIj6/nz2uq27wsRXsjux4dCPTPBa4gsgwiAfgWDDIr0soEGV59ZBoqJEGe2B7CBB1JtZPsUK29da0VZwn0lduLFy6OErPyIXZ4viPwetfYcjW9/lzcVpF0gekFURXJ2docVpZPy9Ukg8NWe0TmuH/BXzw45vMm85AU53hvg+XmjRKqSNUKBcrUByu9LIUMoxwhNKRQHSl4g/24TpCxcyev+9RxAbGCxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(33656002)(122000001)(82960400001)(66946007)(558084003)(91956017)(2906002)(19618925003)(4270600006)(86362001)(9686003)(71200400001)(7696005)(6506007)(38070700005)(508600001)(186003)(8936002)(52536014)(66556008)(110136005)(64756008)(66446008)(66476007)(316002)(76116006)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBZN//8WCD2za8Hm3YEqjCuuuZKG0eajGYIogU7Djl/bIzsbymuIk1zeROJr?=
 =?us-ascii?Q?qp+ESSHDTk3i9+lHsuWKnTdeWr+RtmTtpvzGzyaEyiCcjDnOesVAS0BabRLh?=
 =?us-ascii?Q?zWYCSWaC37sMD5I1OUJnpVn/vcgHaIXI8F4P4XSe0hgQRZ96eAXXMojnUSoX?=
 =?us-ascii?Q?AZw5YPUKkafjl5xoCTCKx7G60NIVn7rXbTIG6NnwfvTef50whNDgHYdgL1VW?=
 =?us-ascii?Q?1CDP4/XHxNHzA5GDBfmn/mCedfrWy4RNKSApnn21OdImExfS+VizoqhIAQCo?=
 =?us-ascii?Q?IGKv3izIvkHww3CQ3OEhYz7lDCVXb2udmthsdDJC+OSnLhSVLRfMm/vYzJS1?=
 =?us-ascii?Q?qi6AacGPtlllFnUI5R94ntudtLiyuW12EqkVvnUTZD6nzhc6IB6Lz41IXctq?=
 =?us-ascii?Q?BRyhKcShrbVtHujzZTIhUZE4iH3CdScppIYnQSef42FS4xRpMDxq47ChEZAl?=
 =?us-ascii?Q?gZ3TiBZA5Jp1r0gVjH8doFnusW7oi/ci/iRu0o3d3ehNZzYkMgVfpLvSCzJp?=
 =?us-ascii?Q?GX7538cj8/ONzH7UeezKVcnQbwoAkbeXNr1p/OHxuZL8mziNM493BiCEJSqS?=
 =?us-ascii?Q?1pXX9ie5qIW3YWBndAuU94r6qznWAcSEmN+HyeebXo+gCEpdETpMoc5fecLL?=
 =?us-ascii?Q?mon3B+w+0zBqo95L2q1WTvzxaU6RboNS40zVMz78vdb6kGZ+DKe46B+UghYy?=
 =?us-ascii?Q?1mBaR3iLCYJeMK8GR5K6wvjVhBvWUKmusvqOsC+hX9z2vC9dgoo+HYRPUryt?=
 =?us-ascii?Q?qwlD87+6QaJQdPCPTgtdBqkoELkuGw1AS94nuVQ2QyvenMIVk1vLopS40u4H?=
 =?us-ascii?Q?hxIPIT98xKITacY+qO5i8R+cWCdeYIyXIMMaC7GJKBwhLAQY6sCQ1m9WA7wb?=
 =?us-ascii?Q?xdYzNfCD/UPMCktr9VtgnnM5dc0DZKcy8SYSXu46qGTpDrPJPB2Z+TPuPg0z?=
 =?us-ascii?Q?LEdpXgMbgY4i/ZIdl4aXJH3VUAQ4il5L+XjMiEICDkVpp7t5qvur+y8zKzOZ?=
 =?us-ascii?Q?yj86xGFDAWVLkeWo1EXFH+f28c7wJLSmAvmT7C8a9UBtd7YaDbcHVsQgZifg?=
 =?us-ascii?Q?h+T6M33rRPFuvDj/Q7xJGR2W+BPfHHnUB/hpFmfZQvJnUsRw6K4Ssuo9Uytt?=
 =?us-ascii?Q?Fa3dj7ZxfTlUlEz56wd+n0R+Lt9KWsp1z2DuQS/k21rLTIjXYWxs5GgCbdes?=
 =?us-ascii?Q?7Z7DxATGOB+b6AtWseb4TIvZO1eAHPWzNEn5LC+AOKeOZ0DwuooV8Sy030Jk?=
 =?us-ascii?Q?ZYPkwIkCZsEeVZjqWKIliI+/SPwmWUU8PLqyMmOHtNPzvv0r6Lc9o4So5ZuG?=
 =?us-ascii?Q?FETwin7OVOEKSGehIdwq0EBoR+HiMk60d40VYHzQ6X9nOWIWdtGFud971I0u?=
 =?us-ascii?Q?8fWC7OkvosteFpxEt74AS80ZEzXt0ukOAl6GvwylZJ25VKDXlKGRevryUcEX?=
 =?us-ascii?Q?KHmfRSX7AfFwwrFclj9l9ydafEn8Z5KTA8VIoUYkjSFVv92rVyCKOFxojWxc?=
 =?us-ascii?Q?4HqlB9ONUvCyhGmhEyXC+XPMoGMdXaWu32J/uUcvALHQoxyK4c0Au0Zn7CVw?=
 =?us-ascii?Q?q9Ssclur/MbRv3MJAxF2IDQ/0BtIwx/AyhMSp3CWV1JLCkYP4LnjxI9v03HU?=
 =?us-ascii?Q?auWKg3ftA4IyLnik6//CfAuXqEGHIcM6FXRtBbYly1XPuFsD3OthhiySLID4?=
 =?us-ascii?Q?HtIBy6E31RcsN0bGVU80c4siaWfbsZTrT4+knr0vyUsxIrF38FTUMx/WcQNk?=
 =?us-ascii?Q?+rx02xZKmmzKaNUykG4gH+ormQMVQjKw1OgOdRCX8xo9TYf6vEcMPiPohIjZ?=
x-ms-exchange-antispam-messagedata-1: JYvcEdQlqilBRaXzMzAe9tEzAaLIDRhfO+c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86abe0ae-864e-44ca-fed8-08da21ed72f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:14:54.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2N0zIY+KlnBqiaOLJ1643OUn6Hm+Bi9cz/vbGeoV1KpqtNr1bCHQ1c0Y7Kxd7RwgHrPsHycls93TAK/YQto9jtxFF64cBG1OnqJmL0N2S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
