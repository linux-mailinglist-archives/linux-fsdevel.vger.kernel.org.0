Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E738152A49D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 16:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiEQOUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbiEQOUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 10:20:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE44BBA1;
        Tue, 17 May 2022 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652797200; x=1684333200;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Lqh2rLFfJWb0/AnvbgICnGACUhxOuLi45Oz1BCPwGE0=;
  b=TrOjRXI2jFfzau/uUWN1R2JCwqd5mT4sNnBbsolsMJvcE3cnib1YIwS2
   70xj9RBtKcwZ6NKSXgCtNaB6qSvXkh1rrr1xCvnznycYcxy06qFf3l7Ml
   6CtIOHT8l22ByiqJmM2vQaCZF7UBGJfL4EDTs2wwQ0AJmDm3P+mpCkjVu
   Oe9Y8qQ/n6UPYMfKuFffSwRjTkgDCzk6T50GpjmujKgOtIEb4aZPbq3xK
   vV4VfDdnGWrxQohpRrmK1PzUhbi1KvQudlg8qb//GNMAf5WU2ypcF4j0o
   zyKeBZbdu6YQsOYyhkTDdNoHkSpD3NbNU/aM9yuVEdOHVnYPBi7d+0rf/
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="205432452"
Received: from mail-bn1nam07lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 22:19:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSYGm2eaXA+aFde/GhnprNibYMUqCrInYmvtQVB2//AiiB7v62iNP7wjK8DTbmLEgQtC4d1uJwzgCsiyEM8FK6Jk+Dv9hxoV/3XjeTw+cHzY9Dl4hHWunJ8NOCBdrI6xDaiPtaUS2SsNsfwJeQrJoNEYHlaJgPVoec1ji9UxA4LMotm6iGtsruAwMzsR2hz8emuXaYrFUqNz2rpIU2zm+pCtQ3DC2fjjsIIuWcs3JNsRiJbHu8m36kf6M70j6LdTyFOZknU5/LoTHFZEW5V20/77yO7FiXURB9dejWNuQOgi1fbo6O6WSq0+l5ES7+m9jYB3+jokJ+V3SrVLRnD9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lqh2rLFfJWb0/AnvbgICnGACUhxOuLi45Oz1BCPwGE0=;
 b=HBcUY5WvMcl/wVZZsvZZPJNrR+PX8nUgfOE9AMyUSOtyO3FqMrRkl9rlyJh45SAin9V7PJsCavZbyVAtRPNbPnnPBOPI7zVXqGqY5AS8FwOC3EzIk/a/5Vt/ah/iXk3OBwOZ8Sv96yqpjz781HKsS9cD/Y8o3DjAQIz647og2BOqNrP80pRypws4FyyoFljr8m7XQINbvQ52LhdJc0tXifWhDDfw7tcnJLyue4P5XKJnZqo+0M6DP30dGwLa4HAApNxvu8rrUomDko6V27G6+gtbB0NopQWSaN/80eKW3heWgaLYMlSJrhdhCPdOLNTByqTW38u4QQlVkH/fBd7pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqh2rLFfJWb0/AnvbgICnGACUhxOuLi45Oz1BCPwGE0=;
 b=eQUifDkFnOenfG8VnDqO1vdjU/c2fnMB5vph0sWPSVPUQCNfOa3uU/JJJDVUgpKCOModK9tp6sD2DWo1kLs92e+yDNvXGpsPzkQeQi+ZQoa75NCB2yFL0BbMiiPui6dNNzbp5YAemb9rTd6vxH9m6BUDUrVMG3rCYK/wRkCSG9Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5462.namprd04.prod.outlook.com (2603:10b6:a03:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 14:19:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 14:19:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Thread-Topic: [PATCH v4 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Thread-Index: AQHYaUWk3AoK5tKSj0OEio55edQW9Q==
Date:   Tue, 17 May 2022 14:19:56 +0000
Message-ID: <PH0PR04MB7416FD8C80A78B635891B6339BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38@eucas1p2.samsung.com>
 <20220516165416.171196-5-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a3ba53c-3c55-45ef-079c-08da381051a4
x-ms-traffictypediagnostic: BYAPR04MB5462:EE_
x-microsoft-antispam-prvs: <BYAPR04MB5462EACD51011B87849243EA9BCE9@BYAPR04MB5462.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cuxVqwHnUBFip96+TLTaA8hbOMEeX3XAL3BXPhPaD/hxKWL3FXNQ2/ODE+/TugOIh7PlLAu8OWfhWoUT4dWy1oGFCtVCOOmPmDECKQEcQRI2gvAyF9qUlzjx59dadfk0VP6ERO2nT0nqvXnyqTn2ZhzAv8gaoiSpUBdSE8N96+s+a0TJkKzxJ5phCCwZqzqlqryQspB5e22zT1HHE48/FmmPOZyOxex/i3XyeFdaLt7IiDXSDUM0aziNhq8ofbPDQ9f2QmWyI1cYX9Dla5p3jQDel/qFn5ZEcNVP/3hnslUjjA0/oYTsp5FOYvKmd3qv9w5bEt/gM0jdn2V5SNztY6FJ7lS2D80ntLOJwxIddQcynYLL5ZHyj4pzMl9casi1pce32kPEhRUIc7MRFj5R86VCw8m8AjlYSttNFMiMf2zw1pxLNb58h/us8fyZ/F7qiUc/0J9tkSHCVTEUyocErLF+k/fygBvEX3otK1q8BGTTWMVYKk5LHc7wOWvSDugG79wYwyamR02+FOvj2Iv/SK+Qg9E31A7J+lDDwQow0bvc0IqTtNNDfXEko03CJh7UWT5xPBsOdVO86A/vn6CVge9Vl/z4LO56/MNkAHTbnVchxQDSy4HHSFqbKXfSLFFSgNx9n4+e7PhGcxFDCdsu6egvyNFf4F1ttb8BweOEa2StDWWDdl8io4gaNTtlLpot/r5ohr/5toETDJ+m+Buu3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(316002)(54906003)(55016003)(6506007)(4326008)(8676002)(8936002)(66446008)(9686003)(64756008)(66476007)(33656002)(86362001)(558084003)(508600001)(186003)(71200400001)(91956017)(52536014)(122000001)(38070700005)(5660300002)(7416002)(38100700002)(82960400001)(2906002)(66556008)(76116006)(66946007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wXyWym6rXdZ1Kj9RG+pOQuEqLgnJWYijKXDgUTDhFBCvHFCze9hnGd7GtIl4?=
 =?us-ascii?Q?FvPs6f/4RNPhlS5Qcphw7OnA29uQihbTAh4RN6ZLj4pb7qyt4g1V1A7z6Tzu?=
 =?us-ascii?Q?4IzFCEX7ngA5MXlceOZTdSmOl/jpnZhLXyeCUKh9ISgScb6LlP+O7s+fMs+Y?=
 =?us-ascii?Q?p4PmYDCotxo9BEMR2OlnTflPe0M+UQEpyiI72lW93+8Spn+Q7yoFYNEns7+W?=
 =?us-ascii?Q?4kKLiBZppSkEnK69E18dfaSAFPjvWnGk1UM1i4IdhKxIno6tOPd5fndcxWZR?=
 =?us-ascii?Q?PxVaBHqBsQyxHbJs5rb4/4JVoQK+MQIPnlkLDK6oNeTWfZM5haWZOuqnR5nx?=
 =?us-ascii?Q?cofEcCQi0APFAZdUiWCFfJPpanJfvkBSvvs5KxkgQb5JqBk7euGySoEfesOw?=
 =?us-ascii?Q?xGDFhkIZWco9PT9BYxlV/5OUlM1DIorLG9yEWHiviOtONznpxj5wkOYW/c/R?=
 =?us-ascii?Q?xEO/6LtexnKMmPsugd1k5IuXuaDIrM4b3IySlUIAJz69O69LFqIx4R0UdAfg?=
 =?us-ascii?Q?a24+FAF6ghRY11e/jwRnWTB3eyuvbw5H97VrI6h4bTQiipY8ZYaqiIGkNWg7?=
 =?us-ascii?Q?J8KqlbGyplw5QBNL7mwu9A+B7+nYXH4jDgpSs3PeWhzad6GDsBC/i/mrhAGG?=
 =?us-ascii?Q?jtW8RSCR22eGYfAbk+RZWeaggG+nOOjfAWMHtChHL40DvmdMfkn7WIDtL/PN?=
 =?us-ascii?Q?fYVEwlZwNnE6fsQYgGHJOF2Z8L06bDfDOV+gwyucCtpvvkU3auQkWmPqb7Uf?=
 =?us-ascii?Q?yWTOQbbROVLvfIa7KY5c+NHmKSSSDy5zr5YpbHEnSyTGMKukUeAaLYKSqoz8?=
 =?us-ascii?Q?3tuV93JPUd43o8MbAuZ7rlzsu+mco27Zwm9O1xQ/Dz5D3XxsgmLREML8jHAy?=
 =?us-ascii?Q?FRlu+Xyp/mcvf4/mjmCLnADVOwtdKUwZ+RLJg7XZVFWnIPT3PgjY4/cUn1cm?=
 =?us-ascii?Q?hiW8hgSMR6VKTyC8tBxp9ooXIawdSAXLQDiapVsLqOG16+6YuBYfMdC//6R8?=
 =?us-ascii?Q?zxk5+xBe2a0zBt+DN001SE+Wx7ftkpVstKZ+rAui9DiCmams5Z+ekiZQtZ3V?=
 =?us-ascii?Q?MzEoj1aL9cTM2On5f2QZUShp+DX6oAo5xdTiYggVHnuErn8Zg97IUjozu0ZB?=
 =?us-ascii?Q?PWHwzk0wN2mw8OUay6A5lYJK8T8VrrrERsy7Foy1z0+4eXnY8nCZ/7K1Q3GR?=
 =?us-ascii?Q?nsj6cZvEbGEGw62fqGNNGGbAXtfCUaWw2cD0H8L6YSHH8CZP0Lj4iQVunLsW?=
 =?us-ascii?Q?+znzJkZCpm3VRrYZAo2glNJi7i4tKAETG4X1AAVGXKp2HTrKgFQ3+hlmMcf0?=
 =?us-ascii?Q?bMFq+XLFvdZtGeDsOce7EY230p8ooh3KbyyMJbyqGBJVlrVQq0Dv3plj4wW0?=
 =?us-ascii?Q?HflhZ7TWrpasxKX0y40OWf0lZNEN55e/3Lyka2uE+1bllvWwKFMXkNUDZ35j?=
 =?us-ascii?Q?dp1fz6OcjATn/AtmhZHs1IFRXORBuiVd6inbkzxFGhLHOkXaOynR0tGaAyPj?=
 =?us-ascii?Q?sFskbvbtE7olUedyB7mEhZB5rvFQGMJPV811sYLHYQOnJmXghiyt+EcUKev2?=
 =?us-ascii?Q?vIqVCo4Omqrq8XpOVf2BxQD8/CS3xrEigjoP/5BkHMHPESKhGxX6Hf60RMT9?=
 =?us-ascii?Q?n7B7mzhAtr4q3qPQatQDqNb/69H+ZQIMyoLi2o5FGcdqjEHv3Gsbf2nfe9T7?=
 =?us-ascii?Q?If5TqlmRp6FqAIaEMnu9a1OxFMTCSEudCyr05s4ET/Uqe5fJJWHGCUtHFVAL?=
 =?us-ascii?Q?r3zIz6BBw1aqVT6WxCXvLgktMGuXW4CbJZFGr9bLCnvWQUtqH8U+r49UjRZ4?=
x-ms-exchange-antispam-messagedata-1: E+DYvtfpoHJfwfCfyeGM53tZyNW3K9Au3oiYzjj/NyJ5ZqD95cEoPJ90
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ba53c-3c55-45ef-079c-08da381051a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 14:19:56.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It57Z7bP9Qz2ngmJ9rvHDvhOGfNGMOdaZRq8ISab8AciVLVMo/W2nI3BEcSBarV7I6p+PuLHYBZT9Qk2+B3K/UwX9yyzeInPBTi77xP54pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5462
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think this is useful even without the rest of the npo2 patches.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
