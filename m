Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924BC532315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiEXGYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:24:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458E6CABA;
        Mon, 23 May 2022 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653373485; x=1684909485;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MXBCON4IjqjylNG5c7tWATGLkuR48VZbHtN0LSHDTyxdKQHeJM0uQ/8n
   Akacw2hAoVMcW4EMKTE4VHmPCEdMc/vyhXxw0UobhHzWEI5w6Z7ySOfWq
   ryj0d8z887zNAPm2lQWp1cz0/J+8xXhQMKL5K425Z2FjiE9DLzZjpKnbB
   kA0UWO1SH+0RAjj3CBiT8X1G3ei4Ytkt3QXFpTLdXyPV1uw6BufQ7sERs
   dk2cvr4aUt6eL85CdsKbUQvgQFr/FxATrOy6mExKQOPXrUYRhX9X/K/rk
   vgVVS3pUlP6I7rORhhrjfiK+aPfEoce/FayqUmjBa0CU6BMmiTsIcngty
   w==;
X-IronPort-AV: E=Sophos;i="5.91,248,1647273600"; 
   d="scan'208";a="313248404"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2022 14:24:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOBPlYUFeZ4O+BB/BXnxCjQtmwBly9fb2CHyM5MOxwqQMOTyM78gn+VtJFrK+2YLvsB0NOgAisOb297qr3SrcHfeRxq01AylCveh1OlSoKpZkGQ28NIDgIeKZsVCLqyBOker07WmM/iQlzI+MeWuoGCZTnI9wSakGf/Lx/R6xGDT/NX6er1IpyD3l/DcqhhUsJmFHbafKge1AMeUjU/pl5DTQB97fNcMwIhiqpftznlDE9IVtcgcCy7+H6ftSMAHgZUdUl42iStutczvNEk7svyvGNOzK9UlfwKqtb73UCJJZ/TE3DDUFpP5qVvS3tdQhcFz5Nv9SJu2RYDtv0bxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mQfWKtHJd7MNehcpRC2h6l2lk+gwRZC97nWAiDiwPLTwED0GWzzGKc2381Ojechemlhp3fLFDFxxb5mvSufToIjfAaV30TS1s6g8I6B0KO14xzrjL7NUqy4i9JFUm2L3uU0KC/5fHIYVGFUslzTGYIB3btcB79UQm853N8OP2dA+FzN760FHaR1V4D+NdBNxVkCNVEJsHbvVqFdnS3N9I8Rh9RR9YyV/PwgoNveZJtJuzOQLhKyoTQKQtp/JTpSRP5i8IB3ijbHU/949QvRDP9bE9NbZTLyDvQS8fbc6FMC1m4DXZZ8YZ/YixbEw5YMOk15eCzMMiVlSR43oWpCWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eLiJLc3LbQ6kCIyjDbKms/yKKWAtEcgFWZeYk3ZdeFjKREkyMIcpYkgQHussgwykhiw5eBRfFHYuGGjPOzm/Sz6/WP8Q09H6WHHB0HbQ0KPxketWRaBxxYzLRsHWRpgBqigzCWJHULx6B9VGcLu/qO74KJN1I+CxznJLp3AigIw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6879.namprd04.prod.outlook.com (2603:10b6:208:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 06:24:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 06:24:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/6] block: export dma_alignment attribute
Thread-Topic: [PATCHv3 2/6] block: export dma_alignment attribute
Thread-Index: AQHYbuh9qEa52E72skebBKpZw1DY0w==
Date:   Tue, 24 May 2022 06:24:42 +0000
Message-ID: <PH0PR04MB7416BE2302B57947C9DE6F969BD79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-3-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba17912-a655-4d61-4fdd-08da3d4e16ed
x-ms-traffictypediagnostic: MN2PR04MB6879:EE_
x-microsoft-antispam-prvs: <MN2PR04MB687935F795029517E4B7D65D9BD79@MN2PR04MB6879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6W3IhYwYNwT/wsGMp49l366A2lrtKtkI59TM/IAJOPxPRVJ7wL+C+DrjCvlrcrs7ivmAPt6eXf34UGlm78z0PceR6ZT82s25DU3ZtOC264kEPlSuxvAZYpwvDahvLZ5/k9/EA6GDjqy4L3HgY0V34xXBZPiRRMYw0eSN+8UUOoLl4zkHTfhWOpKAqSC1mAobMaxbQajMY25GqiSDZ2ZLzh5e6RCJ9L6TSJBxwxNrezmWfTKYxRL2qS+qVyLaWrJj3Ogbye4Ti1eAl6O1NYpKoIPwOsH3CUX3ryWSocp8lOZ+X5+dYPYPMCzKFGVRc9sC31TGtzRM/4/V3COdhNaJfWYwng3v+z0fyLXHrw/EFTa55EnFqu+19rnGUlAiT7XPJ1P25q9IaTlLPbpe13vo47pFjZl8Ox9MjFYiFHAjlZpEFBLjx7+meFQ0CvRFIypPjOngmxYGQJL97WfDxxy8cnrU+GFcaMRFELO5cmvUD0SKhUOaKH0cOqEKVRI3sYWAj6CZRcb8hMG+aX7VhizffKNhScW6vpdB0Ldkenjt3WrNKn1k4z3IU7GsLY7jAAgkt8XkB3oEWuRs396ryJlPmVM1XFyRVoy0AxOXN11WgaZPK3HDTSdXhRK/Wn9FMCTmJoVfUnxkWLfRUlpoNF6Mc4H4n4WJ8nvSPQcy5lKLJJWy7h/xFGNAf/TTusJK6oKo5TYp468ZgZeTWKWg97mug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(82960400001)(33656002)(122000001)(508600001)(38070700005)(26005)(9686003)(7696005)(71200400001)(55016003)(558084003)(38100700002)(86362001)(64756008)(76116006)(91956017)(4270600006)(19618925003)(52536014)(5660300002)(316002)(66556008)(66446008)(110136005)(66476007)(2906002)(8936002)(66946007)(54906003)(186003)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ThedNXjsceWvssK+jiYijakEDmR8IkUehecc1eFCCp4xvylF03JT7x0jJtQo?=
 =?us-ascii?Q?Yi4vSDfyxsKViajhe7FYVAnlQp9Nu54rWFr91WkD1VI8rH4bssEgZZKYQQ0Z?=
 =?us-ascii?Q?FWyfgDdQs4356I/TiAmPCdyKZE6B+quCgCu6MxJ+FqC8LJEv2Btifl96cBTe?=
 =?us-ascii?Q?G5eazs5LfmLg1guuejZvNDoJGhpFAOSzbJ9Wy17lcWC/TCxuxT8ojLh8IaEh?=
 =?us-ascii?Q?FAClrbgSLBfz33uxSw3in3Ev7vulc80Efd53AMVz7UmHj8ayl1AFPr0Rdcvy?=
 =?us-ascii?Q?Cq8WKwL5xWVy1W/idaFaQj2xwB7g7nmuZjPgf4AqHyW2ELSpUbtOVh/9LCTk?=
 =?us-ascii?Q?MhFJrRZ+oqMGqcUjvMKP48AVurDhXLSompk7XjhP5Zxyaw8pC/ZYwMGniLFs?=
 =?us-ascii?Q?ikrsufzNzTyoFZS+BmrysVw8uIuAFw73qr2uuBEDNnOVn49FbK2IA4X98g/o?=
 =?us-ascii?Q?XQjKJODvqYN+Q+jTEnwtu4WAaZI9zngVATILE7HxrQDe1FFmTGwumagVSXlZ?=
 =?us-ascii?Q?bks2kuMpEAVjkcMufMiMb1PEElVioFQTA8VUAyEK0x32F30uKN3pTcDEV/h5?=
 =?us-ascii?Q?0ZWC2P+0R7dpNuy4Q/idTim4sLT/uMRqALF0ve1xJdOeTHWM3OClhRVrpcIb?=
 =?us-ascii?Q?fx2TsbrCIDgQNMQHT6RaYtzBqI9dW/+C0q1xuMWeTWhXrE8ltM9Rp31Udkmb?=
 =?us-ascii?Q?TUo/bKR/+UJae1H55JarrhuCjHzR19X8DyPwW9dBMXlO/Rg3xmZLVYWdL/vM?=
 =?us-ascii?Q?YcVAXIzFHIF8DMJ+996z/lIslvyHVrhW12Lx5mJcrS0xzJvWXABVU7C3d4UY?=
 =?us-ascii?Q?zC5KUw1jkc4FHaWMOZLNqqXSYgABPk6ssL5lobt6qGdRiXiL46B+3F+HjyvT?=
 =?us-ascii?Q?RYDPR+RIkODrB/D/By43q1TeRjtrTOCgfw5qR+BQb0JbZN39QuRAPzlXECsO?=
 =?us-ascii?Q?I0bLGRGL3ftIXM+HLBvnd/rrKFsQ03QG8/sV9rC2NzgxcE/fPdXrh5V2gp81?=
 =?us-ascii?Q?IFMBjMIMKA0XAaaKmGAAK5r1bwhSPvIJQV0kNUklHjfH4bwT/9GWBan1Ln3F?=
 =?us-ascii?Q?yBm9wByOUuMi4izpY+iNREPbvBmCzwbYocsBtgIw2P7a8w4KSGPz57EcaYaX?=
 =?us-ascii?Q?NwE/6jNULQ6KoZGV1cs8vnnys/Kn7zmvgS56xRRWGlR8YspUAUrCdwI090Dy?=
 =?us-ascii?Q?HlCnseCqIBXPdaH17MUGYIJgz2GCQpOaxXWtbXcq4eKTS2cN0VBQi7FkO/Ec?=
 =?us-ascii?Q?Ic2ADcaroab6d49stWAxJEBstVKIXg3T8Uwl8WQTG4SEkL7Fr/GwKYuH1LXF?=
 =?us-ascii?Q?vQDnIAkVMdoJM0WYK/5I0ehQMX7XeJ7ePZ3+sKYRrlVppDwDhp5sbskoRv5b?=
 =?us-ascii?Q?O2ja7LEbU6g5bY9NGQe+sWj59kdT1JUdZsw6pM6rklHI54OVq31y6rwoKfhk?=
 =?us-ascii?Q?8Rs4F3OZt4qcc6uJX17ZCrb4DMrcKy7EjXB/kKoX46famyrhV4LNg9zt5FOl?=
 =?us-ascii?Q?JgpeK88POB3TYXTatv9wJ4J/+HBVDgIe3bZ0x+k6K7WnQRC1mc4I9jMgFDF0?=
 =?us-ascii?Q?BqmzCIB1VZ5KkBBlNLf09PrpXMF4GUGrNqbr3G3ZvHIbXT45WY9cGc8m+eIZ?=
 =?us-ascii?Q?is2Z0xDjrHbNCfE7Wbt+P86sRT2gdJN0uKTGw4GFgqAhBw/6Jtw5XfgO5u+p?=
 =?us-ascii?Q?xOIC8u05x1EJGGdlD64pUlU1qjRdWt40SaB4R/AMZg83P1JFWF2S5pCB1M7s?=
 =?us-ascii?Q?PQtflQWJ/YyCxagZSWKV4xiaKItnp4ko9Ejuo6/yJC7SAL9zD5h/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba17912-a655-4d61-4fdd-08da3d4e16ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 06:24:42.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjaytd77uw3QdzQb6Ed8Vo5SgfcCuCtkpqcdGuC1T4tjGqXAzPl5nl+w+lv84qSDdRJWvWq27PHYF2Bnb1AFesbGRvNC6nXYj6HSq90J6ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6879
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
