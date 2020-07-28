Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E88230ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgG1M5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:57:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1996 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbgG1M47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595941019; x=1627477019;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KTZ/78tTJB4nk4e9h9m+tuccslUbBbtxEa4TrtrOVCmT9kS2Xn22Yebq
   rgnGpKpvzs4avXCrY4AAPXMOUB/GPu+EjeZALovsY4FLRblAJSck/bUE9
   cZTyDMwyU7pmU252AA5Vo/Z26rVjuBWB2QutreCkgYJP4MKX8FDLiuqpm
   EzX+QZ+tvI5YFMmm5X+qHlt9oSWygE3vB12CRr1xs0mX4C1Y2CKVM5l8l
   UwuqGEkV1vUAaL0Yc/DnyAtn1Mc3ElXAX2wwl69fY/i+heBpoFk34bvhW
   6oja+7JvjjXubCH91mQZ0UnG1yGliXCw/FNcxVFok/M1TgxMusqc21JQL
   A==;
IronPort-SDR: gK9xZCKDX9cSM4byXScDmZ89AIssnpejUaPi+k69xl7uTaGVGRuWtlrRsA2Y58hikBHbXrsagE
 IplDxS5Gnly9HP56TS1zyI0mH+mqFCUfBS0UoTslii4MvUIQhTAbPYT3yAaQMza431a5zNO0iz
 t7nvU3tw9PKH0+0kYLhUmPHUHl/FpfHTx9OXryxKLfDPSAo3xgrk/GeQugyWw8iAwPyM5/0H7t
 aCDfNhNbnuZ7fruSQJd6BIAofyPivRpR81Xv05xAjL1ZR6p8+os7ORNLuE5D33cpBaZgyoCAM/
 qpc=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143652628"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:56:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNe0uYEAfjZFe8ci/fjjNmgDHjxwzExGY6Me4htTYSDMdY+WZO33qBarvzKgVJ6751Bb+2fsmC0xgmVyouFfTBb/ewE6BwZNnejXC8Cs3ZaCJIlXfq8OVWfqYc7NyIkXSQmC4YIMG5LJVbO4bpk8jWv3UBdj3zxgBidVvXZ63ZwUbXdcElnq5EoNikFv9hgVmTKIRrGwTmNvH2UnrJDZViJbQ4P8xL8vUrzyNvWbvQsCAAtRUO2gOcocCXdAKLVZ3JfEilf5vbLm5eLYoAnTSh7T0kI6DPCyHtwuxlgHvlYshOGtBGaF8Oikq4rJ5CNepiA7z22zIKU36TheJmHojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cqh838taFrKnLvOEdJCfld/mUUnaUCjMrdZYX/fyRcL+g6qkuJyNdA+hGN6pGKQhnrCT3qXh9//EOwB9CB7uS3aZoNLvWi+tLZfoar+9IgVk1gpPIJPdCYOT3mZsv3DkU/jtzBbSrxpCPI53foH83mFJb7UVWvAS5wwqQ2U/xmdZi5Gj8mBXnVrXoafehgrPeuveDFoT8dgYuVhYvzbas9ukDaop4LW15zW8RlEqdXPSDHMIIPTOpz1Sdix1wqAGqP9C0tX02HxKgCBaPMa2dhyQ0HbLqU9rJIvf3gOJEQ6YBW8O4Q9LhgwYPJvudF0fYoG+kjIUaGxHM2IoKOYovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b29uChG3UOwrtDjEDcjFavxk+dwl8A8gscJ9dPp03CT6NSWQJaVuVi8ZkAaGRxyj6J6xefKnmjxAN3pgPNKqhdrVSFwsckAk6HlKii5XB94StBPUGFIldf6tJAT06Ct5teHgFtT/jXlLeA4ZvYM7kytZCpzqdAi0nfRVvzvJq0s=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5322.namprd04.prod.outlook.com (2603:10b6:5:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 12:56:57 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:56:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 14/14] bdi: replace BDI_CAP_NO_{WRITEBACK,ACCT_DIRTY} with
 a single flag
Thread-Topic: [PATCH 14/14] bdi: replace BDI_CAP_NO_{WRITEBACK,ACCT_DIRTY}
 with a single flag
Thread-Index: AQHWYYzlqorm63WWfE+oLNIUKsplxQ==
Date:   Tue, 28 Jul 2020 12:56:57 +0000
Message-ID: <DM5PR0401MB3591373D85A471CF9541D1E49B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 256ec321-6aa9-4cf0-97c2-08d832f5b5dc
x-ms-traffictypediagnostic: DM6PR04MB5322:
x-microsoft-antispam-prvs: <DM6PR04MB5322089578D056EB25991E949B730@DM6PR04MB5322.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FbYENchCtaITF7m6RyQbIeSeYE8S5uRLhSBUwrGKWMDyYndXIa8DkqeTo4ZUphOpX0bWNxjaUcHvsedufES3GUtZjMp/EHQOUgLlT1gGYUv7j6sSa4dngXlVaMOw9vJGPqEFYNUDi2otNQF8Iy1ACe845Wo0c5OEEAU+qtviNJ8sUqEEbXxBRZAnVFYBZCcCFQZ6CuPeavMN7ag3aH930fsmd19aRUMcvMGz4n494U4JKp0hWFANLMkDEX8QUc1gePJgfw41ZBSSx9Hhc1JCXbjvdzgNu/k2fYrH1EeZHqmzXjT41Py6i51XNOqzGxV/feCFoaCVQIFhyBdFrmefCZ0ad43UdNua9m6BSg5OnT2CN+kfkSmWjq1I2Z4LJqWeli1+h3zkVhQlh06rPOAuww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(8676002)(66556008)(66476007)(66946007)(66446008)(19618925003)(9686003)(7696005)(186003)(26005)(64756008)(86362001)(478600001)(55016002)(6506007)(8936002)(52536014)(7416002)(71200400001)(110136005)(558084003)(4270600006)(33656002)(4326008)(76116006)(91956017)(316002)(2906002)(54906003)(142933001)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G4IJjpzbqsijbA6RQMTP9G+lqgirCTZ4/7zN8ekC6hb1LAROoioXlWe2Ml+OzEayAoSW6N9JJBCaGQPnOyWOpT4Q+64JLk+cQo4mIJUgMYm6ucuiiyiHzZl3LlUC57w/qmQdqGaLfaz++dA7DWD2zzlBFKCCbWohZ4SEBqK/NA93P5uosS8Prs3ezBefgffUbovR6Ebzs+qQLctj5hIEJNawz963UPWv4AGqxdASCR89Rl6k9745uo55/BZWGXR3RuEMQrZO4msfd812hPxtEKfCjR3voXB+NcrTyt/aoAL2bp0NJu2lvQozgOJgvcySJw6WLedmyd5w4Fdp+Qel6dsIdXQYyl+5Q9nyf27iq0tpdfzbPFEPXCm077MHG7iVJ2eEK9EYaRwXkLv78uhyyz+vLq7/xqrkxJRf66K4RLceQQJVoq5PhmO8VSNoMmy4tfOwniOy5IKtBV9x9MsnfVL73rvt1ddUSdeDh2iZbZ6QAi0XPePZugix9z8dNB4M
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256ec321-6aa9-4cf0-97c2-08d832f5b5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:56:57.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aWssUk/6kJwWtFLU9UAlgqdEYYzTZfaqM083iPKdojGMLd2Tux0XHazJqGzL4eGXFQOIVWtTURDagP+ojdZu/490s1Xsh0HV1OI0y7ac3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5322
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
