Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EE12F4852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 11:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhAMKGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 05:06:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61194 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbhAMKGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610532407; x=1642068407;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oc9yzEYAUgvkYu4kW2SIrxBsenneEa6gbZn1OX1Mg38=;
  b=QfISwSkVCt+i/jBbE6j+3TJeZ+EdbfKZYvvdOR3UwiINK/A0LsOEY1uC
   4B51FeU2CjBBCnGrVK8aGQLssMKCeQ0sZpt+C0MSiwj03HZMU70eYpBYE
   eBYyAGTpFC8m2JIB4QVGBJ//0e5hQVGOoZE5gRIJo5exvEg32v39yDHz8
   l/VrM6xW0oWwKVkkWCPKsXGlbMd9HocAKdtZiOxs6K2OHOqzzPXajpvrM
   rTHwl1xa3MJe7TCQNDFkpSk/u5n4uqUc/pjFDg2m1BF1uXliiLVDpAQWH
   TV9r9h6W8RXxbjmlNVh4h4Za0lY6K3zVhON7k9TJFWLUZNM3qa2lweXzA
   A==;
IronPort-SDR: cmD0E8eH2vQdXwxQJD2TIp1YIkLWCUce/L2+JgogHq3hMVKne0mKwLrX7iy2Azb+nQTENULvv3
 usAXVn9EitPQRnvTn4GJHd2GONaqA6kSIOz1wVWqHbgFsGiZnWcqIGdZTb+/ewgwd6ZNA/7IcZ
 a1zMocRNuF8/Xy8T9xH45jT3xha3Z164nsPkWS0e23g7LErIHtEgl1y0SVwhEnWPce6lhHnC+K
 BMxXur/+7Ytiy+dkdldq9pYquEQBO7gFdfYiN8ftxs8imJjG+O5bWVUG3eoAJGsL0vq/KUMxMs
 gyI=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="158500019"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 18:05:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTu6IjdT2RZUjLRGw6OCdJBkLOvz+dCXBiHR2jDQbE9PWa5o48PeyJONU3G+RGJ5vbGG1hctCWeRNTa7ktwI+g+W99m7wCqECQ5ZZdxgON1n7Ee69aZ8ZxZsihoeC0DQKn044EjW1h6HsyDQtd+C+CnbvGKV0glfw7NlGB886z92iO4LyvBrGOzd0UmrhlXmGdjLlRM6B1/7OPL7RVarUDdkqwk3wrAoUK2zSKjAGWhsjft/sPWL9Phi4T/lYVrm3mQqgjDyE0MglwxAuR3AaSkxvG73BVMXcH6Dmj6F5k7ycm3NQdLW93Jgochqd+kfVvDNal0SOmU6FhZFjz4wLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF0igfD4ACdNmfp0SAUw0ssvJpjRz9DXczAIV+1lGYk=;
 b=KvauBA+ocC1+vD+E1M5iID0MPN3q8MWQcuAX/xWLNcf+kABCSeBTSTsTKzCWELtZe1cwYbjasRqXfPPLwvCfnoniGhFBJKUFfSHw+oguC/454D4oqcIV3UuHfINfh14+L3HaHOhxRca+rRnIIq997LBL+78EXDTBSnDctLunekhnmS2gvsn9Hi5JgdMpucFF/HOfnpF0VXxiHxBysCxDuulIPMj47ufes9d1qGXWEMSutbbb7UHTeVjzMHYBt0jjB0j+WkQw4aKpt4zoFDnS31J8mp6lBQDOPz6UeW5qJqYB2KcRcRoGOJjLQLs3Ulj7pE5tCbkReD/xUdYMq5iLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF0igfD4ACdNmfp0SAUw0ssvJpjRz9DXczAIV+1lGYk=;
 b=d2/ruwqzmcNUuJ3ejIK2NbVcQ8Tuxo0dfT8b/cHnOldzyoW/8nOOmD/hVOYxkRZ2sKVL7U4TOvYkq5NHzDhK3KlFPe26IZZ+n85lNHiAlNVRHCHlHxlx5azeZoPL+KYHxRoXeMk2Lo64vZHbcXD0B6+uftUOX+/OPQTEkmJk4yQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4237.namprd04.prod.outlook.com
 (2603:10b6:805:30::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 10:05:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 10:05:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 22/40] btrfs: split ordered extent when bio is sent
Thread-Topic: [PATCH v11 22/40] btrfs: split ordered extent when bio is sent
Thread-Index: AQHW2BaIQ0e0KrofQEKCcNmRcPU+WA==
Date:   Wed, 13 Jan 2021 10:05:37 +0000
Message-ID: <SN4PR0401MB3598F4CED64E6339E25CB1509BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <e2332c7ecb8e4b1a98a769db75ceac899ab1c3c0.1608608848.git.naohiro.aota@wdc.com>
 <1b259084-ec86-d9c3-740b-9463f3d044af@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:38c1:d5fb:3079:ba93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9431da32-696b-46af-8e89-08d8b7aac6ba
x-ms-traffictypediagnostic: SN6PR04MB4237:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4237BF3F8328E38198A6379F9BA90@SN6PR04MB4237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:188;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 387QFip6yb909CCPEF4psH8TDExmQVYYIbjNYd0D4PVB0ZRaW01IFmxI6HYHPz2Liw2p2mNZZa0RKOJjZBDkA84/JOCCr5NQ8NNn/uHcBY76/wkKdgiv5jKMZfJbvwpyaOC9bmHNoR/6Aw7Y2AdKR/IoTqO0DWxil8qi+osMKUEQqblwDetIgw5/UNimKSkwG9+FLWTyRjwKbhw4rjAURAgCH+zOHhgxGJVqWdDUC/M17b9yxU0WdxRy1fC5g2xeIusBjIMmPkFayDuGtM1S5du6fhWQHNoUPv3PQ4rfpMFkxmalSRhDAZBYCREaNjsogRsGSN/S/D5KiRJsrt5tzulppmaR/shzx+PfJ9niyenxl5NvGBSDgcmwKMKkvCKoEa6Qn7zeZ8iL64mbAkW0Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(91956017)(76116006)(53546011)(8936002)(6506007)(558084003)(316002)(2906002)(52536014)(8676002)(186003)(66476007)(66946007)(33656002)(71200400001)(64756008)(66556008)(66446008)(86362001)(7696005)(9686003)(55016002)(478600001)(5660300002)(54906003)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dT/ICdFOpnLzRkSiHLLTAQUjvGq8xnPDKWDJV63Mm4wLlpfet7tlkW84h8g5?=
 =?us-ascii?Q?uaTN5rpQ+1C3QczJWnI7H7SosMUM+n7Gx5SW9w4Q2BIWSTVb9LL1qKtq4hTT?=
 =?us-ascii?Q?2rC5lAh2VgFvenA8Ww9Rk047UF8/pWKQ9m28DlQngjLCNZb36P6nUt3aWbgt?=
 =?us-ascii?Q?ytbQjbMVyPVs0sizgtoQvXuDr96AYL7l8kkwqZeS/DG7LeZI1mTGKaxk60rL?=
 =?us-ascii?Q?WJfnA/o47SjH6cPWALAxkrWMRBsMghSCJ9ByFwtntZHuwC/s12soKjY/N0Nd?=
 =?us-ascii?Q?Ye22L1+z0hzCvp2a8wECWc5IWyXDMwHKQOeoGdHJW0YgmESCRvBCitEnhQor?=
 =?us-ascii?Q?JcZuuxlUU0liOGD0d25y+SHj4PBOaxZSfLZKYqlDgB/Ly41S6eK7PNSWGeWk?=
 =?us-ascii?Q?BATNYY0yozybXVp2U0SKwTE8NCqL89xB12p8FB6NfxZFeJ19h7vNG4uh6bD5?=
 =?us-ascii?Q?ZjStszKB49QCf+3c+4bOU1L0g5HbpGZruKj+u0uhMzls7ck12E+BI+oDSnsK?=
 =?us-ascii?Q?FMX7YyNTl+UqRMExKWLEPy3oHOFqy8l8QmkMMVopwpYLNUU0KwS3RICGL+8M?=
 =?us-ascii?Q?bg0vaepjPJrq2tfOLYpSYiZO6TOh6gdldHSf2Zhx8c/BV6U8NBlhw7VURkGa?=
 =?us-ascii?Q?cHRoE/choVw/PnU+3mQYcGpeLLjtpkdUECCBhVfFltrBaCBkjIvq9irAz3H4?=
 =?us-ascii?Q?1BzugkoqsUNVcerI2r2+1egIHi6c0dEQCZhkGJbX2GOx+cz5oi9hYR8pzlCV?=
 =?us-ascii?Q?JsrfAFczZCAdt7OLYvXQiWOoIj7oxGfWvvw3z1ZRfPhfICUMlep25GcDoU0K?=
 =?us-ascii?Q?DIWk/esgSBWGqOaGxU4VHk/4Uh4e4qwZCjDh91dDO1Rmhb9l67a3qfbcpQmO?=
 =?us-ascii?Q?jkm6R+BiOeDN68vsUCMs6TpkhuryY9SqVqOV0Cn47nnIU6Xyr3xohnh2AKXm?=
 =?us-ascii?Q?tjcYW8mtExnaj1/KKplTii/0P3KIMdek8k7binK9hsmmyZMBO84ZxylLdxai?=
 =?us-ascii?Q?RlIzXANm3J09bVTcH/C941thXSR2bp04D7NwKNyja0PPzSSCVrzYPOsW5o9E?=
 =?us-ascii?Q?O4JRdRs+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431da32-696b-46af-8e89-08d8b7aac6ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 10:05:37.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTHbCPKvVvTS85twy2yKDM5UYSZ19CIslvMnHJ2ouLVHQHIAZj/6kMj71NvPGl/ZL+6gyxNy8D4Zzj7pb8oLR0ol1YUshvpdOSaFEbMRQmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4237
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/01/2021 17:00, Josef Bacik wrote:=0A=
> You're completely ignoring errors here which isn't ok.  =0A=
=0A=
=0A=
Fixed.=0A=
