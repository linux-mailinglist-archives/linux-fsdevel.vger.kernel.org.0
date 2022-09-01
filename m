Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B7B5A93BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiIAJ67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIAJ66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:58:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8C1377B6;
        Thu,  1 Sep 2022 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662026337; x=1693562337;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dW1r8+2HpvXjF6CIHYNMp7E5uDZV8TfnJMyuqyc/La5heJuIHyiwhjuh
   Chs+5oWS/KSJIdYvwLwDyKwyQjGr3hJkktQ4t1G2A6LqlEoKFrD0YGCsE
   FMtMYOS9flEBtG6dbFiUkwTg8IGUJtvmHckLAzRpizXtN9KuBy5nhCcH2
   /Xyrlz/3Y0KvCE5HNFY0WqDWOXthjvg6xVk3Zm2I6SfVi3Xf29lZlzT3s
   PE1lzckQAqi/03Vz6DwoDJ6WvJYW5WckwFO0lC0Rm+kVq3ZOZIebZ5Lc5
   BezPHl9x7QIFVLyc8JJBOBt8R8Ty5Bb2lKHeWTLKyTm3kfrVeu6fVIXjZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="314505813"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 17:58:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTH/VTurUwiTEc8CeTs8wQLFcZ3u3Pff9+csVOvSzcq1IH2POdS5V7vmxcbjUimAYnUnoWDlSohHiY9QGrR5lHtLFWIYODOO2e0qs3V9tUYkreBScxFWk9qXn76qZ+HGBftn4gh9yJJG9mVzu6uEzbHeH6UlyctnCD6IOMnJ5ji5GnQCAgIK3mrzSepRFpj3ruUJiyix9SKHJoU8tyAt12gGFghugnHV4Fgc7J0Hra67eDZfGJmyiB6cc8+aYaF4vb4dlN3OFpZJ8k5f/ClVAtX+QVNrbUoGPopN5Jdr5K3KApk2w+kPtH1CvPQL/4a4vtUYLrTaOZe2qqWOztsTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jd3WUD/fDgrniyRG0s/ZegZWsEoGbO5KApfcJw5BImS18BunEJmTtBjfjxvmq8OP9aD3TXrY22ZC6cSJ9YuGO2ds2h5jH11qf9IyToWtVpwc77RIJdjqubEOewzHszYhwpiX9d5fS/DGj6K8o5M1kFclW0B1A4zFjrxBzD3P4fzUcStOHcgd5bLi65JbgcnvJ3z/l4VBckjkNw8EvuekmSEtfCLnLkTtdPfGsU9peE4+bUeZWN1IIJEST8ORK0XWgOpC0CPsKK0jZb/M6l+nn3FfPPSMSffXshksspd0UwhhY8AUkNKzq4/nxWgIylES+hRskfdK9Im1WjNrm6pVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aEIx7LDgknwKYg7ITWIpCoMFa7nZjlAiN5yxpJNWIUDqWJmFh7FwcasosfpfzlRcLkuyxMgjn2DDxJqiKZA4DHOZ1mNqusMYd2wkZ0ltL9uZRwqiqiDg4YI+f/2IuDH/XuWpMNZIKfNAfCLzPPbafNFT7Qdm5ovRKo/aVwJ6b+A=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB8358.namprd04.prod.outlook.com (2603:10b6:a03:3d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:58:51 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97%6]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 09:58:51 +0000
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
Subject: Re: [PATCH 11/17] btrfs: remove stripe boundary calculation for
 encoded I/O
Thread-Topic: [PATCH 11/17] btrfs: remove stripe boundary calculation for
 encoded I/O
Thread-Index: AQHYvdZ8z3W6WteFCUq7ehTt8HHd7g==
Date:   Thu, 1 Sep 2022 09:58:51 +0000
Message-ID: <SA0PR04MB741820BCC8EBADDF0E1AC3119B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e91a9204-868e-4be2-c311-08da8c0092c9
x-ms-traffictypediagnostic: SJ0PR04MB8358:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkauTtfjrYSyVXGTK2ZsPsErnYN7uPr0e0L5sbmGGNcNKAbLESPvj1o5CpMD1hvGCJriAt4B1FfnK08pW+pKTLeiaPRTdODEvNmUBcqV36mEWDN4RJNI/p/Q7sGO8UNyLJW8Nx3Y0LdYSC4hQwcRjcwAm24n3rTko6t1k2CIvjW4EBy1F/v/jXWTgp84MNbHbIMODAZcNjvseRfKlfhSfHbxmBX8qn6fQvAZ5ShWjFEXPnjXXByDaU4DLBCmJm1oiZ161AfUGh4oCVuUfqWigBjiUMIY89AWRpYdhDbQhKZZGZTkTnJw8MmJpEmhX0m+Iz9ulOyBojGskE3in6OZsWwmgPuVkGInsTbvuQTWeC05556pnQVJhwo49e8vqMDBtHmTzAjvDGITAAWBz9tM71cVIydLFGY1bXLQiuFVLZnFgtkGD6r3AVQ468y9LOXA8MLUMAkT+tI/j+jjqIP61GzpCT1tEY2v3tXbmUT38O1nqEb2a8S+mQrwRlkmCREOeWD/c0JNfirYObcl0FeKpz85TjAf8vb8YaDBzGGxB0qsmxisKM/7uHYbnWt/jajbfdAl0LYPEQLU7tU48aH9rxW2XeYCORwg9UfVbndg6F/oZzjEoRV/pyHZxE+i+oPFf+acRULloZJOQFeBQpVgEQ7kqKPUeruvozEg1ra5Q8huVba0+/+gU9bO3tXgWI6CWTLgqM0MvdSLeZYnKEJ+2jPI54nbo56JA4sxXloDxVvGvkoN2uhQTpbKO/MNj4WeElMBU5xB+uCEsbCwe17kIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(9686003)(4270600006)(6506007)(186003)(52536014)(7696005)(7416002)(5660300002)(8936002)(33656002)(558084003)(86362001)(26005)(41300700001)(478600001)(71200400001)(38070700005)(91956017)(82960400001)(38100700002)(66446008)(4326008)(8676002)(110136005)(2906002)(76116006)(66556008)(55016003)(66946007)(316002)(66476007)(54906003)(64756008)(19618925003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?++gxPGP7uVQf4P7qgLdcz5PcnCgQCI9J/zbUgNt69wlhk2Ug910LgZH0ffJh?=
 =?us-ascii?Q?SRIDLYVIbVWbwO2/3aOYooiL3hlhmM/usSrESdqKGydPUFihjeq1ZysLATm/?=
 =?us-ascii?Q?z+Mvc09Th9CYdy04H7V0dPwBSq5dDKxrgaBbuJpLj6ZiDpuWZIN+Khuec2aa?=
 =?us-ascii?Q?al98Ku/Ysa2x4N6nS9jlyGqKzlmdcIc89Q8kJFTuSTAr/sXEDi+GxWqMXQbY?=
 =?us-ascii?Q?SmMgR9nNr089YGY/SRazxFRBkTlOPAvzfuDPsu49Ft5UDDtHRxdf3eOJh4Ck?=
 =?us-ascii?Q?rCdSv6CPWu+9trc6dMyjd9YLkAyji6cdlpPB8BbAuTPE3v+oIRYQ9onNtLHZ?=
 =?us-ascii?Q?l6w7Z9Eg0OnJSShgmjOGcmarYowEjOeZH3vDAiRs6hyhDEJpXYUG8RVbMtxK?=
 =?us-ascii?Q?HXpButH2SlZwRUjfh+7YNlCSAgTRaxLGh87dEXFaadX7C5MEMW76nypYICe7?=
 =?us-ascii?Q?n1B0QcTKCc32lKJyIMh+htCdjlYO8BVteYWTFi3bc1V7N86xBi6yx6TJdPCF?=
 =?us-ascii?Q?2uQ2FLEx/EvqulFZjUprESJFEI3Ms/pa8G+TN/6vMrz0Y0xKlaC2QEAX45Y4?=
 =?us-ascii?Q?fk/SBY/4knWUtaoBoK6cPH2RG381Mtgnl0SIZ9BdVwBjZqNb8kToNVSVKxe+?=
 =?us-ascii?Q?i9C75Ku1LWocHDxc4HM7YOdJYJSv9ehpg6Ket3hAAc1Z4m47HMYkVnCIGlfa?=
 =?us-ascii?Q?a5P01cYTGxGE+FEBOgwhIwqjH3b2mOFEs6j6wDFtoBm8AikJDDWxKXHW0sc+?=
 =?us-ascii?Q?IWwKJBmUg4A1sI5hwyQ8KTLdBpg3oZGTsdl8MznKYd26XyTVBethoHr/V2cY?=
 =?us-ascii?Q?QqQGgihyXUNRNetEt+DjV1TPUvJgqCoO/zCVqK4+siAgulEgxJoPyc1lzn7O?=
 =?us-ascii?Q?M1SObHX2F1vjti2jqa5osQmGVRuHzC5cGr5J2/04KAxfuMzj/gwGBX/NseX/?=
 =?us-ascii?Q?mBcDNzSQ5auj+IHdMmmpWt6liCDhY8o4SgN/lLUbM7XinkDhl7I27Uj64mEf?=
 =?us-ascii?Q?WmBpbpd2pzr2ctzZx86QSPTUsZjjAUgXpZqve/GpqXgvS5wWL+/xQ+ZTiAx/?=
 =?us-ascii?Q?ZNHQt3/27KOXUhs9pto11PbsYjxDazOaEkGTXsf35jML8KboT6DG6guUWWVb?=
 =?us-ascii?Q?ooFFzj0gh/eOPtiMSU1rFXvxL0S7A81SyjK09OElIRyWEoK+sIM+nVr1oSGG?=
 =?us-ascii?Q?8v6zjvUOkkjVOD4/DwjqJJS6Ii3UJdu94fmEhV4YbiNPDhl5fURaTdpXqGqo?=
 =?us-ascii?Q?VKiCbbd4LBdJuEXqRk1OoMS4Dg4u+kD6f06qU4T0EXek6qcDclmS6TfCeyHy?=
 =?us-ascii?Q?4Q3TvqDYxAg+Dyl/43fbcIzfeub0xN8igKPGp45GVphBXS8/OQolWb/EXRyg?=
 =?us-ascii?Q?a12tfS+EHdjHGg9u4MXEVcwuOoDZ3/rPEhM/5VeILuHHxp3kzQfNF8IsUPBn?=
 =?us-ascii?Q?4zbTR5WOrUq4Pcem33EKIHXgOMBNFezmTcDEVAdrZbTuT/dFC8eSIm0dme+E?=
 =?us-ascii?Q?QX9ci9vFVOVp+f8N6pbBJUpaLUMorGVI7hlxmwPRH2BjbSjHmMnZO2Q2Q5uR?=
 =?us-ascii?Q?lZQ8lFSnbrh40s9wx1bBTqXvnRSkBJBoIFoaVadIKSsTLpvaEU6jzyn6SVz1?=
 =?us-ascii?Q?235i0LwGLyH050EdG1auufE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91a9204-868e-4be2-c311-08da8c0092c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 09:58:51.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8J6HQzlA+xo14r0Nnaxgvp/VBuqexczRVINnqYsrUeNMcDXLIpmhBcmfsYtRo1+059/ZBIZbR3z/L4M4aYP7gLKr78TpM1/qoSa9QJGVqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8358
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
