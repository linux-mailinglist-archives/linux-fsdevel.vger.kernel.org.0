Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB27B60F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 08:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjJCGts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 02:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:49:47 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCD2AC;
        Mon,  2 Oct 2023 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696315784; x=1727851784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XLxhyf4o9mXpRtp2Z1bHx1pjCkb8G2qVnybYeF1hRMk=;
  b=di5cmy+98yhr0dmjAVjHDaTYWiWXc/0EDCymULP057+YQJJeOnKPldEa
   pjGWnuZ3ZsnL81e40QljamaZufeaErIDNBZjYBStEKoVGEUJhCtBwfjsE
   ivF09lnsI0mg3GMAfSHBEJIQ3lhiF0n5niTVLULHPFvdr7dDRRoi7mZ2R
   sN/RWqUeg0+XcOcCO3ZsEdFQHV4osaHUFNFhC4GkjaEkAs9ztK27Rq0dn
   gISUj/9ahCkMqDfwPWS3p9rZKo5K8uW92pHk5DXqjXkUUMCKMjVUvFNLI
   qFmdxxspGcr3CclGm4Iwt6E+SL1796EYSSn3L5ojE1wB2wYPv20DtIvNj
   A==;
X-CSE-ConnectionGUID: xaEILSv6RbOwVUYezrWv1g==
X-CSE-MsgGUID: yVCaqs2XQquXlLTw9Ohq3g==
X-IronPort-AV: E=Sophos;i="6.03,196,1694707200"; 
   d="scan'208";a="243710317"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 14:49:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaZHMwMcPzGC8yoonNAwFV0SrW5QzPk6tC0eIupcYxjhJLnxBp24FkFVEGxYeC0BcC1x5/BSnXWQh7f9LO2Usgp7zBrDkdlX2jPAblRIhcEkUWf2FUZhInIWVx0hrAXXKQ6oGC0S3kq2hvorwsR+Hj2woxxrf6Dk14lbqK1Tcw/4xVm2EHIDxJZo0ho4PsqFIBkQhyxTV27mTCMeB/IcjJUzdFU9k9LYjqrRV708lKsyUZUjFGZhypfDNvx4QaS4d/p7UaSiBwimogKlr32847uBKd7O2g9cvKgKqDHi/CHrgqO5Q2bxRoF6+/Bmia1PvkjrPVai71mgO7elOVAN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLxhyf4o9mXpRtp2Z1bHx1pjCkb8G2qVnybYeF1hRMk=;
 b=k88RUPh4GAYzoie80xTu6vnTvi3D7Isqtso7BF66AkLJB7LuD2PGLO4Cuxmt+YHXDQOP6Z1/khUmpaTsN1KxD8k9hl1R6zUbXxS1oZwvBhMNDcVcxnMNcTjL/gUX1LDNU46BQBQXKKeNRaJiXZJX66O3kCzQMEYBHqzQQk3cwHNM/hqt0Y4aR73BKX6ajoXkNXPSXKIImWSX32Ai62eWACFshSLkl72T5LroujVz6f+ZKlRycHv/NH6qhPbRrQvmjP3JDmuLf3uVeOSkkHeYV4K+sJiS8oqLxqtUZmoxduFQjXvhP+sagz5KusOqWMxpu4sij/WpTnPlhmW/wVgsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLxhyf4o9mXpRtp2Z1bHx1pjCkb8G2qVnybYeF1hRMk=;
 b=dYLa1HNg1rdpXD1biJzwUArSsS6nvD+eE0Jn61ebStAyNcrI8xqvNf/XQwdKaJNO+I0O958W2iYr5wlKSERhxxXXVboQK9JrsMOgwTXNXqtNMN7y0tPezkbn8A2qngcF+r8UVwsszad/m1w7dMoVeODUhKiAYxtocAN0/ZPQeq8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH0PR04MB8164.namprd04.prod.outlook.com (2603:10b6:610:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.18; Tue, 3 Oct 2023 06:49:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 06:49:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: RE: [PATCH 08/13] scsi_debug: Reduce code duplication
Thread-Topic: [PATCH 08/13] scsi_debug: Reduce code duplication
Thread-Index: AQHZ6/b2Ie6kGk0A+0KIqk+vjmj8bbA3s3mQ
Date:   Tue, 3 Oct 2023 06:49:41 +0000
Message-ID: <DM6PR04MB6575869D6FB26D342AB46BF7FCC4A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-9-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-9-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH0PR04MB8164:EE_
x-ms-office365-filtering-correlation-id: 94b0fc19-1e86-48c0-d77f-08dbc3dcebb0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vt/F2AMMZ7PlgvD4YzStbgk7cDs/aw6Ieeqvbxei1rVsrZ9qO+lumGJrNQF/Yq9xfvBKut/GYUwrzdNB4gT/Csh4L/L0nlPYWfrpjPbUYo12iR345zdwJHzqkGES77tWudFDvH5W8khmzqT1DE/NrDpHkuJiLeLFVFw7tnKPMj8H6qyGSjwZUPUf7CcLfy1SBhBifYQrrvfU/3WL87erMiZm72qgqIMHIpxbNJcOJgbZ6vstP7IL52HRdE+1VJJjCm7pgZZi7O+WxfpEeyfrEg7VuyXTzi1FGmI/pBSbqjm87tW0NXQpap89cEng9K9hggM3XzwLe6p0orCFRi+7KsAWFv3y8r2+KE8cSDkeeTmEArezEfm446K18itTtLlTeihuCy5VtycfisrenYkQk1x4jV3eooZKRlJFIumg8G4GFxeJdth6KZ+0mndox+BaFUIISTXQ91M1WPktR7qx3EwMAGJwI+5v6qJF5oqjdp3hC4uVb4ciwybtMlusdmWZ+aoRxmxolDSjg7ZO7iq/hUH5jqwahgmJmuOiFWnFgT+lKakeRnILZwm6s4yGphm5ImBFi9Wbg8+FuMGZRvvr7H3dukO+sFuUx4lPlwseL4M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(478600001)(82960400001)(9686003)(122000001)(76116006)(54906003)(66446008)(66476007)(66556008)(41300700001)(66946007)(64756008)(316002)(110136005)(38100700002)(26005)(38070700005)(71200400001)(7696005)(6506007)(5660300002)(86362001)(55016003)(8676002)(4326008)(52536014)(8936002)(558084003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZo0H8oWS7Md0Q90YMiIqXCEHs61oFDMIcoxeVLK3aRhZ9ZEFrllX2ewNJuZ?=
 =?us-ascii?Q?c32MvAhdHNmq/k/cYUQtE+Bs/9NrjKDucj3z+GnyiGbOrNdHBu4cUGHzfsMX?=
 =?us-ascii?Q?qXZpw6b8PzCyVFHP5VLfqwUSv58Wh5JJXK3tKWHtlvb6DK7MMvbwa006q+qe?=
 =?us-ascii?Q?bTd7Qyz4K1t5yXiAp7GwQjoh/eGilq1V8bmQqQB75CxhCFDSHYL1YcAl1JYn?=
 =?us-ascii?Q?MgfGhYmTofd3XSFsOm/jByGXy3uVXsk91PPqVIJXY80QxlMANYiPnYDICyus?=
 =?us-ascii?Q?OVcbIjZ0LwLH7PJG7DJ5lXKeWo30h05WSV9fKpwWkOi/9yK8L056/bKSvh/q?=
 =?us-ascii?Q?eLOK7SOee/ug9398ZO3pdBmQD44C8e4CflhicmJ7+DWRFrrWqvE4+yGL26MP?=
 =?us-ascii?Q?NmK76P+1HXG7RnVjflQziPXsTIoRls63K2qXU+H9gCXm9NTqS0Cy8bezUwiU?=
 =?us-ascii?Q?j4vBcSQ+CXLI1xtRamrzTzBa0lFPQSwWSVz2E/jjDWKZZCvhcTfFXzxxUUQ3?=
 =?us-ascii?Q?gnr8Vd+p13X5Mtsce0BLDwsP0h4Zdy0wDyvM7HWTI5lT1IHBKYWwxV8OCsvF?=
 =?us-ascii?Q?XjfqqFrBbiGCfp9TucGyYJ8UOfc0bbldwk+IX5Db7Xr8sPDdib3RJ+toEC2O?=
 =?us-ascii?Q?coaB98NLa3Ig9fUVHM0/Hmn6yZ6fTNtt5xns8LYKZO7u8wvIUzqsIgnsTRWq?=
 =?us-ascii?Q?29DZfVDN4Ei3EnKXwNGPrNfi90TbKWHgCKkgN6QH5vzTUgZBA5TByptPaek4?=
 =?us-ascii?Q?wWrhJraQ+uu7VH2F9Hgz4vUmqvkPS99seuXTXoQ66ha9tYEgxk2gzcdp8Sf/?=
 =?us-ascii?Q?p1p1VDbpJSMXRMkpwnk5uqxi3moxzEwxe3DtPd5W8gUIzkirpHlilQNTMLmT?=
 =?us-ascii?Q?RLa2RuYXybfiWQ5vayaCkJQpVLVtfvWe7uft3zJYe9hBX2lEPsApypEfKXid?=
 =?us-ascii?Q?goGiHKn2kE462TfzvW6YYnVQq8I5nJbtgB/yjx82HD+8r+YPhA86cz9/PejL?=
 =?us-ascii?Q?x/1MrUUhhhUxS1giJEYw4HbXjvsQeis5Y2vsaohOrb9mmGWNRF5sApg5hSnr?=
 =?us-ascii?Q?gkvKWh52UmEly7pa92DkKF5QJgoRYnMD3YlUiSc/HqFKdVAj0w5fT+mOdMLv?=
 =?us-ascii?Q?eDDFdOYBHCmGE+HtydNAdAtrJ76/iqGaBDogH+G4lssX+6TdDQsDAsxoFU0m?=
 =?us-ascii?Q?L8MJi6P1qi4yx+S6H0RPipQau2kXbhuV0x90WOyHm+RWElO9NkG5PeKDLLxM?=
 =?us-ascii?Q?Jl4U2hSr3tfeEyS8DFIa9U3NAtYPqEoyC1ykG5RIFGYi4LCHr/ZtkmDOudjV?=
 =?us-ascii?Q?9UpLikOjB8xYJa+6mxXZmB1FP6Yd4mDRuvbDsF6eZ9wFQDumwSt9ISNVXH54?=
 =?us-ascii?Q?PLDgpSi4llfkrIgkiwehA67dRKviFkRkDT4r0gCa6jiTPcbRt+vyFFcurXAd?=
 =?us-ascii?Q?I6zgW1NVJqEkDRXz/QAdoF2xcL+MocNiclBGQaccn71TOTT2PccKr8qsso1i?=
 =?us-ascii?Q?btjvKpNSMmNXHctGcWxXXoAdwNHl33GzF7BIy0DjG0gKG9lD6bpg94Dya4fP?=
 =?us-ascii?Q?8WRgPKGI9ieC0VUJWg2XoHW9NSWGtmrwzJ432XZp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZLxz72NPPO7VoUx73oRJkSpbfGeEGwWudK0756meBOr2xg1hbqGTCx6XHggM?=
 =?us-ascii?Q?CSzdp4LWyOI/Rzkdjqg7wWuOithMwcEjhbqoRB3R7IPxTtw5Dx4w06pvkd8u?=
 =?us-ascii?Q?FKqBd0BAzwQOqqMML015pX9EyQq4DykD57H9dxtkyyoCQSLNo0S2jRwD5kI+?=
 =?us-ascii?Q?JV38VqoxFvehDdOqsQZEcP5OfBgvr7A67eVI0X7iz30wm/qseu0aoDc1+kZC?=
 =?us-ascii?Q?CTyuSZ6USxomUUai9Kd6SP4xpLrtHOyxgo6oamhSr2vtslpudReI+iueTc1N?=
 =?us-ascii?Q?yOguVYfoQ5t6sVqYyfA0+RxxsxRBUcF0GJCquBv5Zd8tPPAED5wWmhoftIlJ?=
 =?us-ascii?Q?Y0Twn8JJ8XowEiicLYcX/cbjOhtS/4oOlHZsYX0nBGCiRBOt4cNbMi91yD88?=
 =?us-ascii?Q?DY++J/sH7tsqOPQ0B4XSxS6W1UTWHRG2pe8qeVXyBUX7Wug28YxG6HUU9H0Z?=
 =?us-ascii?Q?tcHsEgXZ09clMTJfDWtL3M6NuLC57F6n5oAQux081raER+oh7XXqCTe9naYF?=
 =?us-ascii?Q?gkZyClaPgxUjLEsmMBiy3kcCvoR3yw+e13uowDh8jjwixErAh9Bw1ZBFRepT?=
 =?us-ascii?Q?Z+ZoB06QBVkcZPWhzlkWKUVvXvuBT1lEE4CSkrPtudFvzFSM+ZSUxaHc/JCz?=
 =?us-ascii?Q?OwB6+ml7Yv+w/6lKCrtvgDn1GkdSlQy4QCnT9bnSTK7rOiRAhKqDetO6Cfd6?=
 =?us-ascii?Q?BBZ230LVSaao/5XERlU8FnO+BwKfUs9/tiLiHD+Ndx1QFndd4fwy/k0MKLuf?=
 =?us-ascii?Q?laDvGvulTOrP7QQzatMf4iHnr5FaUMhezPuSX1mCjbrQmPzhjEBz7YSEJvCu?=
 =?us-ascii?Q?LvwtI3IT48TveIvelANGLABt6HucUykvhiwhMe88DyuV/9KoxuT56VkKKdX7?=
 =?us-ascii?Q?GoVpP5tbMkB8rEhNrLCSEOQSnCdjBNvsPtxjGQnbwzob7ofW9KDXTAkFcR3A?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b0fc19-1e86-48c0-d77f-08dbc3dcebb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 06:49:41.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbWF5JRPhpy91oqWDgBDuorZwCJlharPT+WDlS7GKwYnCcqwvVJxORcI/4rR1hKRkAMgSX5njr510FVDL6Zh5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8164
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> All VPD pages have the page code in byte one. Reduce code duplication by
> storing the VPD page code once.
>=20
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
