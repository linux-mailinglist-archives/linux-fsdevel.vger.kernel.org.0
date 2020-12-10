Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D08D2D545C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 08:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLJHNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 02:13:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16629 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLJHNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607584384; x=1639120384;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qO3NZNEu8dLeBPzXBBZc586AeuIsJThITi45Aj18LkM=;
  b=E6GnnLXY8t/eSMq96Ltq/TqCh9PNouOQN7MOGmLxG1DRTT98dtoQip8U
   LMcAkG9ccfA3j0Nh1Ka2f+Wyg3+WcT5p1Rzb9d4Ud0SAq5M2jHVzanXOv
   8tANSqf6AeBQhlJE3II7XoIRRCIAYXF9mQf4ShJ8EM2PljlWYdryROPlo
   0vUXCgZT/dyMKeepKXvFdIs2ryFrjNSRmsOiV78hRwyFDOdKqbmrUiK5V
   ZzESCPRJapfDeWQOlQ5pNNLKG8fIWTGYbuiIj0VM3sK6q6fIhJoMtxwK7
   AHRvdWjntUp0Z2JV7qWJTVvqXlrI3RvYgymNpumKA/V/w32sV4r+z0Qfo
   A==;
IronPort-SDR: f8Kj43USeSNoqB+FIvbxhGfvVnlBzMUWy6d4AGxcEByavkLNZVIWa+cKNeYkprhhRpjHZ8qOQJ
 naTyBPnhRqdnA4dTyrjayDaVo9vH9dcHOHPyWsu0lgCC/SR9+x6srS7sGGznTHfOePkhyVgqkp
 KzizGw2CJbOlUCxWn5OpVL5sWpBQpYONi6bRwuSxTtoox2RM5C1f+mB0x0Gc5GLJMZATJiZTKj
 tPsNNRvDTO/MntoP3hAaHrMlCE4FLN2gxDY780MZI6Jfsrv/6COjAXrLzq20ZejI6aFUTzwp9y
 yMU=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="159293565"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 15:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF6tuKgoAD+wVWh6LSESE0Sw9zm2TfzcglfxW8ogMz2J/6aLSCotfHU1YmDycYs5r91Z211kYvY9UeInGdyd4ga+2DCTy0/vRDlLhTw9OBzJMOTvTy+XvwZ/HVi8wNevsWRext6UNdRCviJbbJW/nLuDwwg3ecc0gbfSHSSFqOl6O8/JcFhpguFYpUmaXfjitX61e4QmBWhTHao8pWAvRJVvGBRM3OOoZBY3w6WyA7R+5OyxLCGXBvpHYXgQ1G6o39nCsFDtUU5dKhEynR5D5LJMRKrsVjlZ1tzKFTxv9uxoYzH2bzqmPXxmQn+PktoActgXzYBztQ9uWBDiQrJfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO3NZNEu8dLeBPzXBBZc586AeuIsJThITi45Aj18LkM=;
 b=McjwGpMIGykYyLlremsAZgInz41CjT209Na4HjbOQVVjIguTR6JtyHexvQFesDBTrKZR6d9nKlFf5tVyHquMBqQ8ammyXY9eeZNU0rlTROyb6GKL/Tez/SnrUAve8qa+f+2HeAgidh9/9BUY/gLIztQkchFUzH9JuqPe8n+gF8hRI3xJdZ3onKLS+tA0Boyw60XH+SnX1nij9VlKopghX+zfw4Gfa0gyrgmhZPaPYpSTD7qt4CqR2NqTV2cXCDL7Zl5SfaQ77qNl34VGZdtWQB34nyxMTnFugMTw4/PUc8VG0KyMPzpMSyMkW7le0auj5mL0t7t+wm/HYH2S4gOtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qO3NZNEu8dLeBPzXBBZc586AeuIsJThITi45Aj18LkM=;
 b=gN0lS1BFj8iKmSfWwbro+u/2UCCqJtabgOoCQhCpL8D59O/En/TcgpXntoF27wPwHq2Ys3fcSjV/IPeRRWlGdRYACTP9Sf+XRWrkst9WRhP/2sVmOGfF+3MsTUN2ThHpIIVKACuPRW4k1RHBQYs09oxJJoK/1oezdrITXo4oKys=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7306.namprd04.prod.outlook.com
 (2603:10b6:806:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Thu, 10 Dec
 2020 07:11:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Thu, 10 Dec 2020
 07:11:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Topic: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Index: AQHWzpUrpokN11k08kaowcuFJTiUbQ==
Date:   Thu, 10 Dec 2020 07:11:57 +0000
Message-ID: <SN4PR0401MB35981EA698BE4E89B81786279BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201210013828.417576-1-damien.lemoal@wdc.com>
 <SN4PR0401MB3598F92D83760E2A2D8749E59BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201210070647.GA12511@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1587e977-df6c-4798-a443-08d89cdae1c2
x-ms-traffictypediagnostic: SA0PR04MB7306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB73061CFC936708DDB8F158549BCB0@SA0PR04MB7306.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bnechf7FsUPWEHoVUQ4Iz+FduBMs5LQ6n7cpe02hYzKXxzr8fQL6zcU3yeOrl6I9Ur+Fq7T2W+TC0gXG0HmnbQuZdhrOC8lqYvh6XZ0Ewke9/RAPA0s7AQdXj5te53QaFbePIBxMFxqcgd0p+8Fi04gJw9ObghYtKMYr+2SuyAcnzkVa0nGYebWFSpR82GE9ikr/+E5jBvjpoU0nuH2+DbizTmrBy/R6w5HrMPUQ9MwxWFUdl1ss0UFIMJct8aGAu5Tr4nOt4Zw9O2gPKGQbj1Ue4rQHKbg0rxu5lDK0+I79gJoWEJSL4S5jS7d9YeK8fuy6RT2Y7A/zFUaVLjTbpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(8936002)(186003)(8676002)(83380400001)(2906002)(66946007)(66476007)(66556008)(4326008)(64756008)(54906003)(52536014)(86362001)(6506007)(66446008)(5660300002)(76116006)(71200400001)(4744005)(9686003)(7696005)(33656002)(26005)(53546011)(91956017)(55016002)(6916009)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ywd5Ue5dZypNOhO3AtZCHJPhCqKw4fK4T8haguyqax0LAjJKLO1sFUkAGq9E?=
 =?us-ascii?Q?quAtauP6z1wjpuxGxxXUtGN1h68bUxjiqmEQ/Goy5Ollgx0gKguiZPvxMFbJ?=
 =?us-ascii?Q?5MKh6tApmRSxabwCUyo53og8veLYirH45AM/1m3KRH+wquVYu/Jh9lj1w/kU?=
 =?us-ascii?Q?lrdmc/WT29aIwSynP9Ngn/CeLo20YjwEuGDZBi8j8h7ZbypY9wx9oEIexFQ+?=
 =?us-ascii?Q?cKcDWNZGpMMesTd1zjZeVmnMMyn7DoP+ucVvkB79BYqsvP1toSvtX8N8KMqR?=
 =?us-ascii?Q?EC5M8u+lljHfd+UWyB+Pxiel+7sDlMll/ChdDYJJMn/EqtVsr/Zk3ofgdMYY?=
 =?us-ascii?Q?GYiDfMAJ44VmiF6xMRYshBedpFKImyKjMZSZpAaL7D447koX+oel+Rwk5Fgd?=
 =?us-ascii?Q?apN0YJ5pBsvAwv45++MF1J5C6kNFX4O6x3aAErmWVzcexlNmu/KFzdOTVjqm?=
 =?us-ascii?Q?LZdBqubRLIS4ACUs1sEKO1toIoGhcf7FZvOkbaJiPhg7Ft92aRvuIk95Cp8r?=
 =?us-ascii?Q?vTz2BiAv4U77OAoyA9uGh6CjCZutrnPh/8plfENX6XOiXxKN8P9rlYaSOaPm?=
 =?us-ascii?Q?maChuEnJ0cwlulmk93cKzAgQKM4njnpl4pqn74z5Fd9fVCLYcR+g5nCAhyPs?=
 =?us-ascii?Q?Q1wP5a9LXg2/34btb+eGQbY4Ksl3+3Ya7dP09FxhS0AG2UIEbZ8NxKB83ZLY?=
 =?us-ascii?Q?BIdTmdHXKYK3icB8ersZVisniMM3zPP+fKcaMb3U197DqjxpVlYLFqEvzCRC?=
 =?us-ascii?Q?nOR4ySq0hh2WD/EzNC0Udw1WULj+Iasp3XLjm2DoDg/EIg2PhFhg3dSGDu2i?=
 =?us-ascii?Q?Up9MZi1wkvi0drcFa6llqtQMLLKFZkSbMOqSF/sf8J9myZ7Rap43HiCggRkJ?=
 =?us-ascii?Q?TetFKZb3cVKJBUkJxG/VPYkWa8Nt+DeNQtGs69dWmwP0wa2VY8BPIm9DyQpA?=
 =?us-ascii?Q?Brc0hwLBQOXtk34kqMNhIUZFsQx9d8vB3e/cVg2cNGzehxx4SnhxoW6Zb1dD?=
 =?us-ascii?Q?9hH2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1587e977-df6c-4798-a443-08d89cdae1c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 07:11:57.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbVOGULCY/hHsUdO+H6DQS0cPm64JdHrzLID3wF6cTob+oZiFJfwTTy3pzn0hsuF1oogUetl6tT/w/d3mq03/EAICp1IglHOQcss4UKeRVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7306
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2020 08:06, Christoph Hellwig wrote:=0A=
> On Thu, Dec 10, 2020 at 07:03:08AM +0000, Johannes Thumshirn wrote:=0A=
>> Aren't we loosing bio->bi_status =3D BLK_STS_IOERR in case bio_iov_iter_=
get_pages() fails now?=0A=
> =0A=
> We do, but it does not matter because nothing actually looks at=0A=
> ->bi_status in this failure path.=0A=
> =0A=
=0A=
Right we never pass the bio to the block layer in the error case.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
