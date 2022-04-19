Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49B506967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiDSLIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiDSLIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:08:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2712AC5A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650366367; x=1681902367;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sB3WCXWHKs1z1x2mK4gFq37HZBNaIXFMKn6XPe2rkjs=;
  b=Itvd+RbBJvuxB+8dvpgyepRKSFFuz8fXVtE8KI7mOdDoROhg4CStprKd
   sw2fMAXTa9dYMq1zAdGveBlv6PJEwEPSAQdMOmvLfHRoZVA0FVt4sXa7e
   HSMpk484eNCDuMzxm3qbCP5AmYJPAq/MaLNMtQ76WWG78sI80+oI3wm9O
   EVnDlzYDWGo1yrad01LjB9pMU//Kfg6HThwT87bQJpcjzFl3AYAJpQRWg
   0pjk2EGPgH3K7B3rI6eW8oT3C/C/Fykb7Nb5HQLj1eEUgaiyfjIxLzvqt
   Dr48SxaL0OvHRHeVCtS3eo1yaQD+vRqXPgU9FelhejY/RCoj0Qfpdk59h
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="302447832"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 19:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP8xYzx0dFrWPbddrUzI2EHOd2Y8I6sdEae+IcfCyv1GfSFDpV/9c14E36pEGGtdWnjtaNJ+CEPOW/U5nKJO9ft7cLi0imq+OEVc4nCC6HKD0M1sdtxNpegBx7l/tHwVzLDYn1b1ParFffy0m7ivlcZv4higPvVtAxAPXeBE/m/3fggfMrYGK80gfAy5TDff++oLwGWgNi2W5ubkyyWHIBk5ZoC6jMiHsbsqbY0jkG4SQtJ8Tv5GbfVmsweARjFkEMXrPQ2bw7SSvZWNmvHcoWoNbe5By1ylzBTWJLOUXiUs60hn1NwNQAmvH0OlWgi3PjCdNbCuLG/ujdU12TnN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJEO34gYa6h54rDapj2lTwDOxVeZIrv6sjYHhBvfvgM=;
 b=WXnZnwTgFKvQP6kjSPjf/XueEic3/VzPLfyJqPcA7QO8fmJX18iwKehhmrdALQfA79maf74LndJqme6MlR2uI1M1ooURAcatd92a2LypJGOF1ic75CxW3hwuU1C1uPF5FBrzWsVnRBZ3/qb0cUpyexGgtHfA1Dmbamii3FBiI8qvN1PL2IT4I8KFCjLYJI76jgz/Th7jePhOU3ktR7ZWlGq1Pig5+ESTTXDwVoQvsCnlSH8v3SSCBwDCf0IGBprjLFCLAgx3KGzPl/k2eb3kzbegY+fjXyp8/7RPrPYcs2qAaYiuMnKB8xaGpqPQvQUT5yfOEXWFMWiswtTv0oJenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJEO34gYa6h54rDapj2lTwDOxVeZIrv6sjYHhBvfvgM=;
 b=VmHcsCDYKxxCtNH39gideMdAhitmGjPqZU59PrNCS/8tREC9TPsF9PmDHpuw9vJJ5QciWLE+cfDIrzseanTbQZjL92BkD4GfTHL6vZFs7Ifryhv4v406JbmKWJEtu/DSEls5O9MaMIIPG4FhFnJiYopiQwe/Fwct6SaWbg5q9nc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7085.namprd04.prod.outlook.com (2603:10b6:208:1e6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 11:06:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 11:06:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6/8] zonefs: Add active seq file accounting
Thread-Topic: [PATCH 6/8] zonefs: Add active seq file accounting
Thread-Index: AQHYUsFZQrzjk8mVp0OZnpV4y0KkLA==
Date:   Tue, 19 Apr 2022 11:06:04 +0000
Message-ID: <PH0PR04MB741645F790D210401E2CD2EB9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-7-damien.lemoal@opensource.wdc.com>
 <PH0PR04MB741681FE45A964154D2C4F359BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
 <58c3d966-358c-b7e1-e2a0-8425f783383c@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9e6d3a4-a520-4e00-7d74-08da21f498cd
x-ms-traffictypediagnostic: MN2PR04MB7085:EE_
x-microsoft-antispam-prvs: <MN2PR04MB70856E8AB6347EDC303E75349BF29@MN2PR04MB7085.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jt6N9Gof/aH4l+mkgwCUit7E8ML11lz6kbddSnVlMvjsXyspT5M2rmXdDgubJGEyd2hiw3c6kiePZWnsj50f0k8TA27wxKU+48tzq0vgY/isIi5/zbnMKtfIbG3KSV9nlOICYWT/kUBhjaA+QzQNkWr+xxDDM3SZJDRqgRvDIHHD3wH9ga3WwOC+69MptBi92U+mOuVbgp2V+hp8paq8NDZaP01R2uZ7rNi/+oqFyNKl9HkDp0tuL4dozr9Q7bBEtWWz04TjcXTDOCcTHRUJyEq49BpWae3KZ0D/NTdMCLPYVXva2gURarJrDt9jnhZT2DfagPTpo/5VMSNUh2Cjd+dXY1Lr9Y98NVhaOY7UT4SJQ1Ynd0aFl0ftluu3Aq2pp22vSqewpLcuCPquvN37U/VuxAil9OkRu8Y8XAs1novHcUhXXoSvggsM+8ETtXuGZKBnQHycwR/EesrIyWYA8qQVUyQHtENJEXTnFgBJKkWs1uaEtw/sJi4IIqqUMuDCLk54oRE0yaJDN2g+xeVA3WnB+VgK3EkUvUJcARBO5Dm4F1KfQpYvEXubVr48G4+AD61pi/2Wpewg1+Fql8j9D+DmfkANVA6PVLkdQleyFOyp8PAWHzzoyVWtyUWJuA4dL7bC1V6AXzX1r7f60J3RPVEtD4LHd4PS9Ik7LxMRlVLu1X/7jI6HV+PFmExqPTrqiknzYs+48YD6S9fVkp93zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(66556008)(508600001)(64756008)(66946007)(66446008)(66476007)(83380400001)(82960400001)(38070700005)(86362001)(316002)(38100700002)(91956017)(8676002)(122000001)(76116006)(71200400001)(110136005)(186003)(6506007)(7696005)(9686003)(53546011)(2906002)(33656002)(52536014)(5660300002)(8936002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mTXj8tOP9HYMEnFWjWp47z7MxnHQT2smesseCIFFc/YrNIDiIEHum3czkM5Z?=
 =?us-ascii?Q?POEUbp5leTeU2+JUvC5ZLtrFiciZG0yK5vNLaMlg/sOR/GVemh0gNLv7KuA5?=
 =?us-ascii?Q?SM6BSRla+hmqk4jm+7rln0UK6BXfk9eU5f09eD9aPrAUbsSoiDGE1cmrFyKm?=
 =?us-ascii?Q?F3gFWEBRV5lNkEgDK9fh7vb5F638p9GlfC8ExMQDc6JOENaozyjq2YUbnuP+?=
 =?us-ascii?Q?spf4eJsJLfdA0XjJJs3GBns43uGE7KymrvDNdqXmL0hKKaSBlqaDZGmd8758?=
 =?us-ascii?Q?RQ0VIQ2OVCZ3zuawtudM5M3ys2M350cYs7iqBVlFptUfYcCnoYZC82xbxEUI?=
 =?us-ascii?Q?tUgYloUVFvdPVgplTPoveXGPhEEDvHaaBs/afDGoH5F5oeCxvalch1uqyN6d?=
 =?us-ascii?Q?IoA+L8HsTigfkkjkgODWHpf+Hyh4yxIXgADB1FZaSMpua/I3kEYaGjm7C96U?=
 =?us-ascii?Q?3U18ctGY3jgZxuDvTvBmB4cI2Pa/6rpez9yDg3zj7bARCr9zISCg11QNvj5I?=
 =?us-ascii?Q?+gb30JJi3AMpg1VbPQTTnoPOec7LzXLo6YEl1NWii1K1sfeOAkqa18JPK2gu?=
 =?us-ascii?Q?M+hUC1DiWk4LvZWtoJJI3ObpWagDfaCqEH3L2wSH41Q5eHHAx6SYMK7oIgyF?=
 =?us-ascii?Q?tpAM4HYHB8RCwXqW3vSfH1c8wnd1pKLVHYnu24qMaKhzxjhMWyEsB48qbx5S?=
 =?us-ascii?Q?lwbiBuU9EvZwqEeGTbO3F4oVLTRqVN0G0fr9mvDEvnXUuvfzGdz/8h/PCY1p?=
 =?us-ascii?Q?hHIf2fy2y0jNWrPvF33qTEVbNEliAMicZx8rXyrEeysYfluCRHz87OkIw6hD?=
 =?us-ascii?Q?1uY/2SkiBgUY8XOmmj/Gu9bHw+S2ymub/XCGdGWj8h4xHm8gAxK1JVMLW5JO?=
 =?us-ascii?Q?4doBUcaK67ELQJHMd/fb6q8S/Ua5hC1XknuCukPCWwBrSyMji7L2v3KFw+Zr?=
 =?us-ascii?Q?CBpStcYe9qkASbZXTPnxnkz6eBg3CwPG+YvhJAXmHh1neqa0zZa0m/Xff8lj?=
 =?us-ascii?Q?sbtj8OKw44aBwC7tR/GQRaEXfJgWJ1nHGizlvHqINl/22mtnSSKCWMZnVS5h?=
 =?us-ascii?Q?UiWTchIzs00VOBPh79Yyaq6g9t/pHvupR+KnRTKmV/CSa0f3UflVLfBxBFJR?=
 =?us-ascii?Q?ggSHtMZgPRhNQZGcs9rYRMcMjaFpHjiwNLCbtM8NY9DVOAf3McWY/0hVGSwI?=
 =?us-ascii?Q?tP2mEvfpQmNDIk5CtRiYUkduvXfcxWY0u/zm4/+qDcF5C/w8/1yzvo4gNmP6?=
 =?us-ascii?Q?HBJkGK1edxWuvzs/hv8H2PBiide0wXTgZS0Es8/Sxn4ktLLfjJbIWxrNZikV?=
 =?us-ascii?Q?dgExwaYGrrJsVAYX9bmYbRQSgiSDGwhhMldilOiazah26SyF03lknDiW9vCu?=
 =?us-ascii?Q?ZiKTHEDni96kOSIRDx1iucvQd8rau7jwKFxmB4mRmRC+BNo9xK1TGT2bW3jV?=
 =?us-ascii?Q?KmcUdarmS3+HibGL4VpJVOzKUwvusjXgmF+/EsdvxB76LhcIfNIfvyeY+3zP?=
 =?us-ascii?Q?5JZYn4+ZnS/2lvmjRJk9ltSAf9m0gms4KwRf4qr8n/fGfkM5CNO7CxP/Mcza?=
 =?us-ascii?Q?9hEF5vSlvqXYtMPht7VweSC+mzsnTPGjB9g9HHfnKgVpgKOEWUMYezVmJ1bF?=
 =?us-ascii?Q?GIhJzXQHx4pGaTzK0BoeTDaxwAJ36OFaTJna+cW+7jSPFx798WNNXyYOA7xP?=
 =?us-ascii?Q?YoLyZguJ4RuPA6X+5P/acyb6h+EgZEMdO7ymUTx3gfX0+rdQkTpicIwE1PA5?=
 =?us-ascii?Q?nCDvrnncDuLpEPLDPnhEQwlImGmOO9ozes5WoN9zr1P2DuIsRdf+5Dol3R4M?=
x-ms-exchange-antispam-messagedata-1: l8JJ+xLjRDmhZQNp2QpZJLVfRPBSGovesI4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e6d3a4-a520-4e00-7d74-08da21f498cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 11:06:04.4437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE6QJue0TmAv13CgNb2GeuXPoxBp2YNZsGuUNU8eMdOy6YC8CV/iKlPX4yc5rAZVoq1MWdjO6rsci1EyK++icn1CGVJ+f6HPNX9xi9/QTEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7085
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/04/2022 13:03, Damien Le Moal wrote:=0A=
> On 4/19/22 19:59, Johannes Thumshirn wrote:=0A=
>> On 18/04/2022 03:12, Damien Le Moal wrote:=0A=
>>> +/*=0A=
>>> + * Manage the active zone count. Called with zi->i_truncate_mutex held=
.=0A=
>>> + */=0A=
>>> +static void zonefs_account_active(struct inode *inode)=0A=
>>> +{=0A=
>>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>> +=0A=
>>=0A=
>> Nit:	lockdep_assert_held(&zi->i_truncate_mutex);=0A=
> =0A=
> If I add that, lockdep screams during mount as the inodes mutex is not=0A=
> held when the zone inodes are initialized and zonefs_account_active()=0A=
> called. We could add a wrapper function for this, but I did not feel it=
=0A=
> was necessary.=0A=
=0A=
OK, but then the 'Called with zi->i_truncate_mutex held.' comment is invali=
d=0A=
and should be removed.=0A=
