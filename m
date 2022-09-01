Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75AE5A94FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiIAKqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiIAKqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:46:10 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5070E8316;
        Thu,  1 Sep 2022 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662029167; x=1693565167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZGdErq0LNEcpnciLUdjNw+r8cFd+F7OObfbib1PaCPd62Ris+/gD5q/P
   1nhvbleT74EFqusYzZ+Fs5/6Q1M3+n0DTiBWij5u5poWr+UKGJvk9SCMg
   cJyjTiBYAvPeczi7myAQ+Na+bvisn+ukZfVg0eROhDtsrZVoYGE2s0XJB
   1b+9Wcznfhb/9xFPzn9l0Ux9Zzicdq+/9F4uSwnH5xXwa8E3H/g4ruMxG
   uJELgLg5XzQAueeB9L8Q8o0lw5kk4orBTC7mpse1rNQaKDh3c9x4Jh9ko
   sDuUer+0IvsT5qor47ZEwGZud9cFgfJ428ccrL90e4JoEzeNEiS/li/xo
   g==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="322330664"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 18:46:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcfCoX+u/pGKtOu6bTXESgV/0f1E3vohCa69U/OP3bajiwoXjsHlzamNna3tVPLHM84d1j1LSJ+2fWE+/RJXVC5C8N5sqAD4KFj1PYabUcx1mTi+kfeqrLT/xUG6rM3t3E2hDO0EAfSM7+PNm2zZxIwxUZSGkG33FrZQVwMWpDdNA/K5wkRQwOas7N6s/HquN0WNQAhp+M4OEwKqdZl2IT+CB+O3tsiGvyJ1zIy+oGWErNhb+0Nq1krhWj+JHFnjwSVzMThc5F6BfU3L3PkXFcvJirN4Qywb+6/QBcC5dy+Kp8nZSxfh4NirlR+SXfRID3k/4FH6J81PDCB2z0nLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iFJGQUjA1pAy45wfSYymCwdu9XKmeIxdZyVyiHdyvi3sKHiya+sQ+7cmACUpL64mSJaqVS03AlIlVZrqEM+ny6E4Yfe31jrkI9CPkGQQ+nDMPwoGrJTQhzZXoNhz0jvQdMtgmaFVvDdS+0sCize2tvHtnk4PL2WW0ZeHxrKu5eR37SC30smBoRDg7hR2ttRHmIWkbdc4k5slGL6C0JcSdlf7du/xBHNbcrL35/GFJ4S3CSKRJj8tWvaYZDct6ssv/J91vE1qxWTcNGqnDyiRB1tpPHxY2bbmjp/CFXLeVyA8MR6jzsaDmyw+1iNHOJ5XydKVTQzajIK0Skcc6W9ibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cUWYZ5GDBQNTKufxCwpKT75I712BgOOEsByOqJWHZHmOkD8gnS5ghh9Y5LwAUvLCevMMw4Ehl6Kjp9sWjSfdvyUJtO9n40fykq6PSrXiHZm8zS8b/QYDUXl6Dm/SJkqdrn6jgA6W22Z55aHLaOC3W0BD4pjkgWbcnFGBV79+8GQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7101.namprd04.prod.outlook.com (2603:10b6:208:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 10:46:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%7]) with mapi id 15.20.5566.023; Thu, 1 Sep 2022
 10:46:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Thread-Topic: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Thread-Index: AQHYvdaMZ7IoumTMR0+6yYdzS9upwg==
Date:   Thu, 1 Sep 2022 10:46:02 +0000
Message-ID: <PH0PR04MB741658A475831FA0342C9A129B7B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 864de289-48f2-4cb6-bef4-08da8c072a08
x-ms-traffictypediagnostic: MN2PR04MB7101:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spzDc9VfL1NPMfEss4jvNW3zgfJDfrG5Id1/E0B9Tgv6jRSofEwBZVkRmgeY2IhBtds0+A5DZ4g7Byoru2LMhWk3YjUyvrYRelzME8jMt/VY4SwbSioTykKUugJUG3qgTsLMCiNS12GrqTnpUl3iPTWQrSBDxRRrSNprIbMviMfGwybmMdFL9WVXJ4toKMAQkY4bL5EmvP0KdASuGbsnlj0QWgpoBvo7drISlu4+dwYjEIYlBPccTSkkBhxEQR5iYaskWrAy8AltyjsXSTFydZaT/e9b9OiogysFx3c4xAoHFD+IMbeLnd6odiEPCf4BXxhQUIs5QNQs/2aioxbpAb1RE8NYlfqsVq67DWR/1mi9Dg7BnGeUUmoPketVfF8S1cBJq/nNsEfz4z2PmKj+E7nw8BRlyX9bXi1gGzz3krEkr23f6+VF9Og3ULd4zA396hjZtxqrHAfaLZzVfiMtN32s6IQXnzuirbSpXIWPZZjonkTYNpZqAPBTqVEG8Ie3DXYwWXvIQOT+g1fCnWAMRddVyhM2Bf+7RNBuuq6Dhjz5qyju2SqomSvlm1CDr9DhAPd26QeQDr26mzstxFu10JJ8esy8QOS7M4OnQVsKecXRrmIj7L97aG0JzhXdy8wzk+DVllLD70eZOh2CQf5qYpTi3PSnMxtXwRDuik9vw/54sPyDXs+sMhcKO+rsYuYX50K3AE/eHN4P0CZsEguv4b9q/6WcqJPv/5+1Syye0n0EHDuAu/Q1T4mvrP0GN67vODZTkxwRyNh+vOGWdnVzWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(478600001)(41300700001)(7696005)(6506007)(316002)(54906003)(110136005)(71200400001)(86362001)(26005)(38100700002)(122000001)(82960400001)(4270600006)(9686003)(38070700005)(55016003)(186003)(7416002)(52536014)(8936002)(5660300002)(33656002)(19618925003)(2906002)(64756008)(8676002)(4326008)(66556008)(66476007)(66446008)(558084003)(66946007)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CS0Zg4ob4+44YzbtcyacUfoAXZjFKfW560TpV7y1EljGPBvlxmU2XBzk6pbr?=
 =?us-ascii?Q?2WdC62aXRctvqBrmNWjH6sbHPJZENkZ3smoiMnXwfWjUBN0ncCMJASRjtv52?=
 =?us-ascii?Q?5pwDqOXlrkdRh/s8pOXbxuiWRkI/9asdFxe+FRgEdIctCN5DTgmn4Ulp6ZRF?=
 =?us-ascii?Q?5+8HoWf0TZTGFV1V/vQP5uOQc2XKdMxOXI5MYSQP1j2rtE3K+PyLo94WhGv+?=
 =?us-ascii?Q?Omip8I/FRazyqBZL6iOlXzRnnR1FtznsP9i7G7oXhYDAoAGkJqVzWE7kY7H/?=
 =?us-ascii?Q?4jrflDSsLqhxhauVHy7Wm5GR2xeoViuX0ZseaqIBOOYqxh9jnQSE9z6dX6ST?=
 =?us-ascii?Q?fRFHWs7sYx2NMs6jJgiK/wHDM9LgSBu0kHocoVHxuqRNP2O3ja5fiSJezijz?=
 =?us-ascii?Q?mZxHV4GsUmK/9HcVRaiia8TIme6eJ7m7Mp24cbsRGs9ZoL6TrIQHz9csWbX4?=
 =?us-ascii?Q?kbtwemCKcKlBdsYkz8LbN2Mj+6qFFm5MQia0V/o4zW2hqIo0k4VeWvMjuLew?=
 =?us-ascii?Q?/xirDmWB3vxgV1ulgJKdeSiaa0PE9pE1XZ4xzPOBJCU+fDgUWLCUj08lvPlZ?=
 =?us-ascii?Q?W9Xx/+uR97rCV6L9VXsDTO2/yy4SJ4IRF3fGP2fhPaXM05LhDNWOuGS1vqz6?=
 =?us-ascii?Q?4ot4SkBacYHYP+4uhN1jszCC/3AoSWl7NwYxKg9JeLbRspxcMDrlDB/Vv2DE?=
 =?us-ascii?Q?T09ojCNVLYD1sbKSy0wjvN1Agr0XCfbYyExrfmFkl5lh/dEeiXWsuwZ9h6DB?=
 =?us-ascii?Q?3rNBm7b3GN/ACngMdWC/KXVfv5idXEOAMowYzjYqtIdOOctGyvB/LKLHnGrh?=
 =?us-ascii?Q?u1JPZHWkitdbloVBytEQ4y4qcivhwiIw2PJIxvEkW3Qs5UaZIk4yzyzhQHDN?=
 =?us-ascii?Q?+wV7deeV8cO4nh0OUlmwXOoKPCtxn6rvhCLeK4Dm3rgnIZFcuZtWy5Nt39rJ?=
 =?us-ascii?Q?LIPjfK6rSnEB7FT+MVWsj4Sc3mpamP6qwvdSquC2Ru8g7CBod1bfcxUG1d3J?=
 =?us-ascii?Q?q0hA+KFoDsrl6UJQa378RbqRVcmThkXmiDhD2Isd+9MtcdAhIqLAVANg7FuD?=
 =?us-ascii?Q?ENzBhW5RQsNAKLHar1NXRg+i2GeywzFRFP0qEdgHOl5kGXjs7CCd+Lv3nT53?=
 =?us-ascii?Q?94ZnvaolwToURTiDODcmIP8BQf/Tf8RpspzJRbV2hNYMh7UWm05/5DMf/GTM?=
 =?us-ascii?Q?DzPYap6ubJXc8U2gUr370IyVR98kwIxuOdYdmfkkil0TnKWwR9Z82WOg2oZ1?=
 =?us-ascii?Q?nClnyLAj6W7y4bP+UHZOiHyy7PspH3o/gHOv9Xjlil2Pwdt5EHpdA7hG1pdO?=
 =?us-ascii?Q?2GFlFzNPWMRTZPvPxbHUMDMROyF+P1DReqi+wreZoYBjsX573NcMIsog7sif?=
 =?us-ascii?Q?tmTigVpoksRukVePM920h/zjyKhgUcpNe5gwRuzQiVdlNFeBATov71wEvGMu?=
 =?us-ascii?Q?ZPs2vyWKhXW7wcJYW4K4GFOq66Xo6gebbzBc0YAA9N9MiGEnK7M9OWRru/j6?=
 =?us-ascii?Q?ViVS2ns25GKxU5661QC9Ls9DkRgjLXSAld/AEYOrG3fQ7HfZF8Dcdb8d0TX0?=
 =?us-ascii?Q?6eg70Ltokx384qoBbMbIM6fHlC7XO8E5T2LQOmc6NDHYu586iW+p3qhuXETl?=
 =?us-ascii?Q?6nDRGdyVfrrlwDuEFwYVoOs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864de289-48f2-4cb6-bef4-08da8c072a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 10:46:02.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjsrxqu8kJ8Q313v6EF3X534X2CChrABI006sUe28rebmgfm3AHA6McBM/hQ6+QVCklGtIiXmhaZp7z5XD4NJ/T83NPqAx41xgBrTGPUX24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7101
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
