Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1AC641B37
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 07:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiLDGnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 01:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiLDGnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 01:43:50 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2063.outbound.protection.outlook.com [40.92.103.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A49C1834F;
        Sat,  3 Dec 2022 22:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYD0T2R4dGKeJLFufLJoy2iDphMPl9vxcwm490ByDjzztXkER57m7yLJTIAoVzkTbGuOgaHrSL1B4jSQjf40KSjJXs3mBvfnlK9ANj2JJvGGUpXTN9L8NV6NCiixAmQZBSsjZclWHF7BjhmcLk3lfdFXcn0jAvwbBs9krQOX8IgusuclENnBc99AHsw72+JnbuvEvsvp1OrYdH4I8LacXxPBlEJaMEKQEMcIeJbx+/rWCChOVWsI6mcfvoAKXc3UvLVSvYG4pJA6Y7GZWxo9L4HmvMhhvFKmX56kd7m6KpApYwFizkrfHJPjK7TH/LT+Zlt8KsO8oAsGlDg/jtQzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgIY+0P1t3aXbUFA1YnfMC6Z0iZH5E3T/Q7CCpUZAyo=;
 b=es/xe4TAruBnLGtusVt4NxrxBev7fzTyAYqHroH5SQZEi/JWr4lPCXyCs2tbAshYD16vM9/KXGvRTHqAqyUlrZLaAgwO4Xs6tYBXADftkiyhcgh1HEd/y6D6mrdhz2T9PBVuaNKw1poKh9P6+a541U76/aALmVZ6SL+HuZYDK+28F4HK0dQKhA3VyMJ8FdefUvYSlHy3IiEHOOZYJmUSMj+Cbuwiy++jB+iZjZh/Vh8ktaDwDH80qmKzGXLfPIi7LeXkhU2DdZfJXKRg4e2zP0cr5rLpfx0ybtDu2UebpIrNuo2aZaXeahBbri5j/R7Q5fCQiSuGRzKAuPdJGbYmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgIY+0P1t3aXbUFA1YnfMC6Z0iZH5E3T/Q7CCpUZAyo=;
 b=UAB/At6HZwdntHQ9/F4bfNEmmymFuU2xjtnOab4Xb5chC3SwL6mINXlLocwn04UbMWYSrcIiqlEQFson1bf9X9S92PNvOK6iR2ADivbwNcfRbbvLoIZIhhTiokV5uAEo3VaWZsa9DW+T3/oi1l9+B1a0a+UwZSg6+M4ef2i4T3squ+HmGYkNBr/BGiugYhhswzEBjSwIS4OR+xKd+e10rxVmEPr9u2lAap3eIa/0epmjUx8I2lbVDHtbEiCtPmaQqhsp0jhxUZtvAkBrdwP9WzAGO0XZagZuRmmHQX+JU480LBvxolhYWcwY0qC0TzXYe+efquAQbANzOhZ4KkCzuA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN2PR01MB4155.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:16::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Sun, 4 Dec 2022 06:43:43 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 06:43:43 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     kernel test robot <lkp@intel.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH v2] hfsplus: Add module parameter to enable force writes
Thread-Topic: [PATCH v2] hfsplus: Add module parameter to enable force writes
Thread-Index: AQHZBuZqElmBzL+OqU2IAemfpk3P1q5c602AgABeVAA=
Date:   Sun, 4 Dec 2022 06:43:43 +0000
Message-ID: <E3567E25-C2EE-4DA3-AAFD-2833E15A98B9@live.com>
References: <79C58B25-8ECF-432B-AE90-2194921DB797@live.com>
 <202212040836.kykb1foO-lkp@intel.com>
In-Reply-To: <202212040836.kykb1foO-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [oL9C1InYa2cbT7VEPjtknB3k0+FDEXE7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN2PR01MB4155:EE_
x-ms-office365-filtering-correlation-id: e7543b0c-b4a3-4426-bdde-08dad5c2e2cd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9MeDOrfGw17dS+vgwU7Odo6d9xr8FLkdfLiZafAw1TGvtVH3NmthReNxucj6U0WM4v59XdXa9TMh0Ii2ma2FWy25pLreI3puNSXo6Y5ivwA4QYKOSx71e09Qk+Pc7/6I4SEt1Te85/C+xVFfHQyuQihMeeEKmakb0OnhB+ExKPAszWbA/77/qzW2PsRmegs5q9hqNMzq0bbiQSu8LjCQU/171soPdY2xlPzjuhDLhEPy36JgmOXjOybG1z2J8Qo306g2bM2RHrFtlGyuSYzoJslv4nnadPyHgRcCXQq/6NL8gvJJWFcKaaBpaWfvdFtHUW509FWPsSRRE/7O8XT8MqhiOdkg2PtmAdwh3IUjoA92ek6ZlkLr9UFzxLQbAV9jrKKVba+B9uUX67zY4y4HdtJTm/vwyNYl7UeORg7Sn2RTmyRXbh8sDxqQAmk3aZbfP7znWqu9zA2NOpsf3h3B2AmHKAwOa8GYG1Fv1YAoJ4K0/TgGhbnPaIdbha/ag/zZVfGtTBP0LqPTGhZNnjjbx6zf/ZFxPVj2YdFVetJx0asbcuX5CCgcZ4AN7JI0ojXjVR9KMgxiVc+uH433uXCdO192gSMrnpFNMIqQ2mwsd91QNtyanjnLbzGvc1np6w3T9B6DIMR9qADtsnnfl74vuj8rVv9w69Xa2YArrHVdZI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?51q7Gd+08YSsrNMy4zEXWWBAjvLB/sBqiCeteoj9giaeFINazS45tuZziVf3?=
 =?us-ascii?Q?t+DAi0RFGMY+QJiE7wAIjLdXneRt0ilTQ1NXsXeSTHdhoMazevuLvOphMT68?=
 =?us-ascii?Q?BsIqVMf17y099zcZS22G+T0rrqIT7895ucfbE8Y4YdmvTSxGz5MDoMcHokdq?=
 =?us-ascii?Q?KzVj5wCe7gqWl4xW9sPtiW9JYr30WtZr4JOfZ6JseIV+SQelsByTLwQzWpt4?=
 =?us-ascii?Q?aFwI84MlJanApEUC6vo6ZmKUgkc5LXdQH8KbZreZ70HD5bblHjY+mZo24oAB?=
 =?us-ascii?Q?o05BCZjnE54EPF+yR+iN26d865TNNcaRMXEqkS+irzveuqbWQTHdz2MV988G?=
 =?us-ascii?Q?yosvkWEVAMzHcQR8Nrzr+bY6s5NZDq62hU/BABxhJIWww/smLbrxbcombSsF?=
 =?us-ascii?Q?HLaZ9yTEwz9STOJY/uq1IulpKrlEDoRidnGwR41fUUju0hh4B6aKMSiJq0hh?=
 =?us-ascii?Q?bNHn7+7OUSODHMIzaI+4PGsLUyRWgFho3tw5fbtTDCS6ezO4zd4JS/mDOSTN?=
 =?us-ascii?Q?PSR/uSbcYll1sc0OII435Ih/d8hg4qUu69o4Z6YG1olRX6yCqmZ0gG16jlmM?=
 =?us-ascii?Q?PtcIXqb6WWt+okfw3wXWcQUApgV0GxBNwbRrvSkktdTBenO1Ys00sLqBoRW0?=
 =?us-ascii?Q?VxV/m/oJxW76Zq6esN9h64mgkCSwEcT/Wv0cQx03M5WKtJbPWJ+7DDG56v3b?=
 =?us-ascii?Q?3/1Li47Fw/yIZuHl1E2edES0mmYeJvKyLhGSHple8sPdUpG41gOdQcaTGQhT?=
 =?us-ascii?Q?FneCQaiNUiex65rhpt7fNA7liongXWkKeXQX8guDx4PF4lTLgFijLuz0BKsi?=
 =?us-ascii?Q?a0ZZHPvXt5hFn7vtWdFkMVp9/VcZCJZ2HBQCzickYOei9H8t1VpGvv8WZrkq?=
 =?us-ascii?Q?whlSOizFo4Mgxfo7fyOLpluRimz6PIEroyDINpbUxslliv60ljh58GJfLMuM?=
 =?us-ascii?Q?onHxgDe51XaB2+ZQMaO86KD9/6FMD1XaymSskcwjySL53FJoKj7N+ydNTH/K?=
 =?us-ascii?Q?0i7aNevwXbOZiNrW1acK6hojGGpUNHQZgU4GEB1a8MS1RtHvcZUKaqliuXFk?=
 =?us-ascii?Q?WMYGFEtFAFdEH+nbUlu7h6R4LPqqp1LKYsei6oCSVC6KUAyIdYdyIv0mc+7N?=
 =?us-ascii?Q?FYuDZ2Xw50i3pSqIEYmEl5wqE0qvsSc2wEglfkiSQBflk4RoDMAmgOX/K1zA?=
 =?us-ascii?Q?1gO2Idnb1Yg2mly8+le/27xlWDw1RR2omiNubx+QvtHc2hn9m1iyowq63NTf?=
 =?us-ascii?Q?nY3jVgYNb10p+OUpBYSBFDEyrY821a5kWrT8+/cI/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79854726611D5D4D930B62CF9136A8A9@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e7543b0c-b4a3-4426-bdde-08dad5c2e2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 06:43:43.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4155
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On 04-Dec-2022, at 6:35 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> Hi Aditya,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.1-rc7 next-20221202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/hfsplu=
s-Add-module-parameter-to-enable-force-writes/20221203-151143
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/79C58B25-8ECF-432B-AE90-2194921D=
B797%40live.com
> patch subject: [PATCH v2] hfsplus: Add module parameter to enable force w=
rites
> reproduce:
>        # https://github.com/intel-lab-lkp/linux/commit/dfb483e3c16e562d76=
8f9bddc63252f1cccb0275
>        git remote add linux-review https://github.com/intel-lab-lkp/linux
>        git fetch --no-tags linux-review Aditya-Garg/hfsplus-Add-module-pa=
rameter-to-enable-force-writes/20221203-151143
>        git checkout dfb483e3c16e562d768f9bddc63252f1cccb0275
>        make menuconfig
>        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFI=
G_WARN_ABI_ERRORS
>        make htmldocs
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>>> Documentation/filesystems/hfsplus.rst:65: WARNING: Unexpected indentati=
on.
>=20

Do I need to fix this or should I consider it as a false positive?

