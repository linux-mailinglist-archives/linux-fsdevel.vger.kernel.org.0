Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD22539EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbiFAIEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiFAIEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:04:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FCF45AD5;
        Wed,  1 Jun 2022 01:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654070643; x=1685606643;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=FygCWg+mZK9L0qZRRlmowHu4YEm7z0lPHOb1d0GIcbiEfZT0mZ3JB0sA
   OwkDaQGhMId9XypyxsfQV5lG9aH8GcqxWOkWK8JHOIEPWf4DcTk/M6KI1
   bxUtFbnoo0/3o9rDYK3WpDr+eXGznrjGKL1/ZKh5xydK79OkuvwNrFOzM
   rEuRJ9Whj90VfPQclViRH51anYM5/x+2DfEABSnjc2Flhmh7UGPkZlIzR
   OJVj/Ros+AOjCF1wETXwn3qEpbULWm9mOfToGpJZl0Jgvj9ZWIjosJDlj
   oZwBhmbTX5JAxeCWfoZlU632pBV+w7iB+MZYViCYZk2ZH1JTGe+6D9pM7
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="200723970"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 16:03:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQdvqScBPe26KjXV61peWrdVGUQrGIHLfBbJniLBWl3AvRV9NeJojqtNmaCeplGn8rsZ2R+3BC6iIPvV3F2KN9IpHMJnyyeLJbh3Zd5jzSbWMZrzx9FELpA0rZgru+YEwFFhRcxjV7x8E3QHXVBL8beiRo2osepxsy+Z586N/89ftT64BPOCpq+4RUuscaMEM2Q+huxD3hQoPW4Phfk8qnZ8XppBCwoWtt+ZRTSLanxWODtTW+nT5rdCxXe8TUsbLHDWkenTGU9Xa0RKfqe0CYN+pTWhvoYFfrIbQDtGrVyqBZ5GEqktbsisxLRgTpIFvlcog2YzkxdkCoBupRM4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nHRHutXKbSuzSmO5fBM6leUg4RaFM+iZGtgmTkPRaHz+zEEJiPNMFLapKdmNGFm49p2DBIMVEi/NCEXsxBAnJ86/pDLPamtq647LNpdQ1KtNQjAo22zdjz8tfQgQI4yJn7Vy5ianQkpEjP6I/KG7da/R+IZiyom80pzV8Idc12sTqKAVUO7HD2EJh2Qlioq4DNJ8wCNvgiretWPoQpy6Y7JjtMEoDmSLUmvtqJYYXOVbgOUMvkb3Q4ceD9eeA0RauiQcFogwkjLY4VtMxd1G5qMpRd2keDs7BIX0MRrZvcfgJMJvYkhVG+DjJ2/mcdaywu24ECSOeqDbfTU/lRDGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HCtmsFrQAUdDpWzJJ680w0oX9qdqS7NSvj6vCfXJPB99jbdhN0shrrbfniESSs+HJVdtm9V3IOX8r/WGgxlQecCUsAhM/6266viBoUsFvdUazXnDK+C/U4/joNQ9Ck+qlNcMqV2zvwgj5VLddbH/AUjY0wbKHHgkN/Qe5m5GSH8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB5155.namprd04.prod.outlook.com (2603:10b6:208:5d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 08:03:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 08:03:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Kernel Team <Kernel-team@fb.com>, "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 01/11] block: fix infinite loop for invalid zone append
Thread-Topic: [PATCHv5 01/11] block: fix infinite loop for invalid zone append
Thread-Index: AQHYdSKW4YuJzoh/ekejnJlfe0EUlQ==
Date:   Wed, 1 Jun 2022 08:03:55 +0000
Message-ID: <PH0PR04MB74168DFDA421C149C251C0B29BDF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-2-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0928123-4bea-4016-8614-08da43a54687
x-ms-traffictypediagnostic: BL0PR04MB5155:EE_
x-microsoft-antispam-prvs: <BL0PR04MB5155F0FE3AB31AE006E10A2E9BDF9@BL0PR04MB5155.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NOjVEZ5Rf2eY7e1akqVMB1LVt/sfrYBHQqhJZtMOua/vxEJhwJCqYHvYOb11EJkVFPhOcPhXMZResi6ICxL6W6BfHSiaS9qkjZrcduFtiHn5rfafhiRaHido97tU5PBV9TqH0lVNrSjcKBURhA4IE818YcVUDFV/tMAaWdg4UZvMM37khNe7sTZlaGIxx3pe36/9+NWqMPNrdySkpqaaXZVH9Q7NsfBA7r3WSr+C6cqLs/oLzdXtmWTJVg8VaKEuFieUb9cVI/jusNs5om/88VBe+Vp2PivrVOhoGQdiOI3lcf+2NLiFQdna00XE8qxlwDGFFPA9bOza/JYZ7DK+yDbRpCdWr/qDy7WdHIrzyIhfAysuPfYy6Ru2zzz5neDYxHKOHmI07hzmzA/iLGXOaWwTJTT40u46ZYbgYyMxmJnWyVOSq+vlNc9qotjs+upxEDuBo4W4kIsB9MXjMJOQZpoDc5Qr9nKQ6kHvWeotpfTlwMdRKNHrDPk7YNjw1wxnerHWklIHMDThfSYJEF6szlHgv+G4+Va8w8H/ba2PIbEmeSLuuppaKeO//aou5HNY7mD2fsM9eHam18iDjwlfv+sJwgN4L6wyU177rcDAM2dNVM5DH1xW+F8/ykj4dp75YDivqpUsL1acNe6EdzrExRl0yhH/b/GcsDR18M4fmwlW+F+spjRcUrMQft08O2sD4TICbJtulTQaT5WCSxEOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(186003)(508600001)(7416002)(66476007)(8676002)(64756008)(66446008)(5660300002)(66556008)(4326008)(76116006)(91956017)(71200400001)(33656002)(86362001)(66946007)(8936002)(558084003)(52536014)(9686003)(4270600006)(122000001)(38100700002)(38070700005)(82960400001)(6506007)(19618925003)(7696005)(54906003)(2906002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kX5Z0XdVK0gef/e4WKPDEfIN3sDP7IXeHBLkYbrL50dKprL7/qL7qyugOSo0?=
 =?us-ascii?Q?dxYXE6yWfH/K8HjAYc4E1qwdhEvXZ2kRCUFJcXWzHjndw506TlhTVC8nQl9W?=
 =?us-ascii?Q?BS17sC7CESFtUWXdujZf+oDLWb/tVFIbaqGNDZtgkOZJE8pxKZdENbLUurEH?=
 =?us-ascii?Q?I6b76fIqJZStl/NCr/xIBdI4dgeMlc/GmNUxbifsIeXlAcnUSIfF+HVOgCFW?=
 =?us-ascii?Q?J+dbNyRexSjBUSswhx5HW4RtGl+7HDWU1SLlG+omERlR0Lg0KNbKVvsFf1u6?=
 =?us-ascii?Q?MgehRKqcGynzVIWry62U1lfiqx51c906Nue/7Sd7bq5q14t01POY+LIGFwak?=
 =?us-ascii?Q?S8qHlOPVp/wC4isEA3Gkn9i6HsE1oFpRgN0NEJWiO2ZHt+vsN8GuU1frAQ5q?=
 =?us-ascii?Q?FQH29L8S/y95o8o2zPfdThpp5zlaZBMq27aaCYeq53SDTevo3HBgbmLLRUEx?=
 =?us-ascii?Q?GHmFNrZ0WSxWp+9dPGKa2igY2e6I1P9GXit8S5o9ooN3Drs9hSsZDygGfdR1?=
 =?us-ascii?Q?Y+B3b59c5JoJe1EPFz+KyAGiz8I2OcfzJXqH/ulsWHFvLTHtY82vjgTNXcUw?=
 =?us-ascii?Q?PVqAgP3/BSbTajJ5RfqD8SEIq1a4bKjDB9zje7xAyouR9mHdWZ8OsPG34Hq0?=
 =?us-ascii?Q?y2NgWJloZ/WcW+FWFdrzYHQdWVN83WKyBsTyzqOgOwJF2EUoxG49jVRgp8jf?=
 =?us-ascii?Q?SHGMqqjuhSS3q3fxZkvm5e9PUlAFoCpfIg6H73jeWVHSP0iWudqgo2nPfhHP?=
 =?us-ascii?Q?aLT4fU+3cTvu9D0yEr675QZM0CCNtpZGlAc1VI4GWYwEZ6PSgM/ubpJc6pw4?=
 =?us-ascii?Q?fu7S6x5cxDE7j3WXqa34U+V5LSr3Zz15K6MVgG4iWhf8iXOHpoEMadIN8IRh?=
 =?us-ascii?Q?GLubHNlwhZiyxGNxLvjHDCVo+DmbvViUaMOS9TtgkJo6psJWAs57+xsOecRK?=
 =?us-ascii?Q?tHODLiOm3kqZG7n6kzb83PAP0jL8zfUwzsQ81h6X/9JaqQyVeKWIZcP/i6yN?=
 =?us-ascii?Q?Z4FPz8xUqFmbhsReABLXAar56cWN+G24pvt4ug8eiihZePC076rmq77pn5bC?=
 =?us-ascii?Q?uV0aJ1KY1mrBRJ7AvRf7NKeMfYo/tDNi2LEqFOCMxtPGH6SqYYMy08e7antD?=
 =?us-ascii?Q?0GXeXMtK1C3tJnbynyeHKZSpUexe6b5dKC0+zHc/DLOLsLhnLzcr3NSd8ajh?=
 =?us-ascii?Q?WLeLwEvI+pYuhh/t43dJg+WG8hBs4/PH+IeDHnwuLWtgBOUTW9x218qouo1T?=
 =?us-ascii?Q?GFSEMcbfPrcpJz3hCIAQz0et5+NAMz6vte67gaPuaAEfthT4Tfcy4tEc0ByY?=
 =?us-ascii?Q?dq9ATA0iWNq8YnH3u7pfgxAfqhg9YZy29Trju5CvzvIVCfYKoqWg82+rG58D?=
 =?us-ascii?Q?aZIHZCVzIkx39Cm7U43RJ4lzOhfAWXaBked1L7bdcTUve0Oq7spjJ2238xGW?=
 =?us-ascii?Q?VLLNhoi08TL5sIbXcmOB43gfx1BPLIsAWz1gS45zOoN6ZhCnbtKum7WUCjjC?=
 =?us-ascii?Q?oZMWRrPjKB7rJMOceaDnYju5xmDTQhbU7MjS50hF6efjrmlPr7ynORJiL1yS?=
 =?us-ascii?Q?i7e5LukzAzk6Qtq6yGOpXb2Su1H/Cp8fmQXozlXO+e8R1A+O088M20XzKmLv?=
 =?us-ascii?Q?eaob0Vju4WJDmnJkiveG9J2fTZ18egumz8Hkj3+UfEANe+MQ6UAC3/AB3Gwc?=
 =?us-ascii?Q?KoAvPSAyXF48wuHOto85PJhXj3DDTs0AoYhjwSFgslAWUv+mDZ2w1FsrRmzd?=
 =?us-ascii?Q?VlQnxF/qfJLJH+N7kY+ze78rhgMn/YJoyEJyUA7wd6BPswa4QZi94iHdAHc3?=
x-ms-exchange-antispam-messagedata-1: uiCJ6ptRzjo5MZrCjuC6wv3lG+X66PKPWfr6BmKcHfwQiQ6mIvJ2WxSR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0928123-4bea-4016-8614-08da43a54687
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:03:55.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJs6CzDco1jXAmAIvFFce9eAG0tN7aVlLegOATh7ySoJRcIXHmTTSVpZJKnwvNw1OqKOH25bdGItTuXv5NbVqfztKBCeaTeHIXPzTy5zSYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5155
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
