Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB13350867B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377851AbiDTK77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355368AbiDTK74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:59:56 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BBF3FBF8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650452231; x=1681988231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=Gz7coWRgVTc4xtuGeEfoR+pBUngMAl8i/UnQwfXcCOVUMajVmIWRqmKx
   v0f0aLrsBxRvUFi0CBkZcNVoXM5kcv4L7gO4QAIBO2cp52odh2Tr5hQJ2
   wEPg+kkC93MT1sDv02zhzAVMxgPiD6ocg/NxqFJUWnjEwC+M5Htc+COyY
   GBp1A8cyAPS+7h6oeD1gGpGtPWn/eidDMCevePdlNwrhDNOyns9jA5osL
   IkvLVQkH60lE1hSjbRCT+YrBYUzW9RdK/PEv6ViY88PwHo421F+98EXy7
   4He0huKREqzzdp991CUPlvt1TCCFzWFFOXG+XBWu0+gTb91NPtkHijYwL
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="197213433"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:57:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWK5xwHfD5wy2xidIUa9GM17OkYA790euMkcBkid6KUxlyVLOSqqSxxhmaxS3Bt0F95ZwOZtKTZsc0ZpJCMhXXDLQnCoqtgqOXKofa8m9tsU2UgtbQihLwdIY8tcmdojS1gksDcJr/sUe9zB+Cm/em3zE4PyY8wXIvJx+ADM8h4M9HH6h9jXI/TTUcmOFGhKWSRN+o1qM42hE9KA2GCtclBTJOetXpi9/OCy+lJyhP5OXLgDtkMj9M1PvBxMk4EGLnQoydX+/6LDZnEBXOO6L7xW0ICUDYg+j2u5pdml53DusxmiMJw9SyT6y/T5k5oFDSf/6Ve565DsKOS28Lxmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=b4VYhdKi+wXHxMF89EgPUQcMOHAh6DJEYs/k/yxEPrpRL+32dfHN2Kifo+lomg9kE7hELTWYkKTlAPq1//Brkx2g87WbIesJ+Fnax7OfG9ASma72u2ihnv2haDAtFkMumdFND4sWdBeyOgdqda08ghiHe85UNcgTBkg7/X73VCvaOUTh0uvCs1TyXVIXgJeAblFiThsSZQzmQIG0IGlxjUmwo95ioHsvnn9VKJ2cU+Wi9OrO8N+Ms+aRe4LHI3U8UXdr5oB1F6ucI71fSWhJrUzd4MWXWGIr8AlIgFissKLJbDDgOoPuAkKOmeRIgr1ONVL8R3qBUHaCaLesNlzu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=ZkmPkjIRRrwyBTCZEIL4m8SWZD6OStDwXcTA7LF4vC145gZWHPfzWBG1k2aBesTKNbIqHL9Vo5NUFTJ9PM9rrO9aaTBxmRv/2dC6911EHlbGwdh30sQwXVtLmgPPdFXV/PE8nVykymBqQIztvUY6rPHlgsS8otYYUrE4xtaX8BY=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:57:08 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:57:08 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 7/8] documentation: zonefs: Cleanup the mount options
 section
Thread-Topic: [PATCH v2 7/8] documentation: zonefs: Cleanup the mount options
 section
Thread-Index: AQHYVF/+VfRJsMzvDkiEwD36ZPDDv6z4ogCA
Date:   Wed, 20 Apr 2022 10:57:08 +0000
Message-ID: <20220420105707.GE36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-8-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-8-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e7b617d-7551-447a-7fea-08da22bc83bb
x-ms-traffictypediagnostic: CH2PR04MB6694:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6694BE099453728801720D39EBF59@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3x9NgIU+syIucpKAanEYizH5a6iDYYBX9xRddO9o0EVolwIj7F+OGSYALC/lAOE/V45vXiOQL7pIE3jCKJ1AQsOUZ0nOsH4dr3JzlJ46SsoxF7bv9/tG24GDrO4aHB+npzY0knaR6xrLdCK4xkich/K7uW009ismMYw5CiBNzTOTUnQ3nMfYJODwP6KD+iM2+QjsrvqINxeh1dqQcvd21gEzSo3/shS09hJdSyKUc8Bn3BSZoO25iy5h0B1pTuNrH4p+vzRO7E4aEea2bX+nXJl684a12VtzJOcwm0lbxAyxZetgBLWMoAF93hWUrLBbfbv+FNw57B2UqoNsJYsjWYjsgvmtILP4mb2RE8Bt+PmXHJkhcV3Z2HlvC7WNl71U9hkXwILuTTZPo00I5GXo+nx6W2cQ1Xa83RVfe9dsreSqY6r7Wcza90x0rBHjH2LesTVrz9SEJtw+ev9LdGzv+h1K8lxcaTYbPbNqiAPJ0z0px3X2++5I72PoIfq6Z0CldLPsEziFFZqgo/zahuypzr5QI7HYZW9AFMNx3MoKXSFgXBKFXaHHDQe/hsn3DktP/DKBSoydVJlHsW9DDk8r3ZG3dk9ZnUe/6UAn36/bzUhr5XcPUaOqKUOTMnVCHofnDtMYutIULhoBh++Yd7o7udqZo1Zedl/wtKdY2bIh3aa12/Oqgix3Ly/MQjnPmmuM60aPq+9+uDEFh/SejBPIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66446008)(64756008)(86362001)(71200400001)(6486002)(66556008)(91956017)(508600001)(4326008)(33716001)(6862004)(76116006)(122000001)(54906003)(6506007)(38100700002)(9686003)(6512007)(38070700005)(316002)(33656002)(1076003)(26005)(4270600006)(8676002)(66946007)(82960400001)(66476007)(8936002)(2906002)(558084003)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7PJvYW/DIj51YGHg2QgxLfbPmLz1swNfkRpljzc5K3J+DH19QsAoQngDpZbo?=
 =?us-ascii?Q?jn+qDngqheNRHXIywrtbepGIZPdB0ii59QIBFvXt/vNqyHfml/kCVy2AOboh?=
 =?us-ascii?Q?1G1LxoP05Tx0tKcU1sdTgWvxRat9R9NtniH2iFxPWPcymgpXJCJeS6IiHjrj?=
 =?us-ascii?Q?XR2fNb7m2b1i58vywrjw4fkdp8/4ICmUQ+o1K0mnzH2ZYCP/45vgCVRkfRiU?=
 =?us-ascii?Q?6Vnsy5tmorR/y9CqcHVGWxm9ySWftK9bP9Q7aL1tqJYoiYHyDNztl6l4MT6y?=
 =?us-ascii?Q?Y5ce5zspgcfcHSOHL4f8ViV7SPv2UPQLT8tFwdx+dDExJg8k4P2SDuibgJrz?=
 =?us-ascii?Q?s3euXmu33vtOs502MoA0eForGTIoj1vrcyyIYO7KjYfOOKPDvq4hyUgXC2t0?=
 =?us-ascii?Q?S8YSsyBse4f8LFvXgiC4iBahBIxfdWai2Ucz4oArRRjHrFahJQ8fGiSlWmKx?=
 =?us-ascii?Q?BbmZKYtOhftdz2g+MVSKSTjSsTMH4gpRoIkT8pX8gzvNAFILeSUJsjdODQwl?=
 =?us-ascii?Q?KVdfTwSWxHUxWyV9fjQnH8c6zkRPw425D5bzfUdMChR1fuNnTyZ6xQmN3+rI?=
 =?us-ascii?Q?cApuWuMXbZJ0u2OZFw8oOkcyNqVk1fauFqkByYIpkYgba7yOLfn/qPCTdmgO?=
 =?us-ascii?Q?iLWqxcIH8Ri3WZg/XvSlxgbZDf8KGgp/GFur30+QX5cUq8RaXv8h+xPRQQms?=
 =?us-ascii?Q?c/gMlIjCj1oJcp0rq5ROqwdK9Fv3H7nwGi454gl33AlR0Zbpv0oYVS+HDkvw?=
 =?us-ascii?Q?34JtOmcURXz57EsMTV6PzgrW3ck8by6aagwOsY0ApLckxeumix1T0pVMc5os?=
 =?us-ascii?Q?esDiIcJzEoxdzTnAI4nRZecegKKvhqJdbtvN9hfrkurdJpzMGjVFgvVea6kq?=
 =?us-ascii?Q?M6JSTCt3NGKccnGFL/XgMzQ1Wp69eDskYLrG3bpp7y347grNicGaMRWlsj6q?=
 =?us-ascii?Q?pUzcpIXbotZroU92MbSCSfGAacOn+4iQusxUNIMiqBfxoipzoESvIoGg+zGn?=
 =?us-ascii?Q?C/wb6+shY0K4t2m7bkAY2um32glia/SU0F6QXynjhQjPWkKCSZjnxStXUzTW?=
 =?us-ascii?Q?O75DZnZUQDdKrjhwUPfmJcB7Q55o/A1SncMUpkaYCo+s6jihCNgywWI8toc3?=
 =?us-ascii?Q?8P4W+me468JK9ksDx4G4dNyT2jGUCYwGpfGY1BSNI/U7BtOL47BhqPDLuCy5?=
 =?us-ascii?Q?Ien6H13xlZjqT7vG2zppJp+Ecx7yJhpGMcebS0MwcHYiDhMoa6hz9I6vQNS0?=
 =?us-ascii?Q?OrN6QgnSazaLjbkh1x2IJn2UXSX8IYI1cC2UZDACkjOMd+tKjy2+AgBmMMdx?=
 =?us-ascii?Q?HpGj+MPTQAlSMt/bkzDisOtqxwrVRhBB03J7FHRHk0XTXOzmoipQbAanIl7m?=
 =?us-ascii?Q?yUdFabaHQqQppMUiTE9wO4R6HyXuoitagP2p7kQ9UsPqVM7xlP/cZy2KWXy8?=
 =?us-ascii?Q?6m0X8BiC77CLyaU909l6uYPIJjnBmWbZlFHAvb8qc73s/shuR+NRCd9HeXi+?=
 =?us-ascii?Q?Z2HrW9FS3Nyzew7MEmX1xwxpHj83ePYJTJRdCDrBz2WrXMri0PiBoguQIV8O?=
 =?us-ascii?Q?UfvYZWy7f9m/dtykqajK+j08Lfvjna5WV8Rbr8uXcovCZny+8pjGql6PqUP8?=
 =?us-ascii?Q?yyMaFEzURzlVLt+rbVVLAbcb4xuVoz1E5N4HcPF8gv1o94dvwX36nftbNLYO?=
 =?us-ascii?Q?ww2+oYZKQ5OaKIiiOWzBe1YTOcaGP9u+dQnDgMqHkyHmYS+d+lAbSiEv+EmE?=
 =?us-ascii?Q?3gwd3ydFcA4JKTv4zu2fVK+uIO8eTQg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <334ECAAC6533444482F361564707BD00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7b617d-7551-447a-7fea-08da22bc83bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:57:08.5489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYFxlL5M1aAJjwOh84SefTzc94si1hIgr0Vvw/gQBuRvupfiNT5DX+hCiCVbetEueZVcXvRWN0bPJDIm0aikHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6694
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
