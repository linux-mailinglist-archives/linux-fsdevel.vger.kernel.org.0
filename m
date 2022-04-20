Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EE50866E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377847AbiDTK46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377849AbiDTK4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:56:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AD40922
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650452050; x=1681988050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=Uia3KCL+23okjisIZMg+2i3UJNLiar5jRolXG6l35VdEvDnvhNwL7Ufh
   M/Yp0uCRKnZ1eG4btc2n+Jin0Kk0fObl/VHcVwNBn4HvFpY7andN3SDwp
   dz/KE4q8+DwnYCXXXctBXFTLWtqj2fOrF2GURFNCVamt74x9r70/2rRtb
   5paH0pMhXfvVH15QyXE/Mt7qvgMvsw4ggQUbnCg0bWUhio+dDtQ5g62QH
   pf0FSQz3Y8LkdtFWIycwECd4cFTK65Pmodyu2hrJMZNhwpN+euizTvstI
   TiN6k7x3FVbWMWysncl/9cYQblsmVvy9FbKLHSoaTj9BWDwgAbGg+on2x
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="199251183"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:54:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkolZz+VJnwwsiEe/xsnJ+boodyrf29XR8RS7oZbhP0lYJ/B+0Nt5TQBBhLzfSD0jw7nYJftnRa3VE/aMxnd1i50Nqz5AASPye/Orm0nufO5lDC6ugtkX2hdkcPUt4/5rKbmuHUuwigQTyQ8707881BmSkfwSad1LUWwWwePtdWd8MfQkwzoLOGaeMf0H0dCvH34OScb/tTlSLlfVNotq+dHyPrUKdNYvUxq7MCng6CPJ6ntj94Fi4D//B7AunffLpCvlJuCveT7g1Jgcia5MnIbPBdjW4RPWazEIH9uNv5EjcP/sAxbAMY/sSJJmb0+Lr/lvS8aEsCx+PhZxAdJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=Usiohj3VtY/juVTdgUQnCOU3EZQpSYzxqOo7csVKgc96EHQZyc8cWZ5AgDl2w2VYnKS0sR+/pGU4QnG9S9P59iPtxrRxZTQdFfE4sPPWyDivlC9pkrCs4CQ/mPQWCKbqcTzEGGoMLShOMNeaRgxBX+vkMD8rErFcSGOI9a+wqcSkbTqOXyUa7i1Mr5wkhPvi898sfLeqJ2ENSaXbbnfq4RVJlWkkTxAxLZFocQ3MdnhSjtXVdwdGxrDZ20VWHBRl37yOafdMdkGXaup5BdHu9yq5/hDmP4AbwXYfVGp+HMCy7JLTmhC8mzuuGX/D/nEWBZ79N/N7xl7+ynnaLGDSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=JOWr/R7AzIPv0mufc2FFn0xw6XGPmfuroH5wAbIZrT6lAvKLCqRLFMUvMDE/s2CXcNeNbPMGIXDJi+Wks1XZLkEkRfV5olVD36fO967fyd3p1y5muuwwU5tQXdDyIqeD7NsFEX8pH/9WBZ4IEUu92YdZXkKPH7hAQ2MDvLEXk5M=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:54:07 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:54:07 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 6/8] zonefs: Add active seq file accounting
Thread-Topic: [PATCH v2 6/8] zonefs: Add active seq file accounting
Thread-Index: AQHYVF//FNqABGXOG0ytLXYh/FR9D6z4oSgA
Date:   Wed, 20 Apr 2022 10:54:07 +0000
Message-ID: <20220420105406.GD36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-7-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b478263-53ad-4752-b2dd-08da22bc17df
x-ms-traffictypediagnostic: CH2PR04MB6694:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6694A0E325F1130354FCD9BBEBF59@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VubD7Ms5gAjfLN5bIxa3IyXXK4fl+05umEILWD6Op0JAjd4g5HR2/ePB0a9yBb0BWg1BwpxBm7jpXzH3ItRkgbISlXRFs3K6KJN/TzSlRVmSV927No5BhYTl7bnEzFFcQGPrE30U1EzKCNq56CNdL3cRmTSF4PluT0S2rYqWU+FLx3n1UnFIJ57yNc7Xkw8kE+Fc/U1Ws6CMf97Ac0d6xZYDSU89aPJQZ+GZKnHF66V6U2BlEFpQ6zCidNZVms/GRXHcditeenbDKFLaoqeaiNCj4znMv45jJeFzWF4H6fbMRLY9zYPgaWGMmjEXvyaeHEz9BbHi6H+TlfFZIh4CPTUKKBU9OmBL9TnN2DqyzIqh+Kx3dBHl/NhVfmKNcvg5Wn3FT5JIVTbK5CsQgzPiqhLXxe/vDct10aXkSdtp27dtSsRZRZ9nvnOedQ1zNticG+U0qGJapwwyJwUWnWpiPrPQ4O/5poO/kyecKkU7ODK8rQUODBr5d/OEXV8fMpodXv9MC+boSVVUwiYAHr4/UF3Z+mD67PEao1wxKKIBnFjSqHCpWZzJ05N9Xq5dSC62vndZcLL2hQwR0z5IpFlwo0SbqQMZ6Zc4Jw2V1oBA8K8Clg/tzWmm0666yhK0zbm6Ww6gVJv+owtyw/loKsIejUVYpmII+/igfcwYv9ndz3BSA+rZ14fNTIefkZli7n1bllXLCIMIUJL89vdyOA0NIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66446008)(64756008)(86362001)(71200400001)(6486002)(66556008)(91956017)(508600001)(4326008)(33716001)(6862004)(76116006)(122000001)(54906003)(6506007)(38100700002)(9686003)(6512007)(38070700005)(316002)(33656002)(1076003)(26005)(4270600006)(8676002)(66946007)(82960400001)(66476007)(8936002)(2906002)(558084003)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KDhLTORlnpxpZ7oMAVPpkrQJNBzF2IOrxjIQ/HCw60epnzD43ccljOVvcMde?=
 =?us-ascii?Q?rHVWPfK3gYwJ1ipz1YIPMa8HwObCqi/qJ6y+PZLLnBZFY1WrSENUikHIHaij?=
 =?us-ascii?Q?8rV8IBv5GlDRrERuwHj/w2f7EdVG2Ybeq+aBlMmiNznevoWtRr97Ab6nqiuJ?=
 =?us-ascii?Q?o8trnGq4GxYrtrJ1pcWMKDLsmRhzwjM+iUmRqHT9HnRPBmmaYvVyt5GcbTaW?=
 =?us-ascii?Q?/NKzHJB8ApPkoHMPWaJ3KYNe9U3kpl895mmZ8RA6U8KzGDlBJp+N3DmgdRIL?=
 =?us-ascii?Q?vggSf1wfCLE2QQ22CDEYV02FRs9h7l+CeGJHRV3Z8JjYrHSrSVNdMH7XkKAc?=
 =?us-ascii?Q?v5AFH/X+HyBwavGVT1FgYrLLzHmlx5SmlvQhVrOUhlKTRPS+8fgtEpct6wkG?=
 =?us-ascii?Q?r39xmgFurZM+EAjps0G9mBChc/nyAb8agcA/RZZBY5Ac+ERJOoaBbkB8vMpa?=
 =?us-ascii?Q?wzlIF2Ak/bAVze6lyeqgkABnE56s9KLM1egavqfSj6+nPYTeXmMqQtM/6VDL?=
 =?us-ascii?Q?esxpbiKR9aneIlu5bueCiyzS3qV1Mt+Hr1JcXFo0oH4Cjc0FB1vDw8KWX6KI?=
 =?us-ascii?Q?CX50h8656au27F23RIYBf7PZENSZJMr33/1Vyevy9/FFMqd7wqLrmr0gzySf?=
 =?us-ascii?Q?nFdd9X8J1vRTEbbjHbzE6PInnkZ+07reS/7FFKRD9/oL3YrzR3TwZzIGAkg6?=
 =?us-ascii?Q?6mGHpkGRi/g0RaGbPQeJA3R/29LKEeYOwXnBSPlMSwvPead/RKB3ObJ1q2dE?=
 =?us-ascii?Q?lI5ZhbzE8OCJdtvGzw97amoV6On230Rv8e8m0/iZY7zVoEibqPI2STWjY19t?=
 =?us-ascii?Q?cr48kG4YgFLg9BXdxcTOcAgNXN3MylpWcInZKBY/jiLGOAOzFR1SYQ/Y9ss+?=
 =?us-ascii?Q?nU56vUVYDFy11g2ofaQqDmH7B+6vIIPxIj3m5tNJo4ulKXKo+UXclP/67JMi?=
 =?us-ascii?Q?GQadlRWoJC+VYQ7MwdKxBB7R6l/6b43CuGkyMOCSllxcrt120O0hWgc3HPiK?=
 =?us-ascii?Q?9RcdHI5KND6qYNyHJ6kBjdAfL4n9xzD+ogf1ptjz4yPNEzVSPaXjgnJpeq/t?=
 =?us-ascii?Q?cQTGURtbKpgBGdfwVNWUMT5xbqDrosr7oZQ80uKPc7Juhv2kbOFYYrRrY9qR?=
 =?us-ascii?Q?1wJFVELS/x+AkxxWeia4M06PWt3DrFIxM8B7zXQLCqd1WAzHIrjWvyTDD4UA?=
 =?us-ascii?Q?mro6HaSNOtq9gyo2d1+qYhuYIeAzq1CWx0OETji8i6pYX7ZtO9K8o2HENdVc?=
 =?us-ascii?Q?HSHesV52Mj1TBulRF75dbLmnPtJZTwaAjQvD429XtbvgczWYU3l63hI21XSH?=
 =?us-ascii?Q?X1dfENRzNa7Ja3UqKPS9R6ELA43Ncw+15GzQ1VNL7+jyG7tSYMMElLui2dqm?=
 =?us-ascii?Q?2lCam4rHq/dfO3YpzkvUG07radB/I7S9VVQfHwHyC2KK4T6+pGV4Km6JWk4r?=
 =?us-ascii?Q?TC6M3+X947t8BKsOHvoLfIIqs9rcxkTksQ5/+k21BPu806r1zqeV0tAmA1n+?=
 =?us-ascii?Q?3Qx/LDO306s+WfQGxKj6noFODi+fHFdQQGZ6Ofou+ERpQIZQaWEPJQ2VSdLF?=
 =?us-ascii?Q?DF1EFh7ggDJtZPEnsphlEq2y6gjbfFVw8wr8DDlJIGATmFZySFEz89+ceufd?=
 =?us-ascii?Q?RaOqRGQmz0Sca4F0q+06Sc/hd8arEkd72K/t0KbPJe1xpzCWwpPjBI2xzkb/?=
 =?us-ascii?Q?I+vLjp1VktWDiBz2RXne1DMHcC8py/YVPZVPx9/ZUrwdh9i+FcIMZiPtSX/F?=
 =?us-ascii?Q?k1Ldb4dugrrGN7ptmi/0roToXEHNycU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B448B261A19F44C98991567426B156B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b478263-53ad-4752-b2dd-08da22bc17df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:54:07.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICrvCR2G3WvK7h5EAl5AYcr3apzEAnic6Cs55wQ9Rf1wn6T9R+7/P39zsn7xMSb0liYVS2SoFcLdATglbPnn6w==
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
