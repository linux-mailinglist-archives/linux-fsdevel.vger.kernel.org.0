Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85E4B0E16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiBJNFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 08:05:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiBJNFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:05:02 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 05:05:03 PST
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6BC49;
        Thu, 10 Feb 2022 05:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644498303; x=1676034303;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AEYbXH0OPgxYf5670XPlUnFqTnkWlTZaqiscCxZSii4=;
  b=BHz0WNh9sv0az56GlqSzKXVHi0v3Iv7PQXJN3jQZDBnU0IHEGr6He5Ko
   P3dwTtGqaA58aAbNE7I8UH0t8It18tgUinFyC9JBB39P2IB77HEKbY0lh
   nQdMhGjKiVtTMCAe91lLAHjt8FkDLASNX+0fxiAR3Xwomu6GyMY0jepOL
   KS499kqKjg+wgimpsQIocpT7O012HoxhPia6SQfDvCxQcXTlyp/dXbPzg
   sbRc6FIsfIIqKSsZDbgP7MGz5w1Dmix1DH8rOXu+5vozQgk3l9DL/L4nm
   V7cVEmQvghqseuvMcolhvkjyqa5VG2X3a8rBmE5pMML5h6acqgu1B/V3/
   w==;
X-IronPort-AV: E=Sophos;i="5.88,358,1635177600"; 
   d="scan'208";a="193579544"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2022 21:04:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1Xb1ZkzP35AXsqy1ptCikpwHd6WMV1kYgL3M6Wp4Smt2g+3WglAn2i+esw3kQ1pxQu2b0TgBTz2Avtzh2hEKAq8wqqWgT7y34aNzcTuuJdzK9MHdiG9bGZCeNowORLjp14TtHq6DTSbNWDHuKWE6RV7xYGc+wYH8cQPrGaMBkLHKphXvZ51d7PmnO3TXsy0OF+o73LRfKYVGWz3eQLOuBtPXaajV+aTqTMIAQgsUSS/qOnW4XvOODXkG0XuaVNrjDTRNGDGfb8Fyhg1Uwa8xyynTPQeVGGZLhzQvGlfxzPhuBMUG8nYwpYuPPRZL4+5nMXdJ1GlFVhOafCgNZW5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJx0kITWkVOltRdEjLsT/rE1mkijTxVaUKCyqFTxkgg=;
 b=d7RU2DzannpX+WAkMTTh2MID28BtriBhd/7Riet2b8lltYz9G4Qx23WtR1DSA1E71+pSKSziCpRqeGNkkAQ5231+1QglavbSe3uHXHQ5WlX815hs/BmYsbt3apnKw1FJRaFdl4FSWnpYe4ASBdr9yWGM6yPOBX3KD0HAhALD8d0KI8B659Kug3EikxAlYlEJNOWMHe5e4vPasO7v6XbqeDMBYpGTjkcJIfSiDjOEarC8m9LecMulqntZyNZE9b8iHb7QhaxqA8K4nIZpWOw5pilTf1a4QKKZxxos9Y/HeVZxQ9NocOfccNWfZKPbIKJdCPMuIq/y86GCsnLhpP577w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJx0kITWkVOltRdEjLsT/rE1mkijTxVaUKCyqFTxkgg=;
 b=BaMJAuPCHDg2TQ6XmjmGboYcH3B6qzBAXgy8rW3bwbiGOh1+uD4gUHvYSAB5cQRmQbw/qkk6A2BJm9dXS8trnfM7c68W35tnuc/bvzuw0eubeno2dLnXMX15KYb80n7kP+W1VUsostovI6PIOD37f1IFI8JzhRbjqDbKftvrhuw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4818.namprd04.prod.outlook.com (2603:10b6:208:42::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 10 Feb
 2022 13:03:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 13:03:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/2] btrfs: zoned: mark relocation as writing
Thread-Topic: [PATCH v2 0/2] btrfs: zoned: mark relocation as writing
Thread-Index: AQHYHkNcg+VbPtFIgU6msc8f2UHFLA==
Date:   Thu, 10 Feb 2022 13:03:57 +0000
Message-ID: <PH0PR04MB741614EC7F5E78A39ED9360D9B2F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1644469146.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1913ab39-44b9-4962-5b7d-08d9ec95ccc4
x-ms-traffictypediagnostic: BL0PR04MB4818:EE_
x-microsoft-antispam-prvs: <BL0PR04MB4818B762DC7C21B6995026CA9B2F9@BL0PR04MB4818.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTxKuIgtadJq3EdnQqXMGVqXK7hucdpQJVH+QedGTRZjej3cLcVG8rQxS/a52Dm8k4gB+VPex8EjeXjb6JTa2ldmVla6EwoGeVkPFN7bxCm90WyuidOfvBYSkDOlPPlzwLysQjJuWExavxIg9b2tGCWZ8yfR0RhxmZPRxUbZtL4DeDD4gIegFaPddxb8TQEv/B7fAciCDpROuJJqgHvzuz5tgXYl8CsAKP8W9zVzCLHjbeWiLUcwBe6zo8i+VkhFWqXXV5scuOt6PUu2Q37c/17UEvalRA63pzrxs4Xj12UwDlr7WVZVC92Tz/DyAXdMJURfAbUT9iuodeOvNRRdDSIPHR1kZPY6fUQkRlefLvpXP1S4ePBViPa4taYeIE4BiXkfClq3YCTs8JSIdvhFCkrhLsZ3Eo3GqVtO4mmi8TjwtzlJClq8+HR38WPr4kAE+flD0fRlfVSEwWSA08m6bLEk62825DaKR/Iqc024IG2fD11SLDChGecca1praLgyD71/zkhRoZRE+49adXgE7/DQNTQVikrm1h6u5zsHGQT90ZTcbMTWvfvx0yYQ5kZJ16APwvthxNC9QVAjuuPt+/eiaCcfDZLzOhYp+iRlu4tjaha7+fhki03xDyE5+98QEuJy8QnSDzGhK8GpRaA18VFF0dJ5ZdI5SEdsPjbQXRWXu641SkWUyk1/S1rUKwqYgluDmzvVknVRbKwDnnphwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(38070700005)(82960400001)(4326008)(66946007)(66556008)(64756008)(66476007)(186003)(53546011)(38100700002)(71200400001)(6506007)(8676002)(54906003)(110136005)(2906002)(316002)(33656002)(83380400001)(55016003)(91956017)(8936002)(76116006)(7696005)(52536014)(5660300002)(508600001)(122000001)(9686003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TRYtXCAwUBSVVqiP1Iz5k/6E9X11lJacnRVmb5RhIUlc4Fd7zy8oQD3nUh+S?=
 =?us-ascii?Q?WPr6pOpAu9ytIMoYYiEkUVwACQsi6eb/sYGCNM3n6HXaTMQsDP8AsV2CPl7I?=
 =?us-ascii?Q?J676sevyioUxifwfrxQfuhLzYJGSELlEIZTTwUqwiKuOa4q6VwJuwT5tYmOo?=
 =?us-ascii?Q?vNdtNuTUvXFzunuxTkhDbnYbUP7BhZMx1IX4Ng2r8VSzpTyMtEEGkwPBPemA?=
 =?us-ascii?Q?v7C6DnrOtrAu343UYWsUx7xgAJCDYqyVt5J5KyHqf2qjdWQ3X9DkhwM/Jfur?=
 =?us-ascii?Q?KMkdOtDuoHin6esLH0I/9VGjnlW+mj8QXYhVbLz77Ez2k9yA5/1S/mchy6u3?=
 =?us-ascii?Q?v6PvSJpqR1Vgv0nK1tY+8UgrTMvTmlgWZic3mWOQ/OZU3SFDRYFIGY/wA1N7?=
 =?us-ascii?Q?S0eyqEskkPcnX+B5+U3NYIuaSd6nLy4Cjnhm18KhgNxS31CwFMxHGdoD6T9Q?=
 =?us-ascii?Q?XXWP7BYUjA6xwMucndYZF3s5xZas11ilLXaQFb1EAP8T8fbnDaz0tf7GEqrh?=
 =?us-ascii?Q?6gvrEMSuEkBSBjjt4ScwiG9vj2sd3y/530Quz62Sthpx3MSHvB2VlAlacmlK?=
 =?us-ascii?Q?EW/Mw6l/PWsDMUV1wzi0FmeRWa5etYL770TpLSZhdJ9l5pqiwaBY/WvITKNy?=
 =?us-ascii?Q?2tSIa6Jz2XzL6wkl4iggjiHqnGAVNpzNBiqESL2iZTaEkFNNg3dGAbWef8tZ?=
 =?us-ascii?Q?0kngmwT6Qca+w3Sra4OK5WfB+4jV85UZ75lm+Vq4bUZAaGWHAiCZxW1uKABd?=
 =?us-ascii?Q?qRW6JcTs+Vvt9CC7BHNW9CCPYan5vv9227JstfWwi7st1M01VkXFXo8a4S3J?=
 =?us-ascii?Q?hjLGUV2qzxDY4xe/Kd4Wvj+nwH43mlR6Iao1zhfw9ezpoOjYvbGUN4UOcYZ/?=
 =?us-ascii?Q?BE4rfNpNeQfXNeA7gpLNY5RjesZ3b+2VngHUw/awnC4Rkw3U+/UDM+jKTwyH?=
 =?us-ascii?Q?MC6vCLP/vg9vkUzT5tKcGbV9scrvOUKg/ELC7/UvPXj5A/WU1zfTUPwc+m4o?=
 =?us-ascii?Q?bW7nt7hFpiwWGnOEWX3X7RgPEDEs3uVxxgYzG9/iyRxbn8IzjpaFibEfkFDx?=
 =?us-ascii?Q?m01+KaeSjjQhtTDA7pypAr9Z9Qv435EQmw679lNNxyzRhL9KG2FmGS50JM4L?=
 =?us-ascii?Q?98hBysuJCIqK/cEbpKNEAeBckx4GOCNyhkUN4xIbCco7IYwp5yYplwr4oox9?=
 =?us-ascii?Q?iGqWQy+BDlN55vgQoajtUGqB4Z+coBE8OT3YaLy03cuvUNNNO12ire2NK73A?=
 =?us-ascii?Q?tLT3qd9PQ02FZbZTMjfNPIBEwVMD9XbtpnoGGm8Lzt3zVj0sIiAcQC2u3Ojg?=
 =?us-ascii?Q?9idhBszBmzgHsTOfF5om06Z8FY/vDkSwhCymnsZoLbQv3gJxwe7NwQaz833i?=
 =?us-ascii?Q?Qzk0A8dxy94BYkat8ZNpd1Lqrb9O2VharYhcGzsvtKsszS+8GzMKXsRq35ER?=
 =?us-ascii?Q?s8klvGb2Hl+VF7hM6BtTVt8hPZPboyzANcAPD350w+Qcdnux0TreG7Zv18I6?=
 =?us-ascii?Q?EDX/+8pFKMSnXmpS9ei/toVT9g3I5Pz4gq3og2iQDfTR62TGCf8b/59a9P5F?=
 =?us-ascii?Q?Nq//4zwo3tRBiBKOQWJwlIYIPfdzz5+12OksJhh+p7mGhayr+u9Qwy8D8F1g?=
 =?us-ascii?Q?F1Ldytv5vVvARdoRj8plpgidkymzttbz4EuTxKg0aMuRSu7I6igwv854zPEh?=
 =?us-ascii?Q?rK+xDrhYA9Op9x7ws35Yuvqn4/FsRhM+hizFoIWiWRgD0j7gRkBEksEkUVBj?=
 =?us-ascii?Q?3z0hN7Rq6CKFAp6wWQ16mzKnujd8DHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1913ab39-44b9-4962-5b7d-08d9ec95ccc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 13:03:57.8245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSNoD89dTVmcQWeRGLRtEeea2F3y15B1iOteMfZWFFTqeB7f51hK+46NdBwcQHskORuWxV3T7Eb56plafHN06tUfztCEjjBlCbqomAj8ee0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4818
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/02/2022 06:59, Naohiro Aota wrote:=0A=
> There is a hung_task issue with running generic/068 on an SMR=0A=
> device. The hang occurs while a process is trying to thaw the=0A=
> filesystem. The process is trying to take sb->s_umount to thaw the=0A=
> FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is=0A=
> waiting for an ordered extent to finish. However, as the FS is frozen,=0A=
> the ordered extent never finish.=0A=
> =0A=
> Having an ordered extent while the FS is frozen is the root cause of=0A=
> the hang. The ordered extent is initiated from btrfs_relocate_chunk()=0A=
> which is called from btrfs_reclaim_bgs_work().=0A=
> =0A=
> The first patch is a preparation patch to add asserting functions to=0A=
> check if sb_start_{write,pagefault,intwrite} is called.=0A=
> =0A=
> The second patch adds sb_{start,end}_write and the assert function at=0A=
> proper places.=0A=
> =0A=
> Changelog:=0A=
> v2:=0A=
>   - Implement asserting functions not to directly touch the internal=0A=
>     implementation=0A=
> =0A=
> Naohiro Aota (2):=0A=
>   fs: add asserting functions for sb_start_{write,pagefault,intwrite}=0A=
>   btrfs: zoned: mark relocation as writing=0A=
> =0A=
>  fs/btrfs/block-group.c |  8 +++++++-=0A=
>  fs/btrfs/volumes.c     |  6 ++++++=0A=
>  include/linux/fs.h     | 20 ++++++++++++++++++++=0A=
>  3 files changed, 33 insertions(+), 1 deletion(-)=0A=
> =0A=
=0A=
For the series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
