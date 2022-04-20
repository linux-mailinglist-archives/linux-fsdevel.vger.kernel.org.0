Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7DB508660
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355729AbiDTKzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 06:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359695AbiDTKzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:55:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4B403C5
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650451935; x=1681987935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=niZ3YEh/04jokF2qMico77gA9Mj3hDlLqhu2p8i0EYwQS+SsDdYGPTEe
   gv2jchFoW3f6O1ldHzOMX6AtnymC9kaLdTmskfk7Cv9iwLJlaXvDE2ppc
   ApzzyEsT/js0aBHuZSF1dw82EY6oVbuLVWP2k+WsaRd5/PSIj/nXA/uq+
   rpu6gmd1jCSIWglxkHDoArxYhWV6VwF+hLPNPWgnC1/5G2i/op+0b9Bnp
   H1FFrMFv6Z/rU4dHWb8o1JlyuaZAaMMXvo+v2rTTq7Iz7IqykAL/yRaHG
   R3oTCbtA/PMgwj7XN/RJy/WaLJZprz8pM+IVS8TEiby625octnxB7O6qg
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="199251080"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:52:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfgyCZHZjdp7pW6QaZUedbhos0N4B1FYi5o7wx7b1vt79LZs90b6Vtoj4L95r+vcSCGmRBMmeh9S82v5gS/pyV2DO3v1zbVdKBYIU1oFdLQUXh+EjMWJmmY8cR8QXrfJDD6pu3gGtLpzc0p6dIARfY0VpSz6oAc1OoOhhZNPdtyGSkab8MZTgGI3IiTsi0SRVjG8Y+sP7Idh1PwGhneTpBd0M6QY15c/Nxrh8ofKMUinGRheZjGzsUxeJsJaUMMchz7kJq3QTAQeKSgxRtCNO/lGUat9eRWnZLF+YreQ2tOVV/6BWMXGttllidn6pAJvQ9+EUmueBFAos0AWiS8xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=BW6kFZBmFYCHvHGLFwSexh7DLQcbg88u8dqQbA5gWhsiM2qvsLJodv5LFLeDmqyXRGg6Tc7HGkoy1n5Tsu6jrT7trEhFtydLyyCuyb/px5xfEqdmBtBPS4YHHd7gyPyx7Js0omNZyMC8KzhnAm+ZDhRsc31ZML0MEjmhaQgrR4A1cn0yiNtBZlGL+EsruAmBYASMY/icyiDtRIcfTaCF9gkEh0mEoLy111Zz1KbRLzFUf9HR5p7P6qqEI9XD4gNur0xMd/pAcVyBEqtsUftM4qJw9qFc0ByetHf69n1Gqbv1Z4PqVtprDrd0CvefVExzP0ZyHEnFwbfGph1X+5Z4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=iOvechnPcl1wcy096I8AKLCtDQq0OTKQ32XnYBaWYMqtPC3K487+8mPB/gtgf3lzp9JwWBJ5+KkN38BwrTqTnoTIcxRk38K017Ll3+sao+8RVGVghnhmWis3q4Y6oS4ggVlNILFR8eGLORKJLnDbNYBNAnSmfoY3ZWLOddDxf70=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:52:12 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:52:12 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 5/8] zonefs: Export open zone resource information
 through sysfs
Thread-Topic: [PATCH v2 5/8] zonefs: Export open zone resource information
 through sysfs
Thread-Index: AQHYVGAAdJPxlzYVPEaX04FGmOojVqz4oJ+A
Date:   Wed, 20 Apr 2022 10:52:11 +0000
Message-ID: <20220420105211.GC36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-6-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-6-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bd986b9-f356-4930-cf83-08da22bbd301
x-ms-traffictypediagnostic: CH2PR04MB6694:EE_
x-microsoft-antispam-prvs: <CH2PR04MB66941B8A2A3591C9F7A80ECEEBF59@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zk4gDNmnbOOli2MvuzjSJGW7eP8NKrQq17UpagdvEfxUyCINBgX/n4XzntLKundqc5D7OcaCf1aH+3dkuHGhXPb56lpIe/pxt3aSaHvKpAEtASoPw/iWp/OGXDveWRMtE2YANagCFBAPkHGtdIjMOn/qp3cfcj5rAdNiZeSBf8bFEJC1VyHf/bf86I/xmpaeIhvYYlTG1tB0GVoco5QUzY4ZiCg554hUMhykK5Sf3rIN9lGmPPEckjENNvId/2tZjuOGOH+etSffRe9tgNR3ucitHjAF1Qr/82W3elTxqA3JvFcZPa8OL2JczWxMkFkgXqFhYzGUFCBR6fTMp5taXC11AE6w2vVHqcnBazdU3EE+0OUrA3dl8G8cOwwyn4IWFvARF5vIOgr8I0oYGkVPidgz5Dx28aEeGkUkNpg/hxb8wa47ivAHjtpuVgvzzhkIP4Yo9ZA0x8zP+GqOevwFkztvzdTuAT7Uiug3RJgC+2QN1C/9tCA7PMVKBqAmGqz5EGRP10O7RGUlY95gzuOum+f/WLL+Un8itLAsN9d3A7LDndYLmodZzsUiBke/uQZSivVO3/Q1u/Yq+sQF3b2kwvh+rN+ty+P3vm0maKgseIfBKkEk945jyLC8I7UoqFt7lYS0Rp9HRNfZwXPDA08xhe+j6JPxmfAkZQcMJ/Xl66w7Kh+VrIG0w+UhIG+awhGTwNaaVq7XiUf/QZChV+3loQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66446008)(64756008)(86362001)(71200400001)(6486002)(66556008)(91956017)(508600001)(4326008)(33716001)(6862004)(76116006)(122000001)(54906003)(6506007)(38100700002)(9686003)(6512007)(38070700005)(316002)(33656002)(1076003)(26005)(4270600006)(8676002)(66946007)(82960400001)(66476007)(8936002)(2906002)(558084003)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?77n6eTWFRNahHBIYYHxR1JXgg60laIbEgmBhulbSI00GLzt9sYXRNh8jm/Ln?=
 =?us-ascii?Q?BhTXtlWCfYDDWL/Cl7qXvmAALEVmnE892q2LmeWKZWonyljr3/oY2RGK9Kb2?=
 =?us-ascii?Q?n83GLmdSmLgHZ2waUzGFr/KDUoME07eNbpJEvy8m4i3eyb/dHs3gA8QwNVU2?=
 =?us-ascii?Q?17Yf1btqRNvhJSGDUnNnj2TXe1/FGYwXjRwtJ05yPexpuM7YYXLuLm6pGEVc?=
 =?us-ascii?Q?TvQYer3HtIK7mPfyPsfSbPsOUwHyPLxhZ+CbP1cdD6ngQIUW1Fa6P3oGaYvo?=
 =?us-ascii?Q?+8FlTvk/wJGmw6vjmSqRKY7Fg7v2a1a2jiCmOXun0XQS8uF46LIl3SGaTLtC?=
 =?us-ascii?Q?p0XxXGoawiXN0sD5EJSaLVF94gomD8yG4I7rVC2QjUAM4ELmSf7W7CmAjYX+?=
 =?us-ascii?Q?OW6H0EFLQCTvwBl+HPaRyQ8JhxkgzAgsuDmecKBS83b1Mwybh7eOE7Z1AEDH?=
 =?us-ascii?Q?7gGBUi75dfQbjM+tayGTizQaoebxTNh6IL1shRLiCbW+mLVRG74XTjehNq4S?=
 =?us-ascii?Q?CWZHIGeH87QVddD3Nkjm675Q59o0ItgNcq7i0W649ADtn8YrmjzH9As9yWkz?=
 =?us-ascii?Q?EM8saAac+iXyCMK6+K+nqENmNBie3aceu9K7GIgeJ3M4W6Rq6/3Ag5ZGBZsH?=
 =?us-ascii?Q?uJM1prymPtRiZuJB2xJjIDIv6c1Pn4O2UhAW+CnoJqjuomEwkIdPpiN54HfV?=
 =?us-ascii?Q?pNlCDXFpUMzy2m40/a5jBX9w+DGyopPCA+mwnUs6aB+YJCN6q+4HVBM0boQb?=
 =?us-ascii?Q?czJTkEX0az/FXb75xO6F/v+kbTrQ6h9tW7RFmq3d/rtTh7oqPJ67be84zKXC?=
 =?us-ascii?Q?Xgjdl0VZsO1OeaGBGJS++WaFUT2S6Mz1LbuI4v1YEscFSBQZPQ3VWFUdUN6n?=
 =?us-ascii?Q?X9FdaRFdUBXB8GPs69zA+eLntpTPsPZ69hj5cn2VeJt3LlE8FcjJJ1IAJHhy?=
 =?us-ascii?Q?fLFVImq0vlQiQl+KpyIJI62zggbMkuKahwJBr/PrtyGZBYhZm1EvWynJFF0v?=
 =?us-ascii?Q?orJVK5BSZAkEMlB74yPH/h1q6QPNz0WqE2ciIk9XZ0eZm3w3N/7PNhMB/34F?=
 =?us-ascii?Q?qT+jYdzdIa9Gb3uBfo4+ZmxdHeifVRLqs8P5bD8yX7Gllfr/rNOXNzPKUdNU?=
 =?us-ascii?Q?3kCDt4Xzsty4/Qdd7njdGOkTJdvRXbMfWgaclhKmCExZu9FDT768srYfAS3Y?=
 =?us-ascii?Q?c+/Ky/LgGxKxCjTVih0MYZIY+brKgDkFXd4g6dkjJlhsBrGkFNAqT8L4jpA8?=
 =?us-ascii?Q?ZPdfXwYmKpwq/lY4lmRnqldve+Ba/cJVTWG7eloRfOrxQalEIR+E4+XqMv0I?=
 =?us-ascii?Q?pecdexU5XmCpXWYFTiwRkSONEmB952S+X3ZMFbMamgvuthjwXiMooEV+l/XG?=
 =?us-ascii?Q?S/zOb1Qr2W6TwBxpTVATdBxpl61QjkA+A8NEWkWet+Z2AdzZ93xlQgpp7PIu?=
 =?us-ascii?Q?bsNDgRWhgmnkHnnXPXw6D/EwBO3AOUgp7nB/tlxtO1FBEr+1bePmhcFkNqX6?=
 =?us-ascii?Q?si1A38RCee3jzXctIAJ6kiM0/KmUep0wgLLnEl8Wd9T7yonyX/DZNUQq0lLe?=
 =?us-ascii?Q?suqw9+gWHjToRqZ1Qf1mcl5JYgyyMAe60q2WSACAD3tpCv/Uw0ZJ2AYloExZ?=
 =?us-ascii?Q?wjHwJyASWY9mn8PmA3AxWd7ues1xsh/lMI31JEtOdcSHT5TSWvvnr3Z7u0Qk?=
 =?us-ascii?Q?KorElaoAQGng5wiNciTcqfa/jJYC3wjfnP+6xLyjcFP0eIVcnr07SAXOVXbC?=
 =?us-ascii?Q?BSFVE8e5r5ka8Mn3QuobYFa/sNQGx3Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B3E9C1B0E31804FBD10337005B94430@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd986b9-f356-4930-cf83-08da22bbd301
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:52:12.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t8IuKehVOjpwh/gCliOUSifxQEkz//3heB/a+iIGiuSNDHPfE761t77FkTp/361SBN2llpEoH8U6g7aMesRXQ==
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
