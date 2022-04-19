Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144DF5067B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbiDSJab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 05:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbiDSJaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:30:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31892B1A1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650360467; x=1681896467;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AQv7SOym4nJw7Lx2bP9cMtBGweObAqfTAaHgXnQeARg8zH3KJ+8zTes4
   M8MHG0PBJYSaRP00HK8FwVQGZaqtL+tMWZW5G3k4XBrDZWiouT7yGiTlX
   4unwVNwTEjcqBYmSuvMOyD1/NwYKa9RNS6qIbu5/e0/CwhDBiThgeG4s+
   +4nrMtip3P8HdfJayJ9Evgb+xZ/YavbOuLj8TFSk8txSwTZj/FGkFHKCq
   t8JIyCM4k5ySKYlPJGYQzMGRsl9hIYsM4Ml6PNeOoQQEQS5bSIaDavsDG
   QoO8Yzi6Janck7JF+mwoObUpghqr5gzFSxdAEc0d+XInamaeuXmplut47
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="203112334"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 17:27:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5q5I7PI3qpZTDCdYqNKRF/La9nq+LeC+2w4eE1r3n/0Lq28eMZPU3vloNQ50cVpfpWD+JDcA40rM1QFyhZwbu2MCPJCLq6r2ABkVjKMnT1uVktp/Ilijpy+n4zldo788xbwVanXsd+NeUbN5DGzv+Ur4uRleU/C6cj4mTWji8oyv6V27+W2rUMPXmZUvMFKqaaq2Oue+z57ZI4x1zd8ChZhOMQDE2/RwgSNe6AYi0xaoSi887HHPRWH1baZFqjq4AOlT/NWWXrSmNxaYlTFk6FdhmaHGAhjbspTbGbItdcdJUnhrX1igpBZlEMIKjFkySm54l7pGD3ObU2QI2dCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ObPH9m/CW9vsWUyXJEcAd/N8rbC0/+vNikV6sobNgk5aTn7kg8VrdcCXBUa4p0S0/o3uLg/c/u8KfsQdzxXpsTUbqflg4zDjM5416nodeO/yFfnd4ALvIZhxPUiS59vyHFhwimIovnOIIrlZDs0v3Mvi0fk4x50lQ6BQ7HGKd+vogITJKoXix1To1Pm+NjSCcH80U36O7IBS191Z5XrIityZ6lhLV6Fq/htg56UofNIrR8r9sWyyMuH35k+XETkt7HxUwtNquMW2vE9dT94UInb7wejTV7ygG5v3wUvZNqdEqYUNifM58OiUYK3TxvU0JDoyoaucHJmvAVCCAjZS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KDY6PVFBUBOo0GY4TP5MNqcEO0jXFfYI9XjC1F/QHPd2O7AI/uMnOxuhWq1SHM4mHD40VCkojs8kOTKrL6tDhj9cYg1m6SivkYKeYoiK1o1nmyEKLdiNovdfZoTpXXZ7pBtCCMNCC7oUo5WqUyRgB3bkVgGthmslUENWetCHuj8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6286.namprd04.prod.outlook.com (2603:10b6:208:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 19 Apr
 2022 09:27:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 09:27:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Topic: [PATCH 1/8] zonefs: Clear inode information flags on inode
 creation
Thread-Index: AQHYUsFZgxvWa43Zi0KLFUe+56saZQ==
Date:   Tue, 19 Apr 2022 09:27:45 +0000
Message-ID: <PH0PR04MB741663A5BDF29C44CAF2D2069BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8d53d9c-ac0b-46f0-b19c-08da21e6dcb2
x-ms-traffictypediagnostic: MN2PR04MB6286:EE_
x-microsoft-antispam-prvs: <MN2PR04MB62864B1A0454A7376DD2CC179BF29@MN2PR04MB6286.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvqpbaskM810VsCqrzIU3XBmbsQq8bb6FaH14RfAt+cht6xCXlbH9cagVGQkQEeD/ZCL//hQJGug6fopeyqmEMgyf1v/OVYVS/GKzxPo9HuoZfGt0ralyZE2ifEYxV8W9WxEPqYFtyRxShWXyu8psyj5AtJA75XD/UZ4fWPUn/EMFuVrynjvbG9VMPXOLaKP2rCXkqC3Aq1Pfbmp2qrRzMzWto58p/7kG4asCr+Jf5vhhpVGxhG/hc1WBUnVhrsDgeE7NbN9AJ82jUigswmmr9Pt8xN49VDRdjN338WfiyFS6onqoET+XCSU3WPchULO/5V+7NwxUZrvZHgK9Bq/CYOjEzk5Rvb2DOTxT61zEkEVdsB8ekgvMZzlNcU6UPCeuuc5+CKIjADHSzd6h/0U7dItI7iOxMX6Ud2qsVeX6P6sTEYw1aa5hvwBNiQLrGJMH/p2p0wyvqI77YixTlk7tUqYCB+SDm89RCUqaldhze37DwiIxmHQOLgFQFM/2KaxMWR6JiCslY8ciNSSkO4AHSvQMZDx+TMmngOXsFK6MLE7Q+sZjia3AlshRR3jEV2IDZqnoGVq6CK6rJNhfUdp0GvO94DEbc4y9x/JWirJgTZf8RbOEpmrUAyzlHXOyTKTpCkGSeUWv6wQlEpkunAwSox2oYTm/MaNZAYZiet98bHNPJWfYUToCekOJTbqJHQ93sEr5gREolC8L2FrweSxSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(82960400001)(71200400001)(76116006)(508600001)(52536014)(122000001)(55016003)(110136005)(186003)(86362001)(64756008)(66446008)(66476007)(66556008)(558084003)(66946007)(8676002)(2906002)(4270600006)(7696005)(5660300002)(316002)(38070700005)(38100700002)(9686003)(6506007)(33656002)(19618925003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j4bURiB2At22egjzzIfvoJf0fibfkv7aqZ63ZfscrczDEEP1upKJfBCxpiF/?=
 =?us-ascii?Q?chtzqZna22e6GKC2/cV7TSstrxnsYR8VdU5U7dEFnppHQerIocc739MeNm44?=
 =?us-ascii?Q?+Co4AdENZUJGOeVm2oODhdFJJe3XDzojlhL6YAXsf/jGckA88Mmse/Jfef0g?=
 =?us-ascii?Q?gfmwl9Q7hHVPtR9P373y0Yr+9T/+EoRKDOv9ckXM1m+enr+56QKRMevP+XV0?=
 =?us-ascii?Q?UB5pa4fHzjUZ+u+ja7Ch3tkrTmu47nXyvL+mWbMSpS+F6pX2Lk0O91OPXcMr?=
 =?us-ascii?Q?XbhyV1K53FnUF+44C42anIpLoI8zQob86fvBRiqXn/zcbbSN8yP2XxNPe0YD?=
 =?us-ascii?Q?evychMZgFREeHnhTmkodFUoEkJVxpr7X1v8/81kU+Fkn9JmI+V4C4jRUaxOV?=
 =?us-ascii?Q?9vRDBVFTh8aYb39qUZ15KHWWRoXMLhSQFJ/2H3EG+3qbKQ5XK8JPsmBWuJhJ?=
 =?us-ascii?Q?ecWQerlOLiKPjQH5e4vkV7lIkpdqstPhgty2MHKx4dpxY7FFNh/7cIrqxz9p?=
 =?us-ascii?Q?9+pGYzF/LzCaBSjJBe8Y7BOoUNdvAeuenKjIfjd90obLXiPxWd+GE/qJ+DN5?=
 =?us-ascii?Q?2LVGxuA1/NOmj4nf7he7jGt6x0+3yu812StNAkJShmRotOMTMxZe00OrN1yQ?=
 =?us-ascii?Q?f1JtsWE8QxpZ7C4+4J9v+aYYhEq00i/oZ58irLK0B5IfTHqeBsZJeB8tmqyO?=
 =?us-ascii?Q?Nz2H7bwD9GoJRmjbis2onksjVPHzWlk8td56sxNpgCPVbxrGCowhedYLjF7m?=
 =?us-ascii?Q?nNcvVdO+yDMsG7/POsgZrVZ6rKLMWTZC8WywacrfWgJ+Lm0/PlR+r6deaqz/?=
 =?us-ascii?Q?LrM69/4dlDkwWwSbZsnDDDDR4y9FWTurv2OVdgueCRHaNlbxpHYl92JU5TkN?=
 =?us-ascii?Q?sDkZNEVGWgCyOWL2ueqrmY8ReSR8GJNYvg1SmW762lDJjn9okULJTyTZ/5EO?=
 =?us-ascii?Q?AwzY1KuOEGIodvvck8x2KVBUAtO8Ha7+A/iC0fD6Y1laLYTeNtv6nBFuQLhi?=
 =?us-ascii?Q?mWPqAxMTfFesB/Ozt5vp+A+F/usHteCAKjCk0q/cm9yWSJ0iD9QhbXlD3etg?=
 =?us-ascii?Q?QZRdgRyZzNcqe9Hc2ra5aAYk0/X2hafp+aH1ocyHQwyq24m2qbDuThtTt3Ox?=
 =?us-ascii?Q?KHqe+WBYQgYKeVX0LdufTY2IXo4n2It9X75vkETitujHyA6Oq/1GVonyNFjH?=
 =?us-ascii?Q?20QtLeuQTIF8RnxZszM/CsFWYRlit3jUpcVinPl96zKE+dYkZKZ+9b7vhSqc?=
 =?us-ascii?Q?vKhtD33Qa1SQY40EqpK5VlLPAnWLIR4VM3vtatHa+y45JyCTnn2+KB6+qVYn?=
 =?us-ascii?Q?eIea19kI05OWIxTmZTqzgI0FFzsTXOj4BdWzaLIvWVHcUwd2mwqSWPj+zHsq?=
 =?us-ascii?Q?GybWs8dvoleMwqveWxmzQTnUmMC02hddi7/p0RVbCQ8ojXzFdTPwt8Aixe7U?=
 =?us-ascii?Q?iV0vLdFcuoe2Z5Zzv2gf80PlTDdjQWNepfd8GfBWCTRwuTTxDY5/ElebpNpk?=
 =?us-ascii?Q?4JhQqjWIpj9AMsfZ5+lnPuPPKBdiOsDE7NUIlD0sRd4sTCA99daVthnw5pzn?=
 =?us-ascii?Q?Qlb0oM6HahpyYS/8BMVbFg1fPfhw+aM02EfAEfdiqISQ1vveH06TX0XrFsKZ?=
 =?us-ascii?Q?w28ttyaOR+5UtSX3YtkNMqQkbwu1AaQQYY8+Z6UiSiw+Di/b9AbELEgrl08t?=
 =?us-ascii?Q?4g0DHcnZTSBkNnGaZb1krGHlssVnuA5V4wDfimAHFKi4Zp8Wy1DqyAf+Dwgf?=
 =?us-ascii?Q?42AtUR8+u9aOs3a4WKM1oyngdHJvI1sdFGcPpb2HN4lKuT32Wr70vlWyXLTw?=
x-ms-exchange-antispam-messagedata-1: yhJzbWaGofpq8quuY7D4RD49NkmPLeAEs0c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d53d9c-ac0b-46f0-b19c-08da21e6dcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 09:27:45.3833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hs169K84mSUEUA3zJ0H0fvHFJpGsEvXmMQf+iaqOt100buAirdkoPI4Mck285N+20y502g+1pKlFBlPXrK9bvwbK/gDWuqRhDATaVpgPdr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6286
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
