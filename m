Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600D68BE7E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 14:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBFNmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 08:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBFNmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:42:00 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53C7EC5
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675690915; x=1707226915;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=32W0IHVnNi63d0YF4/G/mjdgXOLqNWjRwFumiobtxto=;
  b=IAoVCI8sxRTCCzMP2TAAOYdV1khpH3QTe1HWavombmcsxZ2ygpUJkj20
   wtsP1HUP80N914avWqL0ok4LejGQ/DYalhLdGaMXZfe0JLVpL5YFtPeTT
   5AoOnWI7pk4gpKPFZGDT1euTtG1Wff4QBAdJoIUqel4OTsX9CWSnxqjbl
   g7S15xk68FygAIC/q7CPCiQQdxeCql2dGvIGvbjONor7fIbzTxvTXN7xY
   Vg5FAstCInDyEqUUU0w9D0/rrcKGbx9gdBuyNd71bUF+vbWXDL4l9K8Db
   1iy5sQaNYS1yivyVj0iPRzsY8+kUJ4Sfdhp8QPvkLibede/8tjoXLvERp
   A==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="222415772"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 21:41:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5hTZkxnI6uR4TxGL2TSXBTPxd4Ura46xz3GW+hEnAcA5/4paDkP48a8BKyRJIb3uam6IPDuB8XQa4shEgAQQ6txBzJ/qtl71ouOa4nfC1j+71HNdGezY9A3Fs8Ftp+gPTXdotl3bCHIALe/fO6SeuG17PgbZ3dthCantHUavOeInW3IncyYT1l8UxNaFhSCSyz7vRmEesbeTOR+OakVPCB0Qye2i/tHEYFmDzqoYc6h1rk5mfZ2mTgDDhq7XQqmUrSp4ujl1WsXUMTyK66ZgnnCqlVq9VCvydOhZciW7xhZGy47GIf1wMxh8edMSysCaVnCrqADd0zfTDK62ewYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32W0IHVnNi63d0YF4/G/mjdgXOLqNWjRwFumiobtxto=;
 b=oCobk9+zxboKbqZiqhxJb6+reGbFLkJmYkSLCLYKBduP+RWl4uZlORO+j0aL6TBTB9rQFXSqhiS/D0ljhEQsp9gEz6mxQFHkUx2gM1/sNir5/wvLCLovD9oPKS4pEKP2r9wXgM2uVxAzphY9SkkCAcclpR7WaQAGs8VCPEMrRXwbuolOVVgQqzzX/YYWB5uaI1+1Q07dI8tr/zftm272948WM0LSTgTaF8bCxRGCNlAt36Sqjh8AxUriyXsqgLiuGdbd/MRbHormNYg464yILnVSlRpRG2pdHhcGZeRQX5JRzaCDGUJBB2QXg3uZD4TiPvH2Tax80MUIb6rt1cfNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32W0IHVnNi63d0YF4/G/mjdgXOLqNWjRwFumiobtxto=;
 b=fxnxCEjqqbHUiKsp+Q2qgXvZX08xGuwSu5JvhiNIsli5qWuSxOWi0xg2IdfFur3SKT5ZzgVWXJUcKL7QrGflE2IwZXvIR129UD3GtOSHRi4VqcMSqcwOLNXhAQW493e8Ijxzw02++HAyRzRr0BoIxmEpOjpKFIjlPDFrP9o5QyE=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by BN6PR04MB0403.namprd04.prod.outlook.com (2603:10b6:404:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:41:50 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::382d:4aea:65a9:8051]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::382d:4aea:65a9:8051%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 13:41:49 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Subject: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Topic: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Index: AQHZOjDDUZpAXLX4TUqlcfdOqdocuw==
Date:   Mon, 6 Feb 2023 13:41:49 +0000
Message-ID: <20230206134148.GD6704@gsv>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4296:EE_|BN6PR04MB0403:EE_
x-ms-office365-filtering-correlation-id: d2de0c53-507f-4d7e-3672-08db0847e5a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yg2eSUZZVlpKSq1R9wt2DxfRm0fot1SpQq2/XPJC2UHUX9JHNo6v0HWrhbGSsthskQz7LtBhuT++mb122Bxbs4FkRlmviDnvxh3BCVZlepTY1l2Ltt2wiILkqmAZjYrVg5rxMF9P8k3PVc0V/MdX0eypz5KunPYh99lF0wjNGlYppFBwSAGOwOYX9AzhsVysL6Qbz2F78DZiKrw6Oi+v9rbcjlcOBwUMcJ7C2+GQ91Jxf8aTl0MZzdpuNm9Uo5A0IlHVqS/vYxWXTL31rk10hUHR6MA79J/M9r1qLyPHInPu3iRC4l8YbGUMJLFJU708P9kMjeqmPa8/JfS0FC1ePdn0RgD1KdDkzdAtYtELWTgtV02YLes+9Dhy/ynsfEomqklSNOIU2AahjdbCulVhKc6E8ezJi9ca7flnla9jRdiLlc5kyjcjivjgmV7fYCtECtr6m+kHc0fuhksyENDG+dX75jCb/eNOm/nMrMSn+wCZzZpjh8vmkyLIxVjGOVhQ06/PSrx8270JO43Dlr4sBxkvxcQ98UB754S7jw4G3MJZYFTBO5trkZmsJcCwedXQ3aAYgUaDwr80aZ7dISCJ04ci5C73XO9DgxhSAYJ2tgZSolWofZAIT8cN4NyhGMLUa8yv1SJbiQRpBFLN3cYI2VhiNLv4X1812V9MdVzutNnAg0GKOyFwxFogdZ6DzQvtuBLvFqca5ebDQMO2Dy9dJqBzh2c46TaqNDhPYO47xMDimak/mlKhJRYA1B/i/aaLvM6Wb1cSXCdNTL2DT4LTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199018)(38070700005)(478600001)(122000001)(82960400001)(38100700002)(33656002)(966005)(1076003)(186003)(6506007)(6512007)(26005)(9686003)(33716001)(6486002)(86362001)(4326008)(76116006)(66946007)(91956017)(66556008)(83380400001)(8676002)(6916009)(66476007)(64756008)(316002)(54906003)(2906002)(7416002)(66446008)(5660300002)(8936002)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cpNZPtY9fJgs15vggte+h1kpvt2uDh2T7BgISPF2k9+oB+iLCk4GuquuxP?=
 =?iso-8859-1?Q?VUSkKhzA2tRGz1tGIU5yIETfUSMeTowP7TupUifCDf6UrqwBRzulQ5p9Ps?=
 =?iso-8859-1?Q?irVTD6hz71vVmpcmIebnNNYnywqD6BWhVPpinj6X80GDCE774tksv8qAKS?=
 =?iso-8859-1?Q?QhonRhFuUR2QGDdk+UgtIy6z0JG0cUnPvIG7spBJO/kYnsvfAi+U5LdsmL?=
 =?iso-8859-1?Q?mtrrR39jkwEocPYbHDLI6AomRrJuW2XGCgTto4eLu/jXZuJm9x8NQ2cL2l?=
 =?iso-8859-1?Q?h6eKtRbba14SOD5T7sya1A+2SKGpyAasXogbkfPL5fewZk9EGAL9TtihWr?=
 =?iso-8859-1?Q?pGsLq+iegnEFFtilPvWTfYF+uN66yxdfP4TS1bT17SUuAaDP2Nvdi4/lCx?=
 =?iso-8859-1?Q?cLnfOZFcUeSpnz8f1bTGQ2ZrkORQ8oKQJM7usm9RNaGwRK7AzC6eoC90U/?=
 =?iso-8859-1?Q?om8gBNfl4v8VRbwxdCAWvANaX1l8+JFJ6Wz6vMVkk88KzC5Cf646C56crJ?=
 =?iso-8859-1?Q?EYLQ/dAxU8k3b2z547ZzNp5glPwD1LTsrz8+j8zju9pJDlZqGS3QWh41wL?=
 =?iso-8859-1?Q?yAKBNMqhp1HoulyR52kHxWD32eqB/BUqp13ItaNoWKg/EQcNhz8YUpF7g0?=
 =?iso-8859-1?Q?bechvHqeGx4T1Se8e0ZpPSyEycpb/9mpM84KwK9QyShMzizFE9us9ZQJTW?=
 =?iso-8859-1?Q?aImvumDy33ajZC3sR+aOqpjhC+SXGsNvUot7SFGWoHb5rBLnmLgzyyYLgA?=
 =?iso-8859-1?Q?nAKR5No7NJ9pL0grv9pgvfTvmbX2iqr5RQI9IX6oPuR6DL793WX9X7bFtz?=
 =?iso-8859-1?Q?C5UQNttmDFA/JSTg4Lp1sz+G3kZQeowwXt9liYKD1zQBDx4xj37hq3M/VT?=
 =?iso-8859-1?Q?V4JzV5+nyjxKn55KCLm8WTlSDxCkjNQ58F+xfeT17JEJIysxBg6PN0rptL?=
 =?iso-8859-1?Q?buZIlUL6K0XbBviHDhZyaLiUUnN38R4qnkFM0569wF+EBg50efIdPbygmI?=
 =?iso-8859-1?Q?LeSjzjLOCNF6ZJ3ntxXtfHJNzKnuHPWXfp4qUOLw8k2PVl4fy9KJotzUC7?=
 =?iso-8859-1?Q?dGC/fUiyJAFtQaz0cbv4QxMnj04b+vQz2ysWq/Pj3/MoeNzni9z7QtCNb4?=
 =?iso-8859-1?Q?QUUAkPzW4ZVHubotJUtZNcjgOivfC6IvDTW/hKUC3cXO79WglH/zlcM7Bc?=
 =?iso-8859-1?Q?+50WMuUShMfZ1UK5MC2Hp9OCPpO5wOfdQubttn8Kh72SwM2Rs+exjqJEos?=
 =?iso-8859-1?Q?5cgFGGg/HNGhksyiARC2TrkDh5DLJorTSarFHB5Lxir1vboNpcqCVelmgF?=
 =?iso-8859-1?Q?zLRF0nrpKMW4zBHND9+l8xTyLY0YzLd2kDFI04fkeM4kEB8TZT1WTOV7u5?=
 =?iso-8859-1?Q?HUQoEmL4rH5QOZa2rZCGgVvwa/nwY/9kQtTTXKkd3EFVgsB+687OAiEu3a?=
 =?iso-8859-1?Q?XCJSspy6vnLzkwnMGX4m/dKzIE2Wh3Nk0POwA8a8lq78T4b6VdtEeJEt5G?=
 =?iso-8859-1?Q?Y7nh2W9R3dUDTeUOiQF3TADdMGlRCGRq0RoZ5vcA/oLTclk6vsx2njBuy6?=
 =?iso-8859-1?Q?6vGLknVMCEOKV+xHXwpg89lm5giKlsctOAFXwfjLYJwLUQHGmwmhESxUgk?=
 =?iso-8859-1?Q?VgpRoK+NnkvcNEb9PseHQLLqqNoG/dm/VwOh8wXU1X6SUuLBKo4H1HXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <73CE9A3975888C469397C6259A66DD5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?Txd56piL9c/NpVHYOVwr+sHGp9kF1LXEkYLujqd1TbYzomFg99903hzzjx?=
 =?iso-8859-1?Q?HErlV/fiYXwegog0iesQ75XxjESGlD2O+ndct1LVM5s9495/PqQcBbT2LC?=
 =?iso-8859-1?Q?Ltb53qOU40Vx09aQBRJ2tz+gAAFi5cc+ICA6VST4kMhSjp7cdZ82OGr0mX?=
 =?iso-8859-1?Q?ts/OpAtfM333mlXkvTqZGK2XKUc6uWW+GtFq59rM4Fv5AUI5jS2bQjh3bA?=
 =?iso-8859-1?Q?gZgUrP8CV9GZDSkLLLWcXoFx2M3v5VzW2zVx93FpxzckYve/WbX3/VCYzH?=
 =?iso-8859-1?Q?SOkthd+coGNRyX6oLkPOZ0I/Dn/rvBVvj9+w1qkhjKzdsgPOmeoO+A4pw2?=
 =?iso-8859-1?Q?aMwM47F2NHeNcEhApSOAkjOQVMnFUtBxtpI5fGK7SBAonSlvcYXo38X03W?=
 =?iso-8859-1?Q?TemgJhOQdYCbfDBdaDsFprs6iVB7M2KOfCuZHmw7vMhgJVkXyzXPLUesec?=
 =?iso-8859-1?Q?BOfb4MCSEhoQqEcgvdnW2GffHuStHQhPvbbPyfX5QQCB+QX6MMTgCnsoGl?=
 =?iso-8859-1?Q?NSo7mKO4f151QExizzD2VN86sfVJht/J9Oztup9qU34zVXnyl2G0zxnMx2?=
 =?iso-8859-1?Q?jyruMz85722YMEkW+2FK7UIIw8PduwAcW2+KYMAQz5UhVvPR+cYGeMiMtW?=
 =?iso-8859-1?Q?Bh6j+3HW8w4FkYJPlntFJPcra04UG+DqxMF0aeoLELMxelLANaybsOG1h3?=
 =?iso-8859-1?Q?AF5urP1ZhsU42kd8RIC8gt6bkf/3WH0eT88/G4EG32vxxsuGfJOQRN4tnF?=
 =?iso-8859-1?Q?1el/xEZT0hW0XKtW80Tv/ZBmmv/blDAnvAcZkCiAPdaOddM3/Q8EQEQmaK?=
 =?iso-8859-1?Q?NPQcPY6sEz9j9FsYJpREsfeelqIPjXzkbUvh1YvIMQa66dwdI4LHqo9whD?=
 =?iso-8859-1?Q?7pXZijSqf7lgFojeGRDPTz7OHQ6VL8n9idLSA5gbNY7BulQLcARGzhqKTh?=
 =?iso-8859-1?Q?ZN5W8FKiuWggqR8ia1Sp5TmkVlUZwGFFY/ltLrTcwBTBv4JDqeJkqA=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2de0c53-507f-4d7e-3672-08db0847e5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 13:41:49.1451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ks+qPNnu9HJxADqmHoYHYY1pnkKn61m2l8Z262AIJf18KRatc2OL+d/w04jbabtRY5ALREvV7s8AeewOeNGdAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0403
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Write amplification induced by garbage collection negatively impacts
both the performance and the life time for storage devices.

With zoned storage now standardized for SMR hard drives
and flash(both NVME and UFS) we have an interface that allows
us to reduce this overhead by adapting file systems to do
better data placement.

Background
----------

Zoned block devices enables the host to reduce the cost of
reclaim/garbage collection/cleaning by exposing the media erase
units as zones.

By filling up zones with data from files that will
have roughly the same life span, garbage collection I/O
can be minimized, reducing write amplification.
Less disk I/O per user write.

Reduced amounts of garbage collection I/O improves
user max read and write throughput and tail latencies, see [1].

Migrating out still-valid data to erase and reclaim unused
capacity in e.g. NAND blocks has a significant performance
cost. Unnecessarily moving data around also means that there
will be more erase cycles per user write, reducing the life
time of the media.

Current state
-------------

To enable the performance benefits of zoned block devices
a file system needs to:

1) Comply with the write restrictions associated to the
zoned device model.=20

2) Make active choices when allocating file data into zones
to minimize GC.

Out of the upstream file systems, btrfs and f2fs supports
the zoned block device model. F2fs supports active data placement
by separating cold from hot data which helps in reducing gc,
but there is room for improvement.


There is still work to be done
------------------------------

I've spent a fair amount of time benchmarking btrfs and f2fs
on top of zoned block devices along with xfs, ext4 and other
file systems using the conventional block interface
and at least for modern applicationsm, doing log-structured
flash-friendly writes, much can be improved.=20

A good example of a flash-friendly workload is RocksDB [6]
which both does append-only writes and has a good prediction model
for the life time of its files (due to its lsm-tree based data structures)

For RocksDB workloads, the cost of garbage collection can be reduced
by 3x if near-optimal data placement is done (at 80% capacity usage).
This is based on comparing ZenFS[2], a zoned storage file system plugin
for RocksDB, with f2fs, xfs, ext4 and btrfs.

I see no good reason why linux kernel file systems (at least f2fs & btrfs)
could not play as nice with these workload as ZenFS does, by just allocatin=
g
file data blocks in a better way.

In addition to ZenFS we also have flex-alloc [5].
There are probably more data placement schemes for zoned storage out there.

I think wee need to implement a scheme that is general-purpose enough
for in-kernel file systems to cover a wide range of use cases and workloads=
.

I brought this up at LPC last year[4], but we did not have much time
for discussions.

What is missing
---------------

Data needs to be allocated to zones in a way that minimizes the need for
reclaim. Best-effort placement decision making could be implemented to plac=
e
files of similar life times into the same zones.

To do this, file systems would have to utilize some sort of hint to
separate data into different life-time-buckets and map those to
different zones.

There is a user ABI for hints available - the write-life-time hint interfac=
e
that was introduced for streams [3]. F2FS is the only user of this currentl=
y.

BTRFS and other file systems with zoned support could make use of it too,
but it is limited to four, relative, life time values which I'm afraid woul=
d be too limiting when multiple users share a disk.

Maybe the life time hints could be combined with process id to separate
different workloads better, maybe we need something else. F2FS supports
cold/hot data separation based on file extension, which is another solution=
.

This is the first thing I'd like to discuss.

The second thing I'd like to discuss is testing and benchmarking, which
is probably even more important and something that should be put into
place first.

Testing/benchmarking
--------------------

I think any improvements must be measurable, preferably without having to
run live production application workloads.

Benchmarking and testing is generally hard to get right, and particularily =
hard
when it comes to testing and benchmarking reclaim/garbage collection,
so it would make sense to share the effort.

We should be able to use fio to model a bunch of application workloads
that would benefit from data placement (lsm-tree based key-value database
stores (e.g rocksdb, terarkdb), stream processing apps like Apache kafka)) =
..=20

Once we have a set of benchmarks that we collectively care about, I think w=
e
can work towards generic data placement methods with some level of
confidence that it will actually work in practice.

Creating a repository with a bunch of reclaim/gc stress tests and benchmark=
s
would be beneficial not only for kernel file systems but also for user-spac=
e
and distributed file systems such as ceph.

Thanks,
Hans

[1] https://www.usenix.org/system/files/atc21-bjorling.pdf
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://lwn.net/Articles/726477/
[4] https://lpc.events/event/16/contributions/1231/
[5] https://github.com/OpenMPDK/FlexAlloc
[6] https://github.com/facebook/rocksdb
