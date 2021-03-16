Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6023533CF53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhCPIJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 04:09:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16724 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhCPIJb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615882171; x=1647418171;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=c4xqb2N/uX/zQ5yKkcwqo2erSsf8uJSjc0c8Q1MAodaSupY4WnyTkqIl
   9G/CzIZ6WkdCemJ+ChT35P8Gubvt0Y0yQbuiiCPaLsghPhbcjQTrUgxTF
   5/ib92K0mXtAmFdLcCPirBUPI4PJv5Jur4w+zTz9TBe92Xp9iQ7OJcT72
   Oe/VXxBBDERvFrU77KAw7i2dkLm+rTe01avSvrmeIybemMrkyVtOUTN2t
   z21Z9SBsr7Hnt/N6w0CrtJrIqyQs1yImuR0uy9oM6WOnSsJFfN4u7oAXB
   okQg6Nrt+K0ecZYTqGoWC4SWeSeBqIWLnP+KttR1/hGVffvaIKrzl+YsM
   w==;
IronPort-SDR: vzdXhUaBGNOYShSN1+m0XZT38R8N4VEPv0awyy+dj1/X6zqK5s2JR8QXrbuLb75my7avk92rkQ
 Aefd7Qe2wvmZO7v+wYXQ2fIIED8z05VynBieKkv9Om+rUwgdZHKNBU8a4tETO+1eJeO6idjUjo
 uihEl8EvpJkkxRgxDWM6CToR95nd/mRItISgiv4opvr7Pl8LlT2QldA1RpppLWEharo85psV10
 TLF1mdyiz8smQr18/8H+e1pjt5d7ecVrpOW1Rz/sWtHzAdKTNjf6Bv1nYnlr0RGrmk4wZNHaUr
 GpE=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="162221273"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 16:09:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO80CLKyhd9bTwMZpkywftZSEDrOFvoEmIPYOAW7OF/HGvImtx3fRyz6rJPqfQwj+jqQQF0whDVimtOV1McsolYbVl5D2t1wZNNqBPhG5xLsM7FIEvr8dbUnAk1SE4EQq8SbI2qMNepcyCsplmJGgiV8QUNJBWW8wTi9syhsvDVKULR5YfzVR2R+VkoSLNcioVoRPbhbLqyZtULztPC3iRe81Tl6XPNeS/mp/cSQE9h+KahbvMDNN1GLFwrakLbzHYq/gnpKZnlsmhzN7m6NvA94wEShNgLFCEerT7Ci2VNeLuDuIEtphXozl2OuJ/PxXDHJG5FrynVsBUpqwumIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Jp3utcRQDCsf5k0BmChgi02O9PPCHmLx7gAWaQzbTpUDzXUje6vY1bPTWN3j5BcC7lZqtSXtoMsniJ4EKpq/WFCbSMWPZgTQY+prPStfQSVrv111gKctd8niTmAnjWQTMeiAibn7dQ6APP10YJI59h+ecDyIWNj2N8ukKUheofVcna2xFeZ12RJpjypXlqZhGEyVYmNRh1KdhqEHA5lDgEKE9dAYJIhMabInSyvTmZ8Z5WDVMgWkEO7Dlc0m4UEQImVNuOslybZDw07JGWcjrY6b4LhWybhXtBZ+xy4csK0z3smbvjCATYoRmVRusCx7hmsgaUh5GPZVj41FsWIITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i5dqZrnGc2W5F4IqZTVyxr1x399o3o2I8RF5dCcAn0XweXkHFNcjTluQoPo/1i5/b2dpq+PrAKGgKR3cMEHA/+n+sDk8zjzw9nY4NEDoGtJOp36WTgERWIz7/MbsGInsq/+7+MUAKyYIZEikFrBiKOx3JOqKy8Am7EMV/boh7Qc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7400.namprd04.prod.outlook.com (2603:10b6:510:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 08:09:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:09:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] zonefs: Fix O_APPEND async write handling
Thread-Topic: [PATCH v2 2/2] zonefs: Fix O_APPEND async write handling
Thread-Index: AQHXGgD6Iktd6fced0ua4CsC7Ww3UA==
Date:   Tue, 16 Mar 2021 08:09:28 +0000
Message-ID: <PH0PR04MB7416E8965D7B150F187E42069B6B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210316010859.122006-1-damien.lemoal@wdc.com>
 <20210316010859.122006-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:a4e0:11d7:79a0:82fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5d1083f-ad88-48d1-27d7-08d8e852d28d
x-ms-traffictypediagnostic: PH0PR04MB7400:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74002D6532A87C7E1B57E3C69B6B9@PH0PR04MB7400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H/mAEEI67uzp+NbyA95rQFdwHSxbPiJzF5Nlgh6O30hsdwVqWwIWk97yV6YbtSEPnxlarndFnk5EduL6lAEfcSj/frrOkjXZlsSjd8Z8gLHqjArIMhzheIpLRMHqUWAX8HJclq3mr+hCSwbwqzmXJUPmJ50VHRxtbuak5lzAHFuKP44fwMUTwGEcQuGN9QckCWx+WZvDDyYNIyyg3zi317PXUtyOgUAFLzCA9AKs0poRx4a3WsrO7TALdEtZ07HgyBMkAI5P3WQtbik9bsmrS+jncmB6RCsYkdNXdr9Za3UgzaBoxZ/FJNap0jqfBSQxe43Gftz3ZDSqMBUKgdDYPKKR/aAwlBjPkWO+w7/7baPOlvyDjnQnuQgwu7H2YzC3fAAjHX82j1boSWghgzsRdmBIj4e5uewgHybt0B0H0adu4E8qtlxlCqo5hnfKSyremKNUoyYxGf9UGaSFTuDKsrl29vHl8f38HF4mEa+fOkw4WWk2OT04+5b0IrVYOc+ADqATsaBkH8++txG5lSnfjY51avQ6ejP7IiXsqyN80JRAZbgKNnvFz5D96IwVeBIy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(33656002)(55016002)(8936002)(19618925003)(9686003)(558084003)(71200400001)(6506007)(2906002)(66556008)(66946007)(64756008)(8676002)(66446008)(7696005)(52536014)(5660300002)(91956017)(110136005)(76116006)(186003)(86362001)(316002)(478600001)(66476007)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GctQXN/36lygEgkiG99Flew3TK1lekyJ4dV3s5dSM037I6+yeIPckvgZoR5o?=
 =?us-ascii?Q?pe0QokAi+0jEI7pgnvZ+hwXcTgyffyoI9v49SkocwswCLDk/xm+Gk0TvZxZL?=
 =?us-ascii?Q?1tZmOsXyKa4vOwhLAW7CoSHMBWzuQ/g1LHxUPX0BB8SYPvD1BPSfqCQ5sheO?=
 =?us-ascii?Q?DQN2K5VRp49hyE1PrXZxu6dB6LxkpglsspLb6YB3HlQ0xKs1wqDLT8wwP4uS?=
 =?us-ascii?Q?StnJls/ebU1IJk3Mjwq+jjRc7+6UqbINfCTjPy7CLRb1eBpM6x1lAHuCmJ9P?=
 =?us-ascii?Q?T57Ka5KifKx49JBBkFNVG5lVKVoUGOLxKXX+buwj+PvA8vYTbKbXYIDcEAQI?=
 =?us-ascii?Q?ZZbEVtp00nyrIDEoK906kdBS2jWDjDHe/PjAoUaHfk9Lc5JCIrTyjstBI0NZ?=
 =?us-ascii?Q?mVruufZ2R8Yl+V4vq/5cdw+N4HfU3EOqYi8ogTqShR4e2aa7iZB5AfcGTlpQ?=
 =?us-ascii?Q?dmEbLMnkHpsdEw9O2L30mJlSNdu0iM0C9m0WI2hJCjAi8kno5wvfaJwibOhI?=
 =?us-ascii?Q?72OiK2WVYP+/g6Z7SW3MkShcq3ak0qoaBa5AEdlHhycOkMTXJB7Gx2Jexl15?=
 =?us-ascii?Q?DLP8YK2cpBzrcvw2l2auot/om6OHo0J3xLnZ08N30peBdVXRJ0KQQTr2jgnP?=
 =?us-ascii?Q?PwmexX36Ple/3R8l/Nuv9AoECb70kPT1oxSyZr6VYWilemgoA3Ecu4r+Mfb3?=
 =?us-ascii?Q?hH+LEiu2PeN02sVB+5nXGIR9kjxnWNPgrL/KELKgV9hpHy5NMcmljrHQPJOV?=
 =?us-ascii?Q?Bjnw+KK8YIkEz/fqQkDdC3praR17kqeqdKYtqkwxqlqKQIpPGOTHKsnuwyxj?=
 =?us-ascii?Q?I2uAt20AC3rLei+Uy2yndIKrEyKPUo0EVGY2lboeqpISHbjypqIVjiYKrfqS?=
 =?us-ascii?Q?GfkMKb9Np7j994DbdwqtedoFnKBOYGUnOzixIlPSkZ0OqgXWUEN71rxo6aH7?=
 =?us-ascii?Q?8WJTOmLm68mQK7ito+cZsbgaXNGBA0fNJse9Ced138ix4q2OYEZwnI6vJLVO?=
 =?us-ascii?Q?Y65gmZwLCpor2FoZv3FK8xfq+RvfJFG/c4N9d9I7Nmk7+OitZdzkjPo2CXBP?=
 =?us-ascii?Q?jD/vg29keQ39vnraoU/6ruZhss4zkSpIv3hpKrWHKv7Dvug8hpJEMoSMVHtJ?=
 =?us-ascii?Q?xzIPJMAQN7FzNKGZW5RUq1fjeB6X/c82aKsmC//5MW2fLbK8t6WnLRNvyj9v?=
 =?us-ascii?Q?KUFEkPbZCLMj/A6/SNDgRrewBaTbzC+9VC4ucr8YjhEapLwWDG1tYi1RIQSQ?=
 =?us-ascii?Q?pJj5q18lHg3YYiM4l7fJVupJHESrQPhkBc00L8u/jh/2RJw4neNDS+SmGFu4?=
 =?us-ascii?Q?PX37TWqYp0kFRmlEbw7a2seWG5EXYqlCgdVJsEefUChhEbjgxxTU3y3mZ3ia?=
 =?us-ascii?Q?C1/Pxhz8JxiHdvrmx4q/BFLSk7/i0BtSIKBiSZnImLVSkQmZ8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d1083f-ad88-48d1-27d7-08d8e852d28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:09:28.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYIqaWE2cRyUPnXd67cSqrr/IzW11ll4nW226F25tGj+6nR90yGwc42k+3BeHpUVcONtSPh5i6j/fxELc4O8QDZrrhFqeZ3+F+Swkkcadp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7400
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
