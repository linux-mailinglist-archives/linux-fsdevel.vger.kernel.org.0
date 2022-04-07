Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677A54F7692
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 08:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241366AbiDGGus (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiDGGup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:50:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C3220B23;
        Wed,  6 Apr 2022 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649314126; x=1680850126;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=e9Q3JkJ5i/h8OLdbrgsey1VCKD0GdVZF632pVcd5nzA=;
  b=h5U9AlDUdWoV3EMGIKxALbAtYphY5+y/8uWTaqsrgPo/+8GstDgLB8Pi
   17eAkACgIqgnr8sAVIuMsR+WrZ0uJ5ZhjmHOGXc2jmBs/GxkjPFXEbne5
   kVnykWsa3gGLB2Q7N9zvg4856cfGuSrhw3RgrB3h4V/vTFRxCPZZgEv84
   yJrGuJxiPYCXkcud+y90DmiIbGzdRviByJaA6c8vVRm9W5jMgq6nMXyme
   rPCsd/zVL9Fek8ME/DZ8PsSjH1HOS6liY1GqcwhMMpHaqdMLiniWD8c9Q
   iPP7mBEON+0vcxo+amhz92Z4EJedmE5YMgcKeDXq4npL8E1U2oe0P3JOm
   A==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643644800"; 
   d="scan'208";a="301488834"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 14:48:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRw+T/BDH5FI8CluwyA9wkK64kjk5FSYY8mHg/RrhF4rt7TU8JKpzGQ9wk4clOH3xQcMeq+01/40O7Iz727mKtEAlcqntIOx+fNVK+FaeXiHEH44LKFK4bzi/KgApOT0FqxTrbkU7dJ3gwFDPqeAjLE2Vha0QBmIS9vZQCkPAfMwso9XbYgQfIIrph/hhObxiPNFIKsEgtkJkLlBxkr0yLC9NOLUTRRG1iw9pLcqjw+0NnYa0HKJ8WMWpwvev5s75UgexQbAzXfho4IQ6aFi+739TSmqdeBxjboAQQt3zwsmbT5pRIqws5gUVfh3Q2e0r7Qb42ozEETfEe91+NIOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVC9JlNfHEuqZB1536I2g5s0y3b93FToXdPiP6pDjuY=;
 b=DB02BhWLjiYHUXEFSjdH/mLk1UXeQ02W9/xpqrW9YNSEVaCIL0LNhkwzQvxKhYcTrCdiuY5YZs8C+AFcAbFkLlpZtE+mE5PcyNH/ILIvfW72l2eBP1sxvRJYgF5FgpTJwlgJwA/ZvJ2g7a7x3QwAYB4tf/GKXf7g3YVuNFx4/IcaZz2ZrgOJHGyvYhnmcZBtnY937ZCkfJXrjmF3Cdh0/zJm26uP86mAIB78fnQg7uydLk361eIo9Si/GsFjdotH7co+vvZaMISqjVvm6zjzojJZyTyN02mKKXauJ0eO2VsDi3s/cdOiWN+5ItJey5gXDrw5DZz1Gv0+7+ogc676Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVC9JlNfHEuqZB1536I2g5s0y3b93FToXdPiP6pDjuY=;
 b=EUDr+yu14pBq3R56Aa9yDF6dRaGRzLfj2ECl/BQ4b6LQrUL4oJ5INQysRL2s+rVMKSKaiKFU7Il9dHGf4wlKa2RW3Nkh5J8JZlEYTl1QOFwm4QCImkT0KmEXt/mJcmlkzcZfXIq8wpJf6gVqd9/UA/DKOpSFlyCS06qNI2+Oiis=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0911.namprd04.prod.outlook.com (2603:10b6:301:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 06:48:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 06:48:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: cleanup btrfs bio handling, part 1
Thread-Topic: cleanup btrfs bio handling, part 1
Thread-Index: AQHYR97dFp1G2XJJkEqHG44+rLKJNw==
Date:   Thu, 7 Apr 2022 06:48:42 +0000
Message-ID: <PH0PR04MB7416AEB0B8ED6AA096472DAF9BE69@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220404044528.71167-1-hch@lst.de>
 <20220405145626.GY15609@twin.jikos.cz> <20220405150956.GA16714@lst.de>
 <20220406180023.GC15609@twin.jikos.cz> <20220407055343.GA13812@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e494ec4-04bb-4005-ccde-08da1862a7bd
x-ms-traffictypediagnostic: MWHPR04MB0911:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0911E061C78806C9B81798B69BE69@MWHPR04MB0911.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyAeQHOMwjaHTbpJJe/W1blEVy9HDCah6R+RECjEgefeRzt4NId6RpIsuoqe8s0LM7mRCIXom3G0WO4PKsO3sDoD1zNQ5ahVo6A3ATxjwUFMgKXFlVflob2L2sJ37yIiU6ydeWe4gJ5vKdIWez9CdbZl4y/G1OFUE4o+Y7T/o+/eVLvYbdpCyZnFgQb6c3p1pPl0dnLeW6mSfLS/xR1zMZqhsgHfUFQu3z47+7esJ2nFcDiJIpMdZMw4YVkRvXYHNHFz6dJhQ0lZcjz7tFTvwT21Fqj14v/HoF8IDqKndh5FkFV+jjMwu0xScBQohncDSpw0V0mGhgs9rWBiz6VWorJHVR7yA4Tz0thcS2UhXdBh5lwuFCha0vE3Od0QxDulds8/zFPBM9tqbUGxSJ9OKJ66p782NbQqyjbG74FthKam9CNhNp/k/KVUU7bj27RW4BV1LpDTdZlqKaGGV2Hr3GCUHYjfXww5jiPRa12CxjyZARCfWW7NGsgHCGog/V3SOA7ns1Aysq0efIDMMfwTuL0wGFB4TB8saGlat+wNM5a9l7zDIMoJM5M1J76pzqtEb2jHie6v4pN58zURZYJbhaM13nCf5bzKUgDWK41CKWG6qwHqoqV6gGSqrJO2OKpgvhPk353WDt7daFzSYkGiRwTaXNcZGat6mMYatxrhhhG8LCnaPSdA7ILOTXltHFwd3d9hTU8dI0vAsTqgM+IZZiH2FHVajZK1RxJn3SXy0GYCLYw0mulTABbMZ7hSnRX4HSAky9eLgDjLIjHtfr79xAc5WiGbCUa8e/F/VDwmi98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(4744005)(38100700002)(33656002)(186003)(966005)(508600001)(55016003)(5660300002)(26005)(8936002)(71200400001)(91956017)(64756008)(66476007)(66946007)(66556008)(86362001)(52536014)(82960400001)(66446008)(110136005)(53546011)(9686003)(8676002)(6506007)(7696005)(76116006)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ecFXUZMj8hWuCvTAC99aUA+xyXG+FeCsn2C19jTSBynbvIUxK+4rmjFVovGB?=
 =?us-ascii?Q?482VR4mFHac0fS2DWTk+EFuSUWecbGUft+d75fD2KFv4qL0cy6Cx0S+v/vrx?=
 =?us-ascii?Q?IHexvsPePW81yEboPiB5UtHOhF/CHMkH0QRnusE9+vdRoTgb+1UlTIXqV12C?=
 =?us-ascii?Q?MPm4hCtsB8cbFTEPr1gFQijXswdqSW0CX/b8KNnMBkVCDNs8fkrfpDQW6cT3?=
 =?us-ascii?Q?eBrix+ha0sXe/sDql0VaFpZfKc4PdG9yzcK+doBNRGChx2lZGfoGgZO19k7a?=
 =?us-ascii?Q?M5Z3A7lUwQmPJtyKxUcQnaQJvCN6hdEnSMKpwgS+BMMlFuCryJ9rbvaNwXMg?=
 =?us-ascii?Q?Qd2xk+8UuUuEcDPAF8dilUbnuM2Z1hixirvl5k7iCr4W2JKXkzTSJbd4lKDd?=
 =?us-ascii?Q?3nmrXR+IYBFy8YqHNFbrxAEOSEXpK/wrmgQ42gJ8NqBZkR20aOINcbgI/471?=
 =?us-ascii?Q?glLx/ahXWrBANUv3egJ2P81HQfpwRgEKhoRTxNqsueuewT8td+z1ikOEMpF7?=
 =?us-ascii?Q?IlyCxcnStonugQmy7UAnOj2gVL54xsrWWYJYvlzNkcgWzNdtyIQLtnlSrvyQ?=
 =?us-ascii?Q?2Wn+HwXt78RVo1zFq1Xp/aWJfZoPAUooLt+oRB6gxYHEBvc/q26QVNSK0CVr?=
 =?us-ascii?Q?L+1eqzEftP7KWm7lmlxkKD8kszRtrsK7TGOIZnFmFwdeKrH+25bLZfsVipg7?=
 =?us-ascii?Q?gpmqYtLW/IBZX5Hi733dA43q58KmcOM00pgcwl+rG0xcCZtr9dR1MK14BE3k?=
 =?us-ascii?Q?vN7Tw/jkXx3n1XcCqamzBIhpH4/IArwcgrMVsYgXgfroVjP9zmEeKTqeZ7I6?=
 =?us-ascii?Q?wNgo+W/MjmgOOKUa+DWjSZRrzWnb1EbAYWtyAX2Jr38JsXtZUPhHVX3N6moI?=
 =?us-ascii?Q?M8IpcSXGa1duC09aLSMkQ/YNIcRaRW+Wg0D4NzlPMBALONCBponJ4PuhayC3?=
 =?us-ascii?Q?nu+uRj3Dp0K5+cYnnnmxAkcz88Mng8Z0Lh+YobGZKpcC69ivLKkiEpL6y+5G?=
 =?us-ascii?Q?MNc3ruRVrzsk9llG+2B5TmQGn85r69eQYP+D/37mmWGrIeneKZeJszrfCZPG?=
 =?us-ascii?Q?pNNB6AI2yvUKOYz+q0oye3uRwLA1ViAcdzVAnzJjNkvVWWRWZcz/dNYuAfyk?=
 =?us-ascii?Q?CjYJnM4eiIAfFPKIiCu619PbQ1DArihlrLSGwhn0nhnzq/+npWaSwWyS3z0K?=
 =?us-ascii?Q?5a/6yFh3lMBN1uDAyDa8uBKXiLV86tbnQrTLuaUy714aMLLq8EFny4QDMeq7?=
 =?us-ascii?Q?dpdFXrVl1twNRnEdCTT2YHWf/5IvE/CwXhoEAudgLuMnLdtlOu9eGrpmMEqf?=
 =?us-ascii?Q?+V2VEzueNsQK+5XqwqgtmlRRTWium7DNweAAsbD9JdOoa89y6QPe09/KpZ7A?=
 =?us-ascii?Q?MGIbNGoQRLQSmdD3qUMF04RJhycNKljNea3Ju8bFPx0xhHfsNrwGNOl9gkNd?=
 =?us-ascii?Q?mYVO0IqV830KS9r+ucdHHpCMDYjLqYtV23aco1T3tItRfje8/rWTDFU1ll60?=
 =?us-ascii?Q?VK8hqBRE46YhQuM3GwK0gu89A5JtIVL2LRpGagl1/YTP0THt89Qu2KrXJmzZ?=
 =?us-ascii?Q?A9odf5FIuiG5tGrqmVQt18Whjok+xp0x2HnHjqGh6JrUC52JCmkCHeHrpYoW?=
 =?us-ascii?Q?3e+YSaUM6DPOqy2MdZ4/RLwuF36yv7kFHx6Dly4p3/QpXA17NYuNbDI8hMIj?=
 =?us-ascii?Q?qMsR6PBZDkUeYPIgL9sYSmxJyjV/tEl/aPsyZ3Kz1/+g/hctwVyPvnG+J13N?=
 =?us-ascii?Q?+wMH7SgzmgHVYnq1XddYDmwuLt3Req/p+KNIK4GllP7Z0pzVlWg/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e494ec4-04bb-4005-ccde-08da1862a7bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 06:48:42.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrScls06Id5mI/CmvW0bcJ9IZqKbBLKnZJg2Qyj2IuHRUyBToIFR3UXL2HGAlYUSEroPJaraeltAwCtRlc94XX/uOpoz5hoXLzXeb8hTCmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0911
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/2022 07:54, Christoph Hellwig wrote:=0A=
> On Wed, Apr 06, 2022 at 08:00:24PM +0200, David Sterba wrote:=0A=
>> I was able to resolve all the merge conflicts either manually or using=
=0A=
>> the tool wiggle, no need to rebase.=0A=
> =0A=
> No problem.  What branch should I use as baseline?  for-next seems to=0A=
> be merged from not otherwise visible branches so I'm not sure that is=0A=
> a good baseline.=0A=
> =0A=
=0A=
Most (if not all) btrfs development happens based on misc-next which is=0A=
at https://github.com/kdave/btrfs-devel.git misc-next=0A=
